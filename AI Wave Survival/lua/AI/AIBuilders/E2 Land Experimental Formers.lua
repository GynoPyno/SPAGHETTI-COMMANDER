local EBC = '/lua/editor/EconomyBuildConditions.lua'
local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local SBC = '/lua/editor/SorianBuildConditions.lua'
import('/mods/AI Wave Survival/lua/AI/PlatoonTemplates/Uveso PlatoonTemplates Land.lua')

BuilderGroup {
    BuilderGroupName = 'E2 Land Experimental Formers',              -- BuilderGroupName, initalized from AIBaseTemplates in "\lua\AI\AIBaseTemplates\"
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'E Zone LAND',                                  -- Random Builder Name.
        --PlatoonAddPlans = {'NameUnitsSorian'},
        PlatoonTemplate = 'T4ExperimentalLandUveso 1 1',                            -- Template Name. These units will be formed. See: "\lua\AI\PlatoonTemplates"
        Priority = 1000,                                                          -- Priority. 1000 is normal.
        InstanceCount = 3,                                                      -- Number of plattons that will be formed.
        FormRadius = 10000,
        BuilderData = {
            SearchRadius = 10000,                                       -- Searchradius for new target.
            GetTargetsFromBase = true,                                          -- Get targets from base position (true) or platoon position (false)
            AggressiveMove = true,                                              -- If true, the unit will attack everything while moving to the target.
            AttackEnemyStrength = 1000000,                                       -- Compare platoon to enemy strenght. 100 will attack equal, 50 weaker and 150 stronger enemies.
            IgnorePathing = true,                                               -- If true, the platoon will not use AI pathmarkers and move directly to the target
            TargetSearchCategory = categories.FOOD,        -- Only find targets matching these categories.
            MoveToCategories = {                                                -- Move to targets
                categories.FOOD,
                categories.STRUCTURE,
            },
        },
        BuilderConditions = {                                                   -- platoon will be formed if all conditions are true
            -- When do we want to form this ?
            { UCBC, 'EnemyUnitsGreaterAtLocationRadius', {  10000, 'LocationType', 0, categories.FOOD }}, -- radius, LocationType, unitCount, categoryEnemy
			{ UCBC, 'PoolGreaterAtLocation', { 'LocationType', 1, categories.EXPERIMENTAL * categories.MOBILE * categories.LAND } },
        },
        BuilderType = 'Any',                                                    -- Build with "Land" "Air" "Sea" "Gate" or "All" Factories. - "Any" forms a Platoon.
    },
}