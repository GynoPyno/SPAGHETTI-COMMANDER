-- AI-Uveso-child: hook AIAddBuilderTable.lua
-- sess.76: intercetta l'UNICO punto in cui Uveso collega in blocco tutti i
-- gruppi builder del template scelto per un nuovo manager (AddGlobalBaseTemplate,
-- chiamata da AddFactoryToClosestManager in aiarchetype-managerloader.lua subito
-- dopo aver scelto 'UvesoExpansionArea' per un nuovo avamposto — vedi
-- Flusso_Avamposti_B16.md punto 6). Senza questo hook, ogni avamposto riceveva
-- l'intero set di ~40 builder stock di Uveso (ingegneri, energia, unita' da
-- combattimento, formers che le portano via, sperimentali, scudi...) in
-- parallelo ai nostri builder dedicati, causando una competizione costante e
-- comportamento incoerente da un avamposto all'altro (root cause identificata
-- in sess.76 dopo i fix parziali di sess.75 su 9 gruppi stock + Engineer
-- Builders — quei fix restano corretti/utili come difesa in profondita', ma
-- coprivano solo una piccola parte dei gruppi realmente attaccati).
--
-- Scelta esplicita dell'utente (sess.76): avamposto "pulito" a zero builder
-- stock — nessuna lista bianca iniziale. I builder dedicati (OWPlus Outpost
-- Engineer Builders / Factory Upgrade) restano agganciati come sempre, tramite
-- la chiamata DIRETTA a AddGlobalBuilderGroup gia' presente in platoon.lua
-- (funzione non toccata da questo hook — quel percorso resta sempre attivo).
-- Se in futuro servira' un builder stock specifico ad hoc, si aggiungera' qui
-- in una whitelist esplicita, non riattivando l'intero template.
--
-- Riconoscimento avamposto: il flag aiBrain.OWPlusOutpostLocationTypes non e'
-- ancora popolato quando questa funzione gira (si popola dopo, in modo
-- asincrono, in platoon.lua) — il riconoscimento usa quindi la POSIZIONE del
-- manager appena creato (aiBrain.BuilderManagers[locationType].Position, gia'
-- valorizzata da AddBuilderManagers poco prima) contro gli slot OUT# noti fin
-- dall'inizio partita (aiBrain.OWPlusSubBases).
--
-- Nota: alcuni mod di terze parti (es. NuclearRepulsorShields) hookano lo
-- stesso file iniettando un proprio BuilderGroup PRIMA di richiamare la
-- funzione originale — se il loro hook viene eseguito prima del nostro nella
-- catena concatenata, quella singola iniezione sfugge al filtro. Non e' il
-- problema che questo fix affronta (la competizione con l'AI stock di Uveso),
-- resta un residuo minore accettato.

local OldAddGlobalBaseTemplate = AddGlobalBaseTemplate

local function OWPlusIsOutpostManagerPosition(aiBrain, locationType)
    local mgr = aiBrain.BuilderManagers[locationType]
    if not mgr or not mgr.Position or not aiBrain.OWPlusSubBases then
        return false
    end
    local px, pz = mgr.Position[1], mgr.Position[3]
    for slotKey, slotPos in aiBrain.OWPlusSubBases do
        if string.sub(slotKey, 1, 3) == 'OUT' and slotPos then
            local dx = px - slotPos[1]
            local dz = pz - slotPos[3]
            if (dx * dx + dz * dz) < (25 * 25) then
                return true
            end
        end
    end
    return false
end

-- sess.76-bis: modalita' TEST ISOLAMENTO ("exterminatus"), richiesta esplicita
-- dall'utente per verificare in modo definitivo se l'intera pipeline
-- avamposti (claim -> trasporto -> ricetta -> adozione) funziona in modo
-- pulito quando NESSUN altro builder — nemmeno a MAIN — puo' competere. Se
-- funziona qui, il problema residuo osservato in game e' di sicuro priorita'/
-- competizione, non un bug nella logica della pipeline stessa.
--
-- MAIN riceve il proprio template ('overwhelmplus') tramite la STESSA
-- funzione AddGlobalBaseTemplate (vedi vanilla aiarchetype-managerloader.lua
-- riga 99: AddGlobalBaseTemplate(aiBrain, 'MAIN', base)) — quindi lo stesso
-- punto di intercettazione gia' usato per gli avamposti copre anche MAIN,
-- senza dover editare a mano l'elenco Builders di
-- 'Uveso MainBase OverwhelmPlus.lua'. Quando attiva, MAIN riceve SOLO i
-- gruppi elencati nella whitelist sotto — tutto il resto della nostra stessa
-- AI (produzione militare, economia estesa, upgrade CDR...) resta
-- disattivato per la durata del test, per scelta esplicita dell'utente.
--
-- USO: spawnare a mano (debug/cheat) un trasporto + un ingegnere T1 vicino a
-- MAIN — con la sola 'OWPlus Outpost Factory' attiva, il builder claim
-- dovrebbe notare l'ingegnere libero e avviare la rivendicazione di un
-- avamposto autonomamente. Nota: la condizione 'GreaterThanEconStorageRatio'
-- del builder claim richiede comunque storage mass>=10%/energy>=20% — se il
-- test non parte, dare risorse a mano (cheat) prima di controllare altro.
--
-- RICORDARSI di rimettere OWPlusExterminatusMode a false a test concluso —
-- con true, MAIN non produce ne' economia ne' difese ne' unita' di alcun tipo.
local OWPlusExterminatusMode = true
local OWPlusExterminatusMainWhitelist = {
    ['OWPlus Outpost Factory'] = true,  -- claim + logistica trasporto propria verso l'avamposto
}

function AddGlobalBaseTemplate(aiBrain, locationType, baseBuilderName)
    if OWPlusIsOutpostManagerPosition(aiBrain, locationType) then
        LOG('[OWPlus] AddGlobalBaseTemplate: OK, "' .. tostring(locationType) .. '" riconosciuto come avamposto - template stock "'
            .. tostring(baseBuilderName) .. '" SALTATO (nessun builder stock, solo i nostri dedicati)')
        if BaseBuilderTemplates[baseBuilderName] then
            aiBrain.BuilderManagers[locationType].BaseSettings = BaseBuilderTemplates[baseBuilderName].BaseSettings
        end
        return
    end

    if OWPlusExterminatusMode and locationType == 'MAIN' then
        LOG('[OWPlus] AddGlobalBaseTemplate: OK, modalita\' ESTERMINATUS attiva su MAIN - solo whitelist isolamento avamposti, tutto il resto disattivato')
        if BaseBuilderTemplates[baseBuilderName] then
            for _, groupName in BaseBuilderTemplates[baseBuilderName].Builders do
                if OWPlusExterminatusMainWhitelist[groupName] then
                    AddGlobalBuilderGroup(aiBrain, locationType, groupName)
                    LOG('[OWPlus] AddGlobalBaseTemplate: OK, gruppo whitelisted agganciato a MAIN: "' .. tostring(groupName) .. '"')
                end
            end
            aiBrain.BuilderManagers[locationType].BaseSettings = BaseBuilderTemplates[baseBuilderName].BaseSettings
        end
        return
    end

    OldAddGlobalBaseTemplate(aiBrain, locationType, baseBuilderName)
end
