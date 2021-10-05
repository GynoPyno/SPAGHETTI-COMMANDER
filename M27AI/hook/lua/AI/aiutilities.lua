local M27Utilities = import('/mods/M27AI/lua/M27Utilities.lua')

local M27EngineerTryReclaimCaptureArea = EngineerTryReclaimCaptureArea
function EngineerTryReclaimCaptureArea(aiBrain, eng, pos, iAreaSize)
    --Reclaims only if within iAreaSize (defaults to size of 1) - although called iAreaSize, it will be based on rectangle, i.e. see if both x and Z co=-ordinates are within iAreaSize of the pos
    local bDebugMessages = false
    if aiBrain.M27AI == false then
        M27EngineerTryReclaimCaptureArea(aiBrain, eng, pos)
    else
        if iAreaSize == nil then iAreaSize = 1 end
        if not pos then
            return false
        end
        local Reclaiming = false
        -- Check if enemy units are at location
        local checkUnits = aiBrain:GetUnitsAroundPoint( (categories.STRUCTURE + categories.MOBILE) - categories.AIR, pos, iAreaSize, 'Enemy')
        -- reclaim units near our building place.
        if checkUnits and table.getn(checkUnits) > 0 then
            for num, unit in checkUnits do
                if unit.Dead or unit:BeenDestroyed() then
                    -- continue
                end
                if not IsEnemy( aiBrain:GetArmyIndex(), unit:GetAIBrain():GetArmyIndex() ) then
                    -- continue
                end
                if unit:IsCapturable() then
                    -- if we can capture the unit/building then do so
                    unit.CaptureInProgress = true
                    IssueCapture({eng}, unit)
                else
                    -- if we can't capture then reclaim
                    unit.ReclaimInProgress = true
                    IssueReclaim({eng}, unit)
                end
                Reclaiming = true
            end
        end
        -- reclaim rocks etc or we can't build mexes or hydros
        local Reclaimables = GetReclaimablesInRect(Rect(pos[1], pos[3], pos[1], pos[3]))
        if Reclaimables and table.getn( Reclaimables ) > 0 then
            local ReclaimPos
            for k,v in Reclaimables do
                if v.MaxMassReclaim > 0 or v.MaxEnergyReclaim > 0 then

                    ReclaimPos = v.CachePosition
                    --Check the reclaim position is actually within the target size:
                    if math.abs(ReclaimPos[1]-pos[1]) <= iAreaSize then
                        if math.abs(ReclaimPos[2] - pos[3]) <= iAreaSize then
                            LOG('Issuing reclaim order; pos[1,3]='..pos[1]..'-'..pos[3]..'; ReclaimPos='..ReclaimPos[1]..'-'..ReclaimPos[3])
                            IssueReclaim({eng}, v)
                            Reclaiming = true
                        else
                            if bDebugMessages == true then LOG('Preventing reclaim order as reclaim too far away') end
                        end
                    else
                        if bDebugMessages == true then LOG('Preventing reclaim order as reclaim too far away') end
                    end
                end
            end
        end
        return Reclaiming
    end
end