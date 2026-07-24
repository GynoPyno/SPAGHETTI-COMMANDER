"""Libreria di build: analisi/trasformazione audio (via ffmpeg) e lettura del log di gioco.

Niente ffprobe (non installato in questo sistema): ffmpeg stampa le stesse informazioni
su stderr quando gli si passa -i senza specificare un output, tecnica usata qui per analyze().
"""
from __future__ import annotations

import re
import subprocess
from dataclasses import dataclass
from pathlib import Path

from . import config


@dataclass
class AudioInfo:
    channels: int
    sample_rate: int
    duration_seconds: float
    mean_volume_db: float | None = None   # volume medio (loudness), via il filtro volumedetect
    max_volume_db: float | None = None    # picco massimo — vicino a 0 dB = rischio di clipping


_STREAM_RE = re.compile(
    r"Stream #\d+:\d+.*?Audio:.*?(\d+) Hz, (mono|stereo|[\d.]+ channels)"
)
_DURATION_RE = re.compile(r"Duration: (\d+):(\d+):(\d+\.\d+)")
_MEAN_VOLUME_RE = re.compile(r"mean_volume:\s*(-?[\d.]+)\s*dB")
_MAX_VOLUME_RE = re.compile(r"max_volume:\s*(-?[\d.]+)\s*dB")


def analyze(path: Path) -> AudioInfo:
    """Analizza un file audio (canali, sample rate, durata, volume medio/di picco) invocando
    ffmpeg col filtro volumedetect (richiede una decodifica completa del file, l'output va
    scartato nel muxer "null" — niente ffprobe, non installato in questo sistema)."""
    result = subprocess.run(
        [str(config.FFMPEG_EXE), "-i", str(path), "-af", "volumedetect", "-f", "null", "-"],
        capture_output=True, text=True,
    )
    text = result.stderr
    stream_match = _STREAM_RE.search(text)
    if not stream_match:
        raise RuntimeError(f"ffmpeg non ha riconosciuto il file audio: {path}\n{text[-500:]}")
    rate = int(stream_match.group(1))
    chan_text = stream_match.group(2)
    if chan_text == "mono":
        channels = 1
    elif chan_text == "stereo":
        channels = 2
    else:
        channels = int(float(chan_text.split()[0]))
    duration = 0.0
    dur_match = _DURATION_RE.search(text)
    if dur_match:
        h, m, s = dur_match.groups()
        duration = int(h) * 3600 + int(m) * 60 + float(s)
    mean_match = _MEAN_VOLUME_RE.search(text)
    max_match = _MAX_VOLUME_RE.search(text)
    return AudioInfo(
        channels=channels,
        sample_rate=rate,
        duration_seconds=duration,
        mean_volume_db=float(mean_match.group(1)) if mean_match else None,
        max_volume_db=float(max_match.group(1)) if max_match else None,
    )


_DURATION_TOLERANCE_S = 10.0   # oltre questa differenza di durata, somiglianza a 0%
_VOLUME_TOLERANCE_DB = 20.0    # oltre questa differenza di volume medio, somiglianza a 0%


def similarity_score(original: AudioInfo, substitute: AudioInfo) -> tuple[float, float, float]:
    """Somiglianza approssimativa fra un audio originale e un sostituto, come indicatore
    orientativo (non una verifica tecnica di corretto funzionamento): confronta durata e
    volume medio, ciascuno 100% se identici e a decadimento lineare fino a 0% oltre una
    tolleranza. Ritorna (punteggio_durata, punteggio_volume, punteggio_totale), tutti 0-100.
    """
    dur_diff = abs(original.duration_seconds - substitute.duration_seconds)
    dur_score = max(0.0, 100.0 * (1 - dur_diff / _DURATION_TOLERANCE_S))

    if original.mean_volume_db is not None and substitute.mean_volume_db is not None:
        vol_diff = abs(original.mean_volume_db - substitute.mean_volume_db)
        vol_score = max(0.0, 100.0 * (1 - vol_diff / _VOLUME_TOLERANCE_DB))
    else:
        vol_score = dur_score

    return dur_score, vol_score, (dur_score + vol_score) / 2


def volume_warning(info: AudioInfo) -> str | None:
    """Messaggio breve se il volume del file sembra fuori norma per un effetto di gioco,
    altrimenti None. Soglie euristiche, non calibrate su un target di loudness specifico."""
    if info.max_volume_db is not None and info.max_volume_db > -1.0:
        return f"vicino al clipping (picco {info.max_volume_db:.1f} dB)"
    if info.mean_volume_db is not None:
        if info.mean_volume_db < -30.0:
            return f"volume basso ({info.mean_volume_db:.1f} dB medio)"
        if info.mean_volume_db > -6.0:
            return f"volume alto ({info.mean_volume_db:.1f} dB medio)"
    return None


def prepare_wave(source: Path, dest: Path, *, mono: bool) -> None:
    """Converte `source` in un .wav PCM 16-bit 44100Hz (mono o stereo), pronto per il banco XACT."""
    dest.parent.mkdir(parents=True, exist_ok=True)
    args = [
        str(config.FFMPEG_EXE), "-y", "-i", str(source),
        "-ac", "1" if mono else "2",
        "-ar", "44100",
        "-acodec", "pcm_s16le",
        str(dest),
    ]
    result = subprocess.run(args, capture_output=True, text=True)
    if result.returncode != 0 or not dest.exists():
        raise RuntimeError(f"ffmpeg ha fallito la conversione di {source}:\n{result.stderr[-1000:]}")


_ERROR_RE = re.compile(r"Error loading soundbank[^\n]*", re.IGNORECASE)


def latest_game_log() -> Path | None:
    if not config.GAME_LOGS_DIR.exists():
        return None
    logs = sorted(config.GAME_LOGS_DIR.glob("game_*.log"), key=lambda p: p.stat().st_mtime)
    return logs[-1] if logs else None


def read_log_errors(log_path: Path | None = None) -> list[str]:
    """Cerca 'Error loading soundbank' nel log di partita più recente (o in quello indicato).

    Un banco che fallisce il caricamento azzera in silenzio TUTTI gli eventi della mod, non
    solo quello nuovo — vedi Audiowo/METODOLOGIA_AUDIO.md e la memoria persistente
    'Rischio banco XACT condiviso'. Controllare sempre dopo un test in game.
    """
    log_path = log_path or latest_game_log()
    if log_path is None:
        return []
    text = log_path.read_text(encoding="utf-8", errors="replace")
    return _ERROR_RE.findall(text)
