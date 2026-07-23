"""Stato corrente della mod Audiowo: quali eventi sono attivi e come sono configurati.

È la "fonte di verità" da cui xap_project.py genera il progetto XACT e hooks.py genera i
file di hook — sostituisce l'editing a mano fatto finora. Salvato in config.STATE_JSON.
"""
from __future__ import annotations

import json
from dataclasses import dataclass, field, asdict
from pathlib import Path

from . import config


@dataclass
class PoolFile:
    """Una variante audio per un evento. path relativo a config.POOL_DIR (es. 'attivi/kaboom.mp3')."""
    path: str
    weight: int = 255


@dataclass
class HookTarget:
    kind: str          # "unit" | "projectile"
    directory_id: str  # nome cartella hook, es. "UEL0001", "TIFHETacticalNuclearShell01"
    field: str          # nome campo Audio.*, es. "Killed", "ImpactTerrain"


@dataclass
class EventConfig:
    cue: str                          # nome cue nel banco Audiowo, univoco
    pattern: str                       # "A" | "B" — vedi pattern_rules.py
    label: str = ""                     # etichetta leggibile per la GUI
    targets: list[HookTarget] = field(default_factory=list)   # Pattern A: blueprint da sovrascrivere
    vo_bank: str | None = None           # Pattern B: Bank vanilla da intercettare in UserSync.lua
    vo_cue: str | None = None            # Pattern B: Cue vanilla da intercettare
    pool: list[PoolFile] = field(default_factory=list)
    volume_db: int = 0                    # centesimi di dB, Sound.Volume nel .xap
    attenuation_curve: int | None = None   # codice curva vanilla target (es. 1050), None = nessuna
    lodcutoff: str | None = None
    mono: bool = False
    catalog_key: str | None = None          # voce di catalogo d'origine, se creato da lì


def _event_from_dict(d: dict) -> EventConfig:
    d = dict(d)
    d["targets"] = [HookTarget(**t) for t in d.get("targets", [])]
    d["pool"] = [PoolFile(**p) for p in d.get("pool", [])]
    return EventConfig(**d)


def load(path: Path = config.STATE_JSON) -> list[EventConfig]:
    if not path.exists():
        return []
    data = json.loads(path.read_text(encoding="utf-8"))
    return [_event_from_dict(d) for d in data]


def save(events: list[EventConfig], path: Path = config.STATE_JSON) -> None:
    config.ensure_data_dir()
    path.write_text(
        json.dumps([asdict(e) for e in events], ensure_ascii=False, indent=2),
        encoding="utf-8",
    )


def bootstrap_from_current_mod() -> list[EventConfig]:
    """Ricostruisce lo stato dei 4 eventi oggi esistenti in Audiowo (scritti a mano finora),
    letti da Audiowo/hook/* e da Audiowo/METODOLOGIA_AUDIO.md. Serve una volta sola, per far
    partire il tool da uno stato coerente con la mod già funzionante — da qui in avanti lo
    stato lo aggiorna il tool stesso, non si torna a leggere gli hook a mano.
    """
    acu_ids = ["UEL0001", "UAL0001", "URL0001", "XSL0001"]
    events = [
        EventConfig(
            cue="acu_death",
            pattern="A",
            label="Morte ACU (esplosione)",
            targets=[HookTarget("unit", uid, "Killed") for uid in acu_ids],
            pool=[PoolFile("attivi/kaboom.mp3")],
        ),
        EventConfig(
            cue="acu_upgrade_complete",
            pattern="A",
            label="Fine upgrade ACU",
            targets=[HookTarget("unit", uid, "EnhanceEnd") for uid in acu_ids],
            pool=[PoolFile("attivi/carpentiere.mp3")],
        ),
        EventConfig(
            cue="nuke_alarm",
            pattern="B",
            label="Allarme lancio Nuke",
            vo_bank="XGG",
            vo_cue="Computer_Computer_MissileLaunch_01351",
            pool=[PoolFile("attivi/polizia_dei_peni.mp3")],
        ),
        EventConfig(
            cue="mavor_impact",
            pattern="A",
            label="Impatto colpo Mavor",
            targets=[HookTarget("projectile", "TIFHETacticalNuclearShell01", "ImpactTerrain")],
            pool=[PoolFile("attivi/metal_pipe.mp3")],
            attenuation_curve=1050,
            lodcutoff="Weapon_LodCutoff",
            mono=True,
        ),
    ]
    return events


if __name__ == "__main__":
    events = bootstrap_from_current_mod()
    save(events)
    print(f"Stato iniziale salvato per {len(events)} eventi in {config.STATE_JSON}")
