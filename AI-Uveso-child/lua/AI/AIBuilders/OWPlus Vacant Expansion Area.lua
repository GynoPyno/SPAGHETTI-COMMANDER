-- OWPlus Vacant Expansion Area.lua
-- Fase 9-F6: builder aggiuntivo per aumentare i tentativi simultanei di
-- rivendicazione marker di espansione.
--
-- Problema: 'U1 Vacant Expansion Area' di Uveso (Expansion.lua) ha InstanceCount = 1
-- — un solo ingegnere alla volta puo' essere in missione di espansione, per tutta
-- la partita. Finche' quel tentativo non si conclude, nessun altro marker viene
-- rivendicato, indipendentemente da quanti siano liberi sulla mappa.
--
-- Soluzione: NON tocchiamo il file originale di Uveso (hook minimale). Aggiungiamo
-- un builder con nome diverso, stesse condizioni/BuilderData, ma InstanceCount piu'
-- alto. Si somma allo slot di Uveso: 1 (stock) + 3 (nostro) = fino a 4 tentativi
-- simultanei, coerente con MAX_FORWARD_BASES=4 in Uveso Forward Base OverwhelmPlus.lua.

local categories = categories
local EBC  = '/lua/editor/EconomyBuildConditions.lua'
local UCBC = '/lua/editor/UnitCountBuildConditions.lua'

local MaxCapFactory   = 0.024
local MaxCapStructure = 0.25

BuilderGroup {
    BuilderGroupName = 'OWPlus Vacant Expansion Area',
    BuildersType = 'EngineerBuilder',

    Builder {
        BuilderName = 'OWPlus Vacant Expansion Area Extra',
        PlatoonTemplate = 'EngineerBuilder',
        Priority = 15300,
        InstanceCount = 3,
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.NoRush1stPhaseActive then
                return 0
            else
                return 15300
            end
        end,
        BuilderConditions = {
            { EBC,  'GreaterThanEconIncome',       { 1.0, 6.0 } },
            { EBC,  'GreaterThanEconStorageRatio', { 0.35, 0.99 } },
            { UCBC, 'ExpansionBaseCheck', {} },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.STRUCTURE * categories.LAND * categories.FACTORY } },
            { UCBC, 'ExpansionAreaNeedsEngineer', { 'LocationType', 1000, -1000, 100, 1, 'StructuresNotMex' } },
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapFactory,   '<', categories.STRUCTURE * categories.FACTORY * categories.LAND } },
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapStructure, '<', categories.STRUCTURE - categories.MASSEXTRACTION - categories.DEFENSE - categories.FACTORY } },
        },
        BuilderType = 'Any',
        BuilderData = {
            RequireTransport = false,
            Construction = {
                BuildClose      = false,
                BaseTemplate    = 'ExpansionBaseTemplates',
                ExpansionBase   = true,
                NearMarkerType  = 'Expansion Area',
                LocationRadius  = 1000,
                LocationType    = 'LocationType',
                ThreatMin       = -1000,
                ThreatMax       = 100,
                ThreatRings     = 1,
                ThreatType      = 'StructuresNotMex',
                ExpansionRadius = 100,
                BuildStructures = {
                    'T1LandFactory',
                    'T1Radar',
                }
            },
        }
    },
}
