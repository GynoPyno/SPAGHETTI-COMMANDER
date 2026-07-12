-- OWPlus Engineer Builders.lua
-- Sostituisce 'U123 Engineer Builders' di Uveso nel template OverwhelmPlus.
--
-- Differenza chiave rispetto all'originale:
--   Tutti i builder T1 hanno la condizione aggiuntiva:
--     HaveLessThanUnitsWithCategory { 1, STRUCTURE * FACTORY * LAND * TECH3 }
--   → non appena esiste una T3 factory (HQ o support), nessun ingegnere T1
--     viene più prodotto. Le fabbriche si concentrano su T3 engineers.
--
-- I builder T1 "panic" (priority 19100) erano il problema principale:
--   senza gate, continuavano a rubare slot fabbrica anche con 30 T3 eng nel pool
--   perché controllavano solo il count di T1 engineers (che ovviamente è 0 a T3).
--
-- T2 e T3 builders sono identici all'originale Uveso.

local categories = categories
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local UCBC = '/lua/editor/UnitCountBuildConditions.lua'

local BasePanicZone, BaseMilitaryZone, BaseEnemyZone = import('/mods/AI-Uveso/lua/AI/AITargetManager.lua').GetDangerZoneRadii()

local MaxCapEngineers = 0.15
-- Gate comune per tutti i builder T1: smetti se esiste una T3 factory (HQ o support)
local NoT3Factory = { UCBC, 'HaveLessThanUnitsWithCategory', { 1,
    categories.STRUCTURE * categories.FACTORY * categories.LAND * categories.TECH3 } }

-- Fase A (B16): questi builder T1 non hanno mai avuto uno scoping di location (a
-- differenza di 'noPool 10' che gia' restringeva a MAIN) — ora che le fabbriche
-- avamposto (OUT#) sono registrate in un BuilderManager reale (9-F19/20), senza
-- questo gate produrrebbero ingegneri T1 anche li', in parallelo e senza rispettare
-- il cap dedicato di 'OWPlus Outpost Engineer Builders.lua' (che usa un conteggio
-- per-avamposto, non l'HaveUnitRatioVersusCap globale usato qui).
-- Fix sess.76: BuildNotOnLocation confrontava il LocationType reale contro la
-- stringa statica 'OUT' (string.find), ma AddFactoryToClosestManager assegna
-- agli avamposti un LocationType generato a runtime tipo "Expansion Area U3",
-- mai contenente 'OUT' — il gate non ha MAI escluso nulla dalla Fase A in poi.
-- OWPlusNotOutpostLocation (hook/lua/editor/unitcountbuildconditions.lua)
-- controlla invece l'appartenenza a aiBrain.OWPlusOutpostLocationTypes.
local NotOutpost = { UCBC, 'OWPlusNotOutpostLocation', { 'LocationType' } }

-- Fix sess.76: BuilderGroupName era 'OWPlus Engineer Builders' (nome diverso
-- dall'originale) invece di 'U123 Engineer Builders' — il commento in testa al
-- file dice "sostituisce", ma con un nome diverso il gruppo si AGGIUNGE soltanto
-- accanto allo stock invece di sovrascriverlo (registry override-by-same-name,
-- Conoscenze_AI_35 §35.5). Per MAIN (template 'overwhelmplus', che referenzia
-- questo gruppo per nome esplicito in riga separata) l'effetto era invisibile
-- perche' quel template non elenca mai 'U123 Engineer Builders' stock. Per gli
-- avamposti pero' il template STOCK 'UvesoExpansionArea' (Uveso ExpansionArea.lua)
-- elenca esplicitamente 'U123 Engineer Builders' — mai sovrascritto finora,
-- quindi ogni avamposto produceva ingegneri T1 anche via lo stock, senza
-- NoT3Factory ne' NotOutpost. Rinominando il gruppo qui, l'override-by-same-name
-- lo sostituisce ovunque venga referenziato per nome, MAIN incluso.
BuilderGroup {
    BuilderGroupName = 'U123 Engineer Builders',
    BuildersType = 'FactoryBuilder',

    -- ============ --
    --    TECH 1    --
    -- ============ --
    Builder {
        BuilderName = 'OWPlus U1 Engineer builder Panic1',
        PlatoonTemplate = 'T1BuildEngineer',
        Priority = 19100,
        BuilderConditions = {
            NoT3Factory,
            NotOutpost,
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.MOBILE * categories.ENGINEER * categories.TECH1 - categories.COMMAND } },
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, categories.MOBILE * categories.ENGINEER * categories.TECH1 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 3, categories.MOBILE * (categories.DIRECTFIRE + categories.INDIRECTFIRE) } },
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapEngineers / 3 , '<', categories.MOBILE * categories.ENGINEER * categories.TECH1 } },
        },
        BuilderType = 'All',
    },
    Builder {
        BuilderName = 'OWPlus U1 Engineer builder Panic2',
        PlatoonTemplate = 'T1BuildEngineer',
        Priority = 19100,
        BuilderConditions = {
            NoT3Factory,
            NotOutpost,
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.MOBILE * categories.ENGINEER * categories.TECH1 - categories.COMMAND } },
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, categories.MOBILE * categories.ENGINEER * categories.TECH1 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 6, categories.MOBILE * (categories.DIRECTFIRE + categories.INDIRECTFIRE) } },
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapEngineers / 3 , '<', categories.MOBILE * categories.ENGINEER * categories.TECH1 } },
        },
        BuilderType = 'All',
    },
    Builder {
        BuilderName = 'OWPlus U1 Engineer builder Cap',
        PlatoonTemplate = 'T1BuildEngineer',
        Priority = 18990,
        BuilderConditions = {
            NoT3Factory,
            NotOutpost,
            { UCBC, 'HaveLessThanUnitsWithCategory', { 6, categories.MOBILE * categories.ENGINEER * categories.TECH1 } },
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, categories.ENGINEER * categories.TECH1 } },
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapEngineers / 3 , '<', categories.MOBILE * categories.ENGINEER * categories.TECH1 } },
        },
        BuilderType = 'All',
    },
    Builder {
        BuilderName = 'OWPlus U1 Engineer noPool 10',
        PlatoonTemplate = 'T1BuildEngineer',
        Priority = 18700,
        BuilderConditions = {
            NoT3Factory,
            { UCBC, 'BuildOnlyOnLocation', { 'LocationType', 'MAIN' } },
            { UCBC, 'PoolLessAtLocation', { 'LocationType', 10, categories.MOBILE * categories.ENGINEER * categories.TECH1 - categories.STATIONASSISTPOD } },
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, categories.ENGINEER * categories.TECH1 } },
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapEngineers / 3 , '<', categories.MOBILE * categories.ENGINEER * categories.TECH1 } },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'OWPlus U1 Engineer noPool land < 3',
        PlatoonTemplate = 'T1BuildEngineer',
        Priority = 18700,
        BuilderConditions = {
            NoT3Factory,
            NotOutpost,
            { UCBC, 'PoolLessAtLocation', { 'LocationType', 3, categories.MOBILE * categories.ENGINEER * categories.TECH1 - categories.STATIONASSISTPOD } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.STRUCTURE * categories.FACTORY * categories.LAND } },
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 2, categories.ENGINEER * categories.TECH1 } },
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapEngineers / 3 , '<', categories.MOBILE * categories.ENGINEER * categories.TECH1 } },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'OWPlus U1 Engineer noPool land < 1',
        PlatoonTemplate = 'T1BuildEngineer',
        Priority = 18500,
        BuilderConditions = {
            NoT3Factory,
            NotOutpost,
            { UCBC, 'PoolLessAtLocation', { 'LocationType', 1, categories.MOBILE * categories.ENGINEER * categories.TECH1 - categories.STATIONASSISTPOD } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.STRUCTURE * categories.FACTORY * categories.LAND } },
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, categories.ENGINEER * categories.TECH1 } },
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapEngineers / 3 , '<', categories.MOBILE * categories.ENGINEER * categories.TECH1 } },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'OWPlus U1 Engineer noPool air',
        PlatoonTemplate = 'T1BuildEngineer',
        Priority = 18400,
        BuilderConditions = {
            NoT3Factory,
            { UCBC, 'PoolLessAtLocation', { 'LocationType', 5, categories.MOBILE * categories.ENGINEER * categories.TECH1 - categories.STATIONASSISTPOD } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.STRUCTURE * categories.FACTORY * categories.AIR } },
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 2, categories.ENGINEER * categories.TECH1 } },
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapEngineers / 3 , '<', categories.MOBILE * categories.ENGINEER * categories.TECH1 } },
        },
        BuilderType = 'Air',
    },
    Builder {
        BuilderName = 'OWPlus U1 Engineer naval 2x',
        PlatoonTemplate = 'T1BuildEngineer',
        Priority = 18400,
        BuilderConditions = {
            NoT3Factory,
            { UCBC, 'EngineerManagerUnitsAtLocation', { 'LocationType', '<', 2, categories.MOBILE * categories.TECH1 } },
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapEngineers / 3 , '<', categories.MOBILE * categories.ENGINEER * categories.TECH1 } },
        },
        BuilderType = 'Sea',
    },

    -- ============ --
    --    TECH 2    --
    -- ============ --
    Builder {
        BuilderName = 'OWPlus U2 Engineer builder Cap',
        PlatoonTemplate = 'T2BuildEngineer',
        Priority = 18500,
        BuilderConditions = {
            { UCBC, 'BuildOnlyOnLocation', { 'LocationType', 'MAIN' } },
            { UCBC, 'EngineerCapCheck', { 'LocationType', 'Tech2' } },
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 2, categories.ENGINEER * categories.TECH2 } },
        },
        BuilderType = 'All',
    },
    Builder {
        BuilderName = 'OWPlus U2 Engineer noPool',
        PlatoonTemplate = 'T2BuildEngineer',
        Priority = 18400,
        BuilderConditions = {
            { UCBC, 'BuildOnlyOnLocation', { 'LocationType', 'MAIN' } },
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.20, 0.20 } },
            { UCBC, 'PoolLessAtLocation', { 'LocationType', 2, categories.MOBILE * categories.ENGINEER * categories.TECH2 - categories.STATIONASSISTPOD } },
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapEngineers / 3 , '<', categories.MOBILE * categories.ENGINEER * categories.TECH2 } },
        },
        BuilderType = 'All',
    },

    -- ============ --
    --    TECH 3    --
    -- ============ --
    Builder {
        BuilderName = 'OWPlus U3 Engineer builder Cap',
        PlatoonTemplate = 'T3BuildEngineer',
        Priority = 18500,
        BuilderConditions = {
            { UCBC, 'BuildOnlyOnLocation', { 'LocationType', 'MAIN' } },
            { UCBC, 'EngineerCapCheck', { 'LocationType', 'Tech3' } },
            -- Fase 9-F15: 2 -> 6, permette a piu' fabbriche di costruire ingegneri T3
            -- in parallelo invece di saturarsi dopo sole 2 (osservato in gioco con
            -- economia abbondante/Paragon: fabbriche libere restavano ferme).
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 6, categories.ENGINEER * categories.TECH3 } },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'OWPlus U3 Engineer builder noPool min',
        PlatoonTemplate = 'T3BuildEngineer',
        Priority = 18500,
        BuilderConditions = {
            { UCBC, 'BuildOnlyOnLocation', { 'LocationType', 'MAIN' } },
            { UCBC, 'PoolLessAtLocation', { 'LocationType', 1, categories.MOBILE * categories.ENGINEER * categories.TECH3 - categories.SUBCOMMANDER - categories.STATIONASSISTPOD } },
            -- Fase 9-F15: 1 -> 6, stesso motivo del builder precedente.
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 6, categories.ENGINEER * categories.TECH3 } },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'OWPlus U3 Engineer noPool Land',
        PlatoonTemplate = 'T3BuildEngineer',
        Priority = 18400,
        BuilderConditions = {
            { UCBC, 'BuildOnlyOnLocation', { 'LocationType', 'MAIN' } },
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.30, 0.30 } },
            -- Fase 9-F15: 3 -> 10, il buffer di ingegneri T3 "in attesa" non deve
            -- fermare la produzione quando l'economia (es. Paragon) puo' sostenerne di piu'.
            { UCBC, 'PoolLessAtLocation', { 'LocationType', 10, categories.MOBILE * categories.ENGINEER * categories.TECH3 - categories.SUBCOMMANDER - categories.STATIONASSISTPOD } },
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapEngineers / 3 , '<', categories.MOBILE * categories.ENGINEER * categories.TECH3 } },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'OWPlus U3 Engineer noPool Air',
        PlatoonTemplate = 'T3BuildEngineer',
        Priority = 18400,
        BuilderConditions = {
            { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.40, 0.40 } },
            -- Fase 9-F15: 3 -> 10, stesso motivo del builder Land precedente.
            { UCBC, 'PoolLessAtLocation', { 'LocationType', 10, categories.MOBILE * categories.ENGINEER * categories.TECH3 - categories.SUBCOMMANDER - categories.STATIONASSISTPOD } },
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapEngineers / 3 , '<', categories.MOBILE * categories.ENGINEER * categories.TECH3 } },
        },
        BuilderType = 'Air',
    },
}
