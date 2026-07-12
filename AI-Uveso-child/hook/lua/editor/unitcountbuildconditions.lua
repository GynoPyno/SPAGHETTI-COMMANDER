-- AI-Uveso-child: hook unitcountbuildconditions.lua
-- Fase 9-F28 (fix B12): UnitsLessInPlatoon (stock Uveso) chiama Platoon:GetPlan()
-- su ogni elemento di aiBrain:GetPlatoonsList() senza controllare se quel
-- metodo esiste davvero. Confermato in sess.66 (dev.log ricorrente):
--   attempt to call method 'GetPlan' (a nil value)
-- Alcuni elementi della lista a volte non hanno il metodo GetPlan (motivo non
-- chiarito — probabile residuo di merge/disband di un plotone), e il crash
-- interrompe la valutazione della condizione. Sospettato come causa (insieme a
-- PlatoonMerger, vedi platoon.lua) dell'esercito pieno di unita' che non
-- lancia mai un attacco su vasta scala.
--
-- Fix: aggiunta guardia difensiva "Platoon and Platoon.GetPlan and" prima di
-- chiamare :GetPlan() — se l'elemento non ha il metodo, viene semplicemente
-- saltato invece di far crashare l'intera valutazione. Nessun'altra logica
-- modificata rispetto all'originale.

--            { UCBC, 'UnitsLessInPlatoon', {} },
function UnitsLessInPlatoon(aiBrain, PlatoonPlan, num, cat)
    local SearchCat = cat or categories.ALLUNITS
    local PlatoonList = aiBrain:GetPlatoonsList()
    local NumPlatoonUnits = 0
    local PlatoonFound
    for Li, Platoon in PlatoonList do
        if Platoon and Platoon.GetPlan and Platoon:GetPlan() == PlatoonPlan then
            PlatoonFound = true
            for Ui, Unit in Platoon:GetPlatoonUnits() or {} do
                if EntityCategoryContains(cat, Unit) then
                    NumPlatoonUnits = NumPlatoonUnits + 1
                end
            end
            break
        end
    end
    if not PlatoonFound then
        -- in case the platoon is not formed yet, just return false.
        -- so the platoonformer does not try to add the unit to an non existing platoon
        return false
    end
    if NumPlatoonUnits < num then
        return true
    end
    return false
end

-- sess.76 (B16): nuova condizione. BuildNotOnLocation (stock AI-Uveso, hook di
-- questo stesso file) fa string.find sul LocationType REALE del builder contro
-- una stringa statica passata come secondo parametro. Tutti i BuilderConditions
-- 'NotOutpost' aggiunti finora (OWPlus Engineer Builders.lua fin dalla Fase A,
-- + i 9 override stock di sess.75) usavano { 'LocationType', 'OUT' } assumendo
-- che gli avamposti avessero LocationType letteralmente 'OUT#'. Confermato falso
-- in dev.log: AddFactoryToClosestManager assegna un LocationType generato a
-- runtime tipo "Expansion Area U3"/"U4"/"U5", mai contenente la sottostringa
-- 'OUT' — quindi BuildNotOnLocation restituiva sempre true (nessuna esclusione
-- mai avvenuta) su OGNI builder in cui era stato usato, dalla Fase A in poi.
-- Un confronto testuale statico non puo' funzionare perche' ogni avamposto ha
-- una stringa diversa e nota solo a runtime: serve un controllo di
-- appartenenza all'insieme aiBrain.OWPlusOutpostLocationTypes (popolato in
-- platoon.lua quando l'avamposto viene registrato, stesso insieme gia' usato
-- dagli hook di FactoryBuilderManager.lua/PlatoonFormManager.lua).
function OWPlusNotOutpostLocation(aiBrain, locationType)
    if aiBrain.OWPlusOutpostLocationTypes and aiBrain.OWPlusOutpostLocationTypes[locationType] then
        -- LOG una sola volta per location (non ad ogni chiamata: condizione valutata
        -- di continuo da GetHighestBuilder/ConditionsMonitor, spam altrimenti garantito).
        aiBrain.OWPlusNotOutpostLoggedOnce = aiBrain.OWPlusNotOutpostLoggedOnce or {}
        if not aiBrain.OWPlusNotOutpostLoggedOnce[locationType] then
            aiBrain.OWPlusNotOutpostLoggedOnce[locationType] = true
            LOG('[OWPlus] OWPlusNotOutpostLocation: OK, esclusione builder stock attiva su location "'
                .. tostring(locationType) .. '"')
        end
        return false
    end
    return true
end

-- sess.76 (test isolamento "esterminatus"): root cause reale del "furto"
-- osservato dall'utente anche con OGNI altro builder disattivato. 'OWPlus
-- Outpost Factory Claim' (OWPlus Outpost Factory.lua) usava 'PoolGreaterAtLocation'
-- — un conteggio grezzo di quanti ingegneri esistono nel pool di MAIN, SENZA
-- escludere quelli gia' impegnati in una rivendicazione avamposto in corso
-- (flag custom OWPlusOutpostBusy, invisibile a questa condizione stock). Con
-- InstanceCount=6 sul builder, appena l'unico ingegnere reale finiva nel pool
-- (conteggio sempre >=1, la vera identita' dell'unita' non conta), UNA
-- SECONDA istanza dello stesso builder poteva rivendicare un ALTRO avamposto
-- riusando lo STESSO ingegnere fisico — confermato in dev.log da un errore
-- esplicito del motore ("IssueTransportLoad: One or more units are already
-- attached to something") e dal fatto che l'avamposto gia' iniziato (3
-- fabbriche costruite) restava orfano e completamente fermo subito dopo.
-- La guardia difensiva 9-F34 (eng.OWPlusOutpostBusy in platoon.lua) scatta
-- troppo tardi: il PlatoonHandle nativo e' gia' stato rubato dalla SECONDA
-- rivendicazione nel momento in cui il nostro codice se ne accorge. Il fix
-- corretto e' impedire la seconda rivendicazione ancora PRIMA che scelga un
-- ingegnere: sostituire PoolGreaterAtLocation con un conteggio che esclude
-- esplicitamente le unita' gia' marcate OWPlusOutpostBusy.
function OWPlusHasFreeEngineerAtLocation(aiBrain, locationType, category)
    local mgr = aiBrain.BuilderManagers[locationType]
    if not mgr or not mgr.Position then
        return false
    end
    local radius = (mgr.EngineerManager and mgr.EngineerManager.Radius) or 100
    local units = aiBrain:GetUnitsAroundPoint(category, mgr.Position, radius, 'Ally') or {}
    for _, u in units do
        if not u.Dead and not u.OWPlusOutpostBusy and u:IsIdleState() then
            return true
        end
    end
    return false
end
