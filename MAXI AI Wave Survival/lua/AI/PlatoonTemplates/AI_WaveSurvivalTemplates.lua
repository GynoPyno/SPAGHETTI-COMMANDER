--[[
    File    :   /lua/AI/PlattonTemplates/AI_WaveSurvivalTemplates.lua
    Author  :   SoftNoob
    Summary :
        Responsible for defining a mapping from AIBuilders keys -> Plans (Plans === platoon.lua functions)
]]

PlatoonTemplate {
   --[[ Name = 'AI_WaveSurvivalLandAttack',
    Plan = 'StrikeForceAI', -- The platoon function to use.
    GlobalSquads = {
        { categories.MOBILE * categories.LAND - categories.EXPERIMENTAL - categories.ENGINEER, -- Type of units.
          2, -- Min number of units.
          20, -- Max number of units.
          'attack', 'none' }, -- Not sure, probably doesn't matter.
    },]]--
}
