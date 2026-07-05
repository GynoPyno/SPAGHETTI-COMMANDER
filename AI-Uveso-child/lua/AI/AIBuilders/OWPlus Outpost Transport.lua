-- OWPlus Outpost Transport.lua
-- Fase 9-F24: pool dedicato di trasporti T1 per gli ingegneri avamposto (OUT#).
--
-- Motivazione (sess.66): il 91% delle rivendicazioni avamposto falliva per timeout
-- (l'ingegnere non arrivava mai a destinazione entro 180s), con ZERO fallimenti
-- reali di FindPlaceToBuild — sintomo di un problema di spostamento/percorso, non
-- di terreno. Soluzione proposta dall'utente: usare i trasporti aerei, gia'
-- supportati da Uveso tramite self:MoveToLocationInclTransport (vedi platoon.lua,
-- chiamata aggiunta in OWPlusDispersedBuildAI per gli avamposti OUT#).
--
-- Il pool standard di Uveso ('U123 Air Transport Builders', gia' nel template)
-- mantiene fino a 3 trasporti di scorta e fino a 10 totali, condivisi con TUTTO
-- il resto dell'esercito (attacchi, altre espansioni). Questo builder aggiunge
-- una scorta ULTERIORE dedicata, cosi' gli ingegneri avamposto competono meno
-- con il resto dell'AI per lo stesso trasporto. NOTA: non e' una riserva vera e
-- propria — la funzione di motore che assegna i trasporti (SendPlatoonWithTransportsNoCheck)
-- prende il primo disponibile per categoria, senza distinguere "chi l'ha costruito".
-- Questo builder alza solo la quantita' totale disponibile, riducendo la scarsita'.
--
-- Si attiva SOLO quando c'e' almeno un avamposto non ancora rivendicato
-- (OWPlusHasUnclaimedOutpost) — niente scorta di trasporti se la fase di
-- espansione avamposti e' esaurita.

local categories = categories
local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC  = '/lua/editor/EconomyBuildConditions.lua'
local OWPlusLogCond = '/mods/AI-Uveso-child/lua/AI/OWPlusLogConditions.lua'

BuilderGroup {
    BuilderGroupName = 'OWPlus Outpost Transport',
    BuildersType = 'FactoryBuilder',

    Builder {
        BuilderName = 'OWPlus Outpost Transport Pool',
        PlatoonTemplate = 'T1AirTransport',
        Priority = 450,
        BuilderConditions = {
            { OWPlusLogCond, 'OWPlusHasUnclaimedOutpost', {} },
            { UCBC, 'BuildOnlyOnLocation', { 'LocationType', 'MAIN' } },
            { EBC,  'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC,  'GreaterThanEconStorageRatio', { 0.10, 0.95 } },
            -- Fase 9-F24: mantiene 4 trasporti aggiuntivi di scorta (oltre ai 3
            -- del pool standard Uveso), fino a un tetto totale di 12 (contro i
            -- 10 dello standard) cosi' il nostro builder non si blocca subito
            -- contro il tetto altrui.
            { UCBC, 'PoolLessAtLocation', { 'LocationType', 4, categories.MOBILE * categories.AIR * categories.TRANSPORTFOCUS - categories.uea0203 } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 12, categories.MOBILE * categories.AIR * categories.TRANSPORTFOCUS - (categories.uea0203 + categories.EXPERIMENTAL) } },
        },
        BuilderType = 'Air',
    },
}
