"""Wrapper su XactBld.exe (DirectX SDK August 2007).

IMPORTANTE: va invocato con subprocess diretto da Python (come qui) o da PowerShell —
mai da Git Bash/MSYS, che fallisce sempre con "Impossibile trovare il file specificato"
anche sul progetto tutorial ufficiale Microsoft (vedi Audiowo/METODOLOGIA_AUDIO.md).
"""
from __future__ import annotations

import subprocess
from dataclasses import dataclass
from pathlib import Path

from . import config


@dataclass
class CompileResult:
    success: bool
    stdout: str
    stderr: str


def compile_xap(xap_path: Path) -> CompileResult:
    """Compila `xap_path` con XactBld.exe (cwd = cartella del progetto, come si aspetta i
    percorsi relativi dei .wav dichiarati nel .xap).

    IMPORTANTE: XactBld fa un build incrementale e decide se ricostruire il Wave Bank (.xwb)
    guardando la sezione testuale del progetto, non il contenuto dei .wav referenziati — se i
    nomi/percorsi delle onde nel .xap non cambiano (il caso comune: lo stesso nome cue, solo
    il file sorgente sotto viene rimpiazzato), salta silenziosamente la ricostruzione e lascia
    il vecchio .xwb, pur riportando "Success" e ricompilando normalmente .xgs/.xsb. Verificato
    sul campo: un cambio di file audio applicato con successo nello stato del tool restava
    "congelato" nel banco onde deployato finché non si cancellava .xwb a mano. Per questo si
    cancellano gli output di una build precedente PRIMA di invocare XactBld: senza un file da
    considerare "già buono", non può saltare nulla.
    """
    for suffix in (".xwb", ".xsb", ".xgs"):
        stale = xap_path.with_suffix(suffix)
        if stale.exists():
            stale.unlink()
    result = subprocess.run(
        [str(config.XACTBLD_EXE), "/WIN32", xap_path.name],
        cwd=str(xap_path.parent),
        capture_output=True, text=True,
    )
    success = result.returncode == 0 and "Success" in result.stdout
    return CompileResult(success=success, stdout=result.stdout, stderr=result.stderr)
