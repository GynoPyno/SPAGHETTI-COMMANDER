"""Pannello Editor evento: configura cue, pool (file + varianti), volume, attenuazione,
mono/stereo, LodCutoff — e le due anteprime "Originale"/"Sostituto" (vedi il piano, punto 6).
"""
from __future__ import annotations

import json

from PySide6.QtCore import Qt, Signal
from PySide6.QtWidgets import (
    QCheckBox, QComboBox, QDoubleSpinBox, QFileDialog, QFormLayout, QHBoxLayout, QLabel,
    QListWidget, QListWidgetItem, QMessageBox, QPushButton, QSpinBox, QVBoxLayout, QWidget,
)

try:
    from PySide6.QtMultimedia import QAudioOutput, QMediaPlayer
    from PySide6.QtCore import QUrl
    _MULTIMEDIA_OK = True
except ImportError:  # pragma: no cover - ambiente senza QtMultimedia
    _MULTIMEDIA_OK = False

from audiedit import config, pool, vanilla_audio
from audiedit.catalog import CatalogEntry
from audiedit.state import EventConfig, HookTarget, PoolFile

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

        if _MULTIMEDIA_OK:
            self._player_original = QMediaPlayer(self)
            self._audio_original = QAudioOutput(self)
            self._player_original.setAudioOutput(self._audio_original)
            self._player_sostituto = QMediaPlayer(self)
            self._audio_sostituto = QAudioOutput(self)
            self._player_sostituto.setAudioOutput(self._audio_sostituto)

        layout = QVBoxLayout(self)
        self.title = QLabel("Seleziona un evento dal catalogo")
        self.title.setWordWrap(True)
        layout.addWidget(self.title)

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
        import_btn.clicked.connect(self._on_import_file)
        remove_btn = QPushButton("Rimuovi variante selezionata")
        remove_btn.clicked.connect(self._on_remove_variant)
        pool_buttons.addWidget(import_btn)
        pool_buttons.addWidget(remove_btn)
        layout.addLayout(pool_buttons)

        preview_buttons = QHBoxLayout()
        self.play_original_btn = QPushButton("▶ Originale")
        self.play_original_btn.clicked.connect(self._on_play_original)
        self.play_sostituto_btn = QPushButton("▶ Sostituto")
        self.play_sostituto_btn.clicked.connect(self._on_play_sostituto)
        preview_buttons.addWidget(self.play_original_btn)
        preview_buttons.addWidget(self.play_sostituto_btn)
        layout.addLayout(preview_buttons)

        self.status_label = QLabel("")
        self.status_label.setWordWrap(True)
        layout.addWidget(self.status_label)

        self.save_btn = QPushButton("Salva evento")
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

    def _refresh_pool_list(self) -> None:
        self.pool_list.clear()
        for pf in self._pool_files:
            item = QListWidgetItem(f"{pf.path}  (peso {pf.weight})")
            item.setData(Qt.UserRole, pf.path)
            self.pool_list.addItem(item)

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

        for pf in event.pool:
            pool.assign(pf.path, event.cue)

        if self._editing_index is not None:
            self._events[self._editing_index] = event
        else:
            self._events.append(event)
            self._editing_index = len(self._events) - 1

        from audiedit import state
        state.save(self._events)
        self.status_label.setText(f"Evento '{cue}' salvato.")
        self.event_saved.emit()
