"""Orchestrazione della build completa: dallo stato corrente al banco deployato in
Audiowo/sounds/. È il pulsante unico "Applica e ricompila" del piano.

Passi: prepara i .wav dai file del pool -> rigenera il .xap -> allinea le curve RPC (se
qualche evento ne ha una) e compila -> se ok, backup del banco precedente e deploy in
Audiowo/sounds/. Non tocca gli hook (vedi hooks.py): quelli si rigenerano a parte, di
solito solo quando cambia l'insieme di eventi/target, non a ogni piccola modifica audio.
"""
from __future__ import annotations

import datetime
import shutil
from dataclasses import dataclass
from pathlib import Path

from . import config, library, rpc_align, state, xap_project
from .state import EventConfig


@dataclass
class BuildResult:
    success: bool
    log: str
    xap_backup: Path | None = None
    sounds_backup: Path | None = None


def _wave_filename(cue: str, variant_index: int, total_variants: int) -> str:
    name = cue if total_variants == 1 else f"{cue}_{variant_index}"
    return f"{name}.wav"


def prepare_waves(events: list[EventConfig]) -> None:
    """Converte i file sorgente del pool (in Audiowo_file/) nei .wav pronti per il banco,
    dentro la cartella di build esterna al repo (config.AUDIO_BUILD_DIR)."""
    config.AUDIO_BUILD_DIR.mkdir(parents=True, exist_ok=True)
    for event in events:
        for i, pool_file in enumerate(event.pool):
            source = config.POOL_DIR / pool_file.path
            dest = config.AUDIO_BUILD_DIR / _wave_filename(event.cue, i, len(event.pool))
            library.prepare_wave(source, dest, mono=event.mono)


def backup_xap() -> Path | None:
    if not config.XAP_PATH.exists():
        return None
    stamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
    backup = config.XAP_PATH.with_suffix(f".xap.backup_{stamp}")
    shutil.copy(config.XAP_PATH, backup)
    return backup


def backup_deployed_sounds() -> Path | None:
    """Copia i banchi attualmente in Audiowo/sounds/ in una sottocartella con data/ora,
    prima di sovrascriverli — vedi 'tenere sempre un backup ripristinabile' in
    Audiowo/METODOLOGIA_AUDIO.md. Il backup vive fuori dal repo (accanto agli altri
    artefatti di build), non dentro Audiowo/sounds/ che è tracciato da git."""
    current = config.MOD_SOUNDS_DIR / f"{xap_project.BANK_NAME}.xsb"
    if not current.exists():
        return None
    stamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
    backup_dir = config.AUDIO_BUILD_DIR / "deploy_backups" / stamp
    backup_dir.mkdir(parents=True, exist_ok=True)
    for ext in ("xwb", "xsb", "xgs"):
        src = config.MOD_SOUNDS_DIR / f"{xap_project.BANK_NAME}.{ext}"
        if src.exists():
            shutil.copy(src, backup_dir / src.name)
    return backup_dir


def deploy() -> None:
    config.MOD_SOUNDS_DIR.mkdir(parents=True, exist_ok=True)
    stem = xap_project.BANK_NAME
    for ext in ("xwb", "xsb", "xgs"):
        src = config.AUDIO_BUILD_DIR / f"{stem}.{ext}"
        shutil.copy(src, config.MOD_SOUNDS_DIR / f"{stem}.{ext}")


def build(events: list[EventConfig] | None = None, *, deploy_on_success: bool = True) -> BuildResult:
    events = events if events is not None else state.load()
    if not events:
        return BuildResult(success=False, log="Nessun evento nello stato (audiowo_state.json vuoto).")

    xap_backup = backup_xap()
    prepare_waves(events)
    base_text = xap_project.render_base(events)
    try:
        result = rpc_align.align_and_build(
            events, base_text, config.AUDIO_BUILD_DIR, xap_name=config.XAP_PATH.name
        )
    except rpc_align.AlignmentError as exc:
        return BuildResult(success=False, log=str(exc), xap_backup=xap_backup)

    if not result.success:
        return BuildResult(success=False, log=result.log, xap_backup=xap_backup)

    sounds_backup = None
    if deploy_on_success:
        sounds_backup = backup_deployed_sounds()
        deploy()

    return BuildResult(
        success=True, log=result.log, xap_backup=xap_backup, sounds_backup=sounds_backup
    )


if __name__ == "__main__":
    outcome = build()
    print("OK" if outcome.success else "FALLITO")
    print(outcome.log[-3000:])
    if outcome.xap_backup:
        print(f"backup .xap: {outcome.xap_backup}")
    if outcome.sounds_backup:
        print(f"backup banchi deployati: {outcome.sounds_backup}")
