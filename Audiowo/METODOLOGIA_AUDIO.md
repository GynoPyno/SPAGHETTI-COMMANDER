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

## Attenuazione del volume in base alla distanza dalla camera — TENTATIVO FALLITO, non riprovare a mano

**Sintomo (2026-07-19)**: un suono custom (Pattern A, `EntityPlaySound`) ha panning direzionale corretto (si sente da che lato arriva rispetto all'inquadratura), ma **il volume resta sempre al massimo indipendentemente dalla distanza** dalla camera — a differenza dei suoni vanilla, che si affievoliscono con la distanza (confermato anche da segnalazioni della community FAF: mod audio "grezze" come Total Mayhem hanno lo stesso problema, "not attenuated by camera distance", a differenza della maggior parte dei suoni originali del gioco).

**Causa (teoria, non del tutto confermata)**: il panning/posizionamento 3D è calcolato in automatico dal motore quando il suono è legato a un'entità (`EntityPlaySound`), mentre l'attenuazione del volume richiederebbe una curva **RPC (Runtime Parameter Control)** nel banco XACT che mappa la variabile riservata `Distance` sul parametro `Volume` del Sound — dato che i banchi vanilla (compilati da GPG con la vera XACT Studio) probabilmente hanno e il nostro `Audiowo.xap` (scritto a mano) no.

**Tentativo fatto e FALLITO**: aggiunta a mano nel testo di `Audiowo.xap` una `Variable { Name = Distance; Reserved = 1; ... }` in `Global Settings`, un blocco `RPC { RPC Curve { Property = 0; Variable Entry { Name = Distance; } RPC Point {...} } }`, e agganciata con `RPC Entry`/`RPC Curve Entry` al sound `mavor_impact`. **`XactBld.exe` ha compilato tutto senza errori** (build "Success!"), ma **in game l'intero Sound Bank `Audiowo.xsb` ha smesso di caricarsi**: `warning: Error loading soundbank '/sounds/audiowo.xsb': Invalid data` nel log partita (`C:\Users\hp\AppData\Roaming\Forged Alliance Forever\logs\game_<id>.log`). Risultato: **non solo il nuovo suono non ha funzionato, ma sono spariti anche morte ACU, upgrade ACU e allarme nuke**, perché condividono lo stesso file `.xsb`. XactBld accetta la sintassi testuale ma il motore di gioco (versione XACT più vecchia/diversa, `xactengine2_9.dll`) rifiuta il binario compilato come "Invalid data" — la nostra sintassi RPC scritta a mano, pur sintatticamente valida per il compilatore, produce un binario che il runtime del gioco non accetta (mancano probabilmente campi/metadati che la vera XACT Studio genera automaticamente e che non sono documentati nel formato testuale `.xap`).

**Rollback eseguito**: rimossi `Variable{Distance}`, il blocco `RPC{...}`, e i riferimenti `RPC Entry`/`RPC Curve Entry` da `Audiowo.xap`. Ricompilato e ridistribuito — il Sound Bank torna a caricarsi come prima (nessuna curva RPC, nessun campo `RPC`/`Variable` nel progetto).

**Se si vuole riprovare in futuro**: NON riscrivere a mano i blocchi `RPC`/`Variable` nel `.xap` — il rischio è di rompere l'intero banco (tutti gli eventi, non solo quello nuovo) in un modo che il compilatore non segnala. Servirebbe usare la vera GUI **XACT Studio** (`Xact.exe`, nella stessa cartella di `XactBld.exe`: `C:\Program Files (x86)\Microsoft DirectX SDK (August 2007)\Utilities\Bin\x86\Xact.exe`) per costruire l'RPC tramite editor visuale (Variable=Distance, Object=Sound, Parameter=Volume, poi "Attach/Detach RPC" sul sound) — l'editor genera i metadati corretti che a mano non siamo riusciti a replicare. Questo richiede intervento manuale dell'utente nella GUI (non scriptabile da qui), poi si torna a compilare con `XactBld.exe` da PowerShell come sempre. **Prima di riprovare, testare SEMPRE in game su un solo evento alla volta e controllare subito il log per `Error loading soundbank` prima di considerare il resto della sessione di test valido** — un fallimento qui azzera silenziosamente tutti gli altri eventi della mod.

---

## Regole trasversali per qualunque hook `.lua`

- Gli hook su file `.lua` (es. `hook/lua/UserSync.lua`, `hook/lua/ui/game/gamemain.lua`) **non sono un sistema di override separato**: il motore fa una **concatenazione testuale** — il contenuto del file della mod viene incollato in coda al file vanilla originale, e il risultato compilato come blocco unico. Per questo un file può limitarsi a poche righe aggiuntive (il codice vanilla gira comunque per intero).
- **Un banale errore di sintassi in un hook `.lua` può causare un crash del motore**, non solo un errore recuperabile — confermato con l'uso di `...` (vararg) in un contesto che ha reso l'intero file concatenato non compilabile. Regole pratiche:
  - Evitare `...` (vararg) quando si conosce già la firma esatta della funzione da wrappare — usare parametri nominati.
  - Usare solo costrutti già visti funzionare nel codice vanilla circostante (for-in, if/then/else, `table.insert`, riassegnazione di funzione globale).
  - Testare in partita locale/sandbox, non in ranked, finché non si è confermato che il file si carica senza errori.
- Per capire se un hook `.lua` si è caricato senza errori, controllare il log della partita (`C:\Users\hp\AppData\Roaming\Forged Alliance Forever\logs\game_<id>.log`) cercando `Hooked ... con ...` seguito (o meno) da un eventuale `SCR_LuaDoFileConcat ... failed`.
