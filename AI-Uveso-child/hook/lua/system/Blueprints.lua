-- AI-Uveso-child: hook Blueprints.lua
-- Sess.87: KEB2304 ("Thor", #Marlos mods compilation) risultava sempre
-- CanBuild=false per qualunque ingegnere (152 fallimenti confermati in un
-- solo test, mai un successo) — causa: nel .bp sorgente della mod
-- 'BUILTBYTIER3ENGINEER' e 'BUILTBYTIER3COMMANDER' sono COMMENTATE (WIP mai
-- completato dal modder), quindi l'unita' non e' costruibile da nessuno.
-- Non tocchiamo il file sorgente (mod terza, sola lettura per convenzione di
-- progetto) — le riattiviamo qui via ModBlueprints, stesso meccanismo gia'
-- usato da AntaresUnitPack-child per casi analoghi.
local BaseModBlueprints = ModBlueprints

function ModBlueprints(all_bps)
    if BaseModBlueprints then
        BaseModBlueprints(all_bps)
    end
    for id, bp in pairs(all_bps.Unit) do
        if string.lower(id) == 'keb2304' then
            if bp.Categories then
                table.insert(bp.Categories, 'BUILTBYTIER3ENGINEER')
                table.insert(bp.Categories, 'BUILTBYTIER3COMMANDER')
                LOG('[OWPlus] Blueprints: OK, KEB2304 - riabilitate BUILTBYTIER3ENGINEER/COMMANDER (erano commentate nel .bp sorgente)')
            end
        end
    end
end
