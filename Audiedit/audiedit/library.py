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


_STREAM_RE = re.compile(
    r"Stream #\d+:\d+.*?Audio:.*?(\d+) Hz, (mono|stereo|[\d.]+ channels)"
)
_DURATION_RE = re.compile(r"Duration: (\d+):(\d+):(\d+\.\d+)")


def analyze(path: Path) -> AudioInfo:
    """Analizza un file audio (canali, sample rate, durata) invocando ffmpeg."""
    result = subprocess.run(
        [str(config.FFMPEG_EXE), "-i", str(path)],
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
    return AudioInfo(channels=channels, sample_rate=rate, duration_seconds=duration)


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
