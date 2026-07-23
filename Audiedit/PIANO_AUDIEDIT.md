# Audiedit — Piano del sotto-progetto "correzione spaziale audio"

Documento di pianificazione del primo servizio di Audiedit. Nasce dal problema riscontrato su Audiowo (i suoni custom non si attenuano con la distanza dalla camera). Segue le 5 fasi concordate: analisi del conosciuto → strumenti esistenti → fattibilità → pianificazione → esecuzione/test. Le fasi 1-3 sono già svolte (sotto). Stato: **in pianificazione, in attesa di un test empirico che fissa la trasformazione di base** (vedi §5).

---

## 0. Obiettivo (come definito dall'utente)

Un servizio, **usabile da terminale (anche da un'IA)** e in prospettiva **componente di un sistema più grande**, che:

1. prende in input il **file audio originale** (il suono vanilla del gioco che si sta sostituendo) e il **file audio nuovo** (il rimpiazzo, già in formato corretto ma privo della "valutazione della distanza");
2. analizza entrambi;
3. **produce il file audio da sostituire**, cioè il nuovo suono corretto in modo che si comporti come l'originale rispetto alla distanza/spazializzazione.

---

## 1. Analisi del conosciuto (svolta 2026-07-19)

Confronto binario tra banchi vanilla, una mod funzionante (MemeSoundEffects) e il nostro banco Audiowo. Risultati:

- **L'attenuazione con la distanza in FA NON è dentro il banco XACT della mod.** È guidata da preset RPC globali (`Weapon_LodCutoff`, `DefaultLodCutoff`, `WeaponBig_LodCutoff`, `UnitMove_LodCutoff`, …) definiti **una sola volta** nel `SupCom.xgs` del gioco. Ogni suono vanilla nel blueprint porta un campo `LodCutoff = '...'` che sceglie quale curva applicare.
- **Il motore risolve quei nomi globalmente**, non contro il `.xgs` del banco della mod. Prova: `MemeSounds.xgs` (mod funzionante) è, per contenuto, identico al nostro `Audiowo.xgs` e NON definisce nessun `LodCutoff`, eppure il suo blueprint usa `LodCutoff = 'Weapon_LodCutoff'` su banco custom.
- **Il nostro override del Mavor aveva perso il campo `LodCutoff`** che il suono vanilla aveva (`Weapon_LodCutoff`). → Leva #1 (metadato, fix di una riga nel blueprint).
- **I suoni vanilla d'impatto sono tutti MONO** (32 kHz, PCM 16-bit). Il nostro pipeline produce **STEREO** (44.1 kHz). In XACT il posizionamento 3D — che genera sia il panning sia l'attenuazione con la distanza — è pensato per sorgenti mono; una sorgente stereo viene trattata (almeno in parte) come non-posizionale. → Leva #2 (proprietà del **file audio**: mono vs stereo).
- Struttura dei file (versioni coerenti tra gioco e nostri output di `XactBld` August 2007): `.xgs` magic `XGSF` (43,42); `.xsb` magic `SDBK` (43,43); `.xwb` magic `WBND` (43,42). Il `.xwb` è PCM non compresso → **estraibile e generabile senza reverse engineering di codec**. Le proprietà per-onda (canali, sample rate, bit) stanno nella sezione `ENTRYMETADATA` del `.xwb` (parser già scritto negli script di lavoro).

**Il tentativo precedente fallito** (curva RPC scritta a mano nel `.xap`) era la strada sbagliata: rompeva il caricamento dell'intero `.xsb` in game ("Invalid data") pur compilando senza errori. Non va ripreso (vedi `Audiowo/METODOLOGIA_AUDIO.md`).

## Principio guida (utente)

**Usare librerie/strumenti esistenti quando ci sono, non reinventare.** Vale sia per l'audio (parsing/downmix/analisi via librerie mature invece di codice PCM a mano) sia per l'orchestrazione. Il codice scritto da noi deve limitarsi alla logica specifica del dominio FA/XACT che nessuna libreria copre.

## 2. Strumenti esistenti

- **ffmpeg** (presente: `C:\Program Files\ImageMagick-7.1.1-Q16-HDRI\ffmpeg`) — conversione/downmix audio (stereo→mono, sample rate, PCM 16-bit). Copre da solo la trasformazione audio, e in più decodifica sorgenti compresse (mp3). Prima scelta per la trasformazione (`-ac 1` per il mono).
- **Librerie Python audio** (da preferire per analisi/lettura, secondo il principio guida): `wave` + `audioop` (stdlib, downmix mono e lettura PCM senza dipendenze), `soundfile`/`numpy` (analisi più ricca), `pydub` (wrapper alto livello su ffmpeg). Da valutare quale minimizza le dipendenze mantenendo il codice pulito.
- **XactBld.exe** (DirectX SDK August 2007) — compila `.xap` → `.xwb/.xsb/.xgs`. Va lanciato da PowerShell (mai Bash). Già nel flusso.
- **Python 3.14** (presente) — parsing testuale dei blueprint, parsing binario dei file XACT, orchestrazione di ffmpeg/XactBld via subprocess, esposizione CLI. Già usato per l'analisi binaria di questo documento.
- **MonoGame** (open source) — implementazione di riferimento per parsing `.xsb/.xwb/.xgs`, se in futuro servisse leggere/scrivere i banchi senza XactBld.
- **Xact.exe** (GUI XACT Studio, presente) — solo come ultima risorsa per autorare curve RPC custom, se mai servisse (attualmente NON serve: i preset `LodCutoff` globali coprono il bisogno).

## 3. Fattibilità

**Alta.** Il problema non richiede né reverse engineering di codec né generazione di curve RPC binarie (le due cose più rischiose). La correzione si riduce a:
- **trasformazione audio** (downmix a mono + match del formato) — ffmpeg, banale e affidabile;
- **scelta del metadato `LodCutoff` corretto** da propagare nel blueprint hook — lookup del valore che l'originale aveva.

L'unico punto aperto è **quale leva sia davvero necessaria** per ripristinare l'attenuazione (solo `LodCutoff`, solo mono, o entrambe): si risolve con un test in game, non con altra analisi statica (vedi §5).

## 4. Cosa fa concretamente il tool

Input: `--originale <audio_o_riferimento>` + `--nuovo <audio>`.
Analisi: estrae il **profilo di spazializzazione** dell'originale (canali/mono, sample rate; e, dove disponibile dal blueprint vanilla, il `LodCutoff`) e quello del nuovo.
Output: il **nuovo audio trasformato** perché il suo profilo coincida con quello dell'originale (principalmente: downmix a mono + match formato PCM 44100/16), pronto per entrare nel banco; più, come metadato complementare, il `LodCutoff` consigliato per l'hook.

Nota concettuale importante da tenere presente: la "valutazione della distanza" NON è interamente dentro la forma d'onda. Una parte è la proprietà del file (mono), l'altra è il metadato `LodCutoff` nel blueprint. Il tool copre entrambe: produce il file audio corretto **e** dichiara il `LodCutoff` da usare.

L'originale può essere fornito come file sciolto oppure estratto dal `.xwb` vanilla (l'audio è PCM non compresso, estrazione fattibile leggendo `PlayRegion` dai metadati d'entrata).

## 1-bis. Analisi profonda (2026-07-19) — dov'è davvero l'attenuazione graduale

Dopo che il test "mono + LodCutoff" ha dato attenuazione **a taglio secco** (on/off, senza gradualità), analisi binaria di `SupCom.xgs` e dei sound bank (`.xsb`), usando come riferimento di formato l'implementazione MonoGame. Risultati:

- **Le variabili `*_LodCutoff` NON sono curve di volume: sono soglie di taglio (cull).** Es. `Weapon_LodCutoff` è una variabile con valore `10000` (una distanza): il motore smette di riprodurre il suono oltre quella distanza. Nessuna gradualità → spiega il comportamento on/off osservato. (`DefaultLodCutoff=-1` ≈ mai tagliare; `UnitRumble_LodCutoff=256` ≈ taglio corto.)
- **La gradualità vanilla viene da curve RPC `Distance→Volume` agganciate al singolo suono nel `.xsb`.** Il `SupCom.xgs` contiene 20 curve RPC (tutte → Volume); ~7 mappano la variabile `Distance` sul Volume in modo graduale (valori in centesimi di dB, `0 → -9600`).
- **Prova sui byte**: il sound vanilla d'impatto (`Impacts.xsb`, `flags=0x03`) aggancia 3 RPC per codice-offset: **1050 = curva `Distance→Volume` graduale**, 1355 = `Duck→Volume`, 1437 = `Angle→Volume`. Il nostro `Audiowo.xsb` (`flags=0x01`) **non aggancia nulla**. Anche `MemeSounds.xsb` (`flags=0x00`) non aggancia nulla → **nessuna mod di esempio nel repo ha mai ottenuto l'attenuazione graduale con banco custom**.
- **Perché il tentativo RPC-a-mano era esploso**: XactBld metteva la curva nel *nostro* `Audiowo.xgs` e il `.xsb` la referenziava **per offset dentro quel file**; il motore FA risolve invece contro il `SupCom.xgs` → l'offset puntava a dati inesistenti → `.xsb` "Invalid data". **Confermato il 2026-07-23** leggendo il log di partita: un `.xgs` di mod non viene *mai* caricato.

**Implicazione per la soluzione**: NON creare una curva nostra e non patchare il binario. Far sì che sia **XactBld stesso** a scrivere il codice giusto, allineando l'offset della nostra curva a quello della curva vanilla desiderata. Vedi §5, Test 5 — è la funzione centrale e ad alto valore del tool, ed è interamente automatizzabile.

## 5. Test empirico — esito

Obiettivo: sapere quale leva ripristina l'attenuazione, per fissare la trasformazione di base del tool.

- **Test 1 — `LodCutoff` da solo (banco stereo):** ESITO **negativo** (utente, 2026-07-19) — il solo metadato NON ripristina l'attenuazione. Quindi la forma d'onda stereo è (almeno concausa) il problema: conferma l'intuizione iniziale dell'utente che manca qualcosa **nel file audio**.
- **Test 2 — mono + `LodCutoff`:** ESITO (utente, 2026-07-19) — ora c'è attenuazione **ma a taglio secco** (on/off a una certa distanza, senza gradualità). Il mono ha reso il suono abbastanza 3D da far scattare il cull del `LodCutoff`, ma manca la curva graduale. → vedi §1-bis.
- **Test 3 — patch `.xsb` per referenziare la curva RPC vanilla (codice 1050):** ESITO **FALLITO** (utente, 2026-07-19). Patch strutturalmente corretto (validato: `flags=0x03`, code 1050, offset sistemati) ma in game → `Error loading soundbank '/sounds/audiowo.xsb': Invalid data`, identico al tentativo (a) via XactBld. L'interpretazione data allora ("FA usa il `.xgs` minimale della mod") è stata **smentita dal Test 4**: la causa reale è che il file, essendo patchato a mano, non supera la validazione dell'header. Rollback eseguito (backup `Audiowo.xsb.working_backup`).

- **Test 4 — copiare `SupCom.xgs` come `Audiowo.xgs` ("Metodo B"):** ESITO **negativo e istruttivo** (2026-07-23). Stesso `Invalid data`. Il log ha mostrato che i `.xgs` di mod non vengono mai caricati → la copia era un **no-op**, e l'ipotesi alla base del Test 3 era sbagliata. Verificato inoltre che il campo u16 @8 dell'header `.xsb` non corrisponde a nessuna variante CRC16 standard su 6 file campione: è verosimilmente un checksum proprietario, e questo spiega perché **qualunque** patch binario venga rifiutato anche quando la struttura è corretta.
- **Test 5 — allineamento dell'offset RPC in fase di build:** ESITO **POSITIVO, confermato in game dall'utente (2026-07-23)**. Il Mavor ora si attenua gradualmente e gli altri 3 eventi continuano a funzionare.

**SOLUZIONE (la funzione di punta del tool).** Il codice RPC che XactBld scrive nel `.xsb` è **l'offset della curva dentro il `.xgs` che genera lui**. Gonfiando `Global Settings` con elementi fittizi si sposta quell'offset finché coincide con il codice della curva vanilla voluta: a quel punto è il tool a scrivere il valore giusto, con checksum valido, senza toccare un byte a mano. Grane misurate: **`Variable` = 13 byte, `Category` = 10 byte, curva `RPC` fittizia a 2 punti = 23 byte**; la lunghezza dei nomi non sposta nulla (la tabella nomi sta dopo le curve). Per il Mavor servivano 852 byte (198 → 1050) = 7 categorie + 34 curve fittizie. Prototipo funzionante: `align2.py` (misura le tre grane con 3 compilazioni, risolve la combinazione intera, ricompila e verifica).

Riepilogo leve (aggiornato): **mono** (necessario, abilita il 3D) → **`LodCutoff`** (taglio netto a distanza max) → **curva RPC allineata** (gradualità, scegliendo il profilo fra quelli vanilla).

### Impatto sul tool Audiedit (ridefinizione)
La funzione "attenuazione graduale" **rientra pienamente nello scope** ed è anzi il cuore del servizio, perché è la parte impossibile da fare a mano in modo affidabile. Lo scope si allarga a tutto ciò che è stato mappato il 2026-07-23 (vedi il catalogo in [`Audiowo/METODOLOGIA_AUDIO.md`](../Audiowo/METODOLOGIA_AUDIO.md)): volume, scelta del profilo di attenuazione, direzionalità, pool casuali, condizioni per giocatore.

## 6. Piano a fasi (rivisto)

- [x] F1 — Analisi del conosciuto (come il vanilla implementa l'attenuazione). **Fatto.**
- [x] F2 — Strumenti esistenti. **Fatto.**
- [x] F3 — Fattibilità e approccio. **Fatto.**
- [x] F4 — Test empirico (§5) per fissare le trasformazioni di base. **Fatto: 5 test, soluzione trovata e confermata in game il 2026-07-23.**
- [ ] F5 — Implementazione nucleo (libreria Python). Funzioni identificate dai test:
  - `analyze(audio)` → canali, frequenza, durata, picco;
  - `to_mono(audio)` → la trasformazione che abilita la spazializzazione;
  - `align_rpc(xap, codice_voluto)` → **la funzione di punta**: misura le grane compilando, risolve la combinazione di elementi fittizi, riscrive il `.xap`, ricompila, verifica il codice emesso;
  - `build_bank(xap)` → wrapper su XactBld (da PowerShell, non da Git Bash);
  - `verify_bank(xsb)` → riparsing di controllo (invarianti: la traversata dei sound finisce esattamente su `simpleCuesOffset`, ogni `clipOffset` coincide con la posizione calcolata, i nomi si risolvono);
  - `make_hook(unità|proiettile, evento, banco, cue, lodcutoff)` → genera il `.bp` di hook;
  - `random_pool(cue, [wav])` → più `Wave Entry` con `Weight` in un solo `Play Wave Event`;
  - `read_log()` → estrae da `game_*.log` gli errori `Error loading soundbank` (canale diagnostico autorevole).
- [ ] F6 — Interfaccia CLI sottile sopra la libreria (input/output file, output machine-readable per uso da IA).
- [ ] F7 — Test end-to-end su Audiowo (rigenerare un cue e verificare in game).

**Vincoli operativi appresi sul campo, da rispettare nell'implementazione:**
- XactBld **va lanciato da PowerShell**; da Git Bash fallisce sempre.
- Il `.xsb` **non si patcha a mano**: 3 tentativi, 3 fallimenti. Passare sempre da XactBld.
- Un banco rifiutato **azzera in silenzio tutti gli eventi della mod**, non solo quello nuovo: dopo ogni build, verificare il log prima di considerare valido un test.
- `Name = <cue>;` compare in **tre** sezioni del `.xap` (Wave Bank, Sound Bank, Cue): ancorarsi alla sezione giusta.
- Tenere sempre un backup ripristinabile del banco funzionante.

## 7. Stack e struttura (proposta)

**Python**, per: coerenza col progetto (già usato), idoneità a orchestrare ffmpeg/XactBld, parsing testuale/binario, e soprattutto **duplice natura libreria+CLI** — il nucleo è importabile come "componente di qualcosa di più grande", la CLI è una delle interfacce (usabile da terminale e da un'IA).

Struttura proposta (nomi provvisori):
```
Audiedit/
  PIANO_AUDIEDIT.md        (questo file)
  sound_service/
    core/                  libreria pura (analisi, trasformazione, lookup metadati)
    cli.py                 wrapper da terminale (I/O file + output JSON)
```
