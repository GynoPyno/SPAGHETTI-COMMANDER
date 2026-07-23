"""Allineamento RPC generalizzato a più eventi (vedi il piano approvato, sezione 4).

Il codice RPC che XactBld scrive nel .xsb è l'offset della curva dentro il .xgs che genera
lui stesso — scoperta e validata in game il 2026-07-23 (vedi Audiowo/METODOLOGIA_AUDIO.md).
Per ottenere un codice-target noto (una curva vanilla di SupCom.xgs, es. 1050 = attenuazione
graduale degli impatti) basta gonfiare `Global Settings` con elementi fittizi finché quel
offset coincide: a quel punto è XactBld stesso a scrivere il valore giusto, con checksum
valido, senza patch binarie (evoluzione di prototipi/align2.py).

Per più eventi con profili diversi si genera una curva reale dedicata per ciascun codice-
target distinto (eventi con lo stesso profilo condividono la stessa curva), ordinate per
offset crescente, con il padding necessario calcolato prima di ciascuna. Il ricalcolo è
sempre totale: non c'è stato incrementale da trascinare tra una build e l'altra.
"""
from __future__ import annotations

import struct
from dataclasses import dataclass
from pathlib import Path

from . import xactbld
from .state import EventConfig
from .xact_binary import XactFormatError, find_sound_offset

_VAR_TEMPLATE = """
    Variable
    {{
        Name = {name};
        Public = 1;
        Global = 0;
        Internal = 0;
        External = 0;
        Monitored = 1;
        Reserved = {reserved};
        Read Only = 0;
        Time = 0;
        Value = 0.000000;
        Initial Value = 0.000000;
        Min = 0.000000;
        Max = 1000000.000000;
    }}
"""

_CATEGORY_TEMPLATE = """
    Category
    {{
        Name = {name};
        Public = 1;
        Background Music = 0;
        Volume = 0;

        Category Entry
        {{
            Name = Global;
        }}

        Instance Limit
        {{
            Max Instances = 255;
            Behavior = 0;

            Crossfade
            {{
                Fade In = 0;
                Fade Out = 0;
                Crossfade Type = 0;
            }}
        }}
    }}
"""

_RPC_TEMPLATE = """
    RPC
    {{
        Name = {name};

        RPC Curve
        {{
            Name = {name}Curve;
            Property = 0;
            Sound = 1;
            Line Color = 4278255360;
            Viewable = 1;

            Variable Entry
            {{
                Name = Distance;
            }}

            RPC Point
            {{
                X = 0.000000;
                Y = 0.000000;
                Curve = 0;
            }}

            RPC Point
            {{
                X = 10000.000000;
                Y = -9600.000000;
                Curve = 0;
            }}
        }}
    }}
"""

_RPC_ENTRY_TEMPLATE = """        RPC Entry
        {{
            RPC Name = {name};
        }}
"""


class AlignmentError(Exception):
    """L'allineamento RPC non è riuscito (compilazione fallita o target irraggiungibile)."""


@dataclass
class AlignResult:
    success: bool
    log: str
    xap_text: str


def _distance_variable_block() -> str:
    return _VAR_TEMPLATE.format(name="Distance", reserved=1)


def _insert_global_settings_padding(base_xap: str, padding_blocks: str) -> str:
    marker = "\nWave Bank\n{"
    i = base_xap.index(marker)
    close = base_xap.rindex("}", 0, i)
    return base_xap[:close] + padding_blocks + base_xap[close:]


def _attach_rpc_entry(text: str, cue: str, rpc_name: str) -> str:
    """Inserisce un RPC Entry nel blocco Sound della `cue` data (non nel Wave/Cue omonimo:
    si ancora al primo 'Name = <cue>;' dopo l'inizio del Sound Bank, che è sempre il Sound
    stesso perché lo renderizziamo prima dei Cue — vedi xap_project.py)."""
    sb = text.index("\nSound Bank\n{")
    name_pos = text.index(f"Name = {cue};", sb)
    cat_entry_pos = text.index("Category Entry", name_pos)
    default_pos = text.index("Name = Default;", cat_entry_pos)
    close = text.index("}", default_pos) + 1
    entry = _RPC_ENTRY_TEMPLATE.format(name=rpc_name)
    return text[:close] + "\n" + entry + text[close:]


def _write_and_compile(build_dir: Path, xap_name: str, text: str) -> tuple[bool, str]:
    xap_path = build_dir / xap_name
    xap_path.write_text(text, encoding="utf-8")
    result = xactbld.compile_xap(xap_path)
    return result.success, result.stdout + result.stderr


def _read_rpc_code(xsb_path: Path, cue: str) -> int | None:
    """Codice RPC del Sound di `cue` (assume un solo RPC Entry, nessun blocco DSP — vero
    per come renderizziamo i Sound in xap_project.py). None se il Sound non ha RPC."""
    d = xsb_path.read_bytes()
    try:
        so = find_sound_offset(d, cue)
    except XactFormatError:
        return None
    if not (d[so] & 0x02):
        return None
    return struct.unpack_from("<I", d, so + 10 + 3)[0]


def _solve_padding(need: int, dv: int, dc: int, dr: int) -> tuple[int, int, int] | None:
    """Combinazione (variabili, categorie, curve fittizie) i cui byte sommano a `need`."""
    if need < 0:
        return None
    if need == 0:
        return (0, 0, 0)
    max_a = need // dv + 2 if dv else 0
    max_b = need // dc + 2 if dc else 0
    for a in range(0, max_a + 1):
        for b in range(0, max_b + 1):
            rest = need - a * dv - b * dc
            if rest < 0:
                continue
            if dr and rest % dr == 0:
                return (a, b, rest // dr)
            if rest == 0 and not dr:
                return (a, b, 0)
    return None


def _measure_grane(
    base_xap_text: str, build_dir: Path, xap_name: str, probe_cue: str
) -> tuple[int, int, int, int]:
    """Misura (c0, delta_variabile, delta_categoria, delta_curva) compilando 4 varianti
    minime. Mai hardcodate: XactBld potrebbe cambiare dimensione tra progetti diversi.
    """

    def build_variant(nvar: int = 0, ncat: int = 0, ncurve: int = 0) -> str:
        blocks = ""
        for k in range(ncat):
            blocks += _CATEGORY_TEMPLATE.format(name=f"PadCat{k:03d}")
        blocks += _distance_variable_block()
        for k in range(nvar):
            blocks += _VAR_TEMPLATE.format(name=f"PadVar{k:03d}", reserved=0)
        for k in range(ncurve):
            blocks += _RPC_TEMPLATE.format(name=f"PadRpc{k:03d}")
        blocks += _RPC_TEMPLATE.format(name="ProbeCurve")
        text = _insert_global_settings_padding(base_xap_text, blocks)
        return _attach_rpc_entry(text, probe_cue, "ProbeCurve")

    def code_of(**kwargs) -> int:
        text = build_variant(**kwargs)
        ok, log = _write_and_compile(build_dir, xap_name, text)
        if not ok:
            raise AlignmentError(f"compilazione di misura fallita:\n{log}")
        xsb_path = build_dir / xap_name.replace(".xap", ".xsb")
        code = _read_rpc_code(xsb_path, probe_cue)
        if code is None:
            raise AlignmentError("il sound-sonda non ha un codice RPC dopo la compilazione")
        return code

    c0 = code_of()
    cv = code_of(nvar=1)
    cc = code_of(ncat=1)
    cr = code_of(ncurve=1)
    return c0, cv - c0, cc - c0, cr - c0


def align_and_build(
    events: list[EventConfig], base_xap_text: str, build_dir: Path, xap_name: str = "Audiowo.xap"
) -> AlignResult:
    """Prende il .xap "senza attenuazione" prodotto da xap_project.render_base(), aggiunge
    (se serve) il padding e le curve RPC reali per tutti gli eventi con attenuation_curve
    impostato, compila e verifica. Se nessun evento ha attenuazione, compila il testo così
    com'è: nessun allineamento necessario.
    """
    attenuated = [e for e in events if e.attenuation_curve is not None]
    if not attenuated:
        ok, log = _write_and_compile(build_dir, xap_name, base_xap_text)
        return AlignResult(success=ok, log=log, xap_text=base_xap_text)

    probe_cue = events[0].cue
    c0, dv, dc, dr = _measure_grane(base_xap_text, build_dir, xap_name, probe_cue)

    targets: dict[int, list[str]] = {}
    for e in attenuated:
        targets.setdefault(e.attenuation_curve, []).append(e.cue)
    sorted_codes = sorted(targets)

    padding_blocks = ""
    cur_offset = c0
    curve_name_by_code: dict[int, str] = {}
    for code in sorted_codes:
        need = code - cur_offset
        sol = _solve_padding(need, dv, dc, dr)
        if sol is None:
            raise AlignmentError(
                f"non trovo una combinazione di padding per il profilo con codice {code} "
                f"(servono {need} byte da {cur_offset}, grane variabile={dv} categoria={dc} "
                f"curva={dr}) — è probabilmente troppo vicino al profilo precedente, "
                "scegliere un profilo diverso per uno dei due eventi"
            )
        n_var, n_cat, n_curve = sol
        for k in range(n_cat):
            padding_blocks += _CATEGORY_TEMPLATE.format(name=f"Pad{code}Cat{k:03d}")
        for k in range(n_var):
            padding_blocks += _VAR_TEMPLATE.format(name=f"Pad{code}Var{k:03d}", reserved=0)
        for k in range(n_curve):
            padding_blocks += _RPC_TEMPLATE.format(name=f"Pad{code}Rpc{k:03d}")
        curve_name = f"Curve{code}"
        padding_blocks += _RPC_TEMPLATE.format(name=curve_name)
        curve_name_by_code[code] = curve_name
        cur_offset = code + 23  # la curva reale occupa le stesse 23 byte del padding

    padding_blocks = _distance_variable_block() + padding_blocks
    text = _insert_global_settings_padding(base_xap_text, padding_blocks)
    for code, cues in targets.items():
        for cue in cues:
            text = _attach_rpc_entry(text, cue, curve_name_by_code[code])

    ok, log = _write_and_compile(build_dir, xap_name, text)
    if not ok:
        return AlignResult(success=False, log=log, xap_text=text)

    xsb_path = build_dir / xap_name.replace(".xap", ".xsb")
    for code, cues in targets.items():
        for cue in cues:
            got = _read_rpc_code(xsb_path, cue)
            if got != code:
                return AlignResult(
                    success=False,
                    log=f"verifica fallita per '{cue}': atteso codice {code}, ottenuto {got}",
                    xap_text=text,
                )
    return AlignResult(success=True, log=log, xap_text=text)
