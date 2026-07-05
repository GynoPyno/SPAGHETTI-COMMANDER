-- OWPlusOutpostGenerator.lua
-- Fase 9-F18: sistema avamposti indipendente da marker di scena. Sostituisce il
-- sistema a settori/marker precedente (9-F11/12/13, 'OWPlus Vacant Expansion Area',
-- ExpansionFunction in Uveso Forward Base OverwhelmPlus.lua).
--
-- Motivazione (sess.64): il vecchio sistema dipendeva dai marker 'Expansion Area'
-- (richiedono 2+ estrattori entro 30u, vedi Conoscenze_AI_30) e 'Large Expansion
-- Area' (raggiunti tramite AIFindStartLocationNeedsEngineer, che pero' mischia
-- insieme marker reali E slot ARMY_X vuoti di altri giocatori — bug scoperto in
-- sess.64: avamposti costruiti su spawn altrui). Il nuovo sistema non cerca piu'
-- marker: genera i punti da solo lungo 8 direzioni fisse dal centro di MAIN,
-- validati a terreno e a distanza da OGNI start di giocatore (non solo il nostro).
--
-- Thread forkato da aiBrain (non da un platoon/unita') in overwhelmplusai.lua —
-- sopravvive per tutta la partita, stesso pattern di PriorityManagerThread/
-- LocationRangeManagerThread di Uveso (aiarchetype-managerloader.lua).

-- Ricette di composizione fabbriche per avamposto — scelta a caso (Random(), sync-safe)
-- ad ogni nuovo avamposto generato, cosi' non sono tutti identici. NON include
-- spaceship (Orbital Wars): quell'integrazione non e' ancora implementata (B3,
-- backlog AI_Mod_Spec.md) — aggiungerla qui darebbe un building-type inesistente.
local OWPlusOutpostRecipes = {
    { 'T1LandFactory' },
    { 'T1LandFactory', 'T1LandFactory' },
    { 'T1LandFactory', 'T1AirFactory' },
    { 'T1LandFactory', 'T1LandFactory', 'T1AirFactory' },
    { 'T1AirFactory' },
    { 'T1AirFactory', 'T1AirFactory' },
    { 'T1LandFactory', 'T1LandFactory', 'T1LandFactory' },
}

-- Le difese (T1GroundDefense/T1AADefense/T2ShieldDefense, stesse stringhe di 9-F16)
-- sono aggiunte dal builder 'OWPlus Outpost Factory.lua' (Construction.BuildStructures),
-- non qui — questo file genera solo le posizioni e sceglie la ricetta di fabbriche.

local AITargetManager = import('/mods/AI-Uveso/lua/AI/AITargetManager.lua')

local function OWPlusTerrainValid(x, z)
    local terrainH = GetTerrainHeight(x, z)
    local surfaceH = GetSurfaceHeight(x, z)
    return math.abs(surfaceH - terrainH) <= 0.5
end

-- Vero se (x,z) e' dentro l'area giocabile della mappa (stessa funzione usata
-- da Uveso stesso in aibuildstructures.lua per i limiti di ricerca).
local function OWPlusInPlayableArea(x, z, playableArea)
    return x >= playableArea[1] and x <= playableArea[3] and z >= playableArea[2] and z <= playableArea[4]
end

-- Vero se (x,z) e' abbastanza lontano da OGNI start di giocatore (non solo il
-- nostro) — evita di ripetere il bug ARMY_X scoperto nel vecchio sistema.
local function OWPlusFarFromEveryStart(x, z, minDist)
    for _, brain in ArmyBrains do
        if brain and not brain:IsDefeated() then
            local sx, sz = brain:GetArmyStartPos()
            if sx and VDist2(x, z, sx, sz) < minDist then
                return false
            end
        end
    end
    return true
end

-- Fase 9-F21: una direzione per thread, forkata in parallelo, invece di un
-- unico thread che scandiva le 8 direzioni in sequenza. Prima (9-F18/20) ogni
-- direzione richiedeva ~7 minuti (41 check * 10s) prima di passare alla
-- successiva — confermato in test: a 15 minuti di gioco l'espansione aveva
-- coperto solo 2-3 direzioni su 8. Ora tutte e 8 avanzano insieme, allo stesso
-- ritmo, fin da inizio partita.
local function OWPlusOutpostDirectionThread(aiBrain, angleDeg, startX, startZ, ownerName)
    local rad = math.rad(angleDeg)
    local dirX, dirZ = math.cos(rad), math.sin(rad)
    local perpX, perpZ = -dirZ, dirX
    local playableArea = AITargetManager.GetPlayableArea()

    -- Fase 9-F21: passo aumentato da 10 a 20 — a passo 10 gli avamposti
    -- risultavano troppo ravvicinati (osservato in test: strisce dense di
    -- 23 fabbriche di terra + 14 di aria lungo una singola direzione).
    local STEP = 20
    local MAX_DIST = 500

    while true do
        local dist = 90
        local offMap = false
        while dist <= MAX_DIST and not offMap do
            local checkKey = angleDeg .. '_' .. dist
            if not aiBrain.OWPlusOutpostChecked[checkKey] then
                local jitterDist = dist + Random(-5, 5)
                local jitterLateral = Random(-15, 15)
                local x = startX + dirX * jitterDist + perpX * jitterLateral
                local z = startZ + dirZ * jitterDist + perpZ * jitterLateral

                if not OWPlusInPlayableArea(x, z, playableArea) then
                    -- Fuori mappa: piu' lontano si andrebbe in questa direzione,
                    -- piu' si resterebbe fuori mappa. Fermiamo questa direzione
                    -- invece di continuare a controllare punti inutili — resta
                    -- innocua a livello di prestazioni (nessun ciclo attivo).
                    offMap = true
                    LOG('[OWPlus] Outpost (' .. ownerName .. '): direzione ' .. angleDeg
                        .. 'deg fuori mappa a dist=' .. dist .. ', fermata')
                elseif OWPlusTerrainValid(x, z) and OWPlusFarFromEveryStart(x, z, 80) then
                    aiBrain.OWPlusOutpostChecked[checkKey] = true
                    aiBrain.OWPlusOutpostCount = (aiBrain.OWPlusOutpostCount or 0) + 1
                    local slotKey = 'OUT' .. aiBrain.OWPlusOutpostCount
                    local surfaceH = GetSurfaceHeight(x, z)
                    aiBrain.OWPlusSubBases[slotKey] = { x, surfaceH, z }
                    local recipe = OWPlusOutpostRecipes[Random(1, table.getn(OWPlusOutpostRecipes))]
                    aiBrain.OWPlusOutpostRecipes[slotKey] = recipe
                    LOG('[OWPlus] Outpost (' .. ownerName .. '): registrato ' .. slotKey
                        .. ' a (' .. math.floor(x) .. ',' .. math.floor(z) .. ') direzione=' .. angleDeg
                        .. 'deg dist=' .. dist .. ', ricetta=' .. table.getn(recipe) .. ' fabbriche')
                    -- NON marchiamo checkKey come "definitivo" se il terreno fallisce: un
                    -- punto fallito oggi (es. detriti/prop temporanei) puo' essere riprovato
                    -- al prossimo giro, usando un nuovo scarto casuale.
                end
            end
            if not offMap then
                dist = dist + STEP
                WaitSeconds(10)
            end
        end
        -- Range esaurito o direzione fuori mappa: pausa lunga, poi riprova solo
        -- i punti ancora non validati (terreno) — i punti fuori mappa vengono
        -- ricontrollati ma falliscono subito senza lavoro pesante.
        WaitSeconds(300)
    end
end

-- Fase 9-F18/9-F21: entry point forkato da aiBrain in overwhelmplusai.lua. Crea
-- un thread indipendente per ciascuna delle 8 direzioni fisse (rosa dei venti)
-- dal centro di MAIN — vedi OWPlusOutpostDirectionThread sopra per i dettagli
-- di scansione, jitter e limite mappa. Nessun tetto sul numero di avamposti per
-- direzione — solo terreno valido e non troppo vicino a uno start altrui.
function OWPlusOutpostScanThread(aiBrain)
    local ownerName = (ArmyBrains[aiBrain:GetArmyIndex()] and ArmyBrains[aiBrain:GetArmyIndex()].Nickname) or tostring(aiBrain:GetArmyIndex())
    local startX, startZ = aiBrain:GetArmyStartPos()
    local angles = { 0, 45, 90, 135, 180, 225, 270, 315 }

    aiBrain.OWPlusSubBases = aiBrain.OWPlusSubBases or {}
    aiBrain.OWPlusOutpostRecipes = aiBrain.OWPlusOutpostRecipes or {}
    aiBrain.OWPlusOutpostChecked = aiBrain.OWPlusOutpostChecked or {}
    aiBrain.OWPlusOutpostCount = aiBrain.OWPlusOutpostCount or 0

    for _, angleDeg in angles do
        aiBrain:ForkThread(OWPlusOutpostDirectionThread, angleDeg, startX, startZ, ownerName)
    end
end
