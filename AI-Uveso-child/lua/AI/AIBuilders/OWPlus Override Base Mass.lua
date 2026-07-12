-- Override di 'U1 MassBuilders' (stock AI-Uveso) — sess.75: esclude gli avamposti
-- (NotOutpost) per evitare che rubino ingegneri/risorse agli avamposti autonomi
-- OverwhelmPlus. Fedele all'originale (AI-Uveso/lua/AI/AIBuilders/Base Mass.lua) salvo
-- l'aggiunta della condizione NotOutpost a ogni Builder.
--
-- Nota: questo gruppo e' esplicitamente citato nel contesto come motivo "costruire
-- estrattori di massa lontani" — gli ingegneri dell'avamposto venivano mandati a
-- costruire mass extractor ovunque sulla mappa (raggio 1000) invece di restare nella
-- location dell'avamposto.

local categories = categories
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'
local MABC = '/lua/editor/MarkerBuildConditions.lua'
local NoRushRadius = ScenarioInfo.norushradius or 30
local BasePanicZone, BaseMilitaryZone, BaseEnemyZone = import('/mods/AI-Uveso/lua/AI/AITargetManager.lua').GetDangerZoneRadii()

local MaxCapMass = 0.10
local MaxCapStructure = 0.12

-- Fase sess.75: esclude gli avamposti (LocationType 'OUT#') da tutti i Builder di questo
-- gruppo stock, cosi' non competono con i BuilderGroup dedicati dell'avamposto per gli
-- ingegneri assegnati alla sua location.
-- Fix sess.76: BuildNotOnLocation (string.find su 'OUT') non funzionava mai — gli
-- avamposti hanno LocationType tipo "Expansion Area U3", mai 'OUT'.
local NotOutpost = { UCBC, 'OWPlusNotOutpostLocation', { 'LocationType' } }

-- ============================================================================================================ --
-- ==                                     Build MassExtractors / Creators                                    == --
-- ============================================================================================================ --
BuilderGroup {
    -- Build MassExtractors / Creators
    BuilderGroupName = 'U1 MassBuilders',
    BuildersType = 'EngineerBuilder',
    -- ================== --
    --    TECH 1 - CDR    --
    -- ================== --
    Builder {
        BuilderName = 'UC Mass 12 initial',
        PlatoonTemplate = 'CommanderBuilder',
        Priority = 19400,
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.NeedMass then
                return 19400
            else
                return 0
            end
        end,
        BuilderConditions = {
            NotOutpost,
            { MABC, 'CanBuildOnMass', { 'LocationType', 12, -500, 1, 0, 'AntiSurface', 1 }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.STRUCTURE * categories.MASSEXTRACTION }},
        },
        BuilderType = 'Any',
        BuilderData = {
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T1Resource',
                },
            }
        }
    },
    Builder {
        BuilderName = 'UC Mass 12',
        PlatoonTemplate = 'CommanderBuilder',
        Priority = 19100,
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.NeedMass then
                return 19100
            else
                return 0
            end
        end,
        BuilderConditions = {
            NotOutpost,
            { MABC, 'CanBuildOnMass', { 'LocationType', 12, -500, 1, 0, 'AntiSurface', 1 }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.STRUCTURE * categories.MASSEXTRACTION }},
        },
        BuilderType = 'Any',
        BuilderData = {
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T1Resource',
                },
            }
        }
    },
    Builder {
        BuilderName = 'UC Mass 12 NoRush',
        PlatoonTemplate = 'CommanderBuilder',
        Priority = 19100,
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.NoRush1stPhaseActive then
                return 19100
            else
                return 0
            end
        end,
        BuilderConditions = {
            NotOutpost,
            { MABC, 'CanBuildOnMass', { 'LocationType', 12, -500, 1, 0, 'AntiSurface', 1 }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.STRUCTURE * categories.MASSEXTRACTION }},
        },
        BuilderType = 'Any',
        BuilderData = {
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T1Resource',
                },
            }
        }
    },
    Builder {
        BuilderName = 'U1 Mass x NoRush',
        PlatoonTemplate = 'EngineerBuilder',
        Priority = 17900,
        DelayEqualBuildPlattons = {'Mass', 05},
        InstanceCount = 2,
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.NoRush1stPhaseActive then
                return 17900
            else
                return 0
            end
        end,
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'CheckBuildPlattonDelay', { 'Mass' }},
            { EBC, 'GreaterThanEconStorageRatio', { -9.99, 0.01 } },
            { MABC, 'CanBuildOnMass', { 'LocationType', NoRushRadius, -500, 1, 0, 'AntiSurface', 1 }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T1Resource',
                }
            }
        }
    },
    -- ======================= --
    --    TECH 1 - Engineer    --
    -- ======================= --
    Builder {
        BuilderName = 'U1 Mass 30',
        PlatoonTemplate = 'EngineerBuilder',
        Priority = 17900,
        InstanceCount = 2,
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.NeedMass then
                return 17900
            else
                return 0
            end
        end,
        BuilderConditions = {
            NotOutpost,
            { EBC, 'GreaterThanEconStorageRatio', { -9.99, 0.01 } },
            { MABC, 'CanBuildOnMass', { 'LocationType', 30, false, false, false, 'AntiSurface', 1 }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                RepeatBuild = true,
                BuildStructures = {
                    'T1Resource',
                }
            }
        }
    },
    Builder {
        BuilderName = 'U1 Mass 60',
        PlatoonTemplate = 'EngineerBuilder',
        Priority = 17880,
        InstanceCount = 2,
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.NeedMass then
                return 17880
            else
                return 0
            end
        end,
        BuilderConditions = {
            NotOutpost,
            { EBC, 'GreaterThanEconStorageRatio', { -9.99, 1.00 } },
            { MABC, 'CanBuildOnMass', { 'LocationType', 60, -500, 1, 0, 'AntiSurface', 1 }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                RepeatBuild = true,
                BuildStructures = {
                    'T1Resource',
                }
            }
        }
    },
    Builder {
        BuilderName = 'U1 Mass 1000 6+',
        PlatoonTemplate = 'EngineerBuilder',
        Priority = 17850,
        InstanceCount = 2,
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.NeedMass then
                return 17850
            else
                return 0
            end
        end,
        BuilderConditions = {
            NotOutpost,
            { EBC, 'GreaterThanEconStorageRatio', { -9.99, 0.10 } },
            { MABC, 'CanBuildOnMass', { 'LocationType', 1000, false, false, false, 'AntiSurface', 1 }},
        },
        BuilderType = 'Any',
        BuilderData = {
            RequireTransport = true,
            Construction = {
                RepeatBuild = true,
                BuildStructures = {
                    'T1Resource',
                }
            }
        }
    },
    Builder {
        BuilderName = 'U1 Mass 1000 8+',
        PlatoonTemplate = 'EngineerBuilder',
        Priority = 17830,
        InstanceCount = 2,
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.NeedMass then
                return 17830
            else
                return 0
            end
        end,
        BuilderConditions = {
            NotOutpost,
            { EBC, 'GreaterThanEconStorageRatio', { -9.99, 1.00 } },
            { MABC, 'CanBuildOnMass', { 'LocationType', 1000, -500, 1, 0, 'AntiSurface', 1 }},
        },
        BuilderType = 'Any',
        BuilderData = {
            RequireTransport = true,
            Construction = {
                RepeatBuild = true,
                BuildStructures = {
                    'T1Resource',
                }
            }
        }
    },
    Builder {
        BuilderName = 'U1 Mass 1000 10+',
        PlatoonTemplate = 'EngineerBuilder',
        Priority = 17810,
        InstanceCount = 2,
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.NeedMass then
                return 17810
            else
                return 0
            end
        end,
        BuilderConditions = {
            NotOutpost,
            { EBC, 'GreaterThanEconStorageRatio', { -9.99, 1.00 } },
            { MABC, 'CanBuildOnMass', { 'LocationType', 1000, -500, 1, 0, 'AntiSurface', 1 }},
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 3, categories.ENGINEER * categories.TECH1 - categories.STATIONASSISTPOD }},
        },
        BuilderType = 'Any',
        BuilderData = {
            RequireTransport = true,
            Construction = {
                RepeatBuild = true,
                BuildStructures = {
                    'T1Resource',
                }
            }
        }
    },
    Builder {
        BuilderName = 'UC Resource RECOVER',
        PlatoonTemplate = 'CommanderBuilder',
        Priority = 19100,
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.NeedMass then
                return 19100
            else
                return 0
            end
        end,
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'BuildOnlyOnLocation', { 'LocationType', 'MAIN' } },
            { MABC, 'CanBuildOnMass', { 'LocationType', 60, -5000, 1, 0, 'AntiSurface', 1 }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.STRUCTURE * categories.MASSEXTRACTION } },
            { UCBC, 'GreaterThanGameTimeSeconds', { 2*60 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T1Resource',
                }
            }
        }
    },
    Builder {
        BuilderName = 'U1 Resource RECOVER',
        PlatoonTemplate = 'EngineerBuilder',
        Priority = 19100,
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.NeedMass then
                return 19100
            else
                return 0
            end
        end,
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'BuildOnlyOnLocation', { 'LocationType', 'MAIN' } },
            { MABC, 'CanBuildOnMass', { 'LocationType', 60, -5000, 1, 0, 'AntiSurface', 1 }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.STRUCTURE * categories.MASSEXTRACTION } },
            { UCBC, 'GreaterThanGameTimeSeconds', { 2*60 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T1Resource',
                }
            }
        }
    },
    -- ============ --
    --    TECH 3    --
    -- ============ --
    Builder {
        BuilderName = 'U3 Mass Fab',
        PlatoonTemplate = 'T3EngineerBuilderNoSUB',
        Priority = 16200,
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.HasParagon then
                return 0
            else
                return 16200
            end
        end,
        BuilderConditions = {
            NotOutpost,
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.40, 1.00}},
            { UCBC, 'HaveUnitRatioUveso', { 0.3, categories.STRUCTURE * categories.MASSFABRICATION, '<=',categories.STRUCTURE * categories.ENERGYPRODUCTION * categories.TECH3 } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE * categories.MASSFABRICATION } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingUpgrade', { 1, categories.STRUCTURE * categories.MASSEXTRACTION * categories.TECH2 }},
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapMass , '<', categories.STRUCTURE * (categories.MASSEXTRACTION + categories.MASSFABRICATION) } },

        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                DesiresAssist = true,
                NumAssistees = 4,
                AdjacencyCategory = categories.STRUCTURE * categories.ENERGYPRODUCTION * categories.TECH3,
                AdjacencyDistance = 50,
                AvoidCategory = categories.MASSFABRICATION,
                maxUnits = 0,
                maxRadius = 15,
                BuildClose = true,
                BuildStructures = {
                    'T3MassCreation',
                },
            }
        }
    },
    Builder {
        BuilderName = 'U1 Reclaim T1+T2 Massfabrikation',
        PlatoonTemplate = 'EngineerBuilder',
        PlatoonAIPlan = 'ReclaimStructuresAI',
        Priority = 790,
        InstanceCount = 2,
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.STRUCTURE * categories.MASSFABRICATION * categories.TECH3 }},
            { UCBC, 'UnitsGreaterAtLocation', { 'LocationType', 0, categories.STRUCTURE * categories.MASSFABRICATION * (categories.TECH1 + categories.TECH2) }},
        },
        BuilderData = {
            Location = 'LocationType',
            Reclaim = {categories.STRUCTURE * categories.MASSFABRICATION * (categories.TECH1 + categories.TECH2)},
        },
        BuilderType = 'Any',
    },
}
