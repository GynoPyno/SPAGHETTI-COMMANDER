"""Percorsi esterni usati da Audiedit — un solo punto da aggiornare se qualcosa si sposta."""
from __future__ import annotations

import os
from pathlib import Path

# Radice del repo delle mod (questo file vive in Audiedit/audiedit/config.py)
REPO_ROOT = Path(__file__).resolve().parents[2]

AUDIEDIT_DIR = REPO_ROOT / "Audiedit"
DATA_DIR = AUDIEDIT_DIR / "data"
CATALOG_JSON = DATA_DIR / "catalog.json"
CURVE_CATALOG_JSON = DATA_DIR / "curve_catalog.json"
POOL_MANIFEST_JSON = DATA_DIR / "pool_manifest.json"
STATE_JSON = DATA_DIR / "audiowo_state.json"

MOD_DIR = REPO_ROOT / "Audiowo"
MOD_SOUNDS_DIR = MOD_DIR / "sounds"
MOD_HOOK_DIR = MOD_DIR / "hook"
MOD_HOOK_UNITS_DIR = MOD_HOOK_DIR / "units"
MOD_HOOK_PROJECTILES_DIR = MOD_HOOK_DIR / "projectiles"
MOD_HOOK_LUA_DIR = MOD_HOOK_DIR / "lua"
USER_SYNC_LUA = MOD_HOOK_LUA_DIR / "UserSync.lua"

POOL_DIR = REPO_ROOT / "Audiowo_file"
POOL_CATEGORIES = ("attivi", "dismessi", "candidati", "varie")

# Cartella di lavoro esterna al repo: dati vanilla estratti + progetto XACT di build.
# Vive fuori da questo repo perché contiene materiale grezzo estratto dal gioco/FAF
# (vedi Audiowo/METODOLOGIA_AUDIO.md e la memoria persistente su "cartelle esterne Audiowo").
WORKDIR = Path(r"C:\Users\hp\Documents\FAF_mod_cartella_lavoro_claude")
UNITS_EXTRACTED_DIR = WORKDIR / "units_nx2_extracted" / "units"
PROJECTILES_EXTRACTED_DIR = WORKDIR / "projectiles_nx2_extracted" / "projectiles"
LUA_EXTRACTED_DIR = WORKDIR / "lua_nx2_extracted" / "lua"
AUDIO_BUILD_DIR = WORKDIR / "audio_build"
XAP_PATH = AUDIO_BUILD_DIR / "Audiowo.xap"

# Installazione gioco e dati FAF — sola lettura.
STEAM_ROOT = Path(r"C:\Program Files (x86)\Steam\steamapps\common\Supreme Commander Forged Alliance")
STEAM_SOUNDS_DIR = STEAM_ROOT / "sounds"
SUPCOM_XGS = STEAM_SOUNDS_DIR / "SupCom.xgs"
FAF_DATA_DIR = Path(r"C:\ProgramData\FAForever")

# Strumenti esterni.
DIRECTX_SDK_BIN = Path(r"C:\Program Files (x86)\Microsoft DirectX SDK (August 2007)\Utilities\Bin\x86")
XACTBLD_EXE = DIRECTX_SDK_BIN / "XactBld.exe"
FFMPEG_EXE = Path(r"C:\Program Files\ImageMagick-7.1.1-Q16-HDRI\ffmpeg.exe")

# Log di partita (per read_log / verifica "Error loading soundbank").
GAME_LOGS_DIR = Path(os.environ.get("APPDATA", "")) / "Forged Alliance Forever" / "logs"


def ensure_pool_dirs() -> None:
    """Crea le 4 sottocartelle del pool se non esistono ancora."""
    for name in POOL_CATEGORIES:
        (POOL_DIR / name).mkdir(parents=True, exist_ok=True)


def ensure_data_dir() -> None:
    DATA_DIR.mkdir(parents=True, exist_ok=True)
