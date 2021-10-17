
local TheOldCreateInitialArmyGroupFunction = CreateInitialArmyGroup
function CreateInitialArmyGroup(strArmy, createCommander)
    -- First execute the original function and create the initial army and commander
    local tblGroup, cdrUnit = TheOldCreateInitialArmyGroupFunction(strArmy, createCommander)
    -- fork a thread with our ACU spawn function
    ForkThread(CreateAllFactionACUs, strArmy, createCommander)
    -- return the values from TheOldCreateInitialArmyGroupFunction
    return tblGroup, cdrUnit
end

function CreateAllFactionACUs(strArmy, createCommander)
    -- Wait a second or we conflict with the score.lua observerLine feature
    coroutine.yield(30)
    -- Check if we have a army with a commander
    if createCommander then
        -- create commanders for all factions
        local AIBrain = GetArmyBrain(strArmy)
        local ownfactionIndex = AIBrain:GetFactionIndex()
        local x, y = AIBrain:GetArmyStartPos()
        local FactionIndexToName = {[1] = 'UEF', [2] = 'AEON', [3] = 'CYBRAN', [4] = 'SERAPHIM', [5] = 'NOMADS' }
        local ACUs = { 'UEL0001', 'UAL0001', 'URL0001', 'XSL0001' }
        -- Is Black Ops installed ?
        if __blueprints['eal0001'] then
            -- Change ACU ID's to Black Ops ACU ID's
            ACUs = { 'EEL0001', 'EAL0001', 'ERL0001', 'ESL0001' }
        end
        -- Is Nomads installed ?
        if __blueprints['xnl0001'] then
            -- Add nomads ACU to table
            table.insert(ACUs,'xnl0001')
        end
        -- Spawn ACUs
        local rotateOpt = ScenarioInfo.Options['RotateACU']
        for k, ACU in ACUs do
            -- only spawn ACU that are not from the initial faction
            if k ~= ownfactionIndex then
                LOG('* AllFactionMod: ['..AIBrain.Nickname..'] "'..FactionIndexToName[k]..'" ACU - ID: '..ACU..' created')
                local unit = AIBrain:CreateUnitNearSpot(ACU, x, y)
                if not rotateOpt or rotateOpt == 'On' then
                    unit:RotateTowardsMid()
                elseif rotateOpt == 'Marker' then
                    local marker = GetMarker(strArmy) or {}
                    if marker['orientation'] then
                        local o = EulerToQuaternion(unpack(marker['orientation']))
                        unit:SetOrientation(o, true)
                    end
                end
                unit:PlayCommanderWarpInEffect()
           else
                LOG('* AllFactionMod: ['..AIBrain.Nickname..'] "'..FactionIndexToName[k]..'" ACU - ID: '..ACU..' already exist')
            end
        end
    end
end
