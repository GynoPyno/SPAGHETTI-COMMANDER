"""Pannello Pool: le 4 sottocartelle di Audiowo_file/, con drag&drop verso l'editor evento."""
from __future__ import annotations

from PySide6.QtCore import Qt
from PySide6.QtWidgets import QListWidget, QListWidgetItem, QPushButton, QTabWidget, QVBoxLayout, QWidget

from audiedit import config, pool


class PoolFileList(QListWidget):
    """Lista trascinabile (sorgente) dei file di una categoria del pool."""

    def __init__(self, parent=None):
        super().__init__(parent)
        self.setDragEnabled(True)

    def mimeData(self, items):
        mime = super().mimeData(items)
        if items:
            mime.setText(items[0].data(Qt.UserRole))
        return mime


class PoolView(QWidget):
    def __init__(self, parent=None):
        super().__init__(parent)
        self._lists: dict[str, PoolFileList] = {}

        layout = QVBoxLayout(self)
        self.tabs = QTabWidget()
        for category in config.POOL_CATEGORIES:
            lst = PoolFileList()
            self._lists[category] = lst
            self.tabs.addTab(lst, category)
        layout.addWidget(self.tabs)

        refresh_btn = QPushButton("Aggiorna")
        refresh_btn.setToolTip(
            "Ricarica queste liste da disco — utile se hai spostato file a mano fuori da "
            "Audiedit (li ritrova nella cartella in cui li hai messi, li segna come non "
            "ancora assegnati a nessun evento)."
        )
        refresh_btn.clicked.connect(self.refresh)
        layout.addWidget(refresh_btn)

        self.refresh()

    def refresh(self) -> None:
        pool.reconcile()
        manifest = pool.load_manifest()
        by_category: dict[str, list[str]] = {c: [] for c in config.POOL_CATEGORIES}
        for rel, rec in manifest.items():
            by_category.setdefault(rec.status, []).append(rel)
        for category, lst in self._lists.items():
            lst.clear()
            for rel in sorted(by_category.get(category, [])):
                label = rel.split("/")[-1]
                rec = manifest[rel]
                if rec.event_key:
                    label += f"  [{rec.event_key}]"
                item = QListWidgetItem(label)
                item.setData(Qt.UserRole, rel)
                item.setToolTip(rel)
                lst.addItem(item)
