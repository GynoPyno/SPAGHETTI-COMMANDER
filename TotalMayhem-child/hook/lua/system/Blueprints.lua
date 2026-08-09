local BaseModBlueprints = ModBlueprints

function ModBlueprints(all_bps)
    BaseModBlueprints(all_bps)
    for id, bp in pairs(all_bps.Unit) do
        local lid = string.lower(id)

        if lid == 'brmbt1peri' or lid == 'brnbt1peri' or lid == 'brobt1peri' or lid == 'brpbt1peri' or lid == 'brnbaafac' then
            -- Sess.98 (richiesta esplicita utente, test manuale in game):
            -- 'Overlook'/'Hacker'/'Finther'/'Uyal Ha-Esel' (radar, 4 varianti per
            -- fazione) e 'Sky-Force' (difesa antiaerea, 1 variante condivisa) sono
            -- tutte taggate categoria HYDROCARBON -- costruibili sugli stessi
            -- depositi della vera centrale a idrocarburi, ma non producono energia.
            -- L'AI si confonde e le costruisce al posto della centrale, sprecando
            -- lo slot e bloccando la progressione economica iniziale. Rimuovere le
            -- categorie BUILTBY* le rende non costruibili in alcun modo (stesso
            -- pattern gia' usato per il duplicato T4 di BlackOpsFAF-Unleashed-child).
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
