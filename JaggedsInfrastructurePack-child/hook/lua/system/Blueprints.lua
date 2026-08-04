local BaseModBlueprints = ModBlueprints

function ModBlueprints(all_bps)
    BaseModBlueprints(all_bps)
    for id, bp in pairs(all_bps.Unit) do
        local lid = string.lower(id)

        if lid == 'euabest2' or lid == 'euebest2' or lid == 'eurbest2' or lid == 'exsbest2' then      -- Energy Storage T2 (tutte le fazioni)
            if bp.Economy then
                bp.Economy.StorageEnergy = 15000
                bp.Economy.BuildCostEnergy = 15000
                bp.Economy.BuildCostMass = 200
            end

        elseif lid == 'euabest3' or lid == 'euebest3' or lid == 'eurbest3' or lid == 'exsbest3' then  -- Energy Storage T3 (tutte le fazioni)
            if bp.Economy then
                bp.Economy.StorageEnergy = 45000
                bp.Economy.BuildCostEnergy = 67500
                bp.Economy.BuildCostMass = 400
            end

        elseif lid == 'euabmst2' or lid == 'euebmst2' then    -- Mass Storage T2 Aeon/UEF
            if bp.Economy then
                bp.Economy.StorageMass = 1500
                bp.Economy.BuildCostEnergy = 2250
                bp.Economy.BuildCostMass = 950
            end

        elseif lid == 'eurbmst2' or lid == 'exsbmst2' then    -- Mass Storage T2 Cybran/Seraphim (costo massa originale gia' asimmetrico vs Aeon/UEF)
            if bp.Economy then
                bp.Economy.StorageMass = 1500
                bp.Economy.BuildCostEnergy = 2250
                bp.Economy.BuildCostMass = 750
            end

        elseif lid == 'euabmst3' or lid == 'euebmst3' or lid == 'eurbmst3' or lid == 'exsbmst3' then  -- Mass Storage T3 (tutte le fazioni)
            if bp.Economy then
                bp.Economy.StorageMass = 4500
                bp.Economy.BuildCostEnergy = 4500
                bp.Economy.BuildCostMass = 3000
            end

        elseif lid == 'bab1106' or lid == 'beb1106' or lid == 'brb1106' or lid == 'bsb1106' then      -- Magazzino ibrido Massa+Energia T4 (tutte le fazioni)
            -- Storage a 2/3 (non 3/4 come il resto, richiesta esplicita utente), costo a 3/4 come tutti gli altri
            if bp.Economy then
                bp.Economy.StorageMass = 5000
                bp.Economy.StorageEnergy = 50000
                bp.Economy.BuildCostEnergy = 75000
                bp.Economy.BuildCostMass = 3750
            end
        end
    end
end
