do
    local oldModBlueprints = ModBlueprints

    function ModBlueprints(all_bps)
	    oldModBlueprints(all_bps)

        local storScale = 2.0
        
        --loop through the blueprints and adjust as desired.
        for id,bp in all_bps.Unit do
            if bp.Economy.StorageMass then
               bp.Economy.StorageMass = bp.Economy.StorageMass * storScale
            end
            if bp.Economy.StorageEnergy then
               bp.Economy.StorageEnergy = bp.Economy.StorageEnergy * storScale
            end  
        end
    end

end







