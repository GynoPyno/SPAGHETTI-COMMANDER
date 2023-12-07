do
    local oldModBlueprints = ModBlueprints
    
    function ModBlueprints(all_bps)
	    oldModBlueprints(all_bps)

        --loop through the blueprints and adjust as desired.
        for id,bp in all_bps.Unit do
						if bp.BlueprintId == 'uab1101' 
						or bp.BlueprintId == 'ueb1101'
						or bp.BlueprintId == 'urb1101'
						or bp.BlueprintId == 'xsb1101' then
					  		  #LOG(bp)
            		  #LOG(bp.Description)
            		  #LOG(bp.BlueprintId)
            		  #LOG(bp.Economy)
            		  bp.Economy.BuildCostEnergy = 375
            		  bp.Economy.BuildCostMass = 75
            		  bp.Economy.BuildTime = 125
            		  bp.Economy.ProductionPerSecondEnergy = 25
            end
        end
    end

end