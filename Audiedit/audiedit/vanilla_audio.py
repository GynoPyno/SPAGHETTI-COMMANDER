"""Estrazione dell'audio vanilla per l'anteprima "Originale" in GUI (vedi PIANO_AUDIEDIT.md §6).

I banchi vanilla sono file .xwb/.xsb semplici, non compressi in archivio, già presenti in
sola lettura nell'installazione Steam del gioco (config.STEAM_SOUNDS_DIR, 160 file verificati).
"""
from __future__ import annotations

import tempfile
from pathlib import Path

from . import config
from .xact_binary import (
    XactFormatError,
    find_sound_offset,
    pcm_to_wav_bytes,
    read_wave_bank,
    resolve_sound_waves,
)


class VanillaAudioUnavailable(Exception):
    """Il Bank/Cue vanilla non è estraibile per l'anteprima (banco assente o formato non gestito).

    Non è un errore fatale: la GUI lo mostra come avviso ("anteprima non disponibile"),
    vedi il limite onesto dichiarato nel piano.
    """


def extract_wav_bytes(bank: str, cue: str) -> bytes:
    xsb_path = config.STEAM_SOUNDS_DIR / f"{bank}.xsb"
    if not xsb_path.exists():
        raise VanillaAudioUnavailable(
            f"banco vanilla '{bank}' non trovato in {config.STEAM_SOUNDS_DIR}"
        )
    try:
        xsb_bytes = xsb_path.read_bytes()
        sound_offset = find_sound_offset(xsb_bytes, cue)
        ref = resolve_sound_waves(xsb_bytes, sound_offset)[0]  # anteprima: prima variante
        # Un Sound può pescare l'onda da un banco diverso dal proprio .xsb (es. i cue di
        # selezione unità in Interface.xsb puntano a UEFSelect/AEONSelect/...).
        target_bank = ref.bank_name or bank
        xwb_path = config.STEAM_SOUNDS_DIR / f"{target_bank}.xwb"
        if not xwb_path.exists():
            raise VanillaAudioUnavailable(
                f"banco onde '{target_bank}' non trovato in {config.STEAM_SOUNDS_DIR}"
            )
        waves = read_wave_bank(xwb_path)
        entry = waves[ref.wave_index]
        return pcm_to_wav_bytes(entry)
    except (XactFormatError, IndexError) as exc:
        raise VanillaAudioUnavailable(f"'{bank}'/'{cue}': {exc}") from exc


def extract_to_temp_wav(bank: str, cue: str) -> Path:
    """Scrive l'anteprima in un .wav temporaneo e ne ritorna il percorso (per QMediaPlayer)."""
    wav_bytes = extract_wav_bytes(bank, cue)
    tmp = tempfile.NamedTemporaryFile(prefix="audiedit_preview_", suffix=".wav", delete=False)
    try:
        tmp.write(wav_bytes)
    finally:
        tmp.close()
    return Path(tmp.name)
