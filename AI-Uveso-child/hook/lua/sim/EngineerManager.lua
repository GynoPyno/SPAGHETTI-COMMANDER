-- AI-Uveso-child: hook EngineerManager.lua
-- sess.76: risponde a una domanda diretta dell'utente ("non è che MAIN ha un
-- raggio di controllo infinito e ripesca gli ingegneri di tutta la mappa?").
-- Risposta: non è il raggio di MAIN in se' (gia' piu' piccolo della distanza
-- dei nostri avamposti, dai 190 alle 400+ unita' osservate in log — scatta
-- gia' oggi) — e' il meccanismo NATIVO di Uveso che, ogni volta che un
-- ingegnere finisce un ordine di costruzione, chiama EngineerManager:
-- TaskFinished(unit): se l'unita' e' piu' lontana di self.Radius dal centro
-- del manager attuale, la riassegna (ReassignUnit) al BuilderManager PIU'
-- VICINO tra TUTTI quelli registrati — indipendentemente da quali BuilderGroup
-- sono agganciati a quel manager (quindi indipendente anche dal filtro
-- AddGlobalBaseTemplate di poco fa). Se invece resta vicino abbastanza, scatta
-- AssignEngineerTask, che crea un plotone NUOVO per l'unita' e le assegna un
-- compito in base al builder con priorita' piu' alta in quel momento —
-- scavalcando qualsiasi cosa stesse facendo prima (compresa la nostra ricetta
-- avamposto). Meccanismo indipendente dai diagnostici PlatoonHandle di
-- sess.75 (che coprono solo l'ingegnere durante la rivendicazione iniziale),
-- e soprattutto indipendente da qualsiasi BuilderGroup — colpisce anche gli
-- ingegneri T1/T2/T3 gia' dedicati e prodotti dalla fabbrica dell'avamposto.
--
-- Fix: due guardie, entrambe minime (early-return, nessuna logica vanilla
-- toccata quando non si applicano).
-- 1) Ingegnere ancora in fase di rivendicazione/ricetta iniziale (flag
--    esistente unit.OWPlusOutpostBusy, sess.67/9-F34) — mai riassegnato ne'
--    ritasked finche' il flag resta attivo.
-- 2) Ingegnere gia' tracciato stabilmente da un manager riconosciuto come
--    avamposto (aiBrain.OWPlusOutpostLocationTypes[self.LocationType]) — mai
--    riassegnato altrove per motivi di distanza: un ingegnere dell'avamposto
--    resta dell'avamposto, punto, indipendentemente da quanto si allontana
--    per costruire una struttura ai bordi del perimetro.

local prevClass = EngineerManager
EngineerManager = Class(prevClass) {

    TaskFinished = function(self, unit)
        if unit.OWPlusOutpostBusy then
            if not unit.OWPlusEngGuardLoggedBusy then
                unit.OWPlusEngGuardLoggedBusy = true
                LOG('[OWPlus] EngineerManager:TaskFinished: OK, ingegnere (' .. tostring(unit.UnitId)
                    .. ') protetto da OWPlusOutpostBusy — riassegnazione/nuovo compito nativo bloccato')
            end
            return
        end
        if self.Brain.OWPlusOutpostLocationTypes and self.Brain.OWPlusOutpostLocationTypes[self.LocationType] then
            if not unit.OWPlusEngGuardLoggedSticky then
                unit.OWPlusEngGuardLoggedSticky = true
                LOG('[OWPlus] EngineerManager:TaskFinished: OK, ingegnere (' .. tostring(unit.UnitId)
                    .. ') dell\'avamposto "' .. tostring(self.LocationType) .. '" tenuto sticky — nessun ReassignUnit per distanza')
            end
            -- Sticky: mai ReassignUnit per allontanamento — resta sempre gestito
            -- da questo stesso manager-avamposto, che assegnera' solo tra i
            -- builder dedicati OWPlus (whitelist AddGlobalBaseTemplate).
            prevClass.AssignEngineerTask(self, unit)
            return
        end
        prevClass.TaskFinished(self, unit)
    end,

    AssignEngineerTask = function(self, unit)
        if unit.OWPlusOutpostBusy then
            return
        end
        prevClass.AssignEngineerTask(self, unit)
    end,
}
