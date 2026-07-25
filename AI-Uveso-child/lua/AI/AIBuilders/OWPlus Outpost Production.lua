-- OWPlus Outpost Production.lua
-- Fase D1 (B24): produzione unita' da combattimento per gli avamposti (OUT#),
-- oltre a ingegneri/difese gia' gestiti da Fase A/B/C/H (B16).
--
-- Un builder per categoria (bot/carri/artiglieria) per tier (T1/T2/T3) = 9
-- totali, stesso pattern di 'OWPlus Outpost Engineer Builders.lua' (scoping
-- automatico per-avamposto via 'LocationType', tier letto con
-- OWPlusOutpostFactoryIsTech — nessun calcolo predittivo di "tech massimo",
-- si legge il tier reale della fabbrica). Ogni avamposto produce SOLO la
-- categoria assegnata da OWPlusAssignOutpostType (B24 punto 1, mono-categoria
-- per ora — il tipo "composito" arriva in Fase D2).
--
-- Tetto di sicurezza TEMPORANEO (sess.90): senza ancora un Former dedicato
-- (Fase D3, soglia di lancio plotone crescente nel tempo) le unita' prodotte
-- si accumulerebbero indefinitamente nel pool senza mai partire in attacco —
-- MAX_OUTPOST_PRODUCTION_POOL limita l'accumulo fino a quando D3 non
-- sostituisce questo tetto grezzo con la soglia dinamica vera.
--
-- Flag disattivabile: OWPlusOutpostAttackEnabled (OWPlusLogConditions.lua) —
-- richiesto esplicitamente dall'utente prima di iniziare l'implementazione
-- (checklist-sviluppo.md sez.2, sistema centrale).

local categories = categories
local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'
local OWPlusLogCond = '/mods/AI-Uveso-child/lua/AI/OWPlusLogConditions.lua'

-- Fase D1 fix (sess.90): il roster vanilla non ha bot/carro per ogni fazione
-- ad ogni tier (vedi commenti in OWPlus PlatoonTemplates Outpost.lua) — le
-- combinazioni senza unita' valida per una fazione vanno escluse qui con
-- FactionIndex, altrimenti quella fazione selezionerebbe un template con
-- FactionSquads privo della propria chiave (nessuna unita' da costruire).
-- Indici fazione: 1=UEF, 2=Aeon, 3=Cybran, 4=Seraphim.

local MAX_OUTPOST_PRODUCTION_POOL = 20

local OWPLUS_PRODUCTION_POOL_CATEGORY = categories.MOBILE * categories.LAND * (categories.DIRECTFIRE + categories.INDIRECTFIRE)
    - categories.SHIELD - categories.STEALTHFIELD - categories.EXPERIMENTAL - categories.ENGINEER - categories.SCOUT - categories.COMMAND - categories.SUBCOMMANDER

BuilderGroup {
    BuilderGroupName = 'OWPlus Outpost Production',
    BuildersType = 'FactoryBuilder',

    Builder {
        BuilderName = 'OWPlus Outpost Production Bot T1',
        PlatoonTemplate = 'OWPlus Outpost Bot T1',
        Priority = 18670,
        BuilderConditions = {
            { OWPlusLogCond, 'OWPlusOutpostAttackEnabled', {} },
            { OWPlusLogCond, 'OWPlusIsOutpostLocation', { 'LocationType' } },
            { OWPlusLogCond, 'OWPlusOutpostTypeIs', { 'LocationType', 'bot' } },
            -- Seraphim non ha un bot T1 puro nel roster, vedi PlatoonTemplate.
            { MIBC, 'FactionIndex', { 1, 2, 3 } },
            { OWPlusLogCond, 'OWPlusOutpostFactoryIsTech', { 'LocationType', 1 } },
            { OWPlusLogCond, 'OWPlusFactoryNotUpgrading', { 'LocationType', 'Production Bot T1' } },
            { UCBC, 'PoolLessAtLocation', { 'LocationType', MAX_OUTPOST_PRODUCTION_POOL, OWPLUS_PRODUCTION_POOL_CATEGORY } },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'OWPlus Outpost Production Bot T2',
        PlatoonTemplate = 'OWPlus Outpost Bot T2',
        Priority = 18680,
        BuilderConditions = {
            { OWPlusLogCond, 'OWPlusOutpostAttackEnabled', {} },
            { OWPlusLogCond, 'OWPlusIsOutpostLocation', { 'LocationType' } },
            { OWPlusLogCond, 'OWPlusOutpostTypeIs', { 'LocationType', 'bot' } },
            -- Solo Seraphim ha un bot T2 dedicato, vedi PlatoonTemplate.
            { MIBC, 'FactionIndex', { 4, 0, 0 } },
            { OWPlusLogCond, 'OWPlusOutpostFactoryIsTech', { 'LocationType', 2 } },
            { OWPlusLogCond, 'OWPlusFactoryNotUpgrading', { 'LocationType', 'Production Bot T2' } },
            { UCBC, 'PoolLessAtLocation', { 'LocationType', MAX_OUTPOST_PRODUCTION_POOL, OWPLUS_PRODUCTION_POOL_CATEGORY } },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'OWPlus Outpost Production Bot T3',
        PlatoonTemplate = 'OWPlus Outpost Bot T3',
        Priority = 18690,
        BuilderConditions = {
            { OWPlusLogCond, 'OWPlusOutpostAttackEnabled', {} },
            { OWPlusLogCond, 'OWPlusIsOutpostLocation', { 'LocationType' } },
            { OWPlusLogCond, 'OWPlusOutpostTypeIs', { 'LocationType', 'bot' } },
            { OWPlusLogCond, 'OWPlusOutpostFactoryIsTech', { 'LocationType', 3 } },
            { OWPlusLogCond, 'OWPlusFactoryNotUpgrading', { 'LocationType', 'Production Bot T3' } },
            { UCBC, 'PoolLessAtLocation', { 'LocationType', MAX_OUTPOST_PRODUCTION_POOL, OWPLUS_PRODUCTION_POOL_CATEGORY } },
        },
        BuilderType = 'Land',
    },

    Builder {
        BuilderName = 'OWPlus Outpost Production Tank T1',
        PlatoonTemplate = 'OWPlus Outpost Tank T1',
        Priority = 18670,
        BuilderConditions = {
            { OWPlusLogCond, 'OWPlusOutpostAttackEnabled', {} },
            { OWPlusLogCond, 'OWPlusIsOutpostLocation', { 'LocationType' } },
            { OWPlusLogCond, 'OWPlusOutpostTypeIs', { 'LocationType', 'tank' } },
            -- Cybran non ha un carro T1 nel roster, vedi PlatoonTemplate.
            { MIBC, 'FactionIndex', { 1, 2, 4 } },
            { OWPlusLogCond, 'OWPlusOutpostFactoryIsTech', { 'LocationType', 1 } },
            { OWPlusLogCond, 'OWPlusFactoryNotUpgrading', { 'LocationType', 'Production Tank T1' } },
            { UCBC, 'PoolLessAtLocation', { 'LocationType', MAX_OUTPOST_PRODUCTION_POOL, OWPLUS_PRODUCTION_POOL_CATEGORY } },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'OWPlus Outpost Production Tank T2',
        PlatoonTemplate = 'OWPlus Outpost Tank T2',
        Priority = 18680,
        BuilderConditions = {
            { OWPlusLogCond, 'OWPlusOutpostAttackEnabled', {} },
            { OWPlusLogCond, 'OWPlusIsOutpostLocation', { 'LocationType' } },
            { OWPlusLogCond, 'OWPlusOutpostTypeIs', { 'LocationType', 'tank' } },
            { OWPlusLogCond, 'OWPlusOutpostFactoryIsTech', { 'LocationType', 2 } },
            { OWPlusLogCond, 'OWPlusFactoryNotUpgrading', { 'LocationType', 'Production Tank T2' } },
            { UCBC, 'PoolLessAtLocation', { 'LocationType', MAX_OUTPOST_PRODUCTION_POOL, OWPLUS_PRODUCTION_POOL_CATEGORY } },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'OWPlus Outpost Production Tank T3',
        PlatoonTemplate = 'OWPlus Outpost Tank T3',
        Priority = 18690,
        BuilderConditions = {
            { OWPlusLogCond, 'OWPlusOutpostAttackEnabled', {} },
            { OWPlusLogCond, 'OWPlusIsOutpostLocation', { 'LocationType' } },
            { OWPlusLogCond, 'OWPlusOutpostTypeIs', { 'LocationType', 'tank' } },
            -- Solo Seraphim ha un vero carro T3, vedi PlatoonTemplate.
            { MIBC, 'FactionIndex', { 4, 0, 0 } },
            { OWPlusLogCond, 'OWPlusOutpostFactoryIsTech', { 'LocationType', 3 } },
            { OWPlusLogCond, 'OWPlusFactoryNotUpgrading', { 'LocationType', 'Production Tank T3' } },
            { UCBC, 'PoolLessAtLocation', { 'LocationType', MAX_OUTPOST_PRODUCTION_POOL, OWPLUS_PRODUCTION_POOL_CATEGORY } },
        },
        BuilderType = 'Land',
    },

    Builder {
        BuilderName = 'OWPlus Outpost Production Artillery T1',
        PlatoonTemplate = 'OWPlus Outpost Artillery T1',
        Priority = 18670,
        BuilderConditions = {
            { OWPlusLogCond, 'OWPlusOutpostAttackEnabled', {} },
            { OWPlusLogCond, 'OWPlusIsOutpostLocation', { 'LocationType' } },
            { OWPlusLogCond, 'OWPlusOutpostTypeIs', { 'LocationType', 'artillery' } },
            { OWPlusLogCond, 'OWPlusOutpostFactoryIsTech', { 'LocationType', 1 } },
            { OWPlusLogCond, 'OWPlusFactoryNotUpgrading', { 'LocationType', 'Production Artillery T1' } },
            { UCBC, 'PoolLessAtLocation', { 'LocationType', MAX_OUTPOST_PRODUCTION_POOL, OWPLUS_PRODUCTION_POOL_CATEGORY } },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'OWPlus Outpost Production Artillery T2',
        PlatoonTemplate = 'OWPlus Outpost Artillery T2',
        Priority = 18680,
        BuilderConditions = {
            { OWPlusLogCond, 'OWPlusOutpostAttackEnabled', {} },
            { OWPlusLogCond, 'OWPlusIsOutpostLocation', { 'LocationType' } },
            { OWPlusLogCond, 'OWPlusOutpostTypeIs', { 'LocationType', 'artillery' } },
            { OWPlusLogCond, 'OWPlusOutpostFactoryIsTech', { 'LocationType', 2 } },
            { OWPlusLogCond, 'OWPlusFactoryNotUpgrading', { 'LocationType', 'Production Artillery T2' } },
            { UCBC, 'PoolLessAtLocation', { 'LocationType', MAX_OUTPOST_PRODUCTION_POOL, OWPLUS_PRODUCTION_POOL_CATEGORY } },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'OWPlus Outpost Production Artillery T3',
        PlatoonTemplate = 'OWPlus Outpost Artillery T3',
        Priority = 18690,
        BuilderConditions = {
            { OWPlusLogCond, 'OWPlusOutpostAttackEnabled', {} },
            { OWPlusLogCond, 'OWPlusIsOutpostLocation', { 'LocationType' } },
            { OWPlusLogCond, 'OWPlusOutpostTypeIs', { 'LocationType', 'artillery' } },
            { OWPlusLogCond, 'OWPlusOutpostFactoryIsTech', { 'LocationType', 3 } },
            { OWPlusLogCond, 'OWPlusFactoryNotUpgrading', { 'LocationType', 'Production Artillery T3' } },
            { UCBC, 'PoolLessAtLocation', { 'LocationType', MAX_OUTPOST_PRODUCTION_POOL, OWPLUS_PRODUCTION_POOL_CATEGORY } },
        },
        BuilderType = 'Land',
    },
}
