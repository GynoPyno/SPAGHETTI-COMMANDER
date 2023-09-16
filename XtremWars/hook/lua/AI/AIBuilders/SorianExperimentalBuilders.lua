function T4LandAttackCondition(aiBrain, locationType, targetNumber)
    return true
end

function T4AirAttackCondition(aiBrain, locationType, targetNumber)
    return true
end

BuilderGroup {
    BuilderGroupName = 'SorianMobileExperimentalEngineersGroup',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'Sorian T3 Land Exp1 Engineer 1 Group',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 952,
        BuilderConditions = {
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3}},
			--{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.MASSPRODUCTION * categories.TECH3}},
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.FACTORY * categories.TECH3 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2 }},
			--{ SIBC, 'EngineerNeedsAssistance', { false, 'LocationType', {'EXPERIMENTAL', 'NUKE STRUCTURE', 'TECH3 ARTILLERY STRUCTURE'} }},
			--{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.EXPERIMENTAL * categories.MOBILE * (categories.LAND + categories.AIR) - categories.SATELLITE}},
			--{ UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.EXPERIMENTAL * categories.LAND } },
            { IBC, 'BrainNotLowPowerMode', {} },
			--{ SBC, 'MarkerLessThan', { 'LocationType', {'Amphibious Path Node', 'Land Path Node'}, 100, true } },
			--{ SIBC, 'T4BuildingCheck', {} },
			--{ SBC, 'EnemyThreatLessThanValueAtBase', { 'LocationType', 1, 'Air', 2 } },
        },
        BuilderType = 'Any',
        BuilderData = {
			MinNumAssistees = 8,
            Construction = {
                BuildClose = false,
				#T4 = true,
                BaseTemplate = ExBaseTmpl,
                NearMarkerType = 'Rally Point',
                BuildStructures = {
                    'T4LandExperimental1',
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'Sorian T3 Land Exp2 Engineer 1 Group',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 952,
        BuilderConditions = {
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.GATE}},
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3}},
			--{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.MASSPRODUCTION * categories.TECH3}},
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.FACTORY * categories.TECH3 } },
			--{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.EXPERIMENTAL}},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2 }},
			--{ UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.EXPERIMENTAL * categories.LAND } },
			--{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.EXPERIMENTAL * categories.MOBILE * (categories.LAND + categories.AIR) - categories.SATELLITE}},
			--{ SIBC, 'EngineerNeedsAssistance', { false, 'LocationType', {'EXPERIMENTAL', 'NUKE STRUCTURE', 'TECH3 ARTILLERY STRUCTURE'} }},
            { IBC, 'BrainNotLowPowerMode', {} },
			--{ SBC, 'MarkerLessThan', { 'LocationType', {'Amphibious Path Node', 'Land Path Node'}, 100, true } },
			--{ SIBC, 'T4BuildingCheck', {} },
			--{ SBC, 'EnemyThreatLessThanValueAtBase', { 'LocationType', 1, 'Air', 2 } },
        },
        BuilderType = 'Any',
        BuilderData = {
			MinNumAssistees = 8,
            Construction = {
                BuildClose = false,
				#T4 = true,
                BaseTemplate = ExBaseTmpl,
                NearMarkerType = 'Rally Point',
                BuildStructures = {
                    'T4LandExperimental2',
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'Sorian T3 Air Exp1 Engineer 1 Group',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 952,
        BuilderConditions = {
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.GATE}},
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3}},
			--{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.MASSPRODUCTION * categories.TECH3}},
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.FACTORY * categories.TECH3 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2} },
			--{ UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.EXPERIMENTAL * categories.AIR } },
			--{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.EXPERIMENTAL * categories.MOBILE * (categories.LAND + categories.AIR) - categories.SATELLITE}},
			--{ SIBC, 'EngineerNeedsAssistance', { false, 'LocationType', {'EXPERIMENTAL', 'NUKE STRUCTURE', 'TECH3 ARTILLERY STRUCTURE'} }},
            { IBC, 'BrainNotLowPowerMode', {} },
			--{ SIBC, 'T4BuildingCheck', {} },
			--{ SBC, 'EnemyThreatLessThanValueAtBase', { 'LocationType', 1, 'Air', 2 } },
        },
        BuilderType = 'Any',
        BuilderData = {
			MinNumAssistees = 8,
            Construction = {
                BuildClose = false,
				#T4 = true,
                NearMarkerType = 'Protected Experimental Construction',
                BuildStructures = {
                    'T4AirExperimental1',
                },
                Location = 'LocationType',
            }
        }
    },
}

BuilderGroup {
    BuilderGroupName = 'SorianMobileLandExperimentalEngineers',
    BuildersType = 'EngineerBuilder',
	#Land T4 builders for 10x10 and smaller maps
    Builder {
        BuilderName = 'Sorian T3 Land Exp1 Engineer 1',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 950,
        BuilderConditions = {
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.GATE}},
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.ENERGYPRODUCTION * categories.TECH3}},
			--{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.MASSPRODUCTION * categories.TECH3}},
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.FACTORY * categories.TECH3 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2 }},
			--{ SIBC, 'EngineerNeedsAssistance', { false, 'LocationType', {'EXPERIMENTAL', 'NUKE STRUCTURE', 'TECH3 ARTILLERY STRUCTURE'} }},
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'MapLessThan', { 1000, 1000 }},
			--{ SBC, 'MarkerLessThan', { 'LocationType', {'Amphibious Path Node', 'Land Path Node'}, 100, true } },
			--{ SIBC, 'T4BuildingCheck', {} },
			{ SBC, 'EnemyThreatLessThanValueAtBase', { 'LocationType', 1, 'Air', 2 } },
        },
        BuilderType = 'Any',
        BuilderData = {
			MinNumAssistees = 8,
            Construction = {
                BuildClose = false,
				#T4 = true,
                BaseTemplate = ExBaseTmpl,
                NearMarkerType = 'Rally Point',
                BuildStructures = {
                    'T4LandExperimental1',
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'Sorian T3 Land Exp2 Engineer 1',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 950,
        BuilderConditions = {
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.GATE}},
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.ENERGYPRODUCTION * categories.TECH3}},
			--{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.MASSPRODUCTION * categories.TECH3}},
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.FACTORY * categories.TECH3 } },
			--{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.EXPERIMENTAL}},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2 }},
			--{ SIBC, 'EngineerNeedsAssistance', { false, 'LocationType', {'EXPERIMENTAL', 'NUKE STRUCTURE', 'TECH3 ARTILLERY STRUCTURE'} }},
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'MapLessThan', { 1000, 1000 }},
			--{ SBC, 'MarkerLessThan', { 'LocationType', {'Amphibious Path Node', 'Land Path Node'}, 100, true } },
			--{ SIBC, 'T4BuildingCheck', {} },
			{ MIBC, 'FactionIndex', {1, 2, 4} },
			{ SBC, 'EnemyThreatLessThanValueAtBase', { 'LocationType', 1, 'Air', 2 } },
        },
        BuilderType = 'Any',
        BuilderData = {
			MinNumAssistees = 8,
            Construction = {
                BuildClose = false,
				#T4 = true,
                BaseTemplate = ExBaseTmpl,
                NearMarkerType = 'Rally Point',
                BuildStructures = {
                    'T4LandExperimental2',
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'Sorian T3 Land Exp3 Engineer 1',
        PlatoonTemplate = 'CybranT3EngineerBuilderSorian',
        Priority = 950,
        BuilderConditions = {
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.GATE}},
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.ENERGYPRODUCTION * categories.TECH3}},
			--{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.MASSPRODUCTION * categories.TECH3}},
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.FACTORY * categories.TECH3 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2 }},
			--{ SIBC, 'EngineerNeedsAssistance', { false, 'LocationType', {'EXPERIMENTAL', 'NUKE STRUCTURE', 'TECH3 ARTILLERY STRUCTURE'} }},
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'MapLessThan', { 1000, 1000 }},
			--{ SBC, 'MarkerLessThan', { 'LocationType', {'Amphibious Path Node', 'Land Path Node'}, 100, true } },
			--{ SIBC, 'T4BuildingCheck', {} },
			{ SBC, 'EnemyThreatLessThanValueAtBase', { 'LocationType', 1, 'Air', 2 } },
        },
        BuilderType = 'Any',
        BuilderData = {
			MinNumAssistees = 8,
            Construction = {
                BuildClose = false,
				#T4 = true,
                BaseTemplate = ExBaseTmpl,
                NearMarkerType = 'Rally Point',
                BuildStructures = {
                    'T4LandExperimental3',
                },
                Location = 'LocationType',
            }
        }
    },
	#Land T4 builders for 20x20 and larger maps
    Builder {
        BuilderName = 'Sorian T3 Land Exp1 Engineer 1 - Large Map',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 949,
        BuilderConditions = {
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.GATE}},
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.ENERGYPRODUCTION * categories.TECH3}},
			--{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.MASSPRODUCTION * categories.TECH3}},
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.FACTORY * categories.TECH3 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2 }},
			--{ SIBC, 'EngineerNeedsAssistance', { false, 'LocationType', {'EXPERIMENTAL', 'NUKE STRUCTURE', 'TECH3 ARTILLERY STRUCTURE'} }},
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'MapGreaterThan', { 1000, 1000 }},
			--{ SBC, 'MarkerLessThan', { 'LocationType', {'Amphibious Path Node', 'Land Path Node'}, 100, true } },
			--{ SIBC, 'T4BuildingCheck', {} },
			{ SBC, 'EnemyThreatLessThanValueAtBase', { 'LocationType', 1, 'Air', 2 } },
        },
        BuilderType = 'Any',
        BuilderData = {
			MinNumAssistees = 8,
            Construction = {
                BuildClose = false,
				#T4 = true,
                BaseTemplate = ExBaseTmpl,
                NearMarkerType = 'Rally Point',
                BuildStructures = {
                    'T4LandExperimental1',
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'Sorian T3 Land Exp2 Engineer 1 - Large Map',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 949,
        BuilderConditions = {
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.GATE}},
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.ENERGYPRODUCTION * categories.TECH3}},
			--{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.MASSPRODUCTION * categories.TECH3}},
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.FACTORY * categories.TECH3 } },
			--{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.EXPERIMENTAL}},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2 }},
			--{ SIBC, 'EngineerNeedsAssistance', { false, 'LocationType', {'EXPERIMENTAL', 'NUKE STRUCTURE', 'TECH3 ARTILLERY STRUCTURE'} }},
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'MapGreaterThan', { 1000, 1000 }},
			--{ SBC, 'MarkerLessThan', { 'LocationType', {'Amphibious Path Node', 'Land Path Node'}, 100, true } },
			--{ SIBC, 'T4BuildingCheck', {} },
			{ MIBC, 'FactionIndex', {1, 2, 4} },
			{ SBC, 'EnemyThreatLessThanValueAtBase', { 'LocationType', 1, 'Air', 2 } },
        },
        BuilderType = 'Any',
        BuilderData = {
			MinNumAssistees = 8,
            Construction = {
                BuildClose = false,
				#T4 = true,
                BaseTemplate = ExBaseTmpl,
                NearMarkerType = 'Rally Point',
                BuildStructures = {
                    'T4LandExperimental2',
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'Sorian T3 Land Exp3 Engineer 1 - Large Map',
        PlatoonTemplate = 'CybranT3EngineerBuilderSorian',
        Priority = 949,
        BuilderConditions = {
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.GATE}},
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.ENERGYPRODUCTION * categories.TECH3}},
			--{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.MASSPRODUCTION * categories.TECH3}},
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.FACTORY * categories.TECH3 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2 }},
			--{ SIBC, 'EngineerNeedsAssistance', { false, 'LocationType', {'EXPERIMENTAL', 'NUKE STRUCTURE', 'TECH3 ARTILLERY STRUCTURE'} }},
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'MapGreaterThan', { 1000, 1000 }},
			--{ SBC, 'MarkerLessThan', { 'LocationType', {'Amphibious Path Node', 'Land Path Node'}, 100, true } },
			--{ SIBC, 'T4BuildingCheck', {} },
			{ SBC, 'EnemyThreatLessThanValueAtBase', { 'LocationType', 1, 'Air', 2 } },
        },
        BuilderType = 'Any',
        BuilderData = {
			MinNumAssistees = 8,
            Construction = {
                BuildClose = false,
				#T4 = true,
                BaseTemplate = ExBaseTmpl,
                NearMarkerType = 'Rally Point',
                BuildStructures = {
                    'T4LandExperimental3',
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'Sorian T2 Engineer Assist Experimental Mobile Land',
        PlatoonTemplate = 'T2EngineerAssistSorian',
        Priority = 800,
        InstanceCount = 5,
        BuilderConditions = {
            --{ UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.EXPERIMENTAL * categories.LAND * categories.MOBILE}},
            { IBC, 'BrainNotLowPowerMode', {} },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2} },
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                AssistRange = 250,
                BeingBuiltCategories = {'EXPERIMENTAL MOBILE LAND'},
                Time = 60,
            },
        }
    },
    Builder {
        BuilderName = 'Sorian T3 Engineer Assist Experimental Mobile Land',
        PlatoonTemplate = 'T3EngineerAssistSorian',
        Priority = 951,
        InstanceCount = 5,
        BuilderConditions = {
            --{ UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.EXPERIMENTAL * categories.LAND * categories.MOBILE}},
            { IBC, 'BrainNotLowPowerMode', {} },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2} },
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
				AssistUntilFinished = true,
                AssistRange = 250,
                BeingBuiltCategories = {'EXPERIMENTAL MOBILE LAND'},
                Time = 60,
            },
        }
    },
}

BuilderGroup {
    BuilderGroupName = 'SorianMobileLandExperimentalForm',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'Sorian T4 Exp Land',
        PlatoonAddPlans = {'NameUnitsSorian', 'DistressResponseAISorian', 'PlatoonCallForHelpAISorian'},
        PlatoonTemplate = 'T4ExperimentalLandSorian',
        Priority = 10000,
        FormRadius = 250,
        InstanceCount = 50,
        BuilderType = 'Any',
        BuilderConditions = {
            --{ SIBC, 'HaveLessThanUnitsWithCategory', { 3, 'EXPERIMENTAL MOBILE LAND, EXPERIMENTAL MOBILE AIR'}},
			--{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 1, 'FACTORY TECH1, FACTORY TECH2' } },
			--{ T4LandAttackCondition, { 'LocationType', 250 } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
			ThreatSupport = 300,
            ThreatWeights = {
                TargetThreatType = 'Commander',
            },
            UseMoveOrder = true,
            PrioritizedCategories = { 'EXPERIMENTAL LAND', 'COMMAND', 'STRUCTURE ARTILLERY EXPERIMENTAL', 'TECH3 STRATEGIC STRUCTURE', 'MASSFABRICATION', 'ENERGYPRODUCTION', 'STRUCTURE STRATEGIC', 'STRUCTURE DEFENSE ANTIAIR', 'STRUCTURE DEFENSE DIRECTFIRE', 'FACTORY AIR', 'FACTORY LAND' }, # list in order
        },
    },
    Builder {
        BuilderName = 'Sorian T4 Exp Land - Scathis',
        PlatoonAddPlans = {'NameUnitsSorian', 'DistressResponseAISorian', 'PlatoonCallForHelpAISorian'},
        PlatoonTemplate = 'T4ExperimentalScathisSorian',
        Priority = 10000,
        FormRadius = 250,
        InstanceCount = 50,
        BuilderType = 'Any',
        BuilderConditions = {
            --{ SIBC, 'HaveLessThanUnitsWithCategory', { 3, 'EXPERIMENTAL MOBILE LAND, EXPERIMENTAL MOBILE AIR'}},
			--{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 1, 'FACTORY TECH1, FACTORY TECH2' } },
			--{ T4LandAttackCondition, { 'LocationType', 250 } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
			ThreatSupport = 300,
            ThreatWeights = {
                TargetThreatType = 'Commander',
            },
            UseMoveOrder = true,
            PrioritizedCategories = { 'EXPERIMENTAL LAND', 'COMMAND', 'STRUCTURE ARTILLERY EXPERIMENTAL', 'TECH3 STRATEGIC STRUCTURE', 'MASSFABRICATION', 'ENERGYPRODUCTION', 'STRUCTURE STRATEGIC', 'STRUCTURE DEFENSE ANTIAIR', 'STRUCTURE DEFENSE DIRECTFIRE', 'FACTORY AIR', 'FACTORY LAND' }, # list in order
        },
    },
    Builder {
        BuilderName = 'Sorian T4 Exp Land Unit Cap',
        PlatoonAddPlans = {'NameUnitsSorian', 'DistressResponseAISorian', 'PlatoonCallForHelpAISorian'},
        PlatoonTemplate = 'T4ExperimentalLandSorian',
        Priority = 10000,
        FormRadius = 250,
        InstanceCount = 50,
        BuilderType = 'Any',
        BuilderConditions = {
            --{ SIBC, 'HaveLessThanUnitsWithCategory', { 3, 'EXPERIMENTAL MOBILE LAND, EXPERIMENTAL MOBILE AIR'}},
			--{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 1, 'FACTORY TECH1, FACTORY TECH2' } },
			--{ UCBC, 'UnitCapCheckGreater', { .95 } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
			ThreatSupport = 300,
            ThreatWeights = {
                TargetThreatType = 'Commander',
            },
            UseMoveOrder = true,
            PrioritizedCategories = { 'EXPERIMENTAL LAND', 'COMMAND', 'STRUCTURE ARTILLERY EXPERIMENTAL', 'TECH3 STRATEGIC STRUCTURE', 'MASSFABRICATION', 'ENERGYPRODUCTION', 'STRUCTURE STRATEGIC', 'STRUCTURE DEFENSE ANTIAIR', 'STRUCTURE DEFENSE DIRECTFIRE', 'FACTORY AIR', 'FACTORY LAND' }, # list in order
        },
    },
}

BuilderGroup {
    BuilderGroupName = 'SorianMobileAirExperimentalEngineers',
    BuildersType = 'EngineerBuilder',
	#Air T4 builders for 20x20 and larger maps
    Builder {
        BuilderName = 'Sorian T3 Air Exp1 Engineer 1',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 950,
        BuilderConditions = {
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.GATE}},
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.ENERGYPRODUCTION * categories.TECH3}},
			--{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.MASSPRODUCTION * categories.TECH3}},
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.FACTORY * categories.TECH3 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2} },
			--{ SIBC, 'EngineerNeedsAssistance', { false, 'LocationType', {'EXPERIMENTAL', 'NUKE STRUCTURE', 'TECH3 ARTILLERY STRUCTURE'} }},
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'MapGreaterThan', { 1000, 1000 }},
			--{ SIBC, 'T4BuildingCheck', {} },
			{ SBC, 'EnemyThreatLessThanValueAtBase', { 'LocationType', 1, 'Air', 2 } },
        },
        BuilderType = 'Any',
        BuilderData = {
			MinNumAssistees = 8,
            Construction = {
                BuildClose = false,
				#T4 = true,
                NearMarkerType = 'Protected Experimental Construction',
                BuildStructures = {
                    'T4AirExperimental1',
                },
                Location = 'LocationType',
            }
        }
    },
	#Air T4 builders for 10x10 and smaller maps
    Builder {
        BuilderName = 'Sorian T3 Air Exp1 Engineer 1 - Small Map',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 949,
        BuilderConditions = {
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.GATE}},
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.ENERGYPRODUCTION * categories.TECH3}},
			--{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.MASSPRODUCTION * categories.TECH3}},
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.FACTORY * categories.TECH3 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2} },
			--{ SIBC, 'EngineerNeedsAssistance', { false, 'LocationType', {'EXPERIMENTAL', 'NUKE STRUCTURE', 'TECH3 ARTILLERY STRUCTURE'} }},
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'MapLessThan', { 1000, 1000 }},
			--{ SIBC, 'T4BuildingCheck', {} },
			{ SBC, 'EnemyThreatLessThanValueAtBase', { 'LocationType', 1, 'Air', 2 } },
        },
        BuilderType = 'Any',
        BuilderData = {
			MinNumAssistees = 8,
            Construction = {
                BuildClose = false,
				#T4 = true,
                NearMarkerType = 'Protected Experimental Construction',
                BuildStructures = {
                    'T4AirExperimental1',
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'Sorian T2 Engineer Assist Experimental Mobile Air',
        PlatoonTemplate = 'T2EngineerAssistSorian',
        Priority = 800,
        InstanceCount = 5,
        BuilderConditions = {
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.EXPERIMENTAL * categories.AIR * categories.MOBILE}},
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.ENERGYPRODUCTION * categories.TECH3}},
            { IBC, 'BrainNotLowPowerMode', {} },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2} },
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                AssistRange = 250,
                BeingBuiltCategories = {'EXPERIMENTAL MOBILE AIR'},
                Time = 60,
            },
        }
    },
    Builder {
        BuilderName = 'Sorian T3 Engineer Assist Experimental Mobile Air',
        PlatoonTemplate = 'T3EngineerAssistSorian',
        Priority = 951,
        InstanceCount = 5,
        BuilderConditions = {
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.EXPERIMENTAL * categories.AIR * categories.MOBILE}},
            { IBC, 'BrainNotLowPowerMode', {} },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2} },
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
				AssistUntilFinished = true,
                AssistRange = 250,
                BeingBuiltCategories = {'EXPERIMENTAL MOBILE AIR'},
                Time = 60,
            },
        }
    },
}


