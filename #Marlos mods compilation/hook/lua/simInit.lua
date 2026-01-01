
local OLDSetupSession = SetupSession
function SetupSession()
    OLDSetupSession()
    import('/mods/#Marlos mods compilation/lua/AI/AIBuilders/ModdedUnitsUpgrade.lua')
end
