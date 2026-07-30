-- OWPlusOutpostOwnership.lua
-- Fase F (B16 - Avamposti autonomi, sess.88): mappa di appartenenza esplicita
-- unita'->avamposto, sostituisce l'inferenza per prossimita' (GetUnitsAroundPoint
-- + raggio fisso) usata finora dal conteggio difese/scudi/artiglieria.
--
-- Perche': il generatore piazza avamposti a passi di 20 unita' (STEP=20,
-- OWPlusOutpostGenerator.lua), il vecchio scan di conteggio usava un raggio di
-- 40 — confermato su un test reale (posizioni vere in dev.log) che OGNI coppia
-- di avamposti consecutivi cade tra 13 e 31 unita' di distanza, quindi sempre
-- dentro il raggio 40 l'uno dell'altro. Risultato: le difese di un avamposto
-- venivano contate anche dal vicino, gonfiando entrambi i conteggi ben oltre
-- il tetto (osservato in game: "terra 8/5, AA 12/5" quando il tetto reale era
-- 5). Non e' un bug isolato di scudi/artiglieria (introdotti in Fase E): tocca
-- allo stesso modo terra/AA, presenti dalla sess.86.
--
-- Disegno (deciso esplicitamente con l'utente dopo un confronto su due
-- alternative): un INSIEME per avamposto (tabella chiave=riferimento diretto
-- all'unita', valore=true) invece di un array — aggiunta/rimozione/verifica
-- appartenenza sono O(1), nessuna ricerca lineare per rimuovere un'unita'
-- specifica. Stesso principio gia' in uso nel progetto per un singolo
-- riferimento (aiBrain.OWPlusOutpostFactories[outpostKey] = factory), qui
-- esteso a una collezione. Vantaggio rispetto a un tag+scan a raggio (prima
-- alternativa considerata): nessuna dipendenza da un raggio fisso — un'unita'
-- (in particolare un futuro ingegnere mobile) non puo' mai "uscire" dalla
-- propria appartenenza semplicemente spostandosi, evitando la stessa classe
-- di bug gia' vista in sess.79 (difese fuori dal raggio di rilevamento
-- ingegneri liberi).
--
-- Ogni unita' porta ANCHE un tag diretto (unit.OWPlusOwnerOutpost =
-- outpostKey), scritto/rimosso in sincrono con l'insieme dalle stesse
-- funzioni sotto. Risponde alla domanda opposta rispetto all'insieme ("di chi
-- e' QUESTA unita' specifica" invece di "quali unita' sono le MIE") — utile a
-- un sistema che ha gia' in mano un riferimento a un'unita' senza sapere a
-- priori quale avamposto controllare.
--
-- Scope iniziale (sess.88): SOLO strutture (difese, scudi, artiglieria,
-- SMD) — mai riassegnate, solo costruite e poi morte.
--
-- Fase G (sess.93): estesa agli ingegneri di avamposto (4 parametro 'kind',
-- vedi sotto). Motivo del parametro: l'insieme era condiviso da TUTTI i tipi
-- di unita' di un avamposto — un consumer gia' esistente (platoon.lua:1399,
-- conteggio crescita difese per tier) avrebbe silenziosamente contato un
-- ingegnere come una difesa in piu' (stesso tier, nessuna categoria
-- esclusiva a distinguerlo nel suo ramo finale). Partizionare per 'kind'
-- applica l'invariante in SCRITTURA (una volta sola, qui) invece di doverla
-- ridondare in lettura in ogni consumer presente e futuro. Default
-- 'structure' per compatibilita' totale con le chiamate esistenti (mai
-- modificate): OWPlusClaimForOutpost/OWPlusGetOwnedUnits senza 4 parametro
-- si comportano esattamente come prima.
--
-- Guardia contro il furto nativo di MAIN (EngineerManager, DeadBaseMonitor):
-- non serve per gli ingegneri di avamposto, gia' garantita da un meccanismo
-- indipendente (hook/lua/sim/EngineerManager.lua, override 'sticky' di
-- TaskFinished) — un ingegnere registrato qui resta sempre vincolato al suo
-- avamposto, mai serve OWPlusReleaseFromOutpost.
OWPlusOwnershipKindStructure = 'structure'
OWPlusOwnershipKindEngineer = 'engineer'

-- Assegna 'unit' all'avamposto 'outpostKey' (per il tipo 'kind', default
-- 'structure'): la aggiunge all'insieme e scrive il tag diretto sull'unita'.
-- Idempotente (riassegnare la stessa unita' allo stesso avamposto/kind non
-- fa danno — sovrascrive con lo stesso valore).
function OWPlusClaimForOutpost(aiBrain, outpostKey, unit, kind)
    if not unit or unit.Dead then
        return
    end
    kind = kind or OWPlusOwnershipKindStructure
    aiBrain.OWPlusOutpostOwnedUnits = aiBrain.OWPlusOutpostOwnedUnits or {}
    aiBrain.OWPlusOutpostOwnedUnits[outpostKey] = aiBrain.OWPlusOutpostOwnedUnits[outpostKey] or {}
    aiBrain.OWPlusOutpostOwnedUnits[outpostKey][kind] = aiBrain.OWPlusOutpostOwnedUnits[outpostKey][kind] or {}
    aiBrain.OWPlusOutpostOwnedUnits[outpostKey][kind][unit] = true
    unit.OWPlusOwnerOutpost = outpostKey
end

-- Rimuove 'unit' dall'appartenenza (insieme + tag) SENZA che sia morta — da
-- usare per una futura riassegnazione esplicita (es. un ingegnere che passa
-- di mano). La morte non richiede questa chiamata: si autopulisce durante
-- l'iterazione, vedi OWPlusGetOwnedUnits sotto. Non ancora usata in nessuna
-- fase (ne' strutture ne' ingegneri sono mai riassegnati oggi), presente per
-- la stessa ragione di genericita' discussa con l'utente in sess.88.
function OWPlusReleaseFromOutpost(aiBrain, outpostKey, unit, kind)
    kind = kind or OWPlusOwnershipKindStructure
    local owned = aiBrain.OWPlusOutpostOwnedUnits and aiBrain.OWPlusOutpostOwnedUnits[outpostKey]
        and aiBrain.OWPlusOutpostOwnedUnits[outpostKey][kind]
    if owned then
        owned[unit] = nil
    end
    if unit and unit.OWPlusOwnerOutpost == outpostKey then
        unit.OWPlusOwnerOutpost = nil
    end
end

-- Ritorna l'insieme (tabella chiave=unita', valore=true) delle unita' vive di
-- un avamposto per il tipo 'kind' (default 'structure'), ripulendo al volo
-- quelle morte incontrate durante l'iterazione (lazy delete — piu' semplice
-- di un thread di pulizia dedicato, costo trascurabile dato il numero di
-- unita' in gioco per avamposto). Il chiamante itera con
-- 'for unit, _ in OWPlusGetOwnedUnits(...) do'.
function OWPlusGetOwnedUnits(aiBrain, outpostKey, kind)
    kind = kind or OWPlusOwnershipKindStructure
    local owned = aiBrain.OWPlusOutpostOwnedUnits and aiBrain.OWPlusOutpostOwnedUnits[outpostKey]
        and aiBrain.OWPlusOutpostOwnedUnits[outpostKey][kind]
    if not owned then
        return {}
    end
    for unit, _ in owned do
        if unit.Dead then
            owned[unit] = nil
        end
    end
    return owned
end

-- Fase H (sess.93): unico scan geometrico condiviso rimasto in tutto il
-- sistema avamposto. Serve SOLO a OWPlusCaptureBuiltStructure (platoon.lua)
-- per risolvere l'handle di un'unita' APPENA costruita, non ancora in questa
-- mappa (IssueBuildMobile/AIExecuteBuildStructure non ritornano un handle
-- diretto) — nessuna alternativa possibile, non e' un conteggio. Tutti gli
-- altri scan del sistema avamposto (upgrade difese, gate ingegneri, tetto
-- produzione) sono stati migrati a OWPlusGetOwnedUnits in questa stessa
-- fase, proprio per non avere piu' copie duplicate di
-- aiBrain:GetUnitsAroundPoint sparse nel codice.
function OWPlusScanUnitsAroundPoint(aiBrain, category, pos, radius)
    return aiBrain:GetUnitsAroundPoint(category, pos, radius, 'Ally') or {}
end
