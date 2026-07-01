-- OWPlus Forward Base.lua
-- Builder group per la base avanzata direzionale (OWPlusForwardBase).
-- Costruisce solo fabbriche terra (no aria, no navale) all'expansion location.
-- Limit 2 fabbriche per location: una normale + una di upgrade.

local categories = categories
local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC  = '/lua/editor/EconomyBuildConditions.lua'

local MaxCapFactory = 0.024  -- 2.4% del cap totale (stesso limite di Uveso)

-- ===================================================-======================================================== --
-- ==             OWPlus Forward Land Factory — solo T1LandFactory a OWPlusForwardBase                      == --
-- ===================================================-======================================================== --
BuilderGroup {
    BuilderGroupName = 'OWPlus Forward Land Factory',
    BuildersType = 'EngineerBuilder',

    Builder {
        BuilderName = 'OWPlus Forward T1 Land Factory',
        PlatoonTemplate = 'EngineerBuilder',
        Priority = 17500,
        InstanceCount = 1,
        DelayEqualBuildPlattons = {'Factories', 5},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Factories' } },
            { EBC,  'GreaterThanEconTrend',        { 0.0, 0.0 } },
            { EBC,  'GreaterThanEconStorageRatio',  { 0.20, 0.50 } },
            -- Max 2 fabbriche terra qui (una e' gia' sufficiente per iniziare)
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 2, categories.STRUCTURE * categories.FACTORY * categories.LAND } },
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapFactory, '<', categories.STRUCTURE * categories.FACTORY * categories.LAND } },
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                Location = 'LocationType',
                BuildStructures = { 'T1LandFactory' },
            }
        },
    },
}
