"""Pannello Editor evento: configura cue, pool (file + varianti), volume, attenuazione,
mono/stereo, LodCutoff — e le due anteprime "Originale"/"Sostituto" (vedi il piano, punto 6).
"""
from __future__ import annotations

import json

from PySide6.QtCore import Qt, Signal
from PySide6.QtGui import QPixmap
from PySide6.QtWidgets import (
    QCheckBox, QComboBox, QDoubleSpinBox, QFileDialog, QFormLayout, QHBoxLayout, QLabel,
    QListWidget, QListWidgetItem, QMessageBox, QProgressBar, QPushButton, QSpinBox,
    QVBoxLayout, QWidget,
)

try:
    from PySide6.QtMultimedia import QAudioOutput, QMediaPlayer
    from PySide6.QtCore import QUrl
    _MULTIMEDIA_OK = True
except ImportError:  # pragma: no cover - ambiente senza QtMultimedia
    _MULTIMEDIA_OK = False

from audiedit import config, icons, library, pool, vanilla_audio
from audiedit.catalog import CatalogEntry
from audiedit.state import EventConfig, HookTarget, PoolFile

from .help_dialog import EVENT_EDITOR_HELP, show_help_dialog

_LODCUTOFFS = [
    "(nessuno)", "Weapon_LodCutoff", "WeaponBig_LodCutoff",
    "UnitMove_LodCutoff", "UnitRumble_LodCutoff", "DefaultLodCutoff",
]

with open(config.CURVE_CATALOG_JSON, encoding="utf-8") as _f:
    _CURVES = json.load(_f)


class EventPoolList(QListWidget):
    """Lista dei file assegnati all'evento in editing: accetta il drop di un file
    trascinato dal pannello Pool."""

    files_dropped = Signal(str)

    def __init__(self, parent=None):
        super().__init__(parent)
        self.setAcceptDrops(True)

    def dragEnterEvent(self, event):
        if event.mimeData().hasText():
            event.acceptProposedAction()

    def dragMoveEvent(self, event):
        event.acceptProposedAction()

    def dropEvent(self, event):
        text = event.mimeData().text()
        if text:
            self.files_dropped.emit(text)
        event.acceptProposedAction()


class EventEditorPanel(QWidget):
    event_saved = Signal()

    def __init__(self, parent=None):
        super().__init__(parent)
        self._catalog_entry: CatalogEntry | None = None
        self._editing_index: int | None = None  # indice in self._events, se evento esistente
        self._events: list[EventConfig] = []
        self._pool_files: list[PoolFile] = []
        self._audio_info_cache: dict[str, library.AudioInfo | None] = {}
        self._original_info_cache: dict[tuple[str, str], library.AudioInfo | None] = {}

        if _MULTIMEDIA_OK:
            self._player_original = QMediaPlayer(self)
            self._audio_original = QAudioOutput(self)
            self._player_original.setAudioOutput(self._audio_original)
            self._player_sostituto = QMediaPlayer(self)
            self._audio_sostituto = QAudioOutput(self)
            self._player_sostituto.setAudioOutput(self._audio_sostituto)

        layout = QVBoxLayout(self)
        header_row = QHBoxLayout()
        self.icon_label = QLabel()
        self.icon_label.setFixedSize(48, 48)
        header_row.addWidget(self.icon_label)
        self.title = QLabel("Seleziona un evento dal catalogo")
        self.title.setWordWrap(True)
        header_row.addWidget(self.title, stretch=1)
        help_btn = QPushButton("?")
        help_btn.setFixedWidth(28)
        help_btn.setToolTip("Cosa significano questi parametri?")
        help_btn.clicked.connect(
            lambda: show_help_dialog(self, "Guida ai parametri evento", EVENT_EDITOR_HELP)
        )
        header_row.addWidget(help_btn)
        layout.addLayout(header_row)

        form = QFormLayout()
        self.cue_edit = QComboBox(editable=True)
        form.addRow("Cue", self.cue_edit)

        self.pattern_label = QLabel("-")
        form.addRow("Pattern", self.pattern_label)

        self.volume_spin = QSpinBox()
        self.volume_spin.setRange(-9600, 9600)
        self.volume_spin.setSingleStep(100)
        self.volume_spin.setSuffix(" centesimi di dB")
        form.addRow("Volume", self.volume_spin)

        self.mono_check = QCheckBox("Converti a mono (necessario per attenuazione/direzionalità)")
        form.addRow("", self.mono_check)

        self.attenuation_combo = QComboBox()
        self.attenuation_combo.addItem("Nessuna attenuazione", None)
        for curve in _CURVES:
            label = f"{curve['label']} ({curve['description']})"
            self.attenuation_combo.addItem(label, curve["code"])
        form.addRow("Attenuazione per distanza", self.attenuation_combo)

        self.lodcutoff_combo = QComboBox()
        self.lodcutoff_combo.addItems(_LODCUTOFFS)
        form.addRow("LodCutoff (taglio netto a distanza)", self.lodcutoff_combo)

        layout.addLayout(form)

        layout.addWidget(QLabel("File audio assegnati (trascina qui dal pannello Pool):"))
        self.pool_list = EventPoolList()
        self.pool_list.files_dropped.connect(self._on_file_dropped)
        layout.addWidget(self.pool_list)

        pool_buttons = QHBoxLayout()
        import_btn = QPushButton("Importa nuovo file...")
        import_btn.setToolTip(
            "Copia un file audio da fuori (es. Downloads) dentro il pool, in candidati/, "
            "pronto per essere assegnato a questo o altri eventi."
        )
        import_btn.clicked.connect(self._on_import_file)
        remove_btn = QPushButton("Rimuovi variante selezionata")
        remove_btn.setToolTip(
            "Toglie la variante selezionata dalla lista sopra per QUESTO evento — non cancella "
            "il file, resta nel pool (va in dismessi/ al salvataggio se nessun altro evento lo usa)."
        )
        remove_btn.clicked.connect(self._on_remove_variant)
        pool_buttons.addWidget(import_btn)
        pool_buttons.addWidget(remove_btn)
        layout.addLayout(pool_buttons)

        preview_buttons = QHBoxLayout()
        self.play_original_btn = QPushButton("▶ Originale")
        self.play_original_btn.setToolTip(
            "Riproduce l'audio vanilla del gioco per questo evento (estratto dai banchi "
            "originali) — non sempre disponibile, dipende dalla struttura interna del suono."
        )
        self.play_original_btn.clicked.connect(self._on_play_original)
        self.play_sostituto_btn = QPushButton("▶ Sostituto")
        self.play_sostituto_btn.setToolTip(
            "Riproduce la prima variante del tuo pool per questo evento, così com'è ora "
            "(prima di salvare)."
        )
        self.play_sostituto_btn.clicked.connect(self._on_play_sostituto)
        preview_buttons.addWidget(self.play_original_btn)
        preview_buttons.addWidget(self.play_sostituto_btn)
        layout.addLayout(preview_buttons)

        similarity_row = QHBoxLayout()
        self.similarity_bar = QProgressBar()
        self.similarity_bar.setRange(0, 100)
        self.similarity_bar.setTextVisible(False)
        self.similarity_bar.setFixedWidth(120)
        self.similarity_label = QLabel("")
        self.similarity_label.setWordWrap(True)
        self.similarity_label.setToolTip(
            "Indicatore orientativo (durata + volume) di quanto il sostituto somiglia "
            "all'originale vanilla — non è una verifica che la mod funzioni, solo un aiuto "
            "per farsi un'idea a colpo d'occhio."
        )
        similarity_row.addWidget(self.similarity_bar)
        similarity_row.addWidget(self.similarity_label, stretch=1)
        layout.addLayout(similarity_row)

        self.status_label = QLabel("")
        self.status_label.setWordWrap(True)
        layout.addWidget(self.status_label)

        self.save_btn = QPushButton("Salva evento")
        self.save_btn.setToolTip(
            "Scrive le modifiche nello stato del tool (audiowo_state.json) e nel pool — NON "
            "tocca ancora la mod: serve poi \"Applica e ricompila\" nella finestra principale "
            "per far sentire davvero il cambiamento in game."
        )
        self.save_btn.clicked.connect(self._on_save)
        layout.addWidget(self.save_btn)

        self.setEnabled(False)

    # -- collegamento con lo stato esterno -------------------------------------------------

    def set_events(self, events: list[EventConfig]) -> None:
        self._events = events

    def _find_event_for_entry(self, entry: CatalogEntry) -> tuple[int | None, EventConfig | None]:
        for i, ev in enumerate(self._events):
            if entry.pattern == "B":
                if ev.vo_bank == entry.bank and ev.vo_cue == entry.cue:
                    return i, ev
            else:
                for t in ev.targets:
                    if (t.kind, t.directory_id, t.field) == (entry.source, entry.directory_id, entry.field):
                        return i, ev
        return None, None

    def load_from_catalog_entry(self, entry: CatalogEntry) -> None:
        self._catalog_entry = entry
        self.setEnabled(True)
        icon_path = icons.get_icon_png(entry.directory_id)
        if icon_path:
            pixmap = QPixmap(str(icon_path)).scaled(
                48, 48, Qt.KeepAspectRatio, Qt.SmoothTransformation
            )
            self.icon_label.setPixmap(pixmap)
        else:
            self.icon_label.clear()
        idx, existing = self._find_event_for_entry(entry)
        self._editing_index = idx
        if existing is not None:
            self._load_event(existing)
            self.title.setText(
                f"Evento esistente: {existing.label or existing.cue}  "
                f"({entry.directory_id} / {entry.context} / {entry.field})"
            )
        else:
            suggested_cue = f"{entry.directory_id.lower()}_{entry.field.lower()}"
            targets = [] if entry.pattern == "B" else [
                HookTarget(entry.source, entry.directory_id, entry.field)
            ]
            new_event = EventConfig(
                cue=suggested_cue,
                pattern=entry.pattern,
                label=entry.display_name or entry.directory_id,
                targets=targets,
                vo_bank=entry.bank if entry.pattern == "B" else None,
                vo_cue=entry.cue if entry.pattern == "B" else None,
                lodcutoff=entry.lodcutoff,
            )
            self._load_event(new_event)
            self.title.setText(
                f"Nuovo evento da {entry.directory_id} / {entry.context} / {entry.field} "
                "— non ancora salvato"
            )
        if entry.pattern == "B":
            self.status_label.setText(
                "Attenzione: questo campo passa dal canale annunciatore (Pattern B). "
                "Richiede l'hook UserSync.lua, non un override diretto del blueprint. "
                "Testare sempre in game dopo il primo deploy."
            )
        else:
            self.status_label.setText("")

    def _load_event(self, event: EventConfig) -> None:
        self.cue_edit.setCurrentText(event.cue)
        self.pattern_label.setText(event.pattern)
        self.volume_spin.setValue(event.volume_db)
        self.mono_check.setChecked(event.mono)
        idx = self.attenuation_combo.findData(event.attenuation_curve)
        self.attenuation_combo.setCurrentIndex(idx if idx >= 0 else 0)
        lod_idx = self.lodcutoff_combo.findText(event.lodcutoff or "(nessuno)")
        self.lodcutoff_combo.setCurrentIndex(lod_idx if lod_idx >= 0 else 0)
        self._pool_files = list(event.pool)
        self._refresh_pool_list()

    def _safe_analyze(self, rel_path: str) -> library.AudioInfo | None:
        """Analizza (durata/volume) un file del pool, con cache per non richiamare ffmpeg a
        ogni refresh — un file del pool non cambia contenuto sotto lo stesso path durante una
        sessione."""
        if rel_path not in self._audio_info_cache:
            try:
                self._audio_info_cache[rel_path] = library.analyze(config.POOL_DIR / rel_path)
            except (RuntimeError, OSError):
                self._audio_info_cache[rel_path] = None
        return self._audio_info_cache[rel_path]

    def _refresh_pool_list(self) -> None:
        self.pool_list.clear()
        for pf in self._pool_files:
            label = f"{pf.path}  (peso {pf.weight})"
            info = self._safe_analyze(pf.path)
            warnings: list[str] = []
            if info is not None:
                label += f"  —  {info.duration_seconds:.1f}s"
                if info.duration_seconds > 10:
                    warnings.append(f"dura {info.duration_seconds:.1f}s, oltre i 10s consigliati")
                vol_warn = library.volume_warning(info)
                if vol_warn:
                    warnings.append(vol_warn)
            if warnings:
                label = f"⚠ {label}  [{'; '.join(warnings)}]"
            item = QListWidgetItem(label)
            item.setData(Qt.UserRole, pf.path)
            if warnings:
                item.setToolTip("; ".join(warnings))
            self.pool_list.addItem(item)
        self._update_similarity()

    def _update_similarity(self) -> None:
        if self._catalog_entry is None or not self._pool_files:
            self.similarity_label.setText("")
            self.similarity_bar.setVisible(False)
            return
        key = (self._catalog_entry.bank, self._catalog_entry.cue)
        if key not in self._original_info_cache:
            try:
                wav_path = vanilla_audio.extract_to_temp_wav(*key)
                self._original_info_cache[key] = library.analyze(wav_path)
            except (vanilla_audio.VanillaAudioUnavailable, RuntimeError, OSError):
                self._original_info_cache[key] = None
        original_info = self._original_info_cache[key]
        if original_info is None:
            self.similarity_bar.setVisible(False)
            self.similarity_label.setText(
                "Somiglianza con l'originale non disponibile (anteprima originale non estraibile)."
            )
            return
        substitute_info = self._safe_analyze(self._pool_files[0].path)
        if substitute_info is None:
            self.similarity_bar.setVisible(False)
            self.similarity_label.setText("Somiglianza con l'originale: impossibile analizzare il sostituto.")
            return
        dur_score, vol_score, total = library.similarity_score(original_info, substitute_info)
        self.similarity_bar.setVisible(True)
        self.similarity_bar.setValue(round(total))
        self.similarity_label.setText(
            f"Somiglianza con l'originale: {total:.0f}%  "
            f"(durata {dur_score:.0f}%, volume {vol_score:.0f}%) — indicatore orientativo, non una verifica."
        )

    # -- azioni utente ----------------------------------------------------------------------

    def _on_file_dropped(self, rel_path: str) -> None:
        if any(pf.path == rel_path for pf in self._pool_files):
            return
        self._pool_files.append(PoolFile(path=rel_path))
        self._refresh_pool_list()

    def _on_import_file(self) -> None:
        path_str, _ = QFileDialog.getOpenFileName(
            self, "Importa file audio", "", "Audio (*.mp3 *.wav *.ogg *.flac *.m4a)"
        )
        if not path_str:
            return
        from pathlib import Path
        rel = pool.import_file(Path(path_str))
        self._pool_files.append(PoolFile(path=rel))
        self._refresh_pool_list()

    def _on_remove_variant(self) -> None:
        row = self.pool_list.currentRow()
        if row < 0:
            return
        del self._pool_files[row]
        self._refresh_pool_list()

    def _on_play_original(self) -> None:
        if not _MULTIMEDIA_OK:
            self.status_label.setText("QtMultimedia non disponibile in questo ambiente.")
            return
        if self._catalog_entry is None:
            return
        try:
            wav_path = vanilla_audio.extract_to_temp_wav(
                self._catalog_entry.bank, self._catalog_entry.cue
            )
        except vanilla_audio.VanillaAudioUnavailable as exc:
            self.status_label.setText(f"Anteprima originale non disponibile: {exc}")
            return
        self._player_original.setSource(QUrl.fromLocalFile(str(wav_path)))
        self._player_original.play()

    def _on_play_sostituto(self) -> None:
        if not _MULTIMEDIA_OK:
            self.status_label.setText("QtMultimedia non disponibile in questo ambiente.")
            return
        if not self._pool_files:
            self.status_label.setText("Nessun file assegnato a questo evento.")
            return
        path = config.POOL_DIR / self._pool_files[0].path
        self._player_sostituto.setSource(QUrl.fromLocalFile(str(path)))
        self._player_sostituto.play()

    def _on_save(self) -> None:
        cue = self.cue_edit.currentText().strip()
        if not cue:
            QMessageBox.warning(self, "Cue mancante", "Serve un nome cue per salvare l'evento.")
            return
        if not self._pool_files:
            QMessageBox.warning(
                self, "Nessun file", "Assegna almeno un file audio prima di salvare."
            )
            return
        for i, ev in enumerate(self._events):
            if ev.cue == cue and i != self._editing_index:
                QMessageBox.warning(self, "Cue duplicata", f"Esiste già un evento con cue '{cue}'.")
                return

        # Rilascia eventuali file del pool caricati nei player di anteprima: su Windows un
        # file appena ascoltato con "▶ Sostituto"/"▶ Originale" può restare "in uso" abbastanza
        # da far fallire lo spostamento subito dopo (visto sul campo: la copia riesce, la
        # cancellazione dell'originale no, e senza questo rilascio falliva in silenzio).
        if _MULTIMEDIA_OK:
            self._player_original.stop()
            self._player_original.setSource(QUrl())
            self._player_sostituto.stop()
            self._player_sostituto.setSource(QUrl())

        # Assegna i file del pool a questo evento PRIMA di costruire l'EventConfig: assign_
        # event_files() può spostare fisicamente un file (es. da candidati/ ad attivi/), e il
        # path salvato nello stato deve riflettere la destinazione finale, non quella di
        # partenza — altrimenti lo stato perde traccia del file (vedi cronologia del bug).
        # other_events_paths evita di sfrattare in dismessi/ un file ancora usato da un
        # ALTRO evento (es. lo stesso audio riusato per due unità diverse).
        other_events_paths = frozenset(
            pf.path
            for i, ev in enumerate(self._events)
            if i != self._editing_index
            for pf in ev.pool
        )
        try:
            final_paths = pool.assign_event_files(
                cue, [pf.path for pf in self._pool_files], other_events_paths
            )
        except OSError as exc:
            QMessageBox.critical(
                self, "Salvataggio fallito",
                f"Non sono riuscito a spostare i file audio nel pool:\n\n{exc}",
            )
            return
        for pf, final_path in zip(self._pool_files, final_paths):
            pf.path = final_path

        base = self._events[self._editing_index] if self._editing_index is not None else None
        lod_text = self.lodcutoff_combo.currentText()
        event = EventConfig(
            cue=cue,
            pattern=base.pattern if base else (self._catalog_entry.pattern if self._catalog_entry else "A"),
            label=base.label if base else (self._catalog_entry.display_name if self._catalog_entry else cue),
            targets=base.targets if base else (
                [] if not self._catalog_entry or self._catalog_entry.pattern == "B"
                else [HookTarget(self._catalog_entry.source, self._catalog_entry.directory_id,
                                  self._catalog_entry.field)]
            ),
            vo_bank=base.vo_bank if base else (
                self._catalog_entry.bank if self._catalog_entry and self._catalog_entry.pattern == "B" else None
            ),
            vo_cue=base.vo_cue if base else (
                self._catalog_entry.cue if self._catalog_entry and self._catalog_entry.pattern == "B" else None
            ),
            pool=list(self._pool_files),
            volume_db=self.volume_spin.value(),
            attenuation_curve=self.attenuation_combo.currentData(),
            lodcutoff=None if lod_text == "(nessuno)" else lod_text,
            mono=self.mono_check.isChecked(),
        )

        if self._editing_index is not None:
            self._events[self._editing_index] = event
        else:
            self._events.append(event)
            self._editing_index = len(self._events) - 1

        from audiedit import state
        state.save(self._events)
        self._refresh_pool_list()
        self.status_label.setText(f"Evento '{cue}' salvato.")
        self.event_saved.emit()
