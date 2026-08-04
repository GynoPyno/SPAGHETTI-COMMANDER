-- OWPlus Economy Upgrade.lua
-- Sess.94: upgrade in-place di estrattori di massa (T3->T4) e magazzini
-- massa/energia (T1->T2->T3), mod Jaggeds Infrastructure Pack. Stesso pattern
-- gia' validato in 'OWPlus Outpost Defense Upgrade.lua' (PlatoonFormBuilder +
-- Plan='UnitUpgradeAI', IssueUpgrade diretto sull'unita', zero codice custom
-- per l'upgrade in se') ma senza le complicazioni specifiche degli avamposti
-- (nessun FormRadius ristretto, nessuna mappa di ownership per-location: qui
-- il target e' MAIN-wide, coerente col pattern vanilla nativo
-- T1BalancedUpgradeBuilders/T2BalancedUpgradeBuilders).
--
-- Nessun ingegnere consumato: il builder forma un plotone attorno alla
-- struttura bersaglio esistente e le fa auto-issuare l'upgrade su se stessa.

local categories = categories
local OWPlusLogCond = '/mods/AI-Uveso-child/lua/AI/OWPlusLogConditions.lua'

BuilderGroup {
    BuilderGroupName = 'OWPlus Economy Upgrade',
    BuildersType = 'PlatoonFormBuilder',

    Builder {
        BuilderName = 'OWPlus Extractor Upgrade T4',
        PlatoonTemplate = 'OWPlusExtractorUpgradeT4',
        -- Sess.95 (sexies): Priority 18400->18401 -- causa trovata (indagine dedicata):
        -- il builder nativo 'U123 ExtractorUpgrades' (AI-Uveso, Base Mass.lua) ha
        -- ESATTAMENTE la stessa Priority 18400 e usa Plan='PlatoonMerger' con
        -- GlobalSquads{MASSEXTRACTION*(T1+T2+T3), 1, 300, ...} -- raccoglie fino a 300
        -- estrattori in UN SOLO plotone globale ad ogni occasione utile. A parita' di
        -- priorita' quel meccanismo "tutto in un colpo" vince quasi sempre la corsa
        -- contro il nostro (che ne vuole solo 1 alla volta), lasciandoci quasi senza
        -- candidati liberi da reclamare (confermato: solo 2 upgrade tentati in 20 min
        -- su 70-92 candidati disponibili). Priorita' leggermente piu' alta ci fa
        -- valutare per primi, cosi' reclamiamo la nostra unica unita' prima che il
        -- meccanismo nativo spazzi via tutto il resto.
        Priority = 18401,
        InstanceCount = 1,
        BuilderConditions = {
            { OWPlusLogCond, 'OWPlusDebugUpgradeGate', { categories.STRUCTURE * categories.MASSEXTRACTION * categories.TECH3, 0.70, 0.30, 'Extractor Upgrade T4' } },
            -- Sess.95 (ter): trigger a percentuale (80% del pool T2+T3 e' gia' T3),
            -- stesso pattern del salto T1->T2/T2->T3 nativo -- nessun requisito
            -- magazzini per T4 (richiesta esplicita utente). Sostituisce il vecchio
            -- gate di fase (rimosso, legato ai magazzini).
            { OWPlusLogCond, 'OWPlusPopulationShareAtLeast', { 0.80, categories.STRUCTURE * categories.MASSEXTRACTION * categories.TECH3, categories.STRUCTURE * categories.MASSEXTRACTION * (categories.TECH2 + categories.TECH3), 'Extractor T3->T4 trigger' } },
            -- Sess.94: diagnostica temporanea (LOG+true), verifica se il warning nativo
            -- "Can't find StructureUpgradeTemplate" blocca davvero l'upgrade o e' innocuo
            { OWPlusLogCond, 'OWPlusDebugUpgradeProgress', { categories.STRUCTURE * categories.MASSEXTRACTION * categories.TECH3, categories.STRUCTURE * categories.MASSEXTRACTION * categories.EXPERIMENTAL, 'Extractor T3->T4' } },
            -- Sess.95 (quinquies): diagnostica temporanea (LOG+true) -- quanti estrattori
            -- T3 risultano IN PAUSA nell'istante in cui questo builder viene valutato,
            -- per capire se e' quello a spiegare il tasso di successo bassissimo.
            { OWPlusLogCond, 'OWPlusDebugExtractorPauseState', { categories.STRUCTURE * categories.MASSEXTRACTION * categories.TECH3, 'Extractor T3->T4' } },
        },
        BuilderType = 'Any',
    },

    Builder {
        BuilderName = 'OWPlus Mass Storage Upgrade T2',
        PlatoonTemplate = 'OWPlusMassStorageUpgradeT2',
        Priority = 18400,
        InstanceCount = 1,
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
        BuilderConditions = {
            -- Sess.96: stesso gate uniformato del builder T2 sopra (assoluto+ratio)
            { OWPlusLogCond, 'OWPlusMassStorageAbsoluteGate', { categories.STRUCTURE * categories.MASSSTORAGE * categories.TECH2, 500, 0.80, 'Mass Storage Upgrade T3' } },
            -- Sess.96: stessa rimozione del builder T2 sopra
            { OWPlusLogCond, 'OWPlusDebugUpgradeProgress', { categories.STRUCTURE * categories.MASSSTORAGE * categories.TECH2, categories.STRUCTURE * categories.MASSSTORAGE * categories.TECH3, 'Mass Storage T2->T3' } },
        },
        BuilderType = 'Any',
    },

    Builder {
        BuilderName = 'OWPlus Energy Storage Upgrade T2',
        PlatoonTemplate = 'OWPlusEnergyStorageUpgradeT2',
        Priority = 18400,
        InstanceCount = 1,
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
        BuilderConditions = {
            -- Sess.95 (sexies): stessi due vincoli (40000 assoluto + 0.80 ratio) del builder T2 sopra
            { OWPlusLogCond, 'OWPlusEnergyStorageAbsoluteGate', { categories.STRUCTURE * categories.ENERGYSTORAGE * categories.TECH2, 40000, 0.80, 'Energy Storage Upgrade T3' } },
            { OWPlusLogCond, 'OWPlusDebugUpgradeProgress', { categories.STRUCTURE * categories.ENERGYSTORAGE * categories.TECH2, categories.STRUCTURE * categories.ENERGYSTORAGE * categories.TECH3, 'Energy Storage T2->T3' } },
        },
        BuilderType = 'Any',
    },
}
