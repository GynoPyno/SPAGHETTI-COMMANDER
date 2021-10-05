local GetPlatoonUnits = moho.platoon_methods.GetPlatoonUnits
local AIAttackUtils = import('/lua/AI/aiattackutilities.lua')
local M27Utilities = import('/mods/M27AI/lua/M27Utilities.lua')
local M27MapInfo = import('/mods/M27AI/lua/AI/M27MapInfo.lua')
local M27Logic = import('/mods/M27AI/lua/AI/M27GeneralLogic.lua')
local M27Overseer = import('/mods/M27AI/lua/AI/M27Overseer.lua')
local AIBuildStructures = import('/lua/AI/aibuildstructures.lua')
local M27Conditions = import('/mods/M27AI/lua/AI/M27CustomConditions.lua')

--    Platoon variables and constants:
--1) Action related
refiCurrentAction = 'M27CurrentAction'
reftPrevAction = 'M27PrevAction'
refbHavePreviouslyRun = 'M27HavePreviouslyRun'
refbForceActionRefresh = 'M27ForceActionRefresh' --E.g. used by overseer the first time a platoon is given a command
refiGameTimeOfLastRefresh = 'M27ForceActionRefresh' --so other code can reference to avoid forcing a refresh too often
refActionAttack = 1
refActionRun = 2
refActionContinueMovementPath = 3
refActionReissueMovementPath = 4 --as per refActionContinueMovementPath but ignores the 'dont refresh continue movementpath' check, and forces re-issuing of movement path even if prev action was a new movement path
refActionNewMovementPath = 5
refActionUseAttackAI = 6
refActionDisband = 7
refActionMoveDFToNearestEnemy = 8 --Direct fire units in the platoon move to the nearest enemy (doesnt affect scouts, T1 arti, and MAA)
refActionReturnToBase = 9
refActionReclaimNearby = 10
refActionBuildMex = 11
refActionAssistConstruction = 12
refActionMoveJustWithinRangeOfNearestPD = 13
refActionMoveToTemporaryLocation = 14

--Extra actions (i.e. performed in addition to main action)
refiExtraAction = 'M27ExtraActionRef'
refExtraActionOvercharge = 1
refExtraActionTargetUnit = 'M27ExtraActionTargetUnit'

local refiRefreshActionCount = 'M27RefreshActionCount' --used to track no. of times action has been skipped
refbOverseerAction = 'M27OverseerActionOverrideFlag'
refiOverseerAction = 'M27OverseerActionOverrideAction'
refbConsiderReclaim = 'M27ConsiderNearbyReclaim'
refbConsiderMexes = 'M27ConsiderNearbyMexes'
refbNeedToHeal = 'M27NeedToHeal'

--2) Pathing related
--refiLastPathTarget = 'M27LastPathTarget' --Replaced with table.getn due to too high a risk of error if this wasnt updated
refiCurrentPathTarget = 'M27CurrentPathTarget'
reftMovementPath = 'M27MovementPath'
refiCyclesForLastStuckAction = 'M27CyclesForLastStuckAction'
reftTemporaryMoveTarget = 'M27TemporaryMoveTarget'
reftMergeLocation = 'M27MergeLocation' --Temporarily stores the location for merged platoons to head to

--3) Unit related
reftCurrentUnits = 'M27CurrentUnitsTable'
refiCurrentUnits = 'M27CurrentUnitsCount'
refiPrevCurrentUnits = 'M27PrevUnitsCount'
reftDFUnits = 'M27DFUnitsTable'
reftIndirectUnits = 'M27IndirectUnitsTable'
reftScoutUnits = 'M27ScoutUnitsTable'
reftBuilders = 'M27BuilderUnitsTable'
reftReclaimers = 'M27ReclaimerUnitsTable'
refiDFUnits = 'M27DFUnitsCount'
refiIndirectUnits = 'M27IndirectUnitsCount'
refiScoutUnits = 'M27ScoutUnitsCount'
refiBuilders = 'M27BuilderUnitsCount'
refiReclaimers = 'M27ReclaimerUnitsCount'
refbACUInPlatoon = 'M27ACUInPlatoon'
refbPlatoonHasUnderwaterLand = 'M27PlatoonHasUnderwaterLand'
refbPlatoonHasOverwaterLand = 'M27PlatoonHasOverwaterLand'

reftFriendlyNearbyUnits = 'M27FriendlyUnitsTable'
refiOverrideDistanceToReachDestination = 'M27OverrideDistanceToReachDestination'

refiEnemySearchRadius = 'M27EnemySearchRadius' --distance that have looked for nearby enemies when getting nearby enemy data
refiEnemiesInRange = 'M27EnemiesInRangeCount'
reftEnemiesInRange = 'M27EnemiesInRangeTable'
refiEnemyStructuresInRange = 'M27EnemiesInRangeStructureCount'
reftEnemyStructuresInRange = 'M27EnemiesInRangeStructureTable'
reftVisibleEnemyIndirect = 'M27EnemyIndirectInRangeTable'
refiVisibleEnemyIndirect = 'M27EnemyIndirectInRangeCount'

--4) Misc
refiLifetimePlatoonCount = 'M27LifetimePlatoonCount'
refiPlatoonCount = 0 --Count of how many times a particular platoonAI has been initiated
reftNearbyMexToBuildOn = 'M27NearbyMexBuildTarget'
refoNearbyReclaimTarget = 'M27NearbyReclaimTarget'
refoConstructionToAssist = 'M27NearbyConstructionTarget'
refbHasBeenGivenExpansionOrder = 'M27HasBeenGivenExpansionOrder' --used for ACU platoon so can add extra checks if its not the first time its expanding
refoSupportHelperUnitTarget = 'M27ScoutHelperUnitTarget'
refoSupportHelperPlatoonTarget = 'M27ScoutHelperPlatoonTarget'
refiSupportHelperFollowDistance = 'M27ScoutHelperFollowDistance'
refbKiteEnemies = 'M27KiteEnemies' --True/false; set to true if want combat units to try and kite the enemy
refbKitingLogicActive = 'M27CurrentlyKiting'
refiPrevNearestEnemyDistance = 'M27PrevNearestEnemyDistance'


function UpdatePlatoonName(oPlatoon, sNewName)
    for iUnit, oUnit in GetPlatoonUnits(oPlatoon) do
        if not oUnit.Dead then
            oUnit:SetCustomName(sNewName)
        end
    end
end

function MoveAlongPath(oPlatoon, tMovementPath, bAttackMove, iPathStartPoint, bDontClearActions)
    --iPathStartPoint - defaults to 1 (first entry in tMovementPath); otherwise will ignore earlier entries in tMovementPath
    if iPathStartPoint == nil then iPathStartPoint = 1 end
    if bAttackMove == nil then bAttackMove = false end
    local bDebugMessages = false
    --if oPlatoon:GetPlan() == 'M27ACUMain' then bDebugMessages = true end
    --if oPlatoon:GetPlan() == 'M27MAAAssister' then bDebugMessages = true end
    local sFunctionRef = 'MoveAlongPath'
    local tCurrentUnits = {}
    tCurrentUnits = oPlatoon[reftCurrentUnits]
    local tLocation = {}
    if bDebugMessages == true then LOG(sFunctionRef..': Start of function; iPathStartPoint='..iPathStartPoint..'; tMovementPath size='..table.getn(tMovementPath)..'; currentunits='..table.getn(oPlatoon[reftCurrentUnits])) end
    for iCurPath = iPathStartPoint, table.getn(tMovementPath) do
    --for iLoc, tLocation in tMovementPath do
        tLocation = tMovementPath[iCurPath]
        if iCurPath == iPathStartPoint then
            if bDebugMessages == true then LOG(sFunctionRef..': Clearing existing actions') end
            --tCurrentUnits = GetPlatoonUnits(oPlatoon)
            if bDontClearActions == false then IssueClearCommands(tCurrentUnits) end
        end
        if bDebugMessages == true then LOG(sFunctionRef..': Moving to tLocationXZ='..tLocation[1]..'-'..tLocation[3]) end
        if bAttackMove == true then
            IssueAggressiveMove(tCurrentUnits, tLocation)
            --oPlatoon:AggressiveMoveToLocation(tLocation)
        else
            IssueMove(tCurrentUnits, tLocation)
            --oPlatoon:MoveToLocation(tLocation, false)
        end
    end
    --oPlatoon[refiLastPathTarget] = table.getn(tMovementPath)
    if iPathStartPoint > table.getn(oPlatoon[reftMovementPath]) then iPathStartPoint = table.getn(oPlatoon[reftMovementPath]) end --redundancy just in case
    oPlatoon[refiCurrentPathTarget] = iPathStartPoint
    --[[if bDebugMessages == true then
        LOG(sFunctionRef..'TEMP ERROR - Platoon not moving - delaying code 5s')
        WaitSeconds(5)
    end]]--
end

function GetPlatoonPositionDeviation(oPlatoon)
    --Returns the standard deviation in positions of oPlatoon; will target a centre point whose size increases based on the platoon size
    --very approximate guide: <3 is close, >10 spread out, >30 very spread out, >100 likely on different parts of the map altogether
    local bDebugMessages = false
    local tPositions = {}
    local iCount = 0
    if oPlatoon[refiCurrentUnits] > 0 then
        for iCurUnit=1, oPlatoon[refiCurrentUnits] do
            tPositions[iCurUnit] = oPlatoon[reftCurrentUnits][iCurUnit]:GetPosition()
        end
        local iCentreSize = math.sqrt(oPlatoon[refiCurrentUnits])*3
        if bDebugMessages == true then LOG(oPlatoon:GetPlan()..oPlatoon[refiPlatoonCount]..': GetPlatoonPositionDeviation: CentreSize='..iCentreSize..'; UnitCount='..oPlatoon[refiCurrentUnits]) end
        if bDebugMessages == true then LOG(oPlatoon:GetPlan()..oPlatoon[refiPlatoonCount]..': Deviation='..M27Utilities.CalculateDistanceDeviationOfPositions(tPositions, iCentreSize)) end

        return M27Utilities.CalculateDistanceDeviationOfPositions(tPositions, iCentreSize)
    else return 0
    end
end


function GetPathingUnit(oPlatoon, oExistingPathingUnit)
    --if oExistingPathingUnit is specified, then returns this if it's still alive
    --otherwise, returns the most restrictive pathing unit in the platoon
    --returns nil if no valid units
    local bDebugMessages = false
    local bGetNewUnit = false
    local oNewPathingUnit
    if oExistingPathingUnit == nil then bGetNewUnit = true
    elseif oExistingPathingUnit.Dead then bGetNewUnit = true end

    if bGetNewUnit == true then
        if bDebugMessages == true then LOG('GetPathingUnit: Get unit with worst pathing in platoon') end
        oNewPathingUnit = AIAttackUtils.GetMostRestrictiveLayer(oPlatoon)
        if oNewPathingUnit == false then
            if bDebugMessages == true then LOG('GetPathingUnit: aiAttackUtils returned false') end
            return nil
        elseif oNewPathingUnit == nil then
            if bDebugMessages == true then LOG('GetPathingUnit: aiAttackUtils returned nil') end
            return nil
        elseif oNewPathingUnit.Dead then
            if bDebugMessages == true then LOG('GetPathingUnit: aiAttackUtils returned dead unit') end
            return nil
        end
    else oNewPathingUnit = oExistingPathingUnit
    end
    if oNewPathingUnit.Dead then return nil
    else return oNewPathingUnit
    end
end

function RemoveUnitsFromPlatoon(oPlatoon, tUnits, bReturnToBase, oPlatoonToAddTo)
    --if bReturnToBase is true then units will be told to move to aiBrain's base
    --if tUnits isnt in oPlatoon then does nothing
    local bDebugMessages = false
    local sFunctionRef = 'RemoveUnitsFromPlatoon'
    local aiBrain = oPlatoon:GetBrain()
    --if tUnits[1] == M27Utilities.GetACU(aiBrain) then bDebugMessages = true LOG(sFunctionRef..': ACU is about to be removed from its current platoon='..M27Overseer.DebugPrintACUPlatoon(aiBrain, true)) end
    if not(oPlatoonToAddTo == oPlatoon) then
        local oArmyPool = aiBrain:GetPlatoonUniquelyNamed('ArmyPool')
        --if not(oPlatoon==oArmyPool) then if oPlatoon:GetPlan() == 'M27ACUMain' then bDebugMessages = true end end
        local sName
        if oPlatoonToAddTo == nil then
            oPlatoonToAddTo = oArmyPool
            sName = 'ArmyPool'
        else
            if oPlatoonToAddTo == oArmyPool then sName = 'ArmyPool'
            else
                if oPlatoonToAddTo.GetPlan then
                    sName = oPlatoonToAddTo:GetPlan()
                end
                if sName == nil then sName = 'nil' end
                if oPlatoonToAddTo[refiPlatoonCount] == nil then sName = sName..0
                else sName = sName..oPlatoonToAddTo[refiPlatoonCount]
                end
                oPlatoonToAddTo[refbForceActionRefresh] = true
                if bDebugMessages == true then LOG(sFunctionRef..': Adding unit to '..sName..'; oPlatoonToAddTo[refbForceActionRefresh] = '..tostring(oPlatoonToAddTo[refbForceActionRefresh])) end
            end
        end
        if oPlatoonToAddTo == nil then
            LOG(sFunctionRef..': WARNING: oPlatoonToAddTo is nil')
        else
            local sCurPlatoonName
            if oPlatoon == oArmyPool then sCurPlatoonName = 'ArmyPool'
            else
                sCurPlatoonName = oPlatoon:GetPlan()
                if sCurPlatoonName == nil then sCurPlatoonName = 'None' end
                if oPlatoon[refiPlatoonCount] == nil then sCurPlatoonName = sCurPlatoonName..0
                else sCurPlatoonName = sCurPlatoonName..oPlatoon[refiPlatoonCount] end
                if bDebugMessages == true then LOG(sFunctionRef..': sCurPlatoonName='..sCurPlatoonName) end
            end
            if not(sCurPlatoonName == sName) then
                if bDebugMessages == true then
                    if oPlatoon == oArmyPool then LOG(sFunctionRef..': About to remove units from ArmyPool platoon and add to platoon '..sName)
                    else
                        LOG(sFunctionRef..': About to remove units from platoon '..oPlatoon:GetPlan())
                                if oPlatoon[refiPlatoonCount] == nil then LOG('which has nil count') else LOG('which has count='..oPlatoon[refiPlatoonCount]) end
                    end
                end
                IssueClearCommands(tUnits)
                aiBrain:AssignUnitsToPlatoon(oPlatoonToAddTo, tUnits, 'Unassigned', 'None')
                if bReturnToBase == true then
                    if bDebugMessages == true then LOG(sFunctionRef..': Issuing move command to tUnits') end
                    IssueMove(tUnits, M27MapInfo.PlayerStartPoints[aiBrain.M27StartPositionNumber]) end
                if ScenarioInfo.Options.AIPLatoonNameDebug == 'all' then UpdatePlatoonName(oPlatoonToAddTo, sName) end
            end
        end
    end
    if bDebugMessages == true then if tUnits[1] == M27Utilities.GetACU(aiBrain) then LOG(sFunctionRef..': end of function; ACU current platoon='..M27Overseer.DebugPrintACUPlatoon(aiBrain, true)) end end
end


function GetCyclesSinceLastMoved(oUnit, bIsPlatoonNotUnit, iTriggerDistance)
    --returns the number of times this function has been called where oUnit hasnt moved by more than x spaces
    if bIsPlatoonNotUnit == nil then bIsPlatoonNotUnit = false end

    local iDistTreatedAsStuck = iTriggerDistance
    if iDistTreatedAsStuck == nil then
        if bIsPlatoonNotUnit == true and oUnit.GetPlatoonUnits then
            iDistTreatedAsStuck = 4 + math.floor(oUnit[refiCurrentUnits] / 4)
            if iDistTreatedAsStuck > 15 then iDistTreatedAsStuck = 15 end
        else iDistTreatedAsStuck = 5 end
    end
    local sLastX = 'M27LastX'
    local sLastZ = 'M27LastZ'
    local sCyclesSinceMoved = 'M27CyclesSinceMoved'
    local iLastX = oUnit[sLastX]
    local iLastZ = oUnit[sLastZ]
    local tCurPos = {}
    if oUnit == nil then return 0
    elseif oUnit.Dead then return 0
    else
        if bIsPlatoonNotUnit then tCurPos = oUnit:GetPlatoonPosition()
        else tCurPos = oUnit:GetPosition() end
        local iCyclesSinceMoved
        if iLastX == nil or iLastZ == nil then iCyclesSinceMoved = 0
        else
            if M27Utilities.GetDistanceBetweenPositions(tCurPos, { iLastX, 0, iLastZ }) <= iDistTreatedAsStuck then
                iCyclesSinceMoved = oUnit[sCyclesSinceMoved]
                if iCyclesSinceMoved == nil then iCyclesSinceMoved = 0 end
                iCyclesSinceMoved = iCyclesSinceMoved + 1
            else
                iCyclesSinceMoved = 0
            end
        end
        if iCyclesSinceMoved == 0 then
            oUnit[sLastX] = tCurPos[1]
            oUnit[sLastZ]= tCurPos[3]
        end
        oUnit[sCyclesSinceMoved] = iCyclesSinceMoved
        return iCyclesSinceMoved
    end
end

function IsDestinationAwayFromNearbyEnemies(aiBrain, tCurPos, tCurDestination, iEnemySearchRadius, bAlsoRunFromEnemyStartLocation)
    --Used for running away from enemies (if they have a threat rating)
    local bDebugMessages = false
    local sFunctionRef = 'IsDestinationAwayFromNearbyEnemies'
    local bIsAwayFromNearbyEnemies = false
    local bStoppedLoop = false
    local tNearbyEnemies = aiBrain:GetUnitsAroundPoint(categories.ALLUNITS, tCurPos, iEnemySearchRadius, 'Enemy')
    local iClosestEnemyDist = 100000
    local iEnemyDistFromTarget
    if tNearbyEnemies == nil then bIsAwayFromNearbyEnemies = true
    else
        if table.getn(tNearbyEnemies) == 0 then bIsAwayFromNearbyEnemies = true
        else
            --Filter to just show units with a threat rating:
            local tEnemiesWithThreat = {}
            for iCurUnit, oCurUnit in tNearbyEnemies do
                if M27Logic.GetCombatThreatRating(aiBrain, { oCurUnit}, true) > 0 then
                    table.insert(tEnemiesWithThreat, oCurUnit)
                end
            end
            if table.getn(tEnemiesWithThreat) == 0 then bIsAwayFromNearbyEnemies = true
            else
                local tRunAwayComparisonPos = {}
                local iComparisonDistance = 5
                if M27Utilities.GetDistanceBetweenPositions(tCurPos, tCurDestination) <= iComparisonDistance then tRunAwayComparisonPos = tCurDestination
                    --MoveTowardsTarget(tStartPos, tTargetPos, iDistanceToTravel, iAngle)
                else tRunAwayComparisonPos =  M27Utilities.MoveTowardsTarget(tCurPos, tCurDestination, iComparisonDistance, 0) end


                local iDistFromComparison, iDistFromStart
                local tUnitCurPos
                for iCurUnit, oCurUnit in tEnemiesWithThreat do
                    tUnitCurPos = oCurUnit:GetPosition()
                    iDistFromStart = M27Utilities.GetDistanceBetweenPositions(tCurPos, tUnitCurPos)
                    iDistFromComparison = M27Utilities.GetDistanceBetweenPositions(tRunAwayComparisonPos, tUnitCurPos)
                    iEnemyDistFromTarget = M27Utilities.GetDistanceBetweenPositions(tUnitCurPos, tCurDestination)
                    if iDistFromComparison < iDistFromStart then
                        bIsAwayFromNearbyEnemies = false
                        bStoppedLoop = true
                        break
                    elseif iEnemyDistFromTarget < iClosestEnemyDist then
                        iClosestEnemyDist = iEnemyDistFromTarget
                        if iClosestEnemyDist <= iEnemySearchRadius then bIsAwayFromNearbyEnemies = false
                            bStoppedLoop = true
                            break
                        end
                    end
                end
                if bStoppedLoop == false then bIsAwayFromNearbyEnemies = true end
            end
        end
    end
    if bIsAwayFromNearbyEnemies == true then
        --Do we also want to be away from the start?
        if bAlsoRunFromEnemyStartLocation == nil or bAlsoRunFromEnemyStartLocation == false then return true
        else
            if bDebugMessages == true then LOG('IsDestinationAwayFromEnemy: Is away from nearest enemy, checking if away from enemy start pos') end
            local bEnemyStartXLessThanTarget = false
            local bEnemyStartZLessThanTarget = false
            local bEnemyStartXLessThanOurs = false
            local bEnemyStartZLessThanOurs = false
            local iEnemyStartNumber = M27Logic.GetNearestEnemyStartNumber(aiBrain)
            if iEnemyStartNumber == nil then
                M27Utilities.ErrorHandler('iEnemyStartNumber=nil')
            else
                local tEnemyStart = M27MapInfo.PlayerStartPoints[M27Logic.GetNearestEnemyStartNumber(aiBrain)]
                if tEnemyStart[1] < tCurDestination[1] then bEnemyStartXLessThanTarget = true end
                if tEnemyStart[3] < tCurDestination[3] then bEnemyStartZLessThanTarget = true end
                if tEnemyStart[1] < tCurPos[1] then bEnemyStartXLessThanOurs = true end
                if tEnemyStart[3] < tCurPos[3] then bEnemyStartZLessThanOurs = true end
                if bEnemyStartXLessThanOurs == bEnemyStartXLessThanTarget and bEnemyStartZLessThanOurs == bEnemyStartZLessThanTarget then
                    if bDebugMessages == true then LOG('IsDestinationAwayFromEnemy: Is away from enemy start as well') end
                    bIsAwayFromNearbyEnemies = true
                else
                    if bDebugMessages == true then LOG('IsDestinationAwayFromEnemy: Isnt away from enemystart; tCurPos[1][3]='..tCurPos[1]..'-'..tCurPos[3]..'tCurDestination='..tCurDestination[1]..'-'..tCurDestination[3]..'; tEnemyStart='..tEnemyStart[1]..'-'..tEnemyStart[3]) end
                    bIsAwayFromNearbyEnemies = false end
            end
        end
    else
        bIsAwayFromNearbyEnemies = false
    end
    return bIsAwayFromNearbyEnemies
end


function IsDestinationAwayFromNearbyEnemy(tCurPos, tCurDestination, oNearestEnemy, bAlsoRunFromEnemyStartLocation)
    --Quicker but more limited version of 'NearbyEnemies' - will only consider the nearest enemy
    local bDebugMessages = false
    local sFunctionRef = 'IsDestinationAwayFromNearbyEnemy'
    local tNearestEnemy = oNearestEnemy:GetPosition()
    --Does the current target move us away from the enemy in both directions? If so then dont change it
    local bXLessThanOurs = false
    local bZLessThanOurs = false
    local bTargetXLessThanOurs = false
    local bTargetZLessThanOurs = false


    if tCurPos[1] > tNearestEnemy[1] then bXLessThanOurs = true end
    if tCurPos[3] > tNearestEnemy[3] then bZLessThanOurs = true end
    if tCurPos[1] > tCurDestination[1] then bTargetXLessThanOurs = true end
    if tCurPos[3] > tCurDestination[3] then bTargetZLessThanOurs = true end
    if bDebugMessages == true then LOG(sFunctionRef..': Choosing location to run away to; tCurPos='..tCurPos[1]..'-'..tCurPos[3]) end
    if bDebugMessages == true then LOG('tNearestEnemy='..tNearestEnemy[1]..'-'..tNearestEnemy[3]) end
    if bDebugMessages == true then LOG('bTargetXLessThanOurs='..tostring(bTargetXLessThanOurs)..'; bTargetZLessThanOurs='..tostring(bTargetXLessThanOurs)) end
    if bTargetXLessThanOurs == bXLessThanOurs or bTargetZLessThanOurs == bZLessThanOurs then
        if bDebugMessages == true then LOG(sFunctionRef..': Isnt away from oNearestEnemy; tCurPos[1][3]='..tCurPos[1]..'-'..tCurPos[3]..'tNearestEnemy='..tNearestEnemy[1]..'-'..tNearestEnemy[3]..'; tCurDestination='..tCurDestination[1]..'-'..tCurDestination[3]) end
        return false
    else
        if bAlsoRunFromEnemyStartLocation == nil or bAlsoRunFromEnemyStartLocation == false then return true
        else
            if bDebugMessages == true then LOG(sFunctionRef..': Is away from nearest enemy, checking if away from enemy start pos') end
            local bEnemyStartXLessThanTarget = false
            local bEnemyStartZLessThanTarget = false
            local bEnemyStartXLessThanOurs = false
            local bEnemyStartZLessThanOurs = false
            local tEnemyStart = M27MapInfo.PlayerStartPoints[oNearestEnemy:GetAIBrain().M27StartPositionNumber]
            if tEnemyStart[1] < tCurDestination[1] then bEnemyStartXLessThanTarget = true end
            if tEnemyStart[3] < tCurDestination[3] then bEnemyStartZLessThanTarget = true end
            if tEnemyStart[1] < tCurPos[1] then bEnemyStartXLessThanOurs = true end
            if tEnemyStart[3] < tCurPos[3] then bEnemyStartZLessThanOurs = true end
            if bEnemyStartXLessThanOurs == bEnemyStartXLessThanTarget and bEnemyStartZLessThanOurs == bEnemyStartZLessThanTarget then
                if bDebugMessages == true then LOG(sFunctionRef..': Is away from enemy start as well') end
                return true
            else
                if bDebugMessages == true then LOG(sFunctionRef..': Isnt awway from enemystart; tCurPos[1][3]='..tCurPos[1]..'-'..tCurPos[3]..'tCurDestination='..tCurDestination[1]..'-'..tCurDestination[3]..'; tEnemyStart='..tEnemyStart[1]..'-'..tEnemyStart[3]) end
                return false end
        end
    end
end

function MergePlatoons(oPlatoonToMergeInto, oPlatoonToBeMerged)
    --Adds all units from oPlatoonToBeMerged into oPlatoonToMergeInto unless they're dead or attached
    local bDebugMessages = false
    local sFunctionRef = 'MergePlatoons'
    local tMergingUnits = oPlatoonToBeMerged:GetPlatoonUnits()
    local tValidUnits = {}
    local bValidUnits = false
    local aiBrain = oPlatoonToMergeInto:GetBrain()
    for iCurUnit, oUnit in tMergingUnits do
        if not oUnit.Dead and not oUnit:IsUnitState('Attached') then
            if oUnit == M27Utilities.GetACU(aiBrain) then
                if bDebugMessages == true then
                    LOG(sFunctionRef..': oPlatoon includes ACU; oPlatoonTo#mergeInto plan='..oPlatoonToMergeInto:GetPlan()..oPlatoonToMergeInto[refiPlatoonCount])
                    if oPlatoonToBeMerged == aiBrain:GetPlatoonUniquelyNamed('ArmyPool') then LOG('oPlatoonToBeMerged is army pool')
                    else LOG('oPlatoonToBeMerged='..oPlatoonToBeMerged:GetPlan()..oPlatoonToBeMerged[refiPlatoonCount])
                    end
                end
            end
            table.insert(tValidUnits, oUnit)
            bValidUnits = true
        end
    end
    if bValidUnits == true then
        if bDebugMessages == true then LOG('MergePlatoons: have units in tMergingUnits; table.getn(tMergingUnits)='..table.getn(tMergingUnits)) end
        if ScenarioInfo.Options.AIPLatoonNameDebug == 'all' then UpdatePlatoonName(oPlatoonToBeMerged, oPlatoonToMergeInto:GetPlan()..oPlatoonToMergeInto[refiPlatoonCount]) end
        aiBrain:AssignUnitsToPlatoon(oPlatoonToMergeInto, tValidUnits, 'Attack', 'GrowthFormation')
    end
end

function GetMergeLocation(oPlatoonToMergeInto, iPercentOfWayToDestination)
    --Returns a pathable location as close to iPercentOfWayToDestination% of the way to oPlatoonToMergeInto's first movement path position as possible, or nil if a pathable location can't be found
    --iPercentOfWayToDestination - default 0.4; % of the way between current location and target location; suggested <=0.5
    --Returns the platoon current position if an error occurs
    local bDebugMessages = false
    local iDistanceFactor
    if iPercentOfWayToDestination == nil then iDistanceFactor = 0.4
    else iDistanceFactor = iPercentOfWayToDestination end
    local tCurPos = oPlatoonToMergeInto:GetPlatoonPosition()
    local tTargetPos = oPlatoonToMergeInto[reftMovementPath][1]
    if bDebugMessages == true then LOG(oPlatoonToMergeInto:GetPlan()..oPlatoonToMergeInto[refiPlatoonCount]..': tTargetPos[1]='..oPlatoonToMergeInto[reftMovementPath][1][1]) end
    local tBaseMergePosition = {}
    for iAxis = 1, 3 do
        if not(iAxis == 2) then tBaseMergePosition[iAxis] = tCurPos[iAxis] + (tTargetPos[iAxis] - tCurPos[iAxis]) * iDistanceFactor end
    end
    tBaseMergePosition[2] = GetTerrainHeight(tBaseMergePosition[1], tBaseMergePosition[3])
    --Check we can path here:
    local oPathingUnit = GetPathingUnit(oPlatoonToMergeInto)
    local iCurSegmentX, iCurSegmentZ = M27MapInfo.GetSegmentFromPosition(tCurPos)
    local sPathingType = M27Utilities.GetUnitPathingType(oPathingUnit)
    local iSegmentGroup = M27MapInfo.GetSegmentGroup(oPathingUnit, sPathingType, iCurSegmentX, iCurSegmentZ)
    local iMergePositionGroup, iMergeSegmentX, iMergeSegmentZ
    local tMergePosition = {}
    local iAttemptCount = 0
    local iDistanceMod = 0
    local iDistanceCount = 0
    local iXSign = 1
    local iZSign = 1
    if iSegmentGroup == nil then
        M27Utilities.ErrorHandler(oPlatoonToMergeInto:GetPlan()..oPlatoonToMergeInto[refiPlatoonCount]..': GetMergeLocation: iSegmentGroup is nil')
        if oPathingUnit == nil then LOG('oPathingUnilt is nil')
        else
            if iCurSegmentX == nil then LOG('iCurSegmentX is nil')
            else LOG('iCurSegmentX='..iCurSegmentX..'; iCurSegmentZ='..iCurSegmentZ)
            end
        end
        return tCurPos
    end
    local bNearbySegmentsSameGroup = false
    local iNearbySegmentSize = 1
    local iPlatoonUnits = oPlatoonToMergeInto[refiCurrentUnits]
    iNearbySegmentSize = math.ceil( iPlatoonUnits / 10)
    if iNearbySegmentSize >= 5 then iNearbySegmentSize = 5 end
    local iSegmentStart = -iNearbySegmentSize
    local iSegmentEnd = iNearbySegmentSize

    while bNearbySegmentsSameGroup == false do
        --Modify position so are cycling between 4 corners of a square around the position that steadily increases in size
        if iAttemptCount == 0 then iDistanceMod = 0
        else
            iDistanceCount = iDistanceCount + 1
            if iDistanceMod == 0 then iDistanceMod = 1 end
            if iDistanceCount > 4 then
                iDistanceCount = 0
                iDistanceMod = iDistanceMod * 2.
            end
            if iDistanceCount == 1 then iXSign = 1 iZSign = 1
            elseif iDistanceCount == 2 then iXSign = 1 iZSign = -1
            elseif iDistanceCount == 3 then iXSign = -1 iZSign = 1
            elseif iDistanceCount == 4 then iXSign = -1 iZSign = -1 end
        end
        tMergePosition = {tBaseMergePosition[1] + iDistanceMod * iXSign, 0, tBaseMergePosition[3] + iDistanceMod * iZSign}
        iMergeSegmentX, iMergeSegmentZ = M27MapInfo.GetSegmentFromPosition(tMergePosition)
        iMergePositionGroup = M27MapInfo.GetSegmentGroup(oPathingUnit, sPathingType, iMergeSegmentX, iMergeSegmentZ)
        iAttemptCount = iAttemptCount + 1

        if iMergePositionGroup == iSegmentGroup then
            --Are the nearby segments the same group?
            bNearbySegmentsSameGroup = true
            --Cycle from -1 to +1 segments (or -x/+x for larger platoon)
            for iXMod = iSegmentStart, iSegmentEnd do
                for iZMod = iSegmentStart, iSegmentEnd do
                    if not(M27MapInfo.GetSegmentGroup(oPathingUnit, sPathingType, iMergeSegmentX + iXMod, iMergeSegmentZ + iZMod) == iSegmentGroup) then bNearbySegmentsSameGroup = false break end
                end
                if bNearbySegmentsSameGroup == false then break end
            end
        end
        if iAttemptCount > 32 then return nil end --Infinite loop protection
    end
    if tMergePosition[1] == nil or tMergePosition[3] == nil then
        M27Utilities.ErrorHandler(oPlatoonToMergeInto:GetPlan()..oPlatoonToMergeInto[refiPlatoonCount]..': GetMergeLocation: tMergePosition is nil')
        if iMergePositionGroup == nil then LOG('iMergePositionGroup is nil')
        else LOG('iMergePositionGroup='..iMergePositionGroup) end
        return tCurPos
    else
        if iMergePositionGroup == iSegmentGroup then tMergePosition[2] = GetTerrainHeight(tMergePosition[1], tMergePosition[3]) end
        return tMergePosition
    end
end

function MergeWithPlatoonsOnPath(oPlatoonToMergeInto, sTargetPlatoonPlanName, bOnlyOnOurSideOfMap)
    --Cycle through all platoons using sTargetPlatoonPlanName and if they're <= same distance from the merge location (based on the first movement path point) then will merge with it
    --bOnlyOnOurSideOfMap - will ignore platoons closer to enemy base than our base if this is true
    local bDebugMessages = false
    local sFunctionRef = 'MergeWithPlatoonsOnPath'
    if bOnlyOnOurSideOfMap == nil then bOnlyOnOurSideOfMap = false end
    local aiBrain = oPlatoonToMergeInto:GetBrain()
    local tFriendlyPlatoons = aiBrain:GetPlatoonsList()
    local bNearToPath, iCurDistFromMerge
    local tBasePlatoonPos = {}
    tBasePlatoonPos = oPlatoonToMergeInto:GetPlatoonPosition()
    local tMergePosition = GetMergeLocation(oPlatoonToMergeInto, 0.35)
    oPlatoonToMergeInto[reftMergeLocation] = tMergePosition
    local tCurPlatoonPos = {}
    if M27Utilities.IsTableEmpty(tMergePosition) == false then
        local iCorePlatoonDistFromMerge = M27Utilities.GetDistanceBetweenPositions(tBasePlatoonPos, tMergePosition)
        local iArmyStartNumber = aiBrain.M27StartPositionNumber
        local iNearestEnemyStartNumber = M27Logic.GetNearestEnemyStartNumber(aiBrain)
        if iNearestEnemyStartNumber == nil then
            M27Utilities.ErrorHandler('iNearestEnemyStartNumber is nil')
        else
            if bDebugMessages == true then LOG('MergeWithplatoonsOnPath: getn(tFriendlyPlatoons)='..table.getn(tFriendlyPlatoons)) end
            for iCurPlan, oCurPlatoon in tFriendlyPlatoons do
                if not(oCurPlatoon == oPlatoonToMergeInto) then
                    if oCurPlatoon:GetPlan() == sTargetPlatoonPlanName then
                        if not oCurPlatoon.UsingTransport then
                            --Check if near enough
                            bNearToPath = false
                            tCurPlatoonPos = oCurPlatoon:GetPlatoonPosition()
                            iCurDistFromMerge = M27Utilities.GetDistanceBetweenPositions(tMergePosition, tCurPlatoonPos)
                            if iCurDistFromMerge <= iCorePlatoonDistFromMerge then
                                if bOnlyOnOurSideOfMap == false then bNearToPath = true
                                else
                                    --Check if closer to our start base than enemy
                                    if M27Utilities.GetDistanceBetweenPositions(tCurPlatoonPos, M27MapInfo.PlayerStartPoints[iArmyStartNumber]) <= M27Utilities.GetDistanceBetweenPositions(tCurPlatoonPos, M27MapInfo.PlayerStartPoints[iNearestEnemyStartNumber]) then bNearToPath = true end
                                end
                            end
                            if bDebugMessages == true then LOG('MergeWithplatoonsOnPath: iCurPlatoonPos='..tCurPlatoonPos[1]..'-'..tCurPlatoonPos[3]..'; tBasePlatoonPos='..tBasePlatoonPos[1]..'-'..tBasePlatoonPos[3]..'; iCurDistFromMerge='..iCurDistFromMerge) end
                            if bNearToPath == true then
                                if bDebugMessages == true then LOG('MergeWithPlatoonsOnPath: oCurPlatoon '..oCurPlatoon:GetPlan()..' is near to a destination, about to merge with '..oPlatoonToMergeInto:GetPlan()) end
                                MergePlatoons(oPlatoonToMergeInto, oCurPlatoon) end
                        end
                    end
                end
            end
        end
    else
        M27Utilities.ErrorHandler('Merge location is nil - only scenarios where expect this are if map has lots of water or impassable areas')
    end
end

function ForceActionRefresh(oPlatoon, iMinGapBetweenForces)
    --Flags to force a refresh when choosing platoon action, if last refresh >=5 seconds ago
    if iMinGapBetweenForces == nil then iMinGapBetweenForces = 5 end
    local bDebugMessages = false
    local sFunctionRef = 'ForceActionRefresh'
    local iTimeOfLastRefresh = oPlatoon[refiGameTimeOfLastRefresh]
    if iTimeOfLastRefresh == nil then iTimeOfLastRefresh = 2 end
    local iCurGameTime = GetGameTimeSeconds()
    if iTimeOfLastRefresh == true or iTimeOfLastRefresh== false then
        iTimeOfLastRefresh = 2
        bDebugMessages = true --error handler
        LOG(sFunctionRef..': Warning: Platoons iTimeOfLastRefresh was a boolean - logs enabled in case its in unexpected scenario.  This somehow happens when a new platoon is created using a unit that formed part of a prev platoon')
    end

    if bDebugMessages == true then
        local sPlatoonRef = oPlatoon:GetPlan()..oPlatoon[refiPlatoonCount]
        LOG(sFunctionRef..': iCurGameTime='..iCurGameTime..'; iLastForcedRefresh='..tostring(iTimeOfLastRefresh)..'; sPlatoonRef='..sPlatoonRef)
    end

    if iCurGameTime - iTimeOfLastRefresh >= iMinGapBetweenForces then
        oPlatoon[refbForceActionRefresh] = true
        oPlatoon[refiGameTimeOfLastRefresh] = iCurGameTime
        if bDebugMessages == true then LOG(sFunctionRef..': Updated time of last refresh, oPlatoon[refiGameTimeOfLastRefresh]='..oPlatoon[refiGameTimeOfLastRefresh]) end
    end
end

function HasPlatoonReachedDestination(oPlatoon)
    --Returns true if have reached current movement point destination, false otherwise
    --also updates
    --Have we reached the current move destination?
    local bDebugMessages = false
    local sFunctionRef = 'HasPlatoonReachedDestination'
    --if oPlatoon[refbOverseerAction] == true then bDebugMessages = true end
    local iCurrentUnits = oPlatoon[refiCurrentUnits]
    if iCurrentUnits == nil then
        oPlatoon[refiCurrentUnits] = table.getn(oPlatoon:GetPlatoonUnits())
        iCurrentUnits = oPlatoon[refiCurrentUnits] end
    local iReachedTargetDist
    if oPlatoon[refiOverrideDistanceToReachDestination] == nil then
        local iBase = 7
        if oPlatoon[refiBuilders] > 0 then iBase = 3 end --redundancy - have put this in the platoon initial setup as well
        iReachedTargetDist = iBase + iCurrentUnits * 0.25
        if iReachedTargetDist > 25 then iReachedTargetDist = 25 end
    else
        iReachedTargetDist = oPlatoon[refiOverrideDistanceToReachDestination]
    end

    if oPlatoon[reftMovementPath][oPlatoon[refiCurrentPathTarget]] == nil then
        --Rare error - debug messages and backup put in place for when this occurs, along with code to disband platoon if cant switch to valid movement path:
        M27Utilities.ErrorHandler(oPlatoon:GetPlan()..oPlatoon[refiPlatoonCount]..sFunctionRef..': oPlatoon[reftMovementPath][oPlatoon[refiCurrentPathTarget]] is nil; iCurrentUnits='..iCurrentUnits)
        if oPlatoon[refiCurrentPathTarget] == nil then LOG('refiCurrentPathTarget is nil') else LOG('refiCurrentPathTarget='..oPlatoon[refiCurrentPathTarget]) end
        if oPlatoon[reftMovementPath] == nil then
            LOG('reftMovementPath is nil')
            oPlatoon[refiCurrentAction] = refActionDisband
        else
            local iMoveTableSize = table.getn(oPlatoon[reftMovementPath])
            LOG('reftMovementPath table size='..iMoveTableSize)
            --Try to fix:
            if iMoveTableSize > 0 then
                LOG('tMovementPath repr='..repr(oPlatoon[reftMovementPath]))
                if oPlatoon[refiCurrentPathTarget] > iMoveTableSize then oPlatoon[refiCurrentPathTarget] = iMoveTableSize end
                if M27Utilities.IsTableEmpty(oPlatoon[reftMovementPath][oPlatoon[refiCurrentPathTarget]]) == true then
                    if iMoveTableSize == 0 then
                        oPlatoon[refiCurrentAction] = refActionDisband
                    else
                        oPlatoon[refiCurrentPathTarget] = oPlatoon[refiCurrentPathTarget] - 1
                    end
                end
            else LOG('reftMovementPath size isnt >0, disbanding platoon')
                oPlatoon[refiCurrentAction] = refActionDisband
            end
        end
        --Output prior actions:
        local sPrevAction = ''
        for iCount, iPrevActionRef in oPlatoon[reftPrevAction] do
            sPrevAction = sPrevAction .. iPrevActionRef .. '-'
        end
        LOG('sPrevAction='..sPrevAction)

    end

    local iCurDistToTarget = M27Utilities.GetDistanceBetweenPositions(oPlatoon:GetPlatoonPosition(), oPlatoon[reftMovementPath][oPlatoon[refiCurrentPathTarget]])
    if bDebugMessages == true then LOG(oPlatoon:GetPlan()..oPlatoon[refiPlatoonCount]..sFunctionRef..': iCurDistToTarget='..iCurDistToTarget..'; iReachedTargetDist='..iReachedTargetDist) end
    if iCurDistToTarget <= iReachedTargetDist then
        if bDebugMessages == true then LOG(oPlatoon:GetPlan()..oPlatoon[refiPlatoonCount]..sFunctionRef..': Are close enough to the target, iCurDistToTarget='..iCurDistToTarget..'; iReachedTargetDist='..iReachedTargetDist) end
        oPlatoon[refiCurrentPathTarget] = oPlatoon[refiCurrentPathTarget] + 1
        if oPlatoon[refiCurrentPathTarget] > table.getn(oPlatoon[reftMovementPath]) then
            oPlatoon[refiCurrentPathTarget] = table.getn(oPlatoon[reftMovementPath])
            oPlatoon[refiCurrentAction] = refActionNewMovementPath
        end
        return true
    else return false end
end

function DeterminePlatoonCompletionAction(oPlatoon)
    --Updates oPlatoon's action if have completed movement path
    local bDebugMessages = false
    --if oPlatoon[refbACUInPlatoon] == true then bDebugMessages = true end
    local aiBrain = oPlatoon:GetBrain()
    --if oPlatoon[refbOverseerAction] == true then bDebugMessages = true end
    local sPlatoonName = oPlatoon:GetPlan()
    if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': Determining platoon completion action') end
    if sPlatoonName == 'M27ACUMain' or sPlatoonName == 'M27AssistHydroEngi' then
        oPlatoon[refiCurrentAction] = refActionDisband
    else
        --Have we previously run away?
        if oPlatoon[refbHavePreviouslyRun] == true then
            --Default: New movement path.  Large attack platoons disband
            if sPlatoonName == 'M27LargeAttackForce' then oPlatoon[refiCurrentAction] = refActionDisband
            else oPlatoon[refiCurrentAction] = refActionNewMovementPath end
        else
            --Default: New movement path.  Large attack platoons switch to attack AI
            if sPlatoonName == 'M27LargeAttackForce' then oPlatoon[refiCurrentAction] = refActionUseAttackAI
            else oPlatoon[refiCurrentAction] = refActionNewMovementPath end
        end
    end
end



function GetNearbyEnemyData(oPlatoon, iEnemySearchRadius)
    --Updates the platoon to record details of nearby enemies
    --iEnemySearchRadius - used for mobile units (not structures)
    local bDebugMessages = false
    local tCurPos = oPlatoon:GetPlatoonPosition()
    local aiBrain = oPlatoon:GetBrain()
    oPlatoon[refiEnemySearchRadius] = iEnemySearchRadius
    if oPlatoon[reftEnemiesInRange] == nil then oPlatoon[reftEnemiesInRange] = {} end
    local iMobileEnemyCategories = categories.LAND * categories.MOBILE
    if oPlatoon[refbPlatoonHasOverwaterLand] == true then iMobileEnemyCategories = categories.LAND * categories.MOBILE + categories.NAVAL * categories.MOBILE end
    oPlatoon[reftEnemiesInRange] = aiBrain:GetUnitsAroundPoint(iMobileEnemyCategories, tCurPos, iEnemySearchRadius, 'Enemy')
    if oPlatoon[reftEnemiesInRange] == nil then
        oPlatoon[refiEnemiesInRange] = 0
    else oPlatoon[refiEnemiesInRange] = table.getn(oPlatoon[reftEnemiesInRange]) end
    oPlatoon[reftEnemyStructuresInRange] = aiBrain:GetUnitsAroundPoint(categories.STRUCTURE, tCurPos, M27Overseer.iSearchRangeForEnemyStructures, 'Enemy')
    if oPlatoon[reftEnemyStructuresInRange] == nil then
        oPlatoon[refiEnemyStructuresInRange] = 0
    else oPlatoon[refiEnemyStructuresInRange] = table.getn(oPlatoon[reftEnemyStructuresInRange]) end
    if oPlatoon[refiEnemiesInRange] + oPlatoon[refiEnemyStructuresInRange] > 0 then
        --get all friendly units around a point for threat detection - use slightly larger area
        oPlatoon[reftFriendlyNearbyUnits] = aiBrain:GetUnitsAroundPoint(categories.LAND, tCurPos, iEnemySearchRadius + 5, 'Ally')
        --Record enemy indirect units that can see
        oPlatoon[reftVisibleEnemyIndirect] = M27Logic.GetVisibleUnitsOnly(aiBrain, EntityCategoryFilterDown(categories.INDIRECTFIRE, oPlatoon[reftEnemiesInRange]))
        if oPlatoon[reftVisibleEnemyIndirect] == nil then oPlatoon[refiVisibleEnemyIndirect] = 0
        else oPlatoon[refiVisibleEnemyIndirect] = table.getn(oPlatoon[reftVisibleEnemyIndirect]) end
    end
end

function UpdatePlatoonActionIfStuck(oPlatoon)
    --Considers if oPlatoon is likely to be stuck, and if so then updates oPlatoon's action
    local bDebugMessages = false
    --if oPlatoon[refbACUInPlatoon] == true then bDebugMessages = true end
    local sFunctionRef = 'UpdatePlatoonActionIfStuck'
    --if oPlatoon[refbOverseerAction] == true then bDebugMessages = true LOG('UpdatePlatoonActionIfStuck: Start') end
    local sPlatoonName = oPlatoon:GetPlan()
    --if sPlatoonName == 'M27ACUMain' then bDebugMessages = true end
    --if sPlatoonName == 'M27ScoutAssister' then bDebugMessages = true end
    local aiBrain = oPlatoon:GetBrain()
    local iNearTargetForSupport = 20 --if are within this range of destination then will ignore isstuck action)

    --Assister and Intel platoons - ignore if they're near their destination
    local bIgnoreAssister = false
    local iAssisterDistanceFromDestination
    if sPlatoonName == M27Overseer.sIntelPlatoonRef or sPlatoonName == 'M27MAAAssister' or sPlatoonName == 'M27ScoutAssister' then
        local tPlatoonPosition = oPlatoon:GetPlatoonPosition()
        iAssisterDistanceFromDestination = M27Utilities.GetDistanceBetweenPositions(tPlatoonPosition, oPlatoon[reftMovementPath][oPlatoon[refiCurrentPathTarget]])
        if iAssisterDistanceFromDestination <= iNearTargetForSupport then bIgnoreAssister = true end
    end
    if bIgnoreAssister == false then
        --Check we're not busy reclaiming, building, upgrading:
        local bBusyBuildingOrReclaiming = false
        if bDebugMessages == true then
            LOG(sFunctionRef..': '..sPlatoonName..oPlatoon[refiPlatoonCount]..': About to check if platoon is stuck; platoon current action before running this:')
            if oPlatoon[refiCurrentAction] == nil then LOG('action is nil')
            else LOG('action is '..oPlatoon[refiCurrentAction]) end
        end
        if oPlatoon[refbConsiderMexes] == true then
            for iBuilder, oBuilder in oPlatoon[reftBuilders] do
                if oBuilder:IsUnitState('Building') == true then bBusyBuildingOrReclaiming = true break end
                if oBuilder:IsUnitState('Capturing') == true then bBusyBuildingOrReclaiming = true break end
                if oBuilder:IsUnitState('Upgrading') == true then bBusyBuildingOrReclaiming = true break end
            end
        end
        if bBusyBuildingOrReclaiming == false then
            if oPlatoon[refbConsiderReclaim] == true then
                for iReclaimer, oReclaimer in oPlatoon[reftReclaimers] do
                    if oReclaimer:IsUnitState('Reclaiming') == true then bBusyBuildingOrReclaiming = true break end
                end
            end
        end
        if bBusyBuildingOrReclaiming == false then
            local iCyclesSinceLastMoved = GetCyclesSinceLastMoved(oPlatoon, true, 5)
            local iCycleThreshold = 13
            if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': UpdateActionIfStuck: iCyclesSinceLastMoved='..iCyclesSinceLastMoved) end
            if iCyclesSinceLastMoved >= iCycleThreshold then
                if oPlatoon[refiCyclesForLastStuckAction] == nil then oPlatoon[refiCyclesForLastStuckAction] = 0 end
                if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': UpdateActionIfStuck: iCyclesSinceLastMoved='..iCyclesSinceLastMoved..'; refiCyclesForLastStuckAction='..oPlatoon[refiCyclesForLastStuckAction]) end
                if iCyclesSinceLastMoved - oPlatoon[refiCyclesForLastStuckAction] >= iCycleThreshold then
                    --Are we still stuck despite trying to get unstuck before?
                    if oPlatoon[refiCyclesForLastStuckAction] >= iCycleThreshold * 6 then
                        --Are still stuck despite attempting to return to base; switch to attack AI
                        oPlatoon[refiCurrentAction] = refActionUseAttackAI
                    else
                        --Still stuck despite trying preferred 'unstick' strategy; now try to return to base
                        if oPlatoon[refiCyclesForLastStuckAction] >= iCycleThreshold * 3 then
                            oPlatoon[refiCurrentAction] = refActionReturnToBase
                        else
                            --First time the platoon is stuck; get preferred unsticking approach

                            --Is the platoon in combat? If so it might be killing units hence why its not moving.  It might also be attacking cliffs
                            local bAttackingForAWhile = false
                            if not(oPlatoon[reftPrevAction] == nil) then
                                local iPrevActionCount = table.getn(oPlatoon[reftPrevAction])
                                if iPrevActionCount >= iCycleThreshold then
                                    --Consider if all of the last iCycleThreshold actions have been attacking:
                                    bAttackingForAWhile = true
                                    for iPrevAction = 1, iPrevActionCount do
                                        if not(oPlatoon[reftPrevAction][iPrevAction] == refActionAttack) then
                                            if not(oPlatoon[reftPrevAction][iPrevAction] == nil) then
                                                bAttackingForAWhile = false
                                                if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': UpdateActionIfStuck: bAttackingForAWhile just changed to false due to iPrevAction='..iPrevAction..'; iActionRef='..oPlatoon[reftPrevAction][iPrevAction]) end
                                                break
                                            end
                                        end
                                        if iPrevAction >= iCycleThreshold then break end
                                    end
                                end
                            end

                            if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': UpdateActionIfStuck: bAttackingForAWhile='..tostring(bAttackingForAWhile)..'; CyclesForLastStuckAction='..oPlatoon[refiCyclesForLastStuckAction]..'; iCyclesSinceLastMoved='..iCyclesSinceLastMoved) end
                            if bAttackingForAWhile == true then
                                oPlatoon[refiCurrentAction] = refActionMoveDFToNearestEnemy
                                if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': UpdateActionIfStuck: Been attacking for a while so will move DF to nearest enemy') end
                            else
                                --Have we just started attacking? If so then give slightly more time to do this
                                if oPlatoon[reftPrevAction][1] == refActionAttack then
                                    if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': UpdateActionIfStuck: Recently started attacking so will give more time before stuck action') end
                                    --Do nothing
                                else
                                    --Are we moving along the path? If so skip the current path if we can
                                    if oPlatoon[reftPrevAction][1] == refActionContinueMovementPath then
                                        if oPlatoon[refiCurrentPathTarget] < table.getn(oPlatoon[reftMovementPath]) then
                                            oPlatoon[refiCurrentPathTarget] = oPlatoon[refiCurrentPathTarget] + 1
                                            oPlatoon[refiCurrentAction] = refActionReissueMovementPath
                                        else
                                            --We're moving but we're already trying to reach the end destination - get new move orders
                                            --Exception - large attack AI That has run back to base and stuck near to base - want it to disband instead
                                            local bDisbandNotNewPath = false
                                            if sPlatoonName == 'M27LargeAttackForce' then
                                                if oPlatoon[refbHavePreviouslyRun] == true then
                                                    --Are we relatively close to our start?
                                                    local tPlatoonPosition = oPlatoon:GetPlatoonPosition()
                                                    if M27Utilities.GetDistanceBetweenPositions(tPlatoonPosition, M27MapInfo.PlayerStartPoints[M27Utilities.GetAIBrainArmyNumber(aiBrain)]) <= 50 then
                                                        bDisbandNotNewPath = true
                                                        oPlatoon[refiCurrentAction] = refActionDisband
                                                    end
                                                end
                                            end
                                            if bDisbandNotNewPath == false then oPlatoon[refiCurrentAction] = refActionNewMovementPath end
                                        end
                                    else

                                        --We're not moving along a path, and aren't attacking an enemy
                                        --Are there nearby enemies? If so then attack them
                                        if oPlatoon[refiEnemiesInRange] + oPlatoon[refiEnemyStructuresInRange] > 0 then
                                            oPlatoon[refiCurrentAction] = refActionAttack
                                        else
                                            oPlatoon[refiCurrentAction] = refActionContinueMovementPath
                                        end
                                    end --Prev action refActionContinueMovementPath
                                end --Prev action refActionAttack
                            end --bAttackingForAWhile
                        end
                    end
                    oPlatoon[refiCyclesForLastStuckAction] = iCyclesSinceLastMoved
                    --Force a refresh in the platoon action (redundancy for unforseen impact of the 'ignore refresh' logic)
                    if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': Stuck action forced refresh enabled') end
                    ForceActionRefresh(oPlatoon)
                end
            end
        end
    end
    if bDebugMessages == true then
        LOG(sFunctionRef..': '..sPlatoonName..oPlatoon[refiPlatoonCount]..': Platoon action following checking if stuck is:')
        if oPlatoon[refiCurrentAction] == nil then LOG('action is nil')
        else LOG('action is '..oPlatoon[refiCurrentAction]) end
    end
end

function GetOverchargeExtraAction(aiBrain, oPlatoon, oUnitWithOvercharge)
    --should have already confirmed overcharge action is available using CanUnitUseOvercharge
    local bDebugMessages = false
    local sFunctionRef = 'GetOverchargeExtraAction'
    if bDebugMessages == true then LOG(sFunctionRef..': Start of code') end
    --Do we have positive energy income? If not, then only overcharge if ACU is low on health as an emergency
    local bResourcesToOvercharge = false
    local oOverchargeTarget
    local iMinT1ForOvercharge = 3
    local bAreRunning = false

    if M27Conditions.HaveExcessEnergy(aiBrain, 10) then bResourcesToOvercharge = true
    else
        if oPlatoon[refbACUInPlatoon] == true and M27Utilities.GetACU(aiBrain):GetHealthPercent() < 0.4 then bResourcesToOvercharge = true end
    end
    if bResourcesToOvercharge == true then
        local tUnitPosition = oUnitWithOvercharge:GetPosition()
        local iACURange = M27Logic.GetACUMaxDFRange(oUnitWithOvercharge)
        local iOverchargeArea = 2.5
        local bShotIsBlocked

        --Is there any enemy point defence nearby? If so then overcharge it (unless are running away in which case just target mobile units)
        if oPlatoon[refiCurrentAction] == refActionRun or oPlatoon[refiCurrentAction] == refActionReturnToBase then bAreRunning = true end
        if bAreRunning == false then

            local tEnemyPointDefence = aiBrain:GetUnitsAroundPoint(categories.STRUCTURE * categories.DIRECTFIRE, tUnitPosition, iACURange, 'Enemy')
            if bDebugMessages == true then LOG(sFunctionRef..': have resources to overcharge, considering nearby enemies') end
            if M27Utilities.IsTableEmpty(tEnemyPointDefence) == false then
                if bDebugMessages == true then LOG(sFunctionRef..': Have enemy point defence in range - considering if shot is blocked') end
                for iUnit, oEnemyPD in tEnemyPointDefence do
                    if M27Logic.IsShotBlocked(oUnitWithOvercharge, oEnemyPD) == false then
                        if bDebugMessages == true then LOG(sFunctionRef..': Setting target to in range PD') end
                        oOverchargeTarget = oEnemyPD
                        break
                    end
                end
            end
            if oOverchargeTarget == nil then
                --Check further away incase enemy has T2 PD
                if bDebugMessages == true then LOG(sFunctionRef..': Checking if any T2 PD further away') end
                tEnemyPointDefence = aiBrain:GetUnitsAroundPoint(categories.STRUCTURE * categories.DIRECTFIRE * categories.TECH2 + categories.STRUCTURE * categories.DIRECTFIRE * categories.TECH3, tUnitPosition, 50, 'Enemy')
                if M27Utilities.IsTableEmpty(tEnemyPointDefence) == false then
                    if bDebugMessages == true then LOG(sFunctionRef..': Have enemy T2 defence that can hit us but is out of our range - considering if shot is blocked') end
                    for iUnit, oEnemyT2PD in tEnemyPointDefence do
                        if M27Logic.IsShotBlocked(oUnitWithOvercharge, oEnemyT2PD) == false then
                            if bDebugMessages == true then LOG(sFunctionRef..': Setting target to T2 PD') end
                            oOverchargeTarget = oEnemyT2PD
                            break
                        end
                    end
                end
            end
        end
        if oOverchargeTarget == nil then
            local tEnemyT2Plus = aiBrain:GetUnitsAroundPoint(categories.LAND * categories.MOBILE * categories.DIRECTFIRE * categories.TECH2 + categories.LAND * categories.MOBILE * categories.DIRECTFIRE * categories.TECH3 + categories.LAND * categories.MOBILE * categories.DIRECTFIRE * categories.EXPERIMENTAL - categories.SUBCOMMANDER, tUnitPosition, iACURange, 'Enemy')
            if M27Utilities.IsTableEmpty(tEnemyT2Plus) == false then
                for iUnit, oEnemyT2Unit in tEnemyT2Plus do
                    if bDebugMessages == true then LOG(sFunctionRef..': Have enemy T2+ mobile land to consider') end
                    if M27Logic.IsShotBlocked(oUnitWithOvercharge, oEnemyT2Unit) == false then
                        if bDebugMessages == true then LOG(sFunctionRef..': Setting target to t2+ unit') end
                        oOverchargeTarget = oEnemyT2Unit
                        break
                    end
                end
            end
            if oOverchargeTarget == nil then
                local tEnemyT1 = aiBrain:GetUnitsAroundPoint(categories.LAND * categories.MOBILE * categories.TECH1 * categories.DIRECTFIRE + categories.LAND * categories.MOBILE * categories.TECH1 * categories.INDIRECTFIRE, tUnitPosition, iACURange, 'Enemy')
                local tNearbyEnemiesToTarget
                local iMaxUnitsInArea = 0
                local iCurUnitsInArea
                for iUnit, oEnemyT1Unit in tEnemyT1 do
                    if bDebugMessages == true then LOG(sFunctionRef..': Have T1 units to consider, checking how many units are near them for AOE') end
                    tNearbyEnemiesToTarget = aiBrain:GetUnitsAroundPoint(categories.ALLUNITS, oEnemyT1Unit:GetPosition(), iOverchargeArea, 'Enemy')
                    if M27Utilities.IsTableEmpty(tNearbyEnemiesToTarget) == false then
                        iCurUnitsInArea = table.getn(tNearbyEnemiesToTarget)if bDebugMessages == true then LOG(sFunctionRef..': Have T1 units with iCurUnitsInArea='..iCurUnitsInArea..' within area effect') end
                        if iCurUnitsInArea >= iMinT1ForOvercharge then
                            --bShotIsBlocked = M27Logic.IsShotBlocked(oUnitWithOvercharge, oEnemyT1Unit)
                            bShotIsBlocked = M27Logic.IsShotBlocked(oUnitWithOvercharge, oEnemyT1Unit)
                            if bShotIsBlocked == false then
                                if iCurUnitsInArea > iMaxUnitsInArea then
                                    if bDebugMessages == true then LOG(sFunctionRef..': Setting target to t1 unit') end
                                    iMaxUnitsInArea = iCurUnitsInArea
                                    oOverchargeTarget = oEnemyT1Unit
                                    if oOverchargeTarget == nil and bDebugMessages == true then LOG(sFunctionRef..': Overcharge target is nil1') end
                                end
                                if oOverchargeTarget == nil and bDebugMessages == true then LOG(sFunctionRef..': Overcharge target is nil2') end
                            end
                            if oOverchargeTarget == nil and bDebugMessages == true then LOG(sFunctionRef..': Overcharge target is nil3') end
                        end
                        if oOverchargeTarget == nil and bDebugMessages == true then LOG(sFunctionRef..': Overcharge target is nil4') end
                    end
                    if oOverchargeTarget == nil and bDebugMessages == true then LOG(sFunctionRef..': Overcharge target is nil5') end
                end
                if oOverchargeTarget == nil and bDebugMessages == true then LOG(sFunctionRef..': Overcharge target is nil6') end
                if oOverchargeTarget == nil then
                    --Consider enemy ACU if its in range and low on health
                    if bDebugMessages == true then LOG(sFunctionRef..': Considering enemy ACU and if its low on health') end
                    local tEnemyACU = aiBrain:GetUnitsAroundPoint(categories.COMMAND, tUnitPosition, iACURange, 'Enemy')
                    if M27Utilities.IsTableEmpty(tEnemyACU) == false then
                        for iUnit, oEnemyACUUnit in tEnemyACU do
                            if oEnemyACUUnit:GetHealthPercent() <= 0.1 then
                                if M27Logic.IsShotBlocked(oUnitWithOvercharge, oEnemyACUUnit) == false then
                                    if bDebugMessages == true then LOG(sFunctionRef..': Setting target to enemy ACU') end
                                    oOverchargeTarget = oEnemyACUUnit
                                    break
                                end
                            end
                        end
                    end
                end
            end
        end
        if oOverchargeTarget == nil then
            if bDebugMessages == true then LOG(sFunctionRef..': oOverchargeTarget is nil, wont give overcharge action') end
        else
            if bDebugMessages == true then LOG(sFunctionRef..': Telling platoon to process overcharge action') end
            oPlatoon[refiExtraAction] = refExtraActionOvercharge
            oPlatoon[refExtraActionTargetUnit] = oOverchargeTarget
        end
    end
end

function GetUnderwaterActionForLandUnit(oPlatoon)
    --Checks if platoon is underwater, and if so decides on action
    local bDebugMessages = false
    local sFunctionRef = 'GetUnderwaterActionForLandUnit'
    local tPlatoonPosition = oPlatoon:GetPlatoonPosition()
    local iHeightAtWhichConsideredUnderwater = M27MapInfo.IsUnderwater(tPlatoonPosition, true) + 1 --small margin of error
    local iMaxDistanceForLandSearch = 20
    if bDebugMessages == true then LOG(sFunctionRef..': Checking if underwater') end
    if tPlatoonPosition[2] < iHeightAtWhichConsideredUnderwater then
        if bDebugMessages == true then LOG(sFunctionRef..': Are underwater, Checking if DF units in platoon') end
        if oPlatoon[refiDFUnits] > 0 then
            --Get blueprint for the first unit in the platoon that is underwater
            local oUnderwaterUnit
            if bDebugMessages == true then LOG(sFunctionRef..': Getting first amphibious unit in platoon') end
            for iUnit, oUnit in oPlatoon[reftDFUnits] do
                if M27Utilities.IsUnitUnderwaterAmphibious(oUnit) == true then
                    oUnderwaterUnit = oUnit
                    break
                end
            end
            if oUnderwaterUnit and not(oUnderwaterUnit.Dead) then
                if bDebugMessages == true then LOG(sFunctionRef..': Have amphibious unit, checking firing position') end
                local tFiringPositionStart = M27Logic.GetDirectFireWeaponPosition(oUnderwaterUnit)
                if tFiringPositionStart then
                    if bDebugMessages == true then LOG(sFunctionRef..': Have firing position, checking if its below water') end
                    local iFiringHeight = tFiringPositionStart[2]
                    if iFiringHeight <= iHeightAtWhichConsideredUnderwater then
                        if bDebugMessages == true then LOG(sFunctionRef..': Gun is below water, checking if have reclaimers; refiReclaimers='..oPlatoon[refiReclaimers]) end
                        local bMoveToNearbyLand, tNearbyLandPosition
                        --Do we contain reclaimers?
                        if oPlatoon[refiReclaimers] > 0 then
                            local aiBrain = oPlatoon:GetBrain()
                            local oReclaimer = oPlatoon[reftReclaimers][1]
                            if oReclaimer == nil or oReclaimer.Dead then
                                M27Utilities.ErrorHandler('Reclaimer is nil or dead')
                            else
                                local iBuildDistance = oReclaimer:GetBlueprint().Economy.MaxBuildDistance
                                local tNearbyEnemiesThatCanReclaim = aiBrain:GetUnitsAroundPoint(categories.RECLAIMABLE, tPlatoonPosition, iBuildDistance + 10, 'Enemy')
                                local oReclaimTarget
                                if bDebugMessages == true then LOG(sFunctionRef..': Have alive reclaimer in platoon, checking if enemy units nearby that can reclaim') end
                                if M27Utilities.IsTableEmpty(tNearbyEnemiesThatCanReclaim) == false then
                                    if bDebugMessages == true then LOG(sFunctionRef..': Are nearby enemies that can reclaim') end
                                    oReclaimTarget = M27Utilities.GetNearestUnit(tNearbyEnemiesThatCanReclaim, tPlatoonPosition, aiBrain, true)
                                    if oReclaimTarget then
                                        local iDistanceToPlatoon = M27Utilities.GetDistanceBetweenPositions(oReclaimTarget:GetPosition(), tPlatoonPosition)
                                        if bDebugMessages == true then LOG(sFunctionRef..': Have a reclaim target, iDistanceToPlatoon='..iDistanceToPlatoon..'; iBuildDistance='..iBuildDistance) end
                                        if iDistanceToPlatoon <= iBuildDistance then
                                            if bDebugMessages == true then LOG(sFunctionRef..': Trying to target nearby enemy for reclaim') end
                                            oPlatoon[refoNearbyReclaimTarget] = oReclaimTarget
                                            oPlatoon[refiCurrentAction] = refActionReclaimNearby
                                        else
                                            --first see if nearby land that can move to
                                            --GetNearestPathableLandPosition(oPathingUnit, tTravelTarget, iMaxSearchRange)
                                            tNearbyLandPosition = M27MapInfo.GetNearestPathableLandPosition(oUnderwaterUnit, oPlatoon[reftMovementPath][oPlatoon[refiCurrentPathTarget]], iMaxDistanceForLandSearch)
                                            if M27Utilities.IsTableEmpty(tNearbyLandPosition) == false then
                                                if bDebugMessages == true then LOG(sFunctionRef..': Have nearby land that can move to') end
                                                bMoveToNearbyLand = true
                                            else
                                                --Reclaim the unit that is further away than our build distance
                                                if bDebugMessages == true then LOG(sFunctionRef..': No nearby land so will move to enemy and try and reclaim') end
                                                oPlatoon[refoNearbyReclaimTarget] = oReclaimTarget
                                                oPlatoon[refiCurrentAction] = refActionReclaimNearby
                                            end
                                        end
                                    else
                                        if bDebugMessages == true then LOG(sFunctionRef..': Are no nearby enemies that can reclaim') end
                                    end
                                end
                            end
                        else
                            if bDebugMessages == true then LOG(sFunctionRef..': No nearby enemies so will see if have nearby land') end
                            tNearbyLandPosition = M27MapInfo.GetNearestPathableLandPosition(oUnderwaterUnit, oPlatoon[reftMovementPath][oPlatoon[refiCurrentPathTarget]], iMaxDistanceForLandSearch)
                            if M27Utilities.IsTableEmpty(tNearbyLandPosition) == false then
                                if bDebugMessages == true then LOG(sFunctionRef..': No nearby enemies but nearby land so will move there') end
                                bMoveToNearbyLand = true
                            end
                        end
                        if bMoveToNearbyLand == true then
                            oPlatoon[refiCurrentAction] = refActionMoveToTemporaryLocation
                            oPlatoon[reftTemporaryMoveTarget] = tNearbyLandPosition
                        else
                            if oPlatoon[refiCurrentAction] == nil then oPlatoon[refiCurrentAction] = refActionContinueMovementPath end
                        end
                    end
                else
                    M27Utilities.ErrorHandler('couldnt locate position value for direct fire weapon on oUnderwater unit')
                end
            else
                M27Utilities.ErrorHandler('platoon is registered as having underwater amphibious units, but couldnt locate any with a direct fire weapon')
            end
        end
    else
        if bDebugMessages == true then LOG(sFunctionRef..': tPlatoonPosition[2]='..tPlatoonPosition[2]..'; terrain height='..GetTerrainHeight(tPlatoonPosition[1], tPlatoonPosition[3])..'; surface height='..GetSurfaceHeight(tPlatoonPosition[1], tPlatoonPosition[3])) end
    end
end

function UpdatePlatoonActionForNearbyEnemies(oPlatoon)
    --Decides what to do based on what enemies the platoon has recorded as being nearby
    --assumes GetNearbyEnemyData has already been run
    local bDebugMessages = false
    --if oPlatoon[refbACUInPlatoon] == true then bDebugMessages = true end
    local sFunctionRef = 'UpdatePlatoonActionForNearbyEnemies'
    --ACU run away if low on health (regardless of whether enemies are in range, although put here since at some point will want T1 arti micro)
    local sPlatoonName = oPlatoon:GetPlan()
    local aiBrain = oPlatoon:GetBrain()
    local bProceed = true


    --ACU RunAway logic (highest priority):
    if oPlatoon[refbACUInPlatoon] == true then
        --bDebugMessages = true
        --Run back to base if low health; reset movement path if regained health
        local iHealthToRunOn = 5250
        local iCurrentHealth = M27Utilities.GetACU(aiBrain):GetHealth()
        if oPlatoon[refbNeedToHeal] == true then iHealthToRunOn = 6250 end
        if iCurrentHealth <= iHealthToRunOn then
            oPlatoon[refbNeedToHeal] = true
            oPlatoon[refiCurrentAction] = refActionReturnToBase
            bProceed = false
        else
            oPlatoon[refbNeedToHeal] = false
            if oPlatoon[refbHavePreviouslyRun] == true then
                if oPlatoon[reftMovementPath][1] == M27MapInfo.PlayerStartPoints[aiBrain.M27StartPositionNumber] then
                    oPlatoon[refiCurrentAction] = refActionNewMovementPath
                    bProceed = false
                end
            end
        end
    end

    --If underwater unit then check for navy units here (aren't checking all the time as only want to include enemy actions re them if are underwater - dont want units chasing them into the water; navy already gets included in nearbyenemies for overwater units
    local iNearbyEnemies = oPlatoon[refiEnemyStructuresInRange] + oPlatoon[refiEnemiesInRange]
    local tPlatoonPos = oPlatoon:GetPlatoonPosition()
    local tEnemyNavyIfUnderwater
    if iNearbyEnemies == 0 and oPlatoon[refbPlatoonHasUnderwaterLand] == true then
        tEnemyNavyIfUnderwater = aiBrain:GetUnitsAroundPoint(categories.NAVAL * categories.MOBILE, tPlatoonPos, oPlatoon[refiEnemySearchRadius], 'Enemy')
        if M27Utilities.IsTableEmpty(tEnemyNavyIfUnderwater) == false then iNearbyEnemies = table.getn(tEnemyNavyIfUnderwater) end
    end
    local bDontConsiderFurtherOrders = false
    local bWillWinAttack = false
    local bHaveRunRecently = false
    if iNearbyEnemies > 0 then
        if bProceed == true then
            --Intel specific - just run unless only structures and known to be hostile:
            if sPlatoonName == M27Overseer.sIntelPlatoonRef or sPlatoonName == 'M27ScoutAssister' or sPlatoonName == 'M27MAAAssister' then
                if oPlatoon[refiEnemiesInRange] > 0 then
                    --Are any enemy units >5 inside our intel range (if M27ScoutAssister or M27MAAAssister, then this is increased to 10)?
                    local bCloseThreat = false
                    local iIntelRange = 35
                    if sPlatoonName == 'M27MAAAssister' then iIntelRange = 40 else
                        for iCurUnit, oUnit in oPlatoon:GetPlatoonUnits() do
                            if not(oUnit.Dead) then
                                iIntelRange = oUnit:GetBlueprint().Intel.RadarRadius
                                break
                            end
                        end
                    end
                    local iDistanceWithinIntelBeforeRun = 5
                    if sPlatoonName == 'M27ScoutAssister' then iDistanceWithinIntelBeforeRun = 10 end

                    local tMobileUnitsInIntelRange = aiBrain:GetUnitsAroundPoint(categories.MOBILE, tPlatoonPos, iIntelRange - iDistanceWithinIntelBeforeRun, 'Enemy')
                    --GetCombatThreatRating(aiBrain, tUnits, bUseBlip, iMassValueOfBlipsOverride)
                    if not(tMobileUnitsInIntelRange == nil) then
                        if table.getn(tMobileUnitsInIntelRange) > 0 then
                            if bDebugMessages == true then LOG(sFunctionRef..': sPlatoonName='..sPlatoonName..oPlatoon[refiPlatoonCount]..': mobile units in intel range='..table.getn(tMobileUnitsInIntelRange)) end
                            if M27Logic.GetCombatThreatRating(aiBrain, tMobileUnitsInIntelRange, true, 50) > 0 then
                                bCloseThreat = true
                            else
                                --still return true if structure in range that has a threat:
                                if oPlatoon[refiEnemyStructuresInRange] > 0 then
                                    --GetCombatThreatRating(aiBrain, tUnits, bUseBlip, iMassValueOfBlipsOverride)
                                    if M27Logic.GetCombatThreatRating(aiBrain, oPlatoon[reftEnemyStructuresInRange], true) > 0 then
                                        bCloseThreat = true
                                    end
                                end
                            end
                            if bDebugMessages == true then LOG(sFunctionRef..': sPlatoonName='..sPlatoonName..oPlatoon[refiPlatoonCount]..': enemy threat='..M27Logic.GetCombatThreatRating(aiBrain, tMobileUnitsInIntelRange, true, 50)) end
                        end
                    end
                    if bCloseThreat == true then
                        --Have enemies in intel range - run away
                        if bDebugMessages == true then LOG(sFunctionRef..': sPlatoonName='..sPlatoonName..oPlatoon[refiPlatoonCount]..':  setting platoon action to run away') end
                        oPlatoon[refiCurrentAction] = refActionRun
                    else
                        --Do nothing
                    end
                else
                    --Only have structures nearby - only run if know are hostile:
                    if M27Logic.GetCombatThreatRating(aiBrain, oPlatoon[reftEnemyStructuresInRange], true) > 0 then
                        oPlatoon[refiCurrentAction] = refActionRun
                    end
                end
            else

                --============Non-Intel logic--------

                --=========Underwater platoon unit logic (higher priority than kiting and overcharge)
                if bDebugMessages == true then LOG(sFunctionRef..': About to check for underwater if platoon has underwater unit in it') end
                if oPlatoon[refbPlatoonHasUnderwaterLand] == true then
                    if bDebugMessages == true then LOG(sFunctionRef..': Have an underwater unit, about to run code to check for underwater action') end
                    GetUnderwaterActionForLandUnit(oPlatoon)
                end
                if oPlatoon[refiCurrentAction] == nil then

                    --======KITING LOGIC-------
                    bDontConsiderFurtherOrders = false
                    if oPlatoon[refiEnemiesInRange] > 0 then
                        --bDebugMessages = true
                        if oPlatoon[refbKiteEnemies] == true then
                            if bDebugMessages == true then LOG(sFunctionRef..sPlatoonName..': Considering kiting action; iEnemiesInRange='..oPlatoon[refiEnemiesInRange]) end
                            --Get nearest enemy
                            local tPlatoonPosition = oPlatoon:GetPlatoonPosition()
                            local tNearbyPD = {}
                            local oNearestPD
                            if oPlatoon[refiEnemyStructuresInRange] > 0 then
                                tNearbyPD = EntityCategoryFilterDown(categories.DIRECTFIRE, oPlatoon[reftEnemyStructuresInRange])
                                if M27Utilities.IsTableEmpty(tNearbyPD) == false then
                                    oNearestPD = M27Utilities.GetNearestUnit(tNearbyPD, tPlatoonPosition, aiBrain, true)
                                end
                            end
                            local oNearestEnemy = M27Utilities.GetNearestUnit(oPlatoon[reftEnemiesInRange], tPlatoonPosition, aiBrain, true)
                            local iPlatoonMaxRange = M27Logic.GetDirectFireUnitMinOrMaxRange(oPlatoon:GetPlatoonUnits(), 2)
                            local iEnemyMaxRange = 0
                            if oNearestEnemy or oNearestPD then
                                local iNearestEnemyDistance = 1000
                                local iNearestPDDistance = 1000
                                local tNearestPD, tNearestEnemy
                                if oNearestPD then
                                    tNearestPD = oNearestPD:GetPosition()
                                    iNearestPDDistance = M27Utilities.GetDistanceBetweenPositions(tNearestPD, tPlatoonPosition)
                                end
                                if oNearestEnemy then
                                    tNearestEnemy = oNearestEnemy:GetPosition()
                                    iNearestEnemyDistance = M27Utilities.GetDistanceBetweenPositions(tNearestEnemy, tPlatoonPosition)
                                end
                                if iNearestPDDistance < iNearestEnemyDistance then
                                    oNearestEnemy = oNearestPD
                                end
                                --CanSeeUnit(aiBrain, oUnit, bTrueIfOnlySeeBlip)
                                if oNearestEnemy == oNearestPD then
                                    --Dont need CanSeeUnit, as in reality will have visual effect from enemy PD that is distinctive such that will know if there's an enemy PD nearby
                                    iEnemyMaxRange = M27Logic.GetDirectFireUnitMinOrMaxRange({oNearestEnemy}, 2)
                                else
                                    if M27Utilities.CanSeeUnit(aiBrain, oNearestEnemy, false) then iEnemyMaxRange = M27Logic.GetDirectFireUnitMinOrMaxRange({oNearestEnemy}, 2) end
                                end
                                if bDebugMessages == true then LOG(sFunctionRef..sPlatoonName..': iPlatoonMaxRange='..iPlatoonMaxRange..'; iEnemyMaxRange='..iEnemyMaxRange) end
                                if iPlatoonMaxRange >= iEnemyMaxRange then --if have same max range may still be benefit to kiting if enemy lacks intel
                                    if oNearestEnemy == oNearestPD then
                                        bDontConsiderFurtherOrders = true
                                        oPlatoon[refiCurrentAction] = refActionMoveJustWithinRangeOfNearestPD
                                    else
                                        --GetIntelCoverageOfPosition(aiBrain, tTargetPosition, iMinCoverageWanted)
                                        --    --Look for the nearest intel coverage for tTargetPosition
                                        --    --if iMinCoverageWanted isn't specified then will return the highest amount, otherwise returns true/false
                                        if iNearestEnemyDistance > iPlatoonMaxRange then
                                            bDontConsiderFurtherOrders = true
                                            oPlatoon[refiCurrentAction] = refActionMoveDFToNearestEnemy
                                        else
                                            local iIntelCoverage = M27Logic.GetIntelCoverageOfPosition(aiBrain, tPlatoonPosition, nil)
                                            if bDebugMessages == true then LOG(sFunctionRef..sPlatoonName..': We outrange nearest enemy, checking our intel coverage, iIntelCoverage='..iIntelCoverage) end
                                            if iIntelCoverage >= 30 then
                                                local iDistanceInsideOurRange = iPlatoonMaxRange - iNearestEnemyDistance
                                                local iPrevDistanceInsideOurRange = oPlatoon[refiPrevNearestEnemyDistance]
                                                oPlatoon[refiPrevNearestEnemyDistance] = iDistanceInsideOurRange
                                                if bDebugMessages == true then LOG(sFunctionRef..sPlatoonName..': iDistanceInsideOurRange='..iDistanceInsideOurRange) end
                                                if iDistanceInsideOurRange > 5 then
                                                    bDontConsiderFurtherOrders = true
                                                    oPlatoon[refiCurrentAction] = refActionRun
                                                else
                                                    if iPrevDistanceInsideOurRange == nil or iPrevDistanceInsideOurRange < iDistanceInsideOurRange then --Enemy getting close
                                                        bDontConsiderFurtherOrders = true
                                                        oPlatoon[refiCurrentAction] = refActionRun
                                                    else
                                                        bDontConsiderFurtherOrders = true
                                                        oPlatoon[refiCurrentAction] = refActionMoveDFToNearestEnemy
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    --We either dont outrange enemy or dont know if we do - revert to normal logic
                                    --bDontConsiderFurtherOrders = true
                                    --oPlatoon[refiCurrentAction] = refActionMoveDFToNearestEnemy
                                end
                                --Kiting override - if have >1 unit closer to enemy than us, then want to just attack-move rather than running away
                                if oPlatoon[refiCurrentAction] == refActionRun then
                                    local iCloserAllyCount = 0
                                    local tCloserAllies = aiBrain:GetUnitsAroundPoint(categories.LAND * categories.DIRECTFIRE + categories.LAND * categories.INDIRECTFIRE, tPlatoonPosition, iNearestEnemyDistance, 'Ally')
                                    if M27Utilities.IsTableEmpty(tCloserAllies) == false then
                                        local iCloserAllyCount = table.getn(tCloserAllies)
                                        if iCloserAllyCount >= 3 then --in reality 2 as ACU should be included
                                            oPlatoon[refiCurrentAction] = refActionAttack
                                        end
                                    end
                                end
                            end
                        end
                        if bDebugMessages == true then if oPlatoon[refiCurrentAction]==nil then LOG(sFunctionRef..sPlatoonName..': Action after running kiting logic is nil')
                        else LOG(sFunctionRef..sPlatoonName..': Action after running kiting logic='..oPlatoon[refiCurrentAction])end
                        end
                    end
                    if oPlatoon[refbKiteEnemies] == true then
                        if oPlatoon[refiCurrentAction] == nil then
                            if oPlatoon[refbKitingLogicActive] == true then
                                --Were previously kiting, now have no action re kiting - e.g. enemy destroyed, or run away
                                if bDebugMessages == true then LOG(sFunctionRef..': Kiting logic has no action, but previously did; reissuing movement path') end
                                oPlatoon[refiCurrentAction] = refActionReissueMovementPath
                            end
                            oPlatoon[refbKitingLogicActive] = false
                        else
                            oPlatoon[refbKitingLogicActive] = true
                        end
                    end
                end
            end



            --ACU Overcharge logic (still OC if are running away):
            if oPlatoon[refbACUInPlatoon] == true then
                --bDebugMessages = true
                if bDebugMessages == true then LOG(sFunctionRef..' about to see if can overcharge') end
                --Assumes ACU will be in table of builders - check if only have 1, in which case should be ACU
                local oPlayerACU = M27Utilities.GetACU(aiBrain) --check in case ACU dies and causes crash
                if oPlatoon[reftBuilders][1] then if M27Conditions.CanUnitUseOvercharge(aiBrain, oPlatoon[reftBuilders][1]) == true then GetOverchargeExtraAction(aiBrain, oPlatoon, oPlatoon[reftBuilders][1]) end end
            end

            if bProceed == true and bDontConsiderFurtherOrders == false then
                --Have we recently given a move DF untis order? If so then dont override it for a while unless have reacehd destination as likely gave the order as were stuck
                if bDebugMessages == true then
                    if oPlatoon[refiEnemyStructuresInRange] > 0 then
                        LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': UpdatePlatoonActionForNearbyEnemies: EnemyStructuresInRange='..oPlatoon[refiEnemyStructuresInRange]..'; Platoon location='..oPlatoon:GetPlatoonPosition()[1]..'-'..oPlatoon:GetPlatoonPosition()[3]..'; location of first enemy structure='..oPlatoon[reftEnemyStructuresInRange][1]:GetPosition()[1]..'-'..oPlatoon[reftEnemyStructuresInRange][1]:GetPosition()[3])
                        LOG('Distance to nearest structure='..M27Utilities.GetDistanceBetweenPositions(oPlatoon:GetPlatoonPosition(), oPlatoon[reftEnemyStructuresInRange][1]:GetPosition()))
                        LOG('Platoon max range='..M27Logic.GetUnitMaxGroundRange(oPlatoon[reftCurrentUnits]))
                    end
                end


                local bDontChangeCurrentAction = false
                if not(oPlatoon[reftPrevAction][10] == nil) then
                    if oPlatoon[reftPrevAction][1] == refActionMoveDFToNearestEnemy then
                        bDontChangeCurrentAction = true
                        for iPrevAction = 1, 10 do
                            if not(oPlatoon[reftPrevAction][iPrevAction] == refActionMoveDFToNearestEnemy) then
                                --Haven't been targetting DF for 10 cycles yet, so dont change
                                break
                            end
                            if iPrevAction == 10 then
                                --Have been targetting DF for 10 cycles now
                                bDontChangeCurrentAction = false
                            end
                        end
                        if bDontChangeCurrentAction == false then
                            --Check if have reached the target:
                            local tDFUnits = EntityCategoryFilterDown(categories.DIRECTFIRE, oPlatoon[reftCurrentUnits])
                            if tDFUnits == nil then bDontChangeCurrentAction = false
                            else
                                if table.getn(tDFUnits) == 0 then bDontChangeCurrentAction = false
                                else
                                    if M27Utilities.GetDistanceBetweenPositions(M27Utilities.GetAveragePosition(tDFUnits), oPlatoon[reftTemporaryMoveTarget]) <= 10 then bDontChangeCurrentAction = false end
                                end
                            end
                        end
                    end
                end



                --=======normal determining action for enemies
                if bDontChangeCurrentAction == false then
                    if oPlatoon[refbACUInPlatoon] == true and oPlatoon[refiEnemiesInRange] > 0 then
                        oPlatoon[refiCurrentAction] = refActionAttack
                    else

                        if sPlatoonName == 'M27AttackNearestUnits' then
                            --Dont care about threat etc. with this AI - just attack:
                            oPlatoon[refiCurrentAction] = refActionAttack
                        else
                            --(no longer assume will lose if more enemies as might have ACU in platoon)
                            --                  if oPlatoon[refiEnemiesInRange] - oPlatoon[refiCurrentUnits] <= 5 or oPlatoon[refiEnemiesInRange] <= oPlatoon[refiCurrentUnits]*1.5 then
                            --Are we likely to win a battle? consider all units near platoon position
                            local iOurThreatRating = M27Logic.GetCombatThreatRating(aiBrain, oPlatoon[reftFriendlyNearbyUnits], false)
                            local iMassValueOfBlipsOverride = nil
                            if oPlatoon[refiEnemiesInRange] <= 5 then iMassValueOfBlipsOverride = 8 end
                            local iEnemyThreatRating = 0
                            if oPlatoon[refiEnemiesInRange] > 0 then iEnemyThreatRating = iEnemyThreatRating + M27Logic.GetCombatThreatRating(aiBrain, oPlatoon[reftEnemiesInRange], true, iMassValueOfBlipsOverride) end
                            if oPlatoon[refiEnemyStructuresInRange] > 0 then iEnemyThreatRating = iEnemyThreatRating + M27Logic.GetCombatThreatRating(aiBrain, oPlatoon[reftEnemyStructuresInRange], true) end

                            if iOurThreatRating * 0.95 >= iEnemyThreatRating then
                                bWillWinAttack = true
                                if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': UpdateActionForNearbyEnemies - our threat is better than theirs; iEnemyThreatRating='..iEnemyThreatRating..'; iOurThreatRating='..iOurThreatRating) end
                            end
                            --end
                            if bWillWinAttack == true then
                                --Check aren't already running away from a threat (and we think we'll win just because some of enemy have dropped out of intel range
                                if oPlatoon[refbHavePreviouslyRun] == true then
                                    --we've previously run away - check how recently:
                                    local iMaxCyclesToCheck = 20
                                    local iCyclesToCheck = table.getn(oPlatoon[reftPrevAction])
                                    if iCyclesToCheck >= 1 then
                                        for iRunCycle = 1, iCyclesToCheck do
                                            if not(oPlatoon[reftPrevAction][iRunCycle] == nil) then
                                                if oPlatoon[reftPrevAction][iRunCycle] == refActionRun then
                                                    bHaveRunRecently = true
                                                    break
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                            if bWillWinAttack == true then
                                if bHaveRunRecently == false then
                                    if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': UpdateActionForNearbyEnemies - will win attack and havent previously run') end
                                    --Large attack AI - Check we're not about to run after a small number of units with a massive attack force
                                    if sPlatoonName == 'M27LargeAttackForce' then
                                        local bDontChaseEnemy = false
                                        if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': UpdateActionForNearbyEnemies - Large attack so considering if small number of enemies nearby') end
                                        if oPlatoon[refiCurrentUnits] >= 10 then
                                            if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': UpdateActionForNearbyEnemies - Large attack AI - we have at least 10 units') end
                                            if oPlatoon[refiEnemyStructuresInRange] == 0 then
                                                if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': UpdateActionForNearbyEnemies - Large attack AI - no structures in range') end
                                                if oPlatoon[refiEnemiesInRange] <= 3 then
                                                    if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': UpdateActionForNearbyEnemies - Large attack AI - <=3 enemy units') end
                                                    --Only 3 mobile enemies and no structures in range, and we have a large attack force; check if we're faster
                                                    local iPossibleEnemySpeed = M27Logic.GetUnitMinSpeed(oPlatoon[reftEnemiesInRange], aiBrain, true)
                                                    if iPossibleEnemySpeed == nil then
                                                        --Dont know how fast any of the enemy is, so dont chase
                                                        bDontChaseEnemy = true
                                                        if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': UpdateActionForNearbyEnemies - Large attack AI - dont know enemy speed, wont chase') end
                                                    else
                                                        local iOurMinSpeed = M27Logic.GetUnitMinSpeed(oPlatoon[reftCurrentUnits], aiBrain, false)
                                                        if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': UpdateActionForNearbyEnemies - Large attack AI - Know enemy speed, iOurMinSpeed='..iOurMinSpeed..'; iPossibleEnemySpeed='..iPossibleEnemySpeed) end
                                                        if iOurMinSpeed < iPossibleEnemySpeed then bDontChaseEnemy = true end
                                                    end
                                                end
                                            end
                                        end
                                        if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': UpdateActionForNearbyEnemies - Large attack AI - bDontChaseEnemy='..tostring(bDontChaseEnemy)) end
                                        if bDontChaseEnemy == false then oPlatoon[refiCurrentAction] = refActionAttack end
                                    else
                                        --Raider AI - dont want to attack structures unless we're a larger raiding group since will spend too long trying to kill a mex
                                        if sPlatoonName == 'M27MexRaiderAI' then
                                            if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': MexRaider custom: refiCurrentUnits='..oPlatoon[refiCurrentUnits]) end
                                            if oPlatoon[refiCurrentUnits] >= 5 then
                                                oPlatoon[refiCurrentAction] = refActionAttack
                                            else --Smaller platoon, so only attack mobile enemies and not structures:
                                                if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': Checking if are enemies in range') end
                                                if oPlatoon[refiEnemiesInRange] > 0 then
                                                    if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': UpdateActionForNearbyEnemies iEnemiesInRange='..oPlatoon[refiEnemiesInRange]) end
                                                    oPlatoon[refiCurrentAction] = refActionAttack
                                                end
                                            end
                                        else
                                            --Other attack AI - just attack enemy if we'll win (dont worry about chasing small groups)
                                            oPlatoon[refiCurrentAction] = refActionAttack
                                        end
                                    end
                                else
                                    --Do nothing - will already have assigned a run away command in a previous cycle, dont need to change things now
                                end
                            else
                                --Will lose attack - run
                                oPlatoon[refiCurrentAction] = refActionRun
                            end
                        end
                    end
                end
            end
        end
    else
        oPlatoon[refiPrevNearestEnemyDistance] = nil
    end
end

function RecordPlatoonUnitsByType(oPlatoon)
    --Update oPlatoon's unittable and count variables

    local bDebugMessages = false
    local sFunctionRef = 'RecordPlatoonUnitsByType'
    --if oPlatoon:GetPlan() == 'M27ACUMain' then bDebugMessages = true end
    if bDebugMessages == true then LOG(oPlatoon:GetPlan()..oPlatoon[refiPlatoonCount]..':RecordPlatoonUnitsByType start') end
    --store previous number for current units (for efficiency purposes):
    if oPlatoon[refiCurrentUnits] == nil then oPlatoon[refiCurrentUnits] = 0 end
    oPlatoon[refiPrevCurrentUnits] = oPlatoon[refiCurrentUnits]
    --Update list of current units:
    oPlatoon[reftCurrentUnits] = oPlatoon:GetPlatoonUnits()
    if oPlatoon[reftCurrentUnits] == nil then
        oPlatoon[refiCurrentUnits] = 0
        oPlatoon[refbACUInPlatoon] = false
    else
        local tACUs = EntityCategoryFilterDown(categories.COMMAND, oPlatoon[reftCurrentUnits])
        oPlatoon[refbACUInPlatoon] = not(M27Utilities.IsTableEmpty(tACUs))
        oPlatoon[refiCurrentUnits] = table.getn(oPlatoon[reftCurrentUnits])
        --Update list of units by type if current unit number has changed:
        local bUpdateByUnitType = false
        if oPlatoon[refiPrevCurrentUnits] == nil then bUpdateByUnitType = true
        elseif not(oPlatoon[refiPrevCurrentUnits] == oPlatoon[refiCurrentUnits]) then bUpdateByUnitType = true end
        if bUpdateByUnitType == true then
            if bDebugMessages == true then LOG(sFunctionRef..': Refreshing details of units in platoon as the number of units has changed') end
            if oPlatoon[refiPrevCurrentUnits] < oPlatoon[refiCurrentUnits] then
                if bDebugMessages == true then LOG(sFunctionRef..': Units in platoon has increased so refreshing platoon action') end
                oPlatoon[refbForceActionRefresh] = true end
            oPlatoon[reftDFUnits] = EntityCategoryFilterDown(categories.DIRECTFIRE - categories.SCOUT, oPlatoon[reftCurrentUnits])
            oPlatoon[reftScoutUnits] = EntityCategoryFilterDown(categories.SCOUT, oPlatoon[reftCurrentUnits])
            oPlatoon[reftIndirectUnits] = EntityCategoryFilterDown(categories.INDIRECTFIRE, oPlatoon[reftCurrentUnits])
            oPlatoon[reftBuilders] = EntityCategoryFilterDown(categories.CONSTRUCTION, oPlatoon[reftCurrentUnits])
            oPlatoon[reftReclaimers] = EntityCategoryFilterDown(categories.RECLAIM, oPlatoon[reftCurrentUnits])
            if oPlatoon[reftDFUnits] == nil then oPlatoon[refiDFUnits] = 0
            else oPlatoon[refiDFUnits] = table.getn(oPlatoon[reftDFUnits]) end
            if oPlatoon[reftScoutUnits] == nil then oPlatoon[refiScoutUnits] = 0
            else oPlatoon[refiScoutUnits] = table.getn(oPlatoon[reftScoutUnits]) end
            if oPlatoon[reftIndirectUnits] == nil then oPlatoon[refiIndirectUnits] = 0
            else oPlatoon[refiIndirectUnits] = table.getn(oPlatoon[reftIndirectUnits]) end
            if oPlatoon[reftBuilders] == nil then oPlatoon[refiBuilders] = 0
            else oPlatoon[refiBuilders] = table.getn(oPlatoon[reftBuilders]) end
            if oPlatoon[reftReclaimers] == nil then oPlatoon[refiReclaimers] = 0
            else oPlatoon[refiReclaimers] = table.getn(oPlatoon[reftReclaimers]) end

            --Does the platoon contain underwater or overwater land units? (for now assumes will only have 1 or the other)
            if oPlatoon[refiCurrentUnits] > 0 then
                local sPathingType = M27Utilities.GetUnitPathingType(GetPathingUnit(oPlatoon))
                oPlatoon[refbPlatoonHasUnderwaterLand] = false
                oPlatoon[refbPlatoonHasOverwaterLand] = false
                if sPathingType == M27Utilities.refPathingTypeAmphibious then
                    for iUnit, oUnit in oPlatoon[reftCurrentUnits] do
                        if M27Utilities.IsUnitUnderwaterAmphibious(oUnit) == true then
                            oPlatoon[refbPlatoonHasUnderwaterLand] = true
                            break
                        else
                            oPlatoon[refbPlatoonHasOverwaterLand] = true
                            break
                        end
                    end
                end
            end
            if bDebugMessages == true then LOG(oPlatoon:GetPlan()..oPlatoon[refiPlatoonCount]..': iBuilders='..oPlatoon[refiBuilders]..'; iReclaimers='..oPlatoon[refiReclaimers]) end
        end
    end
    if bDebugMessages == true then LOG(oPlatoon:GetPlan()..oPlatoon[refiPlatoonCount]..'RecordPlatoonUnitsByType: end of code; iCurrentUnits='..oPlatoon[refiCurrentUnits]..'; iDFUnits='..oPlatoon[refiDFUnits]..'; iScouts='..oPlatoon[refiScoutUnits]..'; iArti='..oPlatoon[refiIndirectUnits]) end
    if bDebugMessages == true then
        if oPlatoon[reftReclaimers] == nil then LOG('tReclaimers is nil')
        else LOG('tReclaimers size='..table.getn(oPlatoon[reftReclaimers])) end
        if oPlatoon[reftBuilders] == nil then LOG('tReclaimers is nil')
            else LOG('tBuilders size='..table.getn(oPlatoon[reftBuilders])) end
    end
end

function DetermineActionForNearbyMex(oPlatoon)
    --Double-check we can still build a mex
    local bDebugMessages = false
    local sFunctionRef = 'DetermineActionForNearbyMex'
    if bDebugMessages == true then LOG(sFunctionRef..': About to check have builders in platoon and get first builder') end
    if oPlatoon[refiBuilders] > 0 then
        local oFirstBuilder
        for _, oBuilder in oPlatoon[reftBuilders] do
            if not(oBuilder.Dead) then
                oFirstBuilder = oBuilder break
            end
        end
        if not(oFirstBuilder==nil) then
            --Are there any unclaimed mexes nearby:
            --GetNearestMexToUnit(oBuilder, bCanBeBuiltOnByAlly, bCanBeBuiltOnByEnemy, iBuildRangeMod)
            local tNearbyMex = M27MapInfo.GetNearestMexToUnit(oFirstBuilder, false, false, M27Overseer.iACUMaxTravelToNearbyMex) --allows a slight detour from current position
            if bDebugMessages == true then
                if M27Utilities.IsTableEmpty(tNearbyMex) then LOG(sFunctionRef..': tNearbyMex is empty')
                    else LOG(sFunctionRef..': tNearbyMex='..repr(tNearbyMex)) end
            end
            if M27Utilities.IsTableEmpty(tNearbyMex) == false then
                oPlatoon[refiCurrentAction] = refActionBuildMex
                if oPlatoon[reftNearbyMexToBuildOn] == nil then oPlatoon[reftNearbyMexToBuildOn] = {} end
                oPlatoon[reftNearbyMexToBuildOn] = tNearbyMex
                if bDebugMessages == true then LOG(sFunctionRef..': Have updated for nearby mex='..repr(oPlatoon[reftNearbyMexToBuildOn])) end
                end
        else
            oPlatoon[refiBuilders] = 0
        end
    end
end

function DetermineActionForNearbyHydro(oPlatoon)
    --Tries to assist any hydro being constructed
    local bDebugMessages = false
    local sFunctionRef = 'DetermineActionForNearbyHydro'
    local iMaxDistanceToMove = M27Overseer.iACUMaxTravelToNearbyMex
    if bDebugMessages == true then LOG(sFunctionRef..': About to check have builders in platoon and get first builder') end
    if oPlatoon[refiBuilders] > 0 then
        local oFirstBuilder
        for _, oBuilder in oPlatoon[reftBuilders] do
            if not(oBuilder.Dead) then
                oFirstBuilder = oBuilder break
            end
        end
        if not(oFirstBuilder==nil) then
            --Are there any Hydro buildings nearby:

            --GetNearestMexToUnit(oBuilder, bCanBeBuiltOnByAlly, bCanBeBuiltOnByEnemy, iBuildRangeMod)
            local aiBrain = oFirstBuilder:GetAIBrain()
            local iBuildDistance = oFirstBuilder:GetBlueprint().Economy.MaxBuildDistance
            local tNearbyHydro = aiBrain:GetUnitsAroundPoint(categories.HYDROCARBON, oFirstBuilder:GetPosition(), iMaxDistanceToMove + iBuildDistance, 'Ally')
            if bDebugMessages == true then LOG(sFunctionRef..': Have a builder, seeing if nearby hydro') end
            if M27Utilities.IsTableEmpty(tNearbyHydro) == false then
                --Is this an ACU that has the gun?
                if bDebugMessages == true then LOG(sFunctionRef..': Have a nearby hydro, seeing if ACU has gun') end
                if oFirstBuilder == M27Utilities.GetACU(aiBrain) and M27Conditions.DoesACUHaveGun(aiBrain, true) == true then
                    --do nothing
                else
                    --Is the building still being constructed?
                    local oHydro = tNearbyHydro[1]
                    if oHydro.GetFractionComplete then
                        local iFractionComplete = oHydro:GetFractionComplete()
                        if bDebugMessages == true then LOG(sFunctionRef..': iFractionComplete='..iFractionComplete) end
                        if iFractionComplete < 1 and iFractionComplete > 0 then
                            if bDebugMessages == true then LOG(sFunctionRef..': Building started but not complete, assigning action') end
                            oPlatoon[refiCurrentAction] = refActionAssistConstruction
                            if oPlatoon[refoConstructionToAssist] == nil then oPlatoon[refoConstructionToAssist] = {} end
                            oPlatoon[refoConstructionToAssist] = oHydro
                        end
                    end
                end
            end
        else
            oPlatoon[refiBuilders] = 0
        end
    end
end

function DetermineActionForNearbyReclaim(oPlatoon)
    local bDebugMessages = false
    local sFunctionRef = 'DetermineActionForNearbyReclaim'
    if oPlatoon[refiReclaimers] > 0 then
        --Check we aren't full with mass
        local aiBrain = oPlatoon:GetBrain()
        local iSpareStorage = (1 - aiBrain:GetEconomyStoredRatio('MASS')) * aiBrain:GetEconomyStored('MASS')
        if iSpareStorage > 1 then --In some cases will want to finish reclaiming if are already reclaiming
            if bDebugMessages == true then LOG(sFunctionRef..': About to get first unit with reclaim function') end
            if oPlatoon[refoNearbyReclaimTarget] == nil then oPlatoon[refoNearbyReclaimTarget] = {} end
            local oFirstReclaimer
            for _, oReclaimer in oPlatoon[reftReclaimers] do
                if not(oReclaimer.Dead) then
                    oFirstReclaimer = oReclaimer break
                end
            end
            if not(oFirstReclaimer==nil) then
                local oReclaimerBP = oFirstReclaimer:GetBlueprint()

                local iBuildDistance = oReclaimerBP.Economy.MaxBuildDistance
                if iBuildDistance <= 5 then iBuildDistance = 5 end
                if bDebugMessages == true then LOG(sFunctionRef..': Found a reclaimer, about to locate any nearby reclaim; iBuildDistance='..iBuildDistance) end
                --Do we already have a reclaim target that we're reclaiming?
                local bAlreadyHaveValidTarget = false
                local bHaveValidTarget = false
                local oReclaimTarget
                local tReclaimLocation = {}

                if oFirstReclaimer:IsUnitState('Reclaiming') == true then
                    oReclaimTarget = oPlatoon[refoNearbyReclaimTarget]
                    if not(oReclaimTarget == nil) then
                        if oReclaimTarget.MaxMassReclaim > 0 then
                            tReclaimLocation = oReclaimTarget.CachePosition
                            if M27Utilities.IsTableEmpty(tReclaimLocation) == false then
                                if M27Utilities.GetDistanceBetweenPositions(tReclaimLocation, oFirstReclaimer:GetPosition()) <= iBuildDistance then
                                    bAlreadyHaveValidTarget = true
                                    bHaveValidTarget = true
                                end
                            end
                        end
                    end
                end

                if bAlreadyHaveValidTarget == false then
                    --GetNearestReclaim(tLocation, iSearchRadius, iMinReclaimValue)
                    oReclaimTarget = M27MapInfo.GetNearestReclaim(oPlatoon:GetPlatoonPosition(), iBuildDistance, 10)
                    if not(oReclaimTarget == nil) then
                        if bDebugMessages == true then LOG(sFunctionRef..': Found a reclaim target, changing action') end
                        oPlatoon[refoNearbyReclaimTarget] = oReclaimTarget
                        bHaveValidTarget = true
                    end
                end
                if bHaveValidTarget == true then
                    local bWillOverflowMass = false
                    --Are we overflowing mass (or about to)?
                    --Get reclaim rate: From testing looks like the reclaim per second is roughly 5 * build power
                    local iBuildPower = oReclaimerBP.Economy.BuildRate
                    if iBuildPower == nil then iBuildPower = 5 end
                    local iReclaimRate = 5 * iBuildPower
                    local iMassReclaimed = math.min(oPlatoon[refoNearbyReclaimTarget].MaxMassReclaim, iReclaimRate)
                    if bDebugMessages == true then LOG(sFunctionRef..': Considering if will overflow mass, iReclaimRate='..iReclaimRate..'; iMassReclaimed='..iMassReclaimed..'; iBuildPower='..iBuildPower..'; iSpareStorage='..iSpareStorage) end
                    if bAlreadyHaveValidTarget == true then
                        --Finish reclaim unless >=5 mass wasted
                        if iMassReclaimed > (iSpareStorage + 5) then bWillOverflowMass = true end
                    else
                        if iMassReclaimed > iSpareStorage then bWillOverflowMass = true end
                    end
                    if bWillOverflowMass == false then
                        if bDebugMessages == true then LOG(sFunctionRef..': wont overflow mass so proceed with reclaim') end
                        oPlatoon[refiCurrentAction] = refActionReclaimNearby
                    else
                        if bDebugMessages == true then LOG(sFunctionRef..': Will overflow mass so wont issue action to reclaim') end
                        oPlatoon[refoNearbyReclaimTarget] = nil
                    end
                end
            else
                oPlatoon[refiReclaimers] = 0
            end
        end
    end
end

function DeterminePlatoonAction(oPlatoon)
    --Record current action as previous action
    local bDebugMessages = false
    --if oPlatoon[refbACUInPlatoon] == true then bDebugMessages = true end
    --if oPlatoon[refbOverseerAction] == true then bDebugMessages = true end
    if oPlatoon and oPlatoon.GetBrain then
        local aiBrain = oPlatoon:GetBrain()
        if aiBrain and aiBrain.PlatoonExists and aiBrain:PlatoonExists(oPlatoon) then
            local sPlatoonName = oPlatoon:GetPlan()
            --if sPlatoonName == 'M27ACUMain' then bDebugMessages = true end
            --if sPlatoonName == 'M27DefenderAI' then bDebugMessages = true end
            --if sPlatoonName == 'M27MexRaiderAI' then bDebugMessages = true end
            --if sPlatoonName == 'M27ScoutAssister' then bDebugMessages = true end
            --if sPlatoonName == M27Overseer.sIntelPlatoonRef then bDebugMessages = true end
            --if oPlatoon:GetPlan() == 'M27MAAAssister' then bDebugMessages = true end
            if bDebugMessages == true then LOG('DeterminePlatoonAction: Start of code') end
            if not(oPlatoon[reftPrevAction][15]==nil) then table.remove(oPlatoon[reftPrevAction], 15) end
            if not(oPlatoon[refiCurrentAction] == nil) then
                if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': DeterminePlatoonAction: Current action isnt nil') end
                if oPlatoon[reftPrevAction] == nil then
                    if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': DeterminePlatoonAction: Prev action table is completely nil so setting it equal to current action') end
                    oPlatoon[reftPrevAction] = {oPlatoon[refiCurrentAction]}
                    if oPlatoon[reftPrevAction] == nil then
                        if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': DeterminePlatoonAction: Prev action table is still completely nil') end
                    end
                else
                    if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': DeterminePlatoonAction: Inserting new prev action into table; action to insert='..oPlatoon[refiCurrentAction]) end
                    table.insert(oPlatoon[reftPrevAction], 1, oPlatoon[refiCurrentAction])
                end
            else --Dont have a current action so won't make any change; set prev action to whatever was there before
                --Exception - have added in override to make current action nil if it was continue movement path and prev action was new movement path; therefore set prev action to continuemovementpath
                if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': DeterminePlatoonAction: Current action is nil') end
                if not(oPlatoon[reftPrevAction] == nil) then
                    if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': DeterminePlatoonAction: No change to preva ction, inserting the prev action to itself; Action to insert='..oPlatoon[reftPrevAction][1]) end
                    if oPlatoon[reftPrevAction][1] == refActionNewMovementPath then
                        table.insert(oPlatoon[reftPrevAction], 1, refActionContinueMovementPath)
                    else
                        table.insert(oPlatoon[reftPrevAction], 1, oPlatoon[reftPrevAction][1])
                    end

                    if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': DeterminePlatoonAction: No change to preva ction, inserting the prev action to itself; Finished inserting='..oPlatoon[reftPrevAction][1]) end
                end
            end
            --[[if bDebugMessages == true then
                if oPlatoon[reftPrevAction] == nil then
                    LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': DeterminePlatoonAction: Prev Action is nil')
                else
                    LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': DeterminePlatoonAction: Prev Action is now '..oPlatoon[reftPrevAction][1])
                    if table.getn(oPlatoon[reftPrevAction]) > 1 then
                        LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': DeterminePlatoonAction: total prev actions='..table.getn(oPlatoon[reftPrevAction]))
                        if oPlatoon[reftPrevAction][2] == nil then
                            LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': DeterminePlatoonAction: 2nd prev action is nil')
                        else
                            LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': DeterminePlatoonAction: 2nd prev action is '..oPlatoon[reftPrevAction][2])
                        end
                    else
                        LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': DeterminePlatoonAction: Only 1 prev action exists')
                    end
                end
            end ]]--
            oPlatoon[refiCurrentAction] = nil
            oPlatoon[refiExtraAction] = nil
            --Setup:
            RecordPlatoonUnitsByType(oPlatoon)
            if oPlatoon[refiCurrentUnits] == 0 then
                if bDebugMessages == true then LOG('Warning - oPlatoon has nil units, so moving to action disband; Platoon ref='..sPlatoonName..oPlatoon[refiPlatoonCount]) end
                oPlatoon[refiCurrentAction] = refActionDisband
            else
                if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': platoon has units') end
                if M27Utilities.IsTableEmpty(oPlatoon[reftMovementPath]) then
                    oPlatoon[refiCurrentAction] = refActionNewMovementPath
                else
                    if M27Utilities.IsTableEmpty(oPlatoon[reftMovementPath][oPlatoon[refiCurrentPathTarget]]) == true then
                        if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': Current path target is nil, getting new movement path') end
                        oPlatoon[refiCurrentAction] = refActionNewMovementPath
                    else
                        --If ACU on low health then run
                        if oPlatoon[refbACUInPlatoon] == true then
                            --bDebugMessages = true
                            --Run back to base if low health; reset movement path if regained health
                            local iHealthPercentage = M27Utilities.GetACU(aiBrain):GetHealthPercent()
                            if iHealthPercentage <= 0.35 then
                                oPlatoon[refbNeedToHeal] = true
                                oPlatoon[refiCurrentAction] = refActionReturnToBase
                            end
                        end
                        if oPlatoon[refiCurrentAction] == nil then
                            --Apply overseer override action if there is one
                            if oPlatoon[refbOverseerAction] == true then
                                local bIgnoreOverseerOverride = false
                                oPlatoon[refbOverseerAction] = false
                                --first Check if reached final destination (in which case will ignore the override except for scouts)
                                if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': Overseer action active; checking if reached current or final destination') end
                                if HasPlatoonReachedDestination(oPlatoon) == true then
                                    if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': Overseer action active; Have reached current destination, considering if final') end
                                    if oPlatoon[refiCurrentPathTarget] > table.getn(oPlatoon[reftMovementPath]) then
                                        if sPlatoonName == M27Overseer.sIntelPlatoonRef then
                                            oPlatoon[refiCurrentPathTarget] = table.getn(oPlatoon[reftMovementPath])
                                        else
                                            if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': Overseer action active; Have reached final destination, getting completion action instead') end
                                            DeterminePlatoonCompletionAction(oPlatoon)
                                            bIgnoreOverseerOverride = true
                                        end
                                    end
                                end
                                if bIgnoreOverseerOverride == false then
                                    oPlatoon[refiCurrentAction] = oPlatoon[refiOverseerAction]
                                    if oPlatoon[refiCurrentAction] == nil then
                                        LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': Likely error - Platoon current action is still nil so override flag set without specifying action')
                                    else
                                        if bDebugMessages == true then LOG('Overseer action override: Platoon current action is:'..oPlatoon[refiCurrentAction]) end
                                    end
                                    --Get more refined enemy targetting commands:
                                    if oPlatoon[refiCurrentAction] == refActionAttack or oPlatoon[refiCurrentAction] == refActionMoveDFToNearestEnemy then
                                        local iPlatoonMaxRange = M27Logic.GetUnitMaxGroundRange(oPlatoon[reftCurrentUnits])
                                        local iEnemySearchRadius = iPlatoonMaxRange * 2 --Will consider responses if any enemies get within 2 times the max range of platoon
                                        GetNearbyEnemyData(oPlatoon, iEnemySearchRadius)
                                        local iOriginalAction = oPlatoon[refiCurrentAction]
                                        UpdatePlatoonActionForNearbyEnemies(oPlatoon)
                                        if oPlatoon[refiCurrentAction] == nil then oPlatoon[refiCurrentAction] = iOriginalAction end
                                    end
                                end
                            else
                                --Check not just had a platoon disband action (in which case wouldve been from other code):
                                if not(oPlatoon[reftPrevAction][1] == nil) then
                                    if oPlatoon[reftPrevAction][1] == refActionDisband then
                                        oPlatoon[refiCurrentAction] = refActionDisband
                                    end
                                end
                                if oPlatoon[refiCurrentAction] == nil then
                                    --Still have units in platoon; do basic setup for checks:
                                    local iPlatoonMaxRange = M27Logic.GetUnitMaxGroundRange(oPlatoon[reftCurrentUnits])
                                    local iEnemySearchRadius = iPlatoonMaxRange * 2 --Will consider responses if any enemies get within 2 times the max range of platoon
                                    if iEnemySearchRadius < 40 then iEnemySearchRadius = 40 end
                                    --Check this is also >= intel size:
                                    local iIntelRange = oPlatoon[reftCurrentUnits][1]:GetBlueprint().Intel.RadarRadius
                                    if iEnemySearchRadius < iIntelRange then iEnemySearchRadius = iIntelRange end
                                    GetNearbyEnemyData(oPlatoon, iEnemySearchRadius) --needed here for action if stuck to work

                                    --Go through action determinants in order of priority (highest priority first):
                                    --Check if platoon is stuck (unless are an intel platoon where would expect to be stationery)
                                    if not(sPlatoonName == M27Overseer.sIntelPlatoonRef) then UpdatePlatoonActionIfStuck(oPlatoon) end
                                    if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': Finished checking action for if stuck') end
                                    if oPlatoon[refiCurrentAction] == nil then
                                        UpdatePlatoonActionForNearbyEnemies(oPlatoon)
                                        if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': Finished getting action for nearby enemies') end
                                        if oPlatoon[refiCurrentAction] == nil then
                                            if not(sPlatoonName == M27Overseer.sIntelPlatoonRef) then --Dont want completion action for intel when it reaches the target path
                                                --Check for nearby reclaim and/or unclaimed mexes if are a builder platoon (e.g. ACU)
                                                if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': About to check action for nearby mex, oPlatoon[refbConsiderMexes]='..tostring(oPlatoon[refbConsiderMexes])) end
                                                if oPlatoon[refbConsiderMexes] == true then DetermineActionForNearbyMex(oPlatoon) end
                                                if oPlatoon[refiCurrentAction] == nil then
                                                    DetermineActionForNearbyHydro(oPlatoon)
                                                    if oPlatoon[refiCurrentAction] == nil then
                                                        if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': About to check action for nearby reclaim, oPlatoon[refbConsiderReclaim]='..tostring(oPlatoon[refbConsiderReclaim])) end
                                                        if oPlatoon[refbConsiderReclaim] == true then DetermineActionForNearbyReclaim(oPlatoon) end
                                                        if oPlatoon[refiCurrentAction] == nil then
                                                            --Check if have reached current or final destination (also update refiCurrentUnits and refiCurrentPathTarget):
                                                            if HasPlatoonReachedDestination(oPlatoon) == true then
                                                                if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': Platoon has reached current destination') end
                                                                --Check if reached final destination:
                                                                if oPlatoon[refiCurrentPathTarget] > table.getn(oPlatoon[reftMovementPath]) then
                                                                    if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': refiCurrentPathTarget='..oPlatoon[refiCurrentPathTarget]..'; movement path table size='..table.getn(oPlatoon[reftMovementPath])..'; have reached final destination') end
                                                                    DeterminePlatoonCompletionAction(oPlatoon) end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                            if oPlatoon[refiCurrentAction] == nil then
                                                --[[
                                                --Check if deviated from normal action previously and so now need to reset
                                                if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': no current action after cehcking if reached destination and for nearby enemies; will resume movement path') end
                                                if not(oPlatoon[reftPrevAction][1] == nil) then
                                                    if oPlatoon[reftPrevAction][1] == refActionAttack or oPlatoon[reftPrevAction][1] == refActionMoveDFToNearestEnemy then
                                                        --Were previously attacking; if no units nearby then cancel
                                                        if oPlatoon[refiEnemiesInRange] + oPlatoon[refiEnemyStructuresInRange] == 0 then
                                                            oPlatoon[refiCurrentAction] = refActionContinueMovementPath
                                                        end
                                                    end
                                                end ]]
                                                --If not stuck, no nearby enemies (that warrant an action) and not reached destination then continue movement path:
                                                oPlatoon[refiCurrentAction] = refActionContinueMovementPath

                                            end
                                        end
                                    else
                                        if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': Current actoin is:'..oPlatoon[refiCurrentAction]) end
                                    end
                                end
                            end
                        end
                    end
                end
            end




            --No need to re-issue command if just gave it (will refresh slower instead) - helps both with performance and to guard against stuttering:
            --DEBUG ONLY
            if bDebugMessages == true then
                LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': End of choosing action, will now ignore if action is unchanged from before')
                if oPlatoon[refiCurrentAction] == nil then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': iCurrentAction is nil')
                else LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': iCurrentAction='..oPlatoon[refiCurrentAction]) end

                if oPlatoon[reftPrevAction][1] == nil then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': 1st prev action is nil')
                else LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': 1st prev action='..oPlatoon[reftPrevAction][1]) end
            end

            local bRefreshAction = true
            --=======Ignore action in certain cases (e.g. we only just gave that action)
            if oPlatoon[reftPrevAction][1] == oPlatoon[refiCurrentAction] then
                if bDebugMessages == true then LOG('Prev action is same as current action, will set refreshaction to false unless due a refresh') end
                if oPlatoon[refiCurrentAction] == refActionContinueMovementPath then
                    --Don't refresh if are continuing movement path
                    bRefreshAction = false
                else
                    local bBuildingOrReclaimingLogic = false
                    --Building and reclaiming - base refresh on whether any units are building/reclaiming
                    if oPlatoon[refiCurrentAction] == refActionBuildMex or oPlatoon[refiCurrentAction] == refActionAssistConstruction then
                        bBuildingOrReclaimingLogic = true
                        bRefreshAction = true
                        if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': Checking if any buidlers ahve unit state building') end
                        for iBuilder, oBuilder in oPlatoon[reftBuilders] do
                            --Units can build something by 'repairing' it, so check for both unit states:
                            if oBuilder:IsUnitState('Building') == true or oBuilder:IsUnitState('Repairing') == true then
                                if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': Builder is building, so dont refresh action') end
                                bRefreshAction = false
                                break
                            elseif oBuilder:IsUnitState('Guarding') == true then
                                --might be assisting construction of a unit/building, or just assisting an engineer - bellow will jsut check for the former
                                if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': Builder is guarding - check the unit being guarded') end
                                if oBuilder.GetGuardedUnit then
                                    local oBeingBuilt = oBuilder:GetGuardedUnit()
                                    if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': Obtained valid reference to guarded unit') end
                                    if oBeingBuilt.GetFractionComplete then
                                        if oBeingBuilt:GetFractionComplete() < 1 then
                                            if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': Builder is assisting something that is being built, so dont refresh action') end
                                            bRefreshAction = false
                                            break
                                        end
                                    end
                                end
                            else
                                if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': Considering whether to ignore refresh - unit state='..M27Logic.GetUnitState(oBuilder)) end
                            end
                        end
                    end
                    if oPlatoon[refiCurrentAction] == refActionReclaimNearby then
                        bBuildingOrReclaimingLogic = true
                        bRefreshAction = true
                        for iReclaimer, oReclaimer in oPlatoon[reftReclaimers] do
                            if oReclaimer:IsUnitState('Reclaiming') == true then
                                bRefreshAction = false
                                break
                            end
                        end
                    end

                    if bRefreshAction == true then
                        --Refresh every 5 cycles:
                        if oPlatoon[refiRefreshActionCount] < 4 then bRefreshAction = false end

                        if bDebugMessages == true then
                            if oPlatoon[refiRefreshActionCount] == nil then oPlatoon[refiRefreshActionCount] = 0 end
                            LOG('RefreshCount='..oPlatoon[refiRefreshActionCount]..'; bRefreshAction='..tostring(bRefreshAction))
                        end
                    end
                end
            else
                if bDebugMessages == true then LOG('Prev action is different to current action, but will check if its continuing movement path just after new movement path') end
                --If have just issued a new movement path, should have sent the platoon along that new movement path, hence dont need to re-do if action is to continue movement path
                if oPlatoon[refiCurrentAction] == refActionContinueMovementPath then
                    if oPlatoon[reftPrevAction][1] == refActionNewMovementPath or oPlatoon[reftPrevAction][1] == refActionReissueMovementPath then
                        bRefreshAction = false
                    end
                end
            end

            --Check for forced refresh:
            if bRefreshAction == false then
                if oPlatoon[refbForceActionRefresh] == true then
                    if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': Forced refresh of platoon action activated') end
                    oPlatoon[refbForceActionRefresh] = false
                    oPlatoon[refiGameTimeOfLastRefresh] = GetGameTimeSeconds()
                    bRefreshAction = true
                end
            end


            --Action the decision on whether to refresh or not
            if bRefreshAction == true then
                oPlatoon[refiRefreshActionCount] = 0
                if oPlatoon[refiCurrentAction] == refActionContinueMovementPath then oPlatoon[refiCurrentAction] = refActionReissueMovementPath end
            else
                if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': DeterminePlatoonAction: Ignoring current action as is same as prev action so setting to nil') end
                oPlatoon[refiCurrentAction] = nil
                oPlatoon[refiRefreshActionCount] = oPlatoon[refiRefreshActionCount] + 1
            end



            if bDebugMessages == true then
                if oPlatoon[refiCurrentAction] == nil then
                    LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': DeterminePlatoonAction: End of code; refiCurrentAction=nil')
                else LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': DeterminePlatoonAction: End of code; refiCurrentAction='..oPlatoon[refiCurrentAction])
                end
                if oPlatoon[refiExtraAction] == nil then
                    LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..':DeterminePlatoonAction: End of code, refiExtraAction is nil')
                else LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..':DeterminePlatoonAction: End of code, refiExtraAction is '..oPlatoon[refiExtraAction])
                end
            end
        end
    end
end

function ReturnToBase(oPlatoon, iOnlyGoThisFarTowardsBase, bDontClearActions)
    --Resets movement path so it is only going to return to base (meaning it will be treated as reaching final destination when it gets there)
    --iOnlyGoThisFarTowardsBase - if nil then go all the way to base, otherwise go x distance from current position

    local bDebugMessages = false
    local sPlatoonName = oPlatoon:GetPlan()
    --if sPlatoonName == 'M27ScoutAssister' then bDebugMessages = true end
    local aiBrain = oPlatoon:GetBrain()
    local iArmyStartNumber = aiBrain.M27StartPositionNumber
    if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': 1s loop: Running away - moving to start position') end
    if bDontClearActions == nil then bDontClearActions = false end
    if bDontClearActions == false then IssueClearCommands(oPlatoon[reftCurrentUnits]) end
    oPlatoon:SetPlatoonFormationOverride('GrowthFormation')
    if sPlatoonName == 'M27AttackNearestUnits' then IssueAggressiveMove(oPlatoon[reftCurrentUnits], M27MapInfo.PlayerStartPoints[iArmyStartNumber])
    else
        if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': Sending MoveToLocation to player start') end
        --oPlatoon:MoveToLocation(M27MapInfo.PlayerStartPoints[iArmyStartNumber], false) end
        IssueMove(oPlatoon[reftCurrentUnits], M27MapInfo.PlayerStartPoints[iArmyStartNumber]) end
    oPlatoon[reftTemporaryMoveTarget] = {}
    oPlatoon[reftMovementPath] = {}
    if iOnlyGoThisFarTowardsBase == nil then
        if bDebugMessages == true then LOG(sPlatoonName..': Going to go all the way back to base') end
        oPlatoon[reftMovementPath][1] = M27MapInfo.PlayerStartPoints[iArmyStartNumber]
    else
        local tPlatoonPosition = oPlatoon:GetPlatoonPosition()
        local iDistToStart = M27Utilities.GetDistanceBetweenPositions(tPlatoonPosition, M27MapInfo.PlayerStartPoints[iArmyStartNumber])
        if bDebugMessages == true then LOG(sPlatoonName..': iDistToStart='..iDistToStart..'; iOnlyGoThisFarTowardsBase='..iOnlyGoThisFarTowardsBase) end
        if iOnlyGoThisFarTowardsBase >= iDistToStart then oPlatoon[reftMovementPath][1] = M27MapInfo.PlayerStartPoints[iArmyStartNumber]
        else
            --GetPositionNearTargetInSamePathingGroup(tStartPos, tTargetPos, iDistanceFromTarget, iAngleBase, oPathingUnit, iNearbyMethodIfBlocked, bTrySidePositions)
            --MoveTowardsTarget(tStartPos, tTargetPos, iDistanceToTravel, iAngle)
            local oPathingUnit = GetPathingUnit(oPlatoon)
            if oPathingUnit and not(oPathingUnit.Dead) then
                oPlatoon[reftMovementPath][1] = GetPositionNearTargetInSamePathingGroup(tPlatoonPosition, M27MapInfo.PlayerStartPoints[iArmyStartNumber], iDistToStart - iOnlyGoThisFarTowardsBase, 0, oPathingUnit, 1, true)
                --M27Utilities.MoveTowardsTarget(tPlatoonPosition, M27MapInfo.PlayerStartPoints[iArmyStartNumber], iOnlyGoThisFarTowardsBase, 0)
                if oPlatoon[reftMovementPath][1] == nil then oPlatoon[reftMovementPath][1] =  M27MapInfo.PlayerStartPoints[iArmyStartNumber] end
                if bDebugMessages == true then LOG(sPlatoonName..': Sent order to only go part of the way back towawrds base') end
            else
                if oPlatoon then oPlatoon[refiCurrentAction] = refActionDisband end
            end
        end
    end
    oPlatoon[refiCurrentPathTarget] = 1
    --oPlatoon[refiLastPathTarget] = 1
    --WaitSeconds(2)
end

function GetNewMovementPath(oPlatoon, bDontClearActions)
    --Sets the movement path variable for oPlatoon and then tells it to move along this
    --bDontClearActions: Set to true if want to add the movement actions to existing orders (e.g. if have issued secondary action such as overcharge)
    local bDebugMessages = false
    local sFunctionRef = 'GetNewMovementPath'
    local bPlatoonNameDisplay = false
    if ScenarioInfo.Options.AIPLatoonNameDebug == 'all' then bPlatoonNameDisplay = true end
    local sPlatoonName = oPlatoon:GetPlan()
    --if oPlatoon[refbACUInPlatoon] == true then bDebugMessages = true end
    --if sPlatoonName == 'M27ACUMain' then bDebugMessages = true end
    local aiBrain = oPlatoon:GetBrain()
    local bDisbandAsNoUnits = false
    local bDontActuallyMove = false
    oPlatoon[refiCurrentPathTarget] = 1 --Redundancy, think put this elsewhere as well
    --If have ACU in the platoon then remove it unless its the ACU platoon
    if bPlatoonNameDisplay == true then UpdatePlatoonName(oPlatoon, sPlatoonName..oPlatoon[refiPlatoonCount]..': refActionNewMovementPath') end
    if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': GettingNewMovementPath') end

    local bDontGetNewPath = false
    if M27Utilities.IsTableEmpty(oPlatoon[reftMovementPath]) == true then
        if oPlatoon[reftMovementPath] == nil then oPlatoon[reftMovementPath] = {} end
        if oPlatoon[reftMovementPath][1] == nil then oPlatoon[reftMovementPath][1] = {} end
    else
        --Have we already got a movement path and no previous action (e.g. defender platoon created and assigned its movement path)
        if M27Utilities.IsTableEmpty(oPlatoon[reftPrevAction]) == true then
            bDontGetNewPath = true
            oPlatoon[refiCurrentAction] = refActionReissueMovementPath
            if bDebugMessages == true then LOG(sFunctionRef..':'..sPlatoonName..oPlatoon[refiPlatoonCount]..': Have no prev action and ahve a valid movement path='..repr(oPlatoon[reftMovementPath])) end
        end
    end

    if bDontGetNewPath == false then
        if sPlatoonName == 'M27LargeAttackForce' then
            --Choose mex in enemy base as the end destination
            oPlatoon[reftMovementPath] = M27Logic.GetMexRaidingPath(oPlatoon, 0, 15, 50, true)
            --oPlatoon[refiLastPathTarget] = table.getn(oPlatoon[reftMovementPath])
        elseif sPlatoonName == 'M27AttackNearestUnits' then
            local iEnemyStartNumber = M27Logic.GetNearestEnemyStartNumber(aiBrain)
            if iEnemyStartNumber == nil then
                LOG(sFunctionRef..':'..sPlatoonName..': EnemyStartNumber=nil, ERROR unless enemy dead')
                oPlatoon[reftMovementPath][1] = M27MapInfo.PlayerStartPoints[aiBrain.M27StartPositionNumber]
            else
                local tTargetBase = M27MapInfo.PlayerStartPoints[iEnemyStartNumber]
                if oPlatoon[reftMovementPath][1] == tTargetBase then
                    --Already targeting nearest enemy - go back to own base instead
                    oPlatoon[reftMovementPath][1] = M27MapInfo.PlayerStartPoints[aiBrain.M27StartPositionNumber]
                else
                    oPlatoon[reftMovementPath][1] = tTargetBase
                end
            end
            oPlatoon[refiCurrentPathTarget] = 1
            --oPlatoon[refiLastPathTarget] = 1
        elseif sPlatoonName == M27Overseer.sIntelPlatoonRef then
            --Overseer sets movement path for itnel platoons, so just set initial move position to current position if this is called
            if M27Utilities.IsTableEmpty(oPlatoon[reftMovementPath][1]) == true then
                oPlatoon[reftMovementPath][1] = oPlatoon:GetPlatoonPosition()
            end
        elseif sPlatoonName == 'M27ScoutAssister' or sPlatoonName == 'M27MAAAssister' then
            RefreshSupportPlatoonMovementPath(oPlatoon)

        elseif sPlatoonName == 'M27ACUMain' or sPlatoonName == 'M27AssistHydroEngi' then
            if bDebugMessages == true then LOG(sFunctionRef..': setting new movement path for M27ACUMain') end
            --Do we want to assist a hydro?
            local bMoveToHydro = false
            --Check if is a hydro near the ACU
            if M27Conditions.ACUShouldAssistEarlyHydro(aiBrain) == true then
                --Do we have power already? Check have >= 10 per tick (so 100)
                if aiBrain:GetEconomyIncome('ENERGY') <= 10 then
                    bMoveToHydro = true
                end
            end
            if bDebugMessages == true then LOG(sFunctionRef..': '..sPlatoonName..': bMoveToHydro='..tostring(bMoveToHydro)) end
            if bMoveToHydro == true then
                --Get nearest hydro location:
                local tNearestHydro = {}
                local iMinHydroDistance = 1000
                local iCurHydroDistance
                for iHydro, tHydroPos in M27MapInfo.HydroPoints do
                    iCurHydroDistance = M27Utilities.GetDistanceBetweenPositions(tHydroPos, oPlatoon:GetPlatoonPosition())
                    if iCurHydroDistance < iMinHydroDistance then
                        tNearestHydro = tHydroPos
                        iMinHydroDistance = iCurHydroDistance
                    end
                end
                --Are we already in range of the hydro? If so then wait 5 ticks
                local iBuildDistance = M27Utilities.GetACU(aiBrain):GetBlueprint().Economy.MaxBuildDistance
                if iMinHydroDistance <= (iBuildDistance + M27Utilities.GetBuildingSize('UAB1102')[1]*0.5) then
                    WaitTicks(5)
                    if oPlatoon then oPlatoon[refiCurrentAction] = refActionDisband end
                    bDontActuallyMove = true

                else
                    oPlatoon[reftMovementPath] = {}
                    oPlatoon[reftMovementPath][1] = {}

                    if bDebugMessages == true then LOG(sFunctionRef..': '..sPlatoonName..': about to call MoveNearConstruction') end
                    --MoveNearConstruction(aiBrain, oBuilder, tLocation, sBlueprintID, iBuildDistanceMod, bReturnMovePathInstead, bUpdatePlatoonMovePath, bReturnNilIfAlreadyMovingNearConstruction)
                    oPlatoon[reftMovementPath][1] = MoveNearConstruction(aiBrain, M27Utilities.GetACU(aiBrain), tNearestHydro, 'UAB1102', 0, true, false, false)
                    if bDebugMessages == true then LOG(sFunctionRef..': '..sPlatoonName..': Moving to hydro, reftMovementPath='..repr(oPlatoon[reftMovementPath])..'; platoon position='..repr(oPlatoon:GetPlatoonPosition())) end
                end
            else
                --Are we before the gun upgrade? then Choose priority expansion target
                if M27Conditions.DoesACUHaveGun(aiBrain, true) == false then
                    oPlatoon[reftMovementPath] = M27Logic.GetPriorityExpansionMovementPath(aiBrain, GetPathingUnit(oPlatoon))
                    if oPlatoon[reftMovementPath] == nil then refiCurrentAction = refActionDisband end
                    if bDebugMessages == true then LOG(sFunctionRef..': '..sPlatoonName..': Expanding, reftMovementPath='..repr(oPlatoon[reftMovementPath])..'; platoon position='..repr(oPlatoon:GetPlatoonPosition())) end
                else
                    --Get enemy base
                    local iEnemyStartNumber = M27Logic.GetNearestEnemyStartNumber(aiBrain)
                    if iEnemyStartNumber == nil then
                        LOG(sFunctionRef..': ERROR unless enemy dead as iEnemyStartNumber is nil')
                        oPlatoon[reftMovementPath][1] = M27MapInfo.PlayerStartPoints[aiBrain.M27StartPositionNumber]
                    else
                        local tTargetBase = M27MapInfo.PlayerStartPoints[M27Logic.GetNearestEnemyStartNumber(aiBrain)]
                        local bSwitchToHome = false
                        if oPlatoon[reftMovementPath][1] == tTargetBase then
                            --Already targeting nearest enemy - if we're within 5 of it then go back to own base instead
                            if M27Utilities.GetDistanceBetweenPositions(tTargetBase, M27Utilities.GetACU(aiBrain):GetPosition()) <= 5 then bSwitchToHome = true end
                        end
                        if bSwitchToHome == true then oPlatoon[reftMovementPath][1] = M27MapInfo.PlayerStartPoints[aiBrain.M27StartPositionNumber]
                        else oPlatoon[reftMovementPath][1] = tTargetBase
                        end
                    end
                    oPlatoon[refiCurrentPathTarget] = 1
                end
            end
        else
            local oACU = M27Utilities.GetACU(aiBrain)
            if sPlatoonName == M27Overseer.sDefenderPlatoonRef then
                --Check if contains ACU in platoon, and if so then remove unless this is the first action of the platoon:
                local bACUInPlatoon = false
                for _, oUnit in oPlatoon:GetPlatoonUnits() do
                    if oUnit == oACU then bACUInPlatoon = true break end
                end
                if bACUInPlatoon == true then
                    if M27Utilities.IsTableEmpty(oPlatoon[reftPrevAction]) == false then
                        if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': Removing ACU as are about to issue new movement path for defender AI') end
                        if bDebugMessages == true then if M27Utilities.IsTableEmpty(oPlatoon[reftPrevAction]) == true then LOG(sFunctionRef..':'..sPlatoonName..': Platoon has no previous actions') else LOG(sFunctionRef..':'..sPlatoonName..': Platoon prev actions='..repr(oPlatoon[reftPrevAction])) end end
                        oACU[M27Overseer.refbACUHelpWanted] = false
                        RemoveUnitsFromPlatoon(oPlatoon, { oACU}, false)
                        local oPlatoonUnits = oPlatoon:GetPlatoonUnits()
                        if M27Utilities.IsTableEmpty(oPlatoonUnits) == true then
                            if bDebugMessages == true then LOG(sFunctionRef..':'..sPlatoonName..': Disbanding platoon instead of new path as no units in it') end
                            bDisbandAsNoUnits = true
                        end
                    end
                end
            end
            if bDisbandAsNoUnits == false then
                --Choose mexes away from enemy base
                oPlatoon[reftMovementPath] = M27Logic.GetMexRaidingPath(oPlatoon, 50)
                if M27Utilities.IsTableEmpty(oPlatoon[reftMovementPath]) then bDisbandAsNoUnits = true end
                --oPlatoon[refiLastPathTarget] = table.getn(oPlatoon[reftMovementPath])
            end
        end
        if bDisbandAsNoUnits == true then
            if bDebugMessages == true then LOG(sFunctionRef..':'..sPlatoonName..oPlatoon[refiPlatoonCount]..': disbanding') end
            if oPlatoon and oPlatoon.PlatoonDisband then oPlatoon:PlatoonDisband() end
        else
            --Large attack AI: get nearby raiders, attackers and defenders to merge (unless theyre closer to enemy base than ours)
            if sPlatoonName == 'M27LargeAttackForce' then
                if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': About to call platoon mergers; ReftMovementPath[1][1]='..oPlatoon[reftMovementPath][1][1]) end
                MergeWithPlatoonsOnPath(oPlatoon, 'M27MexRaiderAI', true)
                MergeWithPlatoonsOnPath(oPlatoon, M27Overseer.sDefenderPlatoonRef, true)
                MergeWithPlatoonsOnPath(oPlatoon, sPlatoonName, true)
                --Update move order with the merge location
                table.insert(oPlatoon[reftMovementPath], 1, oPlatoon[reftMergeLocation])
                --oPlatoon[refiLastPathTarget] = table.getn(oPlatoon[reftMovementPath])
                oPlatoon:Stop()
            end
            if bPlatoonNameDisplay == true then UpdatePlatoonName(oPlatoon, sPlatoonName..oPlatoon[refiPlatoonCount]..': NewMovePath') end
            if bDontActuallyMove == false then
                if M27Utilities.IsTableEmpty(oPlatoon[reftMovementPath]) == true then
                    LOG(sFunctionRef..': '..sPlatoonName..oPlatoon[refiPlatoonCount]..': ERROR - about to issue a movealongpath order, but there is no movement path; will set movement destination to enemy base instead')
                    oPlatoon[reftMovementPath] = {}
                    oPlatoon[reftMovementPath][1] = {}
                    local iEnemyStartNumber = M27Logic.GetNearestEnemyStartNumber(aiBrain)
                    if iEnemyStartNumber == nil then
                        LOG(sFunctionRef..': '..sPlatoonName..oPlatoon[refiPlatoonCount]..':ERROR - enemy start number is nil if theyre not dead then something is wrong')
                        oPlatoon[reftMovementPath][1] = M27MapInfo.PlayerStartPoints[aiBrain.M27StartPositionNumber]
                    else
                        oPlatoon[reftMovementPath][1] = M27MapInfo.PlayerStartPoints[iEnemyStartNumber]
                    end
                end


                --Normal move unless attackAI in which case attack-move:
                if sPlatoonName == 'M27AttackNearestUnits' then MoveAlongPath(oPlatoon, oPlatoon[reftMovementPath], true, 1, bDontClearActions)
                else
                    if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': About to move along path, oPlatoon[reftMovementPath]='..repr(oPlatoon[reftMovementPath])) end
                    MoveAlongPath(oPlatoon, oPlatoon[reftMovementPath], false, 1, bDontClearActions) end
                --oPlatoon[refiCurrentAction] = refActionContinueMovementPath --Dont want to keep getting new movement paths
            end
        end
    end
end

function ReissueMovementPath(oPlatoon, bDontClearActions)
    local bDebugMessages = false
    local sFunctionRef = 'ReissueMovementPath'
    --if oPlatoon[refbACUInPlatoon] == true then bDebugMessages = true end
    local bPlatoonNameDisplay = false
    if ScenarioInfo.Options.AIPLatoonNameDebug == 'all' then bPlatoonNameDisplay = true end
    local sPlatoonName = oPlatoon:GetPlan()
    --if sPlatoonName == 'M27ACUMain' then bDebugMessages = true end
    if M27Utilities.IsTableEmpty(oPlatoon[reftMovementPath]) == true then LOG(sFunctionRef..': WARNING - have been told to reissue movement path but tmovementpath is empty; will get new movement path instead')
        GetNewMovementPath(oPlatoon, bDontClearActions)
    else
        if oPlatoon[refiCurrentPathTarget] == nil then
            LOG(sFunctionRef..': WARNING - have been told to reissue movement path but CurrentPathTarget is nil; will get first entry in movement path instead')
            oPlatoon[refiCurrentPathTarget] = 1
        end
        if oPlatoon[reftMovementPath][oPlatoon[refiCurrentPathTarget]] == nil then
            LOG(sFunctionRef..': WARNING - have been told to reissue movement path, but movement path for iCurrentPathTarget'..oPlatoon[refiCurrentPathTarget]..' is nil, will get new movement path instead')
            GetNewMovementPath(oPlatoon, bDontClearActions)
        else
            if bDebugMessages == true then
                if sPlatoonName == nil then LOG(sFunctionRef..': Warning - sPlatoonName is nil') end
                if oPlatoon[refiPlatoonCount] == nil then LOG(sFunctionRef..': Warning: PlatoonCount is nil') end
            end

            --General (all platoons) - are we closer to the current point on the path or the 2nd?
            local bGetNewPathInstead = false
            local iPossibleMovementPaths = table.getn(oPlatoon[reftMovementPath])
            local tPlatoonCurPos = {}
            local iDistToCurrent, iDistToNext, iDistBetween1and2
            local iLoopCount = 0
            local iMaxLoopCount = 10
            if iPossibleMovementPaths <= oPlatoon[refiCurrentPathTarget] then
                --Only 1 movement path point left - if are ACU then get a new movement path
                if oPlatoon[refbACUInPlatoon] == true then
                    if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..':'..sFunctionRef..': ACU in platoon with only 1 movement path, so will get new movement path') end
                    bGetNewPathInstead = true
                end
            else
                while iPossibleMovementPaths > oPlatoon[refiCurrentPathTarget] do
                    tPlatoonCurPos = oPlatoon:GetPlatoonPosition()
                    iDistToCurrent = M27Utilities.GetDistanceBetweenPositions(tPlatoonCurPos, oPlatoon[reftMovementPath][oPlatoon[refiCurrentPathTarget]])
                    iDistToNext = M27Utilities.GetDistanceBetweenPositions(tPlatoonCurPos, oPlatoon[reftMovementPath][oPlatoon[refiCurrentPathTarget] + 1])
                    iDistBetween1and2 = M27Utilities.GetDistanceBetweenPositions(oPlatoon[reftMovementPath][oPlatoon[refiCurrentPathTarget]], oPlatoon[reftMovementPath][oPlatoon[refiCurrentPathTarget]])
                    if iDistToNext < iDistBetween1and2 then oPlatoon[refiCurrentPathTarget] = oPlatoon[refiCurrentPathTarget] + 1 end
                    iLoopCount = iLoopCount + 1
                    if iLoopCount > iMaxLoopCount then break end
                end
            end
            if bGetNewPathInstead == true then
                if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..':'..sFunctionRef..': Are getting new movement path instead') end
                GetNewMovementPath(oPlatoon, bDontClearActions)
            else
                if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': refActionReissueMovementPath: About to update platoon name and movement path, current target='..oPlatoon[refiCurrentPathTarget]..'; position of this='..repr(oPlatoon[reftMovementPath][oPlatoon[refiCurrentPathTarget]])..'PlatoonUnitCount='..table.getn(oPlatoon[reftCurrentUnits])) end
                if bPlatoonNameDisplay == true then UpdatePlatoonName(oPlatoon, sPlatoonName..oPlatoon[refiPlatoonCount]..': ReissueMovementPath') end
                MoveAlongPath(oPlatoon, oPlatoon[reftMovementPath], false, oPlatoon[refiCurrentPathTarget], bDontClearActions)
            end
        end
    end
end

function IssueIndirectAttack(oPlatoon, bDontClearActions)
    --Targets structures first, if no structures then spread attack on units
    local bDebugMessages = false
    local sFunctionRef = 'IssueIndirectAttack'
    if bDebugMessages == true then LOG(sFunctionRef..':'..oPlatoon:GetPlan()..oPlatoon[refiPlatoonCount]..': IssueIndirectAttack: iIndirectUnites='..oPlatoon[refiIndirectUnits]) end
    if oPlatoon[refiIndirectUnits] > 0 then
        local sPlatoonUniqueRef = oPlatoon:GetPlan()..oPlatoon[refiPlatoonCount]
        local sTargetedRef = sPlatoonUniqueRef..'Indirect'
        local iMinTargetsInRange
        local iMinTargetsAll
        local iCurUnitRange
        local bCurUnitInRange
        local oFirstUnitWithMinTargetsAll
        local oFirstUnitWithMinTargetsInRange
        local iDistFromUs
        local tCurPos
        local tUnitsInRange
        local iUnitsInRange
        if oPlatoon[refiEnemyStructuresInRange] > 0 then
            if bDebugMessages == true then LOG(sFunctionRef..':'..sPlatoonUniqueRef..': Attacking nearest structure in range') end
            IssueAttack(oPlatoon[reftIndirectUnits], M27Utilities.GetNearestUnit(oPlatoon[reftEnemyStructuresInRange], oPlatoon:GetPlatoonPosition()))
        else
            if oPlatoon[refiEnemiesInRange] > 0 then
                --Track no. of times a unit has been targetted - first reset variables
                if bDebugMessages == true then LOG(sFunctionRef..':'..sPlatoonUniqueRef..': No nearby structures so attacking nearest units') end
                for iEnemyUnit, oEnemyUnit in oPlatoon[reftEnemiesInRange] do
                    oEnemyUnit[sTargetedRef] = 0
                end
                --Cycle through each indirect fire unit, and then check for each enemy unit in its range
                --Default target in case can't find one: the first unit in reftEnemiesInRange:
                oFirstUnitWithMinTargetsAll = oPlatoon[reftEnemiesInRange][1]
                if M27Utilities.IsTableEmpty(oPlatoon[reftIndirectUnits]) == false then
                    for iUnit, oUnit in oPlatoon[reftIndirectUnits] do
                        iMinTargetsAll = 100000
                        iMinTargetsInRange = 100000
                        iCurUnitRange = M27Logic.GetUnitMaxGroundRange({oUnit})
                        tCurPos = oUnit:GetPosition()
                        iUnitsInRange = 0
                        tUnitsInRange = {}
                        for iEnemyUnit, oEnemyUnit in oPlatoon[reftEnemiesInRange] do
                            bCurUnitInRange = false
                            if M27Utilities.GetDistanceBetweenPositions(tCurPos, oEnemyUnit:GetPosition()) <= iCurUnitRange then bCurUnitInRange = true end
                            if oEnemyUnit[sTargetedRef] <= iMinTargetsAll then
                                iMinTargetsAll = oEnemyUnit[sTargetedRef]
                                oFirstUnitWithMinTargetsAll = oEnemyUnit
                            end
                            if bCurUnitInRange == true then
                                table.insert(tUnitsInRange, 1,oEnemyUnit)
                                iUnitsInRange = iUnitsInRange + 1
                                if oEnemyUnit[sTargetedRef] < iMinTargetsInRange then
                                    iMinTargetsInRange = oEnemyUnit[sTargetedRef]
                                    oFirstUnitWithMinTargetsInRange = oEnemyUnit
                                end
                            end
                        end
                        --If any units in range, then queue up attacks on all of them, starting with the one with min targets:
                        if bDebugMessages == true then LOG(sFunctionRef..':'..sPlatoonUniqueRef..': iUnit='..iUnit..'; iUnitsInRange='..iUnitsInRange..'; iMinTargetsInRange='..iMinTargetsInRange) end
                        if not(oUnit.Dead) then
                            if iUnitsInRange > 0 then
                                if bDebugMessages == true then LOG(sFunctionRef..':'..sPlatoonUniqueRef..': iUnit='..iUnit..'; X position of target='..oFirstUnitWithMinTargetsInRange:GetPosition()[1]..'; oPlatoon[refiEnemiesInRange]='..oPlatoon[refiEnemiesInRange]..'; iIndirectUnits='..oPlatoon[refiIndirectUnits]) end
                                if bDebugMessages == true then LOG('oUnit ID='..oUnit:GetUnitId()) end
                                if bDebugMessages == true then LOG('oFirstUnitWithMinTargetsAll ID='..oFirstUnitWithMinTargetsAll:GetUnitId()) end
                                IssueAttack({oUnit}, oFirstUnitWithMinTargetsInRange)
                                oFirstUnitWithMinTargetsInRange[sTargetedRef] = oFirstUnitWithMinTargetsInRange[sTargetedRef] + 1
                                for iEnemyUnit, oEnemyUnit in tUnitsInRange do
                                    if not(oEnemyUnit == oFirstUnitWithMinTargetsInRange) then IssueAttack({oUnit}, oEnemyUnit) end
                                end
                            else
                                --queue up attacks on all units within the relevant range, starting with the one with the least targets
                                if bDebugMessages == true then LOG(sFunctionRef..':'..sPlatoonUniqueRef..': iUnit='..iUnit..'; X position of target='..oFirstUnitWithMinTargetsAll:GetPosition()[1]..'; oPlatoon[refiEnemiesInRange]='..oPlatoon[refiEnemiesInRange]..'; iIndirectUnits='..oPlatoon[refiIndirectUnits]) end
                                if bDebugMessages == true then LOG(sFunctionRef..': oUnit ID='..oUnit:GetUnitId()) end
                                if bDebugMessages == true then LOG(sFunctionRef..': oFirstUnitWithMinTargetsAll ID='..oFirstUnitWithMinTargetsAll:GetUnitId()) end

                                IssueAttack({oUnit}, oFirstUnitWithMinTargetsAll)
                                if oFirstUnitWithMinTargetsAll[sTargetedRef] == 0 then oFirstUnitWithMinTargetsAll[sTargetedRef] = 0 end
                                oFirstUnitWithMinTargetsAll[sTargetedRef] = oFirstUnitWithMinTargetsAll[sTargetedRef] + 1
                                for iEnemyUnit, oEnemyUnit in oPlatoon[reftEnemiesInRange] do
                                    if not(oEnemyUnit == oFirstUnitWithMinTargetsAll) then IssueAttack({oUnit}, oEnemyUnit) end
                                end
                            end
                        end
                    end
                else
                    if bDebugMessages == true then LOG(sFunctionRef..': Warning - table of indirect units is empty') end
                end
            else
                --No enemies in range so can't attack - reissue movement path instead
                LOG(sFunctionRef..': WARNING: No enemies to attack, will reissue movement path instead')
                ReissueMovementPath(oPlatoon, bDontClearActions)
            end
        end
    end
end

function UpdateScoutPositions(oPlatoon)
    --Send scouts to the platoons current position (so should never be in front); sends up to 2 scouts to the middle (so for v.large platoons dont group them all in 1 place)
    local bDebugMessages = false
    if oPlatoon[refiScoutUnits] <= 2 then
        if oPlatoon[refiScoutUnits] >= 1 then
            if bDebugMessages == true then LOG('UpdateScoutPositions: Sending IssueMove command') end
            IssueMove(oPlatoon[reftScoutUnits], oPlatoon:GetPlatoonPosition())
        end
    else
        for iUnit, oUnit in oPlatoon[reftScoutUnits] do
            if iUnit >= 3 then break end
            if bDebugMessages == true then LOG('UpdateScoutPositions: Sending IssueMove command') end
            IssueMove({oUnit}, oPlatoon:GetPlatoonPosition())
        end
    end
end

function GetPositionNearTargetInSamePathingGroup(tStartPos, tTargetPos, iDistanceFromTarget, iAngleBase, oPathingUnit, iNearbyMethodIfBlocked, bTrySidePositions, bCheckAgainstExistingCommandTarget, iMinDistanceFromCurrentBuilderMoveTarget)
    --Returns the position to move to in order to be iDistanceFromTarget away from tTargetPos
    --Returns nil if empty table
    --Returns pathing unit's current move location if it also fits the criteria
    --iAngleBase: 0 = straight line; 90 and 270: right angle to the direction; 180 - opposite direction (not yet supported other angles)
    --oPathingUnit - Unit to use for seeing if can path to the desired location
    --iNearbyMethodIfBlocked: default and 1: Move closer to target until are in same pathing group, checking side options as we go;
            --2: Move further away from target until are in same pathing group
            --3: Alternate between closer and further away from target until are in same pathing group
        --bTrySidePositions: Alternates left and right if base line can't find a position, based on the outer distance (so effectively plotting a circle around the target)
    --bCheckAgainstExistingCommandTarget: If true, then will check oPathingUnit's current target location, and if that appears a better fit than what this method results in
        --iMinDistanceFromCurrentBuilderMoveTarget - if bCheckAgainstExistingCommandTarget is true, then this will also check if the potential move target is >1 from the current target (and ignore if its not)
    local bDebugMessages = false
    local sFunctionRef = 'GetPositionNearTargetInSamePathingGroup'
    if bDebugMessages == true then LOG(sFunctionRef..': Start; oPathingUnit blueprint='..oPathingUnit:GetUnitId()) end
    if bCheckAgainstExistingCommandTarget == nil then bCheckAgainstExistingCommandTarget = true end
    if iMinDistanceFromCurrentBuilderMoveTarget == nil then iMinDistanceFromCurrentBuilderMoveTarget = 0 end
    local iMaxX, iMaxZ = GetMapSize()

    local iAdjDistance = 0
    local iLoopCount = 0
    local iIncrement = 0.5
    local iMaxLoopCount = iDistanceFromTarget / iIncrement + 1
    local bHaveValidTarget = false
    local tPossibleTarget = {}
    local iAngleToTarget = 0
    local iMaxAdjCycleCount = 2
    if iNearbyMethodIfBlocked == 3 then iMaxAdjCycleCount = 3 end
    local iMaxAngleCycleCount = 1
    if bTrySidePositions == true then iMaxAngleCycleCount = 3 end
    local iAdjSignage
    local tBasePossibleTarget = {}

    while bHaveValidTarget == false do
        for iAdjCycleCount = 1, iMaxAdjCycleCount do
            if iAdjCycleCount == iMaxAdjCycleCount then iAdjDistance = iAdjDistance + 1 end
            if iAdjCycleCount < 3 then iAdjSignage = 1 else iAdjSignage = -1 end
            iAngleToTarget = iAngleBase
            tBasePossibleTarget = M27Utilities.MoveTowardsTarget(tTargetPos, tStartPos, (iDistanceFromTarget + iAdjDistance) * iAdjSignage, iAngleToTarget)
            for iAngleCycleCount = 1, iMaxAngleCycleCount do
                if iAngleCycleCount == 1 then
                    tPossibleTarget = tBasePossibleTarget
                else
                    if iAngleCycleCount == 2 then iAngleToTarget = 90
                    elseif iAngleCycleCount == 3 then iAngleToTarget = 270
                    end
                    iAngleToTarget = iAngleToTarget + iAngleBase
                    if iAngleToTarget < 0 then iAngleToTarget = iAngleToTarget + 360
                    elseif iAngleToTarget > 360 then iAngleToTarget = iAngleToTarget - 360 end

                --MoveTowardsTarget(tStartPos, tTargetPos, iDistanceToTravel, iAngle)
                    tPossibleTarget = M27Utilities.MoveTowardsTarget(tTargetPos, tStartPos, (iDistanceFromTarget + iAdjDistance) * iAdjSignage, iAngleToTarget)
                end

                if bDebugMessages == true then
                    LOG(sFunctionRef..': tPossibleTarget='..repr(tPossibleTarget)..'; checking if its valid; oPathingUnit blueprint='..oPathingUnit:GetUnitId())
                    M27Utilities.DrawLocation(tPossibleTarget, nil, 4, 10)
                end
                --Are we in map bounds?
                if tPossibleTarget[1] <= iMaxX and tPossibleTarget[1] >= 0 then
                    if tPossibleTarget[3] <= iMaxZ and tPossibleTarget[3] >= 0 then
                        --Are we in the same segment group?

                        if M27MapInfo.InSameSegmentGroup(oPathingUnit, tPossibleTarget) == true then
                            --are in same pathing grouping
                            if bDebugMessages == true then LOG(sFunctionRef..': tPossibleTarget is valid, ='..repr(tPossibleTarget)..'; checking if its valid; oPathingUnit blueprint='..oPathingUnit:GetUnitId()) end
                            if bDebugMessages == true then LOG(sFunctionRef..': have valid location='..repr(tPossibleTarget)) end
                            bHaveValidTarget = true
                            break
                            --note - not bothering with check re if target built on as engi seems to cope ok id building covering its move location
                        end
                    end
                end
            end
            if bHaveValidTarget == true then break end
        end

        iLoopCount = iLoopCount + 1
        if iLoopCount > iMaxLoopCount then
            if bDebugMessages == true then LOG(sFunctionRef..': Have exhausted all options on the way to the target location, so will give up moving within range of the target') end
            break
        end
    end
    --Check if already have a move location that will take us here
    if bHaveValidTarget == true then
        if bDebugMessages == true then LOG(sFunctionRef..': Checking if already have a move location that will take us to the target') end
        tPossibleTarget[2] = GetTerrainHeight(tPossibleTarget[1], tPossibleTarget[3])
        if bCheckAgainstExistingCommandTarget == true then
            if bDebugMessages == true then LOG(sFunctionRef..': Checking against existing target to see if thats better') end
            if oPathingUnit.GetNavigator then
                local oNavigator = oPathingUnit:GetNavigator()
                if oNavigator.GetCurrentTargetPos then
                    local tExistingTargetPos = oNavigator:GetCurrentTargetPos()
                    if M27Utilities.IsTableEmpty(tExistingTargetPos) == false then
                        if M27MapInfo.InSameSegmentGroup(oPathingUnit, tExistingTargetPos) == true then
                            local iDistanceBetweenQueuedAndPossibleTarget = M27Utilities.GetDistanceBetweenPositions(tExistingTargetPos, tPossibleTarget)
                            if bDebugMessages == true then LOG(sFunctionRef..': iDistanceBetweenQueuedAndPossibleTarget='..iDistanceBetweenQueuedAndPossibleTarget) end
                            if iDistanceBetweenQueuedAndPossibleTarget > iMinDistanceFromCurrentBuilderMoveTarget then
                                local tPatherPos = oPathingUnit:GetPosition()
                                local iDistanceFromQueuedMoveLocationToTarget = M27Utilities.GetDistanceBetweenPositions(tExistingTargetPos, tTargetPos)
                                local iDistanceFromPossibleTargetToTarget = M27Utilities.GetDistanceBetweenPositions(tPossibleTarget, tTargetPos)
                                local iDistanceFromPatherToPossibleTarget = M27Utilities.GetDistanceBetweenPositions(tPossibleTarget, tPatherPos)
                                local iDistanceFromPatherToQueuedLocation = M27Utilities.GetDistanceBetweenPositions(tExistingTargetPos, tPatherPos)

                                --first check - are they both within the desired range?
                                local bPossibleTargetIsGood, bQueuedTargetIsGood
                                if iDistanceFromQueuedMoveLocationToTarget == iDistanceFromTarget then bQueuedTargetIsGood = true
                                elseif iDistanceFromQueuedMoveLocationToTarget < iDistanceFromTarget then
                                    if iNearbyMethodIfBlocked == 2 then --Want to be >=
                                        bQueuedTargetIsGood = false
                                    else bQueuedTargetIsGood = true
                                    end
                                else --must be > distance
                                    if iNearbyMethodIfBlocked == 1 then --Want to be <=
                                        bQueuedTargetIsGood = false else bQueuedTargetIsGood = true
                                    end
                                end

                                if iDistanceFromPossibleTargetToTarget == iDistanceFromTarget then bPossibleTargetIsGood = true
                                elseif iDistanceFromPossibleTargetToTarget < iDistanceFromTarget then
                                    if iNearbyMethodIfBlocked == 2 then --Want to be >=
                                        bPossibleTargetIsGood = false
                                    else bPossibleTargetIsGood = true
                                    end
                                else --must be > distance
                                    if iNearbyMethodIfBlocked == 1 then --Want to be <=
                                        bPossibleTargetIsGood = false else bPossibleTargetIsGood = true
                                    end
                                end
                                local bBothGoodOrBad = false
                                if bPossibleTargetIsGood == true and bQueuedTargetIsGood == true then bBothGoodOrBad = true
                                elseif bPossibleTargetIsGood == false and bQueuedTargetIsGood == false then bBothGoodOrBad = true end



                                if bBothGoodOrBad == false then
                                    --One is better than the other so pick it
                                    if bDebugMessages == true then LOG(sFunctionRef..': One of locations is better than the other at meeting initial requirements so will pick it; bQueuedTargetIsGood='..tostring(bQueuedTargetIsGood)) end
                                    if bQueuedTargetIsGood == true then tPossibleTarget = tExistingTargetPos end
                                else
                                    --both are good or bad re meeting the requirements; pick the one that's closest to the target
                                    if bDebugMessages == true then LOG(sFunctionRef..': Both locations are equally good/bad; if theyre both within the target distance will return closet to builder/pather; if theyre both outside the target will pick the one closest to target') end
                                    if iDistanceFromPossibleTargetToTarget <= iDistanceFromTarget and iDistanceFromQueuedMoveLocationToTarget <= iDistanceFromTarget and iDistanceFromPatherToQueuedLocation <= iDistanceFromPatherToPossibleTarget then tPossibleTarget = tExistingTargetPos
                                    elseif iDistanceFromPossibleTargetToTarget > iDistanceFromTarget and iDistanceFromQueuedMoveLocationToTarget > iDistanceFromTarget and iDistanceFromQueuedMoveLocationToTarget <= iDistanceFromPossibleTargetToTarget then tPossibleTarget = tExistingTargetPos
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    else tPossibleTarget = nil end
    return tPossibleTarget
end

function MoveNearConstruction(aiBrain, oBuilder, tLocation, sBlueprintID, iBuildDistanceMod, bReturnMovePathInstead, bUpdatePlatoonMovePath, bReturnNilIfAlreadyMovingNearConstruction)
    --gives oBuilder a move command to get them within range of building on tLocation, factoring in the size of buildingType
    --sBlueprintID - if nil, then will treat the action as having a size of 0
    --iBuildDistanceMod - increase or decrease if want to move closer/further away than build distance would send you; e.g. if want to get 3 within the build distance, set this to -3
    --bReturnMovePathInstead - if true return move destination instead of moving there; returns oBuilder's current position if it doesnt need to move
    --bUpdatePlatoonMovePath - default false; if true then if oBuilder has a platoon, updates that platoon's movement path
    --bReturnNilIfAlreadyMovingNearConstruction - will return nil if bReturnMovePathInstead is set to true and unit is already moving towards target, otherwise will return current move target if its close enough, or the builder position if already in position
    local bDebugMessages = false
    local sFunctionRef = 'MoveNearConstruction'
    if bDebugMessages == true then LOG(sFunctionRef..': Start') end
    if iBuildDistanceMod == nil then iBuildDistanceMod = 0 end
    if bReturnMovePathInstead == nil then bReturnMovePathInstead = false end
    if bUpdatePlatoonMovePath == nil then bUpdatePlatoonMovePath = false end
    if bReturnNilIfAlreadyMovingNearConstruction == nil then bReturnNilIfAlreadyMovingNearConstruction = true end
    local tBuilderLocation = oBuilder:GetPosition()
    local iBuildDistance = 0
    local oBuilderBP = oBuilder:GetBlueprint()
    if oBuilderBP.Economy and oBuilderBP.Economy.MaxBuildDistance then iBuildDistance = oBuilderBP.Economy.MaxBuildDistance end
    iBuildDistance = iBuildDistance + iBuildDistanceMod
    --if iBuildDistance <= 0 then iBuildDistance = 1 end
    local iBuildingSize
    if sBlueprintID == nil then
        iBuildingSize = 0
    else
        iBuildingSize = M27Utilities.GetBuildingSize(sBlueprintID)[1]
    end
    local fSizeMod = 0.5
    local iDistanceFromTarget = iBuildingSize * fSizeMod + iBuildDistance
    local tPossibleTarget
    local bIgnoreMove = false
    local bUseLocationInsteadOfMoveNearby = false
    local iPossibleDistanceFromTarget

    --Determine target:
    if M27Utilities.GetDistanceBetweenPositions(tBuilderLocation, tLocation) > iDistanceFromTarget then
        --Add slight buffer so move into place:
        iDistanceFromTarget = iDistanceFromTarget - 0.25

        --GetPositionNearTargetInSamePathingGroup(tStartPos, tTargetPos, iDistanceFromTarget, iAngleBase, oPathingUnit, iNearbyMethodIfBlocked, bTrySidePositions)
        local iMinDistanceFromCurrentBuilderMoveTarget = 2 --dont want to change movement path from the one generated if it's not that different
        if bDebugMessages == true then LOG(sFunctionRef..': About to get move position near the target '..repr(tLocation)) end
         tPossibleTarget = GetPositionNearTargetInSamePathingGroup(tBuilderLocation, tLocation, iDistanceFromTarget, 0, oBuilder, 1, true, true, iMinDistanceFromCurrentBuilderMoveTarget)

        if tPossibleTarget == nil then
            if bDebugMessages == true then LOG(sFunctionRef..': Cant get a nearby location for target; will return tLocation if can path to it') end
            bUseLocationInsteadOfMoveNearby = true
        else
            iPossibleDistanceFromTarget = M27Utilities.GetDistanceBetweenPositions(tLocation, tPossibleTarget)
            if iPossibleDistanceFromTarget > iDistanceFromTarget then
                if bDebugMessages == true then LOG(sFunctionRef..': Possible target location is outside the build range, so want to just return the target position instead')
                    bUseLocationInsteadOfMoveNearby = true
                end
            end
        end
        if bUseLocationInsteadOfMoveNearby == true then
            --Couldn't find anywhere; can we path to the target?
            bIgnoreMove = true
            if M27MapInfo.InSameSegmentGroup(oBuilder, tLocation, false) == true then
                if bDebugMessages == true then LOG(sFunctionRef..': Can path to tLocation so returning that') end
                if tPossibleTarget == tLocation then M27Utilities.ErrorHandler('TODO for post hotfix version - GetPositionNearTargetInSamePathingGroup should already consider if target location is valid and use that instead of pathing units current position - for now patch in MoveNearConstruction is doing this') end
                tPossibleTarget = tLocation
            else
                M27Utilities.ErrorHandler('MoveNearConstructions target location cant be pathed to and cant find pathable positions near it, will return nil, may cause future error depending on what has called this')
            end
        end

        --Is this target different to current move target?
        if tPossibleTarget then
            if bDebugMessages == true then LOG(sFunctionRef..': tPossibleTarget='..repr(tPossibleTarget)) end
            local oNavigator = oBuilder:GetNavigator()
            if oNavigator.GetCurrentTargetPos then
                local tExistingTargetPos = oNavigator:GetCurrentTargetPos()
                if M27Utilities.IsTableEmpty(tExistingTargetPos) == false then
                    if M27Utilities.GetDistanceBetweenPositions(tExistingTargetPos, tPossibleTarget) < iMinDistanceFromCurrentBuilderMoveTarget then
                        if bDebugMessages == true then LOG(sFunctionRef..': Existing move location '..repr(tExistingTargetPos)..' is close enough to possible target '..repr(tPossibleTarget)..' so will go with that, or return nil if have specified to') end
                        if bReturnNilIfAlreadyMovingNearConstruction == true then tPossibleTarget = nil
                        else tPossibleTarget = tExistingTargetPos end
                        bIgnoreMove = true
                    end
                end
            end
        end
    else
        if bDebugMessages == true then LOG(sFunctionRef..': Are already close enough to target position, so will return builder location or nil depending on function arguments') end
        --Are already in position
        if bReturnNilIfAlreadyMovingNearConstruction == true then tPossibleTarget = nil
        else tPossibleTarget = tBuilderLocation end
        bIgnoreMove = true
    end

    --Move to target:
    if bReturnMovePathInstead == false then
        --Check if unit's current move location is within 1 of this already (note the getpositionneartarget function will have more advanced logic for considering if no need to change current target
        if bIgnoreMove == false then
            --[[if oBuilder.GetNavigator then
                local oNavigator = oBuilder:GetNavigator()
                if oNavigator.GetCurrentTargetPos then
                    local tExistingTargetPos = oNavigator:GetCurrentTargetPos()
                    if M27Utilities.GetDistanceBetweenPositions(tExistingTargetPos, tPossibleTarget) < 1 then
                        bIgnoreMove = true
                    end
                end
            end]]--
            if bIgnoreMove == false then
                if bDebugMessages == true then LOG(sFunctionRef..': Issuing move command to tPossibleTarget='..repr(tPossibleTarget)) end
                IssueMove({oBuilder}, tPossibleTarget)
            else
                if bDebugMessages == true then LOG(sFunctionRef..': Not issuing move command as tPossibleTarget is close to existing target') end
            end
        end
    end
    --Update platoon movement path:
    if bIgnoreMove == false then
        if bUpdatePlatoonMovePath == true and oBuilder.PlatoonHandle then
            if oBuilder.PlatoonHandle[reftMovementPath] == nil then oBuilder.PlatoonHandle[reftMovementPath] = {} end
            if oBuilder.PlatoonHandle[refiCurrentPathTarget] == nil then oBuilder.PlatoonHandle[refiCurrentPathTarget] = 1 end
            if oBuilder.PlatoonHandle[reftMovementPath][oBuilder.PlatoonHandle[refiCurrentPathTarget]] == nil then oBuilder.PlatoonHandle[reftMovementPath][oBuilder.PlatoonHandle[refiCurrentPathTarget]] = {} end
            oBuilder.PlatoonHandle[reftMovementPath][oBuilder.PlatoonHandle[refiCurrentPathTarget]] = tPossibleTarget
        end
    end
    --Return position if have asked for one:
    if bReturnMovePathInstead == true then
        if bDebugMessages == true then
            if tPossibleTarget == nil then LOG(sFunctionRef..': End of function, returning nil')
            else LOG(sFunctionRef..': End of function, returning '..repr(tPossibleTarget)) end
        end
        return tPossibleTarget
    end
end

function RefreshSupportPlatoonMovementPath(oPlatoon)
    --Updates movement path for oPlatoon
    local bDebugMessages = false
    local sFunctionRef = 'RefreshSupportPlatoonMovementPath'
    --if oPlatoon:GetPlan() == 'M27MAAAssister' then bDebugMessages = true end
    local sPlatoonRef = oPlatoon:GetPlan()..oPlatoon[refiPlatoonCount]
    --If no unit assigned default to first intel path midpoint
    if oPlatoon then
        if oPlatoon[refoSupportHelperUnitTarget] == nil and oPlatoon[refoSupportHelperPlatoonTarget] == nil then --redundancy so dont get error when first created
            if bDebugMessages == true then LOG(sFunctionRef..': '..sPlatoonRef..': No scout helper target, will look for intel path instead') end
            if M27Overseer.bIntelPathsGenerated == false then --Shouldnt happen but code just in case
                --Set to current position for now
                oPlatoon[reftMovementPath][1] = oPlatoon:GetPlatoonPosition()
                if bDebugMessages == true then LOG(sFunctionRef..': '..sPlatoonRef..': No intel path generated, setting to platoon position instead') end
            else
                local aiBrain = oPlatoon:GetBrain()
                oPlatoon[reftMovementPath][1] = aiBrain[M27Overseer.reftIntelLinePositions][1][1]
                if bDebugMessages == true then LOG(sFunctionRef..': '..sPlatoonRef..': No scout helper target, setting to intel path instead') end
            end
        else
            -- GetPositionToFollowTargets(tUnitsToFollow, oFollowingUnit, iFollowDistance)
            if bDebugMessages == true then LOG(sFunctionRef..': Either helperunit or helperplatoon isnt nil') end
            local tUnitsToFollow = {}
            local bHavePlatoonTarget = false
            if oPlatoon[refoSupportHelperPlatoonTarget] == nil then
                if oPlatoon[refoSupportHelperPlatoonTarget].GetPlatoonUnits then
                    bHavePlatoonTarget = true
                end
            end
            if bHavePlatoonTarget then tUnitsToFollow = oPlatoon[refoSupportHelperPlatoonTarget]:GetPlatoonUnits()
            else tUnitsToFollow = {oPlatoon[refoSupportHelperUnitTarget]} end

            --Check at least 1 of target is alive
            local bAliveTarget = false
            for iUnit, oUnit in tUnitsToFollow do
                if oUnit.Dead then
                    if oUnit.Dead then
                        oPlatoon[refiCurrentAction] = refActionDisband
                        break
                    end
                end
            end

            local oUnitPather = oPlatoon[reftCurrentUnits][1]
            if oUnitPather == nil or oUnitPather.Dead then
                if oPlatoon[refiCurrentUnits] > 1 then
                    for _, oPlatoonUnit in oPlatoon[reftCurrentUnits] do
                       if not(oPlatoonUnit.Dead) then oUnitPather = oPlatoonUnit end
                    end
                else
                    --Platoon is dead so disband
                    oPlatoon[refiCurrentAction] = refActionDisband
                end
            end
            if oUnitPather == nil then oPlatoon[refiCurrentAction] = refActionDisband
            else
                if oPlatoon[refiSupportHelperFollowDistance] == nil then oPlatoon[refiSupportHelperFollowDistance] = 5 end

                oPlatoon[reftMovementPath][1] = M27Logic.GetPositionToFollowTargets(tUnitsToFollow, oPlatoon[reftCurrentUnits][1], oPlatoon[refiSupportHelperFollowDistance])
                if bDebugMessages == true then
                    LOG(sFunctionRef..': '..sPlatoonRef..': Targetting location of helper target='..repr(oPlatoon[reftMovementPath][1]))
                    LOG(sFunctionRef..': ACU position='..repr(M27Utilities.GetACU(oPlatoon:GetBrain()):GetPosition()))
                end
            end
        end
        oPlatoon[refiCurrentPathTarget] = 1
    end
end

function MoveNearHydroAndAssistEngiBuilder(oPlatoon, oHydroBuilder, tHydroPosition)
    --called by AssistHydro platoon.lua AI - intended for platoon that can build/assist
    --oHydroBuilder is the unit constructing a hydro at tHydroPosition that want to assist
    local bDebugMessages = false
    local sFunctionRef = 'MoveNearHydroAndAssistEngiBuilder'
    local tPlatoonPosition = oPlatoon:GetPlatoonPosition()
    local aiBrain = oPlatoon:GetBrain()
    local iCurHydroDistance = M27Utilities.GetDistanceBetweenPositions(tHydroPosition, tPlatoonPosition)
    local tBuilders = EntityCategoryFilterDown(categories.CONSTRUCTION + categories.REPAIR, oPlatoon:GetPlatoonUnits())
    if M27Utilities.IsTableEmpty(tBuilders) == false then
        local oBuilder = tBuilders[1]
        if iCurHydroDistance > (oBuilder:GetBlueprint().Economy.MaxBuildDistance + M27Utilities.GetBuildingSize('UAB1102')[1]*0.5) then
            --Send move command towards the hydro
            if bDebugMessages == true then LOG(sFunctionRef..': About to call MoveNearConstruction') end
            --MoveNearConstruction(aiBrain, oBuilder, tLocation, sBlueprintID, iBuildDistanceMod, bReturnMovePathInstead, bUpdatePlatoonMovePath, bReturnNilIfAlreadyMovingNearConstruction)
            MoveNearConstruction(aiBrain, oBuilder, tHydroPosition, 'UAB1102', 0, false, true, false, false)
        else
            if oPlatoon[reftMovementPath] == nil then oPlatoon[reftMovementPath] = {} end
            if oPlatoon[reftMovementPath][1] == nil then oPlatoon[reftMovementPath][1] = {} end
            oPlatoon[reftMovementPath][1] = tPlatoonPosition
            oPlatoon[refiCurrentPathTarget] = 1
        end


        if bDebugMessages == true then LOG(sFunctionRef..': Attempting to issue guard command') end
        if oHydroBuilder == nil or oHydroBuilder.Dead or oHydroBuilder:BeenDestroyed() then LOG(sFunctionRef..': ERROR - There is no valid target; wont issue guard command')
        else
            IssueGuard({ oBuilder}, oHydroBuilder)
        end
    end
end


function ProcessPlatoonAction(oPlatoon)
    --Assumes DeterminePlatoonAction has been called
    local bDebugMessages = false
    --if oPlatoon[refbACUInPlatoon] == true then bDebugMessages = true end
    local sFunctionRef = 'ProcessPlatoonAction'
    if oPlatoon and oPlatoon.GetBrain then
        local aiBrain = oPlatoon:GetBrain()
        if aiBrain and aiBrain.PlatoonExists and aiBrain:PlatoonExists(oPlatoon) then

            local sPlatoonName = oPlatoon:GetPlan()
            --if sPlatoonName == 'M27ACUMain' then bDebugMessages = true end
            --if sPlatoonName == 'M27DefenderAI' then bDebugMessages = true end
            --if sPlatoonName == 'M27MexRaiderAI' then bDebugMessages = true end
            --if sPlatoonName == 'M27ScoutAssister' then bDebugMessages = true end
            --if sPlatoonName == M27Overseer.sIntelPlatoonRef then bDebugMessages = true end
            if bDebugMessages == true then
                if oPlatoon[refiCurrentAction] == nil then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': '..sFunctionRef..': refiCurrentAction is nil')
                else LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': '..sFunctionRef..': refiCurrentAction = '..oPlatoon[refiCurrentAction]) end
            end

            --First add in extra action (if have one) - currently just overcharge
            local bDontClearActions = false
            local bCancelOvercharge = false
            local bGiveMoveTargetFirst = false
            if not(oPlatoon[refiExtraAction]==nil) then
                --bDebugMessages = true
                local oOverchargingUnit = oPlatoon[reftBuilders][1]
                if bDebugMessages == true then LOG(sFunctionRef..': Have extra action to process') end
                if oPlatoon[refiExtraAction] == refExtraActionOvercharge then
                    if bDebugMessages == true then LOG(sFunctionRef..': Extra action is overcharge - checking have a target') end
                    if oPlatoon[refExtraActionTargetUnit] and not(oPlatoon[refExtraActionTargetUnit].Dead) then
                        if bDebugMessages == true then LOG(sFunctionRef..': Have valid target, issuing overcharge') end
                        if M27Utilities.IsTableEmpty(oPlatoon[reftBuilders]) == true then
                            LOG(sFunctionRef..': ERROR - tried calling overcharge action but dont have a unit to issue it to')
                        else
                            local oUnitToIssueOverchargeTo = oOverchargingUnit
                            if oUnitToIssueOverchargeTo and not(oUnitToIssueOverchargeTo.Dead) then
                                --Do we need to move closer to get in range of overcharge (e.g. are targetting T2 PD)?
                                local tOCTargetPos = oPlatoon[refExtraActionTargetUnit]:GetPosition()
                                local tOverchargingUnitPos = oOverchargingUnit:GetPosition()
                                local iOverchargingUnitRange = M27Logic.GetACUMaxDFRange(oOverchargingUnit)
                                local iDistanceBetweenUnits = M27Utilities.GetDistanceBetweenPositions(tOCTargetPos, tOverchargingUnitPos)
                                local tMoveTarget = {}
                                local tPossibleTarget = {}
                                if iDistanceBetweenUnits > iOverchargingUnitRange then
                                    --Move towards the target
                                    local iLoopCount = 0
                                    local iMaxLoop = 100
                                    bGiveMoveTargetFirst = true
                                    --GetPositionNearTargetInSamePathingGroup(tStartPos, tTargetPos, iDistanceFromTarget, iAngleBase, oPathingUnit, iNearbyMethodIfBlocked, bTrySidePositions)
                                    tMoveTarget = GetPositionNearTargetInSamePathingGroup(tOverchargingUnitPos, tOCTargetPos, iDistanceBetweenUnits - iOverchargingUnitRange, 0, oOverchargingUnit, 1, true)
                                    if tMoveTarget == nil then
                                        bCancelOvercharge = true
                                    end
                                end
                                if bCancelOvercharge == false then
                                    IssueClearCommands({oUnitToIssueOverchargeTo})
                                    if bGiveMoveTargetFirst == true then IssueMove({ oOverchargingUnit }, tMoveTarget) end
                                    IssueOverCharge({oOverchargingUnit}, oPlatoon[refExtraActionTargetUnit])
                                    bDontClearActions = true
                                    if bDebugMessages == true then LOG(sFunctionRef..': Have just issued overcharge action, waiting') end
                                end
                            else
                                LOG(sFunctionRef..': Warning - unit to issue overcharge to isnt valid or is dead')
                            end
                        end
                    else
                        LOG(sFunctionRef..': ERROR - tried calling overcharge action without a target')
                    end
                end
            end

            if oPlatoon[refiCurrentAction] == nil then
                --dont change what are currently doing
            else
                --local aiBrain = oPlatoon:GetBrain()
                local bPlatoonNameDisplay = false
                if bDebugMessages == true then LOG(sFunctionRef..': ACU state='..M27Logic.GetUnitState(M27Utilities.GetACU(aiBrain))) end
                if ScenarioInfo.Options.AIPLatoonNameDebug == 'all' then bPlatoonNameDisplay = true end
                if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': ProcessPlatoonAction: refiCurrentAction='..oPlatoon[refiCurrentAction]..'; bDontClearActions='..tostring(bDontClearActions)) end
                if not(oPlatoon[refiCurrentAction] == refActionMoveToTemporaryLocation) then oPlatoon[reftTemporaryMoveTarget] = {} end --Resets variable since are about to get new command

                if oPlatoon[refiCurrentAction] == refActionAttack then
                    if bPlatoonNameDisplay == true then UpdatePlatoonName(oPlatoon, sPlatoonName..oPlatoon[refiPlatoonCount]..': refActionAttack') end
                    --attack-move to nearest enemy; LargeAttackAI - prioritise structure over nearest enemy if <=5 enemy units
                    if oPlatoon[refiEnemiesInRange] == 0 and oPlatoon[refiEnemyStructuresInRange] == 0 then ReissueMovementPath(oPlatoon)
                    else
                        local tDFTargetPosition = {}

                        local bAlreadyDeterminedTargetEnemy = false
                        local bChangedActions = false
                        if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': refActionAttack: About to process action') end
                        if sPlatoonName == 'M27LargeAttackForce' then
                            --If only a small number of enemies then target the nearest structure or the slowest enemy unit
                            if oPlatoon[refiEnemiesInRange] < 8 then
                                if oPlatoon[refiEnemyStructuresInRange] > 0 then
                                    tDFTargetPosition = M27Utilities.GetNearestUnit(oPlatoon[reftEnemyStructuresInRange], oPlatoon:GetPlatoonPosition()):GetPosition()
                                    bAlreadyDeterminedTargetEnemy = true
                                else
                                    --No structures; see if are any slower enemies and if so then target them
                                    local tSlowerEnemies = M27Logic.GetUnitSpeedData(oPlatoon[reftEnemiesInRange], aiBrain, true, 4, M27Logic.GetUnitMinSpeed(oPlatoon[reftCurrentUnits], aiBrain, false))
                                    if not(tSlowerEnemies==nil) then
                                        if table.getn(tSlowerEnemies) > 0 then
                                            if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': ProcessPlatoonAction: table.getn(tSlowerEnemies)='..table.getn(tSlowerEnemies)) end
                                            tDFTargetPosition = M27Utilities.GetNearestUnit(tSlowerEnemies, oPlatoon:GetPlatoonPosition()):GetPosition()
                                            bAlreadyDeterminedTargetEnemy = true
                                        end
                                    end
                                end
                            end
                        elseif sPlatoonName == 'M27AttackNearestUnits' then
                            --Has platoon attack nearby structures and (if there are none) nearby land units forever; if no known units then will attack enemy base and then go back to our base and repeat
                            if oPlatoon[refiEnemyStructuresInRange] > 0 then
                                tDFTargetPosition = M27Utilities.GetNearestUnit(oPlatoon[reftEnemyStructuresInRange], oPlatoon:GetPlatoonPosition()):GetPosition()
                                bAlreadyDeterminedTargetEnemy = true
                            elseif oPlatoon[refiEnemiesInRange] == 0 then --Redundancy - no structures or enemies in range
                                bChangedActions = true
                                ReturnToBase(oPlatoon)
                            end
                        end
                        if bAlreadyDeterminedTargetEnemy == false then
                            if oPlatoon[refiEnemiesInRange] > 0 then
                                if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': refActionAttack: Enemies in range, will attack nearest enemy unit') end
                                tDFTargetPosition = M27Utilities.GetNearestUnit(oPlatoon[reftEnemiesInRange], oPlatoon:GetPlatoonPosition()):GetPosition()
                            elseif oPlatoon[refiEnemyStructuresInRange] > 0 then
                                if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': refActionAttack: No enemies in range but have structures in range') end
                                tDFTargetPosition = M27Utilities.GetNearestUnit(oPlatoon[reftEnemyStructuresInRange], oPlatoon:GetPlatoonPosition()):GetPosition()
                            else
                                LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': WARNING - have been assigned action to attack for DF units, but no nearby units recorded.  Will tell DF units to go to current movement path target')
                                if M27Utilities.IsTableEmpty(oPlatoon[reftMovementPath][oPlatoon[refiPlatoonCount]]) == true then
                                    GetNewMovementPath(oPlatoon, bDontClearActions)
                                    bChangedActions = true
                                else
                                    tDFTargetPosition = oPlatoon[reftMovementPath][oPlatoon[refiPlatoonCount]]
                                end
                            end
                        end
                        --Attack-move to target enemy for direct fire units if spread out, otherwise move; for indirect fire units instead do special attack targetting structures if there are any, or spread attack if there arent
                        if bChangedActions == false then
                            if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': refActionAttack: About to issue attack orders') end
                            if bPlatoonNameDisplay == true then UpdatePlatoonName(oPlatoon, sPlatoonName..oPlatoon[refiPlatoonCount]..': AttackNearestEnemy') end
                            if bDontClearActions == false then IssueClearCommands(oPlatoon[reftCurrentUnits]) end
                            local bMoveNotAttack = false
                            if oPlatoon[refiDFUnits] > 0 then
                                --Do we have enemy mobile units? If so consider moving towards them:
                                if oPlatoon[refiEnemiesInRange] > 0 then
                                    --if enemy T1 arti or T2 MML detected then move instead of attack-move even if spread out:
                                    if oPlatoon[refiVisibleEnemyIndirect] > 0 then
                                        bMoveNotAttack = true
                                    else
                                        --ACU in platoon? Then attack move
                                        if oPlatoon[refbACUInPlatoon] == true then bMoveNotAttack = false
                                        else
                                            if GetPlatoonPositionDeviation(oPlatoon) <= 10 then
                                            --Platoon isn't spread out, so ok to move
                                            bMoveNotAttack = true
                                            end
                                        end
                                    end
                                end
                                oPlatoon[reftTemporaryMoveTarget] = tDFTargetPosition


                                if bMoveNotAttack == true then
                                    if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': refActionAttack: Issuing move to DF units to position '..repr(oPlatoon[reftTemporaryMoveTarget])) end
                                    IssueMove(oPlatoon[reftDFUnits], oPlatoon[reftTemporaryMoveTarget])
                                else
                                    IssueAggressiveMove(oPlatoon[reftDFUnits], oPlatoon[reftTemporaryMoveTarget])
                                end
                            end
                            if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': refActionAttack: About to issue attack orders for indirect units') end
                            IssueIndirectAttack(oPlatoon, bDontClearActions) --if are any indirect fire units this will tell them to target structures, or (if none) spread attack enemy unitsi n range
                            UpdateScoutPositions(oPlatoon)
                        end
                    end

                elseif oPlatoon[refiCurrentAction] == refActionRun  then
                    if bPlatoonNameDisplay == true then UpdatePlatoonName(oPlatoon, sPlatoonName..oPlatoon[refiPlatoonCount]..': refActionRun') end
                    oPlatoon[refbHavePreviouslyRun] = true
                    --Do we only have a small number of arti? If so then suicide instead of running away
                    --decided not to have this code in the end - not sure it was working, and when tested arti were firing while running away so removes the reason for having it
                    --[[
                    local bSuicideArti = false
                    if oPlatoon[refiDFUnits] == 0 then
                        if oPlatoon[refiIndirectUnits] > 0 then
                            if oPlatoon[refiIndirectUnits] <= 10 then
                                --Are some of these seraphim?
                                local tNonSeraArti = EntityCategoryFilterDown(categories.SERAPHIM, oPlatoon[reftIndirectUnits])
                                if tNonSeraArti == nil then bSuicideArti = true
                                    elseif table.getn(tNonSeraArti) == 0 then bSuicideArti = true end
                            end
                        end
                    end
                    if bSuicideArti == true then
                        if bDontClearActions == false then IssueClearCommands(oPlatoon[reftIndirectUnits]) end
                        IssueIndirectAttack(oPlatoon, bDontClearActions)
                        for iUnit, oArti in oPlatoon[reftIndirectUnits] do
                            oPlatoon:RemoveUnit(oArti)
                        end
                    end ]]--
                    --Check if current target is away from nearest enemy and also the enemy start location:
                    local bTargetAwayFromNearestEnemy = false
                    local tCurPlatoonPos = oPlatoon:GetPlatoonPosition()
                    local bUseTempPath = false
                    --Does the platoon have a temporary move path set?
                    local tPlatoonCurMoveLocation = oPlatoon[reftTemporaryMoveTarget]
                    local iDistanceToRunBackBy = 40
                    if sPlatoonName == 'M27ScoutAssister' then iDistanceToRunBackBy = 10
                    elseif sPlatoonName == 'M27MAAAssister' then iDistanceToRunBackBy = 15 end

                    if M27Utilities.IsTableEmpty(tPlatoonCurMoveLocation) == true then
                        tPlatoonCurMoveLocation = oPlatoon[reftMovementPath][oPlatoon[refiCurrentPathTarget]]
                    else
                        bUseTempPath = true
                        if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': Temporary move target being used which shouldnt be nil, repr='..repr(oPlatoon[reftTemporaryMoveTarget])) end
                    end

                    if oPlatoon[refiEnemiesInRange] + oPlatoon[refiEnemyStructuresInRange] == 0 then
                        if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': RunAway action - no nearby enemies so assuming current location already valid') end
                        bTargetAwayFromNearestEnemy = true
                    else
                        --IsDestinationAwayFromNearbyEnemies(aiBrain, tCurPos, tCurDestination, iEnemySearchRadius, bAlsoRunFromEnemyStartLocation)
                        if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': RunAway action - are nearby enemies so checking if moving away from them and enemy base') end
                        if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': tCurPlatoonPos='..repr(tCurPlatoonPos)) end
                        if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': tPlatoonCurMoveLocation='..repr(tPlatoonCurMoveLocation)) end
                        if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': oPlatoon[reftMovementPath][oPlatoon[refiCurrentPathTarget]]='..repr(oPlatoon[reftMovementPath][oPlatoon[refiCurrentPathTarget]])) end
                        if IsDestinationAwayFromNearbyEnemies(aiBrain, tCurPlatoonPos, tPlatoonCurMoveLocation, oPlatoon[refiEnemySearchRadius], true) == true then bTargetAwayFromNearestEnemy = true end
                    end
                    if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': Action is to run; bTargetAwayFromNearestEnemy and enemy start='..tostring(bTargetAwayFromNearestEnemy)) end
                    if bTargetAwayFromNearestEnemy == false then
                        --Not moving further away with the current movement path target, try the first movement path; if alredy on it then try opposite direction to enemy unless are other enemies there as well in which case go back to base
                        if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': 1s loop: Running away - Try moving to first mex location or start; iCurrentPathTarget='..oPlatoon[refiCurrentPathTarget]) end
                        if oPlatoon[refiCurrentPathTarget] <= 1 then
                            --Have already tried going to first point, try going in opposite direction to nearest enemy
                            --Does the current path do this?
                            --IsDestinationAwayFromNearbyEnemies(aiBrain, tCurPos, tCurDestination, iEnemySearchRadius, bAlsoRunFromEnemyStartLocation)
                            if IsDestinationAwayFromNearbyEnemies(aiBrain, tCurPlatoonPos, tPlatoonCurMoveLocation, oPlatoon[refiEnemySearchRadius], false) == true then
                                if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': Action is to run; target is away from nearby enemies (even if not from enemy start') end
                                bTargetAwayFromNearestEnemy = true
                            else
                                --if move in opposite direction to nearby enemy (by iDistanceToRunBackBy) does this move further away?
                                --MoveTowardsTarget(tStartPos, tTargetPos, iDistanceToTravel, iAngle)
                                local oNearestEnemy
                                if oPlatoon[refiEnemiesInRange] > 0 then oNearestEnemy = M27Utilities.GetNearestUnit(oPlatoon[reftEnemiesInRange], tCurPlatoonPos)
                                else oNearestEnemy = M27Utilities.GetNearestUnit(oPlatoon[reftEnemyStructuresInRange], tCurPlatoonPos) end

                                local tTempMoveTarget = M27Utilities.MoveTowardsTarget(tCurPlatoonPos, oNearestEnemy:GetPosition(), iDistanceToRunBackBy, 180)
                                --IsDestinationAwayFromNearbyEnemies(aiBrain, tCurPos, tCurDestination, iEnemySearchRadius, bAlsoRunFromEnemyStartLocation)
                                if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': RunAway action - Seeing if moving in opposite direction will move us away') end
                                if IsDestinationAwayFromNearbyEnemies(aiBrain, tCurPlatoonPos, tTempMoveTarget, oPlatoon[refiEnemySearchRadius], false) == true then
                                    bTargetAwayFromNearestEnemy = true
                                    bUseTempPath = true
                                    oPlatoon[reftTemporaryMoveTarget] = tTempMoveTarget
                                    if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': Setting temp move target to move away from nearest enemy') end
                                else
                                    --so need to go to base instead
                                    if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': Returning to base as moving away from nearest enemy doesnt move us away from other enemies') end
                                    if bPlatoonNameDisplay == true then UpdatePlatoonName(oPlatoon, sPlatoonName..oPlatoon[refiPlatoonCount]..': ReturnToBase') end
                                    local iReturnToBaseDistance --nil unless special case
                                    if sPlatoonName == 'M27ScoutAssister' or sPlatoonName == 'M27MAAAssister' then iReturnToBaseDistance = iDistanceToRunBackBy end
                                    ReturnToBase(oPlatoon, iDistanceToRunBackBy)
                                end
                            end
                        else
                            --Move to the previous mex on the pathing (or the 1st/2nd if a large attack force)
                            if sPlatoonName == 'M27LargeAttackForce' then
                                if oPlatoon[refiCurrentPathTarget] > 2 then oPlatoon[refiCurrentPathTarget] = 2
                                else oPlatoon[refiCurrentPathTarget] = 1 end
                            else
                                oPlatoon[refiCurrentPathTarget] = oPlatoon[refiCurrentPathTarget] - 1
                            end
                            if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': 1s loop: Running away - moving to earlier location target') end
                        end
                        if bTargetAwayFromNearestEnemy == true then
                            if bDontClearActions == false then IssueClearCommands(oPlatoon[reftCurrentUnits]) end
                            oPlatoon:SetPlatoonFormationOverride('GrowthFormation')
                            if not(bUseTempPath == true) then
                                if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': RunAway action - Are already moving away from nearest enemy based on the current movement path') end
                                IssueMove(oPlatoon[reftCurrentUnits], oPlatoon[reftMovementPath][oPlatoon[refiCurrentPathTarget]])
                                --oPlatoon:MoveToLocation(oPlatoon[reftMovementPath][oPlatoon[refiCurrentPathTarget]], false)
                                if bPlatoonNameDisplay == true then UpdatePlatoonName(oPlatoon, sPlatoonName..oPlatoon[refiPlatoonCount]..': RunToPrevPos') end
                            else
                                if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': RunAway action - moving to temporary move target') end
                                IssueMove(oPlatoon[reftCurrentUnits], oPlatoon[reftTemporaryMoveTarget])
                                --oPlatoon:MoveToLocation(oPlatoon[reftTemporaryMoveTarget], false)
                                if bPlatoonNameDisplay == true then UpdatePlatoonName(oPlatoon, sPlatoonName..oPlatoon[refiPlatoonCount]..': RunToTempPos') end
                            end
                            --oPlatoon[refiLastPathTarget] = oPlatoon[refiCurrentPathTarget]
                            --WaitSeconds(2)
                        end
                    else
                        --Already moving away from enemy, so no need to change things
                        if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': 1s loop: Already running away from enemy, no need to change things') end
                    end
                elseif oPlatoon[refiCurrentAction] == refActionReissueMovementPath then
                    if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': About to call reissuemovementpath; bDontClearActions='..tostring(bDontClearActions)) end
                    ReissueMovementPath(oPlatoon, bDontClearActions)

                    --IssueMove(oPlatoon[reftCurrentUnits], oPlatoon[reftMovementPath][oPlatoon[refiCurrentPathTarget]])
                elseif oPlatoon[refiCurrentAction] == refActionContinueMovementPath  then
                    --if if bDontClearActions == false then IssueClearCommands(oPlatoon[reftCurrentUnits]) end --already clear using MoveAlongPath
                    if bPlatoonNameDisplay == true then UpdatePlatoonName(oPlatoon, sPlatoonName..oPlatoon[refiPlatoonCount]..': refActionContinueMovementPath') end
                    oPlatoon:SetPlatoonFormationOverride('AttackFormation')
                    --Update movement path if have already gone past it and are closer to the next part of the path:
                    if table.getn(oPlatoon[reftMovementPath]) > oPlatoon[refiCurrentPathTarget] then
                        local tPlatoonCurPos = oPlatoon:GetPlatoonPosition()
                        if tPlatoonCurPos == nil then
                            LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': ERROR - Processing current action ContinueMovementPath - platoon has nil position so disbanding instead')
                            if oPlatoon and aiBrain:PlatoonExists(oPlatoon) then oPlatoon:PlatoonDisband() end
                        else
                            if M27Utilities.GetDistanceBetweenPositions(tPlatoonCurPos, oPlatoon[reftMovementPath][oPlatoon[refiCurrentPathTarget] + 1]) < M27Utilities.GetDistanceBetweenPositions(oPlatoon[reftMovementPath][oPlatoon[refiCurrentPathTarget]], oPlatoon[reftMovementPath][oPlatoon[refiCurrentPathTarget]+1]) then
                                if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': Are moving current path target up 1 as a recloser to next destination than current; refiCurrentPathTarget='..oPlatoon[refiCurrentPathTarget]..'; table.getn(oPlatoon[reftMovementPath])='..table.getn(oPlatoon[reftMovementPath])) end
                                oPlatoon[refiCurrentPathTarget] = oPlatoon[refiCurrentPathTarget] + 1
                            else
                                if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': Are not moving current path target up 1. Distance between platoon and current target='..M27Utilities.GetDistanceBetweenPositions(tPlatoonCurPos, oPlatoon[reftMovementPath][oPlatoon[refiCurrentPathTarget] + 1])..'; distance between current and next move targets='..M27Utilities.GetDistanceBetweenPositions(oPlatoon[reftMovementPath][oPlatoon[refiCurrentPathTarget]], oPlatoon[reftMovementPath][oPlatoon[refiCurrentPathTarget]+1])..'; refiCurrentPathTarget='..oPlatoon[refiCurrentPathTarget]..'; table.getn(oPlatoon[reftMovementPath])='..table.getn(oPlatoon[reftMovementPath])) end
                            end
                        end
                    end

                    if sPlatoonName == 'M27AttackNearestUnits' then MoveAlongPath(oPlatoon, oPlatoon[reftMovementPath], true, oPlatoon[refiCurrentPathTarget], bDontClearActions)
                    else if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': About to issue MoveAlongPath order, oPlatoon[refiCurrentPathTarget]='..oPlatoon[refiCurrentPathTarget]) end
                        MoveAlongPath(oPlatoon, oPlatoon[reftMovementPath], false, oPlatoon[refiCurrentPathTarget], bDontClearActions) end
                elseif oPlatoon[refiCurrentAction] == refActionNewMovementPath  then
                    GetNewMovementPath(oPlatoon, bDontClearActions)
                    if oPlatoon[refiCurrentAction] == refActionReissueMovementPath then ReissueMovementPath(oPlatoon, bDontClearActions) end


                elseif oPlatoon[refiCurrentAction] == refActionUseAttackAI  then
                    if bPlatoonNameDisplay == true then UpdatePlatoonName(oPlatoon, sPlatoonName..oPlatoon[refiPlatoonCount]..': refActionuseAttackAI') end
                    oPlatoon:SetAIPlan('M27AttackNearestUnits')
                elseif oPlatoon[refiCurrentAction] == refActionDisband  then
                    if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': Platoon disbanding') end
                    if bPlatoonNameDisplay == true then UpdatePlatoonName(oPlatoon, sPlatoonName..oPlatoon[refiPlatoonCount]..': refActionDisband') end
                    if oPlatoon and aiBrain:PlatoonExists(oPlatoon) then oPlatoon:PlatoonDisband() end
                elseif oPlatoon[refiCurrentAction] == refActionMoveDFToNearestEnemy  then
                    --Update the name just for direct fire units hence commented out below
                    --if bPlatoonNameDisplay == true then UpdatePlatoonName(oPlatoon, sPlatoonName..oPlatoon[refiPlatoonCount]..': refActionMoveDFToNearestEnemy') end
                    if oPlatoon[refiEnemiesInRange] + oPlatoon[refiEnemyStructuresInRange] > 0 then
                        if oPlatoon[refiDFUnits] > 0 then
                            local oTargetEnemy
                            if oPlatoon[refiEnemiesInRange] == 0 then oTargetEnemy = M27Utilities.GetNearestUnit(oPlatoon[reftEnemyStructuresInRange], oPlatoon:GetPlatoonPosition())
                            elseif oPlatoon[refiEnemyStructuresInRange] == 0 then oTargetEnemy = M27Utilities.GetNearestUnit(oPlatoon[reftEnemiesInRange], oPlatoon:GetPlatoonPosition())
                            else
                                oTargetEnemy = M27Utilities.GetNearestUnit(M27Utilities.CombineTables(oPlatoon[reftEnemiesInRange], oPlatoon[reftEnemyStructuresInRange]), oPlatoon:GetPlatoonPosition())
                            end
                            if bDontClearActions == false then IssueClearCommands(oPlatoon[reftDFUnits]) end
                            oPlatoon[reftTemporaryMoveTarget] = oTargetEnemy:GetPosition()
                            if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': Sending Issue Move to DF units') end
                            IssueMove(oPlatoon[reftDFUnits], oPlatoon[reftTemporaryMoveTarget])
                            if bDontClearActions == false then IssueClearCommands(oPlatoon[reftScoutUnits]) end
                            UpdateScoutPositions(oPlatoon) --Moves scouts to platoon average position
                            if bPlatoonNameDisplay == true then --Only update name of DF units (so cant use normal function):
                                for iUnit, oUnit in oPlatoon[reftDFUnits] do
                                    if not oUnit.Dead then
                                        oUnit:SetCustomName(sPlatoonName..oPlatoon[refiPlatoonCount]..': DFUnitsMoveToEnemy')
                                    end
                                end
                            end
                            --WaitSeconds(1)
                        end
                    end

                elseif oPlatoon[refiCurrentAction] == refActionReturnToBase   then
                    if bPlatoonNameDisplay == true then UpdatePlatoonName(oPlatoon, sPlatoonName..oPlatoon[refiPlatoonCount]..': refActionReturnToBase') end
                    ReturnToBase(oPlatoon)
                elseif oPlatoon[refiCurrentAction] == refActionReclaimNearby then
                    if bPlatoonNameDisplay == true then UpdatePlatoonName(oPlatoon, sPlatoonName..oPlatoon[refiPlatoonCount]..': ActionReclaim') end
                    --Will have already determined reclaim target as part of the check whether to reclaim (for efficiency)
                    if bDebugMessages == true then LOG(sFunctionRef..': '..sPlatoonName..oPlatoon[refiPlatoonCount]..' about to issue reclaim target') end
                    if bDontClearActions == false then IssueClearCommands(oPlatoon[reftReclaimers]) end
                    IssueReclaim(oPlatoon[reftReclaimers], oPlatoon[refoNearbyReclaimTarget])
                    --Add move command so unit wont stay idle
                    IssueMove(oPlatoon[reftReclaimers], oPlatoon[reftMovementPath][oPlatoon[refiCurrentPathTarget]])
                elseif oPlatoon[refiCurrentAction] == refActionBuildMex then
                    --Will have already determined the location to build the mex on (and checked its available to build oin) as part of the check of whether to have this as an action
                    if bPlatoonNameDisplay == true then UpdatePlatoonName(oPlatoon, sPlatoonName..oPlatoon[refiPlatoonCount]..': ActionBuildMex') end
                    if bDebugMessages == true then LOG(sFunctionRef..': '..sPlatoonName..oPlatoon[refiPlatoonCount]..' about to issue command to build mex at location '..repr(oPlatoon[reftNearbyMexToBuildOn])..'; bDontClearActions='..tostring(bDontClearActions)) end
                    if bDontClearActions == false then IssueClearCommands(oPlatoon[reftBuilders]) end
                    if bDebugMessages == true then M27Utilities.DrawLocation(oPlatoon[reftNearbyMexToBuildOn], nil, nil, 20) end --blue circle
                    --First move near construction if it's different to current move target
                    local tMoveNearMex
                    local tBuilderCurPos
                    local bDontMoveBefore = false
                    for _, oBuilder in oPlatoon[reftBuilders] do
                        if not(oBuilder.Dead) then
                            --Not sure how well this will work with platoons containing multiple builders - if gives issues then switch to using assist for the remaining units
                            --M27BuildStructureAtLocation(oBuilder, sBuildingType, tBuildLocation, bMoveNearFirst)
                            if bDebugMessages == true then LOG(sFunctionRef..': First builder position='..repr(oBuilder:GetPosition())) end
                            --MoveNearConstruction(aiBrain, oBuilder, tLocation, sBlueprintID, iBuildDistanceMod, bReturnMovePathInstead, bUpdatePlatoonMovePath, bReturnNilIfAlreadyMovingNearConstruction)
                            tMoveNearMex = MoveNearConstruction(aiBrain, oBuilder, oPlatoon[reftNearbyMexToBuildOn], 'UAB1103', -0.1, true, false, true)
                            if tMoveNearMex then
                                --Check if this is different to current position by enough (as movenearconstruction returns current position if dont need to change things)
                                tBuilderCurPos = oBuilder:GetPosition()
                                if M27Utilities.GetDistanceBetweenPositions(tMoveNearMex, tBuilderCurPos) < 1 then bDontMoveBefore = true tMoveNearMex = nil end
                            else bDontMoveBefore = true
                            end

                            break
                        end
                    end
                    if bDontMoveBefore == false then
                        if bDebugMessages == true then
                            LOG(sFunctionRef..': tMoveNearMex='..repr(tMoveNearMex))
                            M27Utilities.DrawLocation(tMoveNearMex, nil, 3, 20) --orange circle
                        end
                        IssueMove(oPlatoon[reftBuilders], tMoveNearMex)
                    end
                    for _, oBuilder in oPlatoon[reftBuilders] do
                        if not(oBuilder.Dead) then
                            --AIBuildStructures.M27BuildStructureAtLocation(oBuilder, 'T1Resource', oPlatoon[reftNearbyMexToBuildOn])
                            AIBuildStructures.M27BuildStructureDirectAtLocation(oBuilder, 'T1Resource', oPlatoon[reftNearbyMexToBuildOn])
                        end
                    end
                    --Move as soon as are done:
                    IssueMove(oPlatoon[reftBuilders], oPlatoon[reftMovementPath][oPlatoon[refiCurrentPathTarget]])
                elseif oPlatoon[refiCurrentAction] == refActionAssistConstruction then
                    --shoudl have already determined the unit/building to assist previously
                    if bPlatoonNameDisplay == true then UpdatePlatoonName(oPlatoon, sPlatoonName..oPlatoon[refiPlatoonCount]..':ActionAssistConstruction') end
                    if bDontClearActions == false then IssueClearCommands(oPlatoon[reftBuilders]) end
                    --Is it in our build range?
                    local iBuildDistance = 5
                    local tBuildingPosition = oPlatoon[refoConstructionToAssist]:GetPosition()
                    if bDebugMessages == true then LOG(sFunctionRef..':'..sPlatoonName..': about to assign construction target to assist') end
                    for _, oBuilder in oPlatoon[reftBuilders] do
                        if not(oBuilder.Dead) then
                            iBuildDistance = oBuilder:GetBlueprint().Economy.MaxBuildDistance
                            if M27Utilities.GetDistanceBetweenPositions(tBuildingPosition, oBuilder:GetPosition()) > iBuildDistance then
                                --Move to location
                                if bDebugMessages == true then LOG(sFunctionRef..':'..sPlatoonName..': Are too far away, will move closer before assisting') end
                                if oPlatoon[refiOverrideDistanceToReachDestination] == nil then oPlatoon[refiOverrideDistanceToReachDestination] = 3 end --(redundancy as set when platoon first created if there are buildings in it)
                                MoveNearConstruction(aiBrain, oBuilder, tBuildingPosition, oPlatoon[refoConstructionToAssist]:GetUnitId(), -oPlatoon[refiOverrideDistanceToReachDestination] - 1, false)
                            end
                            IssueGuard(oPlatoon[reftBuilders], oPlatoon[refoConstructionToAssist])
                            if bDebugMessages == true then LOG(sFunctionRef..':'..sPlatoonName..': Issued guard order to assist') end
                        end
                    end
                elseif oPlatoon[refiCurrentAction] == refActionMoveJustWithinRangeOfNearestPD then
                    if bPlatoonNameDisplay == true then UpdatePlatoonName(oPlatoon, sPlatoonName..oPlatoon[refiPlatoonCount]..':ActionMoveNearPD') end
                    if bDontClearActions == false then IssueClearCommands(oPlatoon[reftCurrentUnits]) end
                    --Locate nearest PD:
                    if oPlatoon[refiEnemyStructuresInRange] > 0 then
                        local tNearbyPD = EntityCategoryFilterDown(categories.DIRECTFIRE, oPlatoon[reftEnemyStructuresInRange])
                        if M27Utilities.IsTableEmpty(tNearbyPD) == false then
                            local tPlatoonPosition = oPlatoon:GetPlatoonPosition()
                            local oNearestPD = M27Utilities.GetNearestUnit(tNearbyPD, tPlatoonPosition, aiBrain, true)
                            local iPlatoonMaxRange = M27Logic.GetUnitMaxGroundRange(oPlatoon[reftCurrentUnits])
                            if not(iPlatoonMaxRange == nil) and iPlatoonMaxRange > 0 then
                                                --GetPositionNearTargetInSamePathingGroup(tStartPos, tTargetPos, iDistanceFromTarget, iAngleBase, oPathingUnit, iNearbyMethodIfBlocked, bTrySidePositions)
                                local iDistanceFromPDWanted = iPlatoonMaxRange - math.ceil(oPlatoon[refiCurrentUnits] / 4)
                                if iDistanceFromPDWanted < 0 then iDistanceFromPDWanted = 0 end
                                local tMoveTarget = GetPositionNearTargetInSamePathingGroup(tPlatoonPosition, oNearestPD:GetPosition(), iDistanceFromPDWanted, 0, GetPathingUnit(oPlatoon), 1, true)
                                if tMoveTarget then
                                    if bDebugMessages == true then LOG(sPlatoonName..oPlatoon[refiPlatoonCount]..': Move target for enemy PD='..repr(tMoveTarget)) end
                                    IssueMove(oPlatoon[reftCurrentUnits], tMoveTarget)
                                else
                                    --Have a nearby enemy PD but can't move within range of it - resume normal move path (but dont clear actions)
                                    ReissueMovementPath(oPlatoon, true)
                                end
                            else
                                LOG(sFunctionRef..':'..sPlatoonName..oPlatoon[refiPlatoonCount]..': Likely error - sent action to move within range of nearest PD, but platoon has no max range')
                            end
                        else
                            LOG(sFunctionRef..':'..sPlatoonName..oPlatoon[refiPlatoonCount]..': Likely error - sent action to move within range of nearest PD, and no nearby structures found')
                        end
                    else
                        LOG(sFunctionRef..':'..sPlatoonName..oPlatoon[refiPlatoonCount]..': Likely error - sent action to move within range of nearest PD, and no nearby structures found')
                    end
                elseif oPlatoon[refiCurrentAction] == refActionMoveToTemporaryLocation then
                    if bPlatoonNameDisplay == true then UpdatePlatoonName(oPlatoon, sPlatoonName..oPlatoon[refiPlatoonCount]..':ActionTempMove') end
                    if bDontClearActions == false then IssueClearCommands(oPlatoon[reftCurrentUnits]) end
                    if M27Utilities.IsTableEmpty(oPlatoon[reftTemporaryMoveTarget]) == true then
                        M27Utilities.ErrorHandler('Temporary move target is blank')
                    else
                        IssueMove(oPlatoon[reftCurrentUnits], oPlatoon[reftTemporaryMoveTarget])
                        MoveAlongPath(oPlatoon, oPlatoon[reftMovementPath], false, oPlatoon[refiCurrentPathTarget], true)
                    end
                else
                    --Unrecognised platoon action
                    if oPlatoon[refiCurrentAction]  then M27Utilities.ErrorHandler('Dont recognise the current platoon action='..oPlatoon[refiCurrentAction])
                        else M27Utilities.ErrorHandler('Platoon action is nil')
                    end
                end
                if bDebugMessages == true then LOG(sFunctionRef..': '..sPlatoonName..oPlatoon[refiPlatoonCount]..': end of function - ACU state='..M27Logic.GetUnitState(M27Utilities.GetACU(aiBrain))..'; curaction='..oPlatoon[refiCurrentAction]) end
            end
        else
            LOG(sFunctionRef..': PlatoonExists is no longer valid')
        end
    else
        LOG(sFunctionRef..': Platoon is no longer valid')
    end
end



function PlatoonInitialSetup(oPlatoon)
    --Updates platoon name and number of times its been called, then ensures segment pathing and mexes within the pathing group exist
    local bDebugMessages = false
    local sFunctionRef = 'PlatoonInitialSetup'
    local aiBrain = oPlatoon:GetBrain()
    local sPlatoonName = oPlatoon:GetPlan()
    --if sPlatoonName == 'M27ACUMain' then bDebugMessages = true end

    if aiBrain[refiLifetimePlatoonCount] == nil then aiBrain[refiLifetimePlatoonCount] = {} end
    if aiBrain[refiLifetimePlatoonCount][sPlatoonName] == nil then aiBrain[refiLifetimePlatoonCount][sPlatoonName] = 0 end
    aiBrain[refiLifetimePlatoonCount][sPlatoonName] = aiBrain[refiLifetimePlatoonCount][sPlatoonName] + 1
    oPlatoon[refiPlatoonCount] = aiBrain[refiLifetimePlatoonCount][sPlatoonName]
    local bPlatoonNameDisplay = false
    if ScenarioInfo.Options.AIPLatoonNameDebug == 'all' then bPlatoonNameDisplay = true end
    if bPlatoonNameDisplay == true then UpdatePlatoonName(oPlatoon, sPlatoonName..oPlatoon[refiPlatoonCount]..': ReturningToBase') end

    local oPathingUnit = GetPathingUnit(oPlatoon)
    local tPlatoonUnits = oPlatoon:GetPlatoonUnits()

    --Make sure action that give in this platoon repalces any existing action the platoon has:
    IssueClearCommands(tPlatoonUnits)
    local sPathingType
    if oPathingUnit == nil then
        LOG('PlatoonInitialSetup: Possible error - no pathing unit in platoon; sPlatoonName='..sPlatoonName..oPlatoon[refiPlatoonCount]..'; will disband platoon')
        if M27Utilities.IsTableEmpty(tPlatoonUnits) == false then LOG('PlatoonInitialSetup: tPlatoonUnits is not empty') end
        if oPlatoon and aiBrain:PlatoonExists(oPlatoon) then oPlatoon:PlatoonDisband() end
    else
        local tCurPos = oPathingUnit:GetPosition()
        local iCurSegmentX, iCurSegmentZ = M27MapInfo.GetSegmentFromPosition(tCurPos)
        sPathingType = M27Utilities.GetUnitPathingType(oPathingUnit)
        local iSegmentGroup = M27MapInfo.GetSegmentGroup(oPathingUnit, sPathingType, iCurSegmentX, iCurSegmentZ)
        if iSegmentGroup == nil then LOG('ERROR: '..sPlatoonName..oPlatoon[refiPlatoonCount]..': No segments that the platoon can path to') end
        M27MapInfo.RecordMexForPathingGroup(oPathingUnit)

        --Kiting logic (and ACU overcharge):
        oPlatoon[refbKiteEnemies] = false
        --Do we have an ACU in the platoon? If so set auto-overcharge to be on
        local tACUs = EntityCategoryFilterDown(categories.COMMAND, tPlatoonUnits)
        if not(tACUs == nil) then
            oPlatoon[refbACUInPlatoon] = true
            --for iACU, oACU in tACUs do
                --oACU:SetAutoOvercharge(true)
            --end
            oPlatoon[refbKiteEnemies] = true
        else
            oPlatoon[refbACUInPlatoon] = false
            --GetDirectFireUnitMinOrMaxRange(tUnits, iReturnRangeType)
            --    --Works if either sent a table of units or a single unit
            --    --iReturnRangeType: nil or 0: Return min+Max; 1: Return min only; 2: Return max only
            local iMaxDFRange = M27Logic.GetDirectFireUnitMinOrMaxRange(tPlatoonUnits, 2)
            if iMaxDFRange and iMaxDFRange > 22 then oPlatoon[refbKiteEnemies] = true end
        end

    end
    --Does the platoon contain builders or reclaimers? If so then flag to consider nearby mexes and reclaim respectively
    --(although below also updates the tables of these, these will be refreshed every platoon cycle anyway)
    local tBuilders = EntityCategoryFilterDown(categories.CONSTRUCTION, tPlatoonUnits)
    local bCanBuildMex = false
    if bDebugMessages == true then
        if tBuilders == nil then LOG(sFunctionRef..': '..sPlatoonName..oPlatoon[refiPlatoonCount]..': tBuilder size=nil')
            else LOG(sFunctionRef..': '..sPlatoonName..oPlatoon[refiPlatoonCount]..': tBuilder size='..table.getn(tBuilders))
        end
    end
    if M27Utilities.IsTableEmpty(tBuilders) == false then
        local iBuilderFaction
        local sFactionMexBPID
        for iBuilder, oBuilder in tBuilders do
            iBuilderFaction = M27Utilities.GetFactionFromBP(oBuilder:GetBlueprint())
            sFactionMexBPID = M27Utilities.GetBlueprintIDFromBuildingTypeAndFaction('T1Resource', iBuilderFaction)
            if oBuilder:CanBuild(sFactionMexBPID) then
                bCanBuildMex = true
                break
            end
        end
    end
    --Pathing range override
    if sPlatoonName == 'M27ACUMain' or sPlatoonName == 'M27AssistHydroEngi' then
        oPlatoon[refiOverrideDistanceToReachDestination] = 3 --ACU treated as reaching destination when it gets this close to it
    elseif M27Utilities.IsTableEmpty(tBuilders) == false then
        oPlatoon[refiOverrideDistanceToReachDestination] = 3
    end
    oPlatoon[refbConsiderMexes] = bCanBuildMex
    if bCanBuildMex == true then
        oPlatoon[reftBuilders] = tBuilders
    end

    local tReclaimers = EntityCategoryFilterDown(categories.RECLAIM, tPlatoonUnits)
    local bHaveReclaimers = false
    bHaveReclaimers = M27Utilities.IsTableEmpty(tReclaimers)
    oPlatoon[refbConsiderReclaim] = not(bHaveReclaimers)
    if bHaveReclaimers == true then
        oPlatoon[reftReclaimers] = tReclaimers
    end
    if bDebugMessages == true then
        LOG('oPlatoon[refbConsiderReclaim]='..tostring(oPlatoon[refbConsiderReclaim])..' oPlatoon[refbConsiderMexes]='..tostring(oPlatoon[refbConsiderMexes]))
        if tBuilders == nil then LOG(sFunctionRef..': '..sPlatoonName..oPlatoon[refiPlatoonCount]..': tBuilder size=nil')
        else LOG(sFunctionRef..': '..sPlatoonName..oPlatoon[refiPlatoonCount]..': tBuilder size='..table.getn(tBuilders))
        end
        if tReclaimers == nil then LOG(sFunctionRef..': '..sPlatoonName..oPlatoon[refiPlatoonCount]..': tReclaimers size=nil')
        else LOG(sFunctionRef..': '..sPlatoonName..oPlatoon[refiPlatoonCount]..': tReclaimers size='..table.getn(tReclaimers))
        end
    end

    --Does the platoon contain underwater land units?
    oPlatoon[refbPlatoonHasUnderwaterLand] = false
    oPlatoon[refbPlatoonHasOverwaterLand] = false
    if sPathingType == M27Utilities.refPathingTypeAmphibious then
        for iUnit, oUnit in tPlatoonUnits do
            if M27Utilities.IsUnitUnderwaterAmphibious(oUnit) == true then
                oPlatoon[refbPlatoonHasUnderwaterLand] = true
                break
            else
                oPlatoon[refbPlatoonHasOverwaterLand] = true
                break
            end
        end
    end
    --Follower support platoon logic:
    if sPlatoonName == 'M27MAAAssister' then oPlatoon[refiSupportHelperFollowDistance] = 10 end
    if bDebugMessages == true then LOG(sFunctionRef..': Check of ACU action') M27Overseer.DebugPrintACUPlatoon(aiBrain) end



end
