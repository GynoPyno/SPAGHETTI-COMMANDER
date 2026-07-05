-- OWPlusLogConditions.lua
-- Piccole funzioni BuildCondition custom usate dai builder OWPlus per la forward base:
-- alcune sono diagnostiche (LOG + return true, condizione neutra), altre sono
-- condizioni reali (verificano stato su aiBrain.OWPlusSubBases/OWPlusForwardBaseMarkers).

-- Log quando la forward base tenta di espandersi con una nuova fabbrica terra.
function OWPlusLogForwardExpansion(aiBrain, label)
    LOG('[OWPlus] ForwardBase: espansione in corso — builder "' .. tostring(label) .. '" ha superato tutte le condizioni, avvio costruzione')
    return true
end

-- Verifica se uno slot forward base esiste in aiBrain.OWPlusSubBases (registrato da
-- ExpansionFunction quando un marker viene accettato). Usata da 'OWPlus Forward Extra
-- Factory' per sapere se un dato slot (FWD1..FWD4) e' gia' stato assegnato.
function OWPlusForwardSlotExists(aiBrain, slotKey)
    return aiBrain.OWPlusSubBases ~= nil and aiBrain.OWPlusSubBases[slotKey] ~= nil
end

-- Fase 9-F9: quante basi forward sono gia' state accettate (aiBrain.OWPlusForwardBaseMarkers,
-- popolato da ExpansionFunction). Usata per il trigger a due livelli di
-- 'OWPlus Vacant Expansion Area': prima base con soglia bassa, 2a-4a con soglia piu' alta.
-- NOTA (Fase 9-F18): 'OWPlus Vacant Expansion Area' e il sistema a marker/settori sono
-- stati sostituiti dal generatore di avamposti indipendente (OWPlusOutpostGenerator.lua).
-- Questa funzione resta per compatibilita' storica ma non e' piu' referenziata da nessun
-- builder attivo.
function OWPlusForwardCountInRange(aiBrain, minCount, maxCount)
    local count = 0
    if aiBrain.OWPlusForwardBaseMarkers then
        for _ in pairs(aiBrain.OWPlusForwardBaseMarkers) do
            count = count + 1
        end
    end
    return count >= minCount and count < maxCount
end

-- Fase 9-F18: c'e' almeno un avamposto generato (OWPlusOutpostGenerator.lua) non ancora
-- rivendicato da un ingegnere? aiBrain.OWPlusOutpostClaimed traccia gli slot 'OUT#' gia'
-- presi in carico (non ancora quelli completati - una volta costruita la fabbrica lo slot
-- resta comunque "claimed" per sempre, cosi' non viene ripreso in carico una seconda volta).
function OWPlusHasUnclaimedOutpost(aiBrain)
    if not aiBrain.OWPlusSubBases then return false end
    aiBrain.OWPlusOutpostClaimed = aiBrain.OWPlusOutpostClaimed or {}
    for slotKey, _ in aiBrain.OWPlusSubBases do
        if string.sub(slotKey, 1, 3) == 'OUT' and not aiBrain.OWPlusOutpostClaimed[slotKey] then
            return true
        end
    end
    return false
end
