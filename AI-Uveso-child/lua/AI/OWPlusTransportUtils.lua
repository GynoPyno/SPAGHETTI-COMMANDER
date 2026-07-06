-- OWPlusTransportUtils.lua
-- Fase 9-F30: logistica trasporto scritta a mano, sostituisce
-- AIAttackUtils.SendPlatoonWithTransportsNoCheck — quella funzione (motore,
-- nessun sorgente leggibile) confermato in sess.66 non usa mai un trasporto
-- anche quando ce n'e' uno completamente libero fermo a MAIN, senza errori ne'
-- un motivo verificabile. Qui ogni passo e' esplicito e diagnosticabile.
--
-- Pattern di comandi (IssueTransportLoad/IssueMove/IssueTransportUnload,
-- verifica tramite :IsIdleState()) ricalcato da /lua/AI/aiutilities.lua del
-- gioco base (funzione di caricamento truppe su trasporto), non inventato.

local categories = categories

local LOAD_TIMEOUT = 60
local FLY_TIMEOUT = 120
local UNLOAD_TIMEOUT = 40
local POLL_INTERVAL = 2
local ARRIVAL_DIST = 15

-- Cerca un trasporto libero vicino a una posizione. "Libero" = non morto e non
-- gia' impegnato in un movimento/carico/scarico/traghetto proprio.
local function OWPlusFindIdleTransport(aiBrain, nearPos, radius)
    local candidates = aiBrain:GetUnitsAroundPoint(categories.MOBILE * categories.AIR * categories.TRANSPORTFOCUS, nearPos, radius or 200, 'Ally') or {}
    for _, t in candidates do
        if not t.Dead
            and not t:IsUnitState('Moving')
            and not t:IsUnitState('Attached')
            and not t:IsUnitState('Busy')
            and not t:IsUnitState('WaitingForTransport')
            and not t:IsUnitState('TransportLoading')
            and not t:IsUnitState('TransportUnloading')
            and not t:IsUnitState('Ferrying') then
            return t
        end
    end
    return nil
end

-- Fase 9-F30: trasporta 'unit' fino a 'destinationPos' usando un trasporto
-- libero cercato vicino a 'searchPos'. Ritorna true se l'unita' e' arrivata a
-- destinazione via trasporto, false se qualcosa e' fallito — chi chiama deve
-- ricadere sul cammino a piedi.
function OWPlusTransportUnit(aiBrain, unit, searchPos, destinationPos)
    if not unit or unit.Dead then
        return false
    end

    -- 1. Trova un trasporto libero
    local transport = OWPlusFindIdleTransport(aiBrain, searchPos, 200)
    if not transport then
        LOG("[OWPlus] Trasporto: nessun trasporto libero trovato vicino alla posizione di ricerca")
        return false
    end
    LOG('[OWPlus] Trasporto: OK, trovato trasporto libero (' .. tostring(transport.UnitId) .. '), avvio carico')

    -- 2. Carica l'unita' sul trasporto
    IssueClearCommands({ unit })
    IssueClearCommands({ transport })
    IssueTransportLoad({ unit }, transport)

    local waited = 0
    while waited < LOAD_TIMEOUT and not unit.Dead and not transport.Dead and not unit:IsIdleState() do
        WaitSeconds(POLL_INTERVAL)
        waited = waited + POLL_INTERVAL
    end
    if unit.Dead or transport.Dead or not unit:IsUnitState('Attached') then
        LOG("[OWPlus] Trasporto: carico fallito o troppo lento, timeout " .. LOAD_TIMEOUT .. "s")
        return false
    end
    LOG("[OWPlus] Trasporto: OK, unita caricata, avvio volo verso destinazione")

    -- 3. Vola verso destinazione
    IssueClearCommands({ transport })
    IssueMove({ transport }, destinationPos)

    waited = 0
    while waited < FLY_TIMEOUT and not unit.Dead and not transport.Dead do
        local pos = transport:GetPosition()
        if pos and VDist2(pos[1], pos[3], destinationPos[1], destinationPos[3]) < ARRIVAL_DIST then
            break
        end
        WaitSeconds(POLL_INTERVAL)
        waited = waited + POLL_INTERVAL
    end
    if unit.Dead or transport.Dead then
        LOG("[OWPlus] Trasporto: unita o trasporto morto durante il volo")
        return false
    end
    local finalPos = transport:GetPosition()
    if not finalPos or VDist2(finalPos[1], finalPos[3], destinationPos[1], destinationPos[3]) >= ARRIVAL_DIST then
        LOG("[OWPlus] Trasporto: volo troppo lento, non arrivato entro " .. FLY_TIMEOUT .. "s")
        return false
    end
    LOG("[OWPlus] Trasporto: OK, arrivato a destinazione, avvio scarico")

    -- 4. Scarica l'unita' a destinazione
    IssueTransportUnload({ transport }, destinationPos)

    waited = 0
    while waited < UNLOAD_TIMEOUT and not unit.Dead and unit:IsUnitState('Attached') do
        WaitSeconds(POLL_INTERVAL)
        waited = waited + POLL_INTERVAL
    end
    if unit.Dead or unit:IsUnitState('Attached') then
        LOG("[OWPlus] Trasporto: scarico fallito o troppo lento, timeout " .. UNLOAD_TIMEOUT .. "s")
        return false
    end

    LOG("[OWPlus] Trasporto: OK, unita scaricata con successo a destinazione")
    return true
end
