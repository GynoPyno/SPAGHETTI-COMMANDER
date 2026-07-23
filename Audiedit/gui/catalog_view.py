"""Pannello Catalogo: tabella ricercabile di tutti gli Audio.* trovati nei blueprint vanilla."""
from __future__ import annotations

from typing import Callable

from PySide6.QtCore import Signal
from PySide6.QtWidgets import (
    QAbstractItemView, QHeaderView, QLineEdit, QTableWidget, QTableWidgetItem, QVBoxLayout, QWidget,
)

from audiedit.catalog import CatalogEntry

COLUMNS = ["Unità/Proiettile", "Nome", "Contesto", "Campo", "Bank", "Cue", "Pattern", "Configurato"]


class CatalogView(QWidget):
    entry_selected = Signal(object)  # CatalogEntry

    def __init__(
        self, entries: list[CatalogEntry], is_configured: Callable[[CatalogEntry], bool], parent=None
    ):
        super().__init__(parent)
        self._entries = entries
        self._is_configured = is_configured
        self._filtered: list[CatalogEntry] = []

        layout = QVBoxLayout(self)
        self.search = QLineEdit()
        self.search.setPlaceholderText("Cerca per nome, campo, cue...")
        self.search.textChanged.connect(self._apply_filter)
        layout.addWidget(self.search)

        self.table = QTableWidget(0, len(COLUMNS))
        self.table.setHorizontalHeaderLabels(COLUMNS)
        self.table.setEditTriggers(QAbstractItemView.NoEditTriggers)
        self.table.setSelectionBehavior(QAbstractItemView.SelectRows)
        self.table.setSelectionMode(QAbstractItemView.SingleSelection)
        self.table.horizontalHeader().setSectionResizeMode(QHeaderView.Interactive)
        self.table.itemSelectionChanged.connect(self._on_selection_changed)
        layout.addWidget(self.table)

        self._apply_filter("")

    def _row_text(self, e: CatalogEntry) -> list[str]:
        configured = "si" if self._is_configured(e) else ""
        return [e.directory_id, e.display_name or "", e.context, e.field, e.bank, e.cue, e.pattern, configured]

    def _apply_filter(self, text: str) -> None:
        needle = text.lower().strip()
        if not needle:
            self._filtered = list(self._entries)
        else:
            self._filtered = [
                e for e in self._entries
                if needle in " ".join(self._row_text(e)).lower()
            ]
        self._populate()

    def _populate(self) -> None:
        self.table.setRowCount(len(self._filtered))
        for row, entry in enumerate(self._filtered):
            for col, value in enumerate(self._row_text(entry)):
                self.table.setItem(row, col, QTableWidgetItem(value))
        self.table.resizeColumnsToContents()

    def refresh_configured_column(self) -> None:
        self._populate()

    def _on_selection_changed(self) -> None:
        rows = self.table.selectionModel().selectedRows()
        if not rows:
            return
        entry = self._filtered[rows[0].row()]
        self.entry_selected.emit(entry)
