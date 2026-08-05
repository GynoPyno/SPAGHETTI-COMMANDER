-- OWPlus Outpost Mass Storage Adjacency.lua
-- Sess.97: gemello di 'OWPlus Mass Storage Adjacency' (OWPlus Economy.lua),
-- registrato per ogni avamposto invece che solo su MAIN.
--
-- Causa del bug segnalato dall'utente (confermato leggendo il codice nativo
-- Uveso, non ipotesi): AdjacencyCheck (/lua/editor/UnitCountBuildConditions.lua)
-- calcola la distanza dal punto BASE del BuilderManager (factoryManager:
-- GetLocationCoords()), NON dalla posizione dell'ingegnere ne' con scansione
-- mappa intera. 'OWPlus Mass Storage Adjacency' e' registrato SOLO nel
-- template MAIN (Uveso MainBase OverwhelmPlus.lua) -- quindi la condizione
-- "estrattore T2/T3 entro 60 unita'" viene controllata SOLO entro 60 unita'
-- da MAIN, mai da un estrattore lontano o da un avamposto vicino ad esso.
-- Comportamento nativo pre-esistente (anche 'U1 MassStorage Builder' originale,
-- Base Mass.lua, ha la stessa limitazione) -- mai corretto perche' i
-- generatori di energia (bersaglio del builder gemello energia) tendono a
-- clusterizzare vicino a MAIN per natura, mentre gli estrattori di massa sono
-- vincolati a depositi fissi sparsi per la mappa.
--
-- Fix: stesso builder, stesso AdjacencyDistance=60, ma con placeholder
-- generico 'LocationType' (gia' presente nell'originale, MAI hardcoded su
-- 'MAIN') registrato anche per ogni avamposto via AddGlobalBuilderGroup
-- (platoon.lua, OWPlusDispersedBuildAI) -- ogni avamposto controlla i 60
-- unita' intorno a SE STESSO, non solo intorno a MAIN. Stesso pattern gia'
-- in uso per 'OWPlus Outpost Factory Upgrade'/'OWPlus Outpost Defense Upgrade'.
--
-- Throttle di costruzione (OWPlusMassStorageBuildThrottle/OWPlusMassStorageEligible)
-- restano condivisi a livello di ARMATA (non per-location) -- nessuna modifica
-- necessaria, il tetto proporzionale sul totale estrattori resta valido
-- indipendentemente da dove viene costruito il magazzino.

local categories = categories
local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local OWPlusLogCond = '/mods/AI-Uveso-child/lua/AI/OWPlusLogConditions.lua'

local MaxCapMass = 0.10

BuilderGroup {
    BuilderGroupName = 'OWPlus Outpost Mass Storage Adjacency',
    BuildersType = 'EngineerBuilder',

    Builder {
        BuilderName = 'OWPlus Outpost Mass Storage T1 Eng',
        PlatoonTemplate = 'EngineerBuilder',
        Priority = 17879,
        DelayEqualBuildPlattons = { 'MASSSTORAGE', 5 },
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.HasParagon then
                return 0
            else
                return 17879
            end
        end,
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay',           { 'MASSSTORAGE' }},
            { EBC,  'GreaterThanEconStorageRatio',      { 0.1, 0.50 } },
            { OWPlusLogCond, 'OWPlusMassStorageBuildThrottle', { 'Outpost Mass Storage T1' } },
            { UCBC, 'HaveUnitRatioVersusCap',           { MaxCapMass, '<', categories.STRUCTURE * (categories.MASSEXTRACTION + categories.MASSFABRICATION + categories.MASSSTORAGE) }},
            { UCBC, 'AdjacencyCheck',                   { 'LocationType', categories.STRUCTURE * categories.MASSEXTRACTION * (categories.TECH2 + categories.TECH3), 60, 'ueb1106' }},
            { OWPlusLogCond, 'OWPlusMassStorageEligible', { 'Outpost Mass Storage T1 Build' } },
        },
        BuilderData = {
            Construction = {
                AdjacencyCategory = categories.STRUCTURE * categories.MASSEXTRACTION * (categories.TECH2 + categories.TECH3),
                AdjacencyDistance = 60,
                BuildClose = false,
                BuildStructures = { 'MassStorage' },
            }
        },
        BuilderType = 'Any',
    },

    Builder {
        BuilderName = 'OWPlus Outpost Mass Storage T2 Eng',
        PlatoonTemplate = 'T2EngineerBuilder',
        Priority = 17878,
        DelayEqualBuildPlattons = { 'MASSSTORAGE', 5 },
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.HasParagon then
                return 0
            else
                return 17878
            end
        end,
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay',           { 'MASSSTORAGE' }},
            { EBC,  'GreaterThanEconStorageRatio',      { 0.1, 0.50 } },
            { OWPlusLogCond, 'OWPlusMassStorageBuildThrottle', { 'Outpost Mass Storage T2' } },
            { UCBC, 'AdjacencyCheck',                   { 'LocationType', categories.MASSEXTRACTION * categories.TECH3, 60, 'ueb1106' }},
            { UCBC, 'HaveUnitRatioVersusCap',           { MaxCapMass, '<', categories.STRUCTURE * (categories.MASSEXTRACTION + categories.MASSFABRICATION + categories.MASSSTORAGE) }},
            { OWPlusLogCond, 'OWPlusMassStorageEligible', { 'Outpost Mass Storage T2 Build' } },
        },
        BuilderData = {
            Construction = {
                AdjacencyCategory = 'MASSEXTRACTION TECH3',
                AdjacencyDistance = 60,
                BuildClose = false,
                BuildStructures = { 'MassStorage' },
            }
        },
        BuilderType = 'Any',
    },
}
