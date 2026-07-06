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
            -- Fase 9-F21: le difese cercano posto con un riferimento SPOSTATO da
            -- targetPos invece di condividerlo con le fabbriche della ricetta.
            -- Motivo: essendo in coda alla buildList, dopo che 2-3 fabbriche sono
            -- gia' state piazzate vicino a targetPos, FindPlaceToBuild trova
            -- raramente spazio libero li' e la struttura viene saltata in
            -- silenzio (confermato: game log senza NESSUN fallimento esplicito
            -- per T1GroundDefense/T1AADefense, segno che il tentativo non parte
            -- quasi mai, non che fallisce). Offset fisso di 20 unita' in una
            -- direzione casuale (Random(), sync-safe) da' loro terreno libero.
            local defAngle = math.rad(Random(0, 359))
            local defensePos = { targetPos[1] + math.cos(defAngle) * 20, targetPos[2], targetPos[3] + math.sin(defAngle) * 20 }
            buildList = {}
            buildRefs = {}
            for _, t in recipe do
                table.insert(buildList, t)
                table.insert(buildRefs, targetPos)
            end
            for _, t in cons.BuildStructures do
                table.insert(buildList, t)
                table.insert(buildRefs, defensePos)
            end
            LOG('[OWPlus] Outpost: rivendicato ' .. chosenKey .. ', ' .. table.getn(buildList) .. ' strutture da costruire (ricetta+difese)')
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
                return
            end
            if usedTransport then
                LOG('[OWPlus] Outpost: trasporto usato per raggiungere ' .. targetLocType)
            else
                LOG('[OWPlus] Outpost: nessun trasporto disponibile/usato, cammino a piedi verso ' .. targetLocType)
                self:MoveToLocationInclTransport(eng, targetPos, false, true, nil)
                if not aiBrain:PlatoonExists(self) or eng.Dead then
                    return
                end
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

        -- Fase 9-F14: NON controllare IsUnitState('Building') subito dopo aver
        -- messo in coda il comando — l'ingegnere deve prima CAMMINARE fino a
        -- targetPos (puo' essere a 500 unita' di distanza dopo la 9-F13), quindi
        -- un check immediato lo vede sempre "non ancora in costruzione" e
        -- dichiara un falso "terreno non valido". Confermato in test: fallimento
        -- dichiarato al 100% ma ZERO warning "FindPlaceToBuild() failed" di Uveso
        -- in tutta la partita — la ricerca del posto non falliva mai davvero.
        -- Aspettiamo finche' l'ingegnere si muove (sta ancora camminando verso il
        -- target); se si ferma senza aver iniziato a costruire, e' un fallimento
        -- vero (bloccato o comando mai partito). Cap di sicurezza a 180s.
        local maxWaitSeconds = 180
        local waited = 0
        while waited < maxWaitSeconds and aiBrain:PlatoonExists(self) and not eng.Dead do
            if eng:IsUnitState('Building') then
                break
            end
            if not eng:IsUnitState('Moving') then
                WaitSeconds(3)
                waited = waited + 3
                break
            end
            WaitSeconds(3)
            waited = waited + 3
        end

        if not eng.Dead and not eng:IsUnitState('Building') then
            -- Fase 9-F12: nome army nei log per distinguere piu' AI in parallelo.
            local ownerName = (ArmyBrains[aiBrain:GetArmyIndex()] and ArmyBrains[aiBrain:GetArmyIndex()].Nickname) or tostring(aiBrain:GetArmyIndex())

            -- FindPlaceToBuild fallito: terreno non valido alla sub-location.
            -- Attendi 30s prima di disbandare per evitare spam di retry (~10/s → 1/30s).
            LOG('[OWPlus] OWPlusDispersedBuildAI (' .. ownerName .. '): ' .. tostring(targetLocType)
                .. ' terreno non valido, throttle 30s')

            -- Fase 9-F11: reroll per gli slot forward base (FWD1-4). Dopo 3
            -- fallimenti veri consecutivi (ognuno fino a ~210s con l'attesa 9-F14)
            -- sullo stesso slot, lo liberiamo cosi'
            -- ExpansionFunction (Uveso Forward Base OverwhelmPlus.lua) puo' accettare
            -- un marker diverso nello stesso settore. Il marker fallito viene marcato
            -- 'REJECTED' per sempre cosi' non si ripropone.
            --
            -- Fase 9-F13: stesso meccanismo esteso alle sub-location di MAIN
            -- (BASE_NE/SE/SW/NW). Qui non esiste un marker da rifiutare (sono
            -- coordinate fisse validate a init in overwhelmplusai.lua, non marker
            -- di scena) — dopo 3 fallimenti ci limitiamo a liberare lo slot per
            -- fermare lo spam di retry infiniti (visto in test: 100% fallimento
            -- per tutta la partita su Setons/scmp_009).
            --
            -- Fase 9-F18: stesso meccanismo esteso agli avamposti OUT# (nessun
            -- marker da rifiutare, sono punti generati da OWPlusOutpostGenerator.lua).
            if targetLocType and (string.sub(targetLocType, 1, 3) == 'FWD' or string.sub(targetLocType, 1, 5) == 'BASE_' or string.sub(targetLocType, 1, 3) == 'OUT') then
                aiBrain.OWPlusForwardFailCount = aiBrain.OWPlusForwardFailCount or {}
                aiBrain.OWPlusForwardFailCount[targetLocType] = (aiBrain.OWPlusForwardFailCount[targetLocType] or 0) + 1
                LOG('[OWPlus] OWPlusDispersedBuildAI (' .. ownerName .. '): ' .. targetLocType .. ' fallimento #'
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
            end

            WaitSeconds(30)
            self:PlatoonDisband()
            return
        end
        LOG('[OWPlus] OWPlusDispersedBuildAI: OK, build avviato a ' .. tostring(targetLocType))
        self.ProcessBuildCommand(eng, false)

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
                            LOG('[OWPlus] Outpost: fabbrica (' .. tostring(u.UnitId) .. ') a ' .. targetLocType
                                .. ' staccata dal manager "' .. tostring(oldLocType) .. '"')
                        end
                        OWPlusManagerLoader.AddFactoryToClosestManager(aiBrain, u)
                        LOG('[OWPlus] Outpost: prima fabbrica (' .. tostring(u.UnitId) .. ') a ' .. targetLocType
                            .. ' registrata in un BuilderManager reale')
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
                local guardUnits = aiBrain:GetUnitsAroundPoint(categories.STRUCTURE * categories.FACTORY, outpostPos, 20, 'Ally') or {}
                if table.getn(guardUnits) == 0 then
                    LOG('[OWPlus] Outpost watcher (' .. outpostKey .. '): nessuna fabbrica trovata dopo 90s, sorveglianza annullata')
                    return
                end
                LOG('[OWPlus] Outpost watcher (' .. outpostKey .. '): OK, sorveglianza avviata su ' .. table.getn(guardUnits) .. ' fabbriche')

                while true do
                    WaitSeconds(30)
                    local anyAlive = false
                    for _, u in guardUnits do
                        if not u.Dead then
                            anyAlive = true
                            break
                        end
                    end
                    if not anyAlive then
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
        end
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
