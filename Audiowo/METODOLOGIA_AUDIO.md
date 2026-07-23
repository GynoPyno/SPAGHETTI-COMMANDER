# Metodologia: come sostituire un audio di gioco in Audiowo

Questo documento raccoglie i metodi trovati funzionanti (e quelli falliti, per non riprovarli) per sostituire un suono di gioco con uno personalizzato. Nasce dall'esperienza sui primi 3 audio della mod (morte ACU, upgrade ACU, allarme nuke). Prima di lavorare su un nuovo audio, leggere questo documento: quasi certamente il nuovo caso rientra in uno dei due pattern già mappati sotto.

---

## Passo 0 — Come capire a quale pattern appartiene un nuovo audio

1. Trovare nel codice Lua vanilla (estratto in `FAF_mod_cartella_lavoro_claude/lua_nx2_extracted/`) il punto esatto dove il suono viene innescato. Di solito è un campo dentro `Audio = { ... }` su un blueprint (`.bp`), oppure una chiamata diretta da uno script.
2. Cercare nel codice **lato Sim** (cartella `lua/sim/`, `lua/aibrain.lua`, ecc.) la funzione che legge quel campo/trigger.
3. **Domanda chiave**: quella funzione chiama `self:PlaySound(...)` (o `PlaySound(...)`) **direttamente**, oppure passa da `aiBrain:QualcheMetodo(...)` che poi chiama `PlayVOSound`?
   - Se la risposta è **PlaySound diretto** → **Pattern A**, il caso semplice.
   - Se la risposta è **aiBrain → PlayVOSound → Sync.Voice → PlayVoice** → **Pattern B**, il caso che richiede l'hook UI.
4. **Segnale d'allarme se si sbaglia pattern**: se si prova il Pattern A (override blueprint con banco custom) su un audio che in realtà è Pattern B, il sintomo è un **suono vanilla sbagliato e diverso ogni volta che si ritenta** — mai un errore esplicito nei log. Se capita questo, è quasi certamente Pattern B travestito da A.
5. **Caso particolare — suoni di impatto/esplosione di un projectile** (bombe, missili, proiettili): il campo non è sul blueprint dell'unità ma su quello del **projectile** (`/projectiles/<Nome>/<Nome>_proj.bp`, cercare `ProjectileId` nell'arma nel blueprint dell'unità per trovare il nome). I campi `Audio.Impact`, `Audio.ImpactTerrain`, `Audio.ImpactWater`, `Audio.ImpactUnit`, ecc. passano tutti da `sim/Projectile.lua` (`EntityPlaySound`, nativo) — **sempre Pattern A**, mai bisogno di hook UI. I file `.bp` dei projectile non sono nell'archivio `units.nx2` ma in un archivio a parte, `projectiles.nx2` (stesso `C:\ProgramData\FAForever\gamedata\`, stesso formato ZIP, stessa procedura di estrazione).

---

## Pattern A — "PlaySound diretto" (semplice, affidabile)

**Come riconoscerlo**: il campo blueprint viene letto da una funzione che chiama `self:PlaySound(bp[campo])` direttamente (es. `PlayUnitSound` in `sim/Unit.lua`), senza intermediari.

**Soluzione**: override del blueprint con `Merge = true`, sovrascrivendo il campo `Audio.<Nome>` con un `Sound { Bank = 'Audiowo', Cue = '...' }` che punta al nostro banco. Funziona sempre, in modo affidabile, con banchi audio aggiunti da mod — nessun trucco necessario.

**File tipo**:
```
UnitBlueprint {
Merge = true,
BlueprintId = "xxx0001",
    Audio = {
        NomeCampo = Sound {
            Bank = 'Audiowo',
            Cue = 'nome_cue',
        },
    },
}
```

**Casi risolti con questo pattern**:
- `Audio.Killed` (morte ACU) — letto da `PlayUnitSound`, chiamato da `OnKilledVO`/logica di morte in `sim/Unit.lua`.
- `Audio.EnhanceEnd` (fine upgrade ACU) — letto da `PlayUnitSound`, chiamato da `OnWorkEnd` in `sim/Unit.lua`.
- `Audio.ImpactTerrain` sul **projectile** del colpo del Mavor (`UEB2401`, projectile `TIFHETacticalNuclearShell01`, 2026-07-19) — letto in `sim/Projectile.lua:457-461` (`local snd = blueprintAudio['Impact' .. targetType]; ... EntityPlaySound(self, snd)`, dove `EntityPlaySound = EntityMethods.PlaySound`, stessa famiglia nativa di `self:PlaySound`). Override sul blueprint del **projectile** (`/projectiles/<Nome>/<Nome>_proj.bp`), non sull'unità — il colpo/bomba è un'entità separata dall'unità che lo lancia. Nota generale: qualunque `Audio.Impact*` su un projectile passa da questa stessa funzione, quindi è sempre Pattern A. (Provato per la prima volta sul Bombardiere Strategico T3 — stesso identico meccanismo, poi spostato sul Mavor su richiesta esplicita.)

---

## Pattern B — "Canale annunciatore" (VO / Sync.Voice / PlayVoice)

**Come riconoscerlo**: il campo blueprint viene letto da una funzione che chiama `aiBrain:NomeMetodo(bp[campo])` (definita in `aibrain.lua`), che a sua volta chiama `PlayVOSound`. Questa fa `local cue, bank = GetCueBank(sound)` (funzione **nativa**, lato Sim) e poi `table.insert(Sync.Voice, {Cue=cue, Bank=bank})`. Lato UI, `UserSync.lua:OnSync()` legge `Sync.Voice` ogni sync e chiama `PlayVoice(Sound(v), true)` per ogni voce.

**Perché il Pattern A NON funziona qui**: mettere un banco custom nel campo blueprint lo fa passare per `GetCueBank` lato Sim, che **non sa risolvere banchi audio aggiunti da mod** (probabilmente perché deve restare affidabile/deterministica e conosce solo i banchi vanilla) — il risultato è un suono vanilla sbagliato e diverso ogni volta, mai un errore.

**Altri tentativi che NON funzionano** (verificati, non riprovare):
- Ridefinire globalmente `PlayVoice(sound, ...)` per intercettare e sostituire il suono al volo — **non ha alcun effetto**, silenziosamente, anche con sintassi corretta.
- Mutare `v.Bank`/`v.Cue` **sul posto** dentro `Sync.Voice` e lasciare che sia il gioco a chiamare `PlayVoice` con i valori sostituiti — **PlayVoice non gestisce bene i banchi custom**, indipendentemente da dove/come viene chiamata. Risultato: ancora un suono vanilla sbagliato.

**Soluzione che funziona**:
1. **Non toccare il blueprint** — lasciare il campo `Audio.<Nome>` vanilla, così `GetCueBank` lato Sim continua a risolverlo correttamente come ha sempre fatto.
2. Hook **solo lato UI**, su `hook/lua/UserSync.lua` (stesso percorso del file vanilla `/lua/UserSync.lua`), ridefinendo `OnSync()`:
   - Salvare la funzione originale (`local OldOnSync = OnSync`).
   - Ricostruire `Sync.Voice` **escludendo** (non mutando) le voci che corrispondono a `Bank`/`Cue` vanilla del suono da sostituire.
   - Se trovata una voce da sostituire, riprodurre il suono con **`PlaySound` diretto** (mai `PlayVoice`) puntando al nostro banco.
   - Richiamare `OldOnSync()` alla fine, così tutto il resto della sincronizzazione (punteggi, chat, obiettivi, ecc.) continua a funzionare normalmente.

**Codice di riferimento** (adattare Bank/Cue al caso specifico):
```lua
local OldOnSync = OnSync

OnSync = function()
    if Sync.Voice then
        local filtered = {}
        local playCustom = false
        for k, v in Sync.Voice do
            if v.Bank == 'BancoVanilla' and v.Cue == 'CueVanilla' then
                playCustom = true
            else
                table.insert(filtered, v)
            end
        end
        Sync.Voice = filtered
        if playCustom then
            PlaySound(Sound {
                Bank = 'Audiowo',
                Cue = 'nome_cue',
            })
        end
    end
    return OldOnSync()
end
```

**Caso risolto con questo pattern**:
- `Audio.NuclearLaunchDetected` (allarme nuke, quello che sente il nemico) — `Cue = 'Computer_Computer_MissileLaunch_01351'`, `Bank = 'XGG'`.

**Nota**: esiste anche un secondo sistema, indipendente, per il "ping" visivo+sonoro sulla mappa (`ui/game/nukelaunchping.lua` → `ui/game/ping.lua`, suono `Aeon_Select_Radar` dal banco `Interface`, riprodotto con `PlaySound` diretto lato UI). Non è quello che sente il nemico in modo affidabile (dipende dal fatto di avere visione/radar sul punto), ma potrebbe essere rilevante per altri scopi (es. il feedback di chi lancia). Se in futuro serve toccare anche quello, è un Pattern A (PlaySound diretto), quindi semplice.

---

## Attenuazione del volume in base alla distanza dalla camera — RISOLTO il 2026-07-23 (vedi in fondo alla sezione)

**Sintomo (2026-07-19)**: un suono custom (Pattern A, `EntityPlaySound`) ha panning direzionale corretto (si sente da che lato arriva rispetto all'inquadratura), ma **il volume resta sempre al massimo indipendentemente dalla distanza** dalla camera — a differenza dei suoni vanilla, che si affievoliscono con la distanza (confermato anche da segnalazioni della community FAF: mod audio "grezze" come Total Mayhem hanno lo stesso problema, "not attenuated by camera distance", a differenza della maggior parte dei suoni originali del gioco).

**Causa (teoria, non del tutto confermata)**: il panning/posizionamento 3D è calcolato in automatico dal motore quando il suono è legato a un'entità (`EntityPlaySound`), mentre l'attenuazione del volume richiederebbe una curva **RPC (Runtime Parameter Control)** nel banco XACT che mappa la variabile riservata `Distance` sul parametro `Volume` del Sound — dato che i banchi vanilla (compilati da GPG con la vera XACT Studio) probabilmente hanno e il nostro `Audiowo.xap` (scritto a mano) no.

**Tentativo fatto e FALLITO**: aggiunta a mano nel testo di `Audiowo.xap` una `Variable { Name = Distance; Reserved = 1; ... }` in `Global Settings`, un blocco `RPC { RPC Curve { Property = 0; Variable Entry { Name = Distance; } RPC Point {...} } }`, e agganciata con `RPC Entry`/`RPC Curve Entry` al sound `mavor_impact`. **`XactBld.exe` ha compilato tutto senza errori** (build "Success!"), ma **in game l'intero Sound Bank `Audiowo.xsb` ha smesso di caricarsi**: `warning: Error loading soundbank '/sounds/audiowo.xsb': Invalid data` nel log partita (`C:\Users\hp\AppData\Roaming\Forged Alliance Forever\logs\game_<id>.log`). Risultato: **non solo il nuovo suono non ha funzionato, ma sono spariti anche morte ACU, upgrade ACU e allarme nuke**, perché condividono lo stesso file `.xsb`. XactBld accetta la sintassi testuale ma il motore di gioco (versione XACT più vecchia/diversa, `xactengine2_9.dll`) rifiuta il binario compilato come "Invalid data" — la nostra sintassi RPC scritta a mano, pur sintatticamente valida per il compilatore, produce un binario che il runtime del gioco non accetta (mancano probabilmente campi/metadati che la vera XACT Studio genera automaticamente e che non sono documentati nel formato testuale `.xap`).

**Rollback eseguito**: rimossi `Variable{Distance}`, il blocco `RPC{...}`, e i riferimenti `RPC Entry`/`RPC Curve Entry` da `Audiowo.xap`. Ricompilato e ridistribuito — il Sound Bank torna a caricarsi come prima (nessuna curva RPC, nessun campo `RPC`/`Variable` nel progetto).

**Se si vuole riprovare in futuro**: NON riscrivere a mano i blocchi `RPC`/`Variable` nel `.xap` — il rischio è di rompere l'intero banco (tutti gli eventi, non solo quello nuovo) in un modo che il compilatore non segnala. Servirebbe usare la vera GUI **XACT Studio** (`Xact.exe`, nella stessa cartella di `XactBld.exe`: `C:\Program Files (x86)\Microsoft DirectX SDK (August 2007)\Utilities\Bin\x86\Xact.exe`) per costruire l'RPC tramite editor visuale (Variable=Distance, Object=Sound, Parameter=Volume, poi "Attach/Detach RPC" sul sound) — l'editor genera i metadati corretti che a mano non siamo riusciti a replicare. Questo richiede intervento manuale dell'utente nella GUI (non scriptabile da qui), poi si torna a compilare con `XactBld.exe` da PowerShell come sempre. **Prima di riprovare, testare SEMPRE in game su un solo evento alla volta e controllare subito il log per `Error loading soundbank` prima di considerare il resto della sessione di test valido** — un fallimento qui azzera silenziosamente tutti gli altri eventi della mod.

### Pista corretta trovata dopo (2026-07-19, analisi binaria) — la curva RPC NON serviva

Confrontando i binari dei banchi vanilla, di una mod funzionante (MemeSoundEffects) e del nostro, l'attenuazione con la distanza NON dipende da una curva RPC nel banco della mod. Dipende da due cose, entrambe più semplici e sicure:

1. **Campo `LodCutoff` nel blueprint** (metadato, zero rischio). I nomi tipo `Weapon_LodCutoff`, `DefaultLodCutoff`, `WeaponBig_LodCutoff`, `UnitMove_LodCutoff` sono **preset RPC globali definiti una sola volta nel `SupCom.xgs` del gioco**, e il motore li risolve **globalmente** — non serve definirli nel `.xgs` della mod (provato: `MemeSounds.xgs` di una mod funzionante è identico al nostro e non li contiene, eppure il suo blueprint li usa su banco custom). Quando si fa l'override di un `Sound` vanilla, **mantenere il campo `LodCutoff` che il suono originale aveva** (noi l'avevamo perso). Esempio Mavor: il vanilla era `Sound { Bank='Impacts', Cue='Impact_Land_Gen_UEF_Big', LodCutoff='Weapon_LodCutoff' }`, quindi l'override deve portare `LodCutoff = 'Weapon_LodCutoff'`.
2. **Sorgente audio MONO** (proprietà del file). I suoni vanilla d'impatto sono tutti mono (32 kHz PCM); il nostro pipeline produce stereo. In XACT il posizionamento 3D (panning + attenuazione) è pensato per sorgenti mono, lo stereo viene trattato in parte come non-posizionale. Se il solo `LodCutoff` non basta, convertire il wav a **mono** prima di compilarlo nel banco.

**Ordine di prova consigliato** (dal più economico): prima aggiungere solo il `LodCutoff` all'override (nessun rebuild del banco) e testare; se non basta, rigenerare il cue in mono e ricompilare. Questo è anche il punto di partenza del servizio Audiedit (Task 5, vedi [`Audiedit/PIANO_AUDIEDIT.md`](../../Audiedit/PIANO_AUDIEDIT.md)).

**Esiti dei test (2026-07-19)** — tre livelli di attenuazione, non uno:
1. **`LodCutoff` da solo (stereo)**: NON attenua. Il `LodCutoff` da solo non fa nulla se il suono non è trattato come 3D.
2. **mono + `LodCutoff`**: attenua ma **a taglio secco** (on/off). Il mono abilita il 3D → scatta il cull del `LodCutoff`, ma senza gradualità. Motivo (analisi binaria): le variabili `*_LodCutoff` sono **soglie di taglio** (distanze), non curve di volume.
3. **gradualità** (il "via di mezzo"): richiede una **curva RPC `Distance→Volume` agganciata al sound nel `.xsb`**. I suoni vanilla d'impatto agganciano il codice RPC `1050` (curva `Distance→Volume` graduale definita nel `SupCom.xgs`); i nostri non agganciano nulla. **Nessuna mod di esempio nel repo l'ha mai fatto** — e ora sappiamo probabilmente perché: **non è ottenibile con i nostri strumenti.**

**RISULTATO NEGATIVO CONFERMATO (2026-07-19): QUALUNQUE riferimento RPC in un `.xsb` di mod fa fallire il caricamento del banco (`Invalid data`).** Provato in due modi indipendenti, stesso identico esito:
   - (a) autorare la curva RPC nel `.xap` e ricompilare con XactBld → `Invalid data`;
   - (b) patch binario del `.xsb` (validato strutturalmente: sound con `flags=0x03`, RPC code `1050`, tutti gli offset corretti) per referenziare la curva vanilla → `Invalid data`.
   Interpretazione data allora — **SBAGLIATA, ritirata il 2026-07-23**: si era ipotizzato che FA associasse al banco della mod il `.xgs` della mod stessa. Il log di partita dimostra il contrario: **un `.xgs` di mod non viene mai caricato**, FA usa solo il `SupCom.xgs`. Le cause reali erano due, diverse fra loro: in (a) XactBld calcolava il codice RPC come offset dentro il *nostro* `.xgs`, quindi puntava a un indirizzo inesistente nel `SupCom.xgs`; in (b) il patch binario è comunque rifiutato (il campo u16 @8 dell'header è verosimilmente un checksum non ricalcolabile). Vedi la soluzione in fondo.

### SOLUZIONE (2026-07-23, confermata in game): allineamento dell'offset RPC in fase di build

Il codice RPC che XactBld scrive nel `.xsb` **è l'offset della curva dentro il `.xgs` che genera lui stesso**. Non serve quindi nessuna patch binaria: basta gonfiare il `.xgs` con elementi fittizi finché quell'offset coincide con il codice della curva vanilla che si vuole usare. A quel punto è il tool a scrivere il valore giusto, con checksum valido, e il banco carica.

**Grane di spostamento misurate** (quanto sposta in avanti l'offset della curva ogni elemento aggiunto in `Global Settings`, *prima* del blocco `RPC`):

| elemento aggiunto | sposta di |
|---|---|
| `Variable` | 13 byte |
| `Category` | 10 byte |
| curva `RPC` fittizia (2 punti) | 23 byte |
| lunghezza dei nomi | **0 byte** (la tabella nomi sta dopo le curve) |

**Procedura** (automatizzata da `align2.py`, vedi scratchpad; il flusso è: misura le tre grane compilando 3 volte → risolve la combinazione intera → ricompila e verifica):
1. Nel `.xap`, in `Global Settings`: `Variable { Name = Distance; Reserved = 1; ... }` + un blocco `RPC { RPC Curve { Property = 0; Variable Entry { Name = Distance; } ... } }`.
2. Nel `Sound` da attenuare (**solo quello**): `RPC Entry { RPC Name = DistanceVolume; }`.
3. Compilare, leggere il codice emesso nel `.xsb` (offset `soundStart + 10`, dopo `numClips`: `u16 dataLength, u8 numPresets, u32 codice`).
4. Aggiungere categorie/variabili/curve fittizie finché il codice emesso = quello voluto. Per il Mavor servivano 852 byte (198 → 1050) = **7 categorie + 34 curve fittizie**.

Effetto collaterale utile: anche nel nostro `.xgs` l'offset risultante è una curva `Distance→Volume` vera, quindi il risultato è corretto sotto entrambe le ipotesi su quale global-settings usi il motore.

**Attenzione**: `Name = mavor_impact;` compare in **tre** sezioni del `.xap` (Wave Bank, Sound Bank, Cue). Ancorarsi alla sezione giusta quando si inserisce l'`RPC Entry`, altrimenti finisce su un altro suono.

**Formato dei file XACT (per riferimento futuro, parser in Python già scritti negli script di lavoro):** `.xgs`=`XGSF` (header + variabili + curve RPC: ogni curva = `u16 varIndex, u8 pointCount, u16 param(0=Volume,1=Pitch,2=ReverbSend,3=FilterFreq,4=FilterQ)`, poi `pointCount×(f32 pos, f32 val, u8 type)`). `.xsb`=`SDBK` (header di offset + entry Sound: `u8 flags` [bit0=complex, bit1-3=ha RPC, bit4=ha DSP], `u16 cat, u8 vol, u16 pitch, u8 prio, u16 filter`, poi track/clip, poi se ha RPC: `u16 dataLen, u8 numPresets, numPresets×u32 codiceRPC`). `.xwb`=`WBND` (formato per-onda: canali/rate/bit impacchettati in un dword). Riferimento di formato: implementazione MonoGame (`AudioEngine.cs`/`SoundBank.cs`/`XactSound.cs`).

---

## Regole trasversali per qualunque hook `.lua`

- Gli hook su file `.lua` (es. `hook/lua/UserSync.lua`, `hook/lua/ui/game/gamemain.lua`) **non sono un sistema di override separato**: il motore fa una **concatenazione testuale** — il contenuto del file della mod viene incollato in coda al file vanilla originale, e il risultato compilato come blocco unico. Per questo un file può limitarsi a poche righe aggiuntive (il codice vanilla gira comunque per intero).
- **Un banale errore di sintassi in un hook `.lua` può causare un crash del motore**, non solo un errore recuperabile — confermato con l'uso di `...` (vararg) in un contesto che ha reso l'intero file concatenato non compilabile. Regole pratiche:
  - Evitare `...` (vararg) quando si conosce già la firma esatta della funzione da wrappare — usare parametri nominati.
  - Usare solo costrutti già visti funzionare nel codice vanilla circostante (for-in, if/then/else, `table.insert`, riassegnazione di funzione globale).
  - Testare in partita locale/sandbox, non in ranked, finché non si è confermato che il file si carica senza errori.
- Per capire se un hook `.lua` si è caricato senza errori, controllare il log della partita (`C:\Users\hp\AppData\Roaming\Forged Alliance Forever\logs\game_<id>.log`) cercando `Hooked ... con ...` seguito (o meno) da un eventuale `SCR_LuaDoFileConcat ... failed`.

---

## Catalogo delle possibilità (rilevato il 2026-07-23 dai binari del gioco e dalle mod di esempio)

### Meccanismi usati dalle mod di esempio

| mod | meccanismo | cosa insegna |
|---|---|---|
| MemeSoundEffects, Oof | **Pattern A puro**: solo `hook/units/*` e `hook/projectiles/*` con `Audio = { X = Sound{...} }` + banco custom | è la via più semplice; nessun Lua |
| AnimeSounds | **Pattern B**: `hook/lua/ui/game/gamemain.lua` con `AddBeatFunction` che osserva `Sync.Voice` e reagisce a una cue VO specifica | come agganciarsi a un evento annunciatore; usa `ForkThread`+`WaitSeconds` per ritardare, e `math.random(1,11)` per un **pool casuale lato Lua** |
| ZhanaseeSound | nessun banco: **ripunta il blueprint su una cue vanilla diversa** | conferma che la proprietà "si attenua" vive nel Sound del banco, non nel blueprint |
| BlackOps, TotalMayhem, BattlePack | `self:PlaySound(bp.Audio.X)` dentro script di unità/proiettile | si può far suonare un evento **da codice**, in punti arbitrari della logica |

### Cosa si può modificare (campi `Audio` esistenti nei blueprint vanilla)

Unità: `Fire` (347), `DeathExplosion` (254), `UISelection` (244), `DoneBeingBuilt` (208), `Destroyed` (158), `AmbientMove` (77), `AirUnitWaterImpact` (58), `BarrelStart`, `HoverKilledOnWater`, `MuzzleChargeStart`, `AmbientMoveSub`, `NuclearLaunchDetected`, `BeamStart`, `TeleportChargingAtDestination`, `FootFallGenericSeabed`, `StartMove`/`StopMove`, `ConstructLoop`, `Open`/`Close`, `FireUnderWater`, `ShieldOn`/`ShieldOff`, `Killed`, `ChargeStart`, `ActiveLoop`, `EnterWater`/`ExitWater`, `Unpack`, `Activate`.
Proiettili: `ImpactTerrain` (223), `ImpactWater` (26), `NukeExplosion` (14), `Impact` (4), `ExistLoop`.
**Un blocco `Sound{}` in un blueprint accetta solo tre chiavi: `Bank`, `Cue`, `LodCutoff`.** Niente volume o altro: tutto il resto si controlla nel banco.

### Cosa si può controllare, e dove

| voglio… | dove si fa |
|---|---|
| **volume** del singolo suono | `.xap`, `Sound { Volume = N; }` (centesimi di dB, es. `-600` = −6 dB). Anche `Track { Volume }` e il volume di categoria |
| **attenuazione con la distanza on/off** | presenza o assenza dell'`RPC Entry` sul Sound |
| **quanto/come attenua** | scelta della curva vanilla a cui allinearsi (vedi tabella sotto) |
| **direzionalità** | sorgente **mono** (lo stereo non viene spazializzato) + curva `Angle→Volume` (codice 1437) |
| **taglio netto a distanza X** | `LodCutoff` nel blueprint (`Weapon_LodCutoff`=10000, `UnitRumble_LodCutoff`=256, `WeaponBig_LodCutoff`, `UnitMove_LodCutoff`, `DefaultLodCutoff`) |
| **pool casuale per evento** | `.xap`: più blocchi `Wave Entry` con `Weight` dentro **un solo** `Play Wave Event` — è così che il vanilla fa variare gli impatti (`Impact_Land_Gen_UEF_Big` pesca fra 4 onde). In alternativa, pool lato Lua con `math.random` (vedi AnimeSounds) |
| **condizioni (chi ascolta, alleato/nemico)** | **solo lato UI**: la sim è condivisa e deterministica, quindi `PlaySound` nella sim suona uguale per tutti. Per differenziare per spettatore serve un hook UI + `GetFocusArmy()`, `IsAlly()`, `IsEnemy()`, `IsObserver()`, `GetArmiesTable()`. Costo: il suono UI è 2D, non posizionale |

### Curve `Distance→Volume` disponibili nel `SupCom.xgs` (codici da usare con l'allineamento)

| codice | punti | profilo |
|---|---|---|
| 868 | 5 | ripida: −24 dB già a 794, muta a ~3750 |
| 918 | 5 | dolce e lunga: −10 dB a 543, −25 dB a 4566, muta a 6501 |
| **1050** | 6 | **usata dagli impatti vanilla** (quella del Mavor): +30 dB a 0, −6 dB a 327, −28 dB a 3102, muta a 6129 |
| 1109 | 4 | corto raggio: muta già a ~2457 |
| 1200 | 2 | attenuazione lievissima (−3 dB a 325) |
| 1305 | 5 | cortissimo raggio: muta a ~182 |
| 1487 | 3 | attenua a −46 dB entro 2258 poi resta udibile in lontananza |

Altre curve utili: **1378** `CameraDistance→Volume` (dipende dallo zoom, non dalla posizione), **1437** `Angle→Volume` (direzionalità), **1355** `Duck→Volume` (abbassa il suono quando parla l'annunciatore), **968/1223** `AttackTime` e **1027/1150/1282** `ReleaseTime` (inviluppi).

Le 39 categorie del gioco (`Destroy`, `Weapons`, `Units`, `Interface`, `VO`, `Music`, …) raggruppano i suoni per il mixaggio; la categoria si sceglie nel `.xap` con `Category Entry`.
