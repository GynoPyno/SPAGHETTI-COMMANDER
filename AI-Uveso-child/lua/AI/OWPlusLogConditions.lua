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
function OWPlusForwardCountInRange(aiBrain, minCount, maxCount)
    local count = 0
    if aiBrain.OWPlusForwardBaseMarkers then
        for _ in pairs(aiBrain.OWPlusForwardBaseMarkers) do
            count = count + 1
        end
    end
    return count >= minCount and count < maxCount
end
