"""Gestione del pool audio in Audiowo_file/: le 4 sottocartelle e il manifest ("memoria").

Sottocartelle (vedi il piano approvato):
  attivi/     file assegnati a un evento, presenti nell'ultima build della mod.
  dismessi/   file che erano attivi e sono stati sostituiti (memoria storica, per tornare
              indietro rapidamente).
  candidati/  file mai assegnati a nessun evento, papabili per il futuro.
  varie/      tutto il resto (meme senza destinazione chiara, audio non pertinenti).

Fonte di verità: il manifest in config.POOL_MANIFEST_JSON (percorso file -> stato/evento/
storico). Le sottocartelle fisiche sono una vista derivata, tenuta sincronizzata a ogni
operazione. `reconcile()` ricostruisce coerenza se qualcosa viene spostato a mano fuori
dal tool.
"""
from __future__ import annotations

import datetime
import json
import shutil
from dataclasses import dataclass, field, asdict
from pathlib import Path

from . import config

# I 4 file oggi noti in uso, ricostruiti da Audiowo/METODOLOGIA_AUDIO.md e
# fede_claude/PROGETTO_AUDIOWO.md (§6) — seme della migrazione iniziale una tantum.
KNOWN_ACTIVE_ASSIGNMENTS: dict[str, str] = {
    "kaboom.mp3": "acu_death",
    "carpentiere.mp3": "acu_upgrade_complete",
    "polizia_dei_peni.mp3": "nuke_alarm",
    "metal_pipe.mp3": "mavor_impact",
}


@dataclass
class FileRecord:
    status: str                 # "attivi" | "dismessi" | "candidati" | "varie"
    event_key: str | None = None
    history: list[dict] = field(default_factory=list)


def _now() -> str:
    return datetime.datetime.now().isoformat(timespec="seconds")


def load_manifest() -> dict[str, FileRecord]:
    if not config.POOL_MANIFEST_JSON.exists():
        return {}
    raw = json.loads(config.POOL_MANIFEST_JSON.read_text(encoding="utf-8"))
    return {k: FileRecord(**v) for k, v in raw.items()}


def save_manifest(manifest: dict[str, FileRecord]) -> None:
    config.ensure_data_dir()
    config.POOL_MANIFEST_JSON.write_text(
        json.dumps({k: asdict(v) for k, v in manifest.items()}, ensure_ascii=False, indent=2),
        encoding="utf-8",
    )


def _unique_destination(dest_dir: Path, filename: str) -> Path:
    candidate = dest_dir / filename
    if not candidate.exists():
        return candidate
    stem, suffix = Path(filename).stem, Path(filename).suffix
    n = 2
    while (dest_dir / f"{stem}_{n}{suffix}").exists():
        n += 1
    return dest_dir / f"{stem}_{n}{suffix}"


def plan_initial_migration() -> list[tuple[Path, str, str | None]]:
    """Elenca (percorso_attuale, categoria_destinazione, event_key) per ogni file esistente
    in Audiowo_file/, senza spostare nulla — la parte "anteprima" richiesta prima di eseguire.
    """
    moves: list[tuple[Path, str, str | None]] = []
    if not config.POOL_DIR.exists():
        return moves
    for path in sorted(config.POOL_DIR.rglob("*")):
        if path.is_dir():
            continue
        if path.parent.name in config.POOL_CATEGORIES:
            continue  # già dentro una sottocartella gestita, non è materiale da migrare
        if path.name in KNOWN_ACTIVE_ASSIGNMENTS:
            moves.append((path, "attivi", KNOWN_ACTIVE_ASSIGNMENTS[path.name]))
        else:
            moves.append((path, "candidati", None))
    return moves


def execute_initial_migration(moves: list[tuple[Path, str, str | None]]) -> dict[str, FileRecord]:
    """Esegue i movimenti pianificati da plan_initial_migration() e scrive il manifest.

    Sono rename sullo stesso volume: reversibili a mano se qualcosa non convince.
    """
    config.ensure_pool_dirs()
    manifest = load_manifest()
    for src, category, event_key in moves:
        dest_dir = config.POOL_DIR / category
        dest = _unique_destination(dest_dir, src.name)
        shutil.move(str(src), str(dest))
        rel = dest.relative_to(config.POOL_DIR).as_posix()
        manifest[rel] = FileRecord(
            status=category,
            event_key=event_key,
            history=[{"azione": "migrazione iniziale", "quando": _now()}],
        )
    save_manifest(manifest)
    return manifest


def import_file(source: Path) -> str:
    """Copia un file esterno (es. da Downloads) dentro candidati/ e lo registra nel
    manifest — copia, non sposta: il file originale dell'utente resta dov'era. Ritorna il
    percorso relativo a POOL_DIR, pronto per essere assegnato a un evento con assign()."""
    config.ensure_pool_dirs()
    dest = _unique_destination(config.POOL_DIR / "candidati", source.name)
    shutil.copy(source, dest)
    rel = dest.relative_to(config.POOL_DIR).as_posix()
    manifest = load_manifest()
    manifest[rel] = FileRecord(status="candidati", history=[{"azione": "importato", "quando": _now()}])
    save_manifest(manifest)
    return rel


def assign(rel_path: str, event_key: str) -> dict[str, FileRecord]:
    """Assegna il file (già nel pool, percorso relativo a POOL_DIR) a un evento: lo sposta
    in attivi/ e, se un altro file era già attivo su quello stesso evento, lo sposta in
    dismessi/ (memoria storica, non lo cancella).
    """
    manifest = load_manifest()
    src = config.POOL_DIR / rel_path
    if not src.exists():
        raise FileNotFoundError(f"{src} non esiste nel pool")

    # eventuale file già attivo sullo stesso evento -> dismessi
    for other_rel, rec in list(manifest.items()):
        if rec.status == "attivi" and rec.event_key == event_key and other_rel != rel_path:
            other_path = config.POOL_DIR / other_rel
            if other_path.exists():
                dest = _unique_destination(config.POOL_DIR / "dismessi", other_path.name)
                shutil.move(str(other_path), str(dest))
                new_rel = dest.relative_to(config.POOL_DIR).as_posix()
                rec.status = "dismessi"
                rec.history.append({"azione": "sostituito", "evento": event_key, "quando": _now()})
                manifest[new_rel] = rec
                if new_rel != other_rel:
                    del manifest[other_rel]

    dest = _unique_destination(config.POOL_DIR / "attivi", src.name)
    shutil.move(str(src), str(dest))
    new_rel = dest.relative_to(config.POOL_DIR).as_posix()
    rec = manifest.get(rel_path, FileRecord(status="attivi"))
    rec.status = "attivi"
    rec.event_key = event_key
    rec.history.append({"azione": "assegnato", "evento": event_key, "quando": _now()})
    manifest[new_rel] = rec
    if new_rel != rel_path and rel_path in manifest:
        del manifest[rel_path]
    save_manifest(manifest)
    return manifest


def reconcile() -> dict[str, FileRecord]:
    """Rete di sicurezza: ricostruisce le voci di manifest mancanti scansionando le
    sottocartelle (per i file spostati a mano fuori dal tool). Non tocca lo stato di ciò
    che è già tracciato.
    """
    manifest = load_manifest()
    known_paths = set(manifest.keys())
    for category in config.POOL_CATEGORIES:
        cat_dir = config.POOL_DIR / category
        if not cat_dir.exists():
            continue
        for path in sorted(cat_dir.rglob("*")):
            if path.is_dir():
                continue
            rel = path.relative_to(config.POOL_DIR).as_posix()
            if rel not in known_paths:
                manifest[rel] = FileRecord(status=category)
    save_manifest(manifest)
    return manifest


def list_by_status(status: str) -> list[str]:
    manifest = load_manifest()
    return sorted(rel for rel, rec in manifest.items() if rec.status == status)


if __name__ == "__main__":
    planned = plan_initial_migration()
    if not planned:
        print("Nessun file da migrare (Audiowo_file/ vuota o già organizzata).")
    else:
        print(f"Migrazione pianificata per {len(planned)} file:\n")
        for src, category, event_key in planned:
            rel = src.relative_to(config.POOL_DIR)
            evt = f" (evento: {event_key})" if event_key else ""
            print(f"  {rel}  ->  {category}/{evt}")
        execute_initial_migration(planned)
        print(f"\nEseguito. Manifest salvato in {config.POOL_MANIFEST_JSON}")
