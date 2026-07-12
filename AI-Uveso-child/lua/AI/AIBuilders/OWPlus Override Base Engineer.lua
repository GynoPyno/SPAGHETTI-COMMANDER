-- Override di 'U123 Engineer Transfer To MainBase' (stock AI-Uveso) — sess.75: esclude gli
-- avamposti (NotOutpost) per evitare che rubino ingegneri/risorse agli avamposti autonomi
-- OverwhelmPlus. Fedele all'originale (AI-Uveso/lua/AI/AIBuilders/Base Engineer.lua) salvo
-- l'aggiunta della condizione NotOutpost a ogni Builder.
--
-- Nota: questo gruppo trasferisce ingegneri verso MAIN quando ce ne sono troppi in una
-- location. NotOutpost qui e' particolarmente importante: senza di essa gli ingegneri
-- costruiti in un avamposto verrebbero richiamati verso MAIN invece di restare a
-- costruire/potenziare l'avamposto stesso.

local categories = categories
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local UCBC = '/lua/editor/UnitCountBuildConditions.lua'

-- Fase sess.75: esclude gli avamposti (LocationType 'OUT#') da tutti i Builder di questo
-- gruppo stock, cosi' non competono con i BuilderGroup dedicati dell'avamposto per gli
-- ingegneri assegnati alla sua location.
-- Fix sess.76: BuildNotOnLocation (string.find su 'OUT') non funzionava mai — gli
-- avamposti hanno LocationType tipo "Expansion Area U3", mai 'OUT'.
local NotOutpost = { UCBC, 'OWPlusNotOutpostLocation', { 'LocationType' } }

-- ===================================================-======================================================== --
-- ==                                          Engineer Transfers                                            == --
-- ===================================================-======================================================== --
BuilderGroup {
    BuilderGroupName = 'U123 Engineer Transfer To MainBase',
    BuildersType = 'PlatoonFormBuilder',
    -- ============================================ --
    --    Transfer from LocationType to MainBase    --
    -- ============================================ --
    Builder {
        BuilderName = 'U1 Engi Trans to MainBase',
        PlatoonTemplate = 'U1EngineerTransfer',
        Priority = 18300,
        InstanceCount = 3,
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'GreaterThanGameTimeSeconds', { 60*20 } },
            { UCBC, 'BuildNotOnLocation', { 'LocationType', 'MAIN' } },
            { UCBC, 'EngineerManagerUnitsAtLocation', { 'LocationType', '>', 3,  categories.MOBILE * categories.TECH1 } },
        },
        BuilderData = {
            MoveToLocationType = 'MAIN',
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'U2 Engi Trans to MainBase',
        PlatoonTemplate = 'U2EngineerTransfer',
        Priority = 18300,
        InstanceCount = 3,
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'GreaterThanGameTimeSeconds', { 60*20 } },
            { UCBC, 'BuildNotOnLocation', { 'LocationType', 'MAIN' } },
            { UCBC, 'EngineerManagerUnitsAtLocation', { 'LocationType', '>', 3,  categories.MOBILE * categories.TECH2 } },
        },
        BuilderData = {
            MoveToLocationType = 'MAIN',
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'U3 Engi Trans to MainBase',
        PlatoonTemplate = 'U3EngineerTransfer',
        Priority = 18300,
        InstanceCount = 3,
        BuilderConditions = {
            NotOutpost,
            { UCBC, 'GreaterThanGameTimeSeconds', { 60*30 } },
            { UCBC, 'BuildNotOnLocation', { 'LocationType', 'MAIN' } },
            { UCBC, 'EngineerManagerUnitsAtLocation', { 'LocationType', '>', 3,  categories.MOBILE * categories.TECH3 } },
        },
        BuilderData = {
            MoveToLocationType = 'MAIN',
        },
        BuilderType = 'Any',
    },
}
