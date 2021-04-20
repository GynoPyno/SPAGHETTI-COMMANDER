

do
    local oldModBlueprints = ModBlueprints

    function ModBlueprints(all_bps)
	    oldModBlueprints(all_bps)

        local econScale = 1.5

        for id,bp in all_bps.Unit do
            if bp.Economy.ProductionPerSecondMass then
               bp.Economy.ProductionPerSecondMass = bp.Economy.ProductionPerSecondMass * econScale
            end
            if bp.Economy.ProductionPerSecondEnergy then
               bp.Economy.ProductionPerSecondEnergy = bp.Economy.ProductionPerSecondEnergy * econScale
            end  
        end
    end

end




