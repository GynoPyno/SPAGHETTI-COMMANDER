local M27Overseer = import('/mods/M27AI/lua/AI/M27Overseer.lua')
local M27Logic = import('/mods/M27AI/lua/AI/M27GeneralLogic.lua')
local M27Utilities = import('/mods/M27AI/lua/M27Utilities.lua')
local M27MapInfo = import('/mods/M27AI/lua/AI/M27MapInfo.lua')


function SafeToGetACUUpgrade(aiBrain)
    --Determines if its safe for the ACU to get an upgrade
    local bDebugMessages = false
    local sFunctionRef = 'SafeToGetACUUpgrade'

    local bIsSafe = false
    local iSearchRange = 33
    local tACUPos = M27Utilities.GetACU(aiBrain):GetPosition()
    if bDebugMessages == true then LOG(sFunctionRef..': About to check if have intel coverage of iSearchRange='..iSearchRange..' for ACU position repr='..repr(tACUPos)) end
    if M27Logic.GetIntelCoverageOfPosition(aiBrain, tACUPos, iSearchRange) == true then
        --Are there enemies near the ACU with a threat value?
        local tNearbyEnemies = aiBrain:GetUnitsAroundPoint(categories.LAND, tACUPos, iSearchRange, 'Enemy')
        local iThreat = M27Logic.GetCombatThreatRating(aiBrain, tNearbyEnemies, true, nil, 50)
        if iThreat <= 15 then bIsSafe = true end
        if bDebugMessages == true then LOG(sFunctionRef..': Have intel coverage, iThreat='..iThreat..'; bIsSafe='..tostring(bIsSafe)) end
    end
    if bDebugMessages == true then LOG(sFunctionRef..': End of check, bIsSafe='..tostring(bIsSafe)) end
    return bIsSafe
end

function NoEnemyUnitsNearACU(aiBrain, iMaxSearchRange, iMinSearchRange)
    --Need to have iMinSearchRange intel available, and will look up to iMaxSearchRange
    local tACUPos = M27Utilities.GetACU(aiBrain):GetPosition()
    local bNoEnemyUnits = true
    if M27Logic.GetIntelCoverageOfPosition(aiBrain, tACUPos, iMinSearchRange) == false then bNoEnemyUnits = false
    else
        local tNearbyEnemies = aiBrain:GetUnitsAroundPoint(categories.LAND, tACUPos, iMaxSearchRange, 'Enemy')
        bNoEnemyUnits = M27Utilities.IsTableEmpty(tNearbyEnemies)
    end
    return bNoEnemyUnits
end

function WantToGetGunUpgrade(aiBrain)
    --Returns true if meet all the conditions that mean will want gun upgrade
    local bWantToGetGun = true
    if aiBrain:GetEconomyTrend('ENERGY') < 180*0.1 then bWantToGetGun = false --Net energy income
    elseif aiBrain:GetEconomyIncome('ENERGY') < 400 * 0.1 then bWantToGetGun = false --Gross energy income
    elseif SafeToGetACUUpgrade(aiBrain) == false then bWantToGetGun = false
    end
    return bWantToGetGun
end

function WantMoreMAA(aiBrain, iMassOnMAAVsEnemyAir)
    local bDebugMessages = false
    local sFunctionRef = 'WantMoreMAA'
    local iMAAMaxUnitCount = 50
    local bWantMoreMAA = false
    if aiBrain[M27Overseer.refbNeedMAABuilt] == true then
        if bDebugMessages == true then LOG(sFunctionRef..'; rebNeedMAABuild is true so returning true') end
        bWantMoreMAA = true
    else
        local iMassInMAA = aiBrain[M27Overseer.refiOurMassInMAA]
        if iMassInMAA <= 0 then
            if bDebugMessages == true then LOG(sFunctionRef..'; We have no MAA so want to build more') end
            bWantMoreMAA = true
        else
            local iMassInEnemyAir = aiBrain[M27Overseer.refiHighestEnemyAirThreat]
            if iMassOnMAAVsEnemyAir == nil then iMassOnMAAVsEnemyAir = 0.4 end
            if iMassInEnemyAir == 0 then
                if bDebugMessages == true then LOG(sFunctionRef..'; Enemy has no air threat') end
                bWantMoreMAA = false
            else
                if iMassInEnemyAir > iMassInMAA * iMassOnMAAVsEnemyAir then
                    --Check we haven't exceeded the threshold on MAA to get
                    if aiBrain[M27Overseer.refiOurMAAUnitCount] == nil then aiBrain[M27Overseer.refiOurMAAUnitCount] = 0 end
                    if aiBrain[M27Overseer.refiOurMAAUnitCount] > iMAAMaxUnitCount then return false
                    else
                        if bDebugMessages == true then LOG(sFunctionRef..'; We dont have enough mass in MAA to deal with enemy air threat') end
                        bWantMoreMAA = true
                    end
                else
                    if bDebugMessages == true then LOG(sFunctionRef..'; We have enough mass in maa to deal with enemy air') end
                    bWantMoreMAA = false
                end
            end
        end
    end
end

function DoesACUHaveGun(aiBrain, bROFAndRange, oAltACU)
    --bROFAndRange: True if want ACU to have both ROFAndRange (only does something for Aeon)
    --UCBC includes simialr code but for some reason referencing it (or using a direct copy) causes error
    --oAltACU - can pass an ACU that's not aiBrain's ACU
    --e.g. need to specify 1 of aiBrain and oAltACU (no need to specify both)
    local bDebugMessages = false
    local sFunctionRef = 'DoesACUHaveGun'
    if bROFAndRange == nil then bROFAndRange = true end
    local oACU = oAltACU
    if oACU == nil then oACU = M27Utilities.GetACU(aiBrain) end
    local tGunUpgrades = { 'HeavyAntiMatterCannon',
                           'CrysalisBeam', --Range
                           'HeatSink', --Aeon
                           'CoolingUpgrade',
                           'RateOfFire'
    }
    local bACUHasUpgrade = false
    local bHaveOne = false
    if bDebugMessages == true then LOG(sFunctionRef..': About to check if ACU has gun upgrade') end
    for iUpgrade, sUpgrade in tGunUpgrades do
        if bDebugMessages == true then LOG(sFunctionRef..': sUpgrade to check='..sUpgrade..'; oACU:HasEnhancement(sUpgrade)='..tostring(oACU:HasEnhancement(sUpgrade))) end
        if oACU:HasEnhancement(sUpgrade) then
            if bDebugMessages == true then LOG(sFunctionRef..': ACU has enhancement '..sUpgrade..'; returning true unless Aeon and only 1 upgrade') end
            bACUHasUpgrade = true
            if sUpgrade == 'CrysalisBeam' or sUpgrade == 'HeatSink' then
                if bDebugMessages == true then LOG(sFunctionRef..': ACU has either Crysalis or Heat sink, sUpgrade='..sUpgrade) end
                if bROFAndRange == false then
                    break
                else
                    if bHaveOne == false then
                        if bDebugMessages == true then LOG(sFunctionRef..': First of gun upgrades have come across, so not true yet') end
                        bACUHasUpgrade = false
                        bHaveOne = true
                    else
                        if bDebugMessages == true then LOG(sFunctionRef..': Second of gun upgrades have come across, so return true') end
                        bACUHasUpgrade = true break
                    end
                end
            else
            break
            end
        end
    end
    if bDebugMessages == true then LOG(sFunctionRef..': End of check, bACUHasUpgrade='..tostring(bACUHasUpgrade)) end
    return bACUHasUpgrade
end

function HydroNearACUAndBase(aiBrain)
    --If further away hydro, considers if its closer to enemy base than start point; returns empty table if no hydro
    local iMaxDistanceForHydro = 70 --must be within this distance of start position and ACU
    local tACUPosition = M27Utilities.GetACU(aiBrain):GetPosition()
    local tNearestHydro = {}
    local iMinDistanceToACU = 1000
    local iCurDistanceToACU
    local bHydroNear = false
    if M27Utilities.GetACU(aiBrain) then
        for iHydro, tHydro in M27MapInfo.HydroPoints do
            iCurDistanceToACU = M27Utilities.GetDistanceBetweenPositions(tHydro, tACUPosition)
            if iCurDistanceToACU < iMinDistanceToACU then
                --InSameSegmentGroup(oUnit, tDestination, bReturnUnitGroupOnly)
                if M27MapInfo.InSameSegmentGroup(M27Utilities.GetACU(aiBrain), tHydro, false) == true then
                    iMinDistanceToACU = iCurDistanceToACU
                    tNearestHydro = tHydro
                end
            end
        end
    end
    local iDistanceToStart
    if M27Utilities.IsTableEmpty(tNearestHydro) == false then
        iDistanceToStart = M27Utilities.GetDistanceBetweenPositions(tNearestHydro, M27MapInfo.PlayerStartPoints[aiBrain.M27StartPositionNumber])
        if iMinDistanceToACU <= iMaxDistanceForHydro and iDistanceToStart <= iMaxDistanceForHydro then bHydroNear = true end
    end
    return bHydroNear
end

function ACUShouldAssistEarlyHydro(aiBrain)
    local bHydroNearStart = HydroNearACUAndBase(aiBrain)
    local bACUShouldAssist = false
    if bHydroNearStart and GetGameTimeSeconds() <= 200 then bACUShouldAssist = true end
    return bACUShouldAssist
end

function CanUnitUseOvercharge(aiBrain, oUnit)
    --For now checks if enough energy and not underwater; separate function used as may want to expand this with rate of fire check in future
    local oBP = oUnit:GetBlueprint()
    local iEnergyNeeded
    for iWeapon, oWeapon in oBP.Weapon do
        if oWeapon.OverChargeWeapon then
            if oWeapon.EnergyRequired then
                iEnergyNeeded = oWeapon.EnergyRequired
                break
            end
        end
    end
    local bCanUseOC = false
    if aiBrain:GetEconomyStored('ENERGY') >= iEnergyNeeded then bCanUseOC = true end
    if bCanUseOC == true then
        --Check if underwater
        local oUnitPosition = oUnit:GetPosition()
        local iHeightAtWhichConsideredUnderwater = M27MapInfo.IsUnderwater(oUnitPosition, true) + 0.25 --small margin of error
        local tFiringPositionStart = M27Logic.GetDirectFireWeaponPosition(oUnit)
        if tFiringPositionStart then
            local iFiringHeight = tFiringPositionStart[2]
            if iFiringHeight <= iHeightAtWhichConsideredUnderwater then
                bCanUseOC = false
            end
        end
    end
    return bCanUseOC
end

function HaveExcessEnergy(aiBrain, iExcessEnergy)
    --returns true if have at least iExcessEnergy; note that GetEconomyTrend returns the 'per tick' excess (so 10% of what is displayed)
    local sResource = 'ENERGY'
    local bExcessEnergy = false
    if aiBrain:GetCurrentUnits(categories.EXPERIMENTAL * categories.ECONOMIC * categories.STRUCTURE) > 0 then bExcessEnergy = true
    else
        if aiBrain:GetEconomyTrend(sResource) >= iExcessEnergy*0.1 then bExcessEnergy = true end
    end
    return bExcessEnergy
end

function ExcessMassIncome(aiBrain, iExcessResource)
    --returns true if have at least iExcessMass; note that the economy trend will be 10% of what is displayed (so 0.8 excess mass income is displayed in-game as 8 excess mass income) - i.e. presumably it's the 'per tick' excess
    local bDebugMessages = false
    local sResource = 'MASS'
    local bHaveExcess = false
    if bDebugMessages == true then LOG('M27ExcessMassIncome='..aiBrain:GetEconomyTrend(sResource)..'; iExcessCondition='..iExcessResource) end
    if aiBrain:GetCurrentUnits(categories.EXPERIMENTAL * categories.ECONOMIC * categories.STRUCTURE) > 0 then HaveExcess = true
    elseif aiBrain:GetEconomyTrend(sResource) >= iExcessResource*0.1 then bHaveExcess = true end
    return bHaveExcess
end

function AtLeastXMassStored(aiBrain, iResourceStored)
    local iStored = aiBrain:GetEconomyStored('MASS')
    local bEnoughStored = false
    if iStored >= iResourceStored then bEnoughStored = true end
    return bEnoughStored
end

function LifetimeBuildCountLessThan(aiBrain, category, iBuiltThreshold)
    local bDebugMessages = false
    local iTotalBuilt = 0
    if bDebugMessages == true then LOG('M27LifetimeBuildCountLessThan - start') end
    local testCat = category
    if type(category) == 'string' then
        testCat = ParseEntityCategory(category)
    end
    local tUnitBPIDs = EntityCategoryGetUnitList(category)
    local oCurBlueprint
    local iCurCount

    if tUnitBPIDs == nil then
        M27Utilities.ErrorHandler('tUnitBPIDs is nil, so wont have built any')
        iTotalBuilt = 0
    else
        if bDebugMessages == true then LOG('LifetimeBuildCount: cycling through tUnitBPIDs') end
        for _, sBPID in tUnitBPIDs do
            oCurBlueprint = __blueprints[sBPID]
            iCurCount = aiBrain.M27LifetimeUnitCount[sBPID]
            if iCurCount == nil then iCurCount = 0 end
            iTotalBuilt = iTotalBuilt + iCurCount
        end
    end
    local bBuiltLessThan = true
    if iTotalBuilt >= iBuiltThreshold then bBuiltLessThan = false end
    return bBuiltLessThan
end