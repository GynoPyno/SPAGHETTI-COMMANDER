-- OWPlus Vacant Expansion Area.lua
-- Fase 9-F6: builder aggiuntivo per aumentare i tentativi simultanei di
-- rivendicazione marker di espansione (InstanceCount stock Uveso = 1, troppo poco).
--
-- Fase 9-F9: trigger deterministico a due livelli, al posto delle soglie economiche
-- copiate dallo stock (GreaterThanEconIncome/GreaterThanEconStorageRatio) che
-- rendevano l'attivazione imprevedibile (osservato in test: fino a 34 minuti di
-- ritardo prima della prima rivendicazione). L'utente vuole la prima forward base
-- il prima possibile dopo un minimo sviluppo di MAIN, non legata all'economia:
--   Tier 1 (prima base):   >=1 estrattore + >=1 fabbrica di terra a MAIN
--   Tier 2 (basi 2a-4a):   >=2 estrattori + >=2 fabbriche di terra a MAIN
-- (soglia Tier 2 provvisoria, facile da alzare se serve piu' margine prima di
-- inviare altri ingegneri fuori da MAIN)
--
-- NON tocchiamo il file originale di Uveso (hook minimale): 'U1 Vacant Expansion Area'
-- stock resta invariato come fallback aggiuntivo (raramente scattera' per le sue
-- stesse soglie economiche, ma non fa danno lasciarlo attivo).

local categories = categories
local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local OWPlusLogCond = '/mods/AI-Uveso-child/lua/AI/OWPlusLogConditions.lua'

local MaxCapFactory   = 0.024
local MaxCapStructure = 0.25

local LAND_FAC = categories.STRUCTURE * categories.FACTORY * categories.LAND
local MEX      = categories.STRUCTURE * categories.MASSEXTRACTION

local ExpansionConstructionData = {
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

BuilderGroup {
    BuilderGroupName = 'OWPlus Vacant Expansion Area',
    BuildersType = 'EngineerBuilder',

    -- Tier 1: prima forward base, trigger immediato (nessuna soglia economica)
    Builder {
        BuilderName = 'OWPlus Vacant Expansion Area Tier1',
        PlatoonTemplate = 'EngineerBuilder',
        Priority = 15300,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'ExpansionBaseCheck', {} },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, MEX } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, LAND_FAC } },
            { UCBC, 'ExpansionAreaNeedsEngineer', { 'LocationType', 1000, -1000, 100, 1, 'StructuresNotMex' } },
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapFactory,   '<', LAND_FAC } },
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapStructure, '<', categories.STRUCTURE - MEX - categories.DEFENSE - categories.FACTORY } },
            { OWPlusLogCond, 'OWPlusForwardCountInRange', { 0, 1 } },
        },
        BuilderType = 'Any',
        BuilderData = ExpansionConstructionData,
    },

    -- Tier 2: basi 2a-4a, soglia piu' alta (MAIN un po' piu' sviluppata prima di
    -- mandare altri ingegneri fuori). InstanceCount=2: fino a 2 tentativi paralleli.
    Builder {
        BuilderName = 'OWPlus Vacant Expansion Area Tier2',
        PlatoonTemplate = 'EngineerBuilder',
        Priority = 15300,
        InstanceCount = 2,
        BuilderConditions = {
            { UCBC, 'ExpansionBaseCheck', {} },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 1, MEX } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 1, LAND_FAC } },
            { UCBC, 'ExpansionAreaNeedsEngineer', { 'LocationType', 1000, -1000, 100, 1, 'StructuresNotMex' } },
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapFactory,   '<', LAND_FAC } },
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapStructure, '<', categories.STRUCTURE - MEX - categories.DEFENSE - categories.FACTORY } },
            { OWPlusLogCond, 'OWPlusForwardCountInRange', { 1, 4 } },
        },
        BuilderType = 'Any',
        BuilderData = ExpansionConstructionData,
    },
}
