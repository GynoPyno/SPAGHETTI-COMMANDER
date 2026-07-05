-- OWPlus Outpost Factory.lua
-- Fase 9-F18: sostituisce 'OWPlus Forward Extra Factory.lua' (slot fissi FWD1-4,
-- popolati da marker di scena). Builder a MAIN che rivendica dinamicamente un
-- avamposto generato da OWPlusOutpostGenerator.lua (slot 'OUT#', numero illimitato,
-- generati lungo 8 direzioni fisse senza dipendenza da marker Uveso).
--
-- Construction.LocationType = 'OWPlusOutpostPool' e' un sentinel — non e' una
-- location fissa, dice a OWPlusDispersedBuildAI (hook/lua/platoon.lua) di scegliere
-- dinamicamente il primo slot OUT# non ancora rivendicato, usando la sua ricetta
-- di fabbriche (scelta a caso alla generazione) + le difese elencate qui sotto.
--
-- InstanceCount alto: piu' ingegneri possono essere inviati in parallelo a
-- rivendicare avamposti diversi, dato che possono essere molti (nessun tetto
-- nel generatore).

local categories = categories
local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC  = '/lua/editor/EconomyBuildConditions.lua'
local OWPlusLogCond = '/mods/AI-Uveso-child/lua/AI/OWPlusLogConditions.lua'

local ENG = categories.MOBILE * categories.ENGINEER - categories.COMMAND

BuilderGroup {
    BuilderGroupName = 'OWPlus Outpost Factory',
    BuildersType = 'EngineerBuilder',

    Builder {
        BuilderName = 'OWPlus Outpost Factory Claim',
        PlatoonTemplate = 'OWPlusDispersedBuilder',
        Priority = 17500,
        InstanceCount = 6,
        BuilderConditions = {
            { OWPlusLogCond, 'OWPlusHasUnclaimedOutpost', {} },
            { UCBC, 'PoolGreaterAtLocation', { 'MAIN', 0, ENG } },
            { EBC,  'GreaterThanEconStorageRatio', { 0.10, 0.20 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                LocationType    = 'OWPlusOutpostPool',
                BuildClose      = true,
                -- Solo le difese: la ricetta di fabbriche viene anteposta
                -- dinamicamente da OWPlusDispersedBuildAI in base allo slot scelto.
                -- Fase 9-F20: 'T2ShieldDefense' rimosso — richiede un ingegnere T2
                -- (confermato in log: "TECH1 Unit assigned to build TECH2
                -- buildplatoon! FAILED"), ma l'ingegnere inviato da MAIN e' sempre
                -- T1. Lo scudo arrivera' dopo, quando il BuilderManager dedicato
                -- (9-F19/20) e' agganciato correttamente e la fabbrica sale di
                -- tech producendo un proprio ingegnere T2.
                BuildStructures = { 'T1GroundDefense', 'T1AADefense' },
            }
        },
    },
}
