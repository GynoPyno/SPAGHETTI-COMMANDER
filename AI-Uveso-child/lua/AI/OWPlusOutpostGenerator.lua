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

local function OWPlusTerrainValid(x, z)
    local terrainH = GetTerrainHeight(x, z)
    local surfaceH = GetSurfaceHeight(x, z)
    return math.abs(surfaceH - terrainH) <= 0.5
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

-- Fase 9-F18: scansione periodica lungo 8 direzioni fisse (rosa dei venti) dal
-- centro di MAIN. Ad ogni distanza (passo 10, da 90 in su) non ancora valutata,
-- applica un piccolo scarto casuale (laterale + sulla distanza, Random() sync-safe
-- — nessun rischio di desync, ne' per il timing periodico ne' per la scelta
-- casuale: il motore lockstep esegue lo stesso codice deterministico su ogni
-- client allo stesso tick) e verifica terreno + distanza da ogni start. Nessun
-- tetto sul numero di avamposti per direzione — solo terreno valido e non troppo
-- vicino a uno start altrui.
function OWPlusOutpostScanThread(aiBrain)
    local ownerName = (ArmyBrains[aiBrain:GetArmyIndex()] and ArmyBrains[aiBrain:GetArmyIndex()].Nickname) or tostring(aiBrain:GetArmyIndex())
    local startX, startZ = aiBrain:GetArmyStartPos()
    local angles = { 0, 45, 90, 135, 180, 225, 270, 315 }
    local MAX_DIST = 500

    aiBrain.OWPlusSubBases = aiBrain.OWPlusSubBases or {}
    aiBrain.OWPlusOutpostRecipes = aiBrain.OWPlusOutpostRecipes or {}
    aiBrain.OWPlusOutpostChecked = aiBrain.OWPlusOutpostChecked or {}
    local outpostCount = 0

    -- Fase 9-F20: aggiunta un'attesa tra un check e il successivo. Prima
    -- (9-F18) il primo giro copriva TUTTO il range (90-500, passo 10) su tutte
    -- le 8 direzioni praticamente in un colpo solo (nessuna attesa interna al
    -- doppio ciclo) — confermato in test: gia' a 4 minuti di gioco erano stati
    -- generati 100+ avamposti, che competevano tutti insieme per i soli 6
    -- ingegneri paralleli e la massa di MAIN (causa reale delle fabbriche ferme
    -- osservate, non un problema di soglie economiche). Ora un'attesa di 10s tra
    -- ogni singolo check rende la crescita davvero graduale nel corso della
    -- partita, come voluto originariamente.
    while true do
        for _, angleDeg in angles do
            local rad = math.rad(angleDeg)
            local dirX, dirZ = math.cos(rad), math.sin(rad)
            local perpX, perpZ = -dirZ, dirX
            local dist = 90
            while dist <= MAX_DIST do
                local checkKey = angleDeg .. '_' .. dist
                if not aiBrain.OWPlusOutpostChecked[checkKey] then
                    local jitterDist = dist + Random(-5, 5)
                    local jitterLateral = Random(-15, 15)
                    local x = startX + dirX * jitterDist + perpX * jitterLateral
                    local z = startZ + dirZ * jitterDist + perpZ * jitterLateral

                    if OWPlusTerrainValid(x, z) and OWPlusFarFromEveryStart(x, z, 80) then
                        aiBrain.OWPlusOutpostChecked[checkKey] = true
                        outpostCount = outpostCount + 1
                        local slotKey = 'OUT' .. outpostCount
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
                dist = dist + 10
                WaitSeconds(10)
            end
        end
        WaitSeconds(300)
    end
end
