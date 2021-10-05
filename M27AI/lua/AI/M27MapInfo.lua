local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua') -- located in the lua.nx2 part of the FAF gamedata
local M27Utilities = import('/mods/M27AI/lua/M27Utilities.lua')
local M27Logic = import('/mods/M27AI/lua/AI/M27GeneralLogic.lua')


MassPoints = {} -- Stores position of each mass point (as a position value, i.e. a table with 3 values, x, y, z
tMexByPathingAndGrouping = {} --Stores position of each mex based on the segment that it's part of; [a][b][c]: [a] = pathing type ('Land' etc.); [b] = Segment grouping; [c] = Mex position
HydroPoints = {} -- Stores position values i.e. a table with 3 values, x, y, z
PlayerStartPoints = {} -- Stores position values i.e. a table with 3 values, x, y, z; item 1 = ARMY_1 etc.
tResourceNearStart = {} --[iArmy][iResourceType][iCount][tLocation] Stores location of mass extractors and hydrocarbons that are near to start locations; 1st value is the army number, 2nd value the resource type, 3rd the mex number, 4th value the position array (which itself is made up of 3 values)
MassCount = 0 -- used as a way of checking if have the core markers needed
HydroCount = 0
tReclaimAreas = {} --Stores reclaim info for each segment: tReclaimAreas[iSegmentX][iSegmentZ][x]; if x=1 returns total mass in area; if x=2 then returns position of largest reclaim in the area, if x=3 returns how many platoons have been sent here since the game started
--tLastReclaimRefreshByGroup = {} --time that last refreshed reclaim positions for [x] group
iLastReclaimRefresh = 0 --stores time that last refreshed reclaim positions
iMaxSegmentInterval = 80 --constant - no. of times to divide the map by segments for X (and separately for Z) so will end up with this value squared as the no. of segments
--iSegmentSizeX = 12
--iSegmentSizeZ = 12
--Experience significant slowdown of a couple of seconds at 100 (10k segments), so dont recommend much higher than 60s
tSegmentGroupBySegment = {} --table [a][b][c][d] holding the groupings for each segment: [a] = pathing type (Land, etc.); [b] = semgnet group; [c] and [d] =  segment X and Z numbers
tSegmentBySegmentGroup = {} --table holding the segment references in each grouping, split by pathing type:
local tSegmentGroupAllSegmentsMapped = {} --table [a][b], [a] = pathing type, [b] = group number; returns true if have mapped all segments against the group (i.e. used for reclaim so dont call the reclaim script multiple times)
    --[a][b][c]: a = pathing type ('Land', 'Amphibious', 'Air', 'Water'); b = segment group; c = semgent count (within that group); the result will then be the [x][z] segment numbers
iMaxGroups = {} --[sPathing] - returns the no. of groups currently have for a given pathing type
iMapTotalMass = 0 --Stores the total mass on the map
--tSegmentGroupReferencePos = {} --Table holding the engineer segment X and Z positions used for the group; e.g. [3][1] returns the X segment for group 3, [3][2] returns the Z position for group 3

tUnmappedMarker = {} --[sPathing][iResource]; iResource: 1=Mex, 2=Hydro, 3=PlayerStart; returns the marker location

function GetSegmentFromPosition(tPosition)
    --returns x and z values of the segment that tPosition is in
    local iMapSizeX, iMapSizeZ = GetMapSize()
    local iSegmentSizeX = iMapSizeX / iMaxSegmentInterval
    local iSegmentSizeZ = iMapSizeZ / iMaxSegmentInterval
    --local iSegmentSizeX = 1
    --local iSegmentSizeZ = 1
    local iSegmentX = math.floor(tPosition[1] / iSegmentSizeX)
    local iSegmentZ = math.floor(tPosition[3] / iSegmentSizeZ)
    return iSegmentX, iSegmentZ
end
function GetPositionFromSegment(iSegmentX, iSegmentZ)
    local bDebugMessages = false
    local iMapSizeX, iMapSizeZ = GetMapSize()
    local iSegmentSizeX = iMapSizeX / iMaxSegmentInterval
    local iSegmentSizeZ = iMapSizeZ / iMaxSegmentInterval
    --local iSegmentSizeX = 1
    --local iSegmentSizeZ = 1
    local iPosX = (iSegmentX+0.5) * iSegmentSizeX
    local iPosZ = (iSegmentZ+0.5) * iSegmentSizeZ
    if bDebugMessages == true then LOG('GetPositionFromSegment: iSegmentX,Z='..iSegmentX..'-'..iSegmentZ..'; iPosX='..iPosX..'; iPosZ='..iPosZ..'; iMapSizeXZ='..iMapSizeX..'-'..iMapSizeZ) end

    return {iPosX, GetTerrainHeight(iPosX, iPosZ), iPosZ}
end

function RecordResourceLocations()
    local bDebugMessages = false
    local sFunctionRef = 'RecordResourceLocations'
    MassCount = 0
    HydroCount = 0
    local iMarkerType
    local iResourceCount, sPathingType
    local iMaxPathingType = 4

    for _, v in ScenarioUtils.GetMarkers() do
        iMarkerType = 0
        if v.type == "Mass" then
            MassCount = MassCount + 1
            MassPoints[MassCount] = v.position
            if bDebugMessages == true then LOG(sFunctionRef..': Recording masspoints: co-ordinates = ' ..MassPoints[MassCount][1].. ' - ' ..MassPoints[MassCount][2].. ' - ' ..MassPoints[MassCount][3]) end
            iMarkerType = 1
            iResourceCount = MassCount
        end -- Mass
        if v.type == "Hydrocarbon" then
            HydroCount = HydroCount + 1
            HydroPoints[HydroCount] = v.position
            iMarkerType = 2
            iResourceCount = HydroCount
            if bDebugMessages == true then LOG(sFunctionRef..': Recording hydrocarbon points: co-ordinates = '..repr(HydroPoints[HydroCount])) end
        end -- Hydrocarbon
        --Update unmapped marker list:

        --[[for iPathingType = 1, iMaxPathingType do
            if iPathingType == 1 then sPathingType = M27Utilities.refPathingTypeAmphibious
            elseif iPathingType == 2 then sPathingType = M27Utilities.refPathingTypeNavy
            elseif iPathingType == 3 then sPathingType = M27Utilities.refPathingTypeAir
            else sPathingType = M27Utilities.refPathingTypeLand
            end ]]--
        if iMarkerType > 0 then
            for iPathingType, sPathingType in M27Utilities.refPathingTypeAll do
                if tUnmappedMarker[sPathingType] == nil then tUnmappedMarker[sPathingType] = {} end
                if tUnmappedMarker[sPathingType][iMarkerType] == nil then tUnmappedMarker[sPathingType][iMarkerType] = {} end
                tUnmappedMarker[sPathingType][iMarkerType][iResourceCount] = v.position
            end
        end
    end -- GetMarkers() loop
    -- MapMexCount = MassCount
end

function RecordResourceNearStartPosition(iArmy, iMaxDistance, bCountOnly, bMexNotHydro)
    -- iArmy is the army number, e.g. 1 for ARMY_1; iMaxDistance is the max distance for a mex to be returned (this only works the first time ever this function is called)
    --bMexNotHydro - true if looking for nearby mexes, false if looking for nearby hydros; defaults to true

    -- Returns a table containing positions of any mex meeting the criteria, unless bCountOnly is true in which case returns the no. of such mexes

    local bDebugMessages = false
    if iMaxDistance == nil then iMaxDistance = 12 end --NOTE: As currently only run the actual code to locate nearby mexes once, the first iMaxDistance will determine what to use, and any subsequent uses it wont matter
    if bMexNotHydro == nil then bMexNotHydro = true end
    if bCountOnly == nil then bCountOnly = false end
    local iResourceCount = 0
    local iResourceType = 1 --1 = mex, 2 = hydro
    if bMexNotHydro == false then iResourceType = 2 end

    if tResourceNearStart[iArmy] == nil then tResourceNearStart[iArmy] = {} end
    if tResourceNearStart[iArmy][iResourceType] == nil then
        --Haven't determined nearby resource yet
        local iDistance = 0
        local pStartPos =  PlayerStartPoints[iArmy]

        tResourceNearStart[iArmy][iResourceType] = {}
        local AllResourcePoints = {}
        if bMexNotHydro then AllResourcePoints = MassPoints
        else AllResourcePoints = HydroPoints end

        if not(AllResourcePoints == nil) then
            for key,pResourcePos in AllResourcePoints do
                iDistance = M27Utilities.GetDistanceBetweenPositions(pStartPos, pResourcePos)
                if iDistance <= iMaxDistance then
                    if bDebugMessages == true then LOG('Found position near to start; iDistance='..iDistance..'; imaxDistance='..iMaxDistance..'; pStartPos[1][3]='..pStartPos[1]..'-'..pStartPos[3]..'; pResourcePos='..pResourcePos[1]..'-'..pResourcePos[3]..'; bMexNotHydro='..tostring(bMexNotHydro)) end
                    iResourceCount = iResourceCount + 1
                    if tResourceNearStart[iArmy][iResourceType][iResourceCount] == nil then tResourceNearStart[iArmy][iResourceType][iResourceCount] = {} end
                    tResourceNearStart[iArmy][iResourceType][iResourceCount] = pResourcePos
                end
            end
        end
    end
    if bCountOnly == false then
        --Create a table of nearby resource locations:
        local NearbyResourcePos = {}
        for iCurResource, v in tResourceNearStart[iArmy][iResourceType] do
            NearbyResourcePos[iResourceCount] = v
        end
        return NearbyResourcePos
    else
        iResourceCount = 0
        for iCurResource, v in tResourceNearStart[iArmy][iResourceType] do
            iResourceCount = iResourceCount + 1
            if bDebugMessages == true then LOG('valid resource location iResourceCount='..iResourceCount..'; v[1-3]='..v[1]..'-'..v[2]..'-'..v[3]) end
        end
        if bDebugMessages == true then LOG('RecordResourceNearStartPosition: iResourceCount='..iResourceCount..'; bmexNotHydro='..tostring(bMexNotHydro)..'; iMaxDistance='..iMaxDistance) end
        return iResourceCount
    end
end
function RecordMexNearStartPosition(iArmy, iMaxDistance, bCountOnly)
    return RecordResourceNearStartPosition(iArmy, iMaxDistance, bCountOnly, true)
end

function RecordHydroNearStartPosition(iArmy, iMaxDistance, bCountOnly)
    return RecordResourceNearStartPosition(iArmy, iMaxDistance, bCountOnly, false)
end

function RecordPlayerStartLocations()
    -- Updates PlayerStartPoints to Record all the possible player start points
    local bDebugMessages = false
    local iMarkerType = 3
    for i = 1, 16 do
        local tempPos = ScenarioUtils.GetMarker('ARMY_'..i).position
        if tempPos ~= nil then
            PlayerStartPoints[i] = tempPos
            if bDebugMessages == true then LOG('* M27AI: Recording Player start point, ARMY_'..i..' x=' ..PlayerStartPoints[i][1]..';y='..PlayerStartPoints[i][2]..';z='..PlayerStartPoints[i][3]) end
            for iPathingType, sPathingType in M27Utilities.refPathingTypeAll do
                if tUnmappedMarker[sPathingType] == nil then tUnmappedMarker[sPathingType] = {} end
                if tUnmappedMarker[sPathingType][iMarkerType] == nil then tUnmappedMarker[sPathingType][iMarkerType] = {} end
                tUnmappedMarker[sPathingType][iMarkerType][i] = tempPos
            end
        end
    end
end

function GetResourcesNearTargetLocation(tTargetPos, iMaxDistance, bMexNotHydro)
    --Returns a table of locations of the chosen resource within iMaxDistance of tTargetPos
    --returns nil if no matches

    local bDebugMessages = false
    if iMaxDistance == nil then iMaxDistance = 7 end
    if bMexNotHydro == nil then bMexNotHydro = true end
    local iResourceCount = 0
    local iResourceType = 1 --1 = mex, 2 = hydro
    if bMexNotHydro == false then iResourceType = 2 end

    local iDistance = 0
    local tAllResourcePoints = {}
    if bMexNotHydro then tAllResourcePoints = MassPoints
    else tAllResourcePoints = HydroPoints end
    local tNearbyResources = {}

    if not(tAllResourcePoints == nil) then
        for key,pResourcePos in tAllResourcePoints do
            iDistance = M27Utilities.GetDistanceBetweenPositions(tTargetPos, pResourcePos)
            if iDistance <= iMaxDistance then
                if bDebugMessages == true then LOG('GetResourcesNearTarget: Found position near to target location; iDistance='..iDistance..'; imaxDistance='..iMaxDistance..'; tTargetPos[1][3]='..tTargetPos[1]..'-'..tTargetPos[3]..'; pResourcePos='..pResourcePos[1]..'-'..pResourcePos[3]..'; bMexNotHydro='..tostring(bMexNotHydro)) end
                iResourceCount = iResourceCount + 1
                tNearbyResources[iResourceCount] = {}
                tNearbyResources[iResourceCount] = pResourcePos
            end
        end
    end
    return tNearbyResources
end

function AddSegmentToGroup(sPathing, iGroup, iSegmentX, iSegmentZ)
    --Adds iSegmentX+Z to iGroup for sPathing (done so that can call this from multiple places)
    if tSegmentBySegmentGroup[sPathing] == nil then tSegmentBySegmentGroup[sPathing] = {} end
    local iExistingSegments
    if tSegmentBySegmentGroup[sPathing][iGroup] == nil then
        iExistingSegments = 0
        tSegmentBySegmentGroup[sPathing][iGroup] = {}
    else
        iExistingSegments = table.getn(tSegmentBySegmentGroup[sPathing][iGroup])
    end
    if iExistingSegments == nil then iExistingSegments = 0 end
    iExistingSegments = iExistingSegments + 1

    tSegmentBySegmentGroup[sPathing][iGroup][iExistingSegments] = {iSegmentX, iSegmentZ}

    if tSegmentGroupBySegment[sPathing] == nil then tSegmentGroupBySegment[sPathing] = {} end
    if tSegmentGroupBySegment[sPathing][iSegmentX] == nil then tSegmentGroupBySegment[sPathing][iSegmentX] = {} end
    tSegmentGroupBySegment[sPathing][iSegmentX][iSegmentZ] = iGroup
    end

function InSameSegmentGroup(oUnit, tDestination, bReturnUnitGroupOnly)
    --Returns true if oUnit is in same group as tDestination
    --if bReturnUnitGroupOnly is true then instead returns the Grouping number of the segment that oUnit is in
    --will update map grouping public variables if haven't determined the grouping for oUnit (or tDestination)

    --[[Code logic:
    Divide the map into segments
    Check if have already determined the grouping for the segment that oUnit is in
    If it's not been determined, then see if it's been determined for any other segments
    If it's not been determined for any other segments, then create a new grouping, which contains the unit's current segment; then see if the unit can map to key markers (mex and hydro locations and player start points), and record these in the same group if they can be pathed to by the unit
    If instead other segments have already been identified, then see if the unit can path to the first segment in each identified group (and if so assign it to this group); if it can't, then create a new group for the unit, and see if there are any remaining key markers that haven't been mapped (which can be pathed to by the unit)
    Finally, see if the target destination's segment has already been assigned a group; if not, then see if the unit can path to it, and if it can, assign it a group
    ]]
    if bReturnUnitGroupOnly == nil then bReturnUnitGroupOnly = false end
    local bDebugMessages = false
    local sFunctionRef = 'InSameSegmentGroup'
    local bCanPathToDestination = false
    local iUnitGroup
    local bIgnore
    local sPathing
    if oUnit == nil or oUnit.Dead then
        M27Utilities.ErrorHandler('oUnit is nil or dead')
        bCanPathToDestination = false
        iUnitGroup = iMaxGroups[M27Utilities.refPathingTypeLand]
        bIgnore = true
    else
        local iExistingSegments, iMaxLocations, iTargetSegmentX, iTargetSegmentZ, iRemoveCount
        sPathing = M27Utilities.GetUnitPathingType(oUnit)
        local iUnitSegmentX, iUnitSegmentZ = GetSegmentFromPosition(oUnit:GetPosition())
        iUnitGroup = tSegmentGroupBySegment[sPathing][iUnitSegmentX][iUnitSegmentZ]
        if bDebugMessages == true then LOG(sFunctionRef..': oUnit position='..repr(oUnit:GetPosition())) end

        local iFirstSegmentOfGroupX, iFirstSegmentOfGroupZ
        local oFirstUnit
        if bDebugMessages == true then LOG(sFunctionRef..': iUnitSegmentXZ='..iUnitSegmentX..'-'..iUnitSegmentZ) end
        if iUnitGroup == nil then
            --Determine group - cycle through each group and see if can map to first entry:
            if iMaxGroups[sPathing] == nil then iMaxGroups[sPathing] = 0 end
            if iMaxGroups[sPathing] > 0 then
                for iCurGroup = 1, iMaxGroups[sPathing] do
                    --if CanPathTo(oUnit, GetSegmentFromPosition(tSegmentBySegmentGroup[sPathing][1])) == true then
                    --if bDebugMessages == true then LOG('About to print tSegmentBySegmentGroup; iCurGroup='..iCurGroup) end
                    --if bDebugMessages == true then LOG(repr(tSegmentBySegmentGroup[sPathing][iCurGroup])) end
                    --Can we path to the first segment recorded for the current group:
                    iFirstSegmentOfGroupX = tSegmentBySegmentGroup[sPathing][iCurGroup][1][1]
                    iFirstSegmentOfGroupZ = tSegmentBySegmentGroup[sPathing][iCurGroup][1][2]
                    if bDebugMessages == true then LOG('FirstSegmentX,Z='..iFirstSegmentOfGroupX..'-'..iFirstSegmentOfGroupZ) end
                    --if bDebugMessages == true then LOG('Output of GetPositionFromSegment='..repr(GetPositionFromSegment(iFirstSegmentOfGroupX, iFirstSegmentOfGroupZ))) end
                    if oUnit:CanPathTo(GetPositionFromSegment(iFirstSegmentOfGroupX, iFirstSegmentOfGroupZ)) == true then
                        iUnitGroup = iCurGroup
                        AddSegmentToGroup(sPathing, iUnitGroup, iUnitSegmentX, iUnitSegmentZ)
                        if bDebugMessages == true then LOG(sFunctionRef..': Can path to first segment of iUnitGroup='..iUnitGroup..'; ending code') end
                        break
                    end
                end
            end
            --been through all existing groups if any - if not got a group then create a new one:
            if iUnitGroup == nil then
                if bDebugMessages == true then LOG(sFunctionRef..': Cant path to any existing groups, so creating a new one') end
                if iMaxGroups[sPathing] == nil then iMaxGroups[sPathing] = 0 end
                iMaxGroups[sPathing] = iMaxGroups[sPathing] + 1
                iUnitGroup = iMaxGroups[sPathing]
                AddSegmentToGroup(sPathing, iUnitGroup, iUnitSegmentX, iUnitSegmentZ)

                --Cycle through each unmapped marker location; if can path to it then add to the same group and remove from the table of unmapped locations
                for iMethod = 1, 2 do
                    for iLocationType = 1, 3 do
                        iRemoveCount = 0
                        if not(tUnmappedMarker[sPathing][iLocationType]==nil) then
                            iMaxLocations = table.getn(tUnmappedMarker[sPathing][iLocationType - iRemoveCount])
                            if iMaxLocations > 0 then
                                for iLocationCount = 1, iMaxLocations do
                                    if bDebugMessages == true then
                                        LOG(sFunctionRef..': Within loop: iMethod='..iMethod..'; iLocationType='..iLocationType..'; iLocationCount='..iLocationCount..';iMaxLocations='..iMaxLocations..'; iRemoveCount='..iRemoveCount)
                                        --LOG(repr(tUnmappedMarker[sPathing][iLocationType]))
                                    end
                                    iTargetSegmentX, iTargetSegmentZ = GetSegmentFromPosition(tUnmappedMarker[sPathing][iLocationType][iLocationCount - iRemoveCount])
                                    if iMethod == 1 then
                                        --Add location to group if can path to it:
                                        --if CanPathTo(oUnit, tLocation) == true then
                                        if oUnit:CanPathTo(tUnmappedMarker[sPathing][iLocationType][iLocationCount - iRemoveCount]) == true then
                                            if bDebugMessages == true then LOG(sFunctionRef..': Able to path to segment '..iTargetSegmentX..'-'..iTargetSegmentZ) end
                                            AddSegmentToGroup(sPathing, iUnitGroup, iTargetSegmentX, iTargetSegmentZ)
                                        else
                                            if bDebugMessages == true then LOG(sFunctionRef..': Cant path to segment '..iTargetSegmentX..'-'..iTargetSegmentZ) end
                                        end
                                    else
                                        --Remove any markers now mapped:
                                        if not(tSegmentGroupBySegment[sPathing][iTargetSegmentX][iTargetSegmentZ] == nil) then
                                            table.remove(tUnmappedMarker[sPathing][iLocationType], iLocationCount - iRemoveCount)
                                            iRemoveCount = iRemoveCount + 1
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                --Update list of mexes by group
                RecordMexForPathingGroup(oUnit)
                if bDebugMessages == true then
                    local tTempLocationList = {}
                    local iTempLocationCount = 0
                    for iLocation, tSegments in tSegmentBySegmentGroup[sPathing][iUnitGroup] do
                        iTempLocationCount = iTempLocationCount + 1
                        LOG(sFunctionRef..': About to do repr of tSegments')
                        LOG(repr(tSegments))
                        tTempLocationList[iTempLocationCount] = {}
                        tTempLocationList[iTempLocationCount] = GetPositionFromSegment(tSegments[1], tSegments[2])
                    end
                    M27Utilities.DrawLocations(tTempLocationList)
                end
                --If amphibious then map all reclaim positions (since will need to later anyway):
                if sPathing == M27Utilities.refPathingTypeAmphibious then
                    if tSegmentGroupAllSegmentsMapped[sPathing] == nil then tSegmentGroupAllSegmentsMapped[sPathing] = {} end
                    if tSegmentGroupAllSegmentsMapped[sPathing][iUnitGroup] == nil then tSegmentGroupAllSegmentsMapped[sPathing][iUnitGroup] = false end
                    if tSegmentGroupAllSegmentsMapped[sPathing][iUnitGroup] == false then
                        local iMapSizeX, iMapSizeZ = GetMapSize()
                        local iMaxSegmentX = iMaxSegmentInterval
                        local iMaxSegmentZ = iMaxSegmentInterval

                        for iCurSegX = 1, iMaxSegmentX do
                            for iCurSegZ = 1, iMaxSegmentZ do
                                if tSegmentGroupBySegment[sPathing][iUnitGroup][iCurSegX][iCurSegZ] == nil then
                                    if oUnit:CanPathTo(GetPositionFromSegment(iCurSegX, iCurSegZ)) == true then
                                        AddSegmentToGroup(sPathing, iUnitGroup, iCurSegX, iCurSegZ)
                                    end
                                end
                            end
                        end
                        tSegmentGroupAllSegmentsMapped[sPathing][iUnitGroup] = true
                    end
                end

            end
        else
            if bDebugMessages == true then LOG(sFunctionRef..': Identified unit group via existing table, iUnitGroup='..iUnitGroup) end
        end
    end
    --now will have group for ounit; check if have one for destination, and if not see if can path there:
    if bReturnUnitGroupOnly == true then return iUnitGroup
        else
        if bIgnore == true then
            --Do nothing - already set to false before (error handling)
        else
            bCanPathToDestination = false
            if bDebugMessages == true then LOG(sFunctionRef..': tDestination='..repr(tDestination)) end
            iTargetSegmentX, iTargetSegmentZ = GetSegmentFromPosition(tDestination)
            local iDestinationGroup = tSegmentGroupBySegment[sPathing][iTargetSegmentX][iTargetSegmentX]
            if iDestinationGroup == nil then
                --if CanPathTo(oUnit, tDestination) == true then
                if tDestination[2] == nil then tDestination[2] = GetTerrainHeight(tDestination[1], tDestination[3]) end
                if oUnit:CanPathTo(tDestination) == true then
                    AddSegmentToGroup(sPathing, iUnitGroup, iTargetSegmentX, iTargetSegmentZ)
                    bCanPathToDestination = true
                end
            elseif iDestinationGroup == iUnitGroup then bCanPathToDestination = true
            end
        end
        return bCanPathToDestination
    end
end

function GetSegmentGroup(oUnit, sPathing, iSegmentX, iSegmentZ)
    --returns the unit group of iSegmentX and iSegmentZ, or calls InSameSegmentGroup if not known
    --Intended as more efficient call than InSameSegmentGroup
    local iSegmentGroup = tSegmentGroupBySegment[sPathing][iSegmentX][iSegmentZ]
    if iSegmentGroup == nil then
        if InSameSegmentGroup(oUnit, GetPositionFromSegment(iSegmentX, iSegmentZ), false) == true then
            iSegmentGroup = InSameSegmentGroup(oUnit, GetPositionFromSegment(iSegmentX, iSegmentZ), true)
        end
    end
    return iSegmentGroup
end

function GetReclaimablesMassValue(tReclaimables, bAlsoReturnLargestReclaimPosition, iIgnoreReclaimIfNotMoreThanThis)
    local bDebugMessages = false
    local sFunctionRef = 'GetReclaimablesMassValue'
    if bAlsoReturnLargestReclaimPosition == nil then bAlsoReturnLargestReclaimPosition = false end
    if iIgnoreReclaimIfNotMoreThanThis == nil then iIgnoreReclaimIfNotMoreThanThis = 0 end
    if iIgnoreReclaimIfNotMoreThanThis < 0 then iIgnoreReclaimIfNotMoreThanThis = 0 end
    local iMedMassThreshold = 20 --as per large mass threshold
    local iLargeMassThreshold = 150 --any mass with a value more than iLargeMassTreshold gets increased in weighted value by iLargeMassMod
    local iMedMassMod = 2 --increases value of mass over a particular threshold by this
    local iLargeMassMod = 2 --increases value of mass over a particular threshold by this (multiplicative with iMedMassMod)

    local tWreckPos = {}
    local iCurMassValue
    local iTotalMassValue = 0
    local iLargestCurReclaim = 0
    local tReclaimPos = {}
    if tReclaimables and table.getn( tReclaimables ) > 0 then
        for _, v in tReclaimables do
            tWreckPos = v.CachePosition
            if not (tWreckPos[1]==nil) then
                if v.MaxMassReclaim > iIgnoreReclaimIfNotMoreThanThis then
                    -- Determine mass - reduce low value mass value for weighting purposes (since it takes longer to get):
                    --if bDebugMessages == true then LOG('Have wrecks with a valid position and positive mass value within the segment iCurXZ='..iCurX..'-'..iCurZ..'; iWreckNo='.._) end
                    iCurMassValue = v.MaxMassReclaim / (iMedMassMod * iLargeMassMod)
                    if iCurMassValue >= iMedMassThreshold then iCurMassValue = iCurMassValue * iMedMassMod end
                    if iCurMassValue >= iLargeMassThreshold then iCurMassValue = iCurMassValue * iLargeMassMod end
                    iTotalMassValue = iTotalMassValue + iCurMassValue
                    if iCurMassValue > iLargestCurReclaim then
                        iLargestCurReclaim = iCurMassValue
                        tReclaimPos = {tWreckPos[1], tWreckPos[2], tWreckPos[3]}
                    end
                end
                --bIsProp = IsProp(v)
            else
                if not(v.MaxMassReclaim == nil) then
                    if v.MaxMassReclaim > 0 then
                        if bDebugMessages == true then LOG(sFunctionRef..': Warning - have ignored wreck location despite it having a mass reclaim value') end
                    end
                end
            end
        end
    end
    if bAlsoReturnLargestReclaimPosition then
        return iTotalMassValue, tReclaimPos
    else return iTotalMassValue end
end

function GetNearestReclaim(tLocation, iSearchRadius, iMinReclaimValue)
    --Returns the object/wreck of the nearest reclaim that is more than iMinReclaimValue and within iSearchRadius of tLocation
    --returns nil if no valid locations
    local bDebugMessages = false
    local sFunctionRef = 'GetNearestReclaim'
    if iMinReclaimValue == nil then iMinReclaimValue = 1 end
    if iSearchRadius == nil then iSearchRadius = 5 end
    local tRectangle = Rect(tLocation[1] - iSearchRadius, tLocation[3] - iSearchRadius, tLocation[1] + iSearchRadius, tLocation[3] + iSearchRadius)
    local tReclaimables = GetReclaimablesInRect(tRectangle)
    local tCurWreckPosition = {}
    local iCurWreckReclaim
    local iDistToPosition
    local iMinDistToPosition = 10000
    local iClosestWreck
    if bDebugMessages == true then
        if M27Utilities.IsTableEmpty(tReclaimables) then LOG(sFunctionRef..': tReclaimables is empty')
            else LOG(sFunctionRef..': tReclaimables size='..table.getn(tReclaimables)) end
    end
    if M27Utilities.IsTableEmpty(tReclaimables) == false then
        for iWreck, oWreck in tReclaimables do
            tCurWreckPosition = oWreck.CachePosition
            if not (tCurWreckPosition[1]==nil) then
                iCurWreckReclaim = oWreck.MaxMassReclaim
                if iCurWreckReclaim >= iMinReclaimValue then
                    iDistToPosition = M27Utilities.GetDistanceBetweenPositions(tLocation, tCurWreckPosition)
                    if bDebugMessages == true then LOG(sFunctionRef..': iWreck='..iWreck..'; iDistToPosition='..iDistToPosition..'; iCurWreckReclaim='..iCurWreckReclaim..'; iSearchRadius='..iSearchRadius..'; iMinDistToPosition='..iMinDistToPosition) end
                    if iDistToPosition <= iSearchRadius then
                        if iDistToPosition <= iMinDistToPosition then
                            iMinDistToPosition = iDistToPosition
                            iClosestWreck = iWreck
                        end
                    end
                end
            end
        end
    end
    if iClosestWreck == nil then
        if bDebugMessages == true then LOG(sFunctionRef..': No reclaimable objects found, returning nil') end
        return nil
    else
        if bDebugMessages == true then LOG(sFunctionRef..': returning reclaimable object') end
        return tReclaimables[iClosestWreck] end
end

function UpdateReclaimMarkers()
    --Divides map into segments, determines reclaim in each segment and stores this in tReclaimAreas along with the location of the highest reclaim in this segment
    --if oEngineer isn't nil then it will also determine if the segment is pathable
    --Updates the global variable tReclaimAreas{}
    --Config settings:
    --Note: iMaxSegmentInterval defined at the top as a global variable
    local bDebugMessages = false --set to true for certain positions where want logs to print

    local iTimeBeforeFullRefresh = 60 --Will do a full refresh of reclaim every 1m


    local bDoFullRefresh = false
    local tReclaimPos = {}
    local iLargestCurReclaim
    local iMapSizeX, iMapSizeZ = GetMapSize()
    local iSegmentSizeX = iMapSizeX / iMaxSegmentInterval
    local iSegmentSizeZ = iMapSizeZ / iMaxSegmentInterval
    local tReclaimables = {}
    local iTotalMassValue


    --local iLastReclaimRefresh = tLastReclaimRefreshByGroup[iEngSegmentGroup]
    if iLastReclaimRefresh==nil then bDoFullRefresh = true
        if bDebugMessages == true then LOG('This is the first time reclaim is being determined for the map') end
    else
        if iLastReclaimRefresh == 0 then bDoFullRefresh = true
            if bDebugMessages == true then LOG('This is the first time reclaim is being determined for the map') end
        else
            if GetGameTimeSeconds() - iLastReclaimRefresh >= iTimeBeforeFullRefresh then bDoFullRefresh = true if bDebugMessages == true then LOG('UpdateReclaimMarkers: Sufficient time has elapsed since last refresh so re-doing reclaim values') end
            elseif bDebugMessages == true then LOG('UpdateReclaimMarkers: Insufficient time since last reclaim refresh so not refreshing') end
        end
    end
    --Record all segments' mass information:
    if bDoFullRefresh then
        if bDebugMessages == true then LOG('ReclaimRefresh: About to do full refresh') end
        iLastReclaimRefresh = GetGameTimeSeconds()
        tReclaimPos = {}
        iMapTotalMass = 0
        for iCurX = 1, iMaxSegmentInterval do
            for iCurZ = 1, iMaxSegmentInterval do
        --for iCurX = 1, math.floor(iMapSizeX / iSegmentSizeX) do
            --for iCurZ = 1, math.floor(iMapSizeZ / iSegmentSizeZ) do
                if bDebugMessages == true then LOG('Cycling through each segment; iCurX='..iCurX..'; iCurZ='..iCurZ) end

                iTotalMassValue = 0
                tReclaimables = GetReclaimablesInRect(Rect((iCurX - 1) * iSegmentSizeX, (iCurZ - 1) * iSegmentSizeZ, iCurX * iSegmentSizeX, iCurZ * iSegmentSizeZ))
                iLargestCurReclaim = 0
                if tReclaimables and table.getn( tReclaimables ) > 0 then
                    -- local iWreckCount = 0
                    --local bIsProp = nil  --only used for log/testing
                    if bDebugMessages == true then LOG('Have wrecks within the segment iCurXZ='..iCurX..'-'..iCurZ) end
                    iTotalMassValue, tReclaimPos = GetReclaimablesMassValue(tReclaimables, true)

                    --Record this table:
                    if tReclaimAreas[iCurX] == nil then
                        tReclaimAreas[iCurX] = {}
                        if bDebugMessages == true then LOG('Setting table to nothing as is currently nil; iCurX='..iCurX) end
                    end
                    if tReclaimAreas[iCurX][iCurZ] == nil then tReclaimAreas[iCurX][iCurZ] = {} end
                    tReclaimAreas[iCurX][iCurZ][1] = iTotalMassValue
                    tReclaimAreas[iCurX][iCurZ][2] = {}
                    tReclaimAreas[iCurX][iCurZ][2] = GetPositionFromSegment(iCurX, iCurZ)
                end
                iMapTotalMass = iMapTotalMass + iTotalMassValue
                if bDebugMessages == true then LOG('iCurX='..iCurX..'; iCurZ='..iCurZ..'; iMapTotalMass='..iMapTotalMass..'; iTotalMassValue='..iTotalMassValue) end
            end
            WaitTicks(1)
        end
        if bDebugMessages == true then LOG('Finished updating reclaim areas') end
    end
end

function RecordMexForPathingGroup(oPathingUnit)
    --Updates tMexByPathingAndGrouping to record the mex that are in the same pathing group as oPathingUnit
    local bDebugMessages = false
    local sFunctionRef = 'RecordMexForPathingGroup'
    if oPathingUnit and not(oPathingUnit.Dead) then
        local sPathingType = M27Utilities.GetUnitPathingType(oPathingUnit)
        local tUnitPosition = oPathingUnit:GetPosition()
        local iUnitSegmentX, iUnitSegmentZ = GetSegmentFromPosition(tUnitPosition)
        --GetSegmentGroup(oUnit, sPathing, iSegmentX, iSegmentZ)
        local iSegmentGroup = GetSegmentGroup(oPathingUnit, sPathingType, iUnitSegmentX, iUnitSegmentZ)
        if bDebugMessages == true then LOG(sFunctionRef..': , sPathingType='..sPathingType..'; iSegmentGroup='..iSegmentGroup) end
        if tMexByPathingAndGrouping[sPathingType] == nil then tMexByPathingAndGrouping[sPathingType] = {} end
        if tMexByPathingAndGrouping[sPathingType][iSegmentGroup] == nil then
            --Need to record mass locations for this:
            tMexByPathingAndGrouping[sPathingType][iSegmentGroup] = {}
            local iCurSegmentX, iCurSegmentZ
            local iCurSegmentGroup
            local iValidCount = 0
            for iCurMex=1, table.getn(MassPoints) do
                iCurSegmentX, iCurSegmentZ = GetSegmentFromPosition(MassPoints[iCurMex])
                iCurSegmentGroup = GetSegmentGroup(oPathingUnit, sPathingType, iCurSegmentX, iCurSegmentZ)
                if not(iCurSegmentGroup==nil) then
                    if bDebugMessages == true then LOG(sFunctionRef..': iCurSegmentGroup='..iCurSegmentGroup..'; iCurMex='..iCurMex) end
                    if iCurSegmentGroup == iSegmentGroup then
                        --Mex is in the same pathing group, so record it
                        iValidCount = iValidCount + 1
                        tMexByPathingAndGrouping[sPathingType][iSegmentGroup][iValidCount] = {}
                        tMexByPathingAndGrouping[sPathingType][iSegmentGroup][iValidCount] = MassPoints[iCurMex]
                        if bDebugMessages == true then LOG(sFunctionRef..': Segment '..iCurSegmentX..'-'..iCurSegmentZ..' is in a pathing group, so adding it to recorded mexes, iValidCount='..iValidCount) end
                    else
                        if bDebugMessages == true then LOG(sFunctionRef..': Segment '..iCurSegmentX..'-'..iCurSegmentZ..' isnt in pathing group '..iSegmentGroup) end
                    end
                else
                    if bDebugMessages == true then LOG(sFunctionRef..': Segment '..iCurSegmentX..'-'..iCurSegmentZ..' isnt in pathing group '..iSegmentGroup) end
                end
            end
        end
        if bDebugMessages == true then LOG(sFunctionRef..': table.getn of mexbypathing for sPathingType='..sPathingType..'; iSegmentGroup='..iSegmentGroup..'; table.getn='..table.getn(tMexByPathingAndGrouping[sPathingType][iSegmentGroup])) end
    else
        M27Utilities.ErrorHandler('pathing unit is nil or dead so not recording mexes')
    end

end

function GetNumberOfResource (aiBrain, bMexNotHydro, bUnclaimedOnly, bVisibleOnly, iType)
    --iType: 1 = mexes nearer to aiBrain than nearest enemy (in future can add more, e.g. entire map; mexes closer to us than ally, etc.)
    --bUnclaimedOnly - true if mex can't have an extractor on it
    local bDebugMessages = false
    local sFunctionRef = 'GetNumberOfResource'
    if aiBrain then
        if bVisibleOnly == nil then bVisibleOnly = true end
        if M27Utilities.IsTableEmpty(PlayerStartPoints) then RecordPlayerStartLocations() end
        if bDebugMessages == true then LOG(sFunctionRef..': PlayerStartPoints='..repr(PlayerStartPoints)..'; aiBrain army index='..aiBrain:GetArmyIndex()) end
        local tOurStartPos = PlayerStartPoints[aiBrain.M27StartPositionNumber]
        local iEnemyStartNumber = M27Logic.GetNearestEnemyStartNumber(aiBrain)
        local iResourceCount = 0
        if iEnemyStartNumber == nil then
            M27Utilities.ErrorHandler('iEnemyStartNumber is nil')
        else
            local tEnemyStartPos = PlayerStartPoints[iEnemyStartNumber]
            local bIncludeResource
            local oPossibleBuildingsNearPosition = {}
            local oResourcesNearPosition = {}
            local iHalfSize = 2 * 0.5 + 1
            local tMapResources
            if bMexNotHydro == nil then bMexNotHydro = true end
            if bMexNotHydro == true then
                tMapResources = MassPoints
                iHalfSize = 6 * 0.5 + 1
            else tMapResources = HydroPoints end

            if bDebugMessages == true then LOG(sFunctionRef..': tOurStartPos='..tOurStartPos[1]..'-'..tOurStartPos[3]) end
            if bDebugMessages == true then LOG(sFunctionRef..': tEnemyStartPos='..tEnemyStartPos[1]..'-'..tEnemyStartPos[3]) end
            for iCurMex, tResourcePosition in tMapResources do
                bIncludeResource = false
                --Check if is in a valid location based in iType:
                if bDebugMessages == true then LOG(sFunctionRef..': tResourcePosition='..tResourcePosition[1]..'-'..tResourcePosition[3]..'; tEnemyStartPos='..tEnemyStartPos[1]..'-'..tEnemyStartPos[3]..'; tOurStartPos='..tOurStartPos[1]..'-'..tOurStartPos[3]) end
                if iType == 1 then
                    if bDebugMessages == true then LOG(sFunctionRef..': iType==1, checking distance between positions') end
                    if M27Utilities.IsTableEmpty(tEnemyStartPos) == true then
                        M27Utilities.ErrorHandler('tEnemyStartPos is nil')
                        bIncludeResource = true
                    else
                        if M27Utilities.GetDistanceBetweenPositions(tResourcePosition, tEnemyStartPos) >= M27Utilities.GetDistanceBetweenPositions(tResourcePosition, tOurStartPos) then
                            if bDebugMessages == true then LOG(sFunctionRef..': Mex is further from enemy start than our start') end
                            bIncludeResource = true
                        else if bDebugMessages == true then LOG(sFunctionRef..': Mex is further from our start than enemy') end
                        end
                    end
                else
                    bIncludeResource = true
                end

                --check if needs to be unclaimed:
                if bIncludeResource == true and bUnclaimedOnly == true then
                    bIncludeResource = false
                    oPossibleBuildingsNearPosition = GetUnitsInRect(Rect(tResourcePosition[1]-iHalfSize, tResourcePosition[3]-iHalfSize, tResourcePosition[1]+iHalfSize, tResourcePosition[3]+iHalfSize))
                    if oPossibleBuildingsNearPosition == nil then bIncludeResource = true
                    else
                        if table.getn(oPossibleBuildingsNearPosition) == 0 then bIncludeResource = true
                        else
                            if bDebugMessages == true then LOG(sFunctionRef..': Have a unit near the mex, checking if its a mex') end
                            if bMexNotHydro == true then oResourcesNearPosition = EntityCategoryFilterDown(categories.MASSEXTRACTION, oPossibleBuildingsNearPosition)
                            else oResourcesNearPosition = EntityCategoryFilterDown(categories.HYDROCARBON, oPossibleBuildingsNearPosition) end
                        end
                    end
                    if oResourcesNearPosition == nil then bIncludeResource = true
                    else
                        if table.getn(oResourcesNearPosition) == 0 then bIncludeResource = true
                        else
                            if bDebugMessages == true then LOG(sFunctionRef..': Have a mex/hydro building near the mex') end
                            --is a mex building here; check if can see it (if bVisibleOnly is true)
                            if bVisibleOnly == true then
                                --Check if can see the mex (or a radar blip on the mex), and set bIncludeResource to true if don't know about the building thats there
                                if M27Utilities.CanSeeUnit(aiBrain, oResourcesNearPosition[1], true) == false then bIncludeResource = true end
                                if bDebugMessages == true then LOG(sFunctionRef..': Have just checked if the mex/hydro is visible to us; bIncludeResource='..tostring(bIncludeResource)) end
                            else
                                bIncludeResource = true
                            end
                        end
                    end
                end
                if bIncludeResource == true then
                    if bDebugMessages == true then LOG(sFunctionRef..': Mex/hydro is closer to us and not aware of enemy buildings on it, so recording') end
                    iResourceCount = iResourceCount + 1
                end
            end
        end
        return iResourceCount
    else
        M27Utilities.ErrorHandler('aiBrain is nil')
        return 0
    end
end

function GetNearestMexToUnit(oBuilder, bCanBeBuiltOnByAlly, bCanBeBuiltOnByEnemy, iBuildRangeMod)
    --Gets the nearest mex to oBuilder based on oBuilder's build range+iBuildRangeMod. Returns nil if no such mex.  Optional variables:
    --bCanBeBuiltOnByAlly - false if dont want it to have been built on by us
    --bCanBeBuiltOnByEnemy - false if dont want it to have been built on by enemy
    --iBuildRangeMod - defaults to 0

    local bDebugMessages = false
    local sFunctionRef = 'GetNearestMexToUnit'

    if bCanBeBuiltOnByAlly == nil then bCanBeBuiltOnByAlly = false end
    if bCanBeBuiltOnByEnemy == nil then bCanBeBuiltOnByEnemy = false end
    if iBuildRangeMod == nil then iBuildRangeMod = 0 end

    local tUnitPos = oBuilder:GetPosition()
    --local iUnitSegmentX, iUnitSegmentZ = GetSegmentFromPosition(tUnitPos)
    local iUnitPathGroup = InSameSegmentGroup(oBuilder, tUnitPos, true)
    local sPathing = M27Utilities.GetUnitPathingType(oBuilder)
    local oUnitBP = oBuilder:GetBlueprint()
    local iBuildDistance = oUnitBP.Economy.MaxBuildDistance
    if iBuildDistance == nil then iBuildDistance = 5 end
    local iMaxDistanceFromUnit = iBuildDistance + iBuildRangeMod
    local iMinDistanceFromUnit = 10000
    local iNearestMexFromUnit
    local iCurDistanceFromUnit
    local aiBrain = oBuilder:GetAIBrain()
    --local iSegmentX, iSegmentZ --for the mex
    for iCurMex, tMexLocation in tMexByPathingAndGrouping[sPathing][iUnitPathGroup] do
        iCurDistanceFromUnit = M27Utilities.GetDistanceBetweenPositions(tMexLocation, tUnitPos)
        if iCurDistanceFromUnit <= iMaxDistanceFromUnit then
            if iCurDistanceFromUnit < iMinDistanceFromUnit then
                --Is it valid (i.e. no-one has built on it)?
                --IsMexUnclaimed(aiBrain, tMexPosition, bTreatEnemyMexAsUnclaimed, bTreatAllyMexAsUnclaimed)
                if bDebugMessages == true then LOG(sFunctionRef..': Checking if iCurMex is unclaimed, iCurMex='..iCurMex..'; MexLocation='..repr(tMexByPathingAndGrouping[sPathing][iUnitPathGroup][iCurMex])) end
                if M27Logic.IsMexUnclaimed(aiBrain, tMexLocation, false, false) == true then
                    if bDebugMessages == true then LOG(sFunctionRef..'; iCurMex is unclaimed; iCurMex='..iCurMex) end
                    iMinDistanceFromUnit = iCurDistanceFromUnit
                    iNearestMexFromUnit = iCurMex
                else if bDebugMessages == true then LOG(sFunctionRef..': iCurMex is claiemd already, iCurMex='..iCurMex) end
                end
            end
        end
    end
    if bDebugMessages == true then
        if iNearestMexFromUnit == nil then LOG(sFunctionRef..': Nearest mex is nil')
        else LOG(sFunctionRef..'iNearestMexFromUnit='..iNearestMexFromUnit) end
    end
    if iNearestMexFromUnit == nil then return nil
    else return tMexByPathingAndGrouping[sPathing][iUnitPathGroup][iNearestMexFromUnit] end
end

function IsUnderwater(tPosition, bReturnSurfaceHeightInstead)
    --Returns true if tPosition underwater, otherwise returns false
    --bReturnSurfaceHeightInstead:: Return the actual height at which underwater, instead of true/false
    local bUnderwater = false
    if M27Utilities.IsTableEmpty(tPosition) == true then
        M27Utilities.ErrorHandler('tPosition is empty')
    else
        local iSurfaceHeight = GetSurfaceHeight(tPosition[1], tPosition[3])
        if bReturnSurfaceHeightInstead == true then bUnderwater = iSurfaceHeight
        else
            if iSurfaceHeight > tPosition[2] then bUnderwater = true end
        end
    end
    return bUnderwater
end

function GetNearestPathableLandPosition(oPathingUnit, tTravelTarget, iMaxSearchRange)
    --Looks for a position with >0 surface height within iMaxSearchRange of oPathingUnit
    --first looks in a straight line along tTravelTarget, and only if no match does it consider looking left, right and behind
    --Returns nil if cant find target

    local tValidTarget
    if oPathingUnit and not(oPathingUnit.Dead) and M27Utilities.IsTableEmpty(tTravelTarget)==false and iMaxSearchRange then
        local iDistanceForEachCheckLow = 2.5
        local iDoublingDistanceCheckThreshold = 4
        local iHigherThanMaxDistanceCycle = iMaxSearchRange / iDistanceForEachCheckLow
        local iAngleToPath
        local tCurPosition
        local tStartPosition = oPathingUnit:GetPosition()
        local bFoundTarget = false
        for iAngleCycle = 1, 4 do
            if iAngleCycle == 1 then iAngleToPath = 0
                elseif iAngleCycle == 2 then iAngleToPath = 90
                elseif iAngleCycle == 3 then iAngleToPath = 270
                else iAngleToPath = 180
            end

            local iDistanceMod
            local bLastDistanceCycle = false
            local iLastDistanceMod = 0
            for iDistanceCycle = 1, iHigherThanMaxDistanceCycle do
                iDistanceMod = iLastDistanceMod + iDistanceForEachCheckLow
                if iDistanceCycle > iDoublingDistanceCheckThreshold then iDistanceMod = iDistanceMod + iDistanceForEachCheckLow end
                if iDistanceCycle > iMaxSearchRange then iDistanceCycle = iMaxSearchRange bLastDistanceCycle = true end

                tCurPosition = M27Utilities.MoveTowardsTarget(tStartPosition, tTravelTarget, iDistanceMod, iAngleToPath)
                if M27Utilities.IsTableEmpty(tCurPosition) == false then
                    if IsUnderwater(tCurPosition) == false then
                        bFoundTarget = true
                        tValidTarget = tCurPosition
                        break
                    end
                end

                iLastDistanceMod = iDistanceMod
                if bLastDistanceCycle == true then break end
            end
            if bFoundTarget == true then break end
        end
    else
        --Error handling:
        if oPathingUnit == nil then M27Utilities.ErrorHandler('Pathing unit is nil')
        elseif oPathingUnit.Dead then M27Utilities.ErrorHandler('Pathing unit is dead')
        elseif M27Utilities.IsTableEmpty(tTravelTarget) == true then M27Utilities.ErrorHandler('Travel target is empty')
        elseif iMaxSearchRange == nil then M27Utilities.ErrorHandler('iMaxSearchRange is nil')
        end
    end
    --Redundancy - check in same pathing group:
    if tValidTarget then if InSameSegmentGroup(oPathingUnit, tValidTarget, false) == false then tValidTarget = nil end end
    return tValidTarget
end