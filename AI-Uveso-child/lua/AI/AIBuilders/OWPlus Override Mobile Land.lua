-- Override di 'U123 Land Builders ADAPTIVE', 'U123 Land Builders Panic' e 'U1 Land Scout
-- Builders' (stock AI-Uveso) — sess.75: esclude gli avamposti (NotOutpost) per evitare che
-- rubino ingegneri/risorse agli avamposti autonomi OverwhelmPlus. Fedele all'originale
-- (AI-Uveso/lua/AI/AIBuilders/Mobile Land.lua) salvo l'aggiunta della condizione
-- NotOutpost a ogni Builder.

local categories = categories
local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'
local BasePanicZone, BaseMilitaryZone, BaseEnemyZone = import('/mods/AI-Uveso/lua/AI/AITargetManager.lua').GetDangerZoneRadii(true)

local MaxAttackForce = 0.45

if not categories.STEALTHFIELD then categories.STEALTHFIELD = categories.SHIELD end

-- Fase sess.75: esclude gli avamposti (LocationType 'OUT#') da tutti i Builder di questi
-- gruppi stock, cosi' non competono con i BuilderGroup dedicati dell'avamposto per gli
-- ingegneri/fabbriche assegnati alla sua location.
-- Fix sess.76: BuildNotOnLocation (string.find su 'OUT') non funzionava mai — gli
-- avamposti hanno LocationType tipo "Expansion Area U3", mai 'OUT'.
local NotOutpost = { UCBC, 'OWPlusNotOutpostLocation', { 'LocationType' } }

-- ===================================================-======================================================== --
-- ==                                     Adaptive - Land T1 T2 T3 Builder                                   == --
-- ===================================================-======================================================== --
BuilderGroup {
    BuilderGroupName = 'U123 Land Builders ADAPTIVE',
    BuildersType = 'FactoryBuilder',
    -- ============ --
    --    TECH 1    --
    -- ============ --

    -- Terror builder, don't activate !!!
    Builder {
        BuilderName = 'U1A Terror Mobile Arty',
        PlatoonTemplate = 'T1LandArtillery',
        Priority = 0,
        BuilderConditions = {
            NotOutpost,
            { MIBC, 'CanPathToCurrentEnemy', { true, 'LocationType' } },
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
        },
        BuilderType = 'Land',
    },

    Builder {
        BuilderName = 'U1A Tank',
        PlatoonTemplate = 'T1LandDFTank',
        Priority = 150,
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.BuildMobileLandTech1 then
                return 150
            else
                return 0
            end
        end,
        BuilderConditions = {
            NotOutpost,
            { MIBC, 'CanPathToCurrentEnemy', { true, 'LocationType' } },
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.12, 0.30 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 5, categories.MOBILE * categories.ENGINEER - categories.STATIONASSISTPOD - categories.POD } },
            { UCBC, 'HaveUnitRatioVersusEnemy', { 1.0, categories.MOBILE * categories.LAND - categories.ENGINEER, '<=', (categories.MOBILE * categories.LAND * (categories.DIRECTFIRE + categories.INDIRECTFIRE)) } },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'U1A Bot',
        PlatoonTemplate = 'T1LandDFBot',
        Priority = 150,
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.BuildMobileLandTech1 then
                return 150
            else
                return 0
            end
        end,
        BuilderConditions = {
            NotOutpost,
            { MIBC, 'CanPathToCurrentEnemy', { true, 'LocationType' } },
            { MIBC, 'FactionIndex', { 1, 2, 3 , 5 }},
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.12, 0.30 } },
            { UCBC, 'HaveUnitRatioUveso', { 0.2, categories.MOBILE * categories.LAND * categories.BOT * categories.TECH1, '<',categories.MOBILE * categories.LAND * categories.DIRECTFIRE - categories.BOT } },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'U1A Mobile Artillery',
        PlatoonTemplate = 'T1LandArtillery',
        Priority = 150,
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.BuildMobileLandTech1 then
                return 150
            else
                return 0
            end
        end,
        BuilderConditions = {
            NotOutpost,
            { MIBC, 'CanPathToCurrentEnemy', { true, 'LocationType' } },
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.12, 0.30 } },
            { UCBC, 'HaveUnitRatioUveso', { 0.1, categories.MOBILE * categories.LAND * categories.INDIRECTFIRE * categories.TECH1, '<',categories.MOBILE * categories.LAND * categories.DIRECTFIRE } },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'U1A AA',
        PlatoonTemplate = 'T1LandAA',
        Priority = 150,
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.BuildMobileLandTech1 then
                return 150
            else
                return 0
            end
        end,
        BuilderConditions = {
            NotOutpost,
            { MIBC, 'CanPathToCurrentEnemy', { true, 'LocationType' } },
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.12, 0.30 } },
            { UCBC, 'HaveUnitRatioUveso', { 0.05, categories.MOBILE * categories.LAND * categories.ANTIAIR * categories.TECH1, '<',categories.MOBILE * categories.LAND * categories.DIRECTFIRE } },
        },
        BuilderType = 'Land',
    },
    -- ============ --
    --    TECH 2    --
    -- ============ --
    Builder {
        BuilderName = 'U2A DFTank',
        PlatoonTemplate = 'T2LandDFTank',
        Priority = 250,
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.BuildMobileLandTech2 then
                return 250
            else
                return 0
            end
        end,
        BuilderConditions = {
            NotOutpost,
            { MIBC, 'CanPathToCurrentEnemy', { true, 'LocationType' } },
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.12, 0.30 } },
            { UCBC, 'HaveUnitRatioVersusEnemy', { 1.0, categories.MOBILE * categories.LAND - categories.ENGINEER, '<=', (categories.MOBILE * categories.LAND * (categories.DIRECTFIRE + categories.INDIRECTFIRE)) } },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'U2A AttackTank',
        PlatoonTemplate = 'T2AttackTank',
        Priority = 250,
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.BuildMobileLandTech2 then
                return 250
            else
                return 0
            end
        end,
        BuilderConditions = {
            NotOutpost,
            { MIBC, 'CanPathToCurrentEnemy', { true, 'LocationType' } },
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.12, 0.30 } },
            { UCBC, 'HaveUnitRatioVersusEnemy', { 1.0, categories.MOBILE * categories.LAND - categories.ENGINEER, '<=', (categories.MOBILE * categories.LAND * (categories.DIRECTFIRE + categories.INDIRECTFIRE)) } },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'U2A Mobile Artillery',
        PlatoonTemplate = 'T2LandArtillery',
        Priority = 250,
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.BuildMobileLandTech2 then
                return 250
            else
                return 0
            end
        end,
        BuilderConditions = {
            NotOutpost,
            { MIBC, 'CanPathToCurrentEnemy', { true, 'LocationType' } },
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.12, 0.30 } },
            { UCBC, 'HaveUnitRatioUveso', { 0.1, categories.MOBILE * categories.LAND * categories.INDIRECTFIRE * categories.TECH2, '<',categories.MOBILE * categories.LAND * categories.DIRECTFIRE } },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'U2A Mobile AA',
        PlatoonTemplate = 'T2LandAA',
        Priority = 250,
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.BuildMobileLandTech2 then
                return 250
            else
                return 0
            end
        end,
        BuilderConditions = {
            NotOutpost,
            { MIBC, 'CanPathToCurrentEnemy', { true, 'LocationType' } },
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.12, 0.30 } },
            { UCBC, 'HaveUnitRatioUveso', { 0.05, categories.MOBILE * categories.LAND * categories.ANTIAIR * categories.TECH2, '<',categories.MOBILE * categories.LAND * categories.DIRECTFIRE } },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'U2A MobileShields',
        PlatoonTemplate = 'T2MobileShields',
        Priority = 250,
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.BuildMobileLandTech2 or aiBrain.PriorityManager.BuildMobileLandTech3 then
                return 250
            else
                return 0
            end
        end,
        BuilderConditions = {
            NotOutpost,
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.12, 0.30 } },
            { UCBC, 'HaveUnitRatioUveso', { 0.1, (categories.MOBILE * categories.SHIELD) + (categories.MOBILE * categories.STEALTHFIELD), '<',categories.MOBILE * categories.LAND * categories.DIRECTFIRE } },
        },
        BuilderType = 'Land',
    },
    -- ============ --
    --    TECH 3    --
    -- ============ --
    Builder {
        BuilderName = 'U3A Siege Assault Bot',
        PlatoonTemplate = 'T3LandBot',
        Priority = 350,
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.BuildMobileLandTech3 then
                return 350
            else
                return 0
            end
        end,
        BuilderConditions = {
            NotOutpost,
            { MIBC, 'CanPathToCurrentEnemy', { true, 'LocationType' } },
            { MIBC, 'FactionIndex', { 1, 3, 4, 5 }},
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.12, 0.30 } },
            { UCBC, 'HaveUnitRatioVersusEnemy', { 1.0, categories.MOBILE * categories.LAND - categories.ENGINEER, '<=', (categories.MOBILE * categories.LAND * (categories.DIRECTFIRE + categories.INDIRECTFIRE)) } },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'U3A SniperBots',
        PlatoonTemplate = 'T3SniperBots',
        Priority = 350,
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.BuildMobileLandTech3 then
                return 350
            else
                return 0
            end
        end,
        BuilderConditions = {
            NotOutpost,
            { MIBC, 'CanPathToCurrentEnemy', { true, 'LocationType' } },
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.12, 0.30 } },
            { UCBC, 'HaveUnitRatioVersusEnemy', { 1.0, categories.MOBILE * categories.LAND - categories.ENGINEER, '<=', (categories.MOBILE * categories.LAND * (categories.DIRECTFIRE + categories.INDIRECTFIRE)) } },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'U3A ArmoredAssault',
        PlatoonTemplate = 'T3ArmoredAssault',
        Priority = 350,
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.BuildMobileLandTech3 then
                return 350
            else
                return 0
            end
        end,
        BuilderConditions = {
            NotOutpost,
            { MIBC, 'CanPathToCurrentEnemy', { true, 'LocationType' } },
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.12, 0.30 } },
            { UCBC, 'HaveUnitRatioVersusEnemy', { 1.0, categories.MOBILE * categories.LAND - categories.ENGINEER, '<=', (categories.MOBILE * categories.LAND * (categories.DIRECTFIRE + categories.INDIRECTFIRE)) } },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'U3A Mobile Artillery',
        PlatoonTemplate = 'T3LandArtillery',
        Priority = 350,
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.BuildMobileLandTech3 then
                return 350
            else
                return 0
            end
        end,
        BuilderConditions = {
            NotOutpost,
            { MIBC, 'CanPathToCurrentEnemy', { true, 'LocationType' } },
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.12, 0.30 } },
            { UCBC, 'HaveUnitRatioUveso', { 0.1, categories.MOBILE * categories.LAND * categories.INDIRECTFIRE * categories.TECH3, '<',categories.MOBILE * categories.LAND * categories.DIRECTFIRE } },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'U3A Mobile AA MIN',
        PlatoonTemplate = 'T3LandAA',
        Priority = 350,
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.BuildMobileLandTech3 then
                return 350
            else
                return 0
            end
        end,
        BuilderConditions = {
            NotOutpost,
            { MIBC, 'CanPathToCurrentEnemy', { true, 'LocationType' } },
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.12, 0.30 } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 10, categories.MOBILE * categories.LAND * categories.ANTIAIR * categories.TECH3 }},
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'U3A Mobile AA',
        PlatoonTemplate = 'T3LandAA',
        Priority = 350,
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.BuildMobileLandTech3 then
                return 350
            else
                return 0
            end
        end,
        BuilderConditions = {
            NotOutpost,
            { MIBC, 'CanPathToCurrentEnemy', { true, 'LocationType' } },
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.12, 0.30 } },
            { UCBC, 'HaveUnitRatioUveso', { 0.05, categories.MOBILE * categories.LAND * categories.ANTIAIR * categories.TECH3, '<',categories.MOBILE * categories.LAND * categories.DIRECTFIRE } },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'U3A Mobile Shields',
        PlatoonTemplate = 'T3MobileShields',
        Priority = 350,
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.BuildMobileLandTech3 then
                return 350
            else
                return 0
            end
        end,
        BuilderConditions = {
            NotOutpost,
            { MIBC, 'CanPathToCurrentEnemy', { true, 'LocationType' } },
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.12, 0.30 } },
            { UCBC, 'HaveUnitRatioUveso', { 0.1, (categories.MOBILE * categories.SHIELD) + (categories.MOBILE * categories.STEALTHFIELD), '<',categories.MOBILE * categories.LAND * categories.DIRECTFIRE } },
        },
        BuilderType = 'Land',
    },
}
-- ===================================================-======================================================== --
-- ==                                     Land Panic Zone Builder                                            == --
-- ===================================================-======================================================== --
BuilderGroup {
    BuilderGroupName = 'U123 Land Builders Panic',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'U1 PanicZone Mobile Arty extreme',
        PlatoonTemplate = 'T1LandArtillery',
        Priority = 21200,
        BuilderConditions = {
            NotOutpost,
            { MIBC, 'HasNotParagon', {} },
            { UCBC, 'EnemyUnitsGreaterAtLocationRadius', {  BasePanicZone, 'LocationType', 2, categories.MOBILE * categories.LAND - categories.SCOUT - categories.ENGINEER }},
            { UCBC, 'UnitCapCheckLess', { 0.85 } },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'U1 PanicZone Tank Force',
        PlatoonTemplate = 'T1LandDFTank',
        Priority = 21200,
        BuilderConditions = {
            NotOutpost,
            { MIBC, 'HasNotParagon', {} },
            { UCBC, 'EnemyUnitsGreaterAtLocationRadius', {  BasePanicZone, 'LocationType', 2, categories.MOBILE * categories.LAND - categories.SCOUT - categories.ENGINEER }},
            { UCBC, 'UnitCapCheckLess', { 0.85 } },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'U1 PanicZone Bot Force',
        PlatoonTemplate = 'T1LandDFBot',
        Priority = 21100,
        BuilderConditions = {
            NotOutpost,
            { MIBC, 'HasNotParagon', {} },
            { UCBC, 'EnemyUnitsGreaterAtLocationRadius', {  BasePanicZone, 'LocationType', 2, categories.MOBILE * categories.LAND - categories.SCOUT - categories.ENGINEER }},
            { UCBC, 'UnitCapCheckLess', { 0.85 } },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'U1 PanicZone Mobile AA Force',
        PlatoonTemplate = 'T1LandAA',
        Priority = 21300,
        BuilderConditions = {
            NotOutpost,
            { MIBC, 'HasNotParagon', {} },
            { UCBC, 'EnemyUnitsGreaterAtLocationRadius', {  BasePanicZone, 'LocationType', 0, categories.MOBILE * categories.AIR - categories.SCOUT - categories.SATELLITE}},
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 20, categories.ANTIAIR}},
            { UCBC, 'UnitCapCheckLess', { 0.85 } },
        },
        BuilderType = 'Land',
    },
-- ================================== --
--    TECH 2   PanicZone Main Base    --
-- ================================== --
    Builder {
        BuilderName = 'U2R DFTanks PanicZone',
        PlatoonTemplate = 'T2LandDFTank',
        Priority = 21300,
        BuilderConditions = {
            NotOutpost,
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { MIBC, 'HasNotParagon', {} },
            { UCBC, 'EnemyUnitsGreaterAtLocationRadius', {  BasePanicZone, 'LocationType', 1, categories.MOBILE * categories.AIR - categories.SCOUT - categories.SATELLITE}},
            { UCBC, 'UnitCapCheckLess', { 0.90 } },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'U2R ATTTanks PanicZone',
        PlatoonTemplate = 'T2AttackTank',
        Priority = 21300,
        BuilderConditions = {
            NotOutpost,
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { MIBC, 'HasNotParagon', {} },
            { UCBC, 'EnemyUnitsGreaterAtLocationRadius', {  BasePanicZone, 'LocationType', 1, categories.MOBILE * categories.AIR - categories.SCOUT - categories.SATELLITE}},
            { UCBC, 'UnitCapCheckLess', { 0.90 } },
        },
        BuilderType = 'Land',
    },
-- ================================== --
--    TECH 3   PanicZone Main Base    --
-- ================================== --
    Builder {
        BuilderName = 'U3R Siege Assault Bot PanicZone',
        PlatoonTemplate = 'T3LandBot',
        Priority = 21400,
        BuilderConditions = {
            NotOutpost,
            { MIBC, 'FactionIndex', { 1, 3, 4, 5 }},
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { MIBC, 'HasNotParagon', {} },
            { UCBC, 'EnemyUnitsGreaterAtLocationRadius', {  BasePanicZone, 'LocationType', 1, categories.MOBILE * categories.AIR - categories.SCOUT - categories.SATELLITE}},
            { UCBC, 'UnitCapCheckLess', { 0.95 } },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'U3R SniperBots PanicZone',
        PlatoonTemplate = 'T3SniperBots',
        Priority = 21400,
        BuilderConditions = {
            NotOutpost,
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { MIBC, 'HasNotParagon', {} },
            { UCBC, 'EnemyUnitsGreaterAtLocationRadius', {  BasePanicZone, 'LocationType', 1, categories.MOBILE * categories.AIR - categories.SCOUT - categories.SATELLITE}},
            { UCBC, 'UnitCapCheckLess', { 0.95 } },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'U3R ArmoredAssault PanicZone',
        PlatoonTemplate = 'T3ArmoredAssault',
        Priority = 21400,
        BuilderConditions = {
            NotOutpost,
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { MIBC, 'HasNotParagon', {} },
            { UCBC, 'EnemyUnitsGreaterAtLocationRadius', {  BasePanicZone, 'LocationType', 1, categories.MOBILE * categories.AIR - categories.SCOUT - categories.SATELLITE}},
            { UCBC, 'UnitCapCheckLess', { 0.95 } },
        },
        BuilderType = 'Land',
    },
}
-- ===================================================-======================================================== --
-- ==                                       Build T1 Land Scout                                              == --
-- ===================================================-======================================================== --
BuilderGroup {
    BuilderGroupName = 'U1 Land Scout Builders',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'U1R Land Scout',
        PlatoonTemplate = 'T1LandScout',
        Priority = 1000,
        DelayEqualBuildPlattons = {'Scouts', 30},
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.NoRush1stPhaseActive then
                return 0
            else
                return 1000
            end
        end,
        BuilderConditions = {
            NotOutpost,
            { MIBC, 'CanPathToCurrentEnemy', { true, 'LocationType' } },
            { UCBC, 'CheckBuildPlattonDelay', { 'Scouts' }},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 5, categories.MOBILE * categories.ENGINEER - categories.STATIONASSISTPOD - categories.POD }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 6, categories.LAND * categories.SCOUT }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.AIR * categories.SCOUT }},
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, categories.SCOUT * categories.LAND } },
        },
        BuilderType = 'Land',
    },
}
