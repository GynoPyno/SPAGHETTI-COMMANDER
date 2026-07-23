"""Icone delle unità/proiettili, per mostrarle di fianco alle voci del catalogo.

Le icone di gioco sono texture .dds dentro l'archivio ZIP `textures.nx2` (patch FAF, stesso
formato di lua.nx2/units.nx2 già usato altrove nel progetto), sotto
`textures/ui/common/icons/units/<ID>[_variante]_icon.dds`. Qt non legge .dds nativamente:
si converte in PNG con ImageMagick (già presente sul sistema, supporta DDS in lettura) e si
tiene una cache su disco in data/icons_cache/, perché la conversione (un processo esterno
per file) è troppo lenta per farla ad ogni avvio della GUI.
"""
from __future__ import annotations

import re
import subprocess
import tempfile
import zipfile
from pathlib import Path

from . import config

_ID_RE = re.compile(r"([A-Za-z]{2,4}\d{3,5})")
_MAGICK_EXE = Path(r"C:\Program Files\ImageMagick-7.1.1-Q16-HDRI\magick.exe")

_archive_index_cache: dict[str, str] | None = None


def _pick_entry(entries: list[str]) -> str:
    """Tra più icone per lo stesso ID (varianti di potenziamento, es. Engineer/Combat/...),
    preferisce quella "base" senza suffisso, se esiste."""
    for e in entries:
        base = e.rsplit("/", 1)[-1]
        match = _ID_RE.match(base)
        if match and base[:-4].lower() == f"{match.group(1).lower()}_icon":
            return e
    return entries[0]


def _index_archive() -> dict[str, str]:
    grouped: dict[str, list[str]] = {}
    with zipfile.ZipFile(config.TEXTURES_ARCHIVE) as z:
        for name in z.namelist():
            lname = name.lower()
            if not lname.startswith("textures/ui/common/icons/units/") or not lname.endswith(".dds"):
                continue
            base = name.rsplit("/", 1)[-1]
            match = _ID_RE.match(base)
            if not match:
                continue
            grouped.setdefault(match.group(1).upper(), []).append(name)
    return {key: _pick_entry(entries) for key, entries in grouped.items()}


def _archive_index() -> dict[str, str]:
    global _archive_index_cache
    if _archive_index_cache is None:
        _archive_index_cache = _index_archive()
    return _archive_index_cache


def cache_path(directory_id: str) -> Path:
    return config.ICONS_CACHE_DIR / f"{directory_id.upper()}.png"


def get_icon_png(directory_id: str) -> Path | None:
    """Percorso del .png in cache per l'icona di `directory_id`; la converte al volo da
    .dds la prima volta. None se questo ID non ha un'icona nell'archivio (es. proiettili,
    alcune strutture/decorazioni)."""
    out_path = cache_path(directory_id)
    if out_path.exists():
        return out_path

    entry_name = _archive_index().get(directory_id.upper())
    if entry_name is None:
        return None

    out_path.parent.mkdir(parents=True, exist_ok=True)
    with zipfile.ZipFile(config.TEXTURES_ARCHIVE) as z:
        dds_bytes = z.read(entry_name)

    tmp = tempfile.NamedTemporaryFile(suffix=".dds", delete=False)
    try:
        tmp.write(dds_bytes)
        tmp.close()
        result = subprocess.run(
            [str(_MAGICK_EXE), tmp.name, str(out_path)],
            capture_output=True, text=True,
        )
        if result.returncode != 0 or not out_path.exists():
            return None
    finally:
        Path(tmp.name).unlink(missing_ok=True)
    return out_path


def prewarm_all() -> tuple[int, int]:
    """Converte in anticipo tutte le icone note, così la GUI non deve mai aspettare una
    conversione ImageMagick durante l'uso interattivo. Ritorna (convertite con successo, totali)."""
    index = _archive_index()
    ok = sum(1 for directory_id in index if get_icon_png(directory_id) is not None)
    return ok, len(index)


if __name__ == "__main__":
    done, total = prewarm_all()
    print(f"Icone pronte in cache: {done}/{total} -> {config.ICONS_CACHE_DIR}")
