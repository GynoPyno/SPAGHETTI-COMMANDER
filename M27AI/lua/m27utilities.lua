refPathingTypeAmphibious = 'Amphibious'
refPathingTypeNavy = 'Water'
refPathingTypeAir = 'Air'
refPathingTypeLand = 'Land'
refPathingTypeNone = 'None'
refPathingTypeAll = {refPathingTypeAmphibious, refPathingTypeNavy, refPathingTypeAir, refPathingTypeLand}

local M27Overseer = import('/mods/M27AI/lua/AI/M27Overseer.lua')
local BuildingTemplates = import('/lua/BuildingTemplates.lua').BuildingTemplates

function ErrorHandler(sErrorMessage)
    --Intended to be put in code wherever a condition isn't met that should be, so can debug it without the code crashing
    if sErrorMessage == nil then sErrorMessage = 'Not specified' end
    sErrorMessage = 'M27ERROR: '..sErrorMessage
    local a, s = pcall(assert, false, sErrorMessage)
    WARN(a, s)
end

function IsTableEmpty(tTable, bEmptyIfNonTableWithValue)
    --bEmptyIfNonTableWithValue - Optional, defaults to true
    --E.g. if passed oUnit to a function that was expecting a table, then setting bEmptyIfNonTableWithValue = false means it will register the table isn't nil

    if (type(tTable) == "table") then
        if next (tTable) == nil then return true
        else
            for i1, v1 in pairs(tTable) do
                return false
            end
            return true
        end
    else
        if tTable == nil then return true
        else
            if bEmptyIfNonTableWithValue == nil then return true
                else return bEmptyIfNonTableWithValue
            end
        end

    end
end

function IsTableArray(tTable)
    if tTable[1] == nil then
        --LOG('tTable[1] is a nil value')
        return false end
    return true
end

function GetTableSize(tTable)
    local count = 0
    for _ in pairs(tTable) do count = count + 1 end
    return count
end

function CombineTables(t1, t2)
    for _,v in ipairs(t2) do
        table.insert(t1, v)
    end
    return t1
end

function ConvertTableIntoUniqueList(t1DTable)
    --Assumes that table doesn't contain nil values in it
    --First check if is a table:
    local tUniqueTable = {}
    local iTableCount = table.getn(t1DTable)
    local iUniqueRefCount = 0
    for iCurEntry=1, iTableCount do
        if iCurEntry == 1 then
            iUniqueRefCount = iUniqueRefCount + 1
            tUniqueTable[iUniqueRefCount] = t1DTable[iCurEntry]
        else
            for iUniqueEntry = 1, iUniqueRefCount do
                if t1DTable[iCurEntry] == tUniqueTable[iUniqueEntry] then break end
                if iUniqueEntry == iUniqueRefCount then
                    --Not matched against any unique ref entries, so record this:
                    iUniqueRefCount = iUniqueRefCount + 1
                    tUniqueTable[iUniqueRefCount] = t1DTable[iCurEntry]
                    break
                end

            end
        end
    end
    return tUniqueTable
end

function spairs(t, order)
    --Required by the sort tables function
    --Code with thanks to Michal Kottman https://stackoverflow.com/questions/15706270/sort-a-table-in-lua
    -- collect the keys
    local keys = {}
    local iKeyCount = 0
    for k in pairs(t) do
        iKeyCount = iKeyCount+1
        keys[iKeyCount] = k end

    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

function SortTableBySubtable(tTableToSort, sSortByRef, bLowToHigh)
--NOTE: This doesnt update tTableToSort.  Instead it returns a 1-off table reference that you can use e.g. to loop through each entry.  Its returning function(table), which means if you try and store it as a table variable, then further references to it will re-run the function causing issues
    --[[ e.g. of a table where this will work:
    local tPreSortedThreatGroup = {}
    local sThreatGroup
    for i1 = 1, 4 do
        sThreatGroup = 'M27'..i1
        tPreSortedThreatGroup[sThreatGroup] = {}
        if i1 == 1 then
            tPreSortedThreatGroup[sThreatGroup][refiDistanceFromOurBase] = 100
        elseif i1 == 4 then tPreSortedThreatGroup[sThreatGroup][refiDistanceFromOurBase] = 200
        else tPreSortedThreatGroup[sThreatGroup][refiDistanceFromOurBase] = math.random(1, 99)
        end
    end
    for iEntry, tValue in SortTableBySubtable(tPreSortedThreatGroup, refiDistanceFromOurBase, true) then will iterate through the values from low to high
    ]]--

    if bLowToHigh == nil then bLowToHigh = true end
    if bLowToHigh == true then
        return spairs(tTableToSort, function(t,a,b) return t[b][sSortByRef] > t[a][sSortByRef] end)
    else return spairs(tTableToSort, function(t,a,b) return t[b][sSortByRef] < t[a][sSortByRef] end)
    end
end


function GetAveragePosition(tUnits)
    --returns a table with the average position of tUnits
    local tTotalPos = {0,0,0}
    local iUnitCount = 0
    local tCurPos = {}
    for iUnit, oUnit in tUnits do
        tCurPos = oUnit:GetPosition()
        if not(tCurPos[1] == nil) then
            for iAxis = 1, 3 do
                tTotalPos[iAxis] = tTotalPos[iAxis] + tCurPos[iAxis]
            end
            iUnitCount = iUnitCount + 1
        end
    end
    return {tTotalPos[1]/iUnitCount, tTotalPos[2]/iUnitCount, tTotalPos[3]/iUnitCount}
end

function GetDistanceBetweenPositions(Position1, Position2, iBuildingSize)
    -- Returns distance ignoring the y value and taking just x and z values
    --if iBuildingSize is set to a value, then will instead reduce the distance to determine the distance between 1 position and the nearest part of the other position with iBuildingSize
    --iBuildingSize should be the building size from its build location, in 'wall units' - so a land fac is an 8x8 size, and the build position will be the centre of it, making the building size 4, a T1 PGen a size of 1, etc.
    -- LOG('Position1='..Position1[1]..'-'..Position1[3]..'; Position2='..Position2[1]..'-'..Position2[3])
    if iBuildingSize == nil then
        return VDist2(Position1[1], Position1[3], Position2[1], Position2[3])
    else
        local ModPos1X = Position1[1]
        local ModPos1Z = Position1[3]
        if Position1[1] > Position2[1] then
            ModPos1X = Position1[1] - iBuildingSize
            if ModPos1X < Position2[1] then
                    ModPos1X = Position2[1]
            end
        elseif Position1[1] < Position2[1] then
            ModPos1X = Position1[1] + iBuildingSize
            if ModPos1X > Position2[1] then
                ModPos1X = Position2[1] end
        end
        if Position1[3] > Position2[3] then
            ModPos1Z = Position1[3] - iBuildingSize
            if ModPos1Z < Position2[3] then ModPos1Z = Position2[3] end
        elseif Position1[3] < Position2[3] then
            ModPos1Z = Position1[3] + iBuildingSize
            if ModPos1Z > Position2[3] then ModPos1Z = Position2[3] end
        end
        -- LOG('iBuildingSize was set so ModPos used; Position1='..Position1[1]..'-'..Position1[3]..'; Position2='..Position2[1]..'-'..Position2[3]..'iBuildingSize='..iBuildingSize..'iModPos1X='..ModPos1X..'iModPos1Z='..ModPos1Z)
        return VDist2(ModPos1X, ModPos1Z, Position2[1], Position2[3])

    end
end


function MoveTowardsTarget(tStartPos, tTargetPos, iDistanceToTravel, iAngle)
    --Returns the position that want to move iDistanceToTravel along the path from tStartPos to tTargetPos, ignoring height
    --iAngle: 0 = straight line; 90 and 270: right angle to the direction; 180 - opposite direction
    --For now as I'm too lazy to do the basic maths, iAngle must be 0, 90, 180 or 270

    --local rad = math.atan2(tLocation[1] - tBuilderLocation[1], tLocation[3] - tBuilderLocation[3])
    --local iBaseAngle = math.atan((tStartPos[1] - tTargetPos[1])/ (tStartPos[3] - tTargetPos[3]))
    if iAngle == nil then iAngle = 0 end
    local iBaseAngle = math.atan((tStartPos[1] - tTargetPos[1])/ (tStartPos[3] - tTargetPos[3]))
    local iXChangeBase = math.sin(iBaseAngle) * iDistanceToTravel
    local iZChangeBase = math.cos(iBaseAngle) * iDistanceToTravel
    local iXMod = 1
    local iZMod = 1
    if tTargetPos[1] <= tStartPos[1] and tTargetPos[3] <= tStartPos[3] then
        iXMod = -1
        iZMod = -1
    elseif tTargetPos[1] <= tStartPos[1] then --Z is >
        iXMod = 1
        iZMod = 1
    elseif tTargetPos[3] <= tStartPos[3] then
        iXMod = -1
        iZMod = -1
    else --TargetX > StartX, TargetZ > StartZ
        iXMod = 1
        iZMod = 1
    end

    if tTargetPos[3] < tStartPos[3] then iZMod = -1 end
    local iXChangeActual, iZChangeActual
    if iAngle == 0 or iAngle == 180 then
        iXChangeActual = iXChangeBase
        iZChangeActual = iZChangeBase
    else
        iXChangeActual = iZChangeBase
        iZChangeActual = iXChangeBase
    end
    iXChangeActual = iXChangeActual * iXMod
    iZChangeActual = iZChangeActual * iZMod
    if iAngle > 0 then
        if iAngle >= 180 then iXChangeActual = iXChangeActual * -1 end
        if iAngle <= 180 then iZChangeActual = iZChangeActual * -1 end
    end
    local iXPos, iZPos
    iXPos = tStartPos[1] + iXChangeActual
    iZPos = tStartPos[3] + iZChangeActual

    return { iXPos, GetTerrainHeight(iXPos, iZPos), iZPos }
end

function GetAIBrainArmyNumber(aiBrain)
    --note - this is different to aiBrain:GetArmyIndex() which returns the army index; e.g. if 2 players, will have army index 1 and 2; however if 4 start positions, then might have ARMY_2 and ARMY_4 for those 2 players
    local bDebugMessages = false
    if aiBrain then
        if bDebugMessages == true then LOG('GetAIBrainArmyNumber: aiBrain.Name='..aiBrain.Name) end
        return tonumber(string.sub(aiBrain.Name, (string.len(aiBrain.Name)-7)))
    else
        ErrorHandler('aiBrain is nil')
        return nil
    end
end

function IsACU(oUnit)
    if oUnit.Dead then return false else
        if oUnit.GetUnitId and EntityCategoryContains(categories.COMMAND, oUnit:GetUnitId()) then return true else return false end
    end
    --if UnitID == 'ual0001' then -- Aeon
--        return true
--    elseif UnitID == 'uel0001' then -- UEF
--        return true
--    elseif UnitID == 'url0001' then -- Cybran
--        return true
--    elseif UnitID == 'xsl0001' then --Sera
--        return true
end

function GetACU(aiBrain)
    local oACU = aiBrain[M27Overseer.refoStartingACU]
    if oACU == nil then
        ErrorHandler('ACU hasnt been set - will wait 30 seconds to try and avoid crash')
        --WaitSeconds(30)
        ErrorHandler('ACU hasnt been set - finished waiting 30 seconds to try and avoid crash, then will return nil')
        return nil
    else
        if oACU.Dead then
            --is an error where if return the ACU then causes a hard crash (due to some of hte code that relies on this) - easiest way is to just return nil causing an error message that doesnt cause a hard crash
            --(have tested without waiting any seconds and it avoids the hard crash, but waiting just to be safe)
            ErrorHandler('ACU is dead - will wait 30 seconds and then return nil')
            WaitSeconds(30)
            ErrorHandler('ACU is dead - finished waiting 30 seconds to try and avoid crash')
            return nil
        else
            return oACU
        end
    end
end

function GetBlueprintIDFromBuildingType(buildingType, tBuildingTemplate)
    --Returns blueprintID based on buildingType and buildingTemplate; buildingTemplate should be series of tables containing the building types and blueprint IDs for a particular faction
    for Key, Data in tBuildingTemplate do
        if Data[1] == buildingType and Data[2] then
            return Data[2]
        end
    end
end

function GetBlueprintIDFromBuildingTypeAndFaction(buildingType, iFactionNumber)
--Returns the BlueprintID for a building type and faction number (see the BuildingTemplates lua file for a list of all building types)
    --To get iFactionNumber use e.g. factionIndex = aiBrain:GetFactionIndex()
    --1: UEF, 2: Aeon, 3: Cybran, 4: Seraphim, 5: Nomads
    --Alternatively could get faction of a unit, using the FactionName = 'Aeon' property
    local bDebugMessages = false
    if bDebugMessages == true then LOG('About to print out entire building template:'..repr(BuildingTemplates)) end
    local tBuildingTemplateForFaction = BuildingTemplates[iFactionNumber]
    return GetBlueprintIDFromBuildingType(buildingType, tBuildingTemplateForFaction)
end

function GetFactionFromBP(oBlueprint)
    --Returns faction number for oBlueprint
    --1: UEF, 2: Aeon, 3: Cybran, 4: Seraphim, 5: Nomads, 6 = not recognised
    --Note: General.FactionName property uses lowercase for some factions; the categories.x uses upper case
    --Assumed nomads is Nomads

    local tFactionsByName = {'UEF', 'Aeon', 'Cybran', 'Seraphim', 'Nomads'}
    local sUnitFactionName = oBlueprint.General.FactionName
    for iName, sName in tFactionsByName do
        if sName == sUnitFactionName then return iName end
    end
    return 6
end

function GetBlueprintFromID(sBlueprintID)
    --returns blueprint based on the blueprintID
    return __blueprints[string.lower(sBlueprintID)]
end

function GetBuildingSize(BlueprintID)
    --Returns table with X and Z size of sBlueprintID
    local tSizeXZ = {}
    local oBlueprint = GetBlueprintFromID(BlueprintID)
    tSizeXZ[1] = oBlueprint.Physics.SkirtSizeX
    tSizeXZ[2] = oBlueprint.Physics.SkirtSizeZ
    return tSizeXZ
end

function GetAdjacencyLocationForTarget(tablePosTarget, TargetBuildingType, NewBuildingType, buildingTemplate, bCheckValid, aiBrain, bReturnOnlyBestMatch, pBuilderPos, iBuilderMaxDistance, bIgnoreOutsideBuildArea, bBetterIfNoReclaim)
    --Returns all co-ordinates that will result in a NewBuildingType being built adjacent to PosTarget; if bCheckValid is true (default) then will also check it's a valid location to build
    -- tablePosTarget can either be a table (e.g. a table of mex locations), or just a single position
    --Only need to specify aiBrain if bCheckValid = true
    --bIgnoreOutsideBuildArea - if true then ignore any locations outside of the builder's build area
    --bReturnOnlyBestMatch: if true then applies prioritisation and returns only the best match
    --bBetterIfNoReclaim - if true, then will ignore any build location that contains any reclaim (to avoid ACU trying to build somewhere that it has to walk to and reclaim)
    local bDebugMessages = false --True if want most log messages to print
    local sFunctionRef = 'GetAdjacencyLocationForTarget'
    --TEMP FOR TESTING:
    if bCheckValid == nil then bCheckValid = false end
    if aiBrain == nil then bCheckValid = false end
    if bReturnOnlyBestMatch == nil then bReturnOnlyBestMatch = false end
    if pBuilderPos == nil then
        pBuilderPos = {100000, 100000, 100000}
        bIgnoreOutsideBuildArea = false
    end
    if iBuilderMaxDistance == nil then iBuildDistance = 5 end --ACU is 10
    if bIgnoreOutsideBuildArea == nil then bIgnoreOutsideBuildArea = false end
    if bBetterIfNoReclaim == nil then bBetterIfNoReclaim = false end
    if bDebugMessages == true then LOG(sFunctionRef..': NewBuildingType='..tostring(NewBuildingType)..'; TargetBuildingType='..tostring(TargetBuildingType)..'; tablePosTarget='..repr(tablePosTarget)) end
    --local TargetSize = GetBuildingTypeInfo(TargetBuildingType, 1)
    local TargetSize = GetBuildingSize(GetBlueprintIDFromBuildingType(TargetBuildingType, buildingTemplate))
    --local NewBuildingSize = GetBuildingTypeInfo(NewBuildingType, 1)
    local NewBuildingSize = GetBuildingSize(GetBlueprintIDFromBuildingType(NewBuildingType, buildingTemplate))
    local fSizeMod = 0.5
    local iMaxX, iMinX, iMaxZ, iMinZ, iTargetMaxX, iTargetMinX, iTargetMaxZ, iTargetMinZ, OptionsX, OptionsZ
    local iNewX, iNewZ
    local iValidPosCount = 0
    local CurPosition = {}
    local PossiblePositions = {}
    local iPriority
    local iDistanceBetween
    local iMaxPriority = -100
    local tBestPosition = {}
    local bMultipleTargets = IsTableArray(tablePosTarget[1])
    local iTotalTargets = 1
    local PosTarget = {}
    local iMassValue = 0
    if bMultipleTargets == true then iTotalTargets = GetTableSize(tablePosTarget) end
    local bNewBuildingLargerThanNewTarget = false
    if TargetSize[1] < NewBuildingSize[1] or TargetSize[2] < NewBuildingSize[2] then bNewBuildingLargerThanNewTarget = true end
    for iCurTarget = 1, iTotalTargets do
        if bMultipleTargets == true then
            PosTarget = tablePosTarget[iCurTarget]
        else
            PosTarget = tablePosTarget
        end
        --LOG('PosTarget[1]='..PosTarget[1])
        --LOG('TargetSize[1]='..TargetSize[1])
        --LOG('NewBuildingSize[1]='..NewBuildingSize[1])
        iMaxX = PosTarget[1] + TargetSize[1] * fSizeMod + NewBuildingSize[1]*fSizeMod
        iMinX = PosTarget[1] - TargetSize[1] * fSizeMod - NewBuildingSize[1]* fSizeMod
        iMaxZ = PosTarget[3] + TargetSize[2] * fSizeMod + NewBuildingSize[2]* fSizeMod
        iMinZ = PosTarget[3] - TargetSize[2] * fSizeMod - NewBuildingSize[2]* fSizeMod
        iTargetMaxX = PosTarget[1] + TargetSize[1] * fSizeMod
        iTargetMinX = PosTarget[1] - TargetSize[1] * fSizeMod
        iTargetMaxZ = PosTarget[3] + TargetSize[2] * fSizeMod
        iTargetMinZ = PosTarget[3] - TargetSize[2] * fSizeMod
        OptionsX = math.floor(iMaxX - iMinX)
        OptionsZ = math.floor(iMaxZ - iMinZ)
        if bDebugMessages == true then LOG(sFunctionRef..':About to cycle through potential adjacency locations for iCurTarget='..iCurTarget..'; iTotalTargets='..iTotalTargets..'; iMinX-iMaxX='..iMinX..'-'..iMaxX..'; iMinZ-iMaxZ='..iMinZ..'-'..iMaxZ..'; OptionsX='..OptionsX..'; OptionsZ='..OptionsZ)end
        for xi = 0, OptionsX do
            iNewX = iMinX + xi
            --if iNewX >= (iMinX + TargetSize[1]*fSizeMod) or iNewX >= (iTargetMaxX - NewBuildingSize[1]*fSizeMod) then
            for zi = 0, OptionsZ do
                iPriority = 0
                iNewZ = iMinZ + zi
                --if iNewX == 491.5 and iNewZ == 20.5 then bDebugMessages = false end
                --if iNewZ < (iTargetMinZ + NewBuildingSize[2]* fSizeMod) or iNewZ > (iTargetMaxZ - NewBuildingSize[2]* fSizeMod) then
                --ignore corner results (new building larger than target):
                local bIgnore = false
                if bNewBuildingLargerThanNewTarget == true then
                    if iNewX - NewBuildingSize[1] * fSizeMod > iTargetMinX or iNewX + NewBuildingSize[1] * fSizeMod < iTargetMaxX then
                        if iNewZ - NewBuildingSize[2] * fSizeMod > iTargetMinZ or iNewZ + NewBuildingSize[2] * fSizeMod < iTargetMaxZ then
                            iPriority = iPriority - 4
                            --bIgnore = true
                            if bDebugMessages == true then LOG(sFunctionRef..': Corner position so no adjacency - priority decreased; iNewX='..iNewX..'; iNewZ='..iNewZ) end
                        end
                    end
                else
                    if iNewX >= iTargetMinX and iNewX <= iTargetMaxX then
                        --z value needs to be right by the min or max values:
                        if iNewZ == (iTargetMinZ - NewBuildingSize[2]*fSizeMod) or iNewZ == (iTargetMaxZ + NewBuildingSize[2]*fSizeMod) then
                            --valid co-ordinate
                        else
                            --If it's within the target building area then ignore, otherwise record with lower priority as no adjacency:
                            if iNewZ < (iTargetMinZ - NewBuildingSize[2]*fSizeMod) or iNewZ > (iTargetMaxZ + NewBuildingSize[2]*fSizeMod) then
                                iPriority = iPriority - 4
                            else bIgnore = true end
                            if bDebugMessages == true then LOG(sFunctionRef..': NewBuilding <= NewTarget size 1 - failed to find adjacency match so reducing priority by 4; iNewX='..iNewX..'; iNewZ='..iNewZ) end
                        end
                    else
                        if iNewZ >= iTargetMinZ and iNewZ <= iTargetMaxZ then
                            if iNewX == (iTargetMinX - NewBuildingSize[1]*fSizeMod) or iNewX == (iTargetMaxX + NewBuildingSize[1]*fSizeMod) then
                                --Valid match
                            else
                                --If it's within the target building area then ignore, otherwise record with lower priority as no adjacency:
                                if iNewX < (iTargetMinX - NewBuildingSize[1]*fSizeMod) or iNewX > (iTargetMaxX + NewBuildingSize[1]*fSizeMod) then
                                    iPriority = iPriority - 4
                                    else bIgnore = true end
                                if bDebugMessages == true then LOG(sFunctionRef..': NewBuilding <= NewTarget size 2 - failed to find match; iNewX='..iNewX..'; iNewZ='..iNewZ) end
                            end
                        else
                            if (iNewX < (iTargetMinX - NewBuildingSize[1]*fSizeMod) or iNewX > (iTargetMaxX + NewBuildingSize[1]*fSizeMod)) and (iNewZ < (iTargetMinZ - NewBuildingSize[2]*fSizeMod) or iNewZ > (iTargetMaxZ + NewBuildingSize[2]*fSizeMod)) then
                                --should be valid just no adjacency
                                iPriority = iPriority - 4
                            else bIgnore = true end
                            if bDebugMessages == true then LOG(sFunctionRef..': NewBuilding <= NewTarget size 3 - failed to find match; iNewX='..iNewX..'; iNewZ='..iNewZ) end
                        end
                    end
                    -- If bCheckValid then see if aiBrain can build the desired structure at the location
                end
                if bIgnore == false then
                    --Check for reclaim:
                    if bBetterIfNoReclaim == true then
                        --local iMaxReclaimDist = math.sqrt(NewBuildingSize[1]*NewBuildingSize[1]*fSizeMod*fSizeMod + NewBuildingSize[1]*NewBuildingSize[1]*fSizeMod*fSizeMod)
                        --local checkUnits = aiBrain:GetUnitsAroundPoint( (categories.STRUCTURE + categories.MOBILE) - categories.AIR, CurPosition, iMaxReclaimDist, 'Enemy')
                        local Reclaimables = GetReclaimablesInRect(Rect(iNewX - NewBuildingSize[1]*fSizeMod, iNewZ - NewBuildingSize[2]*fSizeMod, iNewX + NewBuildingSize[1]*fSizeMod, iNewZ + NewBuildingSize[2]*fSizeMod))
                        if Reclaimables and table.getn( Reclaimables ) > 0 then
                            local iWreckCount = 0
                            --local iMassValue = nil --only used for log/testing
                            --local bIsProp = nil  --only used for log/testing
                            for _, v in Reclaimables do
                            local WreckPos = v.CachePosition
                                if WreckPos[1]==nil then
                                    if bDebugMessages == true then LOG('Reclaim position for X-Z:'..iNewX..'-'..iNewZ..'; iWreckCount '..iWreckCount..' has a WreckPos[1] that is nil') end
                                else
                                    iMassValue = v.MaxMassReclaim
                                    if iMassValue > 0 then
                                        iWreckCount = iWreckCount + 1
                                        --bIsProp = IsProp(v) --only used for log/testing
                                        if bDebugMessages == true then
                                            if (iNewX == 349.5 and iNewZ == 683.5) or (iNewX == 359.5 and iNewZ == 657.5) then
                                                LOG('Reclaim position for X-Z:'..iNewX..'-'..iNewZ.. '; iWreckCount='..iWreckCount..'='..WreckPos[1]..'-'..WreckPos[2]..'-'..WreckPos[3]..'; iMassValue='..iMassValue)
                                            end
                                        end
                                        --if bDebugMessages == true then LOG('Reclaim position '..iWreckCount..'='..WreckPos[1]..'-'..WreckPos[2]..'-'..WreckPos[3]..'; iMassValue='..iMassValue) end
                                        --DrawLocations(WreckPos, nil, 1, 20, true)
                                    end
                                end
                            end
                            if iWreckCount > 0 then
                                if bDebugMessages == true then LOG('Reclaim detected so reducing priority by 4; iNewX='..iNewX..'iNewZ='..iNewZ) end
                                --bIgnore = true
                                iPriority = iPriority - 4
                            end
                        end
                    end
                end
                if bIgnore ==  false then
                    CurPosition = {iNewX, GetTerrainHeight(iNewX, iNewZ), iNewZ}
                    if bCheckValid then
                        --if aiBrain:CanBuildStructureAt(GetBuildingTypeInfo(NewBuildingType, 2), CurPosition) == false then
                        if aiBrain:CanBuildStructureAt(GetBlueprintIDFromBuildingType(NewBuildingType, buildingTemplate), CurPosition) == false then
                            bIgnore = true
                            if bDebugMessages == true then
                                if bDebugMessages == true then
                                    LOG(sFunctionRef..': aiBrain cant build at iNewX='..iNewX..'; iNewZ='..iNewZ..'; CurPosition='..CurPosition[1]..'-'..CurPosition[2]..'-'..CurPosition[3])
                                    LOG('aiBrain:CanBuildStructureAt(UEB0101, CurPosition)='..tostring(aiBrain:CanBuildStructureAt('UEB0101', CurPosition)))
                                end
                            end
                        end
                    end
                end
                --Ignore if -ve priority and already have better:
                if iPriority < 0 and iMaxPriority > iPriority then
                    if bDebugMessages == true then LOG(sFunctionRef..': Ignoring location as priority too low; iPriority='..iPriority..';iMaxPriority='..iMaxPriority..'; iNewX='..iNewX..'; iNewZ='..iNewZ) end
                    bIgnore = true end
                
                if bIgnore == false then
                    -- We now have a co-ordinate that should result in newbuilding being built adjacent to target building (unless negative priority); check other conditions/priorities
                    if bDebugMessages == true then LOG(sFunctionRef..': Have valid build location, iPriority pre considering build distance='..iPriority..'; CurPosition[1]='..CurPosition[1]..'-'..CurPosition[2]..'-'..CurPosition[3]) end
                    if bIgnoreOutsideBuildArea == true or bReturnOnlyBestMatch == true then iDistanceBetween = GetDistanceBetweenPositions(pBuilderPos, CurPosition, NewBuildingSize[1]*fSizeMod) end
                    --if bIgnoreOutsideBuildArea == true or bReturnOnlyBestMatch == true then iDistanceBetween = GetDistanceBetweenPositions(pBuilderPos, PosTarget) end
                    -- DrawLocations({CurPosition},0, 4, 10)
                    if bReturnOnlyBestMatch == true then
                        --Check if within build area:
                        if iDistanceBetween <= iBuilderMaxDistance then
                            if iDistanceBetween > 0 then
                                iPriority = iPriority + 4
                            else iPriority = iPriority + 1
                            end
                        end
                        --Deduct 3 if ACU would have to move to build - should hopefully be covered by above
                        --if pBuilderPos[1] >= iNewX - NewBuildingSize[1] * fSizeMod and pBuilderPos[1] <= iNewX + NewBuildingSize[1] * fSizeMod then
                        --if pBuilderPos[3] >= iNewZ - NewBuildingSize[2] * fSizeMod and pBuilderPos[3] <= iNewX + NewBuildingSize[2] * fSizeMod then
                        --iPriority = iPriority - 3
                        --end
                        --end
                        --Check if level with target (makes it easier for other buildings to get adjacency):
                        if CurPosition[1] - NewBuildingSize[1]*fSizeMod == iTargetMinX then iPriority = iPriority + 1 end
                        if CurPosition[1] + NewBuildingSize[1]*fSizeMod == iTargetMaxX then iPriority = iPriority + 1 end
                        if CurPosition[3] - NewBuildingSize[2]*fSizeMod == iTargetMinZ then iPriority = iPriority + 1 end
                        if CurPosition[3] + NewBuildingSize[2]*fSizeMod == iTargetMaxZ then iPriority = iPriority + 1 end
                    end
                    if bIgnoreOutsideBuildArea == true then
                        if iDistanceBetween > iBuilderMaxDistance then
                            bIgnore = true
                            if bDebugMessages == true then LOG(sFunctionRef..': Ignoring as iDistanceBetween='..iDistanceBetween..'; normal dist='..GetDistanceBetweenPositions(pBuilderPos, CurPosition)) end
                        else iPriority = iPriority - 2
                        end
                    end

                    if bIgnore == false then
                        iValidPosCount = iValidPosCount + 1
                        PossiblePositions[iValidPosCount] = CurPosition
                        if iPriority > iMaxPriority then
                            iMaxPriority = iPriority
                            if bReturnOnlyBestMatch == true then
                                tBestPosition = CurPosition
                            end
                        end
                        if bDebugMessages == true then if bReturnOnlyBestMatch == true then LOG('iPriority='..iPriority..'; iDistanceBetween='..iDistanceBetween) end end
                        if bDebugMessages == true then LOG('*M27AI: M27Utilities.lua: GetAdjacencyLocationForTarget: iValidPosCount='..iValidPosCount..'; PossiblePositions[iValidPosCount][1-2-3]='..PossiblePositions[iValidPosCount][1]..'-'..PossiblePositions[iValidPosCount][2]..'-'..PossiblePositions[iValidPosCount][3]..'; bReturnOnlyBestMatch='..tostring(bReturnOnlyBestMatch)) end
                    end
                end
                --end
            end
            --end
        end
    end
    if iValidPosCount >= 1 then
        if bReturnOnlyBestMatch then
            if bDebugMessages == true then LOG('*M27AI: M27Utilities.lua: GetAdjacencyLocationForTarget: Returning best possible position; tBestPosition[1]='..tBestPosition[1]..'-'..tBestPosition[2]..'-'..tBestPosition[3]..'; iMaxPriority='..iMaxPriority) end
            --DrawLocations({tBestPosition})
            return tBestPosition
        else
            if bDebugMessages == true then LOG('*M27AI: M27Utilities.lua: GetAdjacencyLocationForTarget: Returning table of possible positions; PossiblePositions[1][1]='..PossiblePositions[1][1]..'-'..PossiblePositions[1][2]..'-'..PossiblePositions[1][3]) end
            return PossiblePositions
        end
    else
        if bDebugMessages == true then LOG('WARNING: *M27AI: M27Utilities.lua: GetAdjacencyLocationForTarget: No valid matches found. PosTarget='..PosTarget[1]..'-'..PosTarget[3]) end
        return nil
    end

end

function ConvertAbsolutePositionToRelative(tableAbsolutePositions, relativePosition, bIgnoreY)
    --NOTE: Not suitable for e.g. giving a build order location, since that appears to be affected by the direction the unit is facing as well?
    -- returns a table of relative positions based on the position of absoluteposition to the relativeposition
    -- if bIgnoreY is false then will do relative y position=0, otherwise will use relativePosition's y value
    local RelX, RelY, RelZ
    local tableRelative = {}
    if bIgnoreY == nil then bIgnoreY = true end
    --LOG('ConvertAbsolutePositionToRelative: tableAbsolutePositions[1]='..tostring(tableAbsolutePositions[1]))
    local bMultiDimensionalTable = IsTableArray(tableAbsolutePositions[1])
    if bMultiDimensionalTable == false then
        RelX = tableAbsolutePositions[1] - relativePosition[1]
        if bIgnoreY then RelY = 0
        else RelY = tableAbsolutePositions[2] - relativePosition[2]
        end
        RelZ = tableAbsolutePositions[3] - relativePosition[3]
        tableRelative = {RelX, RelY, RelZ}
    else
        for i, v in ipairs(tableAbsolutePositions) do
            RelX = tableAbsolutePositions[i][1] - relativePosition[1]
            if bIgnoreY then RelY = 0
            else RelY = tableAbsolutePositions[i][2] - relativePosition[2]
            end
            RelZ = tableAbsolutePositions[i][3] - relativePosition[3]
            tableRelative[i] = {RelX, RelY, RelZ}
            --LOG('Converting Abs to Rel: Abs='..tableAbsolutePositions[i][1]..'-'..tableAbsolutePositions[i][2]..'-'..tableAbsolutePositions[i][3]..'; RelPos='..RelX..RelY..RelZ..'; builderPos='..relativePosition[1]..'-'..relativePosition[2]..'-'..relativePosition[3])
        end

    end
    return tableRelative
end

function ConvertLocationsToBuildTemplate(tableUnits, tableRelativePositions)
    -- Returns a table that can be used as a baseTemplate by AIExecuteBuildStructure and similar functions
    local baseTemplate = {}
    baseTemplate[1] = {} --allows for different locations for different units, wont use this functionality though
    baseTemplate[1][1] = tableUnits -- Units that this applies to
    --baseTemplate[1][1+x] is the dif co-ordinates, each a 3 value table
    --LOG('About to attempt to convert tableRelativePositions into build template')
    local bMultiDimensionalTable = IsTableArray(tableRelativePositions[1])
    if bMultiDimensionalTable == true then
        for i, v in ipairs(tableRelativePositions) do
            baseTemplate[1][1+i] = {}
            baseTemplate[1][1 + i][1] = v[1]
            baseTemplate[1][1 + i][3] = v[2] -- basetemplate changes direction in first 2 of the 3 co-ords
            baseTemplate[1][1 + i][2] = v[3]
            --LOG('ConvertLocationsToBuildTemplate: i='..i..'; baseTemplate[1][1=i][1],2,3='..baseTemplate[1][1+i][1]..'-'..baseTemplate[1][1+i][2]..'-'..baseTemplate[1][1+i][3])
        end
    else
        baseTemplate[1][2] = {}
        baseTemplate[1][2][1] = tableRelativePositions[1]
        baseTemplate[1][2][3] = tableRelativePositions[2]
        baseTemplate[1][2][2] = tableRelativePositions[3]
    end
    return baseTemplate
end

function DrawTableOfLocations(tableLocations, relativeStart, iColour, iDisplayCount, bSingleLocation, iCircleSize)
    --Draw circles around a table of locations to help with debugging - note that as this doesnt use ForkThread (might need to have global variables and no function pulled variables for forkthread to work beyond the first few seconds) this will pause all the AI code
    --If a table (i.e. bSingleLocation is false), then will draw lines between each position
    --All values are optional other than tableLocations
    --if relativeStart is blank then will treat as absolute co-ordinates
    --assumes tableLocations[x][y] where y is table of 3 values
    -- iColour: integer to allow easy selection of different colours (see below code)
    -- iDisplayCount - No. of times to cycle through drawing; limit of 500 (10s) for performance reasons
    --bSingleLocation - true if tableLocations is just 1 position
    local bDebugMessages = false
    if iCircleSize == nil then iCircleSize = 2 end
    if iDisplayCount == nil then iDisplayCount = 500
    elseif iDisplayCount <= 0 then iDisplayCount = 1
    elseif iDisplayCount >= 10000 then iDisplayCount = 10000
    end
    if bSingleLocation == nil then bSingleLocation = false end
    local sColour
    if iColour == nil then sColour = 'c00000FF' --dark blue
    elseif iColour == 1 then sColour = 'c00000FF'
    elseif iColour == 2 then sColour = 'ffFF4040' --orange
    elseif iColour == 3 then sColour = 'c0000000'
    elseif iColour == 4 then sColour = 'ffFF6060'
    end
    if relativeStart == nil then relativeStart = {0,0,0} end
    local iMaxDrawCount = iDisplayCount
    local iCurDrawCount = 0
    if bDebugMessages == true then LOG('About to draw circle at table locations') end
    local bFirstLocation = true
    local tPrevLocation = {}
    while true do
        if bSingleLocation then DrawCircle(tableLocations, iCircleSize, sColour)
        else
            for i, tCurLocation in ipairs(tableLocations) do
                DrawCircle(tCurLocation, iCircleSize, sColour)
                if bFirstLocation == true then
                    bFirstLocation = false
                else
                    DrawLine(tPrevLocation, tCurLocation, sColour)
                end
                tPrevLocation = tCurLocation
            end
        end
        iCurDrawCount = iCurDrawCount + 1
        if iCurDrawCount > iMaxDrawCount then return end
        coroutine.yield(2) --Any more and circles will flash instead of being constant
    end
end

function SteppingStoneForDrawLocations(tableLocations, relativeStart, iColour, iDisplayCount, bSingleLocation, iCircleSize)
    DrawTableOfLocations(tableLocations, relativeStart, iColour, iDisplayCount, bSingleLocation, iCircleSize)
end

function DrawLocations(tableLocations, relativeStart, iColour, iDisplayCount, bSingleLocation, iCircleSize)
    --fork thread doesnt seem to work - can't see the circle, even though teh code itself is called; using steppingstone seems to fix this
    --ForkThread(DrawTableOfLocations, tableLocations, relativeStart, iColour, iDisplayCount, bSingleLocation)
    --DrawTableOfLocations(tableLocations, relativeStart, iColour, iDisplayCount, bSingleLocation)
    ForkThread(SteppingStoneForDrawLocations, tableLocations, relativeStart, iColour, iDisplayCount, bSingleLocation, iCircleSize)
end

function DrawLocation(tLocation, relativeStart, iColour, iDisplayCount, iCircleSize)
    --ForkThread(DrawTableOfLocations, tableLocations, relativeStart, iColour, iDisplayCount, true)
    --DrawTableOfLocations(tableLocations, relativeStart, iColour, iDisplayCount, true)
    ForkThread(SteppingStoneForDrawLocations, tLocation, relativeStart, iColour, iDisplayCount, true, iCircleSize)
end

function GetAllCategoryUnitsNearPosition(aiBrain, unitCategory, lLocation, iDistance, bHostile)
    --Returns a table containing all units of the desired category (e.g. categories.STRUCTURE etc. - see build orders for examples) that are within iDistance from lLocation
    --e.g. to return nearest factory (of any type) do categories.STRUCTURE * categories.FACTORY
    --bHostile: True - return only hostile units; False - return only your own units (note - if need to return all ally units, or all units, hostile and non-hostile, could tweak this in future)
    --Returns only living units
    --LOG('GetAllCategoryUnitsNearPosition: starting to look for units near lLocation='..lLocation[1]..'-'..lLocation[2]..'-'..lLocation[3]..'; iDistance='..iDistance)
    local sHostile = 'Ally'
    if bHostile == true then sHostile = 'Enemy' end
    local tUnits = aiBrain:GetUnitsAroundPoint(unitCategory, lLocation, iDistance, sHostile)
    local iUnitCount = 0
    local tValidUnits = {}
    local iUnitArmyNumber = 0
    local iPlayerArmyNumber = aiBrain:GetArmyIndex()
    local bInclude


    for _, v in tUnits do
        bInclude = false
        if not v.Dead then
            iUnitArmyNumber = v:GetAIBrain():GetArmyIndex()
            if bHostile then
                if not (iUnitArmyNumber == iPlayerArmyNumber) then bInclude = true end
            else
                if iUnitArmyNumber == iPlayerArmyNumber then bInclude = true end
            end
        end
        if bInclude == true then
            iUnitCount = iUnitCount + 1
            tValidUnits[iUnitCount] = v
        end
    end
    --LOG('GetAllCategoryUnitsNearPosition: iUnitCount found='..iUnitCount)
    return tValidUnits
end


function GetAllUnitPositions(tUnits)
    --Converts a table of units (e.g. from GetAllCategoryUnitsNearPosition) into a table of positions
    local tUnitPositions = {}
    local iUnitCount = 0
    for _, v in tUnits do
        iUnitCount = iUnitCount + 1
        tUnitPositions[iUnitCount] = v:GetPosition()
    end
    --LOG('GetAllUnitPositions: iUnitCount='..iUnitCount)
    return tUnitPositions
end

function GetNumberOfUnits(aiBrain, category)
    --returns the number of units of a particular category the aiBrain has
    --categories follow same appraoch as the builder groups, e.g. categories.STRUCTURE * categories.HYDROCARBON to return no. of hydrocarbons

    --local category = categories.STRUCTURE * categories.HYDROCARBON
    local numUnits = 0
    local testCat = category
    if type(category) == 'string' then
        testCat = ParseEntityCategory(category)
    end
    numUnits = aiBrain:GetCurrentUnits(testCat)
    return numUnits
end

function GetUnitPathingType(oUnit)
    --Returns Land, Amphibious, Air or Water or None
    if oUnit and oUnit.GetBlueprint then
        local mType = oUnit:GetBlueprint().Physics.MotionType
        if (mType == 'RULEUMT_AmphibiousFloating' or mType == 'RULEUMT_Hover' or mType == 'RULEUMT_Amphibious') then
            return refPathingTypeAmphibious
        elseif (mType == 'RULEUMT_Water' or mType == 'RULEUMT_SurfacingSub') then
            return refPathingTypeNavy
        elseif mType == 'RULEUMT_Air' then
            return refPathingTypeAir
        elseif (mType == 'RULEUMT_Biped' or mType == 'RULEUMT_Land') then
            return refPathingTypeLand
        else return refPathingTypeNone
        end
    else
        ErrorHandler('oUnit is nil or doesnt have a GetBlueprint function')
    end
end

function IsUnitUnderwaterAmphibious(oUnit)
    local oUnitBP = oUnit:GetBlueprint()
    local bIsUnderwater = false
    if oUnitBP.Physics and oUnitBP.Physics.MotionType then
        if oUnitBP.Physics.MotionType == 'RULEUMT_Amphibious' then
            bIsUnderwater = true
        end
    end
    return bIsUnderwater
end

function ConvertLocationToStringRef(tLocation)
    return 'X'..tLocation[1]..';Z'..tLocation[3]
end

function FactionIndexToCategory(iFactionIndex)
    --returns the categories.[FACTION] for iFactionIndex
    local tCategoryByIndex = {[1] = categories.UEF, [2] = categories.AEON, [3] = categories.CYBRAN, [4] = categories.SERAPHIM, [5] = categories.NOMADS, [6] = categories.ARM, [7] = categories.CORE }
    return tCategoryByIndex[iFactionIndex]
end

function GetFactionNameByIndex(iFactionIndex)
    --e.g. if have oUnitBP, then can check faction name with .General.FactionName
    local tFactionNameByIndex = {[1] = 'UEF', [2]= 'Aeon', [3] = 'Cybran', [4] = 'Seraphim', [5] = 'Nomads'}
    return tFactionNameByIndex[iFactionIndex]
end

function GetUnitsInFactionCategory(aiBrain, category)
    --returns a table of the units that aiBrain's faction that meet category
    --Category is e.g. categories.LAND * categories.DIRECTFIRE (i.e. based on the categories {} data of unit blueprints)

    --local FactionIndexToCategory = {[1] = categories.UEF, [2] = categories.AEON, [3] = categories.CYBRAN, [4] = categories.SERAPHIM, [5] = categories.NOMADS, [6] = categories.ARM, [7] = categories.CORE }
    --[[local bDebugMessages = true
    if bDebugMessages == true then
        LOG('FactionIndex='..aiBrain:GetFactionIndex())
        if FactionIndexToCategory[aiBrain:GetFactionIndex()] == nil then LOG('FactionIndexToCategory is nil') end
    end]]--
    local iFactionCat = FactionIndexToCategory(aiBrain:GetFactionIndex())
    --[[local tAllBlueprints = EntityCategoryGetUnitList(category)
    local tFactionBlueprints
    local iValidBlueprints
    for _, sBlueprint in tAllBlueprints do
        if EntityCategoryContains(iFactionCat, sBlueprint) then
            if tFactionBlueprints == nil then tFactionBlueprints = {} end
            iValidBlueprints = iValidBlueprints + 1
            tFactionBlueprints[iValidBlueprints] = sBlueprint
        end
    end
    return tFactionBlueprints]]--
    return EntityCategoryGetUnitList(category * iFactionCat)
end

function GetNearestUnit(tUnits, tCurPos, aiBrain, bHostileOnly)
    --returns the nearest unit in tUnits from tCurPos
    --bHostile defaults to false; if true then unit must be hostile
    --aiBrain: Optional unless are setting bHostileOnly to true
    local bDebugMessages = false
    local iMinDist = 1000000
    local iCurDist
    local iNearestUnit
    local bValidUnit = false
    local iPlayerArmyIndex
    if not(aiBrain == nil) then iPlayerArmyIndex = aiBrain:GetArmyIndex() end
    local iUnitArmyIndex
    if bHostileOnly == nil then bHostileOnly = false end
    if bDebugMessages == true then LOG('GetNearestUnit: tUnits table size='..table.getn(tUnits)) end
    for iUnit, oUnit in tUnits do
        if not(oUnit.Dead) then
            bValidUnit = true
            if bHostileOnly == true then
                bValidUnit = false
                if oUnit.GetAIBrain then
                    iUnitArmyIndex = oUnit:GetAIBrain():GetArmyIndex()
                    if IsEnemy(iUnitArmyIndex, iPlayerArmyIndex) then
                        bValidUnit = true
                    end
                end
            end
            if bValidUnit == true then
                if bDebugMessages == true then LOG('GetNearestUnit: iUnit='..iUnit) end
                iCurDist = GetDistanceBetweenPositions(oUnit:GetPosition(), tCurPos)
                if iCurDist < iMinDist then
                    iMinDist = iCurDist
                    iNearestUnit = iUnit
                end
            end
        end
    end
    return tUnits[iNearestUnit]
end

function CanSeeUnit(aiBrain, oUnit, bTrueIfOnlySeeBlip)
    --returns true if aiBrain can see oUnit
    --bTrueIfOnlySeeBlip - returns true if can see a blip
    if bTrueIfOnlySeeBlip == nil then bTrueIfOnlySeeBlip = false end
    local iUnitBrain = oUnit:GetAIBrain()
    if iUnitBrain == aiBrain then return true
    else
        local bCanSeeUnit = false
        local iArmyIndex = aiBrain:GetArmyIndex()
        if not(oUnit.Dead) then
            local oBlip = oUnit:GetBlip(iArmyIndex)
            if oBlip then
                if bTrueIfOnlySeeBlip then return true
                elseif oBlip:IsSeenEver(iArmyIndex) then return true end
            end
        end
    end
    return false
end

function CalculateDistanceDeviationOfPositions(tPositions, iOptionalCentreSize)
    --Returns the standard deviation for tPositions - used to assess how spread out a platoon is
    --reduces the gap from the centre by iOptionalCentreSize
    if iOptionalCentreSize == nil then iOptionalCentreSize = 0 end
    local iTotalX = 0
    local iTotalZ = 0
    local iCount = 0
    --Calculate average position:
    for i1, tCurPos in tPositions do
        iCount = iCount + 1
        iTotalX = iTotalX + tCurPos[1]
        iTotalZ = iTotalZ + tCurPos[3]
    end
    local iAverageX = iTotalX / iCount
    local iAverageZ = iTotalZ / iCount
    --Calc sum of squared differences:
    local iCurDistance = 0
    local iCurDifSquared = 0
    local iSquaredDifTotal = 0
    for i1, tCurPos in tPositions do
        iCurDistance = VDist2(tCurPos[1], tCurPos[3], iAverageX, iAverageZ)
        if iCurDistance > iOptionalCentreSize then iCurDistance = iCurDistance - iOptionalCentreSize
        else iCurDistance = 0 end
        iCurDifSquared = iCurDistance * iCurDistance
        iSquaredDifTotal = iSquaredDifTotal + iCurDifSquared
    end
    return math.sqrt(iSquaredDifTotal / iCount)
end