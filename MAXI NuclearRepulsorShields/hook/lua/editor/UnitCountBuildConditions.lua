-- hook for additional build conditions used from AIBuilders

local FactionIndexToCategory = {[1] = categories.UEF, [2] = categories.AEON, [3] = categories.CYBRAN, [4] = categories.SERAPHIM, [5] = categories.NOMADS, [6] = categories.ARM, [7] = categories.CORE }
function CanBuildShieldCategory(aiBrain,category)
    local FactionCat = FactionIndexToCategory[aiBrain:GetFactionIndex()] or categories.ALLUNITS
    local numBuildableUnits = table.getn(EntityCategoryGetUnitList(category * FactionCat)) or -1
    return numBuildableUnits > 0
end
