"""Finestre di aiuto: spiegano i parametri dell'editor evento e i criteri di ricerca del
catalogo, per chi non ha in testa le convenzioni interne del progetto (Pattern A/B, RPC,
LodCutoff, sinonimi di ricerca...)."""
from __future__ import annotations

from PySide6.QtWidgets import QDialog, QPushButton, QTextBrowser, QVBoxLayout


def show_help_dialog(parent, title: str, html: str) -> None:
    dialog = QDialog(parent)
    dialog.setWindowTitle(title)
    dialog.resize(560, 520)
    layout = QVBoxLayout(dialog)
    browser = QTextBrowser()
    browser.setOpenExternalLinks(False)
    browser.setHtml(html)
    layout.addWidget(browser)
    close_btn = QPushButton("Chiudi")
    close_btn.clicked.connect(dialog.accept)
    layout.addWidget(close_btn)
    dialog.exec()


EVENT_EDITOR_HELP = """
<h3>Cosa stai modificando</h3>
<p>Ogni riga del catalogo è un punto in cui il gioco riproduce un suono (<code>Audio.NomeCampo</code>
in un file blueprint). Selezionandola crei o modifichi un <b>evento</b>: l'associazione fra
quel punto e uno o più file audio tuoi.</p>

<h3>Cue</h3>
<p>Nome interno del suono dentro il banco <code>Audiowo</code>, deve essere univoco. Non è
visibile in game, serve solo da "etichetta" per il tool e per XACT.</p>

<h3>Pattern</h3>
<p><b>A — PlaySound diretto:</b> il caso comune. Il tool sovrascrive direttamente il campo
Audio.* nel blueprint dell'unità/proiettile. Semplice e affidabile.</p>
<p><b>B — canale annunciatore:</b> alcuni eventi (es. allarme lancio nuke) non passano da un
blueprint ma dalla voce di sintesi del gioco (<code>aiBrain:PlayVOSound</code>). Richiedono un
aggancio in <code>UserSync.lua</code> invece di un override diretto. Il tool lo gestisce da
solo, ma conviene sempre testare in game dopo il primo deploy di un evento Pattern B.</p>

<h3>Volume</h3>
<p>Guadagno fisso in centesimi di dB (100 = +1dB). Si applica sempre, indipendentemente dalla
distanza.</p>

<h3>Converti a mono</h3>
<p>Necessario se vuoi usare l'attenuazione per distanza o la direzionalità 3D (es. capire da
che parte arriva un colpo): XACT applica questi effetti solo a suoni mono. Un file stereo
lasciato tale suonerà sempre alla stessa "posizione" indipendentemente da dove accade.</p>

<h3>Attenuazione per distanza</h3>
<p>Curva RPC (Runtime Parameter Control) che abbassa gradualmente il volume più ci si allontana
dalla sorgente. Le curve disponibili sono quelle già presenti nei banchi vanilla del gioco
(non puoi inventarne di nuove): scegli quella il cui raggio/comportamento assomiglia di più a
quello che vuoi ottenere.</p>

<h3>LodCutoff</h3>
<p>A differenza dell'attenuazione (che è graduale), il LodCutoff è un taglio netto: oltre
quella distanza il suono non viene proprio riprodotto. Utile per suoni ripetitivi (es. armi
automatiche) che diventerebbero fastidiosi in lontananza anche a volume basso.</p>

<h3>File audio assegnati (pool)</h3>
<p>Uno o più file per lo stesso evento: se ne metti più di uno, il gioco ne sceglie uno a caso
a ogni riproduzione, con probabilità proporzionale al <b>peso</b> di ciascuno (255 = peso
massimo). Trascina i file dal pannello Pool a destra per aggiungerli, oppure importa un nuovo
file dal tuo computer.</p>

<h3>▶ Originale / ▶ Sostituto</h3>
<p><b>Originale</b> riproduce l'audio vanilla del gioco per questo evento specifico (estratto
dai banchi originali). <b>Sostituto</b> riproduce il primo file del tuo pool per l'evento in
modifica. Usali insieme per confrontare prima di salvare — non tutti gli audio originali sono
estraibili (alcune strutture audio del gioco non sono ancora decodificate: se compare
"anteprima non disponibile" non è un errore tuo).</p>

<h3>Salva evento</h3>
<p>Scrive le modifiche nello stato del tool (<code>audiowo_state.json</code>), <b>non</b>
nella mod: la mod viene rigenerata solo quando premi "Applica e ricompila" nella finestra
principale.</p>
"""

CATALOG_SEARCH_HELP = """
<h3>Come funziona la ricerca</h3>
<p>Puoi scrivere più parole: vengono cercate tutte (AND), non serve l'ortografia esatta del
nome interno. La ricerca guarda dentro: ID unità/proiettile, nome (DisplayName), fazione,
tipo, contesto (es. nome dell'arma), nome del campo Audio.*, banco e cue vanilla.</p>

<h3>Sinonimi in italiano</h3>
<p>Alcune parole comuni vengono tradotte automaticamente nei nomi interni dei campi. Esempi:</p>
<ul>
<li><b>morte</b> → Killed, Destroyed, DeathExplosion</li>
<li><b>esplosione / impatto</b> → Impact, Explosion</li>
<li><b>nuke</b> → NuclearLaunchDetected, Nuke</li>
<li><b>upgrade</b> → EnhanceEnd, Upgrade</li>
<li><b>sparo / fuoco</b> → Fire, Shoot</li>
<li><b>selezione</b> → UISelection, Select</li>
<li><b>costruzione</b> → Construct, DoneBeingBuilt</li>
<li><b>movimento</b> → Move, StartMove, StopMove</li>
<li><b>scudo</b> → ShieldOn, ShieldOff</li>
<li><b>teletrasporto</b> → Teleport</li>
<li><b>cattura / riciclaggio</b> → Capture, Reclaim</li>
</ul>
<p>La lista completa è in <code>data/search_synonyms.json</code> — puoi aggiungerne altre a
mano se ne senti la mancanza.</p>

<h3>Filtri a faccette</h3>
<p><b>Fazione</b> e <b>Tipo</b> sono dedotti dalla convenzione degli ID (2° carattere =
fazione: E=UEF, A=Aeon, R=Cybran, S=Seraphim; 3° carattere = tipo: L=Terra, A=Aria, S=Navale,
B=Struttura). I proiettili sono classificati a parte.</p>
<p><b>Campo</b> è il nome esatto del campo Audio.* nel blueprint (es. "Killed", "Fire").</p>
<p><b>Pattern</b> filtra fra i due meccanismi di sostituzione: vedi il tasto "?" nell'editor
evento per la spiegazione di A/B.</p>
<p><b>Stato</b> filtra fra voci già configurate (hai assegnato un evento) o ancora libere.</p>

<h3>Colonna icona e "Configurato"</h3>
<p>L'icona è quella dell'unità in gioco (se il tool l'ha trovata nell'archivio texture).
"Configurato" mostra "si" se questa esatta combinazione unità/campo ha già un evento salvato.</p>
"""
