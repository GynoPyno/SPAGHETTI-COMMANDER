-- Override di 'U1 Factory Builders Expansions' e 'U123 Factory Upgrader Rush' (stock
-- AI-Uveso) — sess.75: esclude gli avamposti (NotOutpost) per evitare che rubino
-- ingegneri/risorse agli avamposti autonomi OverwhelmPlus. Fedele all'originale
-- (AI-Uveso/lua/AI/AIBuilders/Base Factory.lua) salvo l'aggiunta della condizione
-- NotOutpost a ogni Builder.

local categories = categories
local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'

local MaxCapFactory = 0.024
local MaxCapStructure = 0.12

-- Fase sess.75: esclude gli avamposti (LocationType 'OUT#') da tutti i Builder di questi
-- gruppi stock, cosi' non competono con i BuilderGroup dedicati dell'avamposto per gli
-- ingegneri/fabbriche assegnati alla sua location.
-- Fix sess.76: BuildNotOnLocation (string.find su 'OUT') non funzionava mai — gli
-- avamposti hanno LocationType tipo "Expansion Area U3", mai 'OUT'.
local NotOutpost = { UCBC, 'OWPlusNotOutpostLocation', { 'LocationType' } }

-- ============================ --
--    Builder for Expansions    --
-- ============================ --
BuilderGroup {
    BuilderGroupName = 'U1 Factory Builders Expansions',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'U1 Land Factory Expansions',
        PlatoonTemplate = 'EngineerBuilder',
        Priority = 17500,
        InstanceCount = 1,
        DelayEqualBuildPlattons = {'Factories', 5},
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'CheckBuildPlattonDelay', { 'Factories' }},
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.20, 0.50 } },
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 1, categories.STRUCTURE * categories.FACTORY * categories.LAND}},
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapFactory , '<', categories.STRUCTURE * categories.FACTORY * categories.LAND } },
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                Location = 'LocationType',
                BuildStructures = {
                    'T1LandFactory',
                },
            }
        }
    },
    Builder {
        BuilderName = 'U1 Air Factory Expansions',
        PlatoonTemplate = 'EngineerBuilder',
        Priority = 17550,
        DelayEqualBuildPlattons = {'Factories', 5},
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'CheckBuildPlattonDelay', { 'Factories' }},
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.20, 0.50 } },
            { UCBC, 'UnitsGreaterAtLocation', { 'LocationType', 0, categories.STRUCTURE * categories.FACTORY * categories.LAND}},
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 1, categories.STRUCTURE * categories.FACTORY * categories.AIR}},
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapFactory , '<', categories.STRUCTURE * categories.FACTORY * categories.AIR } },
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                Location = 'LocationType',
                BuildStructures = {
                    'T1AirFactory',
                },
            }
        }
    },
}
-- ===================================================-======================================================== --
-- ==                             Upgrade Factories Land/Air/Sea                                             == --
-- ===================================================-======================================================== --
BuilderGroup {
    BuilderGroupName = 'U123 Factory Upgrader Rush',
    BuildersType = 'PlatoonFormBuilder',
    --------------------
    -- LAND Factories --
    --------------------
    Builder {
        BuilderName = 'U1 L UP HQ 1->2 1st Emergency',
        PlatoonTemplate = 'T1LandFactoryUpgrade',
        Priority = 15400,
        DelayEqualBuildPlattons = {'FactoryUpgrade', 3},
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrade' }},
            { UCBC, 'BuildOnlyOnLocation', { 'LocationType', 'MAIN' } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.STRUCTURE * categories.FACTORY * categories.LAND * (categories.TECH2 + categories.TECH3) * categories.SUPPORTFACTORY } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.STRUCTURE * categories.FACTORY * categories.LAND * (categories.TECH2 + categories.TECH3) - categories.SUPPORTFACTORY } },
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'U1 L UP HQ 1->2 1st Enemy',
        PlatoonTemplate = 'T1LandFactoryUpgrade',
        Priority = 15400,
        DelayEqualBuildPlattons = {'FactoryUpgrade', 3},
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrade' }},
            { UCBC, 'BuildOnlyOnLocation', { 'LocationType', 'MAIN' } },
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.STRUCTURE * categories.FACTORY * categories.LAND * (categories.TECH2 + categories.TECH3) - categories.SUPPORTFACTORY } },
            { UCBC, 'UnitsGreaterAtEnemy', { 0 , categories.STRUCTURE * categories.FACTORY * (categories.TECH2 + categories.TECH3) } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingUpgrade', { 1, categories.STRUCTURE * categories.FACTORY * categories.TECH1 }},
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'U1 L UP HQ 1->2 1st F>8',
        PlatoonTemplate = 'T1LandFactoryUpgrade',
        Priority = 15400,
        DelayEqualBuildPlattons = {'FactoryUpgrade', 3},
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrade' }},
            { UCBC, 'BuildOnlyOnLocation', { 'LocationType', 'MAIN' } },
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.10, 0.10 } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.STRUCTURE * categories.FACTORY * categories.LAND * (categories.TECH2 + categories.TECH3) - categories.SUPPORTFACTORY } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 8, categories.STRUCTURE * categories.FACTORY } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingUpgrade', { 1, categories.STRUCTURE * categories.FACTORY * categories.TECH1 }},
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'U1 L UP HQ 1->2 1st E>25',
        PlatoonTemplate = 'T1LandFactoryUpgrade',
        Priority = 15400,
        DelayEqualBuildPlattons = {'FactoryUpgrade', 3},
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrade' }},
            { UCBC, 'BuildOnlyOnLocation', { 'LocationType', 'MAIN' } },
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.10, 0.10 } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.STRUCTURE * categories.FACTORY * categories.LAND * (categories.TECH2 + categories.TECH3) - categories.SUPPORTFACTORY } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 25, categories.STRUCTURE * categories.ENERGYPRODUCTION } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingUpgrade', { 1, categories.STRUCTURE * categories.FACTORY * categories.TECH1 }},
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'U1 L UP HQ 1->2 1st E>1200',
        PlatoonTemplate = 'T1LandFactoryUpgrade',
        Priority = 15400,
        DelayEqualBuildPlattons = {'FactoryUpgrade', 3},
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrade' }},
            { UCBC, 'BuildOnlyOnLocation', { 'LocationType', 'MAIN' } },
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconIncome',  { 0.1, 120.0 }},
            { EBC, 'GreaterThanEconStorageRatio', { 0.10, 0.10 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.STRUCTURE * categories.FACTORY } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.STRUCTURE * categories.FACTORY * categories.LAND * (categories.TECH2 + categories.TECH3) - categories.SUPPORTFACTORY } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingUpgrade', { 1, categories.STRUCTURE * categories.FACTORY * categories.TECH1 }},
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'U1 L UP HQ 1->2 1st ECO 40 320',
        PlatoonTemplate = 'T1LandFactoryUpgrade',
        Priority = 15400,
        DelayEqualBuildPlattons = {'FactoryUpgrade', 3},
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrade' }},
            { UCBC, 'BuildOnlyOnLocation', { 'LocationType', 'MAIN' } },
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconIncome',  { 0.4, 32.0 }},
            { EBC, 'GreaterThanEconStorageRatio', { 0.10, 0.10 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.STRUCTURE * categories.FACTORY } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.STRUCTURE * categories.FACTORY * categories.LAND * (categories.TECH2 + categories.TECH3) - categories.SUPPORTFACTORY } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingUpgrade', { 1, categories.STRUCTURE * categories.FACTORY * categories.TECH1 }},
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'U1 L UP HQ 1->2 1st M2>1',
        PlatoonTemplate = 'T1LandFactoryUpgrade',
        Priority = 15400,
        DelayEqualBuildPlattons = {'FactoryUpgrade', 3},
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrade' }},
            { UCBC, 'BuildOnlyOnLocation', { 'LocationType', 'MAIN' } },
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.10, 0.10 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.STRUCTURE * categories.MASSEXTRACTION * (categories.TECH2 + categories.TECH3) } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.STRUCTURE * categories.FACTORY } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.STRUCTURE * categories.FACTORY * categories.LAND * (categories.TECH2 + categories.TECH3) - categories.SUPPORTFACTORY } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingUpgrade', { 1, categories.STRUCTURE * categories.FACTORY * categories.TECH1 }},
        },
        BuilderType = 'Any',
    },

    Builder {
        BuilderName = 'U2 L UP HQ 2->3 1st Emergency',
        PlatoonTemplate = 'U2LandHQFactoryUpgrade',
        Priority = 15400,
        DelayEqualBuildPlattons = {'FactoryUpgrade', 3},
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrade' }},
            { UCBC, 'BuildOnlyOnLocation', { 'LocationType', 'MAIN' } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.STRUCTURE * categories.FACTORY * categories.LAND * categories.TECH3 * categories.SUPPORTFACTORY } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.STRUCTURE * categories.FACTORY * categories.LAND * categories.TECH3 - categories.SUPPORTFACTORY } },
        },
        BuilderType = 'Any',
    },

    Builder {
        BuilderName = 'U2 L UP HQ 2->3 1st Enemy',
        PlatoonTemplate = 'U2LandHQFactoryUpgrade',
        Priority = 15400,
        DelayEqualBuildPlattons = {'FactoryUpgrade', 3},
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrade' }},
            { UCBC, 'BuildOnlyOnLocation', { 'LocationType', 'MAIN' } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.STRUCTURE * categories.FACTORY * categories.LAND * categories.TECH3 - categories.SUPPORTFACTORY } },
            { UCBC, 'UnitsGreaterAtEnemy', { 0 , categories.STRUCTURE * categories.FACTORY * categories.TECH3 } },
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'U2 L UP HQ 2->3 1st Force',
        PlatoonTemplate = 'U2LandHQFactoryUpgrade',
        Priority = 15400,
        DelayEqualBuildPlattons = {'FactoryUpgrade', 3},
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrade' }},
            { UCBC, 'BuildOnlyOnLocation', { 'LocationType', 'MAIN' } },
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.10, 0.10 } },
            { EBC, 'GreaterThanEconIncome', { 1.7, 16.7 }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.STRUCTURE * categories.FACTORY * categories.LAND * categories.TECH3 - categories.SUPPORTFACTORY } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.STRUCTURE * categories.ENERGYPRODUCTION * ( categories.TECH2 + categories.TECH3 + categories.EXPERIMENTAL ) }},
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'U2 L UP HQ 2->3 Late',
        PlatoonTemplate = 'U2LandHQFactoryUpgrade',
        Priority = 15000,
        DelayEqualBuildPlattons = {'FactoryUpgrade', 3},
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrade' }},
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.15, 0.50 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.STRUCTURE * categories.FACTORY * categories.TECH3 } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingUpgrade', { 2, categories.STRUCTURE * categories.FACTORY * categories.TECH2 }},
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'U2 L UP HQ 2->3 Full ECO',
        PlatoonTemplate = 'U2LandHQFactoryUpgrade',
        Priority = 15000,
        DelayEqualBuildPlattons = {'FactoryUpgrade', 3},
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrade' }},
            { EBC, 'GreaterThanEconStorageRatio', { 0.90, 0.99 } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingUpgrade', { 1, categories.STRUCTURE * categories.FACTORY * categories.TECH3 }},
        },
        BuilderType = 'Any',
    },
-- LAND Support Factories
    Builder {
        BuilderName = 'U1 L UP SUPORT/HQ 1->2 Always',
        PlatoonTemplate = 'T1LandFactoryUpgrade',
        Priority = 19400,
        DelayEqualBuildPlattons = {'FactoryUpgrade', 3},
        BuilderData = {
            OverideUpgradeBlueprint = { 'zeb9501', 'zab9501', 'zrb9501', 'zsb9501', 'znb9501' },
        },
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrade' }},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.STRUCTURE * categories.FACTORY * categories.LAND * ( categories.TECH2 + categories.TECH3 ) - categories.SUPPORTFACTORY } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingUpgrade', { 2, categories.STRUCTURE * categories.FACTORY * categories.TECH1 }},
        },
        BuilderType = 'Any',
    },
-- Builder for 5 factions
    Builder {
        BuilderName = 'U2 L UP SUPORT 2->3 Always 1',
        PlatoonTemplate = 'U2LandSupFactoryUpgrade1',
        Priority = 19400,
        DelayEqualBuildPlattons = {'FactoryUpgrade', 3},
        BuilderData = {
            OverideUpgradeBlueprint = { 'zeb9601', 'zab9601', 'zrb9601', 'zsb9601', 'znb9601' },
        },
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrade' }},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.UEF * categories.STRUCTURE * categories.FACTORY * categories.LAND * categories.TECH3 - categories.SUPPORTFACTORY} },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.UEF * categories.SUPPORTFACTORY * categories.LAND * categories.TECH2 }},
            { UCBC, 'HaveLessThanUnitsInCategoryBeingUpgrade', { 2, categories.STRUCTURE * categories.FACTORY * categories.TECH2 }},
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'U2 L UP SUPORT 2->3 Always 2',
        PlatoonTemplate = 'U2LandSupFactoryUpgrade2',
        Priority = 15400,
        DelayEqualBuildPlattons = {'FactoryUpgrade', 3},
        BuilderData = {
            OverideUpgradeBlueprint = { 'zeb9601', 'zab9601', 'zrb9601', 'zsb9601', 'znb9601' },
        },
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrade' }},
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.AEON * categories.STRUCTURE * categories.FACTORY * categories.LAND * categories.TECH3 - categories.SUPPORTFACTORY} },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.AEON * categories.SUPPORTFACTORY * categories.LAND * categories.TECH2 }},
            { UCBC, 'HaveLessThanUnitsInCategoryBeingUpgrade', { 2, categories.STRUCTURE * categories.FACTORY * categories.TECH2 }},
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'U2 L UP SUPORT 2->3 Always 3',
        PlatoonTemplate = 'U2LandSupFactoryUpgrade3',
        Priority = 15400,
        DelayEqualBuildPlattons = {'FactoryUpgrade', 3},
        BuilderData = {
            OverideUpgradeBlueprint = { 'zeb9601', 'zab9601', 'zrb9601', 'zsb9601', 'znb9601' },
        },
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrade' }},
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.CYBRAN * categories.STRUCTURE * categories.FACTORY * categories.LAND * categories.TECH3 - categories.SUPPORTFACTORY} },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.CYBRAN * categories.SUPPORTFACTORY * categories.LAND * categories.TECH2 }},
            { UCBC, 'HaveLessThanUnitsInCategoryBeingUpgrade', { 2, categories.STRUCTURE * categories.FACTORY * categories.TECH2 }},
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'U2 L UP SUPORT 2->3 Always 4',
        PlatoonTemplate = 'U2LandSupFactoryUpgrade4',
        Priority = 15400,
        DelayEqualBuildPlattons = {'FactoryUpgrade', 3},
        BuilderData = {
            OverideUpgradeBlueprint = { 'zeb9601', 'zab9601', 'zrb9601', 'zsb9601', 'znb9601' },
        },
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrade' }},
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.SERAPHIM * categories.STRUCTURE * categories.FACTORY * categories.LAND * categories.TECH3 - categories.SUPPORTFACTORY} },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.SERAPHIM * categories.SUPPORTFACTORY * categories.LAND * categories.TECH2 }},
            { UCBC, 'HaveLessThanUnitsInCategoryBeingUpgrade', { 2, categories.STRUCTURE * categories.FACTORY * categories.TECH2 }},
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'U2 L UP SUPORT 2->3 Always 5',
        PlatoonTemplate = 'U2LandSupFactoryUpgrade5',
        Priority = 15400,
        DelayEqualBuildPlattons = {'FactoryUpgrade', 3},
        BuilderData = {
            OverideUpgradeBlueprint = { 'zeb9601', 'zab9601', 'zrb9601', 'zsb9601', 'znb9601' },
        },
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrade' }},
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.STRUCTURE * categories.FACTORY * categories.LAND * categories.TECH3 - categories.SUPPORTFACTORY  - categories.SERAPHIM - categories.CYBRAN - categories.AEON - categories.UEF } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.SUPPORTFACTORY * categories.TECH2 * categories.LAND - categories.SERAPHIM - categories.CYBRAN - categories.AEON - categories.UEF }},
            { UCBC, 'HaveLessThanUnitsInCategoryBeingUpgrade', { 2, categories.STRUCTURE * categories.FACTORY * categories.TECH2 }},
        },
        BuilderType = 'Any',
    },
    -------------------
    -- AIR Factories --
    -------------------
    Builder {
        BuilderName = 'U1 A UP HQ 1->2 1st Force',
        PlatoonTemplate = 'T1AirFactoryUpgrade',
        Priority = 15400,
        DelayEqualBuildPlattons = {'FactoryUpgrade', 3},
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrade' }},
            { UCBC, 'BuildOnlyOnLocation', { 'LocationType', 'MAIN' } },
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.STRUCTURE * categories.FACTORY * categories.AIR * (categories.TECH2 + categories.TECH3) - categories.SUPPORTFACTORY } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.STRUCTURE * categories.FACTORY * categories.LAND * categories.TECH2 } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingUpgrade', { 1, categories.STRUCTURE * categories.FACTORY * categories.AIR * categories.TECH1 }},
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'U2 A UP HQ 2->3 1st Force',
        PlatoonTemplate = 'U2AirHQFactoryUpgrade',
        Priority = 15400,
        DelayEqualBuildPlattons = {'FactoryUpgrade', 3},
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrade' }},
            { UCBC, 'BuildOnlyOnLocation', { 'LocationType', 'MAIN' } },
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.STRUCTURE * categories.FACTORY * categories.AIR * categories.TECH3 - categories.SUPPORTFACTORY } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.STRUCTURE * categories.FACTORY * categories.LAND * categories.TECH3 } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingUpgrade', { 1, categories.STRUCTURE * categories.FACTORY * categories.AIR * categories.TECH2 }},
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'U2 A UP HQ 2->3 Late',
        PlatoonTemplate = 'U2AirHQFactoryUpgrade',
        Priority = 15000,
        DelayEqualBuildPlattons = {'FactoryUpgrade', 3},
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrade' }},
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.15, 0.50 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.STRUCTURE * categories.FACTORY * categories.AIR * categories.TECH3 } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingUpgrade', { 2, categories.STRUCTURE * categories.FACTORY * categories.AIR * categories.TECH2 }},
        },
        BuilderType = 'Any',
    },
-- AIR Support Factories
    Builder {
        BuilderName = 'U1 A UP SUPORT/HQ 1->2 Always',
        PlatoonTemplate = 'T1AirFactoryUpgrade',
        Priority = 15400,
        DelayEqualBuildPlattons = {'FactoryUpgrade', 3},
        BuilderData = {
            OverideUpgradeBlueprint = { 'zeb9502', 'zab9502', 'zrb9502', 'zsb9502', 'znb9502' },
        },
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrade' }},
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.15, 0.50 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.STRUCTURE * categories.FACTORY * categories.AIR * ( categories.TECH2 + categories.TECH3 ) - categories.SUPPORTFACTORY } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.STRUCTURE * categories.FACTORY * categories.AIR * categories.TECH1 } },
        },
        BuilderType = 'Any',
    },
-- Builder for 5 factions
    Builder {
        BuilderName = 'U2 A UP SUPORT 2->3 Always 1',
        PlatoonTemplate = 'U2AirSupFactoryUpgrade1',
        Priority = 15400,
        DelayEqualBuildPlattons = {'FactoryUpgrade', 3},
        BuilderData = {
            OverideUpgradeBlueprint = { 'zeb9602', 'zab9602', 'zrb9602', 'zsb9602', 'znb9602' },
        },
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrade' }},
            { EBC, 'GreaterThanEconStorageRatio', { 0.15, 0.50 } },
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.UEF * categories.STRUCTURE * categories.FACTORY * categories.AIR * categories.TECH3 - categories.SUPPORTFACTORY} },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.UEF * categories.AIR * categories.SUPPORTFACTORY * categories.TECH2 }},
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'U2 A UP SUPORT 2->3 Always 2',
        PlatoonTemplate = 'U2AirSupFactoryUpgrade2',
        Priority = 15400,
        DelayEqualBuildPlattons = {'FactoryUpgrade', 3},
        BuilderData = {
            OverideUpgradeBlueprint = { 'zeb9602', 'zab9602', 'zrb9602', 'zsb9602', 'znb9602' },
        },
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrade' }},
            { EBC, 'GreaterThanEconStorageRatio', { 0.15, 0.50 } },
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.AEON * categories.STRUCTURE * categories.FACTORY * categories.AIR * categories.TECH3 - categories.SUPPORTFACTORY} },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.AEON * categories.AIR * categories.SUPPORTFACTORY * categories.TECH2 }},
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'U2 A UP SUPORT 2->3 Always 3',
        PlatoonTemplate = 'U2AirSupFactoryUpgrade3',
        Priority = 15400,
        DelayEqualBuildPlattons = {'FactoryUpgrade', 3},
        BuilderData = {
            OverideUpgradeBlueprint = { 'zeb9602', 'zab9602', 'zrb9602', 'zsb9602', 'znb9602' },
        },
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrade' }},
            { EBC, 'GreaterThanEconStorageRatio', { 0.15, 0.50 } },
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.CYBRAN * categories.STRUCTURE * categories.FACTORY * categories.AIR * categories.TECH3 - categories.SUPPORTFACTORY} },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.CYBRAN * categories.AIR * categories.SUPPORTFACTORY * categories.TECH2 }},
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'U2 A UP SUPORT 2->3 Always 4',
        PlatoonTemplate = 'U2AirSupFactoryUpgrade4',
        Priority = 15400,
        DelayEqualBuildPlattons = {'FactoryUpgrade', 3},
        BuilderData = {
            OverideUpgradeBlueprint = { 'zeb9602', 'zab9602', 'zrb9602', 'zsb9602', 'znb9602' },
        },
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrade' }},
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.15, 0.50 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.SERAPHIM * categories.STRUCTURE * categories.FACTORY * categories.AIR * categories.TECH3 - categories.SUPPORTFACTORY} },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.SERAPHIM * categories.AIR * categories.SUPPORTFACTORY * categories.TECH2 }},
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'U2 A UP SUPORT 2->3 Always 5',
        PlatoonTemplate = 'U2AirSupFactoryUpgrade5',
        Priority = 15400,
        DelayEqualBuildPlattons = {'FactoryUpgrade', 3},
        BuilderData = {
            OverideUpgradeBlueprint = { 'zeb9602', 'zab9602', 'zrb9602', 'zsb9602', 'znb9602' },
        },
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrade' }},
            { EBC, 'GreaterThanEconStorageRatio', { 0.15, 0.50 } },
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.STRUCTURE * categories.FACTORY * categories.AIR * categories.TECH3 - categories.SUPPORTFACTORY  - categories.SERAPHIM - categories.CYBRAN - categories.AEON - categories.UEF } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.SUPPORTFACTORY * categories.TECH2 * categories.AIR - categories.SERAPHIM - categories.CYBRAN - categories.AEON - categories.UEF }},
        },
        BuilderType = 'Any',
    },
}
