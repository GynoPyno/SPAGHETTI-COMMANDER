-- OWPlus Economy Upgrade.lua
-- Sess.94: upgrade in-place di magazzini massa/energia (T1->T2->T3->T4), mod
-- Jaggeds Infrastructure Pack. Stesso pattern gia' validato in 'OWPlus Outpost
-- Defense Upgrade.lua' (PlatoonFormBuilder + Plan='UnitUpgradeAI', IssueUpgrade
-- diretto sull'unita', zero codice custom per l'upgrade in se').
--
-- Nessun ingegnere consumato: il builder forma un plotone attorno alla
-- struttura bersaglio esistente e le fa auto-issuare l'upgrade su se stessa.
--
-- Sess.98: RIMOSSO il builder 'OWPlus Extractor Upgrade T4' (estrattori
-- massa T3->T4) che viveva qui dalla sess.94 -- causa reale finalmente trovata
-- leggendo il motore (lua/sim/PlatoonFormManager.lua, hook diagnostico
-- dedicato): poolPlatoon:CanFormPlatoon(...) tornava SEMPRE false per questo
-- builder (confermato con radius=10000 esplicito, 16 minuti di test reale,
-- zero eccezioni), a differenza dei builder magazzino qui sotto (identici
-- Plan='UnitUpgradeAI'+FactionSquads, ma funzionanti) -- causa strutturale
-- non identificabile a livello Lua (funzione nativa/compilata). L'upgrade
-- estrattori T3->T4 e' stato spostato su un meccanismo diverso, PROVATO
-- funzionante per lo stesso tipo di unita' (T1->T2->T3 nativo): l'override
-- di 'ExtractorUpgradeAI' in hook/lua/platoon.lua (AI-Uveso-child), esteso
-- con un terzo ramo TECH3->TECH4 accanto a quelli T1->T2/T2->T3 gia'
-- esistenti -- vedi commento li' per i dettagli del meccanismo (IssueUpgrade
-- diretto su una lista GLOBALE di unita', mai passa da CanFormPlatoon).
--
-- Sess.97: CORREZIONE al commento originale sopra ("nessun FormRadius
-- ristretto... target MAIN-wide") -- era un'assunzione SBAGLIATA: omettere
-- FormRadius NON significa "nessun limite" -- significa usare self.Radius del
-- BuilderManager (MAIN, tipicamente <=120) come raggio di ricerca candidati
-- (poolPlatoon:CanFormPlatoon/FormPlatoon(template, 1, self.Location, radius)).
-- Aggiunto FormRadius=10000 a tutti i builder magazzino sotto (stesso valore
-- del nativo 'U123 ExtractorUpgrades') -- restano lontani da MAIN anche dopo
-- il fix avamposti sess.97 (OWPlus Outpost Mass Storage Adjacency).

local categories = categories
local OWPlusLogCond = '/mods/AI-Uveso-child/lua/AI/OWPlusLogConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local UCBC = '/lua/editor/UnitCountBuildConditions.lua'

BuilderGroup {
    BuilderGroupName = 'OWPlus Economy Upgrade',
    BuildersType = 'PlatoonFormBuilder',

    Builder {
        BuilderName = 'OWPlus Mass Storage Upgrade T2',
        PlatoonTemplate = 'OWPlusMassStorageUpgradeT2',
        Priority = 18400,
        InstanceCount = 1,
        FormRadius = 10000,
        BuilderConditions = {
            -- Sess.96: ratio-only (0.70/0.30) -> gate uniformato a quello dei
            -- magazzini energia, valore ASSOLUTO (500 massa stoccata) E ratio
            -- (0.80) insieme -- richiesta esplicita utente, soglie di partenza
            -- da affinare.
            { OWPlusLogCond, 'OWPlusMassStorageAbsoluteGate', { categories.STRUCTURE * categories.MASSSTORAGE * categories.TECH1, 500, 0.80, 'Mass Storage Upgrade T2' } },
            -- Sess.96: rimosso il gate di popolazione estrattori T3 80%
            -- (OWPlusPopulationShareAtLeast, introdotto sess.95 quinquies) --
            -- richiesta esplicita utente, ora simmetrico ai magazzini energia:
            -- il potenziamento dipende solo dal gate economico sopra.
            { OWPlusLogCond, 'OWPlusDebugUpgradeProgress', { categories.STRUCTURE * categories.MASSSTORAGE * categories.TECH1, categories.STRUCTURE * categories.MASSSTORAGE * categories.TECH2, 'Mass Storage T1->T2' } },
        },
        BuilderType = 'Any',
    },

    Builder {
        BuilderName = 'OWPlus Mass Storage Upgrade T3',
        PlatoonTemplate = 'OWPlusMassStorageUpgradeT3',
        Priority = 18400,
        InstanceCount = 1,
        FormRadius = 10000,
        BuilderConditions = {
            -- Sess.96: stesso gate uniformato del builder T2 sopra (assoluto+ratio)
            { OWPlusLogCond, 'OWPlusMassStorageAbsoluteGate', { categories.STRUCTURE * categories.MASSSTORAGE * categories.TECH2, 500, 0.80, 'Mass Storage Upgrade T3' } },
            -- Sess.96: stessa rimozione del builder T2 sopra
            { OWPlusLogCond, 'OWPlusDebugUpgradeProgress', { categories.STRUCTURE * categories.MASSSTORAGE * categories.TECH2, categories.STRUCTURE * categories.MASSSTORAGE * categories.TECH3, 'Mass Storage T2->T3' } },
        },
        BuilderType = 'Any',
    },

    Builder {
        -- Sess.97: nuovo, richiesta esplicita utente -- il magazzino ibrido
        -- Massa+Energia T4 (bab1106 & co., mod Jaggeds) non aveva NESSUN builder
        -- AI a guidarne l'upgrade dal magazzino massa T3 (verificato: zero
        -- riferimenti a bab1106/beb1106/brb1106/bsb1106 in tutto AI-Uveso-child
        -- prima di questa modifica) -- l'upgrade funzionava solo se avviato a
        -- mano dal giocatore. Stesso gate economico gia' uniformato di
        -- Mass/Energy Storage Upgrade T2/T3 (assoluto+ratio), nessun builder
        -- nativo compete per questa categoria (catena inesistente fuori da
        -- Jaggeds) -- InstanceCount=5 comunque, stessa lezione del fix sopra.
        BuilderName = 'OWPlus Mass Storage Upgrade T4',
        PlatoonTemplate = 'OWPlusMassStorageUpgradeT4',
        Priority = 18400,
        InstanceCount = 5,
        FormRadius = 10000,
        BuilderConditions = {
            { OWPlusLogCond, 'OWPlusMassStorageAbsoluteGate', { categories.STRUCTURE * categories.MASSSTORAGE * categories.TECH3, 500, 0.80, 'Mass Storage Upgrade T4' } },
            -- Categoria destinazione: MASSSTORAGE*ENERGYSTORAGE insieme -- unico
            -- identificatore pulito per il T4 ibrido, che non ha categoria
            -- EXPERIMENTAL (TechLevel='RULEUTL_Secret', non TECH4 nativo).
            { OWPlusLogCond, 'OWPlusDebugUpgradeProgress', { categories.STRUCTURE * categories.MASSSTORAGE * categories.TECH3, categories.STRUCTURE * categories.MASSSTORAGE * categories.ENERGYSTORAGE, 'Mass Storage T3->T4' } },
        },
        BuilderType = 'Any',
    },

    Builder {
        BuilderName = 'OWPlus Energy Storage Upgrade T2',
        PlatoonTemplate = 'OWPlusEnergyStorageUpgradeT2',
        Priority = 18400,
        InstanceCount = 1,
        FormRadius = 10000,
        BuilderConditions = {
            -- Sess.95 (quinquies): ratio (0.70/0.80) -> valore ASSOLUTO (40000 energia
            -- stoccata) -- una ratio alta puo' essere vera anche con poca energia
            -- stoccata in termini reali, se la capacita' e' ancora piccola.
            -- Sess.95 (sexies): il solo assoluto si e' rivelato irrisorio con
            -- l'economia scalata del test (storage a 2+ milioni) -- ENTRAMBI i
            -- vincoli richiesti insieme (assoluto E ratio 0.80), non uno o l'altro.
            { OWPlusLogCond, 'OWPlusEnergyStorageAbsoluteGate', { categories.STRUCTURE * categories.ENERGYSTORAGE * categories.TECH1, 40000, 0.80, 'Energy Storage Upgrade T2' } },
            { OWPlusLogCond, 'OWPlusDebugUpgradeProgress', { categories.STRUCTURE * categories.ENERGYSTORAGE * categories.TECH1, categories.STRUCTURE * categories.ENERGYSTORAGE * categories.TECH2, 'Energy Storage T1->T2' } },
        },
        BuilderType = 'Any',
    },

    Builder {
        BuilderName = 'OWPlus Energy Storage Upgrade T3',
        PlatoonTemplate = 'OWPlusEnergyStorageUpgradeT3',
        Priority = 18400,
        InstanceCount = 1,
        FormRadius = 10000,
        BuilderConditions = {
            -- Sess.95 (sexies): stessi due vincoli (40000 assoluto + 0.80 ratio) del builder T2 sopra
            { OWPlusLogCond, 'OWPlusEnergyStorageAbsoluteGate', { categories.STRUCTURE * categories.ENERGYSTORAGE * categories.TECH2, 40000, 0.80, 'Energy Storage Upgrade T3' } },
            { OWPlusLogCond, 'OWPlusDebugUpgradeProgress', { categories.STRUCTURE * categories.ENERGYSTORAGE * categories.TECH2, categories.STRUCTURE * categories.ENERGYSTORAGE * categories.TECH3, 'Energy Storage T2->T3' } },
        },
        BuilderType = 'Any',
    },

    -- Sess.98 (bis): RISCRITTO -- il vecchio Plan='UnitUpgradeAI' (PlatoonTemplate
    -- 'OWPlusEnergyGeneratorUpgradeT4') mostrava lo stesso identico sintomo
    -- CanFormPlatoon=sempre-falso gia' isolato per gli estrattori: gate
    -- economico vero e stabile per 20+ minuti (log confermato, sess.98 bis),
    -- 12 candidati T3 liberi, inUpgrade=0, eppure zero nuovi upgrade tentati.
    -- Sostituito con lo stesso meccanismo Plan='PlatoonMerger'+AIPlan gia'
    -- usato con successo dagli estrattori (nativo Uveso, 'Base Mass.lua') --
    -- MAI passa da CanFormPlatoon. Il gate economico (OWPlusEnergyStorageAbsoluteGate)
    -- ora vive DENTRO 'OWPlusEnergyGeneratorUpgrade' (hook/lua/platoon.lua),
    -- chiamato dal loop 'OWPlusEnergyGeneratorUpgradeAI' -- qui restano solo
    -- le condizioni minime per formare/espandere il plotone merger iniziale,
    -- stesso pattern del builder nativo 'Extractor upgrade >40 mass'.
    --
    -- NOTA: a differenza del magazzino ibrido T4 (Jaggeds, distinguibile da T3
    -- via MASSSTORAGE*ENERGYSTORAGE insieme), il T4 generatore qui ha
    -- Categories IDENTICHE al T3 (stesso schema Jaggeds: 'TECH3' non 'TECH4',
    -- non esiste) -- nessun modo pulito di isolarlo via categoria per un
    -- diagnostico sorgente/destinazione separato. La verifica di progresso
    -- passa dal log dedicato sotto (`OWPlusDebugEnergyGeneratorT4Progress`).
    Builder {
        BuilderName = 'OWPlus Energy Generator Upgrade T4',
        PlatoonTemplate = 'AddToEnergyGeneratorUpgradePlatoon',
        Priority = 18400,
        InstanceCount = 1,
        FormRadius = 10000,
        BuilderConditions = {
            { EBC, 'GreaterThanEconIncome', { 4.0, -0.0 } },
            { UCBC, 'HaveGreaterThanArmyPoolWithCategory', { 0, categories.STRUCTURE * categories.ENERGYPRODUCTION * categories.TECH3 } },
            { UCBC, 'GreaterThanGameTimeSeconds', { 1 * 60 } },
            -- Sess.98: diagnostica dedicata (distingue T3/T4 per ID esatto,
            -- vedi OWPlusLogConditions.lua per il motivo) -- richiesta
            -- esplicita utente prima del test di verifica.
            { OWPlusLogCond, 'OWPlusDebugEnergyGeneratorT4Progress', { categories.STRUCTURE * categories.ENERGYPRODUCTION * categories.TECH3, 'Energy Generator T3->T4' } },
        },
        BuilderData = {
            AIPlan = 'OWPlusEnergyGeneratorUpgradeAI',
        },
        BuilderType = 'Any',
    },
}
