-- Author: cino
--
-- Description:
--    Sample Mod to double build range of econ units.
--
-- Modified from "fastbuild x2 range x5 power" by bk0

--this function is called already in game. This gives us a hook to screw the
--blueprint values for the units

do

    local oldModBlueprints = ModBlueprints

    function ModBlueprints(all_bps)
        oldModBlueprints(all_bps)

        local buildRangeScale = 2.0
		
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
