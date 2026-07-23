"""Genera i file di hook (Pattern A: blueprint; Pattern B: hook/lua/UserSync.lua) dallo
stato corrente. Una volta adottato l'editor questi file sono interamente gestiti dal tool:
non vanno più editati a mano (vedi il piano approvato, sezione 5, e
Audiowo/METODOLOGIA_AUDIO.md per la spiegazione dei due pattern).
"""
from __future__ import annotations

from pathlib import Path

from . import config, xap_project
from .state import EventConfig

_UNIT_BP_TEMPLATE = """UnitBlueprint {{
Merge = true,
BlueprintId = "{blueprint_id}",
    Audio = {{
{fields}    }},
}}
"""

_PROJECTILE_BP_TEMPLATE = """ProjectileBlueprint {{
Merge = true,
    Audio = {{
{fields}    }},
}}
"""

_FIELD_TEMPLATE = """        {field} = Sound {{
            Bank = '{bank}',
            Cue = '{cue}',
{lodcutoff}        }},
"""

_USER_SYNC_HEADER = """local OldOnSync = OnSync

OnSync = function()
    if Sync.Voice then
        local filtered = {}
"""

_USER_SYNC_FOOTER = """    end
    return OldOnSync()
end
"""


def _group_pattern_a_targets(
    events: list[EventConfig],
) -> dict[tuple[str, str], list[tuple[str, EventConfig]]]:
    groups: dict[tuple[str, str], list[tuple[str, EventConfig]]] = {}
    for event in events:
        if event.pattern != "A":
            continue
        for target in event.targets:
            key = (target.kind, target.directory_id)
            groups.setdefault(key, []).append((target.field, event))
    return groups


def _render_sound_field(field: str, event: EventConfig) -> str:
    lod = f"            LodCutoff = '{event.lodcutoff}',\n" if event.lodcutoff else ""
    return _FIELD_TEMPLATE.format(
        field=field, bank=xap_project.BANK_NAME, cue=event.cue, lodcutoff=lod
    )


def generate_pattern_a_hooks(events: list[EventConfig]) -> dict[Path, str]:
    """{percorso_file: contenuto} per ogni blueprint da sovrascrivere (Merge=true). Più
    eventi sullo stesso blueprint confluiscono nello stesso file/blocco Audio."""
    files: dict[Path, str] = {}
    for (kind, directory_id), field_events in _group_pattern_a_targets(events).items():
        fields_text = "".join(_render_sound_field(field, ev) for field, ev in field_events)
        if kind == "unit":
            path = config.MOD_HOOK_UNITS_DIR / directory_id / f"{directory_id}_unit.bp"
            content = _UNIT_BP_TEMPLATE.format(blueprint_id=directory_id.lower(), fields=fields_text)
        elif kind == "projectile":
            path = config.MOD_HOOK_PROJECTILES_DIR / directory_id / f"{directory_id}_proj.bp"
            content = _PROJECTILE_BP_TEMPLATE.format(fields=fields_text)
        else:
            raise ValueError(f"tipo di target sconosciuto: {kind}")
        files[path] = content
    return files


def generate_user_sync_lua(events: list[EventConfig]) -> str | None:
    """Contenuto di hook/lua/UserSync.lua per tutti gli eventi Pattern B, oppure None se
    non ce n'è nessuno (in tal caso il file va rimosso, non lasciato vuoto/vecchio)."""
    pattern_b = [e for e in events if e.pattern == "B"]
    if not pattern_b:
        return None

    lines = [_USER_SYNC_HEADER]
    for event in pattern_b:
        lines.append(f"        local play_{event.cue} = false\n")
    lines.append("        for k, v in Sync.Voice do\n")
    for i, event in enumerate(pattern_b):
        kw = "if" if i == 0 else "elseif"
        lines.append(
            f"            {kw} v.Bank == '{event.vo_bank}' and v.Cue == '{event.vo_cue}' then\n"
            f"                play_{event.cue} = true\n"
        )
    lines.append("            else\n                table.insert(filtered, v)\n            end\n")
    lines.append("        end\n        Sync.Voice = filtered\n")
    for event in pattern_b:
        lines.append(
            f"        if play_{event.cue} then\n"
            f"            PlaySound(Sound {{\n"
            f"                Bank = '{xap_project.BANK_NAME}',\n"
            f"                Cue = '{event.cue}',\n"
            f"            }})\n"
            f"        end\n"
        )
    lines.append(_USER_SYNC_FOOTER)
    return "".join(lines)


def write_all(events: list[EventConfig]) -> list[Path]:
    """Scrive su disco tutti gli hook Pattern A e il Pattern B (se presente), rimuovendo
    UserSync.lua se non serve più nessuna sostituzione VO. Ritorna i percorsi scritti."""
    written: list[Path] = []
    for path, content in generate_pattern_a_hooks(events).items():
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(content, encoding="utf-8")
        written.append(path)

    user_sync = generate_user_sync_lua(events)
    if user_sync is None:
        if config.USER_SYNC_LUA.exists():
            config.USER_SYNC_LUA.unlink()
    else:
        config.USER_SYNC_LUA.parent.mkdir(parents=True, exist_ok=True)
        config.USER_SYNC_LUA.write_text(user_sync, encoding="utf-8")
        written.append(config.USER_SYNC_LUA)
    return written


if __name__ == "__main__":
    from . import state

    current_events = state.load()
    before = {
        p: p.read_text(encoding="utf-8")
        for p in list(config.MOD_HOOK_UNITS_DIR.rglob("*.bp"))
        + list(config.MOD_HOOK_PROJECTILES_DIR.rglob("*.bp"))
        + ([config.USER_SYNC_LUA] if config.USER_SYNC_LUA.exists() else [])
    }
    written_paths = write_all(current_events)
    print(f"Scritti {len(written_paths)} file:")
    for p in written_paths:
        changed = before.get(p) != p.read_text(encoding="utf-8")
        marker = "MODIFICATO" if p in before and changed else ("nuovo" if p not in before else "invariato")
        print(f"  {p}  [{marker}]")
