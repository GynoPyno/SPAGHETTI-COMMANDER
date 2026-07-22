-- OWPlus Outpost Factory Upgrade.lua
-- Fase B (B16 - Avamposti autonomi): trigger economico per l'upgrade di tier
-- della fabbrica di un avamposto (T1->T2->T3).
--
-- Meccanismo: NON un EngineerBuilder (nessun ingegnere viene inviato) — riusa il
-- pattern vanilla 'PlatoonFormBuilder' (vedi /lua/ai/AIEconomyUpgradeBuilders.lua,
-- BuilderGroup 'T1BalancedUpgradeBuilders'/'T2BalancedUpgradeBuilders'), gia'
-- usato da Uveso stesso per gli upgrade fabbrica di MAIN: il builder FORMA un
-- plotone attorno alla fabbrica esistente che soddisfa GlobalSquads (per
-- categoria+tier) entro FormRadius, poi esegue PlatoonTemplate.Plan =
-- 'UnitUpgradeAI' (funzione vanilla in platoon.lua, IssueUpgrade diretto
-- sull'unita' — nessun codice custom necessario per l'upgrade in se').
--
-- Soglia 15% storage (vs 10% "tipico" usato altrove per MAIN, da design B16) +
-- priorita' 18400, sopra il range 18200-18300 dei builder sperimentali di MAIN
-- ('OWPlus Experimental.lua') — l'eccedenza economica va prima all'espansione
-- avamposti. GreaterThanEconStorageRatio e' un check ARMY-WIDE (non per-location,
-- verificato in EconomyBuildConditions.lua vanilla), coerente con l'uso identico
-- gia' visto in OWPlus Engineer Builders.lua.
--
-- FormRadius scala all'avamposto (40, non i 10000 army-wide di vanilla — qui
-- serve prendere SOLO la fabbrica di QUESTO avamposto, non una qualunque in
-- giro per la mappa). LocationFactoriesBuildingLess evita upgrade doppi in
-- parallelo sullo stesso avamposto. Templates T1->T2 e T2->T3 per Land+Air
-- (gli unici tipi usati dalla ricetta avamposto, vedi OWPlusOutpostGenerator.lua).

local categories = categories
-- UCBC/EBC rimossi temporaneamente (sess.72): condizioni economia/location passano
-- ora dai wrapper diagnostici OWPlusDebug* in OWPlusLogConditions.lua, da
-- rimettere dirette a diagnosi completata.
local OWPlusLogCond = '/mods/AI-Uveso-child/lua/AI/OWPlusLogConditions.lua'

local OUTPOST_UPGRADE_STORAGE_RATIO = 0.15

-- Fix sess.77 (bug reale trovato in game: valutazione builder per l'intera
-- location bloccata per sempre dopo un salto di tier). InstanceCount=20 era
-- copiato dal pattern vanilla T1BalancedUpgradeBuilders (pensato per basi MAIN
-- con decine di fabbriche contemporanee sparse su tutta la mappa). Un avamposto
-- ha SEMPRE e SOLO una fabbrica (ricetta OWPlusOutpostGenerator.lua): con
-- FormRadius=40, ogni ciclo il motore tentava di formare fino a 20 plotoni
-- sulla stessa identica fabbrica (confermato in dev.log: spam di "upgrade
-- fabbrica avviato" ripetuto decine di volte di fila per lo stesso builder).
-- I plotoni ridondanti (nessuna unita' reale disponibile oltre alla prima)
-- restano fantasma e saturano il bookkeeping del manager per quella location,
-- che smette di essere rivalutata (Engineer E Factory-Upgrade insieme).
local OUTPOST_UPGRADE_INSTANCE_COUNT = 1

BuilderGroup {
    BuilderGroupName = 'OWPlus Outpost Factory Upgrade',
    BuildersType = 'PlatoonFormBuilder',

    Builder {
        BuilderName = 'OWPlus Outpost Land Factory Upgrade T1',
        PlatoonTemplate = 'T1LandFactoryUpgrade',
        Priority = 18400,
        InstanceCount = OUTPOST_UPGRADE_INSTANCE_COUNT,
        FormRadius = 40,
        BuilderConditions = {
            { OWPlusLogCond, 'OWPlusOutpostTierUpAllowed', { 'Land Upgrade T1' } },
            { OWPlusLogCond, 'OWPlusIsOutpostLocation', { 'LocationType' } },
            { OWPlusLogCond, 'OWPlusDebugEconStorageRatio', { OUTPOST_UPGRADE_STORAGE_RATIO, OUTPOST_UPGRADE_STORAGE_RATIO, 'Land Upgrade T1' } },
            { OWPlusLogCond, 'OWPlusDebugLocationFactoriesBuildingLess', { 'LocationType', 1, categories.FACTORY * categories.TECH2 + categories.FACTORY * categories.TECH3, 'Land Upgrade T1' } },
            { OWPlusLogCond, 'OWPlusDebugFactoryUpgradeCandidateExists', { 'LocationType', 1, categories.LAND, 'Land Upgrade T1' } },
            { OWPlusLogCond, 'OWPlusClaimFactoryUpgrade', { 'LocationType', 1, categories.LAND, 'OWPlus Outpost Land Factory Upgrade T1' } },
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'OWPlus Outpost Air Factory Upgrade T1',
        PlatoonTemplate = 'T1AirFactoryUpgrade',
        Priority = 18400,
        InstanceCount = OUTPOST_UPGRADE_INSTANCE_COUNT,
        FormRadius = 40,
        BuilderConditions = {
            { OWPlusLogCond, 'OWPlusOutpostTierUpAllowed', { 'Air Upgrade T1' } },
            { OWPlusLogCond, 'OWPlusIsOutpostLocation', { 'LocationType' } },
            { OWPlusLogCond, 'OWPlusDebugEconStorageRatio', { OUTPOST_UPGRADE_STORAGE_RATIO, OUTPOST_UPGRADE_STORAGE_RATIO, 'Air Upgrade T1' } },
            { OWPlusLogCond, 'OWPlusDebugLocationFactoriesBuildingLess', { 'LocationType', 1, categories.FACTORY * categories.TECH2 + categories.FACTORY * categories.TECH3, 'Air Upgrade T1' } },
            { OWPlusLogCond, 'OWPlusDebugFactoryUpgradeCandidateExists', { 'LocationType', 1, categories.AIR, 'Air Upgrade T1' } },
            { OWPlusLogCond, 'OWPlusClaimFactoryUpgrade', { 'LocationType', 1, categories.AIR, 'OWPlus Outpost Air Factory Upgrade T1' } },
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'OWPlus Outpost Land Factory Upgrade T2',
        PlatoonTemplate = 'T2LandFactoryUpgrade',
        Priority = 18400,
        InstanceCount = OUTPOST_UPGRADE_INSTANCE_COUNT,
        FormRadius = 40,
        BuilderConditions = {
            { OWPlusLogCond, 'OWPlusOutpostTierUpAllowed', { 'Land Upgrade T2' } },
            { OWPlusLogCond, 'OWPlusIsOutpostLocation', { 'LocationType' } },
            { OWPlusLogCond, 'OWPlusDebugEconStorageRatio', { OUTPOST_UPGRADE_STORAGE_RATIO, OUTPOST_UPGRADE_STORAGE_RATIO, 'Land Upgrade T2' } },
            { OWPlusLogCond, 'OWPlusDebugLocationFactoriesBuildingLess', { 'LocationType', 1, categories.FACTORY * categories.TECH3, 'Land Upgrade T2' } },
            { OWPlusLogCond, 'OWPlusDebugFactoryUpgradeCandidateExists', { 'LocationType', 2, categories.LAND, 'Land Upgrade T2' } },
            { OWPlusLogCond, 'OWPlusClaimFactoryUpgrade', { 'LocationType', 2, categories.LAND, 'OWPlus Outpost Land Factory Upgrade T2' } },
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'OWPlus Outpost Air Factory Upgrade T2',
        PlatoonTemplate = 'T2AirFactoryUpgrade',
        Priority = 18400,
        InstanceCount = OUTPOST_UPGRADE_INSTANCE_COUNT,
        FormRadius = 40,
        BuilderConditions = {
            { OWPlusLogCond, 'OWPlusOutpostTierUpAllowed', { 'Air Upgrade T2' } },
            { OWPlusLogCond, 'OWPlusIsOutpostLocation', { 'LocationType' } },
            { OWPlusLogCond, 'OWPlusDebugEconStorageRatio', { OUTPOST_UPGRADE_STORAGE_RATIO, OUTPOST_UPGRADE_STORAGE_RATIO, 'Air Upgrade T2' } },
            { OWPlusLogCond, 'OWPlusDebugLocationFactoriesBuildingLess', { 'LocationType', 1, categories.FACTORY * categories.TECH3, 'Air Upgrade T2' } },
            { OWPlusLogCond, 'OWPlusDebugFactoryUpgradeCandidateExists', { 'LocationType', 2, categories.AIR, 'Air Upgrade T2' } },
            { OWPlusLogCond, 'OWPlusClaimFactoryUpgrade', { 'LocationType', 2, categories.AIR, 'OWPlus Outpost Air Factory Upgrade T2' } },
        },
        BuilderType = 'Any',
    },
}
