"""Genera il testo del progetto XACT (Audiowo.xap) dallo stato corrente (state.EventConfig).

Sostituisce l'editing a mano fatto finora: il .xap torna a essere un artefatto di build,
rigenerato per intero a ogni "Applica e ricompila". Le sezioni Wave Bank/Sound Bank/Cue sono
prodotte qui; l'eventuale attenuazione (Global Settings + RPC Entry) è aggiunta in un secondo
passaggio da rpc_align.py, che ha bisogno di ricompilare più volte per allineare gli offset.

Il formato è quello validato a mano su 4 eventi (vedi Audiedit/prototipi/
Audiowo.xap.esempio-rpc-allineato) — i template sotto ne ricalcano esattamente la sintassi.
"""
from __future__ import annotations

from .state import EventConfig

BANK_NAME = "Audiowo"

_HEADER = f"""Signature = XACT2;
Version = 16;
Content Version = 43;
Release = August 2007;

Options
{{
    Verbose Report = 0;
    Generate C/C++ Headers = 0;
}}

Global Settings
{{
    Xbox File = Xbox\\{BANK_NAME}.xgs;
    Windows File = {BANK_NAME}.xgs;
    Header File = {BANK_NAME}.h;
    Exclude Category Names = 0;
    Exclude Variable Names = 0;

    Category
    {{
        Name = Global;
        Public = 1;
        Background Music = 0;
        Volume = 0;

        Category Entry
        {{
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

    Category
    {{
        Name = Default;
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
}}
"""

_WAVE_BANK_OPEN = f"""
Wave Bank
{{
    Name = {BANK_NAME};
    Xbox File = Xbox\\{BANK_NAME}.xwb;
    Windows File = {BANK_NAME}.xwb;
    Windows Bank Path Edited = 1;
    Seek Tables = 1;
    Compression Preset Name = <none>;
"""

_WAVE_ENTRY = """
    Wave
    {{
        Name = {name};
        File = {filename};
    }}
"""

_SOUND_BANK_OPEN = f"""
Sound Bank
{{
    Name = {BANK_NAME};
    Xbox File = Xbox\\{BANK_NAME}.xsb;
    Windows File = {BANK_NAME}.xsb;
    Windows Bank Path Edited = 1;
"""

_SOUND_OPEN = """
    Sound
    {{
        Name = {cue};
        Volume = {volume};
        Pitch = 0;
        Priority = 0;

        Category Entry
        {{
            Name = Default;
        }}
"""

_SOUND_TRACK_OPEN = """
        Track
        {
            Volume = 0;

            Play Wave Event
            {
                Break Loop = 0;
                Use Speaker Position = 0;
                Use Center Speaker = 1;
                New Speaker Position On Loop = 1;
                Speaker Position Angle = 0.000000;
                Speaer Position Arc = 0.000000;

                Event Header
                {
                    Timestamp = 0;
                    Relative = 0;
                    Random Recurrence = 0;
                    Random Offset = 0;
                }

                Pitch Variation
                {
                    Min = 0;
                    Max = 0;
                    Operator = 0;
                    New Variation On Loop = 0;
                }
"""

_WAVE_ENTRY_REF = """
                Wave Entry
                {{
                    Bank Name = {bank_name};
                    Bank Index = 0;
                    Entry Name = {name};
                    Entry Index = {index};
                    Weight = {weight};
                    Weight Min = 0;
                }}
"""

_SOUND_TRACK_CLOSE = """
            }
        }
    }
"""

_CUE = """
    Cue
    {{
        Name = {cue};

        Variation
        {{
            Variation Type = 3;
            Variation Table Type = 1;
            New Variation on Loop = 0;
        }}

        Sound Entry
        {{
            Name = {cue};
            Index = {index};
            Weight Min = 0;
            Weight Max = 255;
        }}
    }}
"""


def _wave_name(cue: str, variant_index: int, total_variants: int) -> str:
    return cue if total_variants == 1 else f"{cue}_{variant_index}"


def render_base(events: list[EventConfig]) -> str:
    """Genera il .xap completo senza alcuna attenuazione (nessun Variable/RPC in Global
    Settings, nessun RPC Entry sui Sound). Se nessun evento richiede attenuazione questo
    testo è già il progetto finale; altrimenti rpc_align.align_and_build() lo completa.
    """
    wave_blocks: list[str] = []
    wave_index_by_name: dict[str, int] = {}
    next_wave_index = 0

    for event in events:
        for i, pool_file in enumerate(event.pool):
            name = _wave_name(event.cue, i, len(event.pool))
            wave_blocks.append(_WAVE_ENTRY.format(name=name, filename=f"{name}.wav"))
            wave_index_by_name[name] = next_wave_index
            next_wave_index += 1

    sound_blocks: list[str] = []
    for event in events:
        parts = [_SOUND_OPEN.format(cue=event.cue, volume=event.volume_db)]
        parts.append(_SOUND_TRACK_OPEN)
        for i, pool_file in enumerate(event.pool):
            name = _wave_name(event.cue, i, len(event.pool))
            parts.append(_WAVE_ENTRY_REF.format(
                bank_name=BANK_NAME, name=name, index=wave_index_by_name[name], weight=pool_file.weight,
            ))
        parts.append(_SOUND_TRACK_CLOSE)
        sound_blocks.append("".join(parts))

    cue_blocks = [
        _CUE.format(cue=event.cue, index=i) for i, event in enumerate(events)
    ]

    return "".join([
        _HEADER,
        _WAVE_BANK_OPEN, *wave_blocks, "}\n",
        _SOUND_BANK_OPEN, *sound_blocks, *cue_blocks, "}\n",
    ])
