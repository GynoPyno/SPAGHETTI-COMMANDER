--Houses the main code/logic for the overseer AI functionality
--Overseer is aimed to be a strategic AI that can override localised tactical AI (such as platoons)

local M27MapInfo = import('/mods/M27AI/lua/AI/M27MapInfo.lua')
local M27Utilities = import('/mods/M27AI/lua/M27Utilities.lua')
local M27PlatoonUtilities = import('/mods/M27AI/lua/AI/M27PlatoonUtilities.lua')
local M27Logic = import('/mods/M27AI/lua/AI/M27GeneralLogic.lua')
local M27Conditions = import('/mods/M27AI/lua/AI/M27CustomConditions.lua')
local M27LandFactory = import('/mods/M27AI/lua/AI/M27LandFactoryOverseer.lua')

--Semi-Global for this code:
local bACUIsDefending
local iOverseerRange = 1000
refbACUHelpWanted = 'M27ACUHelpWanted' --flags if we want teh ACU to stay in army pool platoon so its available for defence
refoStartingACU = 'M27PlayerStartingACU' --NOTE: Use M27Utilities.GetACU(aiBrain) instead of getting this directly (to help with crash control)

--Threat groups:
local refoEnemyGroupUnits = 'M27EnemyGroupUnits'
local refiTotalThreat = 'M27TotalThreat'
local reftAveragePosition = 'M27AveragePosition'
local refiDistanceFromOurBase = 'M27DistanceFromOurBase'
local refiDistanceFromEnemy = 'M27DistanceFromEnemy'
local reftEnemyThreatGroup = 'M27EnemyThreatGroupObject'
refsEnemyThreatGroup = 'M27EnemyThreatGroupRef'
local refsEnemyGroupName = 'M27EnemyThreatGroupName'
local refiEnemyThreatGroupUnitCount = 'M27EnemyThreatGroupUnitCount'
refstPrevEnemyThreatGroup = 'M27PrevEnemyThreatRefTable'
local refbUnitAlreadyConsidered = 'M27UnitAlreadyConsidered'
local tUnitGroupPreviousReferences = {}

--Platoon references
--local bArmyPoolInAvailablePlatoons = false
sDefenderPlatoonRef = 'M27DefenderAI'
sIntelPlatoonRef = 'M27IntelPathAI'

--Build condition related - note that overseer start shoudl set these to false to avoid error messages when build conditions check their status
refbNeedDefenders = 'M27NeedDefenders'
refbNeedScoutPlatoons = 'M27NeedScoutPlatoons'
refbNeedScoutsBuilt = 'M27NeedScoutsBuilt'
refbNeedMAABuilt = 'M27NeedMAABuilt'
iMinMAAWanted = 6
refbUnclaimedMexNearACU = 'M27UnclaimedMexNearACU'
refbReclaimNearACU = 'M27M27IsReclaimNearACU'
refoReclaimNearACU = 'M27ReclaimObjectNearACU'

--Other ACU related
refbACUWasDefending = 'M27ACUWasDefending'
iACUMaxTravelToNearbyMex = 15 --ACU will go up to this distance out of its current position to build a mex (so range is 20 given build range is 10)
local iCyclesThatACUHasNoPlatoon = 0
local iCyclesThatACUInArmyPool = 0

--Intel related
--local sIntelPlatoonRef = 'M27IntelPathAI' - included above
iInitialRaiderPlatoonsWanted = 2
bConfirmedInitialRaidersHaveScouts = false
bIntelPathsGenerated = false
reftIntelLinePositions = 'M27IntelLinePositions' --x = line; y = point on that line, returns position
local refiCurIntelLineTarget = 'M27CurIntelLineTarget'
local reftScoutsNeededPerPathPosition = 'M27ScoutsNeededPerPathPosition' --table[x] - x is path position, returns no. of scouts needed for that path position - done to save needing to call table.getn
local refiMinScoutsNeededForAnyPath = 'M27MinScoutsNeededForAnyPath'
local refiMaxIntelBasePaths = 'M27MaxIntelPaths'
refiHighestEnemyAirThreat = 'M27HighestEnemyAirThreat' --highest ever value the enemy's air threat has reached in a single map snapshot
refiOurMassInMAA = 'M27OurMassInMAA'
refiOurMAAUnitCount = 'M27OurMAAUnitCount'
iSearchRangeForEnemyStructures = 36 --T1 PD has range of 26, want more than this
bEnemyHasTech2PD = false

--Helper related
local refoUnitsScoutHelper = 'M27UnitsScoutHelper'
local refoUnitsMAAHelper = 'M27UnitsMAAHelper' --MAA platoon assigned to help a unit (e.g. the ACU)
local iMAAThreatValue = 28 --TODO - (long term, e.g. once getting to t2/t3 regularly) - Rework so instead of using this variable are determining MAA wanted by mass value; note also that can't just update this variable with the mass value to use, as it will vary by aiBrain so could cause issues in team games



--Grand strategy related
refiAIBrainCurrentStrategy = 'M27GrandStrategyRef'
refStrategyLandEarly = 1 --initial build order and pre-ACU gun upgrade approach
refStrategyLandAttackBase = 2 --e.g. for when have got gun upgrade on ACU
refStrategyLandConsolidate = 3 --e.g. for if ACU retreating after gun upgrade and want to get map control and eco
refStrategyLandKillACU = 4 --all-out attack on enemy ACU



function DebugPrintACUPlatoon(aiBrain, bReturnPlanOnly)
    --for debugging - sends log of acu platoons plan (and action if it has one and bReturnPlanOnly is false)
    local oACUUnit = M27Utilities.GetACU(aiBrain)
    local oACUPlatoon = oACUUnit.PlatoonHandle
    local sPlan
    local iCount
    local iAction = 0
    if oACUPlatoon == nil then
        sPlan = 'nil'
        if bReturnPlanOnly == true then return sPlan
        else
            iCount = 0
        end
    else
        local oArmyPoolPlatoon = aiBrain:GetPlatoonUniquelyNamed('ArmyPool')
        if oACUPlatoon == oArmyPoolPlatoon then
            sPlan = 'ArmyPool'
            if bReturnPlanOnly == true then return sPlan
            else iCount = 1
            end
        else
            sPlan = oACUPlatoon:GetPlan()
            if bReturnPlanOnly == true then return sPlan
            else
                iCount = oACUPlatoon[M27PlatoonUtilities.refiPlatoonCount]
                if iCount == nil then iCount = 0 end
                iAction = oACUPlatoon[M27PlatoonUtilities.refiCurrentAction]
                if iAction == nil then iAction = 0 end
            end
        end
    end
    LOG('DebugPrintACUPlatoon: ACU platoon ref='..sPlan..iCount..': Action='..iAction..'; UnitState='..M27Logic.GetUnitState(oACUUnit))
end

function RecordIntelPaths(aiBrain)
    local bDebugMessages = false
    local sFunctionRef = 'RecordIntelPaths'

    --First check we have scouts:
    if aiBrain:GetCurrentUnits(categories.SCOUT * categories.MOBILE * categories.LAND) > 0 then
        local tAllScouts = aiBrain:GetListOfUnits(categories.SCOUT * categories.MOBILE * categories.LAND, false, true)
        local oFirstScout
        if not(tAllScouts == nil) then oFirstScout = tAllScouts[1] end
        if not(oFirstScout == nil) then

            local oScoutBP = oFirstScout:GetBlueprint()
            if bDebugMessages == true then LOG(sFunctionRef..'oScoutBP.bp='..oScoutBP.BlueprintId) end
            local iScoutRange = oScoutBP.Intel.RadarRadius
            if iScoutRange == nil then
                M27Utilities.ErrorHandler('iScoutRange is nil')
                iScoutRange = 40
            elseif iScoutRange <= 0 then
                M27Utilities.ErrorHandler('iScoutRange is <=0')
                iScoutRange = 0
            end
            local iPlayerStartNumber = aiBrain.M27StartPositionNumber
            local iEnemyStartNumber = M27Logic.GetNearestEnemyStartNumber(aiBrain)
            if iEnemyStartNumber == nil then
                M27Utilities.ErrorHandler('iEnemYStartNumber is nil')
            else
                if bDebugMessages == true then LOG(sFunctionRef..': iPlayerStartNumber='..iPlayerStartNumber) end
                if bDebugMessages == true then LOG(sFunctionRef..'; iEnemyStartNumber='..iEnemyStartNumber) end
                if bDebugMessages == true then LOG(sFunctionRef..': PlayerStartPos repr='..repr(M27MapInfo.PlayerStartPoints[iPlayerStartNumber])) end
                if bDebugMessages == true then LOG(sFunctionRef..': Enemy Start Pos repr='..repr(M27MapInfo.PlayerStartPoints[iEnemyStartNumber])) end
                local iDistToEnemy = M27Utilities.GetDistanceBetweenPositions(M27MapInfo.PlayerStartPoints[iPlayerStartNumber], M27MapInfo.PlayerStartPoints[iEnemyStartNumber])
                if bDebugMessages == true then LOG(sFunctionRef..': iPlayerStartNumber='..iPlayerStartNumber..'; iEnemyStartNumber='..iEnemyStartNumber..'; iDistToEnemy from our start='..iDistToEnemy) end
                local iIntelLineTotal = (iDistToEnemy - iScoutRange * 2) / iScoutRange - 1 + 2 --Number of points that will be plotting for intel lines
                if iIntelLineTotal <= 0 then iIntelLineTotal = 1 end
                local iMapSizeX, iMapSizeZ = GetMapSize()
                --Determine co-ordinates for the midpoints for each intel line:
                aiBrain[reftIntelLinePositions] = {}
                local iDistanceAlongPath
                local iDistanceAlongSubpath
                local bContinueSubpath
                local iSubpathCount
                local iValidSubpathCount
                local iSubpathLoopCheck = 100 --Code will abort if >100
                local iSubpathAngle
                local bContinueFor90, bContinueFor270, bContinueCombined
                local tPossiblePosition = {}
                local iCorePathDistanceMod = 0
                local iSubpathTempDistanceMod
                local iSubpathDistanceMod90, iSubpathDistanceMod270, iPrevSubpathDistanceMod
                local bSubpathIsValid
                local iMaxLoop = iMapSizeX
                if iMapSizeX < iMapSizeZ then iMaxLoop = iMapSizeZ end
                local iLoopCount
                local bInSameGroup
                if bDebugMessages == true then LOG(sFunctionRef..'; iMapSizeX='..iMapSizeX..'; iMapSizeZ='..iMapSizeZ) end
                for iCurIntelLine = 1, iIntelLineTotal do
                    iDistanceAlongPath = iScoutRange * iCurIntelLine
                    aiBrain[reftIntelLinePositions][iCurIntelLine] = {}
                    aiBrain[reftIntelLinePositions][iCurIntelLine][1] = {}
                    tPossiblePosition = M27Utilities.MoveTowardsTarget(M27MapInfo.PlayerStartPoints[iPlayerStartNumber], M27MapInfo.PlayerStartPoints[iEnemyStartNumber], iDistanceAlongPath)
                    --Check if can path to tPossiblePosition; if can't, then need to move down path until mod is half of intel range, and if still not valid then move up path
                    --InSameSegmentGroup(oUnit, tDestination, bReturnUnitGroupOnly)
                    iLoopCount = 0
                    if bDebugMessages == true then LOG(sFunctionRef..'InSameGroup='..tostring(M27MapInfo.InSameSegmentGroup(oFirstScout, tPossiblePosition, false))) end
                    bInSameGroup = M27MapInfo.InSameSegmentGroup(oFirstScout, tPossiblePosition, false)
                    local btMaxMapSizeCount = {}
                    local iType = 0
                    while bInSameGroup == false do


                        if bDebugMessages == true then LOG(sFunctionRef..': '..iLoopCount..': intel path for iCurIntelLine='..iCurIntelLine..' isnt in same segment group as possible location='..repr(tPossiblePosition)..'; will try adjusting; iCorePathDistanceMod='..iCorePathDistanceMod..'; iLoopCount='..iLoopCount..'; iMaxLoop='..iMaxLoop) end
                        iLoopCount = iLoopCount + 1
                        if iLoopCount > iMaxLoop then
                            M27Utilities.ErrorHandler('Exceeded max loop count; iCurIntelLine='..iCurIntelLine)
                            break
                        end

                        if iCorePathDistanceMod < 0 and not(btMaxMapSizeCount[iType] == true) then
                            iType = 1
                            iCorePathDistanceMod = iCorePathDistanceMod - 1
                            if iCorePathDistanceMod < -(iScoutRange / 2) then iCorePathDistanceMod = 1 end
                        else
                            iCorePathDistanceMod = iCorePathDistanceMod + 1
                            iType = 2
                            if btMaxMapSizeCount[iType] == true then break end
                        end

                        tPossiblePosition = M27Utilities.MoveTowardsTarget(M27MapInfo.PlayerStartPoints[iPlayerStartNumber], M27MapInfo.PlayerStartPoints[iEnemyStartNumber], iDistanceAlongPath + iCorePathDistanceMod)

                        bInSameGroup = M27MapInfo.InSameSegmentGroup(oFirstScout, tPossiblePosition, false)
                        if tPossiblePosition[1] > iMapSizeX or tPossiblePosition[1] < 0 or tPossiblePosition[3] > iMapSizeZ or tPossiblePosition[3] < 0 then
                            btMaxMapSizeCount[iType] = true
                        end
                    end
                    aiBrain[reftIntelLinePositions][iCurIntelLine][1] = tPossiblePosition

                    if bDebugMessages == true then LOG(sFunctionRef..': reftIntelLinePositions[Cur][1]='..repr(aiBrain[reftIntelLinePositions][iCurIntelLine][1])) end
                    if bDebugMessages == true then M27Utilities.DrawLocations({aiBrain[reftIntelLinePositions][iCurIntelLine][1]}) end
                    bContinueSubpath = true
                    iSubpathCount = 0
                    iValidSubpathCount = 0
                    iSubpathAngle = 90
                    bContinueFor90 = true bContinueFor270 = true
                    local iInfiniteLoopCheck = 100
                    iSubpathDistanceMod90 = 0
                    iSubpathDistanceMod270 = 0
                    iPrevSubpathDistanceMod = 0
                    iSubpathTempDistanceMod = 0
                    while bContinueSubpath == true do
                        iSubpathCount = iSubpathCount + 1
                        bSubpathIsValid = false
                        if iSubpathCount > iSubpathLoopCheck then
                            M27Utilities.ErrorHandler('Likely infinite loop, iSubpathCount > '..iSubpathLoopCheck..'; iCurIntelLine='..iCurIntelLine)
                            break
                        end
                        if iSubpathAngle == 90 then
                            bContinueCombined = bContinueFor90
                            iPrevSubpathDistanceMod = iSubpathDistanceMod90
                        else
                            bContinueCombined = bContinueFor270
                            iPrevSubpathDistanceMod = iSubpathDistanceMod270
                        end
                        if bContinueCombined == true then
                            bSubpathIsValid = true
                            iValidSubpathCount = iValidSubpathCount + 1
                            iDistanceAlongSubpath = iScoutRange * math.ceil(iSubpathCount / 2) + iPrevSubpathDistanceMod
                            tPossiblePosition = M27Utilities.MoveTowardsTarget(aiBrain[reftIntelLinePositions][iCurIntelLine][1], M27MapInfo.PlayerStartPoints[iEnemyStartNumber], iDistanceAlongSubpath, iSubpathAngle)

                            iLoopCount = 0
                            iSubpathTempDistanceMod = iPrevSubpathDistanceMod
                            while not(M27MapInfo.InSameSegmentGroup(oFirstScout, tPossiblePosition)) do
                                if bDebugMessages == true then LOG(sFunctionRef..': '..iLoopCount..': Subpath intel path for iCurIntelLine='..iCurIntelLine..' isnt in same segment group as possible location='..repr(tPossiblePosition)..'; will try adjusting; iCorePathDistanceMod='..iCorePathDistanceMod) end
                                iLoopCount = iLoopCount + 1
                                if iLoopCount > iMaxLoop then
                                    M27Utilities.ErrorHandler('Exceeded max loop count; iCurIntelLine='..iCurIntelLine)
                                    break
                                end

                                if iSubpathTempDistanceMod < 0 then
                                    iSubpathTempDistanceMod = iSubpathTempDistanceMod - 1
                                    if iSubpathTempDistanceMod < -(iScoutRange / 2) then iSubpathTempDistanceMod = 1 end
                                else iSubpathTempDistanceMod = iSubpathTempDistanceMod + 1 end


                                tPossiblePosition = M27Utilities.MoveTowardsTarget(aiBrain[reftIntelLinePositions][iCurIntelLine][1], M27MapInfo.PlayerStartPoints[iEnemyStartNumber], iDistanceAlongSubpath + iSubpathTempDistanceMod, iSubpathAngle)
                                if tPossiblePosition[1] < 0 or tPossiblePosition[3] < 0 or tPossiblePosition[1] > iMapSizeX or tPossiblePosition[3] > iMapSizeZ then break end
                            end
                            if iSubpathAngle == 90 then iSubpathDistanceMod90 = iSubpathDistanceMod90 + iSubpathTempDistanceMod
                            else iSubpathDistanceMod270 = iSubpathDistanceMod270 + iSubpathTempDistanceMod end

                            --aiBrain[reftIntelLinePositions][iCurIntelLine][iValidSubpathCount + 1] = tPossiblePosition
                            --if bDebugMessages == true then LOG(sFunctionRef..'; iValidSupbathCount='..iValidSubpathCount..'; about to consider if should remove valid supbath; Pos='..repr(aiBrain[reftIntelLinePositions][iCurIntelLine][iValidSubpathCount + 1])) end
                            if tPossiblePosition[1] > iMapSizeX or tPossiblePosition[1] < 0 or tPossiblePosition[3] > iMapSizeZ or tPossiblePosition[3] < 0 then
                                bSubpathIsValid = false
                                if bDebugMessages == true then LOG(sFunctionRef..': iValidSubpathCount+1 pos after removal='..repr(aiBrain[reftIntelLinePositions][iCurIntelLine][iValidSubpathCount + 1])) end
                                iValidSubpathCount = iValidSubpathCount - 1
                                if bDebugMessages == true then LOG(sFunctionRef..'; Subpath wasnt valid so ahve removed; iValidSupbathCount='..iValidSubpathCount) end
                                if iSubpathAngle == 90 then
                                    bContinueFor90 = false
                                    if bContinueFor270 == false then
                                        bContinueSubpath = false
                                        break
                                    end
                                elseif iSubpathAngle == 270 then
                                    bContinueFor270 = false
                                    if bContinueFor90 == false then
                                        bContinueSubpath = false
                                        break
                                    end
                                elseif iSubpathCount >= iInfiniteLoopCheck then bContinueSubpath = false break
                                end
                            else
                                if bDebugMessages == true then LOG(sFunctionRef..': Was a valid subpath so not removed; iValidSubpathCount='..iValidSubpathCount) end
                                aiBrain[reftIntelLinePositions][iCurIntelLine][iValidSubpathCount + 1] = {}
                                aiBrain[reftIntelLinePositions][iCurIntelLine][iValidSubpathCount + 1] = tPossiblePosition
                                if bDebugMessages == true then LOG(sFunctionRef..': iSubpathCount='..iSubpathCount..'; iValidSubpathCount='..iValidSubpathCount..'; iDistanceAlongSubpath='..iDistanceAlongSubpath..'; aiBrain[reftIntelLinePositions][iCurIntelLine][iValidSubpathCount + 1] ='..repr(aiBrain[reftIntelLinePositions][iCurIntelLine][iValidSubpathCount + 1])) end
                                if bDebugMessages == true then M27Utilities.DrawLocations({aiBrain[reftIntelLinePositions][iCurIntelLine][iValidSubpathCount + 1]}, false, 2) end
                            end
                        end

                        if iSubpathAngle == 90 then iSubpathAngle = 270
                        elseif iSubpathAngle == 270 then iSubpathAngle = 90 end
                    end
                end
                --Record the number of scouts needed for each intel path:
                aiBrain[reftScoutsNeededPerPathPosition] = {}
                aiBrain[refiMinScoutsNeededForAnyPath] = 10000
                for iCurIntelLine = 1, iIntelLineTotal do
                    aiBrain[reftScoutsNeededPerPathPosition][iCurIntelLine] = table.getn(aiBrain[reftIntelLinePositions][iCurIntelLine])
                    if aiBrain[reftScoutsNeededPerPathPosition][iCurIntelLine] < aiBrain[refiMinScoutsNeededForAnyPath] then aiBrain[refiMinScoutsNeededForAnyPath] = aiBrain[reftScoutsNeededPerPathPosition][iCurIntelLine] end
                end
                aiBrain[refiMaxIntelBasePaths] = table.getn(aiBrain[reftIntelLinePositions])
                bIntelPathsGenerated = true
            end
        end
    else
        aiBrain[refbNeedScoutsBuilt] = true
    end
    if bDebugMessages == true then LOG(sFunctionRef..': End of code; bIntelPathsGenerated='..tostring(bIntelPathsGenerated)) end
end

function AddAvailableScoutsToPlatoon(aiBrain, oPlatoonToAddTo, iMaxScoutsToAdd)
--For similar function also see GetNearestScout
    --Cycles through available platoons (defenders, army pool) and adds the nearest scout to oPlatoonToAddTo up to iMaxScoutsToAdd
    local bDebugmessages = false
    local sFunctionRef = 'AddAvailableScoutsToPlatoon'

    local tCurScouts
    local tAvailableScouts = {}
    local sRefUnit = 'RefUnit'
    local sRefPosition = 'RefPosition'
    local iAvailableScouts = 0
    local bPlatoonIsAvailable
    local iAvailablePlatoons = table.getn(aiBrain:GetPlatoonsList())
    local oPlatoon
    local tAllPlatoons = aiBrain:GetPlatoonsList()
    local iRemainingScoutsToAdd = iMaxScoutsToAdd
    for iPlatoon = 1, iAvailablePlatoons + 1 do
        if iPlatoon <= iAvailablePlatoons then
            oPlatoon = tAllPlatoons[iPlatoon]
            bPlatoonIsAvailable = false
            if oPlatoon:GetPlan() == sDefenderPlatoonRef then
                if oPlatoon[refsEnemyThreatGroup] == nil then
                    bPlatoonIsAvailable = true
                end
            end
        else
            oPlatoon = aiBrain:GetPlatoonUniquelyNamed('ArmyPool')
            bPlatoonIsAvailable = true
        end

        tCurScouts = EntityCategoryFilterDown(categories.MOBILE * categories.SCOUT, oPlatoon:GetPlatoonUnits())
        if not(tCurScouts == nil) then
            for iCurScout, oCurScout in tCurScouts do
                if not(oCurScout.Dead or oCurScout:BeenDestroyed()) then
                    iAvailableScouts = iAvailableScouts + 1
                    tAvailableScouts[iAvailableScouts] = {}
                    tAvailableScouts[iAvailableScouts][sRefUnit] = oCurScout
                    tAvailableScouts[iAvailableScouts][sRefPosition] = oCurScout:GetPosition()
                end
            end
        end
    end
    if iAvailableScouts > 0 then
        if iAvailableScouts <= iMaxScoutsToAdd then
            --Add all scouts to target platoon
            for iCurScout, tScoutInfo in tAvailableScouts do
                aiBrain:AssignUnitsToPlatoon(oPlatoonToAddTo, tScoutInfo[sRefUnit], 'Attack', 'GrowthFormation')
            end
        else
            --Sort scouts based on nearest scout, then add to the platoon:
            --SortTableBySubtable(tTableToSort, sSortByRef, bLowToHigh)
            for iCurScout, tScoutInfo in M27Utilities.SortTableBySubtable(tAvailableScouts, sRefPosition, true) do
                aiBrain:AssignUnitsToPlatoon(oPlatoonToAddTo, tScoutInfo[sRefUnit], 'Attack', 'GrowthFormation')
                iRemainingScoutsToAdd = iRemainingScoutsToAdd - 1
                if iRemainingScoutsToAdd <= 0 then break end
            end
        end
    end
end

function GetNearestMobileMAA(aiBrain, oTargetUnit, bOnlyLookInArmyPool)
    --Returns the nearest mobile MAA; works similarly to GetNearestScout (but without the initial raider option)
    local bDebugMessages = false
    local sFunctionRef = 'GetNearestMobileMAA'
    if bOnlyLookInArmyPool == nil then bOnlyLookInArmyPool = false end
    local tPosition = oTargetUnit:GetPosition()
    local bUnitIsInPlatoon = false
    local sPlatoonName = 'None'
    local oPlatoon
    if oTargetUnit.PlatoonHandle and oTargetUnit.PlatoonHandle.GetPlan then
        bUnitIsInPlatoon = true
        oPlatoon = oTargetUnit.PlatoonHandle
        sPlatoonName = oPlatoon:GetPlan()
        if sPlatoonName == nil then sPlatoonName = 'None' end
        if oPlatoon[M27PlatoonUtilities.refiPlatoonCount] == nil then sPlatoonName = sPlatoonName..0
            else sPlatoonName = sPlatoonName..oPlatoon[M27PlatoonUtilities.refiPlatoonCount] end
    end
    local tMAAsToChooseFrom
    local tPoolUnits, oNearestMAA
    local oArmyPoolPlatoon = aiBrain:GetPlatoonUniquelyNamed('ArmyPool')
    if bOnlyLookInArmyPool == false then tMAAsToChooseFrom = aiBrain:GetListOfUnits(categories.ANTIAIR * categories.MOBILE, false, true)
    else  tPoolUnits = oArmyPoolPlatoon:GetPlatoonUnits()
        if M27Utilities.IsTableEmpty(tPoolUnits) == false then
            tMAAsToChooseFrom = EntityCategoryFilterDown(categories.ANTIAIR * categories.MOBILE, tPoolUnits)
        end
    end
    if M27Utilities.IsTableEmpty(tMAAsToChooseFrom) == false then
        local bValidMAA, iCurDistanceToPosition, oCurPlatoon
        local iMinDistanceToPosition = 100000

        for iMAA, oMAA in tMAAsToChooseFrom do
            bValidMAA = false
            if not(oMAA.Dead) then
                bValidMAA = true
                if oMAA.GetFractionComplete and oMAA:GetFractionComplete() < 1 then bValidMAA = false end
                if bValidMAA == true then
                    if bDebugMessages == true then LOG(sFunctionRef..': Have a valid unit, checking its not in the seame platoon or a helper platoon') end
                    --Check its not in the same platoon as the unit we're looking from, or in a helper platoon
                    if bUnitIsInPlatoon == true then
                        if oMAA.PlatoonHandle then
                            oCurPlatoon = oMAA.PlatoonHandle
                            if not(oCurPlatoon == oArmyPoolPlatoon) then
                                if bDebugMessages == true then LOG(sFunctionRef..': MAA has a platoon thats not army pool, checking if its the same as target unit or target units helper') end
                                if oCurPlatoon == oPlatoon then bValidMAA = false
                                else
                                    --Is it part of a helper platoon already assigned to target unit?
                                    if not(oTargetUnit[refoUnitsMAAHelper] == nil) then
                                        if bDebugMessages == true then LOG(sFunctionRef..': oTargetUnit has a helper platoon') end
                                        if oTargetUnit[refoUnitsMAAHelper] == oCurPlatoon then
                                            if bDebugMessages == true then LOG(sFunctionRef..': Platoon already helping ACU so will ignore') end
                                            bValidMAA = false
                                        end
                                    else
                                            if bDebugMessages == true then LOG(sFunctionRef..': Platoon isnt helping targetunit so will include') end
                                    end
                                end
                            end
                        end
                    end
                end
            end
            if bValidMAA == true then
                if bDebugMessages == true then LOG(sFunctionRef..': Have a valid MAA unit thats not already helping target unit, checking how close it is') end
                --if have a valid MAA, then record how close it is
                --GetDistanceBetweenPositions(Position1, Position2, iBuildingSize)
                iCurDistanceToPosition = M27Utilities.GetDistanceBetweenPositions(tPosition, oMAA:GetPosition())
                if iCurDistanceToPosition <= iMinDistanceToPosition then
                    iMinDistanceToPosition = iCurDistanceToPosition
                    oNearestMAA = oMAA
                end
            else
                if bDebugMessages == true then LOG(sFunctionRef..': No valid MAA unit so returning nil') end
            end
        end
    end
    if bDebugMessages == true then if not(oNearestMAA == nil) then LOG(sFunctionRef..': oNearestMAA fractioncomplete='..oNearestMAA:GetFractionComplete()) end end
    return oNearestMAA
end

function GetNearestScout(aiBrain, tPosition, bDontTakeFromInitialRaiders, bOnlyLookInArmyPool)
--For similar function also refer to AddAvailableScoutsToPlatoon
    --Looks for the nearest scout, ignoring scouts in initial raider platoons if bDontTakeFromInitialRaiders is true
    --if bOnlyLookInArmyPool is true then won't consider units in any other existing platoons
    --returns nil if no such scout
    local bDebugMessages = false
    local sFunctionRef = 'GetNearestScout'
    if bOnlyLookInArmyPool == nil then bOnlyLookInArmyPool = false end
    if bDontTakeFromInitialRaiders == nil then bDontTakeFromInitialRaiders = true end
    local tScoutsToChooseFrom
    local tPoolUnits, oNearestScout
    local oArmyPoolPlatoon = aiBrain:GetPlatoonUniquelyNamed('ArmyPool')
    if bOnlyLookInArmyPool == false then tScoutsToChooseFrom = aiBrain:GetListOfUnits(categories.SCOUT, false, true)
    else  tPoolUnits = oArmyPoolPlatoon:GetPlatoonUnits()
        if M27Utilities.IsTableEmpty(tPoolUnits) == false then
            tScoutsToChooseFrom = EntityCategoryFilterDown(categories.SCOUT, tPoolUnits)
        end
    end
    if M27Utilities.IsTableEmpty(tScoutsToChooseFrom) == false then
        local bValidScout, iCurDistanceToPosition, oCurPlatoon
        local iMinDistanceToPosition = 100000
        if bDebugMessages == true then LOG(sFunctionRef..': Total scouts to choose from='..table.getn(tScoutsToChooseFrom)) end

        for iScout, oScout in tScoutsToChooseFrom do
            bValidScout = false
            if not(oScout.Dead) then
                bValidScout = true
                if oScout.GetFractionComplete and oScout:GetFractionComplete() < 1 then
                    if bDebugMessages == true then LOG(sFunctionRef..': iScout='..iScout..': Still being constructed') end
                    bValidScout = false end
                if bValidScout == true then
                    if bDebugMessages == true then LOG(sFunctionRef..': iScout='..iScout..'; checking if its in initialraider in which case wont use') end
                    if bDontTakeFromInitialRaiders == true then
                        if oScout.PlatoonHandle then
                            oCurPlatoon = oScout.PlatoonHandle
                            if not(oCurPlatoon == oArmyPoolPlatoon) then
                                if oCurPlatoon.GetPlan and oCurPlatoon:GetPlan() == 'M27MexRaiderAI' and oCurPlatoon[M27PlatoonUtilities.refiPlatoonCount] <= iInitialRaiderPlatoonsWanted then
                                    if bDebugMessages == true then LOG(sFunctionRef..': iScout is in raider platoon number '..oCurPlatoon[M27PlatoonUtilities.refiPlatoonCount]..'; iInitialRaiderPlatoonsWanted='..iInitialRaiderPlatoonsWanted) end
                                    bValidScout = false
                                end
                            end
                        end
                    end
                end
            end
            if bValidScout == true then
                --have a valid scout, record how close it is
                --GetDistanceBetweenPositions(Position1, Position2, iBuildingSize)
                iCurDistanceToPosition = M27Utilities.GetDistanceBetweenPositions(tPosition, oScout:GetPosition())
                if iCurDistanceToPosition <= iMinDistanceToPosition then
                    iMinDistanceToPosition = iCurDistanceToPosition
                    oNearestScout = oScout
                end
            end
        end
    end
    return oNearestScout
end

function AssignMAAToPreferredPlatoons(aiBrain)
    --Similar to assigning scouts, but for MAA - for now just focus on having MAA helping ACU and any platoon of >20 size that doesnt contain MAA
    --===========ACU MAA helper--------------------------
    local bDebugMessages = false
    local sFunctionRef = 'AssignMAAToPreferredPlatoons'
    local iACUMinMAAWantedWithAirThreat = 1
    local iAirThreatMAAFactor = 0.2 --approx mass value of MAA wanted with ACU as a % of the total air threat
    local iMaxMAAForACU = 25
    if aiBrain[refiHighestEnemyAirThreat] == nil then aiBrain[refiHighestEnemyAirThreat] = 0 end
    if aiBrain[refiHighestEnemyAirThreat] > 0 then
        iACUMinMAAWantedWithAirThreat = math.floor(aiBrain[refiHighestEnemyAirThreat] * iAirThreatMAAFactor / iMAAThreatValue, 1)
        if iACUMinMAAWantedWithAirThreat < 3 then iACUMinMAAWantedWithAirThreat = 3
        elseif iACUMinMAAWantedWithAirThreat > iMaxMAAForACU then iACUMinMAAWantedWithAirThreat = iMaxMAAForACU
        end

    end

    local sMAAPlatoonName = 'M27MAAAssister'
    local iMAAWanted = iACUMinMAAWantedWithAirThreat
    local bNeedMoreMAA = false
    local bACUNeedsMAAHelper = true
    local oNewMAAPlatoon
    local oExistingMAAPlatoon = M27Utilities.GetACU(aiBrain)[refoUnitsMAAHelper]
    if bDebugMessages == true then LOG(sFunctionRef..': About to check if ACU needs MAA; iMAAWanted='..iMAAWanted) end
    if not(oExistingMAAPlatoon == nil) then
        --A helper was assigned, check if it still exists
        if oExistingMAAPlatoon and aiBrain:PlatoonExists(oExistingMAAPlatoon) then
            --Platoon still exists; does it have the right aiplan?
            local sMAAHelperName = oExistingMAAPlatoon:GetPlan()
            if sMAAHelperName and sMAAHelperName == sMAAPlatoonName then
                if bDebugMessages == true then LOG(sFunctionRef..': sMAAHelperName='..sMAAHelperName) end
                --oNewMAAPlatoon = oExistingMAAPlatoon
                --does it have an MAA in it?
                local tACUMAA = oExistingMAAPlatoon:GetPlatoonUnits()
                if M27Utilities.IsTableEmpty(tACUMAA) == false then
                    if bDebugMessages == true then LOG(sFunctionRef..': MAAHelper has units, checking how many are MAA') end
                    local tExistingMAA = EntityCategoryFilterDown(categories.MOBILE * categories.ANTIAIR, tACUMAA)
                    if M27Utilities.IsTableEmpty(tExistingMAA) == false then
                        iMAAWanted = iMAAWanted - table.getn(tExistingMAA)
                        if bDebugMessages == true then LOG(sFunctionRef..': MAAHelper has units, reducing iMAAWanted to '..iMAAWanted) end
                    end
                end
            else
                if bDebugMessages == true then
                    if sMAAHelperName == nil then LOG(sFunctionRef..': MAA Helper has a nil plan; changing')
                    else LOG(sFunctionRef..': MAAHelper doesnt have the right plan; changing') end
                end
                oExistingMAAPlatoon:SetAIPlan(sMAAPlatoonName)
            end
        end
    else
        if bDebugMessages == true then LOG(sFunctionRef..': No MAA helper assigned previously') end
    end
    if iMAAWanted <= 0 then bACUNeedsMAAHelper = false end
    if bDebugMessages == true then LOG(sFunctionRef..': iMAAWanted='..iMAAWanted..'; bACUNeedsMAAHelper='..tostring(bACUNeedsMAAHelper)) end
    if bACUNeedsMAAHelper == true then
        --Assign MAA if we have any available; as its the ACU we want the nearest MAA of any platoon
        if bDebugMessages == true then LOG(sFunctionRef..': Checking for nearest mobileMAA') end
        local oMAAToGive
        local iCurLoopCount = 0
        local iMaxLoopCount = 100
        while iMAAWanted > 0 do
            iCurLoopCount = iCurLoopCount + 1
            if iCurLoopCount > iMaxLoopCount then M27Utilities.ErrorHandler('likely infinite loop') end

            oMAAToGive = GetNearestMobileMAA(aiBrain, M27Utilities.GetACU(aiBrain), false)
            if oMAAToGive == nil or oMAAToGive.Dead then
                if bDebugMessages == true then LOG(sFunctionRef..': oMAAToGive is nil or dead') end
                bNeedMoreMAA = true
                break
            else
                iMAAWanted = iMAAWanted - 1
                if bDebugMessages == true then LOG(sFunctionRef..': oMAAToGive is valid, will create new platoon (if dont already have one) and assign it if havent already created') end
                oNewMAAPlatoon = oExistingMAAPlatoon
                local bNeedNewMAAPlatoon = true
                if oNewMAAPlatoon and aiBrain:PlatoonExists(oNewMAAPlatoon) then bNeedNewMAAPlatoon = false end
                if bNeedNewMAAPlatoon == true then
                    if bDebugMessages == true then LOG(sFunctionRef..': oUnitsMAAHelper is nil, creating new platoon') end
                    oNewMAAPlatoon = aiBrain:MakePlatoon('', '')
                    M27Utilities.GetACU(aiBrain)[refoUnitsMAAHelper] = oNewMAAPlatoon
                else
                    if bDebugMessages == true then LOG(sFunctionRef..': oUnitsMAAHelper is valid, so will add units to this') end
                end
                if oMAAToGive.PlatoonHandle then
                    M27PlatoonUtilities.RemoveUnitsFromPlatoon(oMAAToGive.PlatoonHandle, {oMAAToGive}, false, oNewMAAPlatoon)
                else
                    --Redundancy in case there's a scenario where you dont have a platoon handle for a MAA
                    aiBrain:AssignUnitsToPlatoon(oNewMAAPlatoon, {oMAAToGive}, 'Attack', 'GrowthFormation')
                end
            end
        end
        if not(oNewMAAPlatoon == nil) then
            oNewMAAPlatoon[M27PlatoonUtilities.refoSupportHelperUnitTarget] = M27Utilities.GetACU(aiBrain)
            oNewMAAPlatoon:SetAIPlan(sMAAPlatoonName)
            if bDebugMessages == true then LOG(sFunctionRef..': MAATarget='..repr(oNewMAAPlatoon[M27PlatoonUtilities.refoSupportHelperUnitTarget]:GetPosition())) end
        end
    end


    --=================Large platoons - ensure they have MAA in them, and if not then add MAA
    local tPlatoonUnits, iPlatoonUnits, tPlatoonCurrentMAAs, oMAAToAdd, oMAAOldPlatoon
    local iThresholdForAMAA = 20 --Any platoons with this many units should have a MAA in them
    if aiBrain[refiHighestEnemyAirThreat] == nil then aiBrain[refiHighestEnemyAirThreat] = 0 end
    if aiBrain[refiHighestEnemyAirThreat] > 0 then iThresholdForAMAA = 10 end
    local iMAAWanted, iMAAAlreadyHave
    local iCurLoopCount
    local iMaxLoopCount = 50
    for iCurPlatoon, oPlatoon in aiBrain:GetPlatoonsList() do
        tPlatoonUnits = oPlatoon:GetPlatoonUnits()

        if M27Utilities.IsTableEmpty(tPlatoonUnits) == false then
            iPlatoonUnits = table.getn(tPlatoonUnits)
            if iPlatoonUnits >= iThresholdForAMAA then
                iMAAWanted = math.floor(iPlatoonUnits / iThresholdForAMAA)
                tPlatoonCurrentMAAs = EntityCategoryFilterDown(categories.ANTIAIR * categories.LAND * categories.MOBILE, tPlatoonUnits)
                if M27Utilities.IsTableEmpty(tPlatoonCurrentMAAs) == true then iMAAAlreadyHave = 0
                    else iMAAAlreadyHave = table.getn(tPlatoonCurrentMAAs) end
                iCurLoopCount = 0
                while iMAAWanted > iMAAAlreadyHave do
                    iCurLoopCount = iCurLoopCount + 1
                    if iCurLoopCount > iMaxLoopCount then
                        M27Utilities.ErrorHandler('likely infinite loop')
                        break
                    end
                    --Need MAAs in the platoon
                    oMAAToAdd = GetNearestMobileMAA(aiBrain, tPlatoonUnits[1], true)
                    if oMAAToAdd == nil then
                        bNeedMoreMAA = true
                        break
                    else
                        --Have a valid MAA - add it to the platoon
                        oMAAOldPlatoon = oMAAToAdd.PlatoonHandle
                        if oMAAOldPlatoon then
                            --RemoveUnitsFromPlatoon(oPlatoon, tUnits, bReturnToBase, oPlatoonToAddTo)
                            M27PlatoonUtilities.RemoveUnitsFromPlatoon(oMAAOldPlatoon, { oMAAToAdd}, false, oPlatoon)
                        else
                            --Dont have platoon for the MAA so add manually (backup for unexpected scenarios)
                            aiBrain:AssignUnitsToPlatoon(oPlatoon, { oMAAToAdd}, 'Unassigned', 'None')
                        end
                        iMAAAlreadyHave = iMAAAlreadyHave + 1
                    end
                end
            end
        end
    end


    --========Build order related
    aiBrain[refbNeedMAABuilt] = bNeedMoreMAA
    if bDebugMessages == true then LOG(sFunctionRef..': End of MAA assignment logic') end
end

function AssignScoutsToPreferredPlatoons(aiBrain)
    --Goes through all scouts we have, and assigns them to highest priority tasks
    --Tries to form an intel line (and manages the location of this), and requests more scouts are built if dont have enough to form an intel line platoon;
    local bDebugMessages = false
    local sFunctionRef = 'AssignScoutsToPreferredPlatoons'

    --Rare error - AI mass produces scouts - logs enabled for if this happens
    local tAllScouts = aiBrain:GetListOfUnits(categories.SCOUT, false, true)
    local iScouts = 0
    local iArmyPoolScouts = 0
    if M27Utilities.IsTableEmpty(tAllScouts) == false then iScouts = table.getn(tAllScouts) end
    if iScouts >= 25 then
        local iNonScouts = aiBrain:GetCurrentUnits(categories.MOBILE * categories.LAND - categories.SCOUT)
        if iScouts > iNonScouts then
            bDebugMessages = true --For errors
            M27Utilities.ErrorHandler('Warning possible error unless very large map - more than 25 scouts, but only '..iNonScouts..' non-scouts; iscouts='..iscouts..'; turning on debug messages.  Still stop producing scouts if get to 30') --have a hard limit of 30 in the builder conditions, but 25+ would indicate an error
        end
    end
    local bNeedMoreScouts = false
    local oArmyPoolPlatoon, tArmyPoolScouts
    if iScouts > 0 then
        oArmyPoolPlatoon = aiBrain:GetPlatoonUniquelyNamed('ArmyPool')
        tArmyPoolScouts = EntityCategoryFilterDown(categories.MOBILE * categories.SCOUT, oArmyPoolPlatoon:GetPlatoonUnits())
        if M27Utilities.IsTableEmpty(tArmyPoolScouts) == false then
            iArmyPoolScouts = table.getn(tArmyPoolScouts)
        end


        --============Initial mex raider scouts-----------------------
        --Have we sent mex raiders yet? If not then want scouts in armypool ready to join the raiders
        --M27LifetimePlatoonCount(aiBrain, bool, sPlatoonAI, iBuiltThreshold, bLessThan)
        if aiBrain[M27PlatoonUtilities.refiLifetimePlatoonCount] == nil then aiBrain[M27PlatoonUtilities.refiLifetimePlatoonCount] = {} end
        local iRaiderCount = aiBrain[M27PlatoonUtilities.refiLifetimePlatoonCount]['M27MexRaiderAI']
        if iRaiderCount == nil then
            iRaiderCount = 0
            aiBrain[M27PlatoonUtilities.refiLifetimePlatoonCount]['M27MexRaiderAI'] = 0
        end
        local iMinScoutsWantedInPool = 0 --This is also changed several times below
        if bDebugMessages == true then LOG(sFunctionRef..': About to check if raiders have been checked for scouts; iScouts='..iScouts..'; iRaiderCount='..iRaiderCount..'; bConfirmedInitialRaidersHaveScouts='..tostring(bConfirmedInitialRaidersHaveScouts)) end
        --[[if iRaiderCount < iInitialRaiderPlatoonsWanted then
            --Should be start of the game - want to leave any scouts alone in army pool for raiders to use
            iMinScoutsWantedInPool = iInitialRaiderPlatoonsWanted - iRaiderCount
            if bDebugMessages == true then LOG(sFunctionRef..': Dont have enough raider platoons, so ignoring for now and flagging to get more scouts') end
        else ]]--
        if iRaiderCount > 0 then
            --Have we checked that the raiders have scouts in them?  If not, then as a 1-off add scouts to them
            if bConfirmedInitialRaidersHaveScouts == false then
                if bDebugMessages == true then LOG(sFunctionRef..': About to check if we have enough scouts to assign to the raider platoons if they need them') end
                if iScouts >= 1 then --we should have a scout for the raider platoon
                    if iScouts >= iInitialRaiderPlatoonsWanted and iRaiderCount >= iInitialRaiderPlatoonsWanted then bConfirmedInitialRaidersHaveScouts = true end --will be giving scouts in later step
                    iMinScoutsWantedInPool = 0
                    if bDebugMessages == true then LOG(sFunctionRef..': About to cycle through each platoon to get the initialraider platoons') end
                    local iRaiderScoutsMissing = 0
                    for iCurPlatoon, oPlatoon in aiBrain:GetPlatoonsList() do
                        if not(oPlatoon == oArmyPoolPlatoon) then
                            if oPlatoon:GetPlan() == 'M27MexRaiderAI' then
                                if bDebugMessages == true then LOG(sFunctionRef..': Have found a raider platoon, oPlatoon[M27PlatoonUtilities.refiPlatoonCount]='..oPlatoon[M27PlatoonUtilities.refiPlatoonCount]) end
                                if oPlatoon[M27PlatoonUtilities.refiPlatoonCount] <= iInitialRaiderPlatoonsWanted then
                                    local tRaiders = oPlatoon:GetPlatoonUnits()
                                    if M27Utilities.IsTableEmpty(tRaiders) == false then
                                        local tRaiderScouts = EntityCategoryFilterDown(categories.SCOUT, tRaiders)
                                        if M27Utilities.IsTableEmpty(tRaiderScouts) == true then
                                            if bDebugMessages == true then LOG(sFunctionRef..': Raider platoon'..oPlatoon[M27PlatoonUtilities.refiPlatoonCount]..' doesnt have any scouts, seeing if we can give it a scout') end
                                            --Platoon doesnt have a scout - can we give it one?
                                            iRaiderScoutsMissing = iRaiderScoutsMissing + 1
                                            local oScoutToGive
                                            if iArmyPoolScouts == 0 then
                                                if bDebugMessages == true then LOG(sFunctionRef..': No scouts in army pool, so looking for nearest scout in any platoon') end
                                                oScoutToGive = GetNearestScout(aiBrain, oPlatoon:GetPlatoonPosition(), true, false)
                                                if oScoutToGive.PlatoonHandle then
                                                    if bDebugMessages == true then LOG(sFunctionRef..': scout has platoon handle, giving to raider') end
                                                    M27PlatoonUtilities.RemoveUnitsFromPlatoon(oScoutToGive.PlatoonHandle, {oScoutToGive}, false, oPlatoon)
                                                else
                                                    --Redundancy in case there's a scenario where you dont have a platoon handle for a scout
                                                    if bDebugMessages == true then LOG(sFunctionRef..': Scout has no platoon handle still try to give to raider') end
                                                    aiBrain:AssignUnitsToPlatoon(oPlatoon, {oScoutToGive}, 'Attack', 'AttackFormation')
                                                end
                                            else
                                                if bDebugMessages == true then LOG(sFunctionRef..': iArmyPoolScouts='..iArmyPoolScouts..'; getting a scout from the pool') end
                                                --GetNearestScout(aiBrain, tPosition, bDontTakeFromInitialRaiders, bOnlyLookInArmyPool)
                                                oScoutToGive = GetNearestScout(aiBrain, oPlatoon:GetPlatoonPosition(), true, false)
                                                if oScoutToGive == nil then
                                                    if iScouts >= iRaiderCount then if bDebugMessages == true then LOG(sFunctionRef..': Couldnt find a scout to give - this is expected if theyre under construction but not completed') end end
                                                    bConfirmedInitialRaidershaveScouts = false
                                                else
                                                    M27PlatoonUtilities.RemoveUnitsFromPlatoon(oArmyPoolPlatoon, {oScoutToGive}, false, oPlatoon)
                                                    iArmyPoolScouts = iArmyPoolScouts - 1
                                                    if iArmyPoolScouts > 0 then tArmyPoolScouts = EntityCategoryFilterDown(categories.SCOUT, oArmyPoolPlatoon:GetPlatoonUnits()) end
                                                end
                                            end
                                            oPlatoon:SetPlatoonFormationOverride('AttackFormation') --want raider bots and scouts to stick together
                                            if iScouts <= iRaiderScoutsMissing then
                                                break
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                    if iScouts >= iRaiderScoutsMissing and iRaiderCount >= iInitialRaiderPlatoonsWanted then bConfirmedInitialRaidersHaveScouts = true end
                    if bDebugMessages == true then LOG('Finished cycling through all platoons, iRaiderScoutsMissing='..iRaiderScoutsMissing..'; iScouts='..iScouts..'; bConfirmedHaveScouts='..tostring(bConfirmedInitialRaidersHaveScouts)) end
                end
            end
        end

        if iArmyPoolScouts <= iMinScoutsWantedInPool then
            bNeedMoreScouts = true
        else


            --===========ACU Scout helper--------------------------
            --We have more than enough scouts to cover initial raiders; next priority is the ACU
            local bACUNeedsScoutHelper = true
            if not(M27Utilities.GetACU(aiBrain)[refoUnitsScoutHelper] == nil) then
                --A scout helper was assigned, check if it still exists
                if M27Utilities.GetACU(aiBrain)[refoUnitsScoutHelper] and aiBrain:PlatoonExists(M27Utilities.GetACU(aiBrain)[refoUnitsScoutHelper]) then
                    --Platoon still exists; does it have the right aiplan?
                    local sScoutHelperName = M27Utilities.GetACU(aiBrain)[refoUnitsScoutHelper]:GetPlan()
                    if sScoutHelperName and sScoutHelperName == 'M27ScoutAssister' then
                        --does it have a scout in it?
                        local tACUScout = M27Utilities.GetACU(aiBrain)[refoUnitsScoutHelper]:GetPlatoonUnits()
                        if M27Utilities.IsTableEmpty(tACUScout) == false then
                            if M27Utilities.IsTableEmpty(EntityCategoryFilterDown(categories.MOBILE * categories.SCOUT, tACUScout)) == false then
                                bACUNeedsScoutHelper = false
                            end
                        end
                    end
                end
            end
            if bACUNeedsScoutHelper == true then
                --Assign a scout if we have any available; as its the ACU we want the nearest scout of any platoon (except initial raiders with count of 1 or 2)
                local oScoutToGive = GetNearestScout(aiBrain, M27Utilities.GetACU(aiBrain):GetPosition(), true, false)
                if oScoutToGive == nil then
                    bNeedMoreScouts = true
                else
                    local oNewScoutPlatoon = aiBrain:MakePlatoon('', '')
                    if oScoutToGive.PlatoonHandle then
                        M27PlatoonUtilities.RemoveUnitsFromPlatoon(oScoutToGive.PlatoonHandle, {oScoutToGive}, false, oNewScoutPlatoon)
                    else
                        --Redundancy in case there's a scenario where you dont have a platoon handle for a scout
                        aiBrain:AssignUnitsToPlatoon(oNewScoutPlatoon, {oScoutToGive}, 'Attack', 'GrowthFormation')
                    end
                    oNewScoutPlatoon:SetAIPlan('M27ScoutAssister')


                    M27Utilities.GetACU(aiBrain)[refoUnitsScoutHelper] = oNewScoutPlatoon
                    oNewScoutPlatoon[M27PlatoonUtilities.refoSupportHelperUnitTarget] = M27Utilities.GetACU(aiBrain)
                    if bDebugMessages == true then LOG(sFunctionRef..': ScoutTarget='..repr(oNewScoutPlatoon[M27PlatoonUtilities.refoSupportHelperUnitTarget]:GetPosition())) end
                end
            end



            --==========Intel Line manager
            --Do we have an intel platoon yet?
            local tIntelPlatoons = {}
            local iIntelPlatoons = 0
            --local oFirstIntelPlatoon
            local tCurIntelScouts = {}
            local iCurIntelScouts = 0
            local iIntelScouts = 0
            if bDebugMessages == true then LOG(sFunctionRef..': Cycling through all platoons to identify intel platoons') end
            for iPlatoon, oPlatoon in aiBrain:GetPlatoonsList() do
                if oPlatoon:GetPlan() == sIntelPlatoonRef then
                    tCurIntelScouts = EntityCategoryFilterDown(categories.MOBILE * categories.SCOUT, oPlatoon:GetPlatoonUnits())
                    if not(tCurIntelScouts == nil) then
                        iCurIntelScouts = table.getn(tCurIntelScouts)
                        if iCurIntelScouts > 0 then
                            iIntelScouts = iIntelScouts + iCurIntelScouts
                            iIntelPlatoons = iIntelPlatoons + 1
                            tIntelPlatoons[iIntelPlatoons] = oPlatoon
                        end
                    end
                end
            end
            if bDebugMessages == true then LOG(sFunctionRef..': Intel platoons identified='..iIntelPlatoons) end
            if iIntelPlatoons > 0 then
                local bRefreshPath = false
                local iPrevIntelLineTarget = aiBrain[refiCurIntelLineTarget]
                if aiBrain[refiCurIntelLineTarget] == nil then aiBrain[refiCurIntelLineTarget] = 1 bRefreshPath = true end
                --Determine the point on the path that we want:
                --Do we have at least the minimum number of scouts needed for any intel path to be covered in full? Otherwise will stick with the first path
                if iIntelScouts >= (aiBrain[refiMinScoutsNeededForAnyPath] - 2) then
                    --Determine the preferred path, if we ignore the number of scouts needed for now:
                    --Is the ACU further forwards than the central path point?
                    local tACUPos = M27Utilities.GetACU(aiBrain):GetPosition()

                    local iEnemyStartNumber = M27Logic.GetNearestEnemyStartNumber(aiBrain)
                    local iOurStartNumber = aiBrain.M27StartPositionNumber
                    if iEnemyStartNumber then
                        local iACUDistToEnemy = M27Utilities.GetDistanceBetweenPositions(tACUPos, M27MapInfo.PlayerStartPoints[iEnemyStartNumber])
                        local iACUDistToHome = M27Utilities.GetDistanceBetweenPositions(tACUPos, M27MapInfo.PlayerStartPoints[iOurStartNumber])
                        local iPathDistToEnemy = M27Utilities.GetDistanceBetweenPositions(aiBrain[reftIntelLinePositions][aiBrain[refiCurIntelLineTarget]][1], M27MapInfo.PlayerStartPoints[iEnemyStartNumber])
                        local iPathDistToHome = M27Utilities.GetDistanceBetweenPositions(aiBrain[reftIntelLinePositions][aiBrain[refiCurIntelLineTarget]][1], M27MapInfo.PlayerStartPoints[iOurStartNumber])
                        local bACUNeedsSupport = false
                        if iACUDistToEnemy < iPathDistToEnemy then
                            if iACUDistToHome > iPathDistToHome then
                                bACUNeedsSupport = true
                                --Does the ACU have nearby scout support?
                                local tScoutsNearACU = aiBrain:GetUnitsAroundPoint(categories.SCOUT, tACUPos, 15, 'Ally')
                                if not(tScoutsNearACU == nil) then
                                    if table.getn(tScoutsNearACU) > 0 then
                                        bACUNeedsSupport = false
                                    end
                                end
                            end
                        end
                        if bACUNeedsSupport == true then
                            if bDebugMessages == true then LOG(sFunctionRef..': Want to move scouts forward so ACU has better intel') end
                            aiBrain[refiCurIntelLineTarget] = aiBrain[refiCurIntelLineTarget] + 1
                        else
                            --Cycle through each point on the current path, and check various conditions:
                            local iCurEnemyThreat = 0
                            local iCurAllyThreat = 0
                            local iTotalEnemyNetThreat = 0
                            local bScoutNearAllMexes = true
                            local tNearbyScouts
                            local tEnemyUnitsNearPoint, tEnemyStructuresNearPoint
                            if bDebugMessages == true then LOG(sFunctionRef..': About to loop through subpath positions') end
                            local iLoopCount1 = 0
                            local iLoopMax1 = 100
                            local tNearbyAllies, tNearbyEnemies
                            for iSubPath, tSubPathPosition in aiBrain[reftIntelLinePositions][aiBrain[refiCurIntelLineTarget]] do
                                --GetCombatThreatRating(aiBrain, tUnits, bUseBlip, iMassValueOfBlipsOverride)
                                --To keep things simple will look for units within 20 of each path position;
                                --Some niche cases where this will be inaccurate: Pathing results in 2 path positions being closer together, and units get counted twice
                                --Also this is looking at circles around the point - units that are in the middle of 2 points may not be counted
                                --20 is used because the lowest scout intel range is 40, but some are higher
                                iLoopCount1 = iLoopCount1 + 1
                                if iLoopCount1 > iLoopMax1 then
                                    M27Utilities.ErrorHandler('Likely infinite loop, iSubpath='..iSubpath..'; iLoopCount1='..iLoopCount1)
                                    break
                                end
                                if aiBrain == nil then M27Utilities.ErrorHandler('aiBrain is nil') end
                                tNearbyEnemies = aiBrain:GetUnitsAroundPoint(categories.MOBILE + categories.STRUCTURE, tSubPathPosition, 20, 'Enemy')
                                tNearbyAllies = aiBrain:GetUnitsAroundPoint(categories.MOBILE + categories.STRUCTURE, tSubPathPosition, 35, 'Ally')
                                if bDebugMessages == true then LOG(sFunctionRef..'; iSubPath='..iSubPath..'; about to get enemy and ally threat around point') end
                                if bDebugMessages == true then LOG(sFunctionRef..': tSubPathPosition='..repr(tSubPathPosition)) end
                                if bDebugMessages == true then LOG(sFunctionRef..': is tNearbyEnemies empty?='..tostring(M27Utilities.IsTableEmpty(tNearbyEnemies))) end


                                if M27Utilities.IsTableEmpty(tNearbyEnemies) == true then iCurEnemyThreat = 0 else
                                    iCurEnemyThreat = M27Logic.GetCombatThreatRating(aiBrain, tNearbyEnemies, true) end
                                if bDebugMessages == true then LOG(sFunctionRef..': About to get threat for nearby allies') end
                                if M27Utilities.IsTableEmpty(tNearbyAllies) == true then iCurAllyThreat = 0 else
                                    iCurAllyThreat = M27Logic.GetCombatThreatRating(aiBrain, tNearbyAllies, false) end
                                iTotalEnemyNetThreat = math.max(iCurEnemyThreat - iCurAllyThreat, 0) + iTotalEnemyNetThreat
                                if bDebugMessages == true then LOG(sFunctionRef..'; iSubPath='..iSubPath..'; iCurEnemyThreat='..iCurEnemyThreat..'; iCurAllyThreat='..iCurAllyThreat..'; iTotalEnemyNetThreat='..iTotalEnemyNetThreat) end
                                if iTotalEnemyNetThreat > 170 then
                                    bScoutNearAllMexes = false
                                    break
                                else
                                    tNearbyScouts = aiBrain:GetUnitsAroundPoint(categories.MOBILE * categories.SCOUT, tSubPathPosition, 20)
                                    if tNearbyScouts == nil then bScoutNearAllMexes = false
                                    elseif table.getn(tNearbyScouts) == 0 then bScoutNearAllMexes = false
                                    end
                                end
                            end
                            if bDebugMessages == true then LOG(sFunctionRef..': Finished looping through subpath positions') end
                            if iTotalEnemyNetThreat > 170 then
                                aiBrain[refiCurIntelLineTarget] = aiBrain[refiCurIntelLineTarget] - 1
                            else
                                if iTotalEnemyNetThreat == 0 then
                                    --Are all scouts in position?
                                    if bScoutNearAllMexes == true then
                                        aiBrain[refiCurIntelLineTarget] = aiBrain[refiCurIntelLineTarget] + 1
                                    end
                                end
                            end
                        end
                    else
                        M27Utilities.ErrorHandler('iEnemyStartNumber is nil')
                    end
                else --Dont have enough scouts to cover any path, to stick with initial base path
                    if bDebugMessages == true then LOG(sFunctionRef..': Dont have enough scouts to cover any intel path, stay at base path; aiBrain[refiMinScoutsNeededForAnyPath]='..aiBrain[refiMinScoutsNeededForAnyPath]..'; iIntelPlatoons='..iIntelPlatoons) end
                    bNeedMoreScouts = true
                    aiBrain[refiCurIntelLineTarget] = 1
                end
                --Keep within min and max (this is repeated as needed here to make sure iscoutswanted doesnt cause error)
                if aiBrain[refiCurIntelLineTarget] <= 0 then aiBrain[refiCurIntelLineTarget] = 1
                elseif aiBrain[refiCurIntelLineTarget] > aiBrain[refiMaxIntelBasePaths] then aiBrain[refiCurIntelLineTarget] = aiBrain[refiMaxIntelBasePaths] end

                if bDebugMessages == true then LOG('aiBrain[refiCurIntelLineTarget]='..aiBrain[refiCurIntelLineTarget]..'; table.getn(aiBrain[reftIntelLinePositions])='..table.getn(aiBrain[reftIntelLinePositions])) end
                local iScoutsWanted = table.getn(aiBrain[reftIntelLinePositions][aiBrain[refiCurIntelLineTarget]])
                if iIntelScouts < iScoutsWanted then bNeedMoreScouts = true end
                local iLoopCount = 0
                local iLoopMax = 100
                if bDebugMessages == true then LOG(sFunctionRef..': refiCurIntelLineTarget='..aiBrain[refiCurIntelLineTarget]..'; About to loop through scouts wanted; iScoutsWanted='..iScoutsWanted..'; iIntelScouts='..iIntelScouts) end
                if bDebugMessages == true then
                    LOG('About to log every path in the current line:')
                    for iCurSubPath, tPath in aiBrain[reftIntelLinePositions][aiBrain[refiCurIntelLineTarget]] do
                        LOG('iCurSubPath='..iCurSubPath..'; repr='..repr(tPath))
                    end
                end
                while iIntelScouts < (iScoutsWanted - 2) do
                    --Too few to try and maintain intel path, so fall back 1 position
                    iLoopCount = iLoopCount + 1
                    if iLoopCount > iLoopMax then
                        M27Utilities.ErrorHandler('likely infinite loop - exceeded iLoopMax of '..iLoopMax..'; refiCurIntelLineTarget='..aiBrain[refiCurIntelLineTarget])
                        break
                    end
                    aiBrain[refiCurIntelLineTarget] = aiBrain[refiCurIntelLineTarget] - 1
                    if aiBrain[refiCurIntelLineTarget] <= 1 then break end
                    iScoutsWanted = table.getn(aiBrain[reftIntelLinePositions][aiBrain[refiCurIntelLineTarget]])
                end
                --Keep within min and max possible targets:
                if aiBrain[refiCurIntelLineTarget] <= 0 then aiBrain[refiCurIntelLineTarget] = 1
                elseif aiBrain[refiCurIntelLineTarget] > aiBrain[refiMaxIntelBasePaths] then aiBrain[refiCurIntelLineTarget] = aiBrain[refiMaxIntelBasePaths] end

                --Sort platoons by distance, and check if their current path target is different from what we want
                --SortTableBySubtable(tTableToSort, sSortByRef, bLowToHigh)
                local iDistFromCurPath
                local iMinDistFromCurPath
                local oClosestPlatoon
                local iClosestPlatoon
                local tCurPathPos
                if bDebugMessages == true then LOG(sFunctionRef..': About to loop subpaths in current target') end
                for iCurSubpath = 1, table.getn(aiBrain[reftIntelLinePositions][aiBrain[refiCurIntelLineTarget]]) do
                    iMinDistFromCurPath = 100000
                    oClosestPlatoon = nil
                    iClosestPlatoon = 0
                    tCurPathPos = aiBrain[reftIntelLinePositions][aiBrain[refiCurIntelLineTarget]][iCurSubpath]
                    for iPlatoon, oPlatoon in tIntelPlatoons do
                        iDistFromCurPath = M27Utilities.GetDistanceBetweenPositions(oPlatoon:GetPlatoonPosition(), tCurPathPos)
                        if iDistFromCurPath < iMinDistFromCurPath then
                            iMinDistFromCurPath = iDistFromCurPath
                            oClosestPlatoon = oPlatoon
                            iClosestPlatoon = iPlatoon
                        end
                    end
                    if oClosestPlatoon == nil then break
                    else
                        table.remove(tIntelPlatoons, iClosestPlatoon)
                        if oClosestPlatoon[M27PlatoonUtilities.reftMovementPath] == nil then
                            oClosestPlatoon[M27PlatoonUtilities.reftMovementPath] = {}
                            oClosestPlatoon[M27PlatoonUtilities.reftMovementPath][1] = {}
                        end
                        if not(oClosestPlatoon[M27PlatoonUtilities.reftMovementPath][1] == tCurPathPos) then
                            oClosestPlatoon[M27PlatoonUtilities.reftMovementPath][1] = tCurPathPos
                            oClosestPlatoon[M27PlatoonUtilities.refiOverseerAction] = M27PlatoonUtilities.refActionReissueMovementPath
                            --oClosestPlatoon[M27PlatoonUtilities.refiCurrentAction] = M27PlatoonUtilities.refActionReissueMovementPath
                            M27PlatoonUtilities.ForceActionRefresh(oClosestPlatoon)
                            oClosestPlatoon[M27PlatoonUtilities.refbOverseerAction] = true
                        end
                    end
                end

                --If we have too many scouts then remove excess ones
                if not(tIntelPlatoons == nil) then
                    local iRemainingScouts = table.getn(tIntelPlatoons)
                    if iRemainingScouts >= 2 then
                        local iSpareScoutsWanted
                        local iMaxScoutsWanted = iScoutsWanted
                        local iFirstPathToCheck = math.max(1, aiBrain[refiCurIntelLineTarget] - 2)
                        local iLastPathToCheck = math.min(table.getn(aiBrain[reftIntelLinePositions]), aiBrain[refiCurIntelLineTarget] + 2)
                        local iCurScoutsWanted
                        --Cycle through previous and next intel paths to see if they need more scouts than current path
                        if bDebugMessages == true then LOG(sFunctionRef..': About to loop through previous and next intel paths') end
                        for iCurPathToCheck = iFirstPathToCheck, iLastPathToCheck do
                            iCurScoutsWanted = table.getn(aiBrain[reftIntelLinePositions][iCurPathToCheck])
                            if iCurScoutsWanted > iMaxScoutsWanted then iMaxScoutsWanted = iCurScoutsWanted end
                        end
                        iSpareScoutsWanted = iMaxScoutsWanted - iScoutsWanted
                        if iSpareScoutsWanted < iRemainingScouts then
                            --Have too many scouts - remove spare ones
                            local iScoutsToRemove = iRemainingScouts - iSpareScoutsWanted

                            for iCurRemoval = 1, iScoutsToRemove do
                                tIntelPlatoons[iCurRemoval][M27PlatoonUtilities.refiCurrentAction] = M27PlatoonUtilities.refActionDisband
                                tIntelPlatoons[iCurRemoval][M27PlatoonUtilities.refiOverseerAction] = M27PlatoonUtilities.refActionDisband
                                tIntelPlatoons[iCurRemoval][M27PlatoonUtilities.refbOverseerAction] = true
                            end
                        end


                    end
                end
            else
                if bDebugMessages == true then LOG(sFunctionRef..': No intel platoons (or scouts in them).  refbNeedScoutPlatoons='..tostring(aiBrain[refbNeedScoutPlatoons])..'; refbNeedScoutsBuilt='..tostring(aiBrain[refbNeedScoutsBuilt])) end
                bNeedMoreScouts = true
            end
        end



        --=================Large platoons - ensure they have scouts available, and if not then add scout to them
        local tPlatoonUnits, iPlatoonUnits, tPlatoonCurrentScouts, oScoutToAdd, oScoutOldPlatoon
        local iThresholdForAScout = 10 --Any platoons with this many units should have a scout in them
        for iCurPlatoon, oPlatoon in aiBrain:GetPlatoonsList() do
            tPlatoonUnits = oPlatoon:GetPlatoonUnits()

            if M27Utilities.IsTableEmpty(tPlatoonUnits) == false then
                iPlatoonUnits = table.getn(tPlatoonUnits)
                if iPlatoonUnits >= iThresholdForAScout then
                    tPlatoonCurrentScouts = EntityCategoryFilterDown(categories.SCOUT, tPlatoonUnits)
                    if M27Utilities.IsTableEmpty(tPlatoonCurrentScouts) == true then
                        --Need scouts in the platoon
                        oScoutToAdd = GetNearestScout(aiBrain, oPlatoon:GetPlatoonPosition(), true, true)
                        if oScoutToAdd == nil then
                            bNeedMoreScouts = true
                        else
                            --Have a valid scout - add it to the platoon
                            oScoutOldPlatoon = oScoutToAdd.PlatoonHandle
                            if oScoutOldPlatoon then
                                --RemoveUnitsFromPlatoon(oPlatoon, tUnits, bReturnToBase, oPlatoonToAddTo)
                                M27PlatoonUtilities.RemoveUnitsFromPlatoon(oScoutOldPlatoon, { oScoutToAdd}, false, oPlatoon)
                            else
                                --Dont have platoon for the scout so add manually (backup for unexpected scenarios)
                                aiBrain:AssignUnitsToPlatoon(oPlatoon, { oScoutToAdd}, 'Unassigned', 'None')
                            end
                        end
                    end
                end
            end
        end
    else
        bNeedMoreScouts = true
    end


    --===========Build order flags - whether want more scouts
    aiBrain[refbNeedScoutPlatoons] = bNeedMoreScouts
    if bNeedMoreScouts == true then
        --Do we have any scouts available in the army pool already?
        local tUnusedScouts = EntityCategoryFilterDown(categories.MOBILE * categories.SCOUT, aiBrain:GetPlatoonUniquelyNamed('ArmyPool'):GetPlatoonUnits())
        if tUnusedScouts == nil then
            aiBrain[refbNeedScoutsBuilt] = true
        elseif table.getn(tUnusedScouts) <= 0 then
            aiBrain[refbNeedScoutsBuilt] = true
        else
            aiBrain[refbNeedScoutsBuilt] = false
        end
    else
        aiBrain[refbNeedScoutsBuilt] = false
        if bDebugMessages == true then LOG('bNeedMoreScouts is false; aiBrain[refiMinScoutsNeededForAnyPath]='..aiBrain[refiMinScoutsNeededForAnyPath]..'; iScoutsWanted is table.getn(aiBrain[reftIntelLinePositions][aiBrain[refiCurIntelLineTarget]])='..table.getn(aiBrain[reftIntelLinePositions][aiBrain[refiCurIntelLineTarget]])..'; refiCurIntelLineTarget='..aiBrain[refiCurIntelLineTarget]) end
    end
    if bDebugMessages == true then LOG(sFunctionRef..': bNeedMoreScouts='..tostring(bNeedMoreScouts)..'aiBrain[refbNeedScoutsBuilt]='..tostring(aiBrain[refbNeedScoutsBuilt])) end
end


function RemoveSpareNonCombatUnits(oPlatoon)

    --Removes surplus scouts/MAA from oPlatoon
    local bDebugMessages = false
    local sFunctionRef = 'RemoveSpareTypeOfUnit'
    local tAllUnits = oPlatoon:GetPlatoonUnits()
    local tCombatUnits = EntityCategoryFilterDown(categories.DIRECTFIRE + categories.INDIRECTFIRE - categories.SCOUT - categories.ANTIAIR, tAllUnits)
    local tScouts = EntityCategoryFilterDown(categories.SCOUT, tAllUnits)
    local tMAA = EntityCategoryFilterDown(categories.ANTIAIR, tAllUnits)
    local iCombatUnits = 0
    if not(tCombatUnits == nil) then iCombatUnits = table.getn(tCombatUnits) end
    local iScouts = 0
    if not(tScouts==nil) then iScouts = table.getn(tScouts) end
    local iMAA = 0
    if not(tMAA==nil) then iMAA = table.getn(tMAA) end
    local iMaxScouts = 1 + math.min(iCombatUnits / 16)
    local iMaxMAA = 1 + math.min(iCombatUnits / 6)
    if bDebugMessages == true then LOG(sFunctionRef..': iMaxScouts='..iMaxScouts..'; iScouts='..iScouts..'; oPlatoon Plan and count='..oPlatoon:GetPlan()..oPlatoon[M27PlatoonUtilities.refiPlatoonCount]) end

    local iMaxType, tUnitsOfType, iUnitsOfType
    for iType = 1, 2 do
        if iType == 1 then iMaxType = iMaxScouts iUnitsOfType = iScouts tUnitsOfType = tScouts
        else iMaxType = iMaxMAA iUnitsOfType = iMAA tUnitsOfType = tMAA end
        if bDebugMessages == true then LOG('start of removal cycle, iType='..iType..'; iMaxType='..iMaxType..'; iUnitsOfType='..iUnitsOfType) end
        if iMaxType < iUnitsOfType then
            --Remove the scout that's furthest away, and repeat until no scouts
            local iMaxDistToPlatoon
            local tPlatoonPos = oPlatoon:GetPlatoonPosition()
            local iCurDistToPlatoon
            local iFurthestUnit
            for iRemovalCount = 1, iUnitsOfType - iMaxType do
                iMaxDistToPlatoon = 0
                for iCurUnit, oCurUnit in tUnitsOfType do
                    if not(oCurUnit.Dead or oCurUnit:BeenDestroyed()) then
                        iCurDistToPlatoon = M27Utilities.GetDistanceBetweenPositions(oCurUnit:GetPosition(), tPlatoonPos)
                        if iCurDistToPlatoon > iMaxDistToPlatoon then
                            iMaxDistToPlatoon = iCurDistToPlatoon
                            iFurthestUnit = iCurUnit
                        end
                    end
                end
                iUnitsOfType = iUnitsOfType - 1
                M27PlatoonUtilities.RemoveUnitsFromPlatoon(oPlatoon, {tUnitsOfType[iFurthestUnit]}, false)
                table.remove(tUnitsOfType, iFurthestUnit)
                if bDebugMessages == true then LOG(sFunctionRef..': Removed unit type '..iType..' from the platoon. iMaxUnitsOfType='..iMaxType..'; iUnitsOfType='..iUnitsOfType) end
                if iMaxType >= iUnitsOfType then break end
            end
        end
    end
end

function ResetEnemyThreatGroups(aiBrain)
    --[[ Background:
        Overseer code will have assigned [iArmyIndex][refsThreatGroup] for each visible enemy unit, grouped the units into threat groups, and recorded the threat groups in aiBrain[reftEnemyThreatGroup].
        Friendly platoons will then have been sent to intercept the nearest threat group, and will ahve recorded that threat group's reference
        when enemy units are combined into a threat group, any recent platoon group references should be checked, and then any aiBrain defender platoons targetting those enemy groups should have their references updated
    This Reset function therefore sets the current target to nil, and updates the previous target reference - updates both enemy unit references, and own platoon target references
    ]]
    local iArmyIndex = aiBrain:GetArmyIndex()
    aiBrain[reftEnemyThreatGroup] = {}
    --Reset platoon and aiBrain details:
    --local oPlatoons = aiBrain:GetPlatoonsList()
    --if not(oPlatoons==nil) then
        for iCurPlatoon, oPlatoon in aiBrain:GetPlatoonsList() do
            if oPlatoon[refstPrevEnemyThreatGroup] == nil then oPlatoon[refstPrevEnemyThreatGroup] = {} end
            table.insert(oPlatoon[refstPrevEnemyThreatGroup], 1, oPlatoon[refsEnemyThreatGroup])
            if table.getn(oPlatoon[refstPrevEnemyThreatGroup]) > 10 then table.remove(oPlatoon[refstPrevEnemyThreatGroup], 11) end
            oPlatoon[refsEnemyThreatGroup] = nil
        end
    --end
    local sOldRef
    for iCurEnemy, oEnemyUnit in aiBrain:GetUnitsAroundPoint(categories.LAND, M27MapInfo.PlayerStartPoints[aiBrain.M27StartPositionNumber], iOverseerRange) do
        if oEnemyUnit[iArmyIndex] == nil then oEnemyUnit[iArmyIndex] = {} end
        sOldRef = oEnemyUnit[iArmyIndex][refsEnemyThreatGroup]
        if sOldRef == nil then oEnemyUnit[iArmyIndex][refsEnemyThreatGroup] = {} end
        if oEnemyUnit[iArmyIndex][refstPrevEnemyThreatGroup] == nil then oEnemyUnit[iArmyIndex][refstPrevEnemyThreatGroup] = {} end
        table.insert(oEnemyUnit[iArmyIndex][refstPrevEnemyThreatGroup], 1, sOldRef)
        if table.getn(oEnemyUnit[iArmyIndex][refstPrevEnemyThreatGroup]) > 10 then table.remove(oEnemyUnit[iArmyIndex][refstPrevEnemyThreatGroup], 11) end
        oEnemyUnit[iArmyIndex][refsEnemyThreatGroup] = nil
        oEnemyUnit[iArmyIndex][refbUnitAlreadyConsidered] = nil
    end
end

function AddNearbyUnitsToThreatGroup(aiBrain, oEnemyUnit, sThreatGroup, iRadius, iGameTime)
    --Adds oEnemyUnit to sThreatGroup and calls this function on itself again for any units within iRadius that are visible
    --also updates previous threat group references so they know to refer to this threat group
    --Add oEnemyUnit to sThreatGroup:
    local bDebugMessages = false
    local sFunctionRef = 'AddNearbyUnitsToThreatGroup'
    local iArmyIndex = aiBrain:GetArmyIndex()
    --Only call this if haven't already called this on a unit:
    if oEnemyUnit[iArmyIndex][refbUnitAlreadyConsidered] == nil then
        if bDebugMessages == true then LOG(sFunctionRef..': refbUnitAlreadyConsidered is false, recording unit.  sThreatGroup='..sThreatGroup) end
        oEnemyUnit[iArmyIndex][refsEnemyThreatGroup] = sThreatGroup
        oEnemyUnit[iArmyIndex][refbUnitAlreadyConsidered] = true
        if aiBrain[reftEnemyThreatGroup][sThreatGroup] == nil then
            aiBrain[reftEnemyThreatGroup][sThreatGroup] = {}
            --aiBrain[reftEnemyThreatGroup][sThreatGroup][refsEnemyGroupName] = sThreatGroup
            aiBrain[reftEnemyThreatGroup][sThreatGroup][refoEnemyGroupUnits] = {}
            aiBrain[reftEnemyThreatGroup][sThreatGroup][refiEnemyThreatGroupUnitCount] = 0
        elseif aiBrain[reftEnemyThreatGroup][sThreatGroup][refoEnemyGroupUnits] == nil then
            aiBrain[reftEnemyThreatGroup][sThreatGroup][refoEnemyGroupUnits] = {}
            aiBrain[reftEnemyThreatGroup][sThreatGroup][refiEnemyThreatGroupUnitCount] = 0
        end
        table.insert(aiBrain[reftEnemyThreatGroup][sThreatGroup][refoEnemyGroupUnits], oEnemyUnit)
        aiBrain[reftEnemyThreatGroup][sThreatGroup][refiEnemyThreatGroupUnitCount] = aiBrain[reftEnemyThreatGroup][sThreatGroup][refiEnemyThreatGroupUnitCount] + 1
        if bDebugMessages == true then LOG(sFunctionRef..': Added '..sThreatGroup..' to aiBrain. refiEnemyThreatGroupUnitCount='..aiBrain[reftEnemyThreatGroup][sThreatGroup][refiEnemyThreatGroupUnitCount]) end

        --Record details of old enemy threat group references, and the new threat group that they now belong to
        if not(oEnemyUnit[iArmyIndex][refstPrevEnemyThreatGroup] == nil) then
            local sOldRef
            for iPrevRef, sRef in oEnemyUnit[iArmyIndex][refstPrevEnemyThreatGroup] do
                if not(sRef == nil) then
                    sOldRef = sRef break
                end
            end
            if not(sOldRef == nil) then tUnitGroupPreviousReferences[sOldRef] = sThreatGroup end
        end

        --look for nearby units:
        local tNearbyUnits = aiBrain:GetUnitsAroundPoint(categories.LAND, oEnemyUnit:GetPosition(), iRadius, 'Enemy')
        for iUnit, oUnit in tNearbyUnits do
            if M27Utilities.CanSeeUnit(aiBrain, oUnit, true) == true then AddNearbyUnitsToThreatGroup(aiBrain, oUnit, sThreatGroup, iRadius) end
        end
    end
end

function UpdatePreviousPlatoonThreatReferences(aiBrain, tEnemyThreatGroup)
    local bDebugMessages = false
    local sFunctionRef = 'UpdatePreviousPlatoonThreatReferences'
    local sPlatoonCurTarget
    for iPlatoon, oPlatoon in aiBrain:GetPlatoonsList() do
        if bDebugMessages == true then LOG(sFunctionRef..': iPlatoon='..iPlatoon) end
        sPlatoonCurTarget = oPlatoon[refsEnemyThreatGroup]
        if sPlatoonCurTarget == nil then
            if bDebugMessages == true then LOG(sFunctionRef..': iPlatoon='..iPlatoon..'; sPlatoonCurTarget is nil, checking previous references') end
            if not(oPlatoon[refstPrevEnemyThreatGroup] == nil) then
                if bDebugMessages == true then LOG(sFunctionRef..': iPlatoon='..iPlatoon..'; refstPrevEnemyThreatGroup size='..table.getn(oPlatoon[refstPrevEnemyThreatGroup])) end
                for iPrevRef, sPrevRef in oPlatoon[refstPrevEnemyThreatGroup] do
                    if not(sPrevRef == nil) then
                        if bDebugMessages == true then LOG(sFunctionRef..': iPlatoon='..iPlatoon..'; Have located a previous reference, sPrevRef='..sPrevRef) end
                        --Have located a previous ref - check if we have a new reference for this:
                        oPlatoon[refsEnemyThreatGroup] = tUnitGroupPreviousReferences[sPrevRef]
                        break
                    end
                end
            else
                if bDebugMessages == true then LOG(sFunctionRef..': iPlatoon='..iPlatoon..'; refstPrevEnemyThreatGroup is nil') end
            end
        end
    end
end

function RemoveSpareUnits(oPlatoon, iThreatNeeded, iMinScouts, iMinMAA, oPlatoonToAddTo, bIgnoreIfNearbyEnemies)
    --Remove any units not needed for iThreatNeeded, on assumption remaining units will be merged into oPlatoonToAddTo (so will remove units furthest from that platoon)
    --bIgnoreIfNearbyEnemies (default is yes) is true then won't remove units if have nearby enemies (based on the localised platoon enemy detection)

    local bDebugMessages = false
    local sFunctionRef = 'RemoveSpareUnits'
    local iCurUnitThreat = 0
    local iRemainingThreatNeeded = iThreatNeeded
    local bRemoveRemainingUnits = false
    local iScoutsWanted = iMinScouts
    local iMAAWanted = iMinMAA
    local bRemoveCurUnit = false
    local iRetainedThreat = 0
    if bIgnoreIfNearbyEnemies == nil then bIgnoreIfNearbyEnemies = true end
    --Do we have any nearby enemies?
    if bDebugMessages == true then LOG(sFunctionRef..': EnemiesInRange='..oPlatoon[M27PlatoonUtilities.refiEnemiesInRange]) end
    if not(oPlatoon[M27PlatoonUtilities.refiEnemiesInRange] > 0 or oPlatoon[M27PlatoonUtilities.refiEnemyStructuresInRange] > 0) then
        --local iSearchRange = M27Logic.GetUnitMaxGroundRange(oPlatoon[M27PlatoonUtilities.reftCurrentUnits]) * 1.4
        --if iSearchRange < 40 then iSearchRange = 40 end

        local tTargetMergePoint = oPlatoonToAddTo:GetPlatoonPosition()
        local aiBrain = oPlatoon:GetBrain()
        if tTargetMergePoint == nil then
            M27Utilities.ErrorHandler('tTargetMergePoint is nil; will replace with player start position')
            if oPlatoonToAddTo == aiBrain:GetPlatoonUniquelyNamed('ArmyPool') then LOG(sFunctionRef..' Trying to merge into Armypool - maybe ArmyPool doesnt work for get platoon position') end
            tTargetMergePoint = M27MapInfo.PlayerStartPoints[aiBrain.M27StartPositionNumber]
        end
        --First remove spare scouts (duplicates later call in overseer to help reduce cases where get into constant cycle of removing scout, falling below threat threshold, re-adding scout to go above, then removing again)
        RemoveSpareNonCombatUnits(oPlatoon)
        local tUnits = oPlatoon:GetPlatoonUnits()
        local tUnitPos = {}

        for iCurUnit, oUnit in tUnits do
            if oUnit == M27Utilities.GetACU(aiBrain) then
                if bDebugMessages == true then LOG(sFunctionRef..': oPlatoon includes ACU, plan='..oPlatoon:GetPlan()) end
            end
            tUnitPos = oUnit:GetPosition()
            if not(tUnitPos == nil) then
                oUnit[refiDistanceFromEnemy] = M27Utilities.GetDistanceBetweenPositions(tTargetMergePoint, oUnit:GetPosition())
                else
                M27Utilities.ErrorHandler('tUnitPos is nil; iCurUnit='..iCurUnit..'; oPlatoon plan+count='..oPlatoon:GetPlan()..oPlatoon[refiPlatoonCount])
                oUnit[refiDistanceFromEnemy] = 10000 end
        end
        for iCurUnit, oUnit in M27Utilities.SortTableBySubtable(tUnits, refiDistanceFromEnemy, true) do
            --GetCombatThreatRating(aiBrain, tUnits, bUseBlip, iMassValueOfBlipsOverride)
            if not(oUnit.Dead or oUnit:BeenDestroyed()) then
                if bDebugMessages == true then LOG(sFunctionRef..': iCurUnit='..iCurUnit..'; Distance from platoon='..oUnit[refiDistanceFromEnemy]) end
                if bRemoveRemainingUnits == false then
                    iCurUnitThreat = M27Logic.GetCombatThreatRating(oPlatoon:GetBrain(), {oUnit}, false)
                    iRemainingThreatNeeded = iRemainingThreatNeeded - iCurUnitThreat
                    iRetainedThreat = iRetainedThreat + iCurUnitThreat
                    if iRemainingThreatNeeded < 0 then bRemoveRemainingUnits = true end
                else
                    bRemoveCurUnit = true
                    if iScoutsWanted > 0 then
                        if EntityCategoryContains(categories.SCOUT, oUnit:GetUnitId()) == true then
                            if bDebugMessages == true then LOG(sFunctionRef..': Not removing unit as its a scout and we need a scout') end
                            iScoutsWanted = iScoutsWanted - 1
                            iRetainedThreat = iRetainedThreat + M27Logic.GetCombatThreatRating(oPlatoon:GetBrain(), {oUnit}, false)
                            bRemoveCurUnit = false
                        end
                    end
                    if iMAAWanted > 0 then
                        if EntityCategoryContains(categories.ANTIAIR, oUnit:GetUnitId()) == true then
                            if bDebugMessages == true then LOG(sFunctionRef..': Not removing unit as its a MAA and we need a MAA') end
                            iMAAWanted = iMAAWanted - 1
                            iRetainedThreat = iRetainedThreat + M27Logic.GetCombatThreatRating(oPlatoon:GetBrain(), {oUnit}, false)
                            bRemoveCurUnit = false
                        end
                    end
                    if bRemoveCurUnit == true then M27PlatoonUtilities.RemoveUnitsFromPlatoon(oPlatoon, {oUnit}, false, oPlatoonToAddTo) end
                end
            end
        end
        oPlatoon[refiTotalThreat] = iRetainedThreat
    end
end

function RecordAvailablePlatoonAndReturnValues(aiBrain, oPlatoon, iAvailableThreat, iCurAvailablePlatoons, tCurPos, iDistFromEnemy, iDistToOurBase, tAvailablePlatoons, tNilDefenderPlatoons)
    --Used by ThreatAssessAndRespond - Split out into this function as used in 2 places so want to make sure any changes are reflected in both
    local bDebugMessages = false
    local sFunctionRef = 'RecordAvailablePlatoonAndReturnValues'
    local oArmyPoolPlatoon = aiBrain:GetPlatoonUniquelyNamed('ArmyPool')
    local oRecordedPlatoon
    local bIgnore = false
    if oPlatoon == oArmyPoolPlatoon then
        bIgnore = true
        oRecordedPlatoon = aiBrain:MakePlatoon('', '')
        local tMobileLand = EntityCategoryFilterDown(categories.LAND * categories.MOBILE, oPlatoon:GetPlatoonUnits())
        if M27Utilities.IsTableEmpty(tMobileLand) == false then
            local tArmyPoolUnits = EntityCategoryFilterDown(categories.DIRECTFIRE + categories.INDIRECTFIRE - categories.SCOUT - categories.ANTIAIR, tMobileLand)
            if M27Utilities.IsTableEmpty(tArmyPoolUnits) == false then
                aiBrain:AssignUnitsToPlatoon(oRecordedPlatoon, tArmyPoolUnits, 'Attack', 'None')
                oRecordedPlatoon:SetAIPlan(sDefenderPlatoonRef)
                if bDebugMessages == true then LOG(sFunctionRef..': Created new defender platoon for armypool combat units; oRecordedPlatoon plan='..oRecordedPlatoon:GetPlan()) end
            end
        end
    else
        oRecordedPlatoon = oPlatoon
    end
    if bIgnore == false then
        oRecordedPlatoon[refiTotalThreat] = M27Logic.GetCombatThreatRating(aiBrain, oRecordedPlatoon:GetPlatoonUnits(), false) --returns 0 rather than nil if no threat/any issue
        if bDebugMessages == true then LOG(sFunctionRef..'; Total threat of platoon='..oRecordedPlatoon[refiTotalThreat]) end
        iAvailableThreat = iAvailableThreat + oRecordedPlatoon[refiTotalThreat]
        iCurAvailablePlatoons = iCurAvailablePlatoons + 1
        tAvailablePlatoons[iCurAvailablePlatoons] = {}
        tAvailablePlatoons[iCurAvailablePlatoons] = oRecordedPlatoon
        --if oRecordedPlatoon == oArmyPoolPlatoon then
            --[[--Create new defenderAI platoon that includes mobile land combat units from oArmyPoolPlatoon
            oRecordedPlatoon[reftAveragePosition] = M27MapInfo.PlayerStartPoints[aiBrain.M27StartPositionNumber]
            oRecordedPlatoon[refiDistanceFromEnemy] = M27Utilities.GetDistanceBetweenPositions(M27MapInfo.PlayerStartPoints[aiBrain.M27StartPositionNumber], M27MapInfo.PlayerStartPoints[M27Logic.GetNearestEnemyStartNumber(aiBrain)])
            oRecordedPlatoon[refiDistanceFromOurBase] = 0
            bArmyPoolInAvailablePlatoons = true]]--
        --else
            oRecordedPlatoon[reftAveragePosition] = tCurPos
            oRecordedPlatoon[refiDistanceFromEnemy] = iDistFromEnemy
            oRecordedPlatoon[refiDistanceFromOurBase] = iDistToOurBase
            if oRecordedPlatoon[refsEnemyThreatGroup] == nil then
                local iNilPlatoonCount = table.getn(tNilDefenderPlatoons)
                if iNilPlatoonCount == nil then iNilPlatoonCount = 0 end
                tNilDefenderPlatoons[iNilPlatoonCount + 1] = {}
                tNilDefenderPlatoons[iNilPlatoonCount + 1] = oRecordedPlatoon
            end
        --end
    end
    return iAvailableThreat, iCurAvailablePlatoons
end

function ThreatAssessAndRespond(aiBrain)
    --Identifies enemy threats, and organises platoons which are sent to deal with them
    local bDebugMessages = false
    local sFunctionRef = 'ThreatAssessAndRespond'

    --Key config variables:
    local iThreatGroupDistance = 10
    local iACUDistanceToConsider = 30 --If enemy within this distance of ACU, and within iACUEnemyDistanceFromBase distance of our base, ACU will consider helping (subject to also helping in emergency situation)
    local iACUEnemyDistanceFromBase = 80
    local iEmergencyExcessEnemyThreatNearBase = 200 --If >this much threat near our base ACU will consider helping from a much further distance away
    local iMaxACUEmergencyThreatRange = 150 --If ACU is more than this distance from our base then won't help even if an emergency threat
    local iThreatMaxFactor = 1.3 --i.e. will send up to iThreatMaxFactor * enemy threat to deal with the platoon
    --Other variables
    local sPlan
    local sThreatGroup, iCurThreatGroup
    local iGameTime = math.floor(GetGameTimeSeconds())
    local bGetACUHelp, oACU, sACUPlan
    local tACUPos = {}
    local tEnemyDistanceForSorting = {}
    local iArmyIndex = aiBrain:GetArmyIndex()
    local tEnemyUnits = aiBrain:GetUnitsAroundPoint(categories.LAND, M27MapInfo.PlayerStartPoints[aiBrain.M27StartPositionNumber], iOverseerRange, 'Enemy')
    local tRallyPoint = {}
    local tCurPos = {}
    local iDistToOurBase
    local tAvailablePlatoons
    local tNilDefenderPlatoons
    local oCombatPlatoonToMergeInto
    local bNoMorePlatoons
    local oCurEnemyUnit, iAvailableThreat, iCurAvailablePlatoons, bPlatoonIsAvailable
    local iDistFromEnemy, iThreatNeeded, iThreatWanted
    local oDefenderPlatoon, oBasePlatoon
    local iMinScouts, iMinMAA, bIsFirstPlatoon
    local oArmyPoolPlatoon
    local bAddedUnitsToPlatoon = false

    if bDebugMessages == true then LOG(sFunctionRef..': About to reset enemy threat groups') end
    ResetEnemyThreatGroups(aiBrain)
    if bDebugMessages == true then LOG(sFunctionRef..': Getting ACU platoon and action') DebugPrintACUPlatoon(aiBrain) end
    iCurThreatGroup = 0
    for iCurEnemy, oEnemyUnit in tEnemyUnits do
        --Can we see enemy unit/blip:
        --function CanSeeUnit(aiBrain, oUnit, bBlipOnly)
        if bDebugMessages == true then LOG(sFunctionRef..': iCurEnemy='..iCurEnemy..' - about to see if can see the unit and get its threat') end
        if M27Utilities.CanSeeUnit(aiBrain, oEnemyUnit, true) == true then
            if oEnemyUnit[refsEnemyThreatGroup] == nil then
                --enemy unit hasn't been assigned a threat group - assign it to one now if it's not already got a threat group:
                if not(oEnemyUnit[iArmyIndex][refbUnitAlreadyConsidered] == true) then
                    iCurThreatGroup = iCurThreatGroup + 1
                    sThreatGroup = 'M27'..iGameTime..'No'..iCurThreatGroup
                    oEnemyUnit[iArmyIndex][refsEnemyThreatGroup] = sThreatGroup
                    if bDebugMessages == true then LOG(sFunctionRef..': iCurEnemy='..iCurEnemy..' - about to add unit to threat group '..sThreatGroup) end
                    AddNearbyUnitsToThreatGroup(aiBrain, oEnemyUnit, sThreatGroup, iThreatGroupDistance)
                end
            end
        end
    end
    if bDebugMessages == true then LOG(sFunctionRef..': Finished going through enemy units, iCurThreatGroup='..iCurThreatGroup) end

    --Cycle through each threat group, record threat, average position, and distance to our base
    if iCurThreatGroup > 0 then
        oArmyPoolPlatoon = aiBrain:GetPlatoonUniquelyNamed('ArmyPool')
        oACU = M27Utilities.GetACU(aiBrain)
        tACUPos = oACU:GetPosition()
        if bDebugMessages == true then LOG(sFunctionRef..': tACUPos='..repr(tACUPos)) end
        if bDebugMessages == true then LOG(sFunctionRef..': ACU ID='..oACU:GetUnitId()) end

        for iCurGroup, tEnemyThreatGroup in aiBrain[reftEnemyThreatGroup] do
            UpdatePreviousPlatoonThreatReferences(aiBrain, tEnemyThreatGroup)
            --function GetCombatThreatRating(aiBrain, tUnits, bUseBlip, iMassValueOfBlipsOverride)
            if bDebugMessages == true then LOG(sFunctionRef..': Finished updating previous platoon threat references; iCurGroup='..iCurGroup..';  through enemy units, iCurThreatGroup='..iCurThreatGroup) end
            if bDebugMessages == true then LOG(sFunctionRef..': EnemyThreat='..M27Logic.GetCombatThreatRating(aiBrain, tEnemyThreatGroup[refoEnemyGroupUnits], true)) end
            if bDebugMessages == true then LOG('Units in tEnemyThreatGroup='..table.getn(tEnemyThreatGroup[refoEnemyGroupUnits])) end
            tEnemyThreatGroup[refiTotalThreat] = M27Logic.GetCombatThreatRating(aiBrain, tEnemyThreatGroup[refoEnemyGroupUnits], true)
            tEnemyThreatGroup[reftAveragePosition] = M27Utilities.GetAveragePosition(tEnemyThreatGroup[refoEnemyGroupUnits])
            tEnemyThreatGroup[refiDistanceFromOurBase] = M27Utilities.GetDistanceBetweenPositions(tEnemyThreatGroup[reftAveragePosition], M27MapInfo.PlayerStartPoints[aiBrain.M27StartPositionNumber])
            tEnemyDistanceForSorting[iCurGroup] = {}
            tEnemyDistanceForSorting[iCurGroup] = tEnemyThreatGroup[refiDistanceFromOurBase]
        end
        --Sort threat groups by distance to our base:
        if bDebugMessages == true then LOG(sFunctionRef..': About to sort table of enemy threat groups') end
        if bDebugMessages == true then
            LOG('Threat groups before sorting:')
            for i1, o1 in aiBrain[reftEnemyThreatGroup] do
                LOG('i1='..i1..'; o1.refiDistanceFromOurBase='..o1[refiDistanceFromOurBase]..'; threat group threat='..o1[refiTotalThreat]) end
        end
        --aiBrain[reftEnemyThreatGroup] =
        --[[M27Utilities.SortTableBySubtable(aiBrain[reftEnemyThreatGroup], refiDistanceFromOurBase, true) --sorts by low distance to high
        LOG('Table size='..table.getn(aiBrain[reftEnemyThreatGroup]))
        if bDebugMessages == true then
            LOG('Threat groups after sorting:')
            for i1, o1 in aiBrain[reftEnemyThreatGroup] do
                LOG('i1='..i1..'; o1.refiDistanceFromOurBase='..o1[refiDistanceFromOurBase]..'; threat group threat='..o1[refiTotalThreat]) end
        end]]--
        --for iEnemyGroup, tEnemyThreatGroup in aiBrain[reftEnemyThreatGroup] do
        aiBrain[refbNeedDefenders] = false
        for iEnemyGroup, tEnemyThreatGroup in M27Utilities.SortTableBySubtable(aiBrain[reftEnemyThreatGroup], refiDistanceFromOurBase, true) do
            if bDebugMessages == true then LOG(sFunctionRef..': Start of cycle through sorted table of each enemy threat group; iEnemyGroup='..iEnemyGroup..'; distance from our base='..tEnemyThreatGroup[refiDistanceFromOurBase]) end
            bNoMorePlatoons = false
            --Get total threat of non-committed platoons closer to our base than enemy:
            iAvailableThreat = 0
            iCurAvailablePlatoons = 0
            tAvailablePlatoons = {}
            tNilDefenderPlatoons = {}
            --bArmyPoolInAvailablePlatoons = false
            for iPlatoon, oPlatoon in aiBrain:GetPlatoonsList() do
                bPlatoonIsAvailable = false
                sPlan = oPlatoon:GetPlan()
                --Only include defender platoons that are closer to our base than enemy threat, and which aren't already dealing with a threat
                if oPlatoon[M27PlatoonUtilities.refiPlatoonCount] == nil then oPlatoon[M27PlatoonUtilities.refiPlatoonCount] = 0 end
                if bDebugMessages == true then LOG(sFunctionRef..': Considering available platoons; iPlatoon='..iPlatoon..'; sPlan='..sPlan..oPlatoon[M27PlatoonUtilities.refiPlatoonCount]..'; iEnemyGroup='..iEnemyGroup..'; sDefenderPlatoonRef='..sDefenderPlatoonRef) end
                if sPlan == sDefenderPlatoonRef then
                    tCurPos = oPlatoon:GetPlatoonPosition()
                    iDistToOurBase = M27Utilities.GetDistanceBetweenPositions(tCurPos, M27MapInfo.PlayerStartPoints[aiBrain.M27StartPositionNumber])
                    if iDistToOurBase <= tEnemyThreatGroup[refiDistanceFromOurBase] then
                        if oPlatoon[refsEnemyThreatGroup] == nil then
                            bPlatoonIsAvailable = true
                            if bDebugMessages == true then LOG(sFunctionRef..': Platoons current target is nil so platoon is available; iPlatoon='..iPlatoon) end
                        else
                            if bDebugMessages == true then LOG(sFunctionRef..': iPlatoon='..iPlatoon..'; Is busy targetting '..oPlatoon[refsEnemyThreatGroup]..'; curent threat group considering is: '..iEnemyGroup) end
                            if sThreatGroup == nil then LOG(repr(aiBrain[reftEnemyThreatGroup])) end
                            --aiBrain[reftEnemyThreatGroup][sThreatGroup][refsEnemyGroupName] = sThreatGroup
                            if oPlatoon[refsEnemyThreatGroup] == iEnemyGroup then bPlatoonIsAvailable = true end
                        end
                    else
                        if bDebugMessages == true then LOG(sFunctionRef..': Platoon is too far away to be of help; iPlatoon='..iPlatoon..'; sPlan='..sPlan..oPlatoon[M27PlatoonUtilities.refiPlatoonCount]..'; iEnemyGroup='..iEnemyGroup..'; iDistToOurBase='..iDistToOurBase..'; tEnemyThreatGroup[refiDistanceFromOurBase]='..tEnemyThreatGroup[refiDistanceFromOurBase]) end
                    end
                else
                    if bDebugMessages == true then LOG(sFunctionRef..': Platoon plan isnt equal to defender plan. iPlatoon='..iPlatoon..'; sPlan='..sPlan..oPlatoon[M27PlatoonUtilities.refiPlatoonCount]..'; iEnemyGroup='..iEnemyGroup) end
                end
                if bPlatoonIsAvailable == true then
                    --Add current platoon details:
                    iDistFromEnemy = M27Utilities.GetDistanceBetweenPositions(tCurPos, tEnemyThreatGroup[reftAveragePosition])
                    if bDebugMessages == true then LOG(sFunctionRef..': Platoon is available, will record the threat; iAvailableThreat pre updating='..iAvailableThreat) end
                    iAvailableThreat, iCurAvailablePlatoons = RecordAvailablePlatoonAndReturnValues(aiBrain, oPlatoon, iAvailableThreat, iCurAvailablePlatoons, tCurPos, iDistFromEnemy, iDistToOurBase, tAvailablePlatoons, tNilDefenderPlatoons)
                    if bDebugMessages == true then LOG(sFunctionRef..': Platoon is available, have recorded the threat; iAvailableThreat post updating='..iAvailableThreat) end
                end
            end
            --Ensure enemy engis will have a unit capable of killing them quickly
            if tEnemyThreatGroup[refiTotalThreat] < 20 then tEnemyThreatGroup[refiTotalThreat] = 20 end
            -- Do we have enough threat available? If not, add ACU if enemy is near
            iThreatNeeded = tEnemyThreatGroup[refiTotalThreat]
            iThreatWanted = iThreatNeeded * iThreatMaxFactor
            if bDebugMessages == true then LOG(sFunctionRef..': Considering action based on our threat vs enemy; EnemyThreat='..tEnemyThreatGroup[refiTotalThreat]..'; iAvailableThreat='..iAvailableThreat) end
            if iAvailableThreat < iThreatNeeded then
                --Add army pool to the available threat
                if bDebugMessages == true then LOG(sFunctionRef..': Considering whether to add army pool to deal with threat') end
                --if bArmyPoolInAvailablePlatoons == false then
                    --GetCombatThreatRating(aiBrain, tUnits, bUseBlip, iMassValueOfBlipsOverride)
                    tCurPos = M27MapInfo.PlayerStartPoints[aiBrain.M27StartPositionNumber]
                    iDistFromEnemy = M27Utilities.GetDistanceBetweenPositions(tCurPos, tEnemyThreatGroup[reftAveragePosition])
                    iDistToOurBase = 0
                    iAvailableThreat, iCurAvailablePlatoons = RecordAvailablePlatoonAndReturnValues(aiBrain, oArmyPoolPlatoon, iAvailableThreat, iCurAvailablePlatoons, tCurPos, iDistFromEnemy, iDistToOurBase, tAvailablePlatoons, tNilDefenderPlatoons)
                    --iAvailableThreat = iAvailableThreat + M27Logic.GetCombatThreatRating(aiBrain, oArmyPoolPlatoon:GetPlatoonUnits(), false)
                    --table.insert(tAvailablePlatoons, oArmyPoolPlatoon)

                --end
            end
            if iAvailableThreat < iThreatNeeded then
                --Check if should add ACU to help fight - is enemy relatively close to ACU, relatively close to our start, and ACU is closer to start than enemy?
                bGetACUHelp = false
                iDistFromEnemy = M27Utilities.GetDistanceBetweenPositions(tACUPos, tEnemyThreatGroup[reftAveragePosition])
                if bDebugMessages == true then LOG(sFunctionRef..': Considering whether should get ACU to help; iDistFromEnemy ='..iDistFromEnemy) end
                if iDistFromEnemy < iACUDistanceToConsider then
                    if tEnemyThreatGroup[refiDistanceFromOurBase] < iACUEnemyDistanceFromBase then
                        iDistToOurBase = M27Utilities.GetDistanceBetweenPositions(tACUPos, M27MapInfo.PlayerStartPoints[aiBrain.M27StartPositionNumber])
                        if iDistToOurBase < tEnemyThreatGroup[refiDistanceFromOurBase] then
                            --are we closer to our base than enemy?
                            local iEnemyStartPoint = M27Logic.GetNearestEnemyStartNumber(aiBrain)
                            if iEnemyStartPoint then
                                local iDistToEnemyBase = M27Utilities.GetDistanceBetweenPositions(tACUPos, M27MapInfo.PlayerStartPoints[iEnemyStartPoint])
                                if iDistToEnemyBase > 0 and iDistToOurBase / iDistToEnemyBase < 0.85 then bGetACUHelp = true end
                            end
                        end
                    end
                end
                if bDebugMessages == true then LOG(sFunctionRef..': bGetACUHelp='..tostring(bGetACUHelp)..'; if this is false then will check if emergency response required') end
                --Check if emergency response required:
                if bGetACUHelp == false then
                    if tEnemyThreatGroup[refiDistanceFromOurBase] < iACUEnemyDistanceFromBase then
                        if iThreatNeeded - iAvailableThreat > iEmergencyExcessEnemyThreatNearBase and iThreatNeeded > 0 and iAvailableThreat / iThreatNeeded < 0.85 then
                            if iDistToOurBase <= iMaxACUEmergencyThreatRange then
                                bGetACUHelp = true
                                if bDebugMessages == true then LOG(sFunctionRef..': bGetACUHelp='..tostring(bGetACUHelp)..'; Emergency response is required') end
                            end
                        end
                    end
                end


                --Check ACU isn't upgrading
                if bGetACUHelp == true then
                    if bDebugMessages == true then LOG(sFunctionRef..': checking if ACU is upgrading') end
                    if oACU:IsUnitState('Upgrading') == true then
                        if bDebugMessages == true then LOG(sFunctionRef..': ACU is upgrading so dont want it to help') end
                        bGetACUHelp = false
                    end
                end
                --Check ACU hasn't finished its gun upgrade (want both for aeon):
                if bGetACUHelp == true then
                    if M27Conditions.DoesACUHaveGun(aiBrain, true) == true then
                        if bDebugMessages == true then LOG(sFunctionRef..': ACU has gun upgrade so dont want it to help as it should be attacking') end
                        bGetACUHelp = false end
                end

                oACU[refbACUHelpWanted] = bGetACUHelp
                if bGetACUHelp == true then
                    --Check if ACU not already in a defender platoon:
                    sACUPlan = DebugPrintACUPlatoon(aiBrain, true)
                    if not(sACUPlan == sDefenderPlatoonRef) then
                        --Flag that ACU has been added to defenders if its using the main AI
                        if DebugPrintACUPlatoon(aiBrain, true) == 'M27ACUMain' then aiBrain[refbACUWasDefending] = true end
                        --Add ACU to defenders
                        if bDebugMessages == true then LOG(sFunctionRef..': Getting ACU threat rating before adding to defenders; iAvailableThreat before adding ACU='..iAvailableThreat) end
                        local oACUPlatoon = oACU.PlatoonHandle
                        if oACUPlatoon == nil then
                            if bDebugMessages == true then LOG(sFunctionRef..': oACUs platoon handle is nil, creating new plan for ACU') end
                            oACUPlatoon = aiBrain:MakePlatoon('', '')
                            aiBrain:AssignUnitsToPlatoon(oACUPlatoon, {oACU},'Attack', 'None')
                            oACUPlatoon:SetAIPlan(sDefenderPlatoonRef)
                        else
                            if bDebugMessages == true then LOG(sFunctionRef..': ACU will help so have enough threat; iAvailableThreat before adding ACU='..iAvailableThreat..'; changing ACUs plan to use defender plan') end
                            oACU.PlatoonHandle:SetAIPlan(sDefenderPlatoonRef)
                            bACUIsDefending = true
                        end
                        iAvailableThreat, iCurAvailablePlatoons = RecordAvailablePlatoonAndReturnValues(aiBrain, oACU.PlatoonHandle, iAvailableThreat, iCurAvailablePlatoons, tACUPos, iDistFromEnemy, iDistToOurBase, tAvailablePlatoons, tNilDefenderPlatoons)
                        if bDebugMessages == true then LOG(sFunctionRef..': iAvailableThreat after adding ACU to available platoons='..iAvailableThreat) end
                        --iAvailableThreat = iAvailableThreat + M27Logic.GetCombatThreatRating(aiBrain, {oACU}, false)

                    end
                end
                if bDebugMessages == true then LOG(sFunctionRef..': Finished considering if ACU should help; bGetACUHelp='..tostring(bGetACUHelp)) end
            else
                --Threat higher than needed, so flag that don't need ACU help
                oACU[refbACUHelpWanted] = false
            end
            --Now that have all available units, decide on action based on enemy threat
            if iAvailableThreat < iThreatNeeded then
                aiBrain[refbNeedDefenders] = true --will assign more units to defender platoon
                --Dont have enough units yet, so get units in position so when have enough can respond
                --Go to midpoint, or if enemy too close then to base
                if bDebugMessages == true then LOG(sFunctionRef..': Dont have enough threat to deal with enemy - iAvailableThreat='..iAvailableThreat..'; iThreatNeeded='..iThreatNeeded..'; set refbNeedDefenders to true; getting rally point for any available platoons to retreat to') end
                if bDebugMessages == true then LOG(sFunctionRef..': ACU state='..M27Logic.GetUnitState(M27Utilities.GetACU(aiBrain))) end
                tRallyPoint = {}
                if tEnemyThreatGroup[refiDistanceFromOurBase] > 60 then
                    tRallyPoint[1] = (tEnemyThreatGroup[reftAveragePosition][1] + M27MapInfo.PlayerStartPoints[aiBrain.M27StartPositionNumber][1]) / 2
                    tRallyPoint[3] = (tEnemyThreatGroup[reftAveragePosition][3] + M27MapInfo.PlayerStartPoints[aiBrain.M27StartPositionNumber][3]) / 2
                    tRallyPoint[2] = GetTerrainHeight(tRallyPoint[1], tRallyPoint[3])
                else
                    if bDebugMessages == true then LOG(sFunctionRef..': Enemy is clsoe to our base, so rally point is our base') end
                    tRallyPoint = M27MapInfo.PlayerStartPoints[aiBrain.M27StartPositionNumber] end
                for iPlatoon, oPlatoon in tAvailablePlatoons do
                    oPlatoon[refsEnemyThreatGroup] = nil
                    if not(oPlatoon==oArmyPoolPlatoon) then --redundancy/from old code - armypool shouldnt be in availableplatoons any more
                        oPlatoon[M27PlatoonUtilities.refiOverseerAction] = M27PlatoonUtilities.refActionReissueMovementPath
                        M27PlatoonUtilities.ForceActionRefresh(oPlatoon)
                        oPlatoon[M27PlatoonUtilities.reftMovementPath] = {}
                        oPlatoon[M27PlatoonUtilities.reftMovementPath][1] = tRallyPoint
                        oPlatoon[M27PlatoonUtilities.refiCurrentPathTarget] = 1
                        --oPlatoon[M27PlatoonUtilities.refiLastPathTarget] = 1
                        oPlatoon[M27PlatoonUtilities.refbOverseerAction] = true
                        --IssueClearCommands(oPlatoon:GetPlatoonUnits())
                        if bDebugMessages == true then LOG(sFunctionRef..': Set tMovementPath[1] to tRallyPoint='..tRallyPoint[1]..'-'..tRallyPoint[3]..' and then stop looking at remaining threats; iPlatoon='..iPlatoon..'; Plan+Count='..oPlatoon:GetPlan()..oPlatoon[M27PlatoonUtilities.refiPlatoonCount]) end
                    else
                        --Armypool platoon - do nothing - shouldve already had combat units added to an available platoon; rely on new platoons being created soon that get sent commands (as if try issuing commands to army pool it can stop platoons being created)
                    end
                end
                break
            else
                --Can beat enemy so attack them - filter to just those platoons that need to deal with the threat if we have more than what is needed:
                --if iAvailableThreat >= iThreatWanted then
                    --Only need some of the platoon units, pick the ones nearest the enemy
                    --tAvailablePlatoons =
                    --M27Utilities.SortTableBySubtable(tAvailablePlatoons, refiDistanceFromEnemy, true)
                --end
                iMinScouts = 1 --Want to make sure defender platoon has at least 1 scout if one is available
                iMinMAA = 1 --as per scouts
                bIsFirstPlatoon = true
                --TODO - if run into performance issues could see if it works by setting a new variable equal to the sorted table where need sorting, and not where don't need sorting; however may not work as repeated calls to a variable that uses the sorttables causes errors since sorttables is a function of a table
                local bNeedBasePlatoon = true
                bAddedUnitsToPlatoon = false
                for iPlatoonRef, oAvailablePlatoon in M27Utilities.SortTableBySubtable(tAvailablePlatoons, refiDistanceFromEnemy, true) do
                --for iCurPlatoon = 1, iCurAvailablePlatoons do

                    oDefenderPlatoon = tAvailablePlatoons[iPlatoonRef]
                    if iThreatWanted <= 0 then
                        --Ensure platoon is available to target other platoons as it's not needed for this one
                        oDefenderPlatoon[refsEnemyThreatGroup] = nil
                    else
                        if bNeedBasePlatoon == true then
                            if not(oBasePlatoon == oArmyPoolPlatoon) then
                                oBasePlatoon = oDefenderPlatoon
                                bNeedBasePlatoon = false
                                if bIsFirstPlatoon == false then
                                    --Means army pool was the first platoon - need to manually add it to the base platoon now to make sure have enough threat
                                    M27PlatoonUtilities.MergePlatoons(oBasePlatoon, oArmyPoolPlatoon)
                                    bAddedUnitsToPlatoon = true
                                end
                            end
                        end

                        if bDebugMessages == true then LOG(sFunctionRef..': Totalthreat group IDd = '..iCurThreatGroup..'; Cur threat group iEnemyGroup='..iEnemyGroup..'iPlatoonRef='..iPlatoonRef..'; iThreatNeeded='..iThreatNeeded..'; iThreatWanted='..iThreatWanted) end
                        if bNeedBasePlatoon == false then
                            --Check if have at least 1 T1 tank too many (otherwise ignore) - 52 is lowest mass cost of a tank (56 is highest)
                            if oDefenderPlatoon[refiTotalThreat] == nil then --e.g. army pool will be nil
                                                                            --GetCombatThreatRating(aiBrain, tUnits, bUseBlip, iMassValueOfBlipsOverride)
                                oDefenderPlatoon[refiTotalThreat] = M27Logic.GetCombatThreatRating(aiBrain, oDefenderPlatoon:GetPlatoonUnits(), false)
                            end
                            if bDebugMessages == true then LOG('oDefenderPlatoon[refiTotalThreat]='..oDefenderPlatoon[refiTotalThreat]) end
                            if oDefenderPlatoon[refiTotalThreat] - iThreatWanted >= 52 then
                                --Determine the first nil platoon that hasn't been assigned to merge units into:
                                if bDebugMessages == true then LOG(sFunctionRef..': Dont need all of the platoon, locate the first different nil defender platoon so spare units can be assigned to this; iPlatoonRef='..iPlatoonRef) end
                                oCombatPlatoonToMergeInto = nil
                                for iNilPlatoon, oNilPlatoon in tNilDefenderPlatoons do
                                    if oNilPlatoon[refsEnemyThreatGroup] == nil then
                                        if not(oNilPlatoon == oDefenderPlatoon) then oCombatPlatoonToMergeInto = oNilPlatoon break end
                                    end
                                end
                                if oCombatPlatoonToMergeInto == nil then oCombatPlatoonToMergeInto = aiBrain:GetPlatoonUniquelyNamed('ArmyPool') end
                                if oDefenderPlatoon == oArmyPoolPlatoon then
                                    if bDebugMessages == true then LOG('oDefenderPlatoon is army pool already, so dont want to try and remove') end
                                else
                                    if bDebugMessages == true then LOG('oDefenderPlatoon is '..oDefenderPlatoon:GetPlan()..oDefenderPlatoon[M27PlatoonUtilities.refiPlatoonCount]) end
                                    if bDebugMessages == true then LOG(sFunctionRef..': Removing spare units from oDefenderPlatoon; iThreatNeeded='..iThreatNeeded..'; oDefenderPlatoon[refiTotalThreat]='..oDefenderPlatoon[refiTotalThreat]) end
                                    RemoveSpareUnits(oDefenderPlatoon, iThreatWanted, iMinScouts, iMinMAA, oCombatPlatoonToMergeInto, true)
                                    if bDebugMessages == true then LOG(sFunctionRef..': Finished removing spare units from oDefenderPlatoon') end
                                    if bIsFirstPlatoon == false then
                                        --function MergePlatoons(oPlatoonToMergeInto, oPlatoonToBeMerged)
                                        if bDebugMessages == true then LOG(sFunctionRef..': About to merge remaining units in defender platoon into base platoon; oBasePlatoon='..oBasePlatoon:GetPlan()..oBasePlatoon[M27PlatoonUtilities.refiPlatoonCount]) end
                                        M27PlatoonUtilities.MergePlatoons(oBasePlatoon, oDefenderPlatoon)
                                        bAddedUnitsToPlatoon = true
                                    end
                                end
                                iThreatWanted = 0
                                iThreatNeeded = 0
                                break
                            else
                                --need all of platoon:
                                if bDebugMessages == true then LOG(sFunctionRef..': About to adjust threat needed for the threat of the available platoon that have just used; iEnemyThreat='..iEnemyGroup..'; iPlatoonRef='..iPlatoonRef..'; iThreatNeeded='..iThreatNeeded..'; oDefenderPlatoon[refiTotalThreat]='..oDefenderPlatoon[refiTotalThreat]) end
                                iThreatNeeded = iThreatNeeded - oDefenderPlatoon[refiTotalThreat]
                                iThreatWanted = iThreatWanted - oDefenderPlatoon[refiTotalThreat]
                                if iThreatWanted <= 0 then bNoMorePlatoons = true end
                                if bIsFirstPlatoon == false then
                                    M27PlatoonUtilities.MergePlatoons(oBasePlatoon, oDefenderPlatoon)
                                    bAddedUnitsToPlatoon = true
                                end
                            end
                        end
                    end
                    if iMinScouts > 0 then
                        if not(EntityCategoryFilterDown(categories.SCOUT, oBasePlatoon:GetPlatoonUnits()) == nil) then iMinScouts = 0 end
                    end
                    if iMinMAA > 0 then
                        if not(EntityCategoryFilterDown(categories.ANTIAIR, oBasePlatoon:GetPlatoonUnits()) == nil) then iMinMAA = 0 end
                    end
                    if not(oBasePlatoon == oArmyPoolPlatoon) then bIsFirstPlatoon = false end
                end
                --Base platoon should now be able to beat enemy
                if oBasePlatoon == nil then
                    LOG(sFunctionRef..': ERROR - oBasePlatoon is nil but had thought could beat the enemy - unless down to just ACU and no defenders likely error')
                else
                    if oBasePlatoon == oArmyPoolPlatoon then
                        LOG(sFunctionRef..': WARNING - oArmyPoolPlatoon is oBasePlatoon - will abort threat intereception logic and flag that want defender platoons to be created')
                        if table.getn(tAvailablePlatoons) <= 1 then aiBrain[refbNeedDefenders] = true end
                    else
                        if oBasePlatoon:GetPlan() == nil then
                            LOG(sFunctionRef..': ERROR - oBasePlatoons plan is nil, will set to be the defender AI')
                            oBasePlatoon:SetAIPlan(sDefenderPlatoonRef)
                        end

                        oBasePlatoon[reftAveragePosition] = oBasePlatoon:GetPlatoonPosition()
                        oBasePlatoon[refiDistanceFromEnemy] = M27Utilities.GetDistanceBetweenPositions(oBasePlatoon[reftAveragePosition], tEnemyThreatGroup[reftAveragePosition])
                        oBasePlatoon[M27PlatoonUtilities.refbOverseerAction] = true
                        if bDebugMessages == true then LOG(sFunctionRef..': About to issue new orders to oBasePlatoon; oBasePlatoon plan+count='..oBasePlatoon:GetPlan()..oBasePlatoon[M27PlatoonUtilities.refiPlatoonCount]..'; units in oBasePlatoon='..table.getn(oBasePlatoon:GetPlatoonUnits())..'; oBasePlatoon[refiDistanceFromEnemy]='..oBasePlatoon[refiDistanceFromEnemy]) end
                        if oBasePlatoon[refiDistanceFromEnemy] <= 30 then
                            if bDebugMessages == true then LOG(sFunctionRef..': Telling base platoon to have actionattack') end
                            oBasePlatoon[M27PlatoonUtilities.refiOverseerAction] = M27PlatoonUtilities.refActionAttack
                            oBasePlatoon[M27PlatoonUtilities.refiEnemiesInRange] = tEnemyThreatGroup[refiEnemyThreatGroupUnitCount]
                            oBasePlatoon[M27PlatoonUtilities.reftEnemiesInRange] = tEnemyThreatGroup[refoEnemyGroupUnits]
                            if bAddedUnitsToPlatoon == true then M27PlatoonUtilities.ForceActionRefresh(oBasePlatoon) end
                        else
                            if bDebugMessages == true then LOG(sFunctionRef..': Telling base platoon to refresh its movement path') end
                            M27PlatoonUtilities.ForceActionRefresh(oBasePlatoon)
                            oBasePlatoon[M27PlatoonUtilities.refiOverseerAction] = M27PlatoonUtilities.refActionReissueMovementPath
                        end
                        --IssueClearCommands(oBasePlatoon:GetPlatoonUnits())
                        oBasePlatoon[M27PlatoonUtilities.reftMovementPath] = {}
                        oBasePlatoon[M27PlatoonUtilities.reftMovementPath][1] = tEnemyThreatGroup[reftAveragePosition]
                        oBasePlatoon[M27PlatoonUtilities.refiCurrentPathTarget] = 1
                        --oBasePlatoon[M27PlatoonUtilities.refiLastPathTarget] = 1
                        oBasePlatoon[refsEnemyThreatGroup] = iEnemyGroup
                        oBasePlatoon[M27PlatoonUtilities.refbOverseerAction] = true
                        --Free up any spare scouts and MAA post-platoon merger:
                        RemoveSpareNonCombatUnits(oBasePlatoon)
                        oBasePlatoon:SetPlatoonFormationOverride('AttackFormation')
                    end
                end
            end --Available threat vs enemy threat
        end --for each tEnemyThreatGroup
        if bDebugMessages == true then LOG(sFunctionRef..': Finished cycling through all tEnemyThreatGroups; end of overseer cycle') end
        if bDebugMessages == true then LOG(sFunctionRef..': End of code - ACU state='..M27Logic.GetUnitState(M27Utilities.GetACU(aiBrain))) end
    else
        --No threat groups
        M27Utilities.GetACU(aiBrain)[refbACUHelpWanted] = false
    end -->0 enemy threat groups
    if bDebugMessages == true then LOG(sFunctionRef..': End of code, getting ACU debug plan and action') DebugPrintACUPlatoon(aiBrain) end
end

function ACUManager(aiBrain)
    local bDebugMessages = false
    local sFunctionRef = 'ACUManager'

    local oACU = M27Utilities.GetACU(aiBrain)
    --Config related
    local iBuildDistance = oACU:GetBlueprint().Economy.MaxBuildDistance

    local iDistanceToLookForMexes = iBuildDistance + iACUMaxTravelToNearbyMex --Note The starting build order uses a condition which references whether ACU has mexes this far away, so factor in if changing this
    local iDistanceToLookForReclaim = iBuildDistance + iACUMaxTravelToNearbyMex
    local iMinReclaimValue = 16

    local tACUPos = oACU:GetPosition()



    local oACUPlatoon = oACU.PlatoonHandle
    local sPlatoonName = 'None'
    if oACUPlatoon and oACUPlatoon.GetPlan then sPlatoonName = oACUPlatoon:GetPlan() end
    local oArmyPoolPlatoon = aiBrain:GetPlatoonUniquelyNamed('ArmyPool')

    if oACUPlatoon then
        iCyclesThatACUHasNoPlatoon = 0
        if oACUPlatoon == oArmyPoolPlatoon then
            sPlatoonName = 'ArmyPool'
            iCyclesThatACUInArmyPool = iCyclesThatACUInArmyPool + 1
        end
    else
        iCyclesThatACUHasNoPlatoon = iCyclesThatACUHasNoPlatoon + 1
        iCyclesThatACUInArmyPool = 0
    end
    --=======ACU Idle override
    local iIdleCount = 0
    local iIdleThreshold = 3
    if M27Logic.IsUnitIdle(oACU, false) == true then
        iIdleCount = iIdleCount + 1
        if iIdleCount > iIdleThreshold then
            local oNewPlatoon = aiBrain:MakePlatoon('', '')
            aiBrain:AssignUnitsToPlatoon(oNewPlatoon, {oACU},'Attack', 'None')
            oNewPlatoon:SetAIPlan('M27ACUMain')
            if oACUPlatoon and not(oACUPlatoon == oArmyPoolPlatoon) and oACUPlatoon.PlatoonDisband then oACUPlatoon:PlatoonDisband() end
        end
    else
        iIdleCount = 0
    end

    --==============ACU PLATOON FORM OVERRIDES==========------------
    --Check to try and ensure ACU gets put in a platoon when its gun upgrade has finished (sometimes this doesnt happen)
    if bDebugMessages == true then LOG(sFunctionRef..'oACU[refbACUHelpWanted]='..tostring(oACU[refbACUHelpWanted])) end

    if M27Conditions.DoesACUHaveGun(aiBrain, true) == true then
        if bDebugMessages == true then LOG(sFunctionRef..': ACU has gun, switching it to the ACUMain platoon if its not using it') end
        local bReplacePlatoon = true
        if sPlatoonName == 'M27ACUMain' then
            if bDebugMessages == true then LOG(sFunctionRef..': ACU is using M27ACUMain already so dont refresh platoon') end
            bReplacePlatoon = false
        else
            if bDebugMessages == true then LOG(sFunctionRef..': ACU is using '..sPlatoonName..': Will refresh unless are building') end
            --Check if are building something
            local bLetACUFinishBuilding = false
            if oACU:IsUnitState('Building') == true then
                local oUnitBeingBuilt = oACU:GetFocusUnit()
                if oUnitBeingBuilt:GetFractionComplete() <= 0.25 then
                    --Only keep building if is a mex
                    local sBeingBuilt = oUnitBeingBuilt:GetUnitId()
                    if EntityCategoryContains(categories.MASSEXTRACTION, sBeingBuilt) == true then bLetACUFinishBuilding = true end
                else bLetACUFinishBuilding = true
                end
            end

            if bLetACUFinishBuilding == true then bReplacePlatoon = true end
        end
        if bReplacePlatoon == true then
            if bDebugMessages == true then LOG(sFunctionRef..': ACU is using '..sPlatoonName..': Are creating a new AI for ACU') end
            local oNewPlatoon = aiBrain:MakePlatoon('', '')
            aiBrain:AssignUnitsToPlatoon(oNewPlatoon, {oACU},'Attack', 'None')
            oNewPlatoon:SetAIPlan('M27ACUMain')
        end
            --ACU isn't in main platoon - create a new one for it to join unless its >20% of the way building something

            --[[
            if bDebugMessages == true then LOG(sFunctionRef..': ACU has platoon, checking if its army pool') end
            local oArmyPoolPlatoon = aiBrain:GetPlatoonUniquelyNamed('ArmyPool')
            if oACUPlatoon == oArmyPoolPlatoon then
                if bDebugMessages == true then LOG(sFunctionRef..': ACU is in army pool, clearing its commands') end
                IssueClearCommands({oACU})
            else
                if bDebugMessages == true then LOG(sFunctionRef..': ACU isnt in army pool, checking if its in large attack AI') end
                local sACUPlan = oACUPlatoon:GetPlan()
                if sACUPlan == 'M27LargeAttackForce' then
                    if bDebugMessages == true then LOG(sFunctionRef..': ACU is in large attack platoon - dont change anything') end
                else
                    if bDebugMessages == true then LOG(sFunctionRef..': ACU isnt in large attack platoon - removing it from current platoon') end
                    --RemoveUnitsFromPlatoon(oPlatoon, tUnits, bReturnToBase, oPlatoonToAddTo)
                    M27PlatoonUtilities.RemoveUnitsFromPlatoon(oACUPlatoon, {oACU}, false)
                end
            end ]]--
    else
        --NOTE: Rare error where ACU would start upgrade and then cancel straight away - if happens again, expand the code where are disbanding to get upgrade so that it also assigns the command to get the upgrade
        local bCreateNewPlatoon = false
        local bDisbandExistingPlatoon = false
        if oACUPlatoon == nil then
            if bDebugMessages == true then LOG(sFunctionRef..': ACU has no gun and no platoon') end
            if iCyclesThatACUHasNoPlatoon > 4 then --5 cycles where no platoon, so create a new one unless ACU is busy
                if GetGameTimeSeconds() > 30 then --at start of game is a wait of longer than 4 seconds before ACU is able to do anything
                    bCreateNewPlatoon = true
                    if bDebugMessages == true then LOG(sFunctionRef..': ACU been in no platoon for '..iCyclesThatACUHasNoPlatoon..' cycles so giving it a platoon unless its reclaiming/repairing/upgrading/building') end
                    --Dont create if ACU is doing somethign likely useful
                    if oACU:IsUnitState('Building') == true or oACU:IsUnitState('Reclaiming') == true or oACU:IsUnitState('Repairing') == true or oACU:IsUnitState('Upgrading') == true or oACU:IsUnitState('Guarding') then bCreateNewPlatoon = false end
                end
            end
        else
            if oACUPlatoon == oArmyPoolPlatoon then
                if bDebugMessages == true then LOG(sFunctionRef..': ACU has no gun is in army pool, will try and create a new platoon if no help needed from ACU') end
                if oACU[refbACUHelpWanted] == false then
                    bCreateNewPlatoon = true
                else
                    if iCyclesThatACUInArmyPool > 9 then
                        if GetGameTimeSeconds() > 30 then
                            if bDebugMessages == true then LOG(sFunctionRef..': ACU been in army pool for '..iCyclesThatACUInArmyPool..' cycles so giving it a platoon unless its reclaiming/repairing/upgrading/building/guarding') end
                            if oACU:IsUnitState('Building') == true or oACU:IsUnitState('Reclaiming') == true or oACU:IsUnitState('Repairing') == true or oACU:IsUnitState('Upgrading') == true or oACU:IsUnitState('Guarding') then bCreateNewPlatoon = false end
                            bCreateNewPlatoon = true --Dont want ACU staying in army pool if its still not been used
                        end
                    end
                end
            else
                if bDebugMessages == true then LOG(sFunctionRef..': ACU has no gun and is in platoon '..sPlatoonName) end
                --ACU is in a platoon but its not the army pool; disband if meet the conditions for gun upgrade and ACU not building
                bDisbandExistingPlatoon = true
                if oACU:IsUnitState('Building') == true or oACU:IsUnitState('Repairing') == true or oACU:IsUnitState('Upgrading') == true then bDisbandExistingPlatoon = false
                else
                    bDisbandExistingPlatoon = M27Conditions.WantToGetGunUpgrade(aiBrain)
                end
                if bDisbandExistingPlatoon == true then
                    --Check no nearby enemies first
                    bDisbandExistingPlatoon = false
                    if oACU.PlatoonHandle[M27PlatoonUtilities.refiEnemiesInRange] == nil or oACU.PlatoonHandle[M27PlatoonUtilities.refiEnemiesInRange] == 0 then
                        local tNearbyEnemyUnits = aiBrain:GetUnitsAroundPoint(categories.LAND * categories.DIRECTFIRE + categories.LAND*categories.INDIRECTFIRE, tACUPos, iSearchRangeForEnemyStructures, 'Enemy')
                        if M27Utilities.IsTableEmpty(tNearbyEnemyUnits) == true then
                            bDisbandExistingPlatoon = true
                        end
                    end
                end
            end
        end
        if bDisbandExistingPlatoon == true then
            if bDebugMessages == true then LOG(sFunctionRef..': ACU ready to get gun so disbanding') end
            oACU.PlatoonHandle:PlatoonDisband()
        elseif bCreateNewPlatoon == true then
            local oNewPlatoon = aiBrain:MakePlatoon('', '')
            aiBrain:AssignUnitsToPlatoon(oNewPlatoon, {oACU},'Support', 'None')
            oNewPlatoon:SetAIPlan('M27ACUMain')
            iCyclesThatACUInArmyPool = 0
            iCyclesThatACUHasNoPlatoon = 0
        end
    end

    --==============BUILD ORDER RELATED=============
    --Update the build condition flag for if ACU is near an unclaimed mex or has nearby reclaim, unless ACU is part of the main acu platoon ai (which already has this logic in it)
    local sACUPlan = DebugPrintACUPlatoon(aiBrain, true)
    local bPlatoonAlreadyChecks = false
    if sACUPlan == 'M27ACUMain' then
        if not(oACU.PlatoonHandle[M27PlatoonUtilities.refiCurrentAction] == M27PlatoonUtilities.refActionDisband) then bPlatoonAlreadyChecks = true end
    end
    if bPlatoonAlreadyChecks == false then
        --Check for nearby mexes:
        local sPathing = M27Utilities.GetUnitPathingType(oACU)
        --GetSegmentGroup(oUnit, sPathing, iSegmentX, iSegmentZ)
        local iACUSegmentX, iACUSegmentZ = M27MapInfo.GetSegmentFromPosition(tACUPos)
        local iSegmentGroup = M27MapInfo.GetSegmentGroup(oACU, sPathing, iACUSegmentX, iACUSegmentZ)
        local tNearbyUnits = {}
        M27MapInfo.RecordMexForPathingGroup(oACU) --Makes sure we can reference tMexByPathingAndGrouping
        local iCurDistToACU
        local iBuildingSizeRadius = 0.5
        local bNearbyUnclaimedMex = false
        if bDebugMessages == true then LOG(sFunctionRef..': sPathing='..sPathing..'; iSegmentGroup='..iSegmentGroup..'; No. of mexes in tMexByPathingAndGrouping='..table.getn(M27MapInfo.tMexByPathingAndGrouping[sPathing][iSegmentGroup])) end
        --tMexByPathingAndGrouping[a][b][c]: [a] = pathing type ('Land' etc.); [b] = Segment grouping; [c] = Mex position
        local tPossibleMexes = M27MapInfo.tMexByPathingAndGrouping[sPathing][iSegmentGroup]
        if M27Utilities.IsTableEmpty(tPossibleMexes) == false then
            for iMex, tMexPosition in M27MapInfo.tMexByPathingAndGrouping[sPathing][iSegmentGroup] do
                iCurDistToACU = M27Utilities.GetDistanceBetweenPositions(tMexPosition, tACUPos)
                --if bDebugMessages == true then LOG(sFunctionRef..': iMex='..iMex..'; iCurDistToACU='..iCurDistToACU..'; iDistanceToLookForMexes='..iDistanceToLookForMexes) end
                if iCurDistToACU <= iDistanceToLookForMexes then
                    --Check if any building on mex (won't bother with seeing if its an enemy building as AI should be attacking any such building anyway so not worth the effort to code in a 'hold fire and capture' type logic at this stage)
                    --if bDebugMessages == true then LOG(sFunctionRef..'; Mex is within distance to look for, checking if any nearby units') end
                    --IsMexUnclaimed(aiBrain, tMexPosition, bTreatEnemyMexAsUnclaimed)
                    bNearbyUnclaimedMex = M27Logic.IsMexUnclaimed(aiBrain, tMexPosition, false)
                    break
                end
            end
        end
        aiBrain[refbUnclaimedMexNearACU] = bNearbyUnclaimedMex

        --Check for nearby reclaim
        --GetNearestReclaim(tLocation, iSearchRadius, iMinReclaimValue)
        local oReclaim = M27MapInfo.GetNearestReclaim(tACUPos, iDistanceToLookForReclaim, iMinReclaimValue)
        if not(oReclaim == nil) then
            aiBrain[refbReclaimNearACU] = true
            aiBrain[refoReclaimNearACU] = oReclaim
        end
    else
        --Set flags to false as will need refreshing before know if there's still nearby mex/reclaim
        aiBrain[refbReclaimNearACU] = false
        aiBrain[refbUnclaimedMexNearACU] = false
    end

    --==========ACU Run away logic
    local iHealthPercentage = oACU:GetHealthPercent()
    if iHealthPercentage <= 0.3 then
        if bDebugMessages == true then LOG(sFunctionRef..': ACU low on health so forcing it to run to base') end
        local bNewPlatoon = true
        local oNewPlatoon
        local iPlayerStartNumber = aiBrain.M27StartPositionNumber
        --Is the ACU within 15 of our base? If so then no point overriding
        if M27Utilities.GetDistanceBetweenPositions(oACU:GetPosition(), M27MapInfo.PlayerStartPoints[iPlayerStartNumber]) > 15 then
            if oACU.PlatoonHandle and oACU.PlatoonHandle.GetPlan and oACU.PlatoonHandle:GetPlan() == 'M27ACUMain' then bNewPlatoon = false end
            if bNewPlatoon == true then
                oNewPlatoon = aiBrain:MakePlatoon('', '')
                aiBrain:AssignUnitsToPlatoon(oNewPlatoon, {oACU}, 'Support', 'None')
                oNewPlatoon:SetAIPlan('M27ACUMain')
                oNewPlatoon[M27PlatoonUtilities.reftMovementPath] = {}
                oNewPlatoon[M27PlatoonUtilities.reftMovementPath][1] = {}
            else oNewPlatoon = oACU.PlatoonHandle
            end
            if not(oNewPlatoon[M27PlatoonUtilities.reftMovementPath][1] == M27MapInfo.PlayerStartPoints[iPlayerStartNumber]) then
                oNewPlatoon[M27PlatoonUtilities.refiOverseerAction] = M27PlatoonUtilities.refActionReturnToBase
                if bDebugMessages == true then LOG(sFunctionRef..': Forcing action refresh') end
                M27PlatoonUtilities.ForceActionRefresh(oNewPlatoon, 5)
            end
        end
    end
end

function EngineerManager(aiBrain)
--Checks for idle engineers and disbands their platoon
    local bDebugMessages = false
    local sFunctionRef = 'EngineerManager'
    local iMaxSecondsToBeIdle = 2
    local tAllEngineers = aiBrain:GetListOfUnits(categories.CONSTRUCTION * categories.ENGINEER - categories.COMMAND, false, true)
    local refiEngineerIdleCount = 'M27EngineerIdleCount'
    local refbEngineerDisbandedBefore = 'M27EngineerDisbanded'
    if bDebugMessages == true then
        if M27Utilities.IsTableEmpty(tAllEngineers) == true then LOG(sFunctionRef..': tAllEngineers is empty')
        else LOG(sFunctionRef..': tAllEngineers size='..table.getn(tAllEngineers)) end
    end

    for iEngineer, oEngineer in tAllEngineers do
        if oEngineer[refiEngineerIdleCount] == nil then oEngineer[refiEngineerIdleCount] = 0 end
        if M27Logic.IsUnitIdle(oEngineer) == true then
            oEngineer[refiEngineerIdleCount] = oEngineer[refiEngineerIdleCount] + 1
            if bDebugMessages == true then LOG(sFunctionRef..': Engineer is idle, current count='..oEngineer[refiEngineerIdleCount]..'; considering whether to disband it') end
            if oEngineer[refiEngineerIdleCount] >= iMaxSecondsToBeIdle then
                local oEngiPlatoon = oEngineer.PlatoonHandle
                if oEngiPlatoon then
                    local sPlan = 'None'
                    if oEngiPlatoon.GetPlan then sPlan = oEngiPlatoon:GetPlan() end
                    if bDebugMessages == true then LOG(sFunctionRef..': Engineer plan before disbanding='..sPlan) end
                    oEngineer[refiEngineerIdleCount] = 0
                    local bSwitchToBackupAI = false
                    local bDisbandPlatoon = true
                    if sPlan == 'EngineerBuildAI' then bSwitchToBackupAI = true
                    else
                        if oEngineer.refbEngineerDisbandedBefore == nil then oEngineer.refbEngineerDisbandedBefore = false
                        elseif oEngineer.refbEngineerDisbandedBefore == true then bSwitchToBackupAI = true
                        end
                        local oArmyPoolPlatoon = aiBrain:GetPlatoonUniquelyNamed('ArmyPool')
                        if oEngiPlatoon == oArmyPoolPlatoon then
                            bDisbandPlatoon = false
                            bSwitchToBackupAI = true end
                    end
                    if bDisbandPlatoon == true then
                        if oEngiPlatoon.PlatoonDisband then
                            oEngiPlatoon:Stop()
                            oEngiPlatoon:PlatoonDisband()
                        end
                    end
                    if bSwitchToBackupAI == true then
                        --Bug where if e.g. ACU builds on a mex when engineer was going to, the engineer does nothing even after being disbanded and reassigned to the same platoon
                        local oNewPlatoon = aiBrain:MakePlatoon('', '')
                        aiBrain:AssignUnitsToPlatoon(oNewPlatoon, {oEngineer}, 'Support', 'None')
                        oNewPlatoon:SetAIPlan('M27ReclaimAI')
                        oEngineer.refbEngineerDisbandedBefore = true
                    end
                end
            end
        else oEngineer[refiEngineerIdleCount] = 0 end
    end
end

function PlatoonNameUpdater(aiBrain, bUpdateCustomPlatoons)
    --Every second cycles through every platoon and updates its name to reflect its plan and platoon count
    local bDebugMessages = false
    local sFunctionRef = 'PlatoonNameUpdater'
    if bDebugMessages == true then LOG(sFunctionRef..': checking if want to update platoon names') end
    if ScenarioInfo.Options.AIPLatoonNameDebug == 'all' then
        if bUpdateCustomPlatoons == nil then bUpdateCustomPlatoons = true end
        local sPlatoonName, iPlatoonCount
        local oArmyPoolPlatoon = aiBrain:GetPlatoonUniquelyNamed('ArmyPool')
        local bPlatoonUsesM27Platoon = true
        local refsPrevPlatoonName = 'M27PrevPlatoonName'
        if M27Utilities.IsTableEmpty(aiBrain[M27PlatoonUtilities.refiLifetimePlatoonCount]) == true then aiBrain[M27PlatoonUtilities.refiLifetimePlatoonCount] = {} end
        if bDebugMessages == true then LOG(sFunctionRef..': About to cycle through each platoon') end
        for iPlatoon, oPlatoon in aiBrain:GetPlatoonsList() do
            if oPlatoon == oArmyPoolPlatoon then
                sPlatoonName = 'ArmyPool'
                bPlatoonUsesM27Platoon = false
            else
                if oPlatoon.GetPlan then
                    sPlatoonName = oPlatoon:GetPlan()
                    if oPlatoon[M27PlatoonUtilities.refiPlatoonCount] == nil then bPlatoonUsesM27Platoon = false end
                else sPlatoonName = 'None'
                    bPlatoonUsesM27Platoon = false
                end
            end
            if sPlatoonName == nil then sPlatoonName = 'None' end
            if aiBrain[M27PlatoonUtilities.refiLifetimePlatoonCount][sPlatoonName] == nil then aiBrain[M27PlatoonUtilities.refiLifetimePlatoonCount][sPlatoonName] = 0 end
            if bDebugMessages == true then LOG(sFunctionRef..': sPlatoonName='..sPlatoonName..'; bPlatoonUsesM27Platoon='..tostring(bPlatoonUsesM27Platoon)) end
            if bPlatoonUsesM27Platoon == false then
                if bDebugMessages == true then LOG(sFunctionRef..': sPlatoonName='..sPlatoonName..'; Platoon doesnt use M27Platoon, checking if have updated name before') end
                --Have we already updated this platoon before?
                local bHaveUpdatedBefore = false
                if oPlatoon[refsPrevPlatoonName] == nil then
                    oPlatoon[refsPrevPlatoonName] = sPlatoonName
                else
                    if oPlatoon[refsPrevPlatoonName] == sPlatoonName then bHaveUpdatedBefore = true end
                end
                if bHaveUpdatedBefore == false then
                    aiBrain[M27PlatoonUtilities.refiLifetimePlatoonCount][sPlatoonName] = aiBrain[M27PlatoonUtilities.refiLifetimePlatoonCount][sPlatoonName] + 1
                    oPlatoon[M27PlatoonUtilities.refiPlatoonCount] = aiBrain[M27PlatoonUtilities.refiLifetimePlatoonCount][sPlatoonName]
                    M27PlatoonUtilities.UpdatePlatoonName(oPlatoon, sPlatoonName..oPlatoon[M27PlatoonUtilities.refiPlatoonCount])
                end
            else
                if bUpdateCustomPlatoons == true then
                    local iPlatoonCount = oPlatoon[M27PlatoonUtilities.refiPlatoonCount]
                    if iPlatoonCount == nil then iPlatoonCount = 0 end
                    local iPlatoonAction = oPlatoon[M27PlatoonUtilities.refiCurrentAction]
                    if iPlatoonAction == nil then iPlatoonAction = 0
                    M27PlatoonUtilities.UpdatePlatoonName(oPlatoon, sPlatoonName..iPlatoonCount..':Action='..iPlatoonAction) end
                end
            end
        end
    end
end

function WaitTicksSpecial(aiBrain, iTicksToWait)
    --calls the GetACU function since that will check if ACU is alive, and if not will delay to avoid a crash
    local oACU = M27Utilities.GetACU(aiBrain)
    WaitTicks(iTicksToWait)
    oACU = M27Utilities.GetACU(aiBrain)
end

function AirThreatChecker(aiBrain)
    --Get enemy total air threat level
    local bDebugMessages = false
    local sFunctionRef = 'AirThreatChecker'
    if bDebugMessages == true then LOG(sFunctionRef..': Start of cycle') end
    local tEnemyAirUnits = aiBrain:GetUnitsAroundPoint(categories.AIR, M27MapInfo.PlayerStartPoints[aiBrain.M27StartPositionNumber], 1000, 'Enemy')
    --GetAirThreatLevel(aiBrain, tUnits, bMustBeVisibleToIntelOrSight, bIncludeAirToAir, bIncludeGroundToAir, bIncludeAirToGround, bIncludeNonCombatAir, iAirBlipThreatOverride, iMobileLandBlipThreatOverride, iNavyBlipThreatOverride, iStructureBlipThreatOverride)
    local iAllAirThreat = M27Logic.GetAirThreatLevel(aiBrain, tEnemyAirUnits, true, true, false, true, true)
    if aiBrain[refiHighestEnemyAirThreat] == nil then aiBrain[refiHighestEnemyAirThreat] = 0 end
    if iAllAirThreat > aiBrain[refiHighestEnemyAirThreat] then aiBrain[refiHighestEnemyAirThreat] = iAllAirThreat end
    local tMAAUnits = aiBrain:GetListOfUnits(categories.MOBILE * categories.LAND * categories.ANTIAIR, false, true)
    if M27Utilities.IsTableEmpty(tMAAUnits) == true then aiBrain[refiOurMAAUnitCount] = 0
        else aiBrain[refiOurMAAUnitCount] = table.getn(tMAAUnits) end
    aiBrain[refiOurMassInMAA] = M27Logic.GetAirThreatLevel(aiBrain, tMAAUnits, false, false, true, false, false)
    if bDebugMessages == true then LOG(sFunctionRef..': Finished cycle, iAllAirThreat='..iAllAirThreat..'; OurMassInMAA='..aiBrain[refiOurMassInMAA]) end
end

function EnemyThreatRangeUpdater(aiBrain)
    --Updates range to look for enemies based on if any T2 PD detected
    local bDebugMessages = false
    local sFunctionRef = 'EnemyThreatRangeUpdater'
    if bEnemyHasTech2PD == false then
        local tEnemyTech2 = aiBrain:GetUnitsAroundPoint(categories.STRUCTURE * categories.DIRECTFIRE * categories.TECH2, M27Utilities.GetACU(aiBrain):GetPosition(), 1000, 'Enemy')
        if M27Utilities.IsTableEmpty(tEnemyTech2) == false then
            bEnemyHasTech2PD = true
            iSearchRangeForEnemyStructures = 65 --Tech 2 is 60, so want to factor it into decisions on whether to attack if are near it
            if bDebugMessages == true then LOG(sFunctionRef..': Enemy T2 PD detected - increasing range to look for nearby enemies on platoons') end
        end
    end
end

function InitiateLandFactoryConstructionManager(aiBrain)
    --Creates monitor for what land factories should build
    ForkThread(M27LandFactory.LandFactoryOverseer, aiBrain)
end


function OverseerManager(aiBrain)
    local bDebugMessages = false
    local sFunctionRef = 'OverseerManager'


    --INITIAL SETUP
    aiBrain[refbNeedScoutsBuilt] = false
    aiBrain[refbNeedScoutPlatoons] = false
    aiBrain[refbNeedDefenders] = false
    for _, oACU in aiBrain:GetListOfUnits(categories.COMMAND, false, true) do
        aiBrain[refoStartingACU] = oACU
        M27Utilities.GetACU(aiBrain)[refbACUHelpWanted] = false
        break
    end
    --InitiateLandFactoryConstructionManager(aiBrain)

    WaitTicksSpecial(aiBrain, 1)
    local iSlowerCycleThreshold = 4
    local iSlowerCycleCount = 0

    while(not(aiBrain:IsDefeated())) do
        if bDebugMessages == true then LOG(sFunctionRef..': Start of cycle') end
        if bIntelPathsGenerated == false then RecordIntelPaths(aiBrain) end --will only run once have first scout
        if bIntelPathsGenerated == true then
            AssignScoutsToPreferredPlatoons(aiBrain)
        end
        AssignMAAToPreferredPlatoons(aiBrain) --No point running logic for MAA helpers if havent created any scouts
        if bDebugMessages == true then
            LOG(sFunctionRef..': aiBrain UnitState='..M27Logic.GetUnitState(M27Utilities.GetACU(aiBrain)))
        end

        if bDebugMessages == true then
            LOG(sFunctionRef..': pre threat assessment ACU platoon=')
            DebugPrintACUPlatoon(aiBrain)
        end

        ThreatAssessAndRespond(aiBrain)
        AirThreatChecker(aiBrain)
        if bDebugMessages == true then LOG(sFunctionRef..': post threat assessment pre ACU manager') end
        ACUManager(aiBrain)
        if bDebugMessages == true then
            LOG(sFunctionRef..': post ACU manager, pre wait 10 ticks')
            DebugPrintACUPlatoon(aiBrain)
        end
        EngineerManager(aiBrain)

        WaitTicksSpecial(aiBrain, 1)
        M27Utilities.GetACU(aiBrain)
        if bDebugMessages == true then LOG(sFunctionRef..': Waited 1 tick; platoon name is:') DebugPrintACUPlatoon(aiBrain) end
        PlatoonNameUpdater(aiBrain)

        iSlowerCycleCount = iSlowerCycleCount - 1
        if iSlowerCycleCount <= 0 then
            iSlowerCycleCount = iSlowerCycleThreshold
            EnemyThreatRangeUpdater(aiBrain)
        end

        WaitTicksSpecial(aiBrain, 9)

        if bDebugMessages == true then
            if M27Utilities.GetACU(aiBrain).GetNavigator then if M27Utilities.GetACU(aiBrain):GetNavigator().GetCurrentTargetPos then LOG(sFunctionRef..': ACU current navigator target pos='..repr(M27Utilities.GetACU(aiBrain):GetNavigator():GetCurrentTargetPos())) end end
        end

        if bDebugMessages == true then
            LOG(sFunctionRef..': End of overseer cycle code (about to start new cycle) ACU platoon=')
            DebugPrintACUPlatoon(aiBrain)
        end

    end
end