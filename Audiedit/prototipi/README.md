# Prototipi — script di lavoro da cui nasce Audiedit

Script Python usati per reverse-engineering del sistema audio XACT di Supreme Commander FA
(sessione del 2026-07-19 / 2026-07-23). **Non sono ancora il tool**: sono i pezzi funzionanti e
verificati sul campo, da rifondere nella libreria vera (vedi `../PIANO_AUDIEDIT.md`, fase F5).

Tutti usano solo la libreria standard (`struct`, `subprocess`). I percorsi di gioco e di build
sono in testa a ciascun file — vanno parametrizzati quando diventeranno libreria.

| script | cosa fa | perché conta |
|---|---|---|
| **`align2.py`** | Allinea l'offset della curva RPC nel `.xgs` generato da XactBld al codice di una curva vanilla, così che sia il tool a scrivere il valore giusto nel `.xsb`. Misura le grane con 3 compilazioni, risolve la combinazione intera, ricompila e verifica. | **Il pezzo centrale.** È la soluzione all'attenuazione graduale, confermata in game. Da generalizzare a qualsiasi codice target. |
| `xgs_catalog.py` | Dump completo di `SupCom.xgs`: 39 categorie, 22 variabili, 20 curve RPC con i punti di ogni curva. | Genera il catalogo delle attenuazioni selezionabili. Diventerà la tabella di lookup del tool. |
| `ab_compare.py` | Dato banco + cue, stampa flags/categoria/volume/pitch/RPC del Sound e il formato delle onde del `.xwb`. | Ispettore diagnostico: è così che si è isolata la differenza fra un suono che si attenua e uno che no. |
| `wave_usage.py` | Mappa quali onde usa ogni cue di un banco e quali sono condivise. | Serve a valutare i danni collaterali prima di toccare un banco vanilla. Decodifica anche le liste di varianti (pool casuali). |
| `xwb_format.py` | Parser dell'header `.xwb`: segmenti, conteggio onde, formato per-onda (canali/frequenza/bit). | Base per l'analisi audio e per il controllo mono/stereo. |
| `inspect_ours.py` | Dump ragionato di un `.xsb`: offset di header, entry dei sound, clip data, tabella nomi. | Riferimento di formato commentato; utile per il `verify_bank()` del tool. |
| `crc_hunt.py` | Prova 25 varianti CRC16 standard × 7 intervalli sul campo u16 @8 dell'header `.xsb`. | Risultato **negativo** su 6 file: nessuna combacia. È la prova che quel campo è un checksum proprietario e che il `.xsb` non si patcha a mano. Tenuto come documentazione di un vicolo cieco, per non riesplorarlo. |

## Progetti XACT di riferimento

Il progetto di build vero vive fuori dal repo (`C:\Users\hp\Documents\FAF_mod_cartella_lavoro_claude\audio_build\Audiowo.xap`). Qui ne sono conservate due istantanee di testo, utili come esempio funzionante:

- **`Audiowo.xap.esempio-senza-rpc`** — il progetto originale a 4 suoni, senza attenuazione.
- **`Audiowo.xap.esempio-rpc-allineato`** — lo stesso progetto **dopo l'allineamento**: `Variable{Distance}`, il blocco `RPC{DistanceVolume}`, l'`RPC Entry` sul solo `mavor_impact`, e i 7 `Category` + 34 `RPC` fittizi che spostano l'offset della curva da 198 a **1050**. È il file che, compilato, produce il banco funzionante confermato in game.

Confrontare i due è il modo più rapido per capire cosa deve generare `align_rpc()`.

## Vincoli operativi (imparati sbagliando)

- **XactBld va lanciato da PowerShell.** Da Git Bash fallisce sempre, anche sui progetti tutorial Microsoft.
- **Il `.xsb` non si patcha a mano.** Tre tentativi indipendenti, tutti `Error loading soundbank: Invalid data`, anche con struttura verificata corretta in ogni campo.
- **Un banco rifiutato azzera in silenzio tutti gli eventi della mod**, non solo quello nuovo. Dopo ogni build controllare `%APPDATA%\Forged Alliance Forever\logs\game_*.log` (scritto alla chiusura del gioco) cercando `Error loading soundbank` — è il canale diagnostico autorevole.
- Tenere sempre un backup ripristinabile del banco funzionante.
