local BaseModBlueprints = ModBlueprints

function ModBlueprints(all_bps)
    BaseModBlueprints(all_bps)
    for id, bp in pairs(all_bps.Unit) do
        local lid = string.lower(id)

        if lid == 'bab1106' or lid == 'beb1106' or lid == 'brb1106' or lid == 'bsb1106' then
            -- Magazzino ibrido Massa+Energia T4 (BlackOps) -- non ha percorso di
            -- upgrade (a differenza della copia Jaggeds Infrastructure Pack), quindi
            -- rimuovere le categorie BUILTBY* lo rende irraggiungibile in ogni modo,
            -- non solo dal menu di costruzione diretta (stesso pattern usato in
            -- AntaresUnitPack-child per gli spacedock swab03/sweb03/swrb03/swsb03).
            if bp.Categories then
                local filtered = {}
                for _, cat in ipairs(bp.Categories) do
                    if not string.find(cat, 'BUILTBY') then
                        table.insert(filtered, cat)
                    end
                end
                bp.Categories = filtered
            end
        end
    end
end
