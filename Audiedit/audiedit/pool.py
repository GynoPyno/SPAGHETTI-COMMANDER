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


def _safe_move(src: Path, dest: Path) -> None:
    """Sposta src in dest; se l'operazione fallisce a metà (tipicamente: il sorgente è
    ancora aperto da un altro processo — es. il media player usato per l'anteprima "▶
    Sostituto" — quindi `shutil.move` riesce a copiare ma non a cancellare l'originale),
    ripulisce la copia parziale invece di lasciare un doppione fantasma nel pool, e rilancia
    un errore chiaro invece di uno stack trace grezzo.
    """
    try:
        shutil.move(str(src), str(dest))
    except OSError as exc:
        if dest.exists() and src.exists():
            dest.unlink()
        raise OSError(
            f"impossibile spostare '{src.name}': {exc}. Se lo hai appena ascoltato in "
            "anteprima, prova a fermare la riproduzione (o riseleziona l'evento) e riprova."
        ) from exc


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


def assign_event_files(
    event_key: str, rel_paths: list[str], other_events_paths: frozenset[str] = frozenset()
) -> list[str]:
    """Assegna l'insieme `rel_paths` (percorsi nel pool) come varianti dell'evento
    `event_key`: sposta ciascuno in attivi/ (se non già lì) e sposta in dismessi/ ogni altro
    file che risultava attivo per lo stesso evento ma non è più fra `rel_paths` (rimosso
    dall'editor) — A MENO CHE non compaia in `other_events_paths` (i pool di TUTTI GLI ALTRI
    eventi, calcolati dal chiamante da state.json): un file può essere condiviso da più
    eventi, e rimuoverlo da uno solo non deve spostarlo in dismessi/ se un altro evento lo sta
    ancora usando. Ritorna i percorsi finali, nello stesso ordine di `rel_paths` — possono
    differire dall'ingresso se un file è stato spostato (es. da candidati/ ad attivi/): il
    chiamante deve salvare QUESTI percorsi, non quelli passati in ingresso.

    Nota storica: prima esisteva un `assign()` per-singolo-file, chiamato una volta per ogni
    variante dell'evento. Corrompeva i pool a più varianti (ogni chiamata "sfrattava" in
    dismessi/ qualunque altro file già attivo per lo stesso evento, comportamento corretto
    per un singolo sostituto ma sbagliato quando le varianti multiple sono intenzionali), e
    quando il file di partenza era già in attivi/ faceva scattare `_unique_destination` contro
    se stesso, rinominandolo inutilmente (es. carpentiere.mp3 -> carpentiere_2.mp3 a ogni
    salvataggio successivo).
    """
    manifest = load_manifest()
    new_set = set(rel_paths)

    # smobilita gli attivi di questo evento non più presenti nel nuovo insieme, ma solo se
    # nessun ALTRO evento li usa ancora (altrimenti resta in attivi/: e' condiviso).
    for other_rel, rec in list(manifest.items()):
        if rec.status != "attivi" or rec.event_key != event_key or other_rel in new_set:
            continue
        if other_rel in other_events_paths:
            # ancora in uso da un altro evento: l'etichetta event_key qui diventerebbe
            # fuorviante (un solo nome per un file usato da piu' eventi), la svuotiamo — la
            # verita' su chi lo usa vive negli EventConfig.pool, non in questo manifest.
            rec.event_key = None
            manifest[other_rel] = rec
            continue
        other_path = config.POOL_DIR / other_rel
        if not other_path.exists():
            continue
        dest = _unique_destination(config.POOL_DIR / "dismessi", other_path.name)
        _safe_move(other_path, dest)
        new_rel = dest.relative_to(config.POOL_DIR).as_posix()
        rec.status = "dismessi"
        rec.history.append({"azione": "sostituito", "evento": event_key, "quando": _now()})
        manifest[new_rel] = rec
        del manifest[other_rel]

    final_paths = []
    for rel_path in rel_paths:
        src = config.POOL_DIR / rel_path
        if not src.exists():
            raise FileNotFoundError(f"{src} non esiste nel pool")
        if src.parent == config.POOL_DIR / "attivi":
            # già lì: nessuno spostamento fisico, altrimenti _unique_destination scambierebbe
            # il file con se stesso e lo rinominerebbe senza motivo.
            new_rel = rel_path
        else:
            dest = _unique_destination(config.POOL_DIR / "attivi", src.name)
            _safe_move(src, dest)
            new_rel = dest.relative_to(config.POOL_DIR).as_posix()
        rec = manifest.get(rel_path, FileRecord(status="attivi"))
        rec.status = "attivi"
        rec.event_key = event_key
        rec.history.append({"azione": "assegnato", "evento": event_key, "quando": _now()})
        manifest[new_rel] = rec
        if new_rel != rel_path and rel_path in manifest:
            del manifest[rel_path]
        final_paths.append(new_rel)

    save_manifest(manifest)
    return final_paths


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
