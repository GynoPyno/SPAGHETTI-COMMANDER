"""Scanner del catalogo: trova tutti i campi Audio.* nei blueprint vanilla estratti.

Non usa un parser Lua completo (non serve: il formato dei .bp è generato da GPG ed è
regolare). Usa un tracker di profondità delle graffe per isolare ogni blocco `Audio = { ... }`
(anche quelli annidati dentro le armi) e una regex per le righe `Campo = Sound { ... }` al
suo interno. I blocchi che non si riescono a interpretare vengono segnalati e saltati,
non bloccano lo scan.

Vedi il piano in Audiedit (fase F1) e Audiowo/METODOLOGIA_AUDIO.md per il contesto.
"""
from __future__ import annotations

import json
import re
from dataclasses import dataclass, asdict
from pathlib import Path

from . import config
from .pattern_rules import classify

FIELD_RE = re.compile(r"(?P<field>\w+)\s*=\s*Sound\s*\{(?P<body>[^{}]*)\}")
BANK_RE = re.compile(r"Bank\s*=\s*'([^']*)'")
CUE_RE = re.compile(r"Cue\s*=\s*'([^']*)'")
LODCUTOFF_RE = re.compile(r"LodCutoff\s*=\s*'([^']*)'")
AUDIO_BLOCK_RE = re.compile(r"\bAudio\s*=\s*\{")
BLUEPRINT_ID_RE = re.compile(r'BlueprintId\s*=\s*"([^"]*)"')
DISPLAY_NAME_RE = re.compile(r'DisplayName\s*=\s*"([^"]*)"')
LABEL_RE = re.compile(r'Label\s*=\s*"([^"]*)"')


@dataclass
class CatalogEntry:
    key: str                # identificatore univoco, usato per assegnazioni/stato
    source: str              # "unit" | "projectile"
    directory_id: str        # nome cartella (es. "UEL0001") -> usato per i percorsi hook
    blueprint_id: str | None  # BlueprintId letto dal file (es. "uel0001"), se presente
    display_name: str | None
    context: str              # "top" oppure "weapon:<Label>"
    field: str                # es. "Killed", "Fire", "ImpactTerrain"
    bank: str
    cue: str
    lodcutoff: str | None
    pattern: str               # "A" | "B"
    file: str                  # percorso assoluto del .bp sorgente


class ScanIssue(Exception):
    """Segnala un blocco non interpretabile; catturata e loggata dallo scanner, non fatale."""


def _matching_close(text: str, open_pos: int) -> int:
    depth = 0
    i = open_pos
    n = len(text)
    while i < n:
        c = text[i]
        if c == "{":
            depth += 1
        elif c == "}":
            depth -= 1
            if depth == 0:
                return i
        i += 1
    raise ScanIssue(f"graffa non bilanciata a partire da {open_pos}")


def _enclosing_block_start(text: str, pos: int) -> int | None:
    """Posizione della '{' del blocco che contiene `pos`, scandendo all'indietro."""
    depth = 0
    i = pos - 1
    while i >= 0:
        c = text[i]
        if c == "}":
            depth += 1
        elif c == "{":
            if depth == 0:
                return i
            depth -= 1
        i -= 1
    return None


def _context_of(text: str, audio_open_pos: int) -> str:
    outer_start = _enclosing_block_start(text, audio_open_pos)
    if outer_start is None:
        return "top"
    try:
        outer_end = _matching_close(text, outer_start)
    except ScanIssue:
        return "top"
    label_match = LABEL_RE.search(text, outer_start, outer_end)
    if label_match:
        return f"weapon:{label_match.group(1)}"
    return "top"


def _scan_file(path: Path, source: str, issues: list[str]) -> list[CatalogEntry]:
    text = path.read_text(encoding="utf-8", errors="replace")
    directory_id = path.parent.name
    blueprint_match = BLUEPRINT_ID_RE.search(text)
    blueprint_id = blueprint_match.group(1) if blueprint_match else None
    display_match = DISPLAY_NAME_RE.search(text)
    display_name = display_match.group(1) if display_match else None

    entries: list[CatalogEntry] = []
    for audio_match in AUDIO_BLOCK_RE.finditer(text):
        open_pos = audio_match.end() - 1
        try:
            close_pos = _matching_close(text, open_pos)
        except ScanIssue as exc:
            issues.append(f"{path}: {exc}")
            continue
        block_text = text[open_pos + 1:close_pos]
        context = _context_of(text, open_pos)
        for field_match in FIELD_RE.finditer(block_text):
            field = field_match.group("field")
            body = field_match.group("body")
            bank_match = BANK_RE.search(body)
            cue_match = CUE_RE.search(body)
            if not (bank_match and cue_match):
                issues.append(
                    f"{path}: campo '{field}' in {context} senza Bank/Cue riconoscibili"
                )
                continue
            lod_match = LODCUTOFF_RE.search(body)
            entries.append(CatalogEntry(
                key=f"{directory_id}|{context}|{field}",
                source=source,
                directory_id=directory_id,
                blueprint_id=blueprint_id,
                display_name=display_name,
                context=context,
                field=field,
                bank=bank_match.group(1),
                cue=cue_match.group(1),
                lodcutoff=lod_match.group(1) if lod_match else None,
                pattern=classify(field),
                file=str(path),
            ))
    return entries


def scan(*, issues: list[str] | None = None) -> list[CatalogEntry]:
    """Scansiona units_nx2_extracted e projectiles_nx2_extracted e ritorna il catalogo completo."""
    own_issues: list[str] = issues if issues is not None else []
    entries: list[CatalogEntry] = []

    for root, source in (
        (config.UNITS_EXTRACTED_DIR, "unit"),
        (config.PROJECTILES_EXTRACTED_DIR, "projectile"),
    ):
        if not root.exists():
            own_issues.append(f"cartella non trovata, saltata: {root}")
            continue
        for bp_path in sorted(root.rglob("*.bp")):
            entries.extend(_scan_file(bp_path, source, own_issues))

    return entries


def save(entries: list[CatalogEntry], path: Path = config.CATALOG_JSON) -> None:
    config.ensure_data_dir()
    path.write_text(
        json.dumps([asdict(e) for e in entries], ensure_ascii=False, indent=2),
        encoding="utf-8",
    )


def load(path: Path = config.CATALOG_JSON) -> list[CatalogEntry]:
    data = json.loads(path.read_text(encoding="utf-8"))
    return [CatalogEntry(**d) for d in data]


def _print_summary(entries: list[CatalogEntry], issues: list[str]) -> None:
    from collections import Counter

    print(f"Voci trovate: {len(entries)}")
    by_field = Counter(e.field for e in entries)
    print("Top 10 campi per frequenza:")
    for field, count in by_field.most_common(10):
        print(f"  {field:<20} {count}")
    pattern_b = [e for e in entries if e.pattern == "B"]
    print(f"Pattern B rilevati: {len(pattern_b)}")
    for e in pattern_b:
        print(f"  {e.directory_id} / {e.context} / {e.field}")
    if issues:
        print(f"\nAvvisi di scan ({len(issues)}), prime 20:")
        for msg in issues[:20]:
            print(f"  ! {msg}")


if __name__ == "__main__":
    scan_issues: list[str] = []
    result = scan(issues=scan_issues)
    save(result)
    _print_summary(result, scan_issues)
    print(f"\nSalvato in {config.CATALOG_JSON}")
