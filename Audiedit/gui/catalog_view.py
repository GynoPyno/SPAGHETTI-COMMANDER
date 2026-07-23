"""Pannello Catalogo: ricerca a faccette su tutti gli Audio.* trovati nei blueprint vanilla.

Pensato per chi non conosce i nomi interni (BlueprintId, nome campo Lua): la ricerca
testuale capisce anche termini italiani comuni ("morte", "impatto", "scudo"...) grazie a
data/search_synonyms.json, e si può restringere per fazione/tipo/campo/pattern/stato senza
dover indovinare l'ortografia esatta.
"""
from __future__ import annotations

import json
from typing import Callable

from PySide6.QtCore import QSize, Signal
from PySide6.QtGui import QIcon
from PySide6.QtWidgets import (
    QAbstractItemView, QCheckBox, QComboBox, QHBoxLayout, QHeaderView, QLabel, QLineEdit,
    QTableWidget, QTableWidgetItem, QVBoxLayout, QWidget,
)

from audiedit import config, icons
from audiedit.catalog import CatalogEntry, faction_of, unit_type_of

COLUMNS = [
    "", "Unità/Proiettile", "Nome", "Fazione", "Tipo", "Contesto", "Campo", "Bank", "Cue",
    "Pattern", "Configurato",
]

_ALL = "(tutti)"


def _load_synonyms() -> dict[str, list[str]]:
    if not config.DATA_DIR.joinpath("search_synonyms.json").exists():
        return {}
    with open(config.DATA_DIR / "search_synonyms.json", encoding="utf-8") as f:
        return json.load(f)


class CatalogView(QWidget):
    entry_selected = Signal(object)  # CatalogEntry

    def __init__(
        self, entries: list[CatalogEntry], is_configured: Callable[[CatalogEntry], bool], parent=None
    ):
        super().__init__(parent)
        self._is_configured = is_configured
        self._synonyms = _load_synonyms()
        self._qicon_cache: dict[str, QIcon | None] = {}

        # precalcolo una volta sola: testo di ricerca e parole-sinonimo pertinenti per voce,
        # per non doverli ricostruire a ogni tasto premuto nella ricerca
        self._rows: list[tuple[CatalogEntry, str, str, str, list[str]]] = []
        for e in entries:
            faction = faction_of(e)
            unit_type = unit_type_of(e)
            haystack = " ".join([
                e.directory_id, e.display_name or "", faction, unit_type,
                e.context, e.field, e.bank, e.cue,
            ]).lower()
            synonym_terms = [
                key for key, fields in self._synonyms.items()
                if any(f.lower() in e.field.lower() for f in fields)
            ]
            self._rows.append((e, faction, unit_type, haystack, synonym_terms))

        self._filtered: list[tuple[CatalogEntry, str, str]] = []

        layout = QVBoxLayout(self)

        self.search = QLineEdit()
        self.search.setPlaceholderText(
            "Cerca (anche in italiano: \"morte\", \"impatto\", \"scudo\", \"fuoco\"...)"
        )
        self.search.textChanged.connect(self._apply_filter)
        layout.addWidget(self.search)

        facet_row = QHBoxLayout()
        self.faction_combo = QComboBox()
        self.type_combo = QComboBox()
        self.field_combo = QComboBox()
        self.pattern_combo = QComboBox()
        self.status_combo = QComboBox()

        factions = sorted({r[1] for r in self._rows})
        self.faction_combo.addItems([_ALL] + factions)
        types = sorted({r[2] for r in self._rows})
        self.type_combo.addItems([_ALL] + types)
        field_counts: dict[str, int] = {}
        for e, *_ in self._rows:
            field_counts[e.field] = field_counts.get(e.field, 0) + 1
        fields_by_freq = [f for f, _ in sorted(field_counts.items(), key=lambda kv: -kv[1])]
        self.field_combo.addItems([_ALL] + fields_by_freq)
        self.pattern_combo.addItems([_ALL, "A", "B"])
        self.status_combo.addItems([_ALL, "Configurati", "Non configurati"])

        for label, combo in [
            ("Fazione", self.faction_combo), ("Tipo", self.type_combo),
            ("Campo", self.field_combo), ("Pattern", self.pattern_combo),
            ("Stato", self.status_combo),
        ]:
            facet_row.addWidget(QLabel(label))
            combo.currentIndexChanged.connect(self._apply_filter)
            facet_row.addWidget(combo)
        layout.addLayout(facet_row)

        self.count_label = QLabel("")
        layout.addWidget(self.count_label)

        self.table = QTableWidget(0, len(COLUMNS))
        self.table.setHorizontalHeaderLabels(COLUMNS)
        self.table.setEditTriggers(QAbstractItemView.NoEditTriggers)
        self.table.setSelectionBehavior(QAbstractItemView.SelectRows)
        self.table.setSelectionMode(QAbstractItemView.SingleSelection)
        self.table.horizontalHeader().setSectionResizeMode(QHeaderView.Interactive)
        self.table.setIconSize(QSize(28, 28))
        self.table.setSortingEnabled(True)
        self.table.itemSelectionChanged.connect(self._on_selection_changed)
        layout.addWidget(self.table)

        self._apply_filter()

    def _get_icon(self, directory_id: str) -> QIcon | None:
        if directory_id not in self._qicon_cache:
            path = icons.get_icon_png(directory_id)
            self._qicon_cache[directory_id] = QIcon(str(path)) if path else None
        return self._qicon_cache[directory_id]

    def _row_text(self, entry: CatalogEntry, faction: str, unit_type: str) -> list[str]:
        configured = "si" if self._is_configured(entry) else ""
        return [
            "", entry.directory_id, entry.display_name or "", faction, unit_type, entry.context,
            entry.field, entry.bank, entry.cue, entry.pattern, configured,
        ]

    def _apply_filter(self, *_args) -> None:
        needle = self.search.text().lower().strip()
        tokens = needle.split()
        faction_filter = self.faction_combo.currentText()
        type_filter = self.type_combo.currentText()
        field_filter = self.field_combo.currentText()
        pattern_filter = self.pattern_combo.currentText()
        status_filter = self.status_combo.currentText()

        self._filtered = []
        for entry, faction, unit_type, haystack, synonym_terms in self._rows:
            if faction_filter != _ALL and faction != faction_filter:
                continue
            if type_filter != _ALL and unit_type != type_filter:
                continue
            if field_filter != _ALL and entry.field != field_filter:
                continue
            if pattern_filter != _ALL and entry.pattern != pattern_filter:
                continue
            if status_filter != _ALL:
                configured = self._is_configured(entry)
                if status_filter == "Configurati" and not configured:
                    continue
                if status_filter == "Non configurati" and configured:
                    continue
            if tokens and not all(
                token in haystack or any(token in kw or kw in token for kw in synonym_terms)
                for token in tokens
            ):
                continue
            self._filtered.append((entry, faction, unit_type))

        self._populate()

    def _populate(self) -> None:
        self.table.setSortingEnabled(False)
        self.table.setRowCount(len(self._filtered))
        for row, (entry, faction, unit_type) in enumerate(self._filtered):
            for col, value in enumerate(self._row_text(entry, faction, unit_type)):
                self.table.setItem(row, col, QTableWidgetItem(value))
            icon = self._get_icon(entry.directory_id)
            if icon is not None:
                self.table.item(row, 0).setIcon(icon)
        self.table.setSortingEnabled(True)
        self.table.resizeColumnsToContents()
        self.table.resizeRowsToContents()
        self.count_label.setText(f"{len(self._filtered)} risultati su {len(self._rows)}")

    def refresh_configured_column(self) -> None:
        self._apply_filter()

    def _on_selection_changed(self) -> None:
        rows = self.table.selectionModel().selectedRows()
        if not rows:
            return
        row = rows[0].row()
        if row >= len(self._filtered):
            return
        entry = self._filtered[row][0]
        self.entry_selected.emit(entry)
