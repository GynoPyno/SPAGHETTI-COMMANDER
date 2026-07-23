"""Finestra principale: catalogo + editor evento + pool, e il pulsante "Applica e ricompila"."""
from __future__ import annotations

from PySide6.QtCore import Qt
from PySide6.QtGui import QCursor, QIcon
from PySide6.QtWidgets import (
    QApplication, QHBoxLayout, QMainWindow, QMessageBox, QPlainTextEdit, QPushButton,
    QSplitter, QVBoxLayout, QWidget,
)

from audiedit import build as build_module
from audiedit import catalog, config, library, state
from audiedit.catalog import CatalogEntry

from .catalog_view import CatalogView
from .event_editor_panel import EventEditorPanel
from .pool_view import PoolView


def _load_catalog() -> list[CatalogEntry]:
    if config.CATALOG_JSON.exists():
        return catalog.load()
    entries = catalog.scan()
    catalog.save(entries)
    return entries


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Audiedit — editor Audiowo")
        icon_path = config.AUDIEDIT_DIR / "app_icon.ico"
        if icon_path.exists():
            self.setWindowIcon(QIcon(str(icon_path)))
        self.resize(1400, 800)

        self._events = state.load()
        self._catalog_entries = _load_catalog()

        self.catalog_view = CatalogView(self._catalog_entries, self._is_configured)
        self.editor_panel = EventEditorPanel()
        self.editor_panel.set_events(self._events)
        self.pool_view = PoolView()

        self.catalog_view.entry_selected.connect(self.editor_panel.load_from_catalog_entry)
        self.editor_panel.event_saved.connect(self._on_event_saved)

        splitter = QSplitter(Qt.Horizontal)
        splitter.addWidget(self.catalog_view)
        splitter.addWidget(self.editor_panel)
        splitter.addWidget(self.pool_view)
        splitter.setSizes([550, 500, 350])

        central = QWidget()
        layout = QVBoxLayout(central)
        layout.addWidget(splitter, stretch=1)

        build_row = QHBoxLayout()
        self.build_btn = QPushButton("Applica e ricompila")
        self.build_btn.clicked.connect(self._on_build)
        build_row.addWidget(self.build_btn)
        self.check_log_btn = QPushButton("Controlla log di gioco")
        self.check_log_btn.clicked.connect(self._on_check_log)
        build_row.addWidget(self.check_log_btn)
        layout.addLayout(build_row)

        self.log_view = QPlainTextEdit(readOnly=True)
        self.log_view.setMaximumBlockCount(2000)
        layout.addWidget(self.log_view)

        self.setCentralWidget(central)

    def _is_configured(self, entry: CatalogEntry) -> bool:
        for ev in self._events:
            if entry.pattern == "B":
                if ev.vo_bank == entry.bank and ev.vo_cue == entry.cue:
                    return True
            else:
                for t in ev.targets:
                    if (t.kind, t.directory_id, t.field) == (entry.source, entry.directory_id, entry.field):
                        return True
        return False

    def _on_event_saved(self) -> None:
        self.catalog_view.refresh_configured_column()
        self.pool_view.refresh()

    def _on_build(self) -> None:
        self.build_btn.setEnabled(False)
        QApplication.setOverrideCursor(QCursor(Qt.WaitCursor))
        try:
            from audiedit import hooks
            hooks.write_all(self._events)
            result = build_module.build(self._events)
        finally:
            QApplication.restoreOverrideCursor()
            self.build_btn.setEnabled(True)

        self.log_view.appendPlainText("=" * 60)
        self.log_view.appendPlainText("BUILD OK" if result.success else "BUILD FALLITA")
        self.log_view.appendPlainText(result.log)
        if result.xap_backup:
            self.log_view.appendPlainText(f"Backup .xap: {result.xap_backup}")
        if result.sounds_backup:
            self.log_view.appendPlainText(f"Backup banchi precedenti: {result.sounds_backup}")

        if result.success:
            QMessageBox.information(
                self, "Build completata",
                "Mod aggiornata e deployata. Ricorda di testare in game, soprattutto se hai "
                "aggiunto un evento nuovo — nessun controllo automatico sostituisce l'ascolto "
                "in partita.",
            )
        else:
            QMessageBox.critical(self, "Build fallita", result.log[-1000:])

    def _on_check_log(self) -> None:
        errors = library.read_log_errors()
        if errors:
            self.log_view.appendPlainText("=" * 60)
            self.log_view.appendPlainText("Errori trovati nell'ultimo log di partita:")
            for err in errors:
                self.log_view.appendPlainText(f"  {err}")
            QMessageBox.warning(
                self, "Banco non caricato",
                "Il log di partita segnala un errore di caricamento del banco: TUTTI gli "
                "eventi della mod potrebbero essere silenziati, non solo l'ultimo modificato.",
            )
        else:
            self.log_view.appendPlainText("Nessun errore 'Error loading soundbank' nel log più recente.")


def main() -> None:
    app = QApplication.instance() or QApplication([])
    window = MainWindow()
    window.show()
    app.exec()


if __name__ == "__main__":
    main()
