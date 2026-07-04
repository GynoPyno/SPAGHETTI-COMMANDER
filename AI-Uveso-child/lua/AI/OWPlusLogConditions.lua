-- OWPlusLogConditions.lua
-- Funzioni BuildCondition che stampano un LOG diagnostico e restituiscono sempre true.
-- Usate come ultima condizione in BuilderConditions per confermare quando un builder
-- supera tutte le condizioni reali e sta per tentare la costruzione — senza alterare
-- la logica del builder (return true = condizione neutra, non blocca mai).

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
