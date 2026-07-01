-- Uveso Forward Base OverwhelmPlus.lua
-- Template per la base avanzata direzionale (OWPlusForwardBase).
-- Viene selezionato da ExpansionFunction quando un marker 'Expansion Area'
-- si trova in direzione del nemico e a distanza ragionevole da MAIN.
-- Contiene solo fabbriche terra (per unita' da combattimento) + difese.
-- Gli ingegneri vengono inviati da MAIN, non nascono qui.

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
        -- Fabbriche: solo terra. Builder personalizzato (solo T1LandFactory).
        -- U123 Factory Upgrader Rush aggiorna T1->T2->T3.
        -----------------------------------------------------------------------------
        'OWPlus Forward Land Factory',
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

    -- ExpansionFunction: chiamata per ogni marker 'Expansion Area' sulla mappa.
    -- Restituisce 2000 (> 1000 di UvesoExpansionArea) solo per marker che sono:
    --   1. In direzione del nemico piu' vicino (dot product > 0.3, angolo < ~72 deg)
    --   2. A distanza ragionevole da MAIN (60-220 unita')
    -- Per tutti gli altri marker restituisce -1 (UvesoExpansionArea li gestisce).
    ExpansionFunction = function(aiBrain, location, markerType)
        if not aiBrain.Uveso then return -1 end
        if markerType ~= 'Expansion Area' then return -1 end

        local myX, myZ = aiBrain:GetArmyStartPos()
        local markerX = location.x or location[1]
        local markerZ = location.z or location[3]
        if not markerX or not markerZ then
            LOG('[OWPlus] ForwardBase ExpansionFunction: location senza coordinate, skip')
            return -1
        end

        -- Trova il nemico piu' vicino (qualsiasi army marcato come nemico)
        local enemyX, enemyZ = nil, nil
        local bestDistSq = math.huge
        for _, army in pairs(ArmyBrains) do
            if IsEnemy(aiBrain:GetArmyIndex(), army:GetArmyIndex()) then
                local ex, ez = army:GetArmyStartPos()
                local d = (ex - myX)^2 + (ez - myZ)^2
                if d < bestDistSq then
                    bestDistSq = d
                    enemyX, enemyZ = ex, ez
                end
            end
        end
        if not enemyX then
            LOG('[OWPlus] ForwardBase ExpansionFunction: nessun nemico trovato, skip')
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

        LOG('[OWPlus] ForwardBase: marker ACCETTATO ('
            .. math.floor(markerX) .. ',' .. math.floor(markerZ)
            .. ') dot=' .. string.format('%.2f', dot)
            .. ' dist=' .. math.floor(markerDist))

        -- 2000 > 1000 (UvesoExpansionArea) -> questo template vince il marker
        return 2000
    end,
}
