# Documento degli Obiettivi: Custom Audio Mod & Manager per Supreme Commander: FAF

## 1. Introduzione e Scopo del Documento
Il presente documento definisce gli obiettivi operativi, i requisiti tecnici e i confini architetturali per lo sviluppo di una soluzione integrata (Mod + Tool di gestione esterni) dedicata alla personalizzazione degli eventi audio macro in **Supreme Commander: Forged Alliance** tramite la piattaforma **FAF (Forged Alliance Forever)**.

L'obiettivo di questo documento è analizzare criticamente il brief iniziale, evidenziando le criticità tecniche del motore di gioco e della gestione delle mod in FAF, e riformulare gli obiettivi in modo realistico e strutturato, pronti per essere validati tramite uno studio di fattibilità "codice alla mano".

---

## 2. Analisi Critica del Brief (Messa in Discussione delle Assunzioni)

Prima di procedere allo sviluppo, è fondamentale smontare e analizzare le assunzioni del brief originale per evitare blocchi architetturali insormontabili durante la fase di programmazione.

### 2.1 Criticità 1: Mod Lato Client/UI vs Mod di Simulazione (Il problema del Desync)
* **Assunzione del Brief:** Il brief suggerisce di effettuare l'hook di script come `ACU.lua` o `NukeProjectile.lua` per intercettare i trigger audio (es. morte dell'ACU o lancio Nuke).
* **Messa in discussione:** In Supreme Commander, il codice è rigidamente diviso in due ambienti isolati: **Sim (Simulazione)** e **User (Interfaccia/UI)**.
    * Script come `ACU.lua` e `NukeProjectile.lua` girano nell'ambiente di **Sim**. Qualsiasi modifica, hook o alterazione del codice in questi file trasforma la mod in una **Sim Mod**. Le Sim Mod richiedono che *tutti* i giocatori nella lobby abbiano la mod attiva, altrimenti il gioco subisce un *Desynchronization (Desync)* immediato, rendendo impossibile la partita in multiplayer.
    * Se l'obiettivo inderogabile è una **Mod lato Client/UI** (attivabile dal singolo utente senza vincolare gli altri giocatori), **è tassativamente vietato fare l'hook degli script di Sim**.
* **Soluzione Riformulata:** I trigger degli eventi macro devono essere intercettati interamente nell'ambiente **User/UI**, agganciandosi ai sistemi di notifica che la Sim invia alla UI (es. i messaggi di `Sync` per la perdita del Commander, gli alert radar/UI per il lancio nucleare strategico, e gli eventi dell'interfaccia dei potenziamenti dell'ACU).

### 2.2 Criticità 2: Riproduzione di file audio sciolti (.wav/.ogg) vs Struttura Microsoft XACT
* **Assunzione del Brief:** Memorizzare i file in una cartella `/sounds/` all'interno della mod e caricarli via Lua.
* **Messa in discussione:** Il motore audio di Supreme Commander (basato su una vecchia versione di Microsoft XACT / DirectSound) non gestisce nativamente la riproduzione diretta di file `.wav` o `.ogg` arbitrari tramite le funzioni standard `PlaySound()` se questi non sono impacchettati in un banco audio (`.xwb`, `.xsb`) o definiti rigidamente in strutture di blueprint audio riconosciute.
* **Soluzione Riformulata:** Lo studio di fattibilità deve determinare se:
    1. Esiste un metodo documentato in FAF per registrare una directory di file `.wav` sciolti come "Sound Bank" virtuale leggibile dalle funzioni UI (es. `PlayVoice` o funzioni della UI).
    2. Oppure se il tool esterno deve occuparsi di compilare dinamicamente un file `.xwb` (XACT Wave Bank) utilizzando strumenti a riga di comando (come `XACTBld.exe` o alternative open source) ogni volta che l'utente cambia un suono.

### 2.3 Criticità 3: Il Player Audio Integrato e l'accesso ai file di gioco
* **Assunzione del Brief:** Il tool esterno deve includere un player per ascoltare l'anteprima del suono *originale* predefinito.
* **Messa in discussione:** I suoni originali di gioco sono compressi e impacchettati nei file `.xwb` all'interno dei file d'archivio di SupCom (`.scd` o directory di FAF). Estrarre e riprodurre al volo un suono da un file `.xwb` protetto richiede librerie di parsing XACT (es. `vgmstream` o codice personalizzato), aumentando drasticamente la complessità del tool e sollevando potenziali problemi di ridistribuzione di asset coperti da copyright.
* **Soluzione Riformulata:** Il tool non deve estrarre gli audio dal gioco in tempo reale. In alternativa:
    * Il tool includerà al suo interno una copia pre-estratta (leggera e compressa) esclusivamente dei 4-5 suoni predefiniti oggetto di modifica.
    * Oppure, il player integrato mostrerà l'anteprima *esclusivamente* del nuovo file audio selezionato dall'utente prima di iniettarlo nella mod.

### 2.4 Criticità 4: Assunzione "Unica Mod Audio Attiva"
* **Assunzione del Brief:** Il sistema deve considerare questa come l'unica mod audio attiva.
* **Messa in discussione:** Nel client FAF, gli utenti utilizzano spesso mod UI cumulative (es. *UI Party*, *Common Mod Tools*, mod per la telecamera). Dichiarare l'esclusività può corrompere l'installazione o disabilitare mod essenziali per il giocatore.
* **Soluzione Riformulata:** La mod deve essere strutturata seguendo i canoni standard del sistema di hooking distruttivo/costruttivo di FAF (`mod_info.lua` con priorità definita), garantendo che sovrascriva solo i trigger audio specifici senza interferire con altre mod UI che non toccano le stesse funzioni.

---

## 3. Obiettivi di Progetto Ridefiniti (Il Documento Obiettivi)

Alla luce dell'analisi critica, vengono stabiliti i seguenti obiettivi macro e micro per lo sviluppo.

### Obiettivo 1: Studio e Validazione dei Trigger lato UI (Priorità Assoluta)
Isolare e mappare i punti di aggancio (hook) esclusivamente nell'ambiente UI di FAF per i tre eventi target.
* **Sotto-obiettivo 1.1 (Allarme Nuke):** Individuare il modulo UI che gestisce l'allarme visivo/sonoro del lancio nucleare strategico (es. `/lua/ui/game/scoping.lua` o i trigger di alert strategici nel codice dell'interfaccia utente) e verificare la possibilità di intercettarlo per riprodurre un file audio personalizzato.
* **Sotto-obiettivo 1.2 (Morte ACU):** Trovare il meccanismo con cui la UI riceve la notifica di sconfitta di un Commander (es. tramite il sistema di monitoraggio del punteggio/armate lato UI o gli eventi di chat di sistema `Eradicated`) e iniettare la riproduzione dell'audio di sovraccarico ed esplosione.
* **Sotto-obiettivo 1.3 (Potenziamenti ACU):** Intercettare la fine della coda di costruzione/potenziamento dell'ACU nell'interfaccia dei comandi o tramite il sistema di notifiche vocali nativo della UI.

### Obiettivo 2: Definizione del Meccanismo di Iniezione Audio
Stabilire la modalità con cui il motore di gioco elabora l'audio della mod.
* **Sotto-obiettivo 2.1:** Testare l'utilizzo della funzione UI `PlaySound()` o `PlayVoice()` con percorsi relativi alla cartella della mod (`/mods/MiaMod/sounds/file.wav`) per verificare se il motore accetta file PCM non impacchettati.
* **Sotto-obiettivo 2.2:** Se il punto 2.1 fallisce, definire le specifiche per la generazione automatica di un mini-banco audio `.xwb` da parte del tool esterno.

### Obiettivo 3: Sviluppo del Tool di Gestione Esterno (Manager GUI)
Creare un'applicazione leggera e standalone per l'utente finale.
* **Sotto-obiettivo 3.1 (Rilevamento e Configurazione):** Il tool deve individuare automaticamente il percorso di installazione di FAF (tramite chiavi di registro di Windows o percorsi standard `%appdata%/FaForever/user/MyGames/Gas Powered Games/Supreme Commander Forged Alliance/mods/`).
* **Sotto-obiettivo 3.2 (Interfaccia Utente):** Fornire una GUI minimale strutturata come una tabella di corrispondenze:
    
    | Evento Macro | Audio Corrente | Azione | Anteprima |
    | :--- | :--- | :--- | :--- |
    | Lancio Nuke | [Default] / [Personalizzato.wav] | Sostituisci File | [Play] |
    | Esplosione ACU | [Default] / [Personalizzato.wav] | Sostituisci File | [Play] |
    | Upgrade ACU | [Default] / [Personalizzato.wav] | Sostituisci File | [Play] |

* **Sotto-obiettivo 3.3 (Validazione e Conversione Audio):** Integrare un controllo di robustezza sul file caricato dall'utente. Il tool deve convertire automaticamente l'audio di input in formato **WAV PCM Standard (16-bit, 44100Hz, Stereo/Mono a seconda dei requisiti del motore)** per prevenire crash del gioco.
* **Sotto-obiettivo 3.4 (Generazione Scrittura File):** Il tool deve sovrascrivere i file fisici nella cartella della mod e rigenerare/aggiornare dinamicamente il file `mod_info.lua` per forzare l'aggiornamento della cache di FAF.

---

## 4. Architettura di Riferimento per lo Studio di Fattibilità

Il progetto sarà diviso in due componenti distinte che comunicano unicamente tramite il File System.

```
+-----------------------------------------------------------------------+
|                       MANANGER TOOL (Python/GUI)                      |
|                                                                       |
|  [Interfaccia] -> Seleziona .wav Utente -> Validazione & Conversione |
|                                                    |                  |
+----------------------------------------------------|------------------+
                                                     v
                                      Scrittura nel File System
                                                     |
                                                     v
+-----------------------------------------------------------------------+
|                 DIRECTORY DELLA MOD FAF (/mods/AudioMod/)              |
|                                                                       |
|  ├── mod_info.lua (Rigenerato dal tool)                               |
|  ├── /sounds/ (Contiene i file .wav convertiti dal tool)              |
|  └── /hook/lua/ui/ (Script hook che intercettano gli eventi UI)       |
+-----------------------------------------------------------------------+
                                                     |
                                                     v
                                          Caricato all'avvio da
                                                     |
                                                     v
+-----------------------------------------------------------------------+
|                    SUPREME COMMANDER: FAF GAME ENGINE                 |
|                                                                       |
|  [Engine C++] -> [Ambiente UI (No Sim)] -> Esegue Hook -> Play Audio  |
+-----------------------------------------------------------------------+
```

---

## 5. Check-list per lo Studio di Fattibilità (Codice alla Mano)

Il programmatore/analista dovrà utilizzare la seguente check-list come roadmap immediata per validare il codice:

1. [ ] **Verifica Isolamento UI:** Creare manualmente una mod vuota in FAF, fare l'hook di una funzione di UI (es. l'inizializzazione dell'HUD della partita) e verificare che la mod si carichi regolarmente in una partita multiplayer senza causare Desync.
2. [ ] **Test Riproduzione WAV:** Inserire un file `test.wav` nella cartella della mod ed eseguire tramite la console di gioco (o forzando uno script UI) il comando `PlaySound` o `PlayVoice` indicando il percorso della mod. Controllare i log di gioco (`game.log`) per verificare errori di caricamento audio.
3. [ ] **Intercettazione Nuke Lato UI:** Tracciare quale file di script UI viene eseguito quando compare l'alert visivo di "Nuke Inbound" sulla mappa tattica. Verificare se l'evento è accessibile dall'ambiente User.
4. [ ] **Scelta del Framework GUI:** Scegliere tra `Python + Tkinter` (massima leggerezza, zero dipendenze pesanti) o `Python + PyQt/PySide` (interfaccia più moderna, richiede installazione di pacchetti). Validare la capacità di convertire file audio usando solo librerie Python native o un binario compatto di `ffmpeg`.
