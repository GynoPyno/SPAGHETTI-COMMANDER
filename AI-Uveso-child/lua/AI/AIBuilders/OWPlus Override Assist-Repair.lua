-- Override di 'UC123 Assistees' e 'U1 Engineer Reclaim' (stock AI-Uveso) — sess.75: esclude gli
-- avamposti (NotOutpost) per evitare che rubino ingegneri/risorse agli avamposti autonomi
-- OverwhelmPlus. Fedele all'originale (AI-Uveso/lua/AI/AIBuilders/Assist-Repair.lua) salvo
-- l'aggiunta della condizione NotOutpost a ogni Builder.

local categories = categories
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'

-- Fase sess.75: esclude gli avamposti da tutti i Builder di questi gruppi stock, cosi'
-- non competono con i BuilderGroup dedicati dell'avamposto per gli ingegneri assegnati
-- alla sua location. Fix sess.76: BuildNotOnLocation (string.find su 'OUT') non
-- funzionava mai — gli avamposti hanno LocationType tipo "Expansion Area U3", mai
-- 'OUT'. OWPlusNotOutpostLocation controlla invece aiBrain.OWPlusOutpostLocationTypes.
local NotOutpost = { UCBC, 'OWPlusNotOutpostLocation', { 'LocationType' } }

-- ===================================================-======================================================== --
-- ==                                             Assistees                                                  == --
-- ===================================================-======================================================== --
BuilderGroup {
    BuilderGroupName = 'UC123 Assistees',
    BuildersType = 'PlatoonFormBuilder',
    -- =============== --
    --    Factories    --
    -- =============== --
    Builder {
        BuilderName = 'UC Assist Factory build',
        PlatoonTemplate = 'CommanderAssist',
        Priority = 17950,
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'HaveGreaterThanUnitsInCategoryBeingBuiltAtLocation', { 'LocationType', 0, categories.STRUCTURE * categories.FACTORY * categories.TECH1 }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Structure',
                AssistRange = 80,
                BeingBuiltCategories = {'STRUCTURE FACTORY TECH1'},
                AssistUntilFinished = true,
                Time = 0,
            },
        }
    },
    Builder {
        BuilderName = 'U1 Assist 1st T2 Factory Upgrade',
        PlatoonTemplate = 'EngineerAssist',
        Priority = 200,
        InstanceCount = 20,
        BuilderConditions = {
            NotOutpost,
            { EBC, 'GreaterThanEconStorageRatio', { 0.50, 0.99}},
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.LAND * categories.ENGINEER * categories.TECH1 - categories.STATIONASSISTPOD } },
            { UCBC, 'HaveGreaterThanUnitsInCategoryBeingBuiltAtLocation', { 'LocationType', 0, categories.STRUCTURE * categories.FACTORY * categories.LAND * categories.TECH2 , categories.STRUCTURE * categories.FACTORY * categories.LAND * categories.TECH1 }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.STRUCTURE * categories.FACTORY * categories.LAND * ( categories.TECH2 + categories.TECH3 ) } },
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Factory',
                AssistRange = 80,
                BeingBuiltCategories = {'STRUCTURE LAND FACTORY TECH2'},
                AssistUntilFinished = true,
                PermanentAssist = true,
                Time = 0,
            },
        }
    },
    Builder {
        BuilderName = 'U1 Assist 1st T3 Factory Upgrade',
        PlatoonTemplate = 'EngineerAssist',
        Priority = 200,
        InstanceCount = 20,
        BuilderConditions = {
            NotOutpost,
            { EBC, 'GreaterThanEconStorageRatio', { 0.50, 0.99}},
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.LAND * categories.ENGINEER * categories.TECH1 - categories.STATIONASSISTPOD } },
            { UCBC, 'HaveGreaterThanUnitsInCategoryBeingBuiltAtLocation', { 'LocationType', 0, categories.STRUCTURE * categories.FACTORY * categories.LAND * categories.TECH3 , categories.STRUCTURE * categories.FACTORY * categories.LAND * categories.TECH2 }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.STRUCTURE * categories.FACTORY * categories.LAND * categories.TECH3 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Factory',
                AssistRange = 80,
                BeingBuiltCategories = {'STRUCTURE LAND FACTORY TECH3'},
                AssistUntilFinished = true,
                PermanentAssist = true,
                Time = 0,
            },
        }
    },
    Builder {
        BuilderName = 'U2 Assist 1st T3 Factory Upgrade',
        PlatoonTemplate = 'T2EngineerAssist',
        Priority = 200,
        InstanceCount = 10,
        BuilderConditions = {
            NotOutpost,
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.50, 0.99}},
            { UCBC, 'HaveGreaterThanUnitsInCategoryBeingBuiltAtLocation', { 'LocationType', 0, categories.STRUCTURE * categories.FACTORY * categories.LAND * categories.TECH3 , categories.STRUCTURE * categories.FACTORY * categories.LAND * categories.TECH2 }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.STRUCTURE * categories.FACTORY * categories.LAND * categories.TECH3 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Factory',
                AssistRange = 80,
                BeingBuiltCategories = {'STRUCTURE LAND FACTORY TECH3'},
                AssistUntilFinished = true,
                PermanentAssist = true,
                Time = 0,
            },
        }
    },
    Builder {
        BuilderName = 'U2 Assist Factory Upgrade',
        PlatoonTemplate = 'T2EngineerAssist',
        Priority = 200,
        InstanceCount = 20,
        BuilderConditions = {
            NotOutpost,
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.50, 0.99}},
            { UCBC, 'HaveGreaterThanUnitsInCategoryBeingBuiltAtLocation', { 'LocationType', 0, categories.STRUCTURE * categories.FACTORY}},
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Factory',
                AssistRange = 80,
                AssistClosestUnit = true,
                BeingBuiltCategories = {'STRUCTURE FACTORY'},
                AssistUntilFinished = true,
                PermanentAssist = true,
                Time = 0,
            },
        }
    },
    -- Permanent assist
    Builder {
        BuilderName = 'T2 Gate Assist',
        PlatoonTemplate = 'T2EngineerAssist',
        Priority = 900,
        InstanceCount = 10,
        BuilderConditions = {
            NotOutpost,
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.50, 0.99}},
            { UCBC, 'LocationFactoriesBuildingGreater', { 'LocationType', 0, categories.SUBCOMMANDER } },
        },
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssistRange = 120,
                AssisteeType = 'Factory',
                BeingBuiltCategories = {'SUBCOMMANDER'},
                PermanentAssist = true,
                AssistClosestUnit = false,
                AssistUntilFinished = true,
                Time = 0,
            },
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'T1 Assist Factory unit build',
        PlatoonTemplate = 'EngineerAssist',
        Priority = 600,
        InstanceCount = 10,
        BuilderConditions = {
            NotOutpost,
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.50, 0.99}},
            { UCBC, 'GreaterThanGameTimeSeconds', { 60*15 } },
            { UCBC, 'LocationFactoriesBuildingGreater', { 'LocationType', 0, categories.MOBILE - categories.SUBCOMMANDER } },
        },
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Factory',
                AssistRange = 120,
                BeingBuiltCategories = {'MOBILE INDIRECTFIRE, MOBILE DIRECTFIRE, MOBILE ANTIAIR'},
                AssistClosestUnit = false,
                AssistUntilFinished = true,
                Time = 0,
            },
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'T2 Assist Factory unit build',
        PlatoonTemplate = 'T2EngineerAssist',
        Priority = 600,
        InstanceCount = 10,
        BuilderConditions = {
            NotOutpost,
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.50, 0.99}},
            { UCBC, 'GreaterThanGameTimeSeconds', { 60*15 } },
            { UCBC, 'LocationFactoriesBuildingGreater', { 'LocationType', 0, categories.MOBILE - categories.SUBCOMMANDER } },
        },
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Factory',
                AssistRange = 120,
                BeingBuiltCategories = {'MOBILE INDIRECTFIRE, MOBILE DIRECTFIRE, MOBILE ANTIAIR'},
                AssistClosestUnit = true,
                AssistUntilFinished = true,
                Time = 0,
            },
        },
        BuilderType = 'Any',
    },

    -- ============ --
    --    ENERGY    --
    -- ============ --
    Builder {
        BuilderName = 'UC Assist Energy 1',
        PlatoonTemplate = 'CommanderAssist',
        Priority = 17950,
        BuilderConditions = {
            NotOutpost,
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.50, 0.99}},
            { UCBC, 'HaveGreaterThanUnitsInCategoryBeingBuiltAtLocation', { 'LocationType', 0, categories.STRUCTURE * categories.ENERGYPRODUCTION }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Structure',
                AssistRange = 50,
                BeingBuiltCategories = {'STRUCTURE ENERGYPRODUCTION'},
                AssistUntilFinished = true,
                Time = 0,
            },
        }
    },
    Builder {
        BuilderName = 'UC Assist Hydro',
        PlatoonTemplate = 'CommanderAssist',
        Priority = 17950,
        BuilderConditions = {
            NotOutpost,
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.50, 0.99}},
            { UCBC, 'HaveGreaterThanUnitsInCategoryBeingBuiltAtLocation', { 'LocationType', 0, categories.STRUCTURE * categories.HYDROCARBON }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Structure',
                AssistRange = 50,
                BeingBuiltCategories = {'STRUCTURE HYDROCARBON'},
                AssistUntilFinished = true,
                Time = 0,
            },
        }
    },
    Builder {
        BuilderName = 'U1 Assist Energy',
        PlatoonTemplate = 'EngineerAssist',
        Priority = 17950,
        InstanceCount = 3,
        BuilderConditions = {
            NotOutpost,
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.50, 0.99}},
            { UCBC, 'HaveGreaterThanUnitsInCategoryBeingBuiltAtLocation', { 'LocationType', 0, categories.STRUCTURE * categories.ENERGYPRODUCTION }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Structure',
                AssistRange = 60,
                BeingBuiltCategories = {'STRUCTURE ENERGYPRODUCTION'},
                AssistUntilFinished = true,
                Time = 0,
            },
        }
    },
    Builder {
        BuilderName = 'U2 Assist Energy Turbo',
        PlatoonTemplate = 'T2EngineerAssist',
        Priority = 17950,
        InstanceCount = 2,
        BuilderConditions = {
            NotOutpost,
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.50, 0.99}},
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 1, categories.MOBILE * categories.LAND * categories.ENGINEER * categories.TECH2 - categories.STATIONASSISTPOD } },
            { UCBC, 'HaveGreaterThanUnitsInCategoryBeingBuiltAtLocation', { 'LocationType', 0, categories.STRUCTURE * categories.ENERGYPRODUCTION * (categories.TECH2 + categories.TECH3) }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Structure',
                AssistRange = 80,
                AssistClosestUnit = true,
                BeingBuiltCategories = {'STRUCTURE ENERGYPRODUCTION TECH2', 'STRUCTURE ENERGYPRODUCTION TECH3'},
                AssistUntilFinished = true,
                Time = 0,
            },
        }
    },
    Builder {
        BuilderName = 'U3 Assist Energy Turbo',
        PlatoonTemplate = 'T3EngineerAssistNoSUB',
        Priority = 17950,
        InstanceCount = 2,
        BuilderConditions = {
            NotOutpost,
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.50, 0.99}},
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 1, categories.MOBILE * categories.LAND * categories.ENGINEER * categories.TECH3 - categories.STATIONASSISTPOD } },
            { UCBC, 'HaveGreaterThanUnitsInCategoryBeingBuiltAtLocation', { 'LocationType', 0, categories.STRUCTURE * categories.ENERGYPRODUCTION * (categories.TECH2 + categories.TECH3) }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Structure',
                AssistRange = 80,
                AssistClosestUnit = true,
                BeingBuiltCategories = {'STRUCTURE ENERGYPRODUCTION TECH2', 'STRUCTURE ENERGYPRODUCTION TECH3'},
                AssistUntilFinished = true,
                Time = 0,
            },
        }
    },
    -- ========== --
    --    MASS    --
    -- ========== --
    Builder {
        BuilderName = 'U1 Assist Mass',
        PlatoonTemplate = 'EngineerAssist',
        Priority = 17900,
        InstanceCount = 10,
        BuilderConditions = {
            NotOutpost,
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.50, 0.99}},
            { UCBC, 'HaveGreaterThanUnitsInCategoryBeingBuiltAtLocation', { 'LocationType', 0, categories.STRUCTURE * categories.MASSEXTRACTION }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Structure',
                AssistRange = 80,
                BeingBuiltCategories = {'STRUCTURE MASSEXTRACTION'},
                AssistUntilFinished = true,
                Time = 0,
            },
        }
    },
    -- ============ --
    --    Paragon   --
    -- ============ --
    Builder {
        BuilderName = 'U1 Assist PARA',
        PlatoonTemplate = 'EngineerAssist',
        Priority = 500,
        InstanceCount = 5,
        BuilderConditions = {
            NotOutpost,
            { EBC, 'GreaterThanEconIncome', { 20.0, 100.0 }},
            { UCBC, 'HaveGreaterThanUnitsInCategoryBeingBuilt', { 0, categories.STRUCTURE * categories.ECONOMIC * categories.EXPERIMENTAL }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Structure',
                AssistRange = 120,
                BeingBuiltCategories = {'EXPERIMENTAL ECONOMIC'},
                AssistUntilFinished = true,
                Time = 0,
            },
        }
    },
    Builder {
        BuilderName = 'U2 Assist PARA',
        PlatoonTemplate = 'T2EngineerAssist',
        Priority = 500,
        InstanceCount = 5,
        BuilderConditions = {
            NotOutpost,
            { EBC, 'GreaterThanEconIncome', { 30.0, 100.0 }},
            { UCBC, 'HaveGreaterThanUnitsInCategoryBeingBuilt', { 0, categories.STRUCTURE * categories.ECONOMIC * categories.EXPERIMENTAL }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Structure',
                AssistRange = 120,
                BeingBuiltCategories = {'EXPERIMENTAL ECONOMIC'},
                AssistUntilFinished = true,
                Time = 0,
            },
        }
    },
    Builder {
        BuilderName = 'U3 Assist PARA',
        PlatoonTemplate = 'T3EngineerAssistNoSUB',
        Priority = 500,
        InstanceCount = 5,
        BuilderConditions = {
            NotOutpost,
            { EBC, 'GreaterThanEconIncome', { 40.0, 100.0 }},
            { UCBC, 'HaveGreaterThanUnitsInCategoryBeingBuilt', { 0, categories.STRUCTURE * categories.ECONOMIC * categories.EXPERIMENTAL }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Structure',
                AssistRange = 120,
                BeingBuiltCategories = {'EXPERIMENTAL ECONOMIC'},
                AssistUntilFinished = true,
                Time = 0,
            },
        }
    },
    Builder {
        BuilderName = 'U1 Assist PARA+',
        PlatoonTemplate = 'EngineerAssist',
        Priority = 500,
        InstanceCount = 10,
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.STRUCTURE * categories.ECONOMIC * categories.EXPERIMENTAL}},
            { UCBC, 'HaveGreaterThanUnitsInCategoryBeingBuilt', { 0, categories.STRUCTURE * categories.ECONOMIC * categories.EXPERIMENTAL }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Structure',
                AssistRange = 120,
                BeingBuiltCategories = {'EXPERIMENTAL ECONOMIC'},
                AssistUntilFinished = true,
                Time = 0,
            },
        }
    },
    Builder {
        BuilderName = 'U2 Assist PARA+',
        PlatoonTemplate = 'T2EngineerAssist',
        Priority = 500,
        InstanceCount = 10,
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.STRUCTURE * categories.ECONOMIC * categories.EXPERIMENTAL}},
            { UCBC, 'HaveGreaterThanUnitsInCategoryBeingBuilt', { 0, categories.STRUCTURE * categories.ECONOMIC * categories.EXPERIMENTAL }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Structure',
                AssistRange = 120,
                BeingBuiltCategories = {'EXPERIMENTAL ECONOMIC'},
                AssistUntilFinished = true,
                Time = 0,
            },
        }
    },
    Builder {
        BuilderName = 'U3 Assist PARA+',
        PlatoonTemplate = 'T3EngineerAssist',
        Priority = 500,
        InstanceCount = 10,
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.STRUCTURE * categories.ECONOMIC * categories.EXPERIMENTAL}},
            { UCBC, 'HaveGreaterThanUnitsInCategoryBeingBuilt', { 0, categories.STRUCTURE * categories.ECONOMIC * categories.EXPERIMENTAL }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Structure',
                AssistRange = 120,
                BeingBuiltCategories = {'EXPERIMENTAL ECONOMIC'},
                AssistUntilFinished = true,
                Time = 0,
            },
        }
    },
    -- =================== --
    --    Experimentals    --
    -- =================== --
    Builder {
        BuilderName = 'U1 Assist Experimental',
        PlatoonTemplate = 'EngineerAssist',
        Priority = 1,
        InstanceCount = 50,
        BuilderConditions = {
            NotOutpost,
            { EBC, 'GreaterThanEconStorageRatio', { 0.25, 1.00}},
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 1, categories.MOBILE * categories.LAND * categories.ENGINEER * categories.TECH1 - categories.STATIONASSISTPOD } },
            { UCBC, 'HaveGreaterThanUnitsInCategoryBeingBuiltAtLocation', { 'LocationType', 0, categories.EXPERIMENTAL }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Structure',
                AssistRange = 100,
                AssistClosestUnit = true,
                BeingBuiltCategories = {'EXPERIMENTAL'},
                AssistUntilFinished = true,
                Time = 0,
            },
        }
    },
    Builder {
        BuilderName = 'U2 Assist Experimental',
        PlatoonTemplate = 'T2EngineerAssist',
        Priority = 200,
        InstanceCount = 50,
        BuilderConditions = {
            NotOutpost,
            { EBC, 'GreaterThanEconStorageRatio', { 0.30, 1.00}},
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 1, categories.MOBILE * categories.LAND * categories.ENGINEER * categories.TECH2 - categories.STATIONASSISTPOD } },
            { UCBC, 'HaveGreaterThanUnitsInCategoryBeingBuiltAtLocation', { 'LocationType', 0, categories.EXPERIMENTAL * (categories.ECONOMIC + categories.SHIELD + categories.MOBILE ) }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Structure',
                AssistRange = 100,
                AssistClosestUnit = true,
                BeingBuiltCategories = {'EXPERIMENTAL ECONOMIC, EXPERIMENTAL SHIELD, EXPERIMENTAL MOBILE'},
                AssistUntilFinished = true,
                Time = 0,
            },
        }
    },
    Builder {
        BuilderName = 'U3 Assist Experimental',
        PlatoonTemplate = 'T3EngineerAssistNoSUB',
        Priority = 200,
        InstanceCount = 15,
        BuilderConditions = {
            NotOutpost,
            { EBC, 'GreaterThanEconStorageRatio', { 0.40, 1.00}},
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 2, categories.MOBILE * categories.LAND * categories.ENGINEER * categories.TECH3 - categories.STATIONASSISTPOD } },
            { UCBC, 'HaveGreaterThanUnitsInCategoryBeingBuiltAtLocation', { 'LocationType', 0, categories.EXPERIMENTAL * (categories.ECONOMIC + categories.SHIELD + categories.MOBILE ) }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Structure',
                AssistRange = 100,
                AssistClosestUnit = true,
                BeingBuiltCategories = {'EXPERIMENTAL ECONOMIC, EXPERIMENTAL SHIELD, EXPERIMENTAL MOBILE'},
                AssistUntilFinished = true,
                Time = 0,
            },
        }
    },

    -- ================ --
    --    Artillery     --
    -- ================ --
    Builder {
        BuilderName = 'U1 Assist Arty Satellite',
        PlatoonTemplate = 'EngineerAssist',
        Priority = 200,
        InstanceCount = 10,
        BuilderConditions = {
            NotOutpost,
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.25, 0.80}},
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.LAND * categories.ENGINEER * categories.TECH1 - categories.STATIONASSISTPOD } },
            { UCBC, 'HaveGreaterThanUnitsInCategoryBeingBuiltAtLocation', { 'LocationType', 0, (categories.STRUCTURE * categories.ARTILLERY) + categories.xeb2402}},
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                BeingBuiltCategories = {'STRUCTURE ARTILLERY, ORBITALSYSTEM'},
                AssisteeType = 'Structure',
                AssistRange = 100,
                AssistClosestUnit = true,
                AssistUntilFinished = true,
                Time = 0,
            },
        }
    },

    -- ============== --
    --    Shields     --
    -- ============== --
    Builder {
        BuilderName = 'U1 Assist Shield',
        PlatoonTemplate = 'EngineerAssist',
        Priority = 200,
        InstanceCount = 10,
        BuilderConditions = {
            NotOutpost,
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.25, 0.80}},
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.LAND * categories.ENGINEER * categories.TECH1 - categories.STATIONASSISTPOD } },
            { UCBC, 'HaveGreaterThanUnitsInCategoryBeingBuiltAtLocation', { 'LocationType', 0, categories.STRUCTURE * categories.SHIELD }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                BeingBuiltCategories = {'STRUCTURE SHIELD'},
                AssisteeType = 'Structure',
                AssistRange = 100,
                AssistClosestUnit = true,
                AssistUntilFinished = true,
                Time = 0,
            },
        }
    },
    -- =================== --
    --    General Assist   --
    -- =================== --
    Builder {
        BuilderName = 'U1 Engineer Assist Engineer',
        PlatoonTemplate = 'EngineerAssist',
        Priority = 1,
        InstanceCount = 50,
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'LocationEngineersBuildingAssistanceGreater', { 'LocationType', 0, categories.ALLUNITS } },
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.25, 0.80}},
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                BeingBuiltCategories = {'ALLUNITS'},
                PermanentAssist = false,
                AssisteeType = 'Engineer',
                AssistClosestUnit = true,
                Time = 30,
            },
        }
    },
    Builder {
        BuilderName = 'U2 Engineer Assist Engineer',
        PlatoonTemplate = 'T2EngineerAssist',
        Priority = 1,
        InstanceCount = 50,
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'LocationEngineersBuildingAssistanceGreater', { 'LocationType', 0, categories.TECH2 + categories.TECH3 + categories.EXPERIMENTAL } },
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.25, 0.80}},
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                BeingBuiltCategories = {'TECH2', 'TECH3', 'EXPERIMENTAL'},
                PermanentAssist = false,
                AssisteeType = 'Engineer',
                AssistClosestUnit = true,
                Time = 30,
            },
        }
    },
    Builder {
        BuilderName = 'U3 Engineer Assist Engineer',
        PlatoonTemplate = 'T3EngineerAssistNoSUB',
        Priority = 1,
        InstanceCount = 50,
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'LocationEngineersBuildingAssistanceGreater', { 'LocationType', 0, categories.TECH3 + categories.EXPERIMENTAL } },
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.25, 0.80}},
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                BeingBuiltCategories = {'TECH3', 'EXPERIMENTAL'},
                AssistLocation = 'LocationType',
                PermanentAssist = false,
                AssisteeType = 'Engineer',
                AssistClosestUnit = true,
                Time = 30,
            },
        }
    },

    -- =============== --
    --    Finisher     --
    -- =============== --
    Builder {
        BuilderName = 'U1 Finisher',
        PlatoonTemplate = 'EngineerBuilder',
        PlatoonAIPlan = 'FinisherAIUveso',
        Priority = 17900,
        InstanceCount = 4,
        BuilderConditions = {
            NotOutpost,
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { UCBC, 'UnfinishedUnitsAtLocation', { 'LocationType' }},
        },
        BuilderData = {
            LocationType = 'LocationType',
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'U2 Finisher',
        PlatoonTemplate = 'T2EngineerBuilder',
        PlatoonAIPlan = 'FinisherAIUveso',
        Priority = 17900,
        InstanceCount = 4,
        BuilderConditions = {
            NotOutpost,
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { UCBC, 'UnfinishedUnitsAtLocation', { 'LocationType' }},
        },
        BuilderData = {
            LocationType = 'LocationType',
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'U3 Finisher',
        PlatoonTemplate = 'T3EngineerBuilder',
        PlatoonAIPlan = 'FinisherAIUveso',
        Priority = 17900,
        InstanceCount = 2,
        BuilderConditions = {
            NotOutpost,
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { UCBC, 'UnfinishedUnitsAtLocation', { 'LocationType' }},
        },
        BuilderData = {
            LocationType = 'LocationType',
        },
        BuilderType = 'Any',
    },
    -- =============== --
    --    Repair     --
    -- =============== --
    Builder {
        BuilderName = 'U1 Engineer Repair',
        PlatoonTemplate = 'EngineerBuilder',
        PlatoonAIPlan = 'RepairAI',
        Priority = 60,
        InstanceCount = 5,
        BuilderConditions = {
            NotOutpost,
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.05, 0.50}},
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.LAND * categories.ENGINEER * categories.TECH1 - categories.STATIONASSISTPOD } },
            { UCBC, 'DamagedStructuresInArea', { 'LocationType', }},
        },
        BuilderData = {
            LocationType = 'LocationType',
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'U2 Engineer Repair',
        PlatoonTemplate = 'T2EngineerBuilder',
        PlatoonAIPlan = 'RepairAI',
        Priority = 60,
        InstanceCount = 3,
        BuilderConditions = {
            NotOutpost,
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.05, 0.50}},
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.LAND * categories.ENGINEER * categories.TECH2 - categories.STATIONASSISTPOD } },
            { UCBC, 'DamagedStructuresInArea', { 'LocationType', }},
        },
        BuilderData = {
            LocationType = 'LocationType',
        },
        BuilderType = 'Any',
    },
}
-- ============== --
--    Reclaim     --
-- ============== --
BuilderGroup {
    BuilderGroupName = 'U1 Engineer Reclaim',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'U1 Reclaim RECOVER mass',
        PlatoonTemplate = 'U1Reclaim',
        Priority = 19600,
        InstanceCount = 1,
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.HasParagon then
                return 0
            else
                return 19600
            end
        end,
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.MOBILE * categories.COMMAND }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.STRUCTURE * categories.MASSEXTRACTION } },
        },
        BuilderData = {
            LocationType = 'LocationType',
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'U1 Reclaim RECOVER energy',
        PlatoonTemplate = 'U1Reclaim',
        Priority = 19500,
        InstanceCount = 1,
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.HasParagon then
                return 0
            else
                return 19500
            end
        end,
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.MOBILE * categories.COMMAND }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.STRUCTURE * categories.ENERGYPRODUCTION } },
        },
        BuilderData = {
            LocationType = 'LocationType',
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'U1 Reclaim Resource 1',
        PlatoonTemplate = 'U1Reclaim',
        Priority = 18000,
        InstanceCount = 1,
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.HasParagon then
                return 0
            else
                return 18000
            end
        end,
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 8, categories.MOBILE * categories.ENGINEER - categories.STATIONASSISTPOD - categories.POD}},
        },
        BuilderData = {
            LocationType = 'LocationType',
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'U1 Reclaim Resource 2',
        PlatoonTemplate = 'U1Reclaim',
        Priority = 17400,
        InstanceCount = 1,
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.HasParagon then
                return 0
            else
                return 17400
            end
        end,
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'BuildOnlyOnLocation', { 'LocationType', 'MAIN' } },
            { EBC, 'LessThanEconStorageRatio', { 0.80, 2.00}},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 11, categories.MOBILE * categories.ENGINEER - categories.STATIONASSISTPOD - categories.POD}},
        },
        BuilderData = {
            LocationType = 'LocationType',
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'U1 Reclaim Resource 3',
        PlatoonTemplate = 'U1Reclaim',
        Priority = 17400,
        InstanceCount = 2,
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.HasParagon then
                return 0
            else
                return 17400
            end
        end,
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'BuildOnlyOnLocation', { 'LocationType', 'MAIN' } },
            { EBC, 'LessThanEconStorageRatio', { 0.80, 2.00}},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.MOBILE * categories.ENGINEER * categories.TECH2 - categories.STATIONASSISTPOD}},
        },
        BuilderData = {
            LocationType = 'LocationType',
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'U1 Reclaim Resource 4',
        PlatoonTemplate = 'U1Reclaim',
        Priority = 17400,
        InstanceCount = 6,
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.HasParagon then
                return 0
            else
                return 17400
            end
        end,
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'BuildOnlyOnLocation', { 'LocationType', 'MAIN' } },
            { EBC, 'LessThanEconStorageRatio', { 0.80, 2.00}},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.MOBILE * categories.ENGINEER * categories.TECH3 - categories.STATIONASSISTPOD}},
        },
        BuilderData = {
            LocationType = 'LocationType',
        },
        BuilderType = 'Any',
    },
}
