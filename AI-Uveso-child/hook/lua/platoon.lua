-- AI-Uveso-child: hook platoon.lua
-- OWPlusDispersedBuildAI: PlatoonAI custom per costruire nelle sub-location BASE_NE/SE/SW/NW.
--
-- PROBLEMA: EngineerBuildAI (branch else) passa reference=true (booleano) ad AIExecuteBuildStructure.
-- Uveso's AIExecuteBuildStructure usa closeToBuilder → posizione dell'ingegnere (= MAIN).
-- Construction.LocationType nel builder non viene mai letto in questo path.
--
-- SOLUZIONE: questo PlatoonAI legge cons.LocationType, trova le coordinate in
-- aiBrain.OWPlusSubBases[locType] (tabella custom, immune a DeadBaseMonitor),
-- e passa targetPos come 'reference' (tabella) ad AIExecuteBuildStructure.
-- Uveso controlla per primo "reference and type(reference) == 'table'" → usa targetPos come centro.
--
-- NOTA: NON si usa aiBrain.BuilderManagers per le sub-location perché DeadBaseMonitor
-- rimuove ogni manager non-MAIN senza ingegneri/fabbriche dopo 5 secondi dalla creazione.

local AIBuildStructures = import('/lua/AI/aibuildstructures.lua')
-- Fase 9-F30: modulo nostro (non un file hookato del motore/di un'altra mod),
-- quindi nessun rischio di load-order come per aiarchetype-managerloader.lua —
-- sicuro da importare qui a livello di file.
local OWPlusTransportUtils = import('/mods/AI-Uveso-child/lua/AI/OWPlusTransportUtils.lua')
-- Fase C (B16): stesso motivo di OWPlusTransportUtils sopra — modulo nostro, puro
-- (nessuna dipendenza esterna a livello di file), sicuro da importare qui.
local OWPlusOutpostDefensePool = import('/mods/AI-Uveso-child/lua/AI/OWPlusOutpostDefensePool.lua')
-- Fase 9-F21: AddFactoryToClosestManager (usata piu' sotto, dentro il ForkThread
-- di riaggancio) e' una "globale" ma vive nell'ambiente isolato del modulo
-- aiarchetype-managerloader.lua — in questo motore ogni file import()ato ha il
-- proprio _G separato (setfenv), quindi va acceduta tramite la tabella
-- restituita da import(), non come nome nudo. Confermato bug reale in game log:
-- "access to nonexistent global variable AddFactoryToClosestManager" da
-- platoon.lua, ogni volta che 9-F19/20 tentava di chiamarla.
--
-- Fase 9-F23: l'import di questo modulo NON va fatto qui a livello di file (si
-- eseguirebbe troppo presto, mentre platoon.lua stesso si sta ancora caricando,
-- prima che il resto del bootstrap AI abbia definito le globali da cui questo
-- modulo dipende) — confermato crash reale: "access to nonexistent global
-- variable ExecutePlan" proprio dentro aiarchetype-managerloader.lua, innescato
-- da questo import a caricamento modulo. L'import va fatto in modo "lazy",
-- dentro la funzione/ForkThread che lo usa davvero: a quel punto nel match il
-- bootstrap AI normale (PriorityManagerThread ecc., forkati da questo stesso
-- file a inizio partita) ha gia' caricato ed eseguito il modulo, quindi
-- l'import() qui sotto trova la cache gia' pronta (stesso path base motore
-- usato dal resto del gioco, non il path del file di hook della mod) invece di
-- ricaricarlo da zero.

CopyOfOldPlatoonClassOWPlusChild = Platoon
Platoon = Class(CopyOfOldPlatoonClassOWPlusChild) {

    OWPlusDispersedBuildAI = function(self)
        local aiBrain = self:GetBrain()
        local cons = self.PlatoonData and self.PlatoonData.Construction
        if not cons or not cons.BuildStructures then
            WaitTicks(1)
            self:PlatoonDisband()
            return
        end

        -- Trova le coordinate della sub-location target (es. 'BASE_NE')
        local targetLocType = cons.LocationType
        local targetPos
        local buildList = cons.BuildStructures
        local buildRefs

        -- Fase 9-F18: 'OWPlusOutpostPool' e' un sentinel — non e' una location
        -- fissa, ma dice "scegli dinamicamente un avamposto (OUT#) generato da
        -- OWPlusOutpostGenerator.lua non ancora rivendicato". La ricetta di quello
        -- slot (fabbriche scelte a caso) viene anteposta alle difese gia' in
        -- cons.BuildStructures.
        if targetLocType == 'OWPlusOutpostPool' then
            aiBrain.OWPlusOutpostClaimed = aiBrain.OWPlusOutpostClaimed or {}
            local chosenKey
            if aiBrain.OWPlusSubBases then
                for slotKey, _ in aiBrain.OWPlusSubBases do
                    if string.sub(slotKey, 1, 3) == 'OUT' and not aiBrain.OWPlusOutpostClaimed[slotKey] then
                        chosenKey = slotKey
                        break
                    end
                end
            end
            if not chosenKey then
                WaitTicks(1)
                self:PlatoonDisband()
                return
            end
            aiBrain.OWPlusOutpostClaimed[chosenKey] = true
            targetLocType = chosenKey
            targetPos = aiBrain.OWPlusSubBases[chosenKey]
            local recipe = aiBrain.OWPlusOutpostRecipes and aiBrain.OWPlusOutpostRecipes[chosenKey] or {}
            buildList = {}
            buildRefs = {}
            for _, t in recipe do
                table.insert(buildList, t)
                table.insert(buildRefs, targetPos)
            end
            -- Fix sess.76 (richiesta utente): le difese NON vengono piu' aggiunte
            -- alla ricetta iniziale. Osservato in game: con fabbriche+difese nello
            -- stesso buildList, l'ingegnere restava esposto al meccanismo nativo
            -- di riassegnazione (EngineerManager:TaskFinished, vedi hook dedicato)
            -- per tutta la durata della lista lunga (12-18 strutture) — piu' tempo
            -- passa prima che la prima fabbrica sia adottata in un BuilderManager
            -- reale, piu' a lungo l'ingegnere resta vulnerabile. Ora il buildList
            -- contiene SOLO le fabbriche: l'avamposto va "online" (fabbrica
            -- adottata, builder dedicati agganciati) il piu' velocemente
            -- possibile. Le difese vengono costruite DOPO, da un thread dedicato
            -- avviato solo quando l'avamposto e' gia' online (vedi piu' sotto,
            -- vicino al log "agganciati builder dedicati") — la ricetta difese
            -- resta comunque disponibile in aiBrain.OWPlusOutpostDefenseRecipes,
            -- semplicemente non consumata qui.
            LOG('[OWPlus] Outpost: rivendicato ' .. chosenKey .. ', ' .. table.getn(buildList) .. ' fabbriche da costruire (difese rimandate a dopo)')
        elseif targetLocType then
            -- Legge da OWPlusSubBases (tabella custom sul brain, immune a DeadBaseMonitor).
            -- BuilderManagers NON viene usato: i manager vuoti vengono rimossi dopo 5s.
            targetPos = aiBrain.OWPlusSubBases and aiBrain.OWPlusSubBases[targetLocType]
        end

        if not targetPos then
            LOG('[OWPlus-WARN] OWPlusDispersedBuildAI: sub-base ' .. tostring(targetLocType) .. ' non trovata in OWPlusSubBases')
            self:EngineerBuildAI()
            return
        end

        if not buildRefs then
            buildRefs = {}
            for _ in buildList do table.insert(buildRefs, targetPos) end
        end

        -- Trova l'ingegnere
        local eng
        for _, v in self:GetPlatoonUnits() do
            if not v.Dead and EntityCategoryContains(categories.ENGINEER, v) then
                IssueClearCommands({v})
                if not eng then
                    eng = v
                else
                    IssueGuard({v}, eng)
                end
            end
        end

        if not eng or eng.Dead then
            WaitTicks(1)
            self:PlatoonDisband()
            return
        end

        -- Fase 9-F34: guardia difensiva contro il doppio-assegnamento dello
        -- stesso ingegnere a due rivendicazioni avamposto in parallelo (bug
        -- osservato in sess.67: un ingegnere che stava gia' costruendo un
        -- avamposto ad est e' stato caricato da un trasporto e portato a
        -- costruirne un altro a nord-ovest). 'OWPlus Outpost Factory Claim' ha
        -- InstanceCount=6, quindi fino a 6 rivendicazioni possono partire in
        -- parallelo — se il framework di selezione ingegneri (fuori dal nostro
        -- controllo) assegna per errore/race lo stesso ingegnere a due platoon
        -- OWPlusDispersedBuildAI, questo flag lo rileva e la SECONDA
        -- rivendicazione si ritira subito senza toccare l'ingegnere, lasciando
        -- la prima (gia' in corso) indisturbata. Il flag viene ripulito a ogni
        -- uscita della funzione (abbandono, fallimento terreno, completamento).
        if eng.OWPlusOutpostBusy then
            LOG('[OWPlus-WARN] OWPlusDispersedBuildAI: ingegnere gia\' impegnato su un altro avamposto, abbandono rivendicazione di ' .. tostring(targetLocType))
            self:PlatoonDisband()
            return
        end
        eng.OWPlusOutpostBusy = true

        -- Fase 9-F30: per gli avamposti OUT# (non per i nodi BASE_ di MAIN, gia'
        -- vicini e raramente in timeout), spostiamo l'ingegnere con la nostra
        -- logistica trasporto scritta a mano (OWPlusTransportUtils.lua) invece
        -- di affidarci a AIAttackUtils.SendPlatoonWithTransportsNoCheck.
        -- Motivazione: sess.66, quella funzione di motore rifiutava sempre di
        -- usare un trasporto — CONFERMATO con un log diagnostico che trasporti
        -- completamente liberi esistevano vicino a MAIN nel momento esatto del
        -- tentativo (nessuno stato attivo), eppure la funzione restituiva
        -- comunque "nessun trasporto disponibile", senza errori/crash e senza
        -- un motivo verificabile dal codice sorgente (compilato nel motore).
        -- Prima di questo (9-F24-27) avevamo gia' scoperto e corretto due bug
        -- nostri nella chiamata (target=nil, GetMostRestrictiveLayer mancante)
        -- che spiegavano i primi fallimenti — ma anche dopo quei fix, con
        -- trasporti confermati liberi, la funzione continuava a rifiutarsi.
        if targetLocType and string.sub(targetLocType, 1, 3) == 'OUT' then
            local mainPos = aiBrain.BuilderManagers and aiBrain.BuilderManagers['MAIN'] and aiBrain.BuilderManagers['MAIN'].Position
            local usedTransport = false
            if mainPos then
                LOG('[OWPlus] Outpost: tentativo trasporto (logistica propria) verso ' .. targetLocType)
                usedTransport = OWPlusTransportUtils.OWPlusTransportUnit(aiBrain, eng, mainPos, targetPos)
            end
            if not aiBrain:PlatoonExists(self) or eng.Dead then
                eng.OWPlusOutpostBusy = nil
                return
            end
            if usedTransport then
                LOG('[OWPlus] Outpost: trasporto usato per raggiungere ' .. targetLocType)
            else
                -- Fase 9-F33: espansione avamposti SOLO via trasporto, su richiesta
                -- esplicita dell'utente (sess.67, confermata efficace in sess.68 —
                -- fallback a piedi cancellato). Se non c'e' un trasporto libero ORA,
                -- abbandoniamo questo tentativo (verra' ritentato dal builder) invece
                -- di camminare — cosi' l'AI e' spinta a costruire piu' trasporti
                -- invece di aggirarli a piedi.
                --
                -- Fase 9-F35: throttle 10s prima di disbandare. Senza, il builder
                -- ('OWPlus Outpost Factory Claim', priorita' alta, valutato quasi
                -- ogni tick) rirendicava e riabbandonava lo stesso slot in loop
                -- istantaneo — confermato in sess.68: 527 abbandoni per 1 solo
                -- trasporto trovato libero in una partita di 4 minuti.
                LOG('[OWPlus] Outpost: nessun trasporto disponibile, tentativo abbandonato (solo-trasporto, 9-F33) per ' .. targetLocType)
                WaitSeconds(10)
                eng.OWPlusOutpostBusy = nil
                -- Rilascia lo slot (se e' un OUT# con claim registrato) cosi'
                -- 'OWPlus Outpost Factory Claim' puo' ritentarlo quando un
                -- trasporto sara' di nuovo libero, invece di perderlo per sempre.
                if targetLocType and aiBrain.OWPlusOutpostClaimed then
                    aiBrain.OWPlusOutpostClaimed[targetLocType] = nil
                end
                self:PlatoonDisband()
                return
            end
        end

        local factionLookup = { UEF = 1, AEON = 2, CYBRAN = 3, SERAPHIM = 4, NOMADS = 5 }
        local factionIndex = cons.FactionIndex or factionLookup[eng.factionCategory] or 1
        local buildingTmplFile = import(cons.BuildingTemplateFile or '/lua/BuildingTemplates.lua')
        local baseTmplFile = import(cons.BaseTemplateFile or '/lua/BaseTemplates.lua')
        local buildingTmpl = buildingTmplFile[(cons.BuildingTemplate or 'BuildingTemplates')][factionIndex]
        local baseTmpl = baseTmplFile[(cons.BaseTemplate or 'BaseTemplates')][factionIndex]
        local baseTmplAtTarget = AIBuildStructures.AIBuildBaseTemplateFromLocation(baseTmpl, targetPos)

        self.SetupEngineerCallbacks(eng)

        -- Costruisce vicino a targetPos (o a buildRefs[i] per le difese, 9-F21).
        -- closeToBuilder=nil, reference=tabella → AIExecuteBuildStructure di Uveso
        -- entra nel branch "reference and type(reference)=='table'" → relativeTo = reference.
        for i, buildType in buildList do
            if aiBrain:PlatoonExists(self) and not eng.Dead then
                -- Diagnostica (sess.75): sospetto che l'ingegnere venga "rubato" da un
                -- builder generico di Uveso ('U1 Engineer Reclaim'/'UC123 Assistees',
                -- punto critico noto — non conoscono il nostro flag OWPlusOutpostBusy,
                -- campo custom che il codice vanilla non ha motivo di rispettare) prima
                -- di finire tutta la ricetta, lasciando avamposti con solo 2-3 fabbriche
                -- + le prime 1-2 difese costruite, poi silenzio (osservato in game,
                -- sess.75). Se il PlatoonHandle non e' piu' questo plotone, qualcun
                -- altro lo ha gia' preso in carico.
                if eng.PlatoonHandle ~= self then
                    LOG('[OWPlus-DBG] OWPlusDispersedBuildAI: ingegnere (' .. tostring(eng.UnitId) .. ') NON e\' piu\' in questo plotone prima di costruire item '
                        .. i .. '/' .. table.getn(buildList) .. ' (' .. tostring(buildType) .. ') a ' .. tostring(targetLocType)
                        .. ' — PlatoonHandle attuale: ' .. tostring(eng.PlatoonHandle and (eng.PlatoonHandle.BuilderName or eng.PlatoonHandle.PlanName or 'sconosciuto') or 'nil'))
                end
                AIBuildStructures.AIExecuteBuildStructure(
                    aiBrain, eng, buildType,
                    nil,             -- closeToBuilder nil → non usa posizione eng
                    false,           -- relative false
                    buildingTmpl,
                    baseTmplAtTarget,
                    buildRefs[i],    -- reference tabella → Uveso usa come centro di ricerca
                    nil
                )
            end
        end

        -- Fase 9-F14 (RIMOSSA, sess.76): esisteva un controllo separato qui,
        -- prima del loop finale, che provava a indovinare se il posizionamento
        -- fosse fallito guardando Moving/Building per un tempo limitato (fino a
        -- 180s) — un'euristica Lua parallela e ridondante rispetto al loop
        -- finale qui sotto, che fa la STESSA cosa in modo piu' robusto (grazia
        -- piu' lunga, diagnostica anti-furto). La doppia euristica ha causato un
        -- bug reale: quando questo controllo concludeva (erroneamente) "terreno
        -- non valido" mentre l'ingegnere in realta' AVEVA gia' un ordine nativo
        -- valido in coda (la chiamata AIExecuteBuildStructure qui sopra aveva
        -- gia' trovato posto ed emesso l'ordine — PlatoonDisband() non lo
        -- cancella), l'ingegnere continuava a costruire per conto suo (HP reali
        -- in salita, confermato dall'utente: 3600/4000 su una struttura da
        -- 4000) mentre il nostro codice lo considerava gia' "libero" — varco da
        -- cui una rivendicazione successiva lo riprendeva, sembrando un furto.
        -- Ora c'e' UNA sola fonte di verita' (il loop finale sotto): si fida
        -- SOLO dello stato nativo reale, senza provare a indovinare prima. Se
        -- il posizionamento e' davvero impossibile, l'ingegnere restera'
        -- inattivo e il loop lo rilevera' comunque (dopo idleGraceSeconds),
        -- solo piu' lentamente (fino al tetto di sicurezza) — vedi 'everBuilt'
        -- piu' sotto per il meccanismo "3 fallimenti poi scarta lo slot",
        -- spostato qui per scattare solo su un fallimento vero (zero strutture
        -- mai costruite), non su un sospetto prematuro.
        --
        -- Fase 9-F32: RIMOSSA self.ProcessBuildCommand(eng, false) (era qui dalla
        -- 9-F31). Causa di root del bug "ingegnere ripreso mentre costruisce
        -- ancora", confermata leggendo /lua/platoon.lua vanilla:
        -- ProcessBuildCommand fa IssueClearCommands({eng}) e ri-emette SOLO il
        -- primo item di eng.EngineerBuildQueue, scartando gli ordini nativi per
        -- gli item 2..N gia' emessi dal ciclo AIExecuteBuildStructure qui sopra
        -- (che li mette in coda nativa direttamente via aiBrain:BuildStructure,
        -- non serve alcuna chiamata di supporto). Il completamento del primo
        -- item dovrebbe far scattare EngineerBuildDone (via SetupEngineerCallbacks)
        -- per processare l'item successivo, ma EngineerBuildDone controlla
        -- `unit.PlatoonHandle.PlanName == 'EngineerBuildAI'` — il nostro plotone
        -- ha PlanName = 'OWPlusDispersedBuildAI', quindi il callback esce subito
        -- e la catena si interrompe dopo il primo item. L'ingegnere risultava
        -- "davvero" libero a livello nativo (nessun comando in coda) pur avendo
        -- ancora 1-4 strutture pianificate nel nostro codice — altri builder
        -- (reclaim/economia) lo raccoglievano, e siccome era l'unico membro di
        -- questo plotone la riassegnazione lo disbandava, uccidendo anche
        -- questo stesso thread a meta' esecuzione (spiega perche' il LOG di
        -- chiusura sotto non compariva mai in sess.67, nemmeno per il primo
        -- avamposto avviato con 12+ minuti disponibili prima della fine del test).
        --
        -- Fix: nessuna chiamata a ProcessBuildCommand. Attendiamo lo stato
        -- nativo dell'ingegnere (che riflette davvero cosa sta facendo) invece
        -- della sua coda Lua-side, che nel nostro path non viene mai svuotata
        -- correttamente — stesso pattern di WatchForNotBuilding in platoon.lua
        -- vanilla. Resta "occupato" finche' sta costruendo o si sposta tra una
        -- struttura e l'altra, con lo stesso tetto di sicurezza di prima.
        local queueWaited = 0
        local queueMaxWait = 600
        -- Diagnostica (sess.75): questo loop controlla solo IsUnitState('Building'/
        -- 'Moving') — se l'ingegnere viene rubato da un altro builder che lo mette
        -- SUBITO al lavoro su qualcos'altro (es. reclaim), risulterebbe comunque
        -- "Building"/"Moving" e il loop continuerebbe fino al tetto di sicurezza
        -- (600s) pensando che stia ancora completando la NOSTRA ricetta — quando
        -- in realta' l'ha abbandonata da tempo. wasStolen evita di floodare il
        -- log, segnala solo il momento in cui il furto viene rilevato.
        local wasStolen = false
        -- Fix sess.76 (bug reale trovato, non il furto sospettato in sess.75):
        -- uscire dal loop al PRIMO istante non-Building/non-Moving dichiarava
        -- "completato" anche per una pausa normale tra una struttura e l'altra
        -- (camminata verso il punto successivo, breve attesa risorse) — a quel
        -- punto OWPlusOutpostBusy veniva rilasciato SUBITO, esponendo
        -- l'ingegnere al meccanismo nativo di riassegnazione (EngineerManager
        -- hook) proprio nel mezzo della ricetta. Ora serve un periodo di
        -- inattivita' CONTINUA (idleGraceSeconds) prima di dichiarare davvero
        -- concluso — una pausa breve non fa piu' uscire dal loop.
        local idleStreak = 0
        local idleGraceSeconds = 20
        local loggedIdleStart = false
        -- Fase 9-F14 (spostata qui, sess.76): traccia se ALMENO una struttura e'
        -- davvero entrata in costruzione durante questo tentativo — usato dopo
        -- il loop per il meccanismo "3 fallimenti poi scarta lo slot" (ex 9-F11/
        -- 9-F13/9-F18), ora agganciato a un fallimento vero (zero progresso)
        -- invece che al sospetto prematuro del vecchio controllo separato.
        local everBuilt = false
        while not eng.Dead and queueWaited < queueMaxWait do
            if eng:IsUnitState('Building') or eng:IsUnitState('Moving') then
                if eng:IsUnitState('Building') then
                    everBuilt = true
                end
                if loggedIdleStart then
                    loggedIdleStart = false
                    LOG('[OWPlus-DBG] OWPlusDispersedBuildAI: ingegnere (' .. tostring(eng.UnitId)
                        .. ') ripreso a costruire/muoversi dopo pausa di ' .. idleStreak .. 's a ' .. tostring(targetLocType))
                end
                idleStreak = 0
            else
                idleStreak = idleStreak + 5
                if not loggedIdleStart then
                    loggedIdleStart = true
                    LOG('[OWPlus-DBG] OWPlusDispersedBuildAI: ingegnere (' .. tostring(eng.UnitId)
                        .. ') inattivo (ne Building ne Moving) a ' .. tostring(targetLocType) .. ', grazia ' .. idleGraceSeconds .. 's prima di dichiarare concluso')
                end
                if idleStreak >= idleGraceSeconds then
                    break
                end
            end
            if eng.PlatoonHandle ~= self and not wasStolen then
                wasStolen = true
                LOG('[OWPlus-DBG] OWPlusDispersedBuildAI: ingegnere (' .. tostring(eng.UnitId) .. ') rubato da un altro plotone durante l\'attesa finale a '
                    .. tostring(targetLocType) .. ' dopo ' .. queueWaited .. 's — PlatoonHandle attuale: '
                    .. tostring(eng.PlatoonHandle and (eng.PlatoonHandle.BuilderName or eng.PlatoonHandle.PlanName or 'sconosciuto') or 'nil'))
            end
            WaitSeconds(5)
            queueWaited = queueWaited + 5
        end
        LOG('[OWPlus] OWPlusDispersedBuildAI: OK, costruzione avamposto completata (o ingegnere morto/tetto raggiunto) a ' .. tostring(targetLocType))
        -- Fase 9-F34: costruzione conclusa (o ingegnere morto/tetto raggiunto) —
        -- rilascia il flag cosi' l'ingegnere (se sopravvissuto) torna disponibile
        -- per una futura rivendicazione avamposto legittima.
        --
        -- Fix sess.76 (bug reale osservato in game: struttura in coda su
        -- posizione irraggiungibile, es. cima di una montagna raggiungibile
        -- solo in volo): l'uscita dal loop per grazia-inattivita' (idleGraceSeconds)
        -- NON significa che tutte le strutture del buildList siano state
        -- davvero completate — puo' scattare anche con una struttura ancora
        -- bloccata in coda nativa (mai raggiungibile a piedi). Senza
        -- IssueClearCommands, quell'ordine STALE restava nella coda nativa
        -- dell'ingegnere: appena veniva rimesso al lavoro da un altro sistema
        -- (es. il watcher "compito locale di default" qui sotto, che lo trova
        -- libero e gli assegna assist fabbrica), l'ingegnere oscillava
        -- all'infinito tra il nuovo ordine e la ripresa dell'ordine irraggiungibile
        -- rimasto in coda — osservato dal vivo in game (sess.76). Ripulire la
        -- coda qui garantisce che chiunque riprenda l'ingegnere parta da zero.
        if not eng.Dead then
            IssueClearCommands({eng})
            eng.OWPlusOutpostBusy = nil
        end

        -- Fase 9-F11/13/18 (spostato da 9-F14, sess.76): "3 fallimenti poi
        -- scarta lo slot" — ora scatta SOLO se questo tentativo non ha mai
        -- costruito nulla (everBuilt=false), non piu' su un sospetto prematuro.
        -- Stesso meccanismo di prima: dopo 3 fallimenti veri consecutivi sullo
        -- stesso slot, lo liberiamo (o rifiutiamo per sempre il marker, per gli
        -- slot FWD che ne hanno uno) invece di ritentarlo all'infinito.
        if not everBuilt and targetLocType and (string.sub(targetLocType, 1, 3) == 'FWD' or string.sub(targetLocType, 1, 5) == 'BASE_' or string.sub(targetLocType, 1, 3) == 'OUT') then
            local ownerName = (ArmyBrains[aiBrain:GetArmyIndex()] and ArmyBrains[aiBrain:GetArmyIndex()].Nickname) or tostring(aiBrain:GetArmyIndex())
            aiBrain.OWPlusForwardFailCount = aiBrain.OWPlusForwardFailCount or {}
            aiBrain.OWPlusForwardFailCount[targetLocType] = (aiBrain.OWPlusForwardFailCount[targetLocType] or 0) + 1
            LOG('[OWPlus] OWPlusDispersedBuildAI (' .. ownerName .. '): ' .. targetLocType .. ' fallimento vero (zero strutture costruite) #'
                .. aiBrain.OWPlusForwardFailCount[targetLocType] .. '/3')
            if aiBrain.OWPlusForwardFailCount[targetLocType] >= 3 then
                if string.sub(targetLocType, 1, 3) == 'FWD' then
                    local markerKey = math.floor(targetPos[1]) .. '_' .. math.floor(targetPos[3])
                    aiBrain.OWPlusForwardBaseMarkers = aiBrain.OWPlusForwardBaseMarkers or {}
                    aiBrain.OWPlusForwardBaseMarkers[markerKey] = 'REJECTED'
                    LOG('[OWPlus] OWPlusDispersedBuildAI (' .. ownerName .. '): ' .. targetLocType .. ' liberato dopo 3 fallimenti, marker ('
                        .. markerKey .. ') rifiutato per sempre')
                else
                    LOG('[OWPlus] OWPlusDispersedBuildAI (' .. ownerName .. '): ' .. targetLocType .. ' disabilitato dopo 3 fallimenti (nessun fallback disponibile)')
                end
                aiBrain.OWPlusSubBases[targetLocType] = nil
                aiBrain.OWPlusForwardFailCount[targetLocType] = nil
            end
        elseif everBuilt and targetLocType and aiBrain.OWPlusForwardFailCount then
            -- Reset del contatore: un tentativo che ha davvero costruito qualcosa
            -- azzera i fallimenti precedenti, non serve piu' scartare lo slot.
            aiBrain.OWPlusForwardFailCount[targetLocType] = nil
        end

        -- Fase 9-F17 (diagnostica): a quale BuilderManager finisce per appartenere
        -- la fabbrica costruita qui? Se e' 'MAIN', significa che segue le regole
        -- di produzione di MAIN (solo ingegneri, 9-F4) invece della lista Builders
        -- del template Uveso Forward Base OverwhelmPlus.lua (mai attaccata per FWD*
        -- per lo stesso motivo per cui fabbrica/difese richiedevano un workaround).
        if targetLocType and (string.sub(targetLocType, 1, 3) == 'FWD' or string.sub(targetLocType, 1, 5) == 'BASE_') then
            ForkThread(function()
                WaitSeconds(60)
                local nearby = aiBrain:GetUnitsAroundPoint(categories.STRUCTURE * categories.FACTORY * categories.LAND, targetPos, 15, 'Ally')
                for _, u in nearby or {} do
                    if not u.Dead and u.BuilderManagerData and u.BuilderManagerData.FactoryBuildManager then
                        LOG('[OWPlus] Diagnostica manager: fabbrica ' .. tostring(u.UnitId) .. ' a ' .. tostring(targetLocType)
                            .. ' appartiene al manager "' .. tostring(u.BuilderManagerData.FactoryBuildManager.LocationType) .. '"')
                    elseif not u.Dead then
                        LOG('[OWPlus] Diagnostica manager: fabbrica ' .. tostring(u.UnitId) .. ' a ' .. tostring(targetLocType)
                            .. ' SENZA BuilderManagerData (orfana)')
                    end
                end
            end)
        end

        -- Fase 9-F19 (corretta in 9-F20): per gli avamposti OUT#, cattura il
        -- riferimento alla PRIMA fabbrica costruita e la ri-registra in un
        -- BuilderManager dedicato tramite AddFactoryToClosestManager. Scoperta
        -- (9-F20): la fabbrica NON resta orfana — viene assegnata automaticamente
        -- al manager di MAIN (confermato dal diagnostico 9-F17 sui nodi BASE_,
        -- che trova sempre 'appartiene al manager "MAIN"'). Il check originale
        -- 'not u.BuilderManagerData' quindi non scattava mai: bisogna PRIMA
        -- staccare esplicitamente la fabbrica dal manager attuale (rimuoverla dal
        -- FactoryList di MAIN), stesso pattern che Uveso stesso usa per le
        -- fabbriche navali mal assegnate in LocationRangeManagerThread
        -- (aiarchetype-managerloader.lua), POI chiamare AddFactoryToClosestManager
        -- perche' la trovi realmente senza manager.
        if targetLocType and string.sub(targetLocType, 1, 3) == 'OUT'
            and not (aiBrain.OWPlusOutpostFactories and aiBrain.OWPlusOutpostFactories[targetLocType]) then
            local outpostKey = targetLocType
            local outpostPos = targetPos
            ForkThread(function()
                -- Fase 9-F23: import lazy, path base motore (non il path del file
                -- di hook della mod) — vedi nota in testa al file per il motivo.
                local OWPlusManagerLoader = import('/lua/ai/aiarchetype-managerloader.lua')
                local waitedBuild = 0
                while eng and not eng.Dead and eng:IsUnitState('Building') and waitedBuild < 300 do
                    WaitSeconds(5)
                    waitedBuild = waitedBuild + 5
                end
                WaitSeconds(2)
                local nearby = aiBrain:GetUnitsAroundPoint(categories.STRUCTURE * categories.FACTORY, targetPos, 15, 'Ally')
                for _, u in nearby or {} do
                    if not u.Dead then
                        aiBrain.OWPlusOutpostFactories = aiBrain.OWPlusOutpostFactories or {}
                        aiBrain.OWPlusOutpostFactories[targetLocType] = u
                        if u.BuilderManagerData and u.BuilderManagerData.FactoryBuildManager then
                            local oldLocType = u.BuilderManagerData.FactoryBuildManager.LocationType
                            for k, v in u.BuilderManagerData.FactoryBuildManager.FactoryList do
                                if v == u then
                                    u.BuilderManagerData.FactoryBuildManager.FactoryList[k] = nil
                                end
                            end
                            -- Fix sess.77 (quater, applicato per coerenza/sicurezza anche qui):
                            -- rimuovere dalla FactoryList del vecchio manager non basta —
                            -- SetupFactoryCallbacks (vanilla) registra i trigger di completamento
                            -- costruzione SOLO se BuilderManagerData e' nil in quel momento. Senza
                            -- azzerarlo, quei trigger potrebbero restare legati al vecchio manager.
                            u.BuilderManagerData = nil
                            LOG('[OWPlus] Outpost: fabbrica (' .. tostring(u.UnitId) .. ') a ' .. targetLocType
                                .. ' staccata dal manager "' .. tostring(oldLocType) .. '"')
                        end
                        OWPlusManagerLoader.AddFactoryToClosestManager(aiBrain, u)
                        LOG('[OWPlus] Outpost: prima fabbrica (' .. tostring(u.UnitId) .. ') a ' .. targetLocType
                            .. ' registrata in un BuilderManager reale')

                        -- Fase A (B16): segna il LocationType REALE (non targetLocType/'OUT#')
                        -- come avamposto riconosciuto. u.BuilderManagerData.FactoryBuildManager.
                        -- LocationType NON e' affidabile qui: FactoryBuilderManager.lua vanilla
                        -- (SetupFactoryCallbacks) fa "if not v.BuilderManagerData then" prima di
                        -- riassegnarlo — essendo gia' non-nil dal precedente aggancio a MAIN,
                        -- resta stantio anche dopo AddFactoryToClosestManager. L'unica fonte di
                        -- verita' e' l'appartenenza reale a FactoryList del nuovo manager
                        -- (table.insert incondizionato dentro AddFactory, non soggetto al guard).
                        local realLocType
                        for locKey, mgr in aiBrain.BuilderManagers do
                            if mgr.FactoryManager and mgr.FactoryManager.FactoryList then
                                for _, factoryUnit in mgr.FactoryManager.FactoryList do
                                    if factoryUnit == u then
                                        realLocType = locKey
                                        break
                                    end
                                end
                            end
                            if realLocType then break end
                        end

                        if realLocType then
                            aiBrain.OWPlusOutpostLocationTypes = aiBrain.OWPlusOutpostLocationTypes or {}
                            aiBrain.OWPlusOutpostLocationTypes[realLocType] = true
                            -- Fix orfano fabbrica (sess.72): serve la chiave reale anche fuori da
                            -- questo ForkThread (dal watcher di recupero orfani piu' sotto), che
                            -- e' un ForkThread SIBLING separato e non vede 'realLocType' (locale a
                            -- questo blocco). Salvata per-outpost cosi' resta leggibile ovunque.
                            aiBrain.OWPlusOutpostRealLocType = aiBrain.OWPlusOutpostRealLocType or {}
                            aiBrain.OWPlusOutpostRealLocType[targetLocType] = realLocType
                            LOG('[OWPlus] Outpost: ' .. targetLocType .. ' registrato in OWPlusOutpostLocationTypes con chiave reale "' .. realLocType .. '"')

                            -- Fase A/B/C fix (sess.71): AddFactoryToClosestManager crea il
                            -- nuovo manager con il template stock 'UvesoExpansionArea'
                            -- (AddGlobalBaseTemplate, aiarchetype-managerloader.lua),
                            -- NON col nostro 'overwhelmplus' — la sua lista Builders non
                            -- include quindi nessuno dei builder OWPlus Outpost dedicati.
                            -- Confermato in dev.log (sess.71): 'OWPlus Outpost Engineer
                            -- Builders'/'OWPlus Outpost Factory Upgrade' mai valutati per
                            -- nessun avamposto reale. Fix: aggancio mirato dei soli 2
                            -- BuilderGroup dedicati a QUESTO manager (non l'intero template
                            -- overwhelmplus, per non esporre gli avamposti anche ai builder
                            -- generici di MAIN non ancora verificati come sicuri).
                            local OWPlusAddBuilderTable = import('/lua/ai/AIAddBuilderTable.lua')
                            OWPlusAddBuilderTable.AddGlobalBuilderGroup(aiBrain, realLocType, 'OWPlus Outpost Engineer Builders')
                            OWPlusAddBuilderTable.AddGlobalBuilderGroup(aiBrain, realLocType, 'OWPlus Outpost Factory Upgrade')
                            LOG('[OWPlus] Outpost: ' .. targetLocType .. ' — agganciati builder dedicati (Engineer/FactoryUpgrade) al manager "' .. realLocType .. '"')

                            -- Fase 2 difese (sess.76, richiesta utente): l'avamposto e' ora
                            -- online (fabbrica adottata, builder dedicati agganciati) — solo
                            -- ORA costruiamo le difese, usando la ricetta gia' generata da
                            -- OWPlusOutpostGenerator.lua (mai consumata nella ricetta
                            -- iniziale, che ora contiene solo fabbriche). Un ingegnere libero
                            -- alla volta (lo stesso ingegnere del claim se ancora presente e
                            -- libero, oppure un ingegnere dedicato prodotto nel frattempo)
                            -- costruisce una difesa, aspetta il completamento, poi passa alla
                            -- successiva — stesso principio di offset casuale gia' usato per
                            -- le fabbriche (9-F21).
                            ForkThread(function()
                                local defenseRecipe = aiBrain.OWPlusOutpostDefenseRecipes and aiBrain.OWPlusOutpostDefenseRecipes[outpostKey]
                                if not defenseRecipe then
                                    return
                                end
                                local defenseList = {}
                                for _, t in defenseRecipe.ground do table.insert(defenseList, t) end
                                for _, t in defenseRecipe.aa do table.insert(defenseList, t) end
                                LOG('[OWPlus] Outpost (' .. outpostKey .. '): OK, avvio fase difese (' .. table.getn(defenseList) .. ' strutture)')
                                for _, defType in defenseList do
                                    local freeEng
                                    local waited = 0
                                    while not freeEng and waited < 180 do
                                        local nearbyEngs = aiBrain:GetUnitsAroundPoint(
                                            categories.MOBILE * categories.ENGINEER, outpostPos, 30, 'Ally') or {}
                                        for _, e in nearbyEngs do
                                            if not e.Dead and not e.OWPlusOutpostBusy and e:IsIdleState() then
                                                freeEng = e
                                                break
                                            end
                                        end
                                        if not freeEng then
                                            WaitSeconds(5)
                                            waited = waited + 5
                                        end
                                    end
                                    if freeEng and not freeEng.Dead then
                                        freeEng.OWPlusOutpostBusy = true
                                        local defAngle = math.rad(Random(0, 359))
                                        local defDist = Random(20, 40)
                                        local defensePos = { outpostPos[1] + math.cos(defAngle) * defDist, outpostPos[2], outpostPos[3] + math.sin(defAngle) * defDist }
                                        -- Fix sess.76 (crash reale trovato in game: "attempt to loop
                                        -- over local 'buildingTemplate' (a nil value)"): a differenza
                                        -- della ricetta iniziale (OWPlusDispersedBuildAI, che risolve
                                        -- sempre buildingTmpl/baseTmplAtTarget), qui passavamo nil per
                                        -- entrambi. Funziona quando il c-engine DecideWhatToBuild()
                                        -- risolve da solo il tipo — ma per unita' non vanilla (es. pool
                                        -- difese TotalMayhem, vedi OWPlusOutpostDefensePool.lua)
                                        -- DecideWhatToBuild() fallisce e il fallback manuale DENTRO
                                        -- AIExecuteBuildStructure itera "buildingTemplate" — crash se nil.
                                        local factionLookup = { UEF = 1, AEON = 2, CYBRAN = 3, SERAPHIM = 4, NOMADS = 5 }
                                        local defFactionIndex = factionLookup[freeEng.factionCategory] or 1
                                        local defBuildingTmpl = import('/lua/BuildingTemplates.lua')['BuildingTemplates'][defFactionIndex]
                                        local defBaseTmpl = import('/lua/BaseTemplates.lua')['BaseTemplates'][defFactionIndex]
                                        local defBaseTmplAtTarget = AIBuildStructures.AIBuildBaseTemplateFromLocation(defBaseTmpl, defensePos)
                                        AIBuildStructures.AIExecuteBuildStructure(
                                            aiBrain, freeEng, defType, nil, false, defBuildingTmpl, defBaseTmplAtTarget, defensePos, nil)
                                        local buildWaited = 0
                                        while not freeEng.Dead and (freeEng:IsUnitState('Building') or freeEng:IsUnitState('Moving')) and buildWaited < 180 do
                                            WaitSeconds(5)
                                            buildWaited = buildWaited + 5
                                        end
                                        if not freeEng.Dead then
                                            freeEng.OWPlusOutpostBusy = nil
                                        end
                                    else
                                        LOG('[OWPlus-WARN] Outpost (' .. outpostKey .. '): nessun ingegnere libero per la difesa "' .. tostring(defType) .. '", salto')
                                    end
                                end
                                LOG('[OWPlus] Outpost (' .. outpostKey .. '): OK, fase difese completata')
                            end)

                            -- Fix (sess.73): confermato via hook diagnostico (AssignBuildOrder,
                            -- FactoryBuilderManager.lua / ManagerLoopBody, PlatoonFormManager.lua)
                            -- che: 1) la fabbrica chiede "cosa costruisco?" SOLO alla nascita e al
                            -- completamento dell'ordine corrente (FactoryFinishBuilding), mai piu'
                            -- nel frattempo — i nostri 2 BuilderGroup vengono agganciati DOPO questa
                            -- primissima richiesta (gia' soddisfatta, quasi certamente da un builder
                            -- stock del template UvesoExpansionArea), quindi restano invisibili
                            -- finche' quell'ordine non finisce (mai successo entro la durata dei
                            -- test); 2) le NOSTRE condizioni custom (OWPlusLogConditions.lua) non
                            -- sono valutate dal vivo dal motore ma lette da una cache aggiornata da
                            -- un thread condiviso di tutto il brain (ConditionsMonitor,
                            -- BrainConditionsMonitor.lua) con fino a ~7s di ritardo dalla prima
                            -- registrazione. Attendiamo quindi 8s (oltre il ritardo massimo della
                            -- cache) prima di forzare una nuova valutazione su entrambi i sistemi,
                            -- invece di aspettare un trigger naturale che potrebbe non arrivare mai.
                            local forceLocType = realLocType
                            local forceOutpostKey = targetLocType
                            ForkThread(function()
                                WaitSeconds(8)
                                local mgr = aiBrain.BuilderManagers[forceLocType]
                                if not mgr then return end

                                -- Fase A: guardia IsIdleState() — AssignBuildOrder non controlla se
                                -- la fabbrica e' gia' impegnata, forzarla su una occupata rischierebbe
                                -- di accodare un secondo ordine sopra quello in corso.
                                if mgr.FactoryManager and mgr.FactoryManager.FactoryList then
                                    for _, fac in mgr.FactoryManager.FactoryList do
                                        if not fac.Dead and fac.BuilderManagerData and fac.BuilderManagerData.BuilderType and fac:IsIdleState() then
                                            mgr.FactoryManager:AssignBuildOrder(fac, fac.BuilderManagerData.BuilderType)
                                            LOG('[OWPlus] Outpost: ' .. forceOutpostKey .. ' — forzata nuova valutazione builder su fabbrica ('
                                                .. tostring(fac.UnitId) .. ', bType=' .. tostring(fac.BuilderManagerData.BuilderType) .. ')')
                                        end
                                    end
                                end

                                -- Fase B: nessun equivalente di AssignBuildOrder — la decisione vive
                                -- dentro ManagerLoopBody, normalmente richiamato dal loop periodico
                                -- del manager. La invochiamo direttamente sui SOLI builder upgrade
                                -- appena agganciati (handle gia' disponibili in BuilderHandles).
                                local upgradeHandles = mgr.BuilderHandles and mgr.BuilderHandles['OWPlus Outpost Factory Upgrade']
                                if mgr.PlatoonFormManager and upgradeHandles then
                                    for _, builderHandle in upgradeHandles do
                                        mgr.PlatoonFormManager:ManagerLoopBody(builderHandle, 'Any')
                                    end
                                    LOG('[OWPlus] Outpost: ' .. forceOutpostKey .. ' — forzata valutazione immediata builder upgrade fabbrica')
                                end
                            end)
                        else
                            LOG('[OWPlus-WARN] Outpost: ' .. targetLocType .. ' non trovato in FactoryList di alcun BuilderManager dopo AddFactoryToClosestManager — OWPlusOutpostLocationTypes NON popolato, i builder ingegnere avamposto non si attiveranno qui')
                        end
                        break
                    end
                end
            end)

            -- Fase 9-F22: sorveglianza distruzione/ricostruzione. Se TUTTE le
            -- fabbriche di questo avamposto muoiono, dopo un periodo di sicurezza
            -- (per non rimandare un ingegnere in mezzo a un combattimento ancora
            -- in corso) e solo quando l'area torna libera da nemici, libera lo
            -- slot cosi' 'OWPlus Outpost Factory Claim' puo' rimandare un
            -- ingegnere a ricostruirlo — stessa posizione (OWPlusSubBases) e
            -- stessa ricetta (OWPlusOutpostRecipes), mai toccate qui.
            ForkThread(function()
                WaitSeconds(90)
                local initialCount = table.getn(aiBrain:GetUnitsAroundPoint(categories.STRUCTURE * categories.FACTORY, outpostPos, 20, 'Ally') or {})
                if initialCount == 0 then
                    LOG('[OWPlus] Outpost watcher (' .. outpostKey .. '): nessuna fabbrica trovata dopo 90s, sorveglianza annullata')
                    return
                end
                LOG('[OWPlus] Outpost watcher (' .. outpostKey .. '): OK, sorveglianza avviata su ' .. initialCount .. ' fabbriche')

                -- Fix falso-morto da upgrade (sess.74): la versione precedente teneva un
                -- riferimento fisso alle unita' catturate qui sopra e controllava solo
                -- '.Dead' su QUELLE istanze specifiche. Confermato in dev.log (sess.73/74):
                -- un upgrade riuscito di una fabbrica sostituisce l'entita' (la vecchia
                -- muore, ne nasce una nuova alla stessa posizione — comportamento normale
                -- del motore per l'upgrade di una struttura, gia' noto da Conoscenze_AI_34
                -- §34.1 e dal fix orfano di sess.72) — per un avamposto con UNA sola
                -- fabbrica, questo faceva scattare "tutte le fabbriche distrutte" su un
                -- avamposto perfettamente sano appena salito di tier, buttando via un
                -- successo e forzando una ricostruzione completa (osservato: OUT17,
                -- ricostruzione poi fallita per terreno non valido). Fix: ad ogni ciclo
                -- ri-scansiona fisicamente l'area invece di fidarsi di riferimenti vecchi
                -- — cosi' una fabbrica sostituita da upgrade viene vista correttamente
                -- come "ancora presente", non come "morta".
                while true do
                    WaitSeconds(30)
                    local liveCount = table.getn(aiBrain:GetUnitsAroundPoint(categories.STRUCTURE * categories.FACTORY, outpostPos, 20, 'Ally') or {})
                    if liveCount == 0 then
                        break
                    end
                end
                LOG('[OWPlus] Outpost watcher (' .. outpostKey .. '): OK, tutte le fabbriche distrutte, attesa di sicurezza (60s) prima di valutare ricostruzione')

                WaitSeconds(60)
                while aiBrain:GetNumUnitsAroundPoint(categories.ALLUNITS - categories.SCOUT, outpostPos, 40, 'Enemy') > 0 do
                    WaitSeconds(30)
                end

                aiBrain.OWPlusOutpostClaimed[outpostKey] = nil
                aiBrain.OWPlusOutpostFactories[outpostKey] = nil
                LOG('[OWPlus] Outpost watcher (' .. outpostKey .. '): OK, area libera da nemici, slot rilasciato per ricostruzione')
            end)

            -- Fase A (B16): riassorbimento ingegneri di tier superato. Quando la
            -- fabbrica dell'avamposto sale di tier (T1->T2->T3), gli ingegneri del
            -- tier precedente non vengono piu' prodotti (gate in OWPlus Outpost
            -- Engineer Builders.lua) ma quelli gia' esistenti non vanno sprecati:
            -- finiscono l'ordine in corso, poi passano ad assist permanente della
            -- fabbrica stessa (IssueGuard, stesso idioma usato per il secondo+
            -- ingegnere di uno stesso plotone piu' sopra in questo file).
            ForkThread(function()
                -- Fix race condition (sess.73): questo ForkThread e' SIBLING del thread
                -- di registrazione (quello che popola aiBrain.OWPlusOutpostFactories,
                -- piu' sopra in questo file) — nessuna garanzia che sia gia' finito
                -- quando questo parte. Controllare 'OWPlusOutpostFactories[outpostKey]'
                -- all'istante zero lo trovava quasi sempre nil, facendo terminare la
                -- sorveglianza all'istante (confermato in dev.log sess.73: "avviata" e
                -- "terminata (fabbrica assente/morta)" sempre a distanza zero, per OGNI
                -- avamposto di ogni test finora — il riassorbimento non ha mai
                -- funzionato). Fix: attendere fino a 60s che la tabella venga popolata
                -- prima di dichiarare la sorveglianza avviata o abbandonarla.
                local waitedForFactory = 0
                while not (aiBrain.OWPlusOutpostFactories and aiBrain.OWPlusOutpostFactories[outpostKey])
                    and waitedForFactory < 60 do
                    WaitSeconds(2)
                    waitedForFactory = waitedForFactory + 2
                end
                if not (aiBrain.OWPlusOutpostFactories and aiBrain.OWPlusOutpostFactories[outpostKey]) then
                    LOG('[OWPlus-WARN] Outpost (' .. outpostKey .. '): sorveglianza riassorbimento tier non avviata, fabbrica mai registrata entro 60s')
                    return
                end

                LOG('[OWPlus] Outpost (' .. outpostKey .. '): OK, avviata sorveglianza riassorbimento tier ingegneri')
                local lastTier = 1
                while true do
                    WaitSeconds(20)
                    -- Fix falso-morto da upgrade (sess.74): la versione precedente teneva
                    -- fisso il riferimento a aiBrain.OWPlusOutpostFactories[outpostKey] e
                    -- si fermava al primo .Dead — ma un upgrade riuscito sostituisce
                    -- l'entita' (stesso motivo del fix 9-F22 poco sopra), quindi il
                    -- riassorbimento si fermava dopo il PRIMO salto di tier, lasciando
                    -- indietro ingegneri costruiti su tier successivi (osservato: un
                    -- ingegnere T2 "rimasto in coda" dopo l'upgrade a T3). Fix: ad ogni
                    -- ciclo ri-cerca fisicamente la fabbrica viva di tier piu' alto vicino
                    -- alla posizione nota, invece di fidarsi della vecchia istanza —
                    -- cosi' il riassorbimento segue correttamente T1->T2->T3 anche
                    -- attraverso piu' sostituzioni di entita'.
                    local nearbyFactories = aiBrain:GetUnitsAroundPoint(
                        categories.STRUCTURE * categories.FACTORY, outpostPos, 20, 'Ally') or {}
                    local factory
                    local curTier = 0
                    for _, f in nearbyFactories do
                        if not f.Dead then
                            local fTier = 1
                            if EntityCategoryContains(categories.TECH3, f) then
                                fTier = 3
                            elseif EntityCategoryContains(categories.TECH2, f) then
                                fTier = 2
                            end
                            if fTier > curTier then
                                curTier = fTier
                                factory = f
                            end
                        end
                    end
                    if not factory then break end
                    aiBrain.OWPlusOutpostFactories[outpostKey] = factory

                    if curTier > lastTier then
                        LOG('[OWPlus] Outpost (' .. outpostKey .. '): OK, fabbrica salita a tier ' .. curTier
                            .. ', riassorbimento ingegneri tier ' .. lastTier)
                        -- Diagnostica sess.77 (quater): dump non-throttled dello stato reale di
                        -- FactoryManager.FactoryList nell'istante esatto del salto di tier, per
                        -- capire se la lista resta "sporca" (vecchia entita' morta ancora presente,
                        -- nuova entita' T-superiore mai aggiunta) — sospettato responsabile del
                        -- "buco nero": la valutazione builder Engineer/FactoryUpgrade per questa
                        -- location si ferma per sempre subito dopo ogni salto di tier osservato.
                        do
                            local diagRealLocType = aiBrain.OWPlusOutpostRealLocType and aiBrain.OWPlusOutpostRealLocType[outpostKey]
                            local diagMgr = diagRealLocType and aiBrain.BuilderManagers[diagRealLocType]
                            if diagMgr and diagMgr.FactoryManager and diagMgr.FactoryManager.FactoryList then
                                local diagCount = 0
                                local diagParts = {}
                                for _, diagF in diagMgr.FactoryManager.FactoryList do
                                    diagCount = diagCount + 1
                                    table.insert(diagParts, tostring(diagF.UnitId) .. '(Dead=' .. tostring(diagF.Dead)
                                        .. ',T3=' .. tostring(EntityCategoryContains(categories.TECH3, diagF))
                                        .. ',T2=' .. tostring(EntityCategoryContains(categories.TECH2, diagF)) .. ')')
                                end
                                LOG('[OWPlus-DIAG] Tier-up (' .. outpostKey .. ', manager="' .. tostring(diagRealLocType)
                                    .. '"): FactoryList contiene ' .. diagCount .. ' voci: ' .. table.concat(diagParts, ' | '))
                            else
                                LOG('[OWPlus-DIAG] Tier-up (' .. outpostKey .. '): manager/FactoryManager/FactoryList non trovato (realLocType="'
                                    .. tostring(diagRealLocType) .. '")')
                            end
                            -- Heartbeat 15s x 8 (120s totali): lo snapshot singolo sopra cattura
                            -- solo l'istante esatto — se il "buco nero" si manifesta qualche
                            -- secondo dopo (es. durante le ForkThread di riassorbimento/Fase C
                            -- che partono subito sotto), questo heartbeat lo mostra comunque.
                            ForkThread(function()
                                local diagTicks = 0
                                while diagTicks < 8 do
                                    WaitSeconds(15)
                                    diagTicks = diagTicks + 1
                                    local hbMgr = diagRealLocType and aiBrain.BuilderManagers[diagRealLocType]
                                    if hbMgr and hbMgr.FactoryManager and hbMgr.FactoryManager.FactoryList then
                                        local hbCount = 0
                                        local hbParts = {}
                                        for _, hbF in hbMgr.FactoryManager.FactoryList do
                                            hbCount = hbCount + 1
                                            -- Fix sess.77 (quinquies): estesa con IsUnitState('Upgrading'/'Building')
                                            -- e OWPlusUpgradeClaimed sulle entita' vive, per capire se gli Engineer
                                            -- builder restano bloccati per sempre da 'Upgrading' incollato a true su
                                            -- una fabbrica gia' al tier massimo (T3, nessun upgrade successivo
                                            -- possibile), o se il blocco ha un'altra causa.
                                            local hbExtra = ''
                                            if not hbF.Dead then
                                                hbExtra = ',Upgrading=' .. tostring(hbF:IsUnitState('Upgrading'))
                                                    .. ',Building=' .. tostring(hbF:IsUnitState('Building'))
                                                    .. ',Claimed=' .. tostring(hbF.OWPlusUpgradeClaimed)
                                            end
                                            table.insert(hbParts, tostring(hbF.UnitId) .. '(Dead=' .. tostring(hbF.Dead) .. hbExtra .. ')')
                                        end
                                        -- Fix sess.77 (quinquies): timestamp REALE dell'ultima valutazione
                                        -- della condizione, letto direttamente da OWPlusDebugLastLog (scritto
                                        -- ad OGNI chiamata della funzione, indipendentemente dal throttle sul
                                        -- LOG) — piu' affidabile di cercare righe di log throttled per capire
                                        -- SE e QUANDO il ciclo di valutazione builder per questa location si
                                        -- e' davvero fermato, invece di dedurlo dall'assenza di righe.
                                        local hbLastEval = aiBrain.OWPlusDebugLastLog
                                            and aiBrain.OWPlusDebugLastLog['IsOutpostLocation_' .. tostring(diagRealLocType)]
                                        local hbNow = GetGameTimeSeconds()
                                        local hbAgo = hbLastEval and (hbNow - hbLastEval) or nil
                                        LOG('[OWPlus-DIAG] Heartbeat +' .. (diagTicks * 15) .. 's (' .. outpostKey .. '): FactoryList = '
                                            .. hbCount .. ' voci: ' .. table.concat(hbParts, ' | ')
                                            .. ' -- ultima valutazione OWPlusIsOutpostLocation: ' .. tostring(hbAgo) .. 's fa')
                                    else
                                        LOG('[OWPlus-DIAG] Heartbeat +' .. (diagTicks * 15) .. 's (' .. outpostKey .. '): manager sparito!')
                                    end
                                end
                            end)
                        end
                        local oldTierCat = categories.TECH1
                        if lastTier == 2 then
                            oldTierCat = categories.TECH2
                        end
                        local oldEngs = aiBrain:GetUnitsAroundPoint(
                            categories.MOBILE * categories.ENGINEER * oldTierCat, outpostPos, 30, 'Ally') or {}
                        -- Snapshot locale: lastTier verra' riassegnato dal while esterno prima
                        -- che questi ForkThread (in attesa che l'ingegnere finisca l'ordine
                        -- corrente) eseguano il proprio LOG — senza questa copia il messaggio
                        -- potrebbe riportare un tier gia' superato da un successivo salto.
                        local reassignedFromTier = lastTier
                        -- Fix sess.76 (crash reale trovato in game): "attempt to call method
                        -- 'IsUnitState' (a nil value)" proprio nell'istante del salto di tier —
                        -- oldEng risultava nil dentro la ForkThread nonostante il guard
                        -- "not oldEng.Dead" appena sopra (che presuppone oldEng non-nil). Il
                        -- crash uccideva la coroutine silenziosamente e, a valle, l'intera
                        -- valutazione dei builder ingegnere per l'avamposto si fermava per il
                        -- resto della partita (confermato: OWPlusOutpostFactoryIsTech mai piu'
                        -- valutata dopo il crash). Guardia difensiva aggiuntiva (oldEng non-nil,
                        -- sia fuori che dentro la ForkThread) per non fidarsi ciecamente che
                        -- l'iterazione su oldEngs (GetUnitsAroundPoint) dia sempre voci valide.
                        for _, oldEng in oldEngs do
                            if oldEng and not oldEng.Dead then
                                ForkThread(function()
                                    while oldEng and not oldEng.Dead and (oldEng:IsUnitState('Building') or oldEng:IsUnitState('Moving')) do
                                        WaitSeconds(5)
                                    end
                                    local curFactory = aiBrain.OWPlusOutpostFactories and aiBrain.OWPlusOutpostFactories[outpostKey]
                                    if oldEng and not oldEng.Dead and curFactory and not curFactory.Dead then
                                        IssueClearCommands({oldEng})
                                        IssueGuard({oldEng}, curFactory)
                                        LOG('[OWPlus] Outpost (' .. outpostKey .. '): ingegnere tier ' .. reassignedFromTier
                                            .. ' (' .. tostring(oldEng.UnitId) .. ') riassegnato ad assist permanente della fabbrica')
                                    end
                                end)
                            end
                        end
                        -- Fase C (B16): reclaim reale + ricostruzione delle difese
                        -- del tier precedente. Ogni difesa trovata viene reclamata
                        -- da un ingegnere libero dell'avamposto (stesso flag
                        -- OWPlusOutpostBusy della 9-F34, per evitare che il ciclo
                        -- standard di assegnazione builder lo riprenda a meta'
                        -- reclaim) e ricostruita al tier nuovo. Se l'ingegnere
                        -- viene comunque interrotto (reclaim mai completato entro
                        -- il timeout), nessun danno strutturale: la vecchia difesa
                        -- resta in piedi (il reclaim reale, a differenza dei danni,
                        -- non lascia la struttura a meta' se annullato) e si
                        -- riprova dopo un throttle — stesso principio della 9-F35.
                        local oldDefenses = aiBrain:GetUnitsAroundPoint(
                            categories.STRUCTURE * categories.DEFENSE * oldTierCat - categories.SHIELD, outpostPos, 40, 'Ally') or {}
                        for _, oldDef in oldDefenses do
                            if not oldDef.Dead then
                                local isAA = EntityCategoryContains(categories.ANTIAIR, oldDef)
                                ForkThread(function()
                                    local rebuilt = false
                                    local totalWaited = 0
                                    while not rebuilt and not oldDef.Dead and totalWaited < 600 do
                                        -- Ingegnere libero: non gia' impegnato (OWPlusOutpostBusy)
                                        -- e realmente idle (Conoscenze_AI_32 §32.2: IsIdleState(),
                                        -- non IsUnitState()).
                                        local freeEng
                                        local nearbyEngs = aiBrain:GetUnitsAroundPoint(
                                            categories.MOBILE * categories.ENGINEER, outpostPos, 30, 'Ally') or {}
                                        for _, e in nearbyEngs do
                                            if not e.Dead and not e.OWPlusOutpostBusy and e:IsIdleState() then
                                                freeEng = e
                                                break
                                            end
                                        end

                                        -- Fix sess.77 (crash reale trovato in game, RIPETUTO anche dopo
                                        -- un primo guard "not oldDef.Dead" appena prima della chiamata):
                                        -- "attempt to call method 'GetPosition' (a nil value)" su oldDef.
                                        -- Il fatto che si ripresenti identico nonostante il ricontrollo
                                        -- immediato (nessun WaitSeconds/yield fra check e chiamata, quindi
                                        -- nessun altro thread Lua puo' essersi inserito in mezzo) indica che
                                        -- .Dead puo' restare false lato Lua per una finestra dopo che il
                                        -- motore ha gia' invalidato l'entita' lato C — non verificabile da
                                        -- script. pcall come rete di sicurezza definitiva: se la chiamata
                                        -- fallisce comunque, si abbandona il giro e si riprova al prossimo
                                        -- (il while esterno ricontrolla oldDef.Dead ad ogni iterazione).
                                        local defPos
                                        if freeEng then
                                            local defPosOk
                                            defPosOk, defPos = pcall(function() return oldDef:GetPosition() end)
                                            if not defPosOk or not defPos then
                                                LOG('[OWPlus-WARN] Outpost (' .. outpostKey .. '): GetPosition fallita su difesa (probabile invalidazione concorrente), salto questa iterazione')
                                                freeEng = nil
                                            end
                                        end
                                        if freeEng then
                                            freeEng.OWPlusOutpostBusy = true
                                            IssueClearCommands({freeEng})
                                            IssueReclaim({freeEng}, oldDef)

                                            local reclaimWaited = 0
                                            while not oldDef.Dead and reclaimWaited < 120 do
                                                WaitSeconds(3)
                                                reclaimWaited = reclaimWaited + 3
                                            end

                                            if oldDef.Dead and not freeEng.Dead then
                                                local newDefType = OWPlusOutpostDefensePool.OWPlusPickUpgradeDefense(aiBrain, curTier, isAA)
                                                -- Fix sess.76: stesso crash/fix della fase difese iniziali
                                                -- piu' sotto — nil per buildingTemplate/baseTemplate fa
                                                -- crashare AIExecuteBuildStructure su unita' non vanilla
                                                -- (es. difese TotalMayhem) quando DecideWhatToBuild() non
                                                -- le risolve da solo.
                                                local factionLookup = { UEF = 1, AEON = 2, CYBRAN = 3, SERAPHIM = 4, NOMADS = 5 }
                                                local defFactionIndex = factionLookup[freeEng.factionCategory] or 1
                                                local defBuildingTmpl = import('/lua/BuildingTemplates.lua')['BuildingTemplates'][defFactionIndex]
                                                local defBaseTmpl = import('/lua/BaseTemplates.lua')['BaseTemplates'][defFactionIndex]
                                                local defBaseTmplAtTarget = AIBuildStructures.AIBuildBaseTemplateFromLocation(defBaseTmpl, defPos)
                                                AIBuildStructures.AIExecuteBuildStructure(
                                                    aiBrain, freeEng, newDefType, nil, false, defBuildingTmpl, defBaseTmplAtTarget, defPos, nil)
                                                LOG('[OWPlus] Outpost (' .. outpostKey .. '): difesa tier ' .. reassignedFromTier
                                                    .. ' reclamata e ricostruita a tier ' .. curTier .. ' (' .. tostring(newDefType) .. ')')
                                                rebuilt = true
                                            else
                                                LOG('[OWPlus-WARN] Outpost (' .. outpostKey .. '): reclaim difesa interrotto/scaduto, riprovo dopo throttle')
                                            end

                                            if not freeEng.Dead then
                                                freeEng.OWPlusOutpostBusy = nil
                                            end
                                        end

                                        if not rebuilt and not oldDef.Dead then
                                            WaitSeconds(15)
                                            totalWaited = totalWaited + 15
                                        end
                                    end
                                    if not rebuilt and not oldDef.Dead then
                                        LOG('[OWPlus-WARN] Outpost (' .. outpostKey .. '): difesa tier ' .. reassignedFromTier
                                            .. ' non reclamata/ricostruita entro il tetto di sicurezza, resta al tier vecchio')
                                    end
                                end)
                            end
                        end

                        lastTier = curTier
                    end
                end
                LOG('[OWPlus] Outpost (' .. outpostKey .. '): sorveglianza riassorbimento tier terminata (fabbrica assente/morta)')
            end)

            -- Fix orfano fabbrica avamposto (sess.72): confermato in dev.log (100%
            -- riproducibile su ogni avamposto osservato) che la fabbrica di un
            -- avamposto puo' sparire dal FactoryList del suo BuilderManager (es. dopo
            -- un upgrade — il motore distrugge l'unita' vecchia e ne crea una nuova
            -- alla stessa posizione, comportamento normale per l'upgrade di una
            -- struttura) senza che nulla ri-registri la nuova entita': l'avamposto
            -- resta con fabbrica fisicamente presente ma invisibile a
            -- OWPlusOutpostFactoryIsTech per il resto della partita — "costruito ma
            -- fermo". Stesso pattern di recupero che Uveso usa per le fabbriche navali
            -- disperse (LocationRangeManagerThread, aiarchetype-managerloader.lua:
            -- "no factory manager?" -> AddFactoryToClosestManager), qui applicato
            -- puntualmente alla posizione nota dell'avamposto invece che a scansione
            -- globale su tutte le unita' dell'esercito.
            ForkThread(function()
                WaitSeconds(30)
                local emptyStreak = 0
                while aiBrain.OWPlusOutpostRealLocType and aiBrain.OWPlusOutpostRealLocType[outpostKey] do
                    local realLocType = aiBrain.OWPlusOutpostRealLocType[outpostKey]
                    local mgr = aiBrain.BuilderManagers[realLocType]
                    if not mgr or not mgr.FactoryManager then
                        -- Fix sess.77: non e' solo la ENTRY nel FactoryList a poter sparire —
                        -- puo' sparire il MANAGER stesso. DeadBaseMonitor (base-ai.lua, vedi
                        -- Conoscenze_AI regola 19) distrugge ogni BuilderManager non-MAIN privo
                        -- di ingegneri/fabbriche ogni 5s: durante un upgrade fabbrica esiste una
                        -- finestra reale (vecchia entita' gia' .Dead, nuova non ancora
                        -- ri-registrata) in cui puo' scattare. Diagnostica dedicata (sess.77,
                        -- dump FactoryList al salto di tier + heartbeat 15s) ha confermato: il
                        -- manager risultava sparito esattamente al tier-up e mai piu' tornato —
                        -- root cause reale del "buco nero" post tier-up inseguito per tutta la
                        -- sessione. Fix: invece di arrendersi (vecchio comportamento: break),
                        -- ri-registrare da zero la fabbrica fisicamente ancora viva alla
                        -- posizione nota, stesso identico percorso della PRIMA adozione (Fase
                        -- 9-F19/20 piu' sopra in questo file).
                        local rescueCandidates = aiBrain:GetUnitsAroundPoint(
                            categories.STRUCTURE * categories.FACTORY, outpostPos, 20, 'Ally') or {}
                        local rescueFactory
                        for _, cand in rescueCandidates do
                            if not cand.Dead then
                                rescueFactory = cand
                                break
                            end
                        end
                        if rescueFactory then
                            -- Come nella prima adozione (Fase 9-F19/20): la fabbrica potrebbe
                            -- essere gia' stata auto-assegnata al manager di MAIN dal motore
                            -- (comportamento nativo quando nessun manager dedicato la reclama) —
                            -- va staccata esplicitamente prima di AddFactoryToClosestManager,
                            -- altrimenti il guard 'if not v.BuilderManagerData' di vanilla la
                            -- ignora e resta assegnata a MAIN.
                            if rescueFactory.BuilderManagerData and rescueFactory.BuilderManagerData.FactoryBuildManager then
                                local rescueOldLocType = rescueFactory.BuilderManagerData.FactoryBuildManager.LocationType
                                for k, v in rescueFactory.BuilderManagerData.FactoryBuildManager.FactoryList do
                                    if v == rescueFactory then
                                        rescueFactory.BuilderManagerData.FactoryBuildManager.FactoryList[k] = nil
                                    end
                                end
                                -- Fix sess.77 (quater): rimuovere la fabbrica dalla FactoryList del
                                -- vecchio manager NON basta — SetupFactoryCallbacks (vanilla,
                                -- FactoryBuilderManager.lua) registra i trigger "fabbrica ha finito
                                -- di costruire, chiedi il prossimo ordine" SOLO se
                                -- unit.BuilderManagerData e' nil in quel momento. Senza azzerarlo
                                -- qui, quei trigger restano legati per sempre al VECCHIO manager
                                -- (i loro closure catturano il vecchio 'self') anche se la fabbrica
                                -- compare correttamente nella FactoryList del manager giusto —
                                -- spiega perche' una prima valutazione poteva riuscire per caso ma
                                -- nessun ordine successivo veniva mai richiesto.
                                rescueFactory.BuilderManagerData = nil
                                LOG('[OWPlus] Outpost (' .. outpostKey .. '): fabbrica di recupero (' .. tostring(rescueFactory.UnitId)
                                    .. ') staccata dal manager "' .. tostring(rescueOldLocType) .. '"')
                            end
                            local OWPlusManagerLoader = import('/lua/ai/aiarchetype-managerloader.lua')
                            OWPlusManagerLoader.AddFactoryToClosestManager(aiBrain, rescueFactory)
                            local newRealLocType
                            for locKey, candMgr in aiBrain.BuilderManagers do
                                if candMgr.FactoryManager and candMgr.FactoryManager.FactoryList then
                                    for _, factoryUnit in candMgr.FactoryManager.FactoryList do
                                        if factoryUnit == rescueFactory then
                                            newRealLocType = locKey
                                            break
                                        end
                                    end
                                end
                                if newRealLocType then break end
                            end
                            if newRealLocType then
                                aiBrain.OWPlusOutpostLocationTypes[newRealLocType] = true
                                aiBrain.OWPlusOutpostRealLocType[outpostKey] = newRealLocType
                                local OWPlusAddBuilderTable = import('/lua/ai/AIAddBuilderTable.lua')
                                OWPlusAddBuilderTable.AddGlobalBuilderGroup(aiBrain, newRealLocType, 'OWPlus Outpost Engineer Builders')
                                OWPlusAddBuilderTable.AddGlobalBuilderGroup(aiBrain, newRealLocType, 'OWPlus Outpost Factory Upgrade')
                                -- Fix sess.77 (septies): stessa rete di sicurezza del ramo
                                -- "fabbrica orfana" poco sotto — chiamata diretta ed esplicita a
                                -- AssignBuildOrder, indipendente da cosa AddFactoryToClosestManager
                                -- abbia deciso internamente.
                                local rescueBType2 = 'Land'
                                if EntityCategoryContains(categories.AIR, rescueFactory) then
                                    rescueBType2 = 'Air'
                                elseif EntityCategoryContains(categories.NAVAL, rescueFactory) then
                                    rescueBType2 = 'Sea'
                                end
                                aiBrain.BuilderManagers[newRealLocType].FactoryManager:AssignBuildOrder(rescueFactory, rescueBType2)
                                aiBrain.OWPlusOutpostFactories = aiBrain.OWPlusOutpostFactories or {}
                                aiBrain.OWPlusOutpostFactories[outpostKey] = rescueFactory
                                LOG('[OWPlus] Outpost (' .. outpostKey .. '): OK, manager sparito (DeadBaseMonitor) — ricreato e riagganciato con chiave "' .. newRealLocType .. '"')
                                emptyStreak = 0
                            else
                                LOG('[OWPlus-WARN] Outpost (' .. outpostKey .. '): manager sparito, fabbrica ricandidata ma non trovata in alcun FactoryList dopo AddFactoryToClosestManager')
                                break
                            end
                        else
                            emptyStreak = emptyStreak + 20
                            if emptyStreak >= 300 then
                                LOG('[OWPlus-WARN] Outpost (' .. outpostKey .. '): manager sparito e nessuna fabbrica viva/recuperabile per 300s consecutivi, sorveglianza terminata')
                                break
                            end
                        end
                    else
                        local aliveCount = 0
                        if mgr.FactoryManager.FactoryList then
                            for _, f in mgr.FactoryManager.FactoryList do
                                if not f.Dead then
                                    aliveCount = aliveCount + 1
                                end
                            end
                        end

                        if aliveCount == 0 then
                            local candidates = aiBrain:GetUnitsAroundPoint(
                                categories.STRUCTURE * categories.FACTORY, outpostPos, 20, 'Ally') or {}
                            local rescued = false
                            for _, cand in candidates do
                                if not cand.Dead then
                                    -- Fix sess.77 (bis): 'not cand.BuilderManagerData' non scattava
                                    -- mai — confermato in game (diagnostica dedicata): la nuova
                                    -- fabbrica T-superiore NON resta orfana dopo un upgrade, il
                                    -- motore la auto-assegna a un manager esistente (tipicamente
                                    -- MAIN, stesso comportamento gia' noto dalla PRIMA adozione,
                                    -- Fase 9-F19/20 piu' sopra) — quindi ha SEMPRE BuilderManagerData
                                    -- non-nil, solo puntato al manager sbagliato. Va staccata
                                    -- esplicitamente da quel manager (stesso identico pattern della
                                    -- 9-F19/20) prima di AddFactory, non solo aggiunta se libera.
                                    if cand.BuilderManagerData and cand.BuilderManagerData.FactoryBuildManager
                                        and cand.BuilderManagerData.FactoryBuildManager ~= mgr.FactoryManager then
                                        local candOldLocType = cand.BuilderManagerData.FactoryBuildManager.LocationType
                                        for k, v in cand.BuilderManagerData.FactoryBuildManager.FactoryList do
                                            if v == cand then
                                                cand.BuilderManagerData.FactoryBuildManager.FactoryList[k] = nil
                                            end
                                        end
                                        -- Fix sess.77 (quater): rimuovere dalla FactoryList del vecchio
                                        -- manager NON basta — SetupFactoryCallbacks (vanilla,
                                        -- FactoryBuilderManager.lua) registra i trigger "fabbrica ha
                                        -- finito di costruire, chiedi il prossimo ordine" SOLO se
                                        -- unit.BuilderManagerData e' nil in quel momento. Letto il
                                        -- codice vanilla: senza azzerarlo qui, quei trigger restano
                                        -- legati per sempre al VECCHIO manager (closure che cattura il
                                        -- vecchio 'self'), anche se la fabbrica compare correttamente
                                        -- nella FactoryList del manager giusto — root cause reale del
                                        -- "condizioni verdi ma fabbrica ferma dopo il primo ordine".
                                        cand.BuilderManagerData = nil
                                        LOG('[OWPlus] Outpost (' .. outpostKey .. '): fabbrica (' .. tostring(cand.UnitId)
                                            .. ') staccata dal manager "' .. tostring(candOldLocType) .. '"')
                                    end
                                    mgr.FactoryManager:AddFactory(cand)
                                    -- Fix sess.77 (septies): confermato in game (hook diagnostico
                                    -- gia' esistente su AssignBuildOrder, sess.73) — dopo un
                                    -- riaggancio "a freddo" la catena nativa che chiede "cosa
                                    -- costruire" (SetupNewFactory -> DelayBuildOrder ->
                                    -- AssignBuildOrder) a volte non parte MAI: zero righe di log
                                    -- dell'hook per l'intera restante durata della partita, non
                                    -- "chiamata ma nessun builder trovato". Sospetto: AddFactory
                                    -- vanilla ha un guard 'FactoryAlreadyExists' che, se la
                                    -- fabbrica risulta gia' presente nella FactoryList per altra
                                    -- via, salta silenziosamente l'intera configurazione (incluso
                                    -- il fork di DelayBuildOrder). Chiamata diretta ed esplicita
                                    -- come rete di sicurezza, indipendente da cosa abbia deciso
                                    -- AddFactory internamente — stesso bType che vanilla stesso
                                    -- avrebbe determinato (i nostri avamposti sono sempre Land).
                                    local rescueBType = 'Land'
                                    if EntityCategoryContains(categories.AIR, cand) then
                                        rescueBType = 'Air'
                                    elseif EntityCategoryContains(categories.NAVAL, cand) then
                                        rescueBType = 'Sea'
                                    end
                                    mgr.FactoryManager:AssignBuildOrder(cand, rescueBType)
                                    cand.lost = nil
                                    aiBrain.OWPlusOutpostFactories = aiBrain.OWPlusOutpostFactories or {}
                                    aiBrain.OWPlusOutpostFactories[outpostKey] = cand
                                    LOG('[OWPlus] Outpost (' .. outpostKey .. '): fabbrica orfana (' .. tostring(cand.UnitId)
                                        .. ') trovata e riagganciata al manager "' .. realLocType .. '"')
                                    rescued = true
                                    emptyStreak = 0
                                    break
                                end
                            end
                            if not rescued then
                                emptyStreak = emptyStreak + 20
                                if emptyStreak >= 300 then
                                    LOG('[OWPlus-WARN] Outpost (' .. outpostKey .. '): nessuna fabbrica viva/recuperabile per 300s consecutivi, sorveglianza orfani terminata (probabile distruzione reale, gestita dalla 9-F22)')
                                    break
                                end
                            end
                        else
                            emptyStreak = 0
                        end
                    end

                    WaitSeconds(20)
                end
            end)

            -- Fase A: compito locale di default (sess.75). Un ingegnere dell'avamposto
            -- appena costruito (tier attuale, non superato) non ha nessun compito
            -- assegnato — nulla lo tiene sul posto. Osservato in game: i builder stock
            -- del template UvesoExpansionArea (ancora agganciato per intero insieme ai
            -- nostri, mai ripulito) lo reclamano per compiti generici ovunque sulla
            -- mappa (es. estrattori di massa lontani dall'avamposto), oppure — se
            -- nemmeno lo stock lo reclama — resta semplicemente fermo senza ordini
            -- (osservato: 5 ingegneri T3 tutti fermi in un avamposto). Watcher
            -- dedicato: ogni 15s, qualunque ingegnere libero (IsIdleState(), non gia'
            -- OWPlusOutpostBusy) vicino alla posizione nota viene messo ad assist
            -- permanente della fabbrica locale — stesso idioma IssueGuard gia' usato
            -- dal riassorbimento tier qui sopra, esteso qui agli ingegneri del tier
            -- CORRENTE (non solo quelli superati). Un ingegnere gia' in guardia non
            -- risulta piu' IsIdleState(), quindi non viene ri-processato ad ogni ciclo.
            ForkThread(function()
                while aiBrain.OWPlusOutpostRealLocType and aiBrain.OWPlusOutpostRealLocType[outpostKey] do
                    WaitSeconds(15)
                    local curFactory = aiBrain.OWPlusOutpostFactories and aiBrain.OWPlusOutpostFactories[outpostKey]
                    if curFactory and not curFactory.Dead then
                        local nearbyEngs = aiBrain:GetUnitsAroundPoint(
                            categories.MOBILE * categories.ENGINEER, outpostPos, 30, 'Ally') or {}
                        for _, e in nearbyEngs do
                            if not e.Dead and not e.OWPlusOutpostBusy and e:IsIdleState() then
                                -- Fix sess.76: IssueClearCommands prima di IssueGuard — senza,
                                -- un ordine STALE rimasto in coda nativa (es. una struttura
                                -- irraggiungibile abbandonata da OWPlusDispersedBuildAI, vedi
                                -- nota li' sopra) poteva riemergere dopo l'assist, causando un
                                -- oscillare infinito tra "assist fabbrica" e "riprova a
                                -- raggiungere il punto impossibile" — osservato dal vivo in game.
                                IssueClearCommands({e})
                                IssueGuard({e}, curFactory)
                                LOG('[OWPlus] Outpost (' .. outpostKey .. '): ingegnere libero (' .. tostring(e.UnitId)
                                    .. ') messo ad assist della fabbrica per default (nessun compito locale trovato)')
                            end
                        end
                    end
                end
            end)
        end
    end,

    -- Fix sess.76 (root cause reale del "tutto fermo dopo N strutture",
    -- confermata leggendo /lua/platoon.lua vanilla): EngineerBuildDone/
    -- EngineerCaptureDone/EngineerReclaimDone/EngineerFailedToBuild vanilla
    -- hanno tutte lo stesso bug di precedenza Lua:
    --   if not unit.PlatoonHandle.PlanName == 'EngineerBuildAI' then return end
    -- che Lua interpreta come (not unit.PlatoonHandle.PlanName) == 'EngineerBuildAI'
    -- — sempre falso quando PlanName e' una stringa non vuota (quindi il
    -- "return" non scatta MAI, per NESSUN piano, incluso il nostro
    -- 'OWPlusDispersedBuildAI'). Risultato: appena l'ingegnere completa
    -- l'ULTIMA struttura nativa in coda (eng.EngineerBuildQueue, popolata da
    -- AIExecuteBuildStructure), il trigger vanilla EngineerBuildDone chiama
    -- comunque ProcessBuildCommand — che, trovando la coda vuota dopo aver
    -- rimosso l'item appena completato, chiama eng.PlatoonHandle:PlatoonDisband()
    -- SUL NOSTRO PLOTONE. PlatoonDisband cancella gli ordini nativi
    -- dell'ingegnere e soprattutto distrugge self.AIThread — uccidendo la
    -- coroutine di OWPlusDispersedBuildAI a meta' esecuzione (tipicamente
    -- dentro il loop di attesa finale), SENZA alcun errore Lua: il nostro
    -- codice semplicemente smette di girare, OWPlusOutpostBusy resta true per
    -- sempre, e l'avamposto adottato/i builder dedicati non partono mai —
    -- esattamente il pattern "costruisce N strutture poi tutto fermo"
    -- osservato per l'intera sessione, non solo con la ricetta a 1 fabbrica.
    -- Confermato in dev.log: 'EngineerManager:TaskFinished' scattava proprio
    -- nell'istante in cui l'utente vedeva la fabbrica finire (TaskFinished e'
    -- chiamato anche da dentro PlatoonDisband stesso).
    --
    -- Fix: override dei 4 callback per il nostro piano, con la precedenza
    -- corretta ("not (X == Y)" invece di "not X == Y") — se il piano e' il
    -- nostro, non facciamo nulla (la ricetta e il loop di attesa dedicato
    -- gestiscono gia' tutto da soli); altrimenti richiamiamo la versione
    -- originale invariata.
    EngineerBuildDone = function(unit, params)
        if not unit.PlatoonHandle then return end
        if unit.PlatoonHandle.PlanName == 'OWPlusDispersedBuildAI' then
            return
        end
        CopyOfOldPlatoonClassOWPlusChild.EngineerBuildDone(unit, params)
    end,
    EngineerCaptureDone = function(unit, params)
        if not unit.PlatoonHandle then return end
        if unit.PlatoonHandle.PlanName == 'OWPlusDispersedBuildAI' then
            return
        end
        CopyOfOldPlatoonClassOWPlusChild.EngineerCaptureDone(unit, params)
    end,
    EngineerReclaimDone = function(unit, params)
        if not unit.PlatoonHandle then return end
        if unit.PlatoonHandle.PlanName == 'OWPlusDispersedBuildAI' then
            return
        end
        CopyOfOldPlatoonClassOWPlusChild.EngineerReclaimDone(unit, params)
    end,
    EngineerFailedToBuild = function(unit, params)
        if not unit.PlatoonHandle then return end
        if unit.PlatoonHandle.PlanName == 'OWPlusDispersedBuildAI' then
            return
        end
        CopyOfOldPlatoonClassOWPlusChild.EngineerFailedToBuild(unit, params)
    end,

    -- Fase 9-F28 (fix B12): PlatoonMerger (stock Uveso) chiama Platoon:GetPlan()
    -- su ogni elemento di aiBrain:GetPlatoonsList() senza controllare se quel
    -- metodo esiste davvero. Confermato in sess.66 (dev.log ricorrente):
    --   attempt to call method 'GetPlan' (a nil value)
    -- Se il crash avviene qui, la funzione si interrompe PRIMA di creare/
    -- riusare il plotone unificato — le unita' del plotone chiamante restano
    -- quindi in un plotone "orfano" mai fuso ne' disbandato, mai assegnate a
    -- un plotone d'attacco attivo. Sospettato (insieme a UnitsLessInPlatoon,
    -- vedi hook/lua/editor/unitcountbuildconditions.lua) come causa
    -- dell'esercito pieno di unita' che non lancia mai un attacco su vasta
    -- scala. Fix: stessa guardia difensiva "Platoon and Platoon.GetPlan and"
    -- prima di chiamare :GetPlan() — nessun'altra logica modificata rispetto
    -- all'originale.
    PlatoonMerger = function(self)
        local aiBrain = self:GetBrain()
        local PlatoonPlan = self.PlatoonData.AIPlan
        if not PlatoonPlan then
            return
        end
        local platoonUnits = self:GetPlatoonUnits()
        local AlreadyMergedPlatoon
        local PlatoonList = aiBrain:GetPlatoonsList()
        for _, Platoon in PlatoonList do
            if Platoon and Platoon.GetPlan and Platoon:GetPlan() == PlatoonPlan then
                AlreadyMergedPlatoon = Platoon
                break
            end
        end
        if not AlreadyMergedPlatoon then
            AlreadyMergedPlatoon = aiBrain:MakePlatoon( PlatoonPlan..'Platoon', PlatoonPlan )
            AlreadyMergedPlatoon.PlanName = PlatoonPlan
            AlreadyMergedPlatoon.BuilderName = PlatoonPlan..'Platoon'
        end
        aiBrain:AssignUnitsToPlatoon( AlreadyMergedPlatoon, platoonUnits, 'support', 'none' )
        AlreadyMergedPlatoon.PlatoonData.SearchRadius = self.PlatoonData.SearchRadius
        AlreadyMergedPlatoon.PlatoonData.GetTargetsFromBase = self.PlatoonData.GetTargetsFromBase
        AlreadyMergedPlatoon.PlatoonData.IgnorePathing = self.PlatoonData.IgnorePathing
        AlreadyMergedPlatoon.PlatoonData.DirectMoveEnemyBase = self.PlatoonData.DirectMoveEnemyBase
        AlreadyMergedPlatoon.PlatoonData.RequireTransport = self.PlatoonData.RequireTransport
        AlreadyMergedPlatoon.PlatoonData.AggressiveMove = self.PlatoonData.AggressiveMove
        AlreadyMergedPlatoon.PlatoonData.AttackEnemyStrength = self.PlatoonData.AttackEnemyStrength
        AlreadyMergedPlatoon.PlatoonData.TargetSearchCategory = self.PlatoonData.TargetSearchCategory
        AlreadyMergedPlatoon.PlatoonData.MoveToCategories = self.PlatoonData.MoveToCategories
        AlreadyMergedPlatoon.PlatoonData.WeaponTargetCategories = self.PlatoonData.WeaponTargetCategories
        AlreadyMergedPlatoon.PlatoonData.TargetHug = self.PlatoonData.TargetHug
        self:PlatoonDisbandNoAssign()
    end,
}
