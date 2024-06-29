-- Author: Shamble
--
-- Description:
--    Sample Mod to increase build range of econ units.
--
-- Modified from "2x build range" by cino

--this function is called already in game. This gives us a hook to screw the
--blueprint values for the units

do

    local oldModBlueprints = ModBlueprints

    function ModBlueprints(all_bps)
        oldModBlueprints(all_bps)

        local buildRangeScale = 1.3
		
        --loop through the blueprints and adjust as desired.
        for id,bp in all_bps.Unit do
            if bp.Economy.MaxBuildDistance then
                bp.Economy.MaxBuildDistance = bp.Economy.MaxBuildDistance * buildRangeScale
            end
			if bp.Economy.BuildRate then
                if bp.Economy.MaxBuildDistance == nil then
					bp.Economy.MaxBuildDistance = 10
				end
				bp.Economy.MaxBuildDistance = bp.Economy.MaxBuildDistance * buildRangeScale
			end
        end
    end

end
