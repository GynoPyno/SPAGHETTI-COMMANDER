-- OWPlus Forward Extra Factory.lua
-- Fase 9-F7: costruisce la fabbrica terra alle forward base (slot FWD1..FWD4
-- registrati da ExpansionFunction in aiBrain.OWPlusSubBases quando un marker
-- viene accettato).
--
-- Problema risolto: 'OWPlus Forward Land Factory' (builder EngineerBuilder generico
-- Uveso, definito ALLA forward base stessa) non trovava mai un ingegnere disponibile
-- in loco — la forward base ha EngineerCount=0 per design (gli ingegneri vengono da
-- MAIN). Risultato: le condizioni passavano ripetutamente (confermato da LOG
-- OWPlusLogForwardExpansion, ~130 volte in un test) ma nessun ingegnere veniva mai
-- assegnato al platoon, quindi AIExecuteBuildStructure non veniva mai chiamato.
--
-- Soluzione: builder a MAIN (questo file), stesso Plan gia' collaudato per i nodi
-- dispersi (PlatoonTemplate = 'OWPlusDispersedBuilder' -> OWPlusDispersedBuildAI in
-- hook/lua/platoon.lua). Preleva un ingegnere idle da MAIN e lo invia direttamente
-- alle coordinate registrate in OWPlusSubBases['FWDn'], bypassando del tutto la
-- risoluzione location-by-name di Uveso che falliva.

local categories = categories
local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC  = '/lua/editor/EconomyBuildConditions.lua'
local OWPlusLogCond = '/mods/AI-Uveso-child/lua/AI/OWPlusLogConditions.lua'

local ENG = categories.MOBILE * categories.ENGINEER - categories.COMMAND

BuilderGroup {
    BuilderGroupName = 'OWPlus Forward Extra Factory',
    BuildersType = 'EngineerBuilder',

    Builder {
        BuilderName = 'OWPlus Forward Factory FWD1',
        PlatoonTemplate = 'OWPlusDispersedBuilder',
        Priority = 17500,
        InstanceCount = 1,
        BuilderConditions = {
            { OWPlusLogCond, 'OWPlusForwardSlotExists', { 'FWD1' } },
            { UCBC, 'PoolGreaterAtLocation', { 'MAIN', 0, ENG } },
            { EBC,  'GreaterThanEconStorageRatio', { 0.10, 0.20 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                LocationType    = 'FWD1',
                BuildClose      = true,
                BuildStructures = { 'T1LandFactory' },
            }
        },
    },
    Builder {
        BuilderName = 'OWPlus Forward Factory FWD2',
        PlatoonTemplate = 'OWPlusDispersedBuilder',
        Priority = 17500,
        InstanceCount = 1,
        BuilderConditions = {
            { OWPlusLogCond, 'OWPlusForwardSlotExists', { 'FWD2' } },
            { UCBC, 'PoolGreaterAtLocation', { 'MAIN', 0, ENG } },
            { EBC,  'GreaterThanEconStorageRatio', { 0.10, 0.20 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                LocationType    = 'FWD2',
                BuildClose      = true,
                BuildStructures = { 'T1LandFactory' },
            }
        },
    },
    Builder {
        BuilderName = 'OWPlus Forward Factory FWD3',
        PlatoonTemplate = 'OWPlusDispersedBuilder',
        Priority = 17500,
        InstanceCount = 1,
        BuilderConditions = {
            { OWPlusLogCond, 'OWPlusForwardSlotExists', { 'FWD3' } },
            { UCBC, 'PoolGreaterAtLocation', { 'MAIN', 0, ENG } },
            { EBC,  'GreaterThanEconStorageRatio', { 0.10, 0.20 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                LocationType    = 'FWD3',
                BuildClose      = true,
                BuildStructures = { 'T1LandFactory' },
            }
        },
    },
    Builder {
        BuilderName = 'OWPlus Forward Factory FWD4',
        PlatoonTemplate = 'OWPlusDispersedBuilder',
        Priority = 17500,
        InstanceCount = 1,
        BuilderConditions = {
            { OWPlusLogCond, 'OWPlusForwardSlotExists', { 'FWD4' } },
            { UCBC, 'PoolGreaterAtLocation', { 'MAIN', 0, ENG } },
            { EBC,  'GreaterThanEconStorageRatio', { 0.10, 0.20 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                LocationType    = 'FWD4',
                BuildClose      = true,
                BuildStructures = { 'T1LandFactory' },
            }
        },
    },
}
