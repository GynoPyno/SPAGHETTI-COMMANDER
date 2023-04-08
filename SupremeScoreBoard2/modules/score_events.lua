local modPath = '/mods/SupremeScoreBoard2/'
local modScripts  = modPath..'modules/'
local log  = import(modScripts..'ext.logging.lua')

CurrentEvents = {}
CurrentEvents.ACUEntersTransporter = {}
CurrentEvents.ACUDestroyed = {}

function UpdateEvents(newEvents)
    -- insert every element
    if newEvents.ACUEntersTransporter then
        for i,acu in pairs(newEvents.ACUEntersTransporter) do
            table.insert(CurrentEvents.ACUEntersTransporter, acu)
        end
    end
    if newEvents.ACUDestroyed then
        for i,acu in pairs(newEvents.ACUDestroyed) do
            table.insert(CurrentEvents.ACUDestroyed, acu)
        end
    end

    -- traverse complete list
    for i,acu in pairs(CurrentEvents.ACUEntersTransporter) do
        log.Trace("Timestamp: " .. acu.Timestamp .. " id: " .. acu.ACUArmyID)
    end
    for i,acu in pairs(CurrentEvents.ACUDestroyed) do
        log.Trace("Timestamp: " .. acu.Timestamp .. " id: " .. acu.KilledArmy)
    end
end