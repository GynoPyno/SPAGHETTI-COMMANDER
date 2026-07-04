-- Uveso Forward Base OverwhelmPlus.lua
-- Template per la base avanzata direzionale (OWPlusForwardBase).
-- Viene selezionato da ExpansionFunction quando un marker 'Expansion Area' o
-- 'Large Expansion Area' si trova in direzione del nemico e a distanza
-- ragionevole da MAIN.
-- Contiene solo fabbriche terra (per unita' da combattimento) + difese.
-- Gli ingegneri vengono inviati da MAIN, non nascono qui.
--
-- Fase 9-F5 (2026-07-03): markerType allargato da solo 'Expansion Area' (2 sulla
-- mappa scmp_009) anche a 'Large Expansion Area' (8 sulla mappa) — prima questi
-- ultimi finivano tutti gestiti dal template stock UvesoExpansionAreaLarge (nessun
-- filtro direzionale, produzione non coordinata con la nostra strategia). Aggiunto
-- anche un cap MAX_FORWARD_BASES per evitare dispersione eccessiva di risorse.

BaseBuilderTemplate {
    BaseTemplateName = 'OWPlusForwardBase',
    Builders = {
        -----------------------------------------------------------------------------
        -- Ingegneri: vengono da MAIN. Assistono le costruzioni e tornano a MAIN.
        -- NON includere 'U123 Engineer Builders': gli ingegneri non nascono qui.
        -----------------------------------------------------------------------------
        'UC123 Assistees',
        'U123 Engineer Transfer To MainBase',

        -----------------------------------------------------------------------------
        -- Fabbriche: costruite da MAIN via OWPlus Forward Extra Factory (Fase 9-F7),
        -- che riusa il Plan OWPlusDispersedBuildAI gia' collaudato per i nodi dispersi.
        -- 'OWPlus Forward Land Factory' (EngineerBuilder generico Uveso) rimosso:
        -- non trovava mai un ingegnere disponibile in loco (EngineerCount=0 qui),
        -- causava spam infinito di "espansione in corso" senza mai costruire nulla.
        -- U123 Factory Upgrader Rush aggiorna T1->T2->T3.
        -----------------------------------------------------------------------------
        'U123 Factory Upgrader Rush',

        -----------------------------------------------------------------------------
        -- Produzione unita' terra: solo combattimento.
        -- OWPlus Land T2T3 bypassa i builder Uveso default e garantisce T2/T3.
        -----------------------------------------------------------------------------
        'U123 Land Builders Panic',
        'U123 Land Builders ADAPTIVE',
        'OWPlus Land T2T3',

        -----------------------------------------------------------------------------
        -- Former: le unita' attaccano appena formate, senza gate NoRush.
        -----------------------------------------------------------------------------
        'OWPlus Land Formers Aggressive',

        -----------------------------------------------------------------------------
        -- Difese locali: scudi, AA, point defense.
        -----------------------------------------------------------------------------
        'U23 Shields Builder',
        'U23 Shields Upgrader',
        'U234 Repair Shields Former',
        'U123 Defense Anti Air Builders',
        'U123 Defense Anti Ground Builders',

        -----------------------------------------------------------------------------
        -- Scout.
        -----------------------------------------------------------------------------
        'U1 Land Scout Builders',
        'U1 Air Scout Builders',
        'U1 Land Scout Formers',
        'U13 Air Scout Formers',
    },
    NonCheatBuilders = {},

    BaseSettings = {
        FactoryCount = {
            Land = 2,
            Air  = 0,
            Sea  = 0,
            Gate = 0,
        },
        EngineerCount = {
            Tech1 = 0,
            Tech2 = 0,
            Tech3 = 0,
            SCU   = 0,
        },
        MassToFactoryValues = {
            T1Value  = 6,
            T2Value  = 15,
            T3Value  = 22.5,
        },
    },

    -- ExpansionFunction: chiamata per ogni marker 'Expansion Area' / 'Large Expansion Area' sulla mappa.
    -- Restituisce 2000 (> 1000 di UvesoExpansionArea) solo per marker che sono:
    --   1. In direzione del nemico piu' vicino (dot product > 0.3, angolo < ~72 deg)
    --   2. A distanza ragionevole da MAIN (60-220 unita')
    --   3. Non fanno superare il cap MAX_FORWARD_BASES di basi forward gia' accettate
    -- Per tutti gli altri marker restituisce -1 (UvesoExpansionArea li gestisce).
    ExpansionFunction = function(aiBrain, location, markerType)
        if not aiBrain.Uveso then return -1 end
        if markerType ~= 'Expansion Area' and markerType ~= 'Large Expansion Area' then return -1 end

        local myX, myZ = aiBrain:GetArmyStartPos()
        local markerX = location.x or location[1]
        local markerZ = location.z or location[3]
        if not markerX or not markerZ then
            LOG('[OWPlus] ForwardBase ExpansionFunction: location senza coordinate, skip')
            return -1
        end

        -- Cap sul numero di basi forward: una volta accettato, un marker resta
        -- accettato per sempre (la base e' gia' in costruzione li') — il cap si
        -- applica solo a NUOVI marker candidati.
        local MAX_FORWARD_BASES = 4
        local markerKey = math.floor(markerX) .. '_' .. math.floor(markerZ)
        aiBrain.OWPlusForwardBaseMarkers = aiBrain.OWPlusForwardBaseMarkers or {}

        if aiBrain.OWPlusForwardBaseMarkers[markerKey] then
            return 2000
        end

        local acceptedCount = 0
        for _ in pairs(aiBrain.OWPlusForwardBaseMarkers) do
            acceptedCount = acceptedCount + 1
        end
        if acceptedCount >= MAX_FORWARD_BASES then
            return -1
        end

        -- Nemico corrente: usa aiBrain:GetCurrentEnemy() (stesso meccanismo di
        -- CanPathToCurrentEnemy in MiscBuildConditions.lua di Uveso) invece di un
        -- ciclo manuale su ArmyBrains+IsEnemy — piu' robusto e gia' testato/attivo
        -- in questa stessa run (CanPathToCurrentEnemy ha trovato il nemico correttamente
        -- per entrambe le AI in un test FFA dove il ciclo manuale falliva).
        local currentEnemy = aiBrain:GetCurrentEnemy()
        if not currentEnemy then
            LOG('[OWPlus] ForwardBase ExpansionFunction: GetCurrentEnemy() nil, skip')
            return -1
        end
        local enemyX, enemyZ = currentEnemy:GetArmyStartPos()
        if not enemyX or not enemyZ then
            LOG('[OWPlus] ForwardBase ExpansionFunction: nemico senza start pos, skip')
            return -1
        end

        -- Vettore verso il nemico
        local dx = enemyX - myX
        local dz = enemyZ - myZ
        local enemyDist = math.sqrt(dx*dx + dz*dz)

        -- Vettore verso il marker
        local mx = markerX - myX
        local mz = markerZ - myZ
        local markerDist = math.sqrt(mx*mx + mz*mz)
        if markerDist < 1 then return -1 end

        -- Dot product: coseno dell'angolo tra direzione-nemico e direzione-marker
        local dot = (dx*mx + dz*mz) / (enemyDist * markerDist)

        -- Rifiuta marker fuori dal cono "forward" (angolo > ~72 deg = cos < 0.3)
        if dot < 0.3 then return -1 end

        -- Rifiuta marker troppo vicini a MAIN o troppo lontani
        if markerDist < 60 or markerDist > 220 then return -1 end

        -- Fase 9-F8: verifica validita' del terreno PRIMA di accettare definitivamente
        -- il marker — altrimenti uno slot su MAX_FORWARD_BASES resterebbe sprecato per
        -- sempre su una posizione mai costruibile (visto in gioco: marker accettato ma
        -- 'terreno non valido' ripetuto ogni 30s per tutta la partita). Se surfaceHeight
        -- e terrainHeight divergono di oltre 0.5, il punto e' probabilmente acqua o
        -- terreno troppo irregolare — scarta e lascia che un altro marker venga provato.
        local terrainH = GetTerrainHeight(markerX, markerZ)
        local surfaceH = GetSurfaceHeight(markerX, markerZ)
        if math.abs(surfaceH - terrainH) > 0.5 then
            LOG('[OWPlus] ForwardBase: marker (' .. math.floor(markerX) .. ',' .. math.floor(markerZ)
                .. ') scartato, terreno non valido (terrainH=' .. string.format('%.1f', terrainH)
                .. ' surfaceH=' .. string.format('%.1f', surfaceH) .. ')')
            return -1
        end

        -- Marker accettato: registra per sempre (cap si applica solo a nuovi marker)
        aiBrain.OWPlusForwardBaseMarkers[markerKey] = true

        -- Fase 9-F7: registra la posizione anche in OWPlusSubBases (stessa tabella
        -- gia' usata da OWPlusDispersedBuildAI per i nodi NE/SE/SW/NW) cosi'
        -- 'OWPlus Forward Extra Factory' (builder a MAIN) puo' inviare un ingegnere
        -- qui riusando il Plan gia' collaudato, invece del builder locale generico
        -- che non trovava mai un ingegnere disponibile (EngineerCount=0 alla forward base).
        local slotKey = 'FWD' .. (acceptedCount + 1)
        aiBrain.OWPlusSubBases = aiBrain.OWPlusSubBases or {}
        aiBrain.OWPlusSubBases[slotKey] = { markerX, surfaceH, markerZ }
        LOG('[OWPlus] ForwardBase: registrato slot ' .. slotKey .. ' in OWPlusSubBases per costruzione da MAIN')

        LOG('[OWPlus] ForwardBase: marker ACCETTATO tipo=' .. tostring(markerType)
            .. ' (' .. math.floor(markerX) .. ',' .. math.floor(markerZ)
            .. ') dot=' .. string.format('%.2f', dot)
            .. ' dist=' .. math.floor(markerDist)
            .. ' basi accettate=' .. (acceptedCount + 1) .. '/' .. MAX_FORWARD_BASES)

        -- 2000 > 1000 (UvesoExpansionArea) -> questo template vince il marker
        return 2000
    end,
}
