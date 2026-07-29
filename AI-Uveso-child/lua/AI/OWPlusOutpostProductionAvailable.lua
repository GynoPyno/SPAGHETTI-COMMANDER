-- OWPlusOutpostProductionAvailable.lua
-- Fase D1 (B24), 2026-07-29: tabella statica precomputata dal catalogo unita' di terra --
-- 'questa categoria ha ALMENO un'unita' (vanilla o modded) per questa fazione a questo
-- tier?'. Sostituisce la chiamata a GetFactoryTemplate dentro OWPlusOutpostEffectiveType
-- (OWPlusLogConditions.lua): con decine di candidati per cella, interrogare il motore
-- per ognuno solo per rispondere si/no e' inutile -- lo sappiamo gia' in fase di
-- generazione dai dati del catalogo. Aggiornare a mano se si aggiungono/rimuovono
-- candidati in OWPlus Outpost Production.lua senza rigenerare lo script.
OWPlusProductionAvailable = {
    bot = {
        [1] = { UEF = true, Aeon = true, Cybran = true, Seraphim = true },
        [2] = { UEF = true, Aeon = true, Cybran = true, Seraphim = true },
        [3] = { UEF = true, Aeon = true, Cybran = true, Seraphim = true },
    },
    tank = {
        [1] = { UEF = true, Aeon = true, Cybran = true, Seraphim = true },
        [2] = { UEF = true, Aeon = true, Cybran = true, Seraphim = true },
        [3] = { UEF = true, Aeon = false, Cybran = true, Seraphim = true },
    },
    artillery = {
        [1] = { UEF = true, Aeon = true, Cybran = true, Seraphim = true },
        [2] = { UEF = true, Aeon = true, Cybran = true, Seraphim = true },
        [3] = { UEF = true, Aeon = true, Cybran = true, Seraphim = true },
    },
}
