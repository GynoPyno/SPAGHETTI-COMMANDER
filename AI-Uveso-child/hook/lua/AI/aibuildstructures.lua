-- Sess.98 (bis): hook minimale (funzione sciolta) su un bug NATIVO del
-- motore FAF, non introdotto da questo progetto. In AIBuildAdjacency
-- (/lua/ai/aibuildstructures.lua) il campo che dice alla scelta finale di
-- posizionamento "preferisci vicino a questo punto" viene letto con un typo
-- case-sensitive: 'BuildManagerdata' (d minuscola) invece di
-- 'BuildManagerData' (D maiuscola, usato correttamente due righe sopra nello
-- stesso costrutto if). Lua e' case-sensitive: quel campo non esiste mai su
-- 'builder', quindi baseLocation resta sempre {nil, nil, nil} (il default
-- dichiarato subito sopra) e la funzione nativa FindPlaceToBuild riceve
-- sempre nil come punto di preferenza.
--
-- Impatto osservato in game: builder con Construction.AdjacencyCategory
-- (es. i nostri magazzini massa/energia, radius 9999 da sess.98) continuano
-- a costruire solo vicino a MAIN nonostante candidati liberi esistano su
-- tutta la mappa -- allargare il raggio di RICERCA (gia' fatto) non basta,
-- perche' il bug e' nella scelta FINALE tra i candidati trovati, non nella
-- ricerca stessa. Fix: copia esatta della funzione nativa con la sola
-- correzione del typo. Impatta globalmente ogni builder (non solo Uveso) che
-- passi da AIBuildAdjacency -- effetto atteso positivo, nessuna logica
-- cambiata a parte il campo corretto.
LOG('[AI-Uveso-child] aibuildstructures.lua: OK, hook AIBuildAdjacency attivo (fix typo nativo BuildManagerdata->BuildManagerData)')

function AIBuildAdjacency(aiBrain, builder, buildingType, closeToBuilder, relative, buildingTemplate, baseTemplate, reference, NearMarkerType)
    local whatToBuild = aiBrain:DecideWhatToBuild(builder, buildingType, buildingTemplate)
    if whatToBuild then
        local unitSize = aiBrain:GetUnitBlueprint(whatToBuild).Physics
        local template = {}
        table.insert(template, {})
        table.insert(template[1], { buildingType })
        for k, v in reference do
            if not v.Dead then
                local targetSize = v:GetBlueprint().Physics
                local targetPos = v:GetPosition()
                targetPos[1] = targetPos[1] - (targetSize.SkirtSizeX/2)
                targetPos[3] = targetPos[3] - (targetSize.SkirtSizeZ/2)
                -- Top/bottom of unit
                for i=0,((targetSize.SkirtSizeX/2)-1) do
                    local testPos = { targetPos[1] + 1 + (i * 2), targetPos[3]-(unitSize.SkirtSizeZ/2), 0 }
                    local testPos2 = { targetPos[1] + 1 + (i * 2), targetPos[3]+targetSize.SkirtSizeZ+(unitSize.SkirtSizeZ/2), 0 }
                    if testPos[1] > 8 and testPos[1] < ScenarioInfo.size[1] - 8 and testPos[2] > 8 and testPos[2] < ScenarioInfo.size[2] - 8 then
                        table.insert(template[1], testPos)
                    end
                    if testPos2[1] > 8 and testPos2[1] < ScenarioInfo.size[1] - 8 and testPos2[2] > 8 and testPos2[2] < ScenarioInfo.size[2] - 8 then
                        table.insert(template[1], testPos2)
                    end
                end
                -- Sides of unit
                for i=0,((targetSize.SkirtSizeZ/2)-1) do
                    local testPos = { targetPos[1]+targetSize.SkirtSizeX + (unitSize.SkirtSizeX/2), targetPos[3] + 1 + (i * 2), 0 }
                    local testPos2 = { targetPos[1]-(unitSize.SkirtSizeX/2), targetPos[3] + 1 + (i*2), 0 }
                    if testPos[1] > 8 and testPos[1] < ScenarioInfo.size[1] - 8 and testPos[2] > 8 and testPos[2] < ScenarioInfo.size[2] - 8 then
                        table.insert(template[1], testPos)
                    end
                    if testPos2[1] > 8 and testPos2[1] < ScenarioInfo.size[1] - 8 and testPos2[2] > 8 and testPos2[2] < ScenarioInfo.size[2] - 8 then
                        table.insert(template[1], testPos2)
                    end
                end
            end
        end
        -- build near the base the engineer is part of, rather than the engineer location
        local baseLocation = {nil, nil, nil}
        if builder.BuildManagerData and builder.BuildManagerData.EngineerManager then
            -- Sess.98 (bis): fix typo nativo -- 'BuildManagerdata' -> 'BuildManagerData'
            baseLocation = builder.BuildManagerData.EngineerManager.Location
        end
        local location = aiBrain:FindPlaceToBuild(buildingType, whatToBuild, template, false, builder, baseLocation[1], baseLocation[3])
        if location then
            if location[1] > 8 and location[1] < ScenarioInfo.size[1] - 8 and location[2] > 8 and location[2] < ScenarioInfo.size[2] - 8 then
                AddToBuildQueue(aiBrain, builder, whatToBuild, location, false)
                return true
            end
        end
        -- Build in a regular spot if adjacency not found
        return AIExecuteBuildStructure(aiBrain, builder, buildingType, builder, true, buildingTemplate, baseTemplate)
    end
    return false
end
