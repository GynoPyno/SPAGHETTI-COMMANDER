-- Override di 'U1 Air Scout Builders' (stock AI-Uveso) — sess.75: esclude gli avamposti
-- (NotOutpost) per evitare che rubino ingegneri/risorse agli avamposti autonomi
-- OverwhelmPlus. Fedele all'originale (AI-Uveso/lua/AI/AIBuilders/Mobile Air.lua) salvo
-- l'aggiunta della condizione NotOutpost a ogni Builder.
--
-- Nota: questo gruppo e' quello citato nel contesto come motivo "costruire scout invece
-- di restare a costruire/potenziare l'avamposto" — le fabbriche T1/T3 Air di un avamposto
-- venivano dirottate a costruire scout aerei per tutta la mappa.

local categories = categories
local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'
local BasePanicZone, BaseMilitaryZone, BaseEnemyZone = import('/mods/AI-Uveso/lua/AI/AITargetManager.lua').GetDangerZoneRadii()

local MaxAttackForce = 0.45

-- Fase sess.75: esclude gli avamposti (LocationType 'OUT#') da tutti i Builder di questo
-- gruppo stock, cosi' non competono con i BuilderGroup dedicati dell'avamposto per gli
-- ingegneri/fabbriche assegnati alla sua location.
-- Fix sess.76: BuildNotOnLocation (string.find su 'OUT') non funzionava mai — gli
-- avamposti hanno LocationType tipo "Expansion Area U3", mai 'OUT'.
local NotOutpost = { UCBC, 'OWPlusNotOutpostLocation', { 'LocationType' } }

-- ===================================================-======================================================== --
-- ==                                       Build T1/T3 Air Scout                                            == --
-- ===================================================-======================================================== --
BuilderGroup {
    BuilderGroupName = 'U1 Air Scout Builders',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'U1 Air Scout',
        PlatoonTemplate = 'T1AirScout',
        Priority = 20000,
        DelayEqualBuildPlattons = {'Scouts', 10},
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.NoRush1stPhaseActive then
                return 0
            else
                return 20000
            end
        end,
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'CheckBuildPlattonDelay', { 'Scouts' }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 6, categories.AIR * categories.SCOUT }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.FACTORY * categories.AIR * categories.TECH3 } },
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, categories.AIR * categories.SCOUT } },
        },
        BuilderType = 'Air',
    },
    Builder {
        BuilderName = 'U3 Air Scout',
        PlatoonTemplate = 'T3AirScout',
        Priority = 20000,
        DelayEqualBuildPlattons = {'Scouts', 10},
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.NoRush1stPhaseActive then
                return 0
            else
                return 20000
            end
        end,
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'CheckBuildPlattonDelay', { 'Scouts' }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 8, categories.INTELLIGENCE * categories.AIR * categories.TECH3 }},
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, categories.AIR * categories.SCOUT } },
        },
        BuilderType = 'Air',
    },
}
