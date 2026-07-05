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
            for _, t in recipe do table.insert(buildList, t) end
            for _, t in cons.BuildStructures do table.insert(buildList, t) end
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

        local factionLookup = { UEF = 1, AEON = 2, CYBRAN = 3, SERAPHIM = 4, NOMADS = 5 }
        local factionIndex = cons.FactionIndex or factionLookup[eng.factionCategory] or 1
        local buildingTmplFile = import(cons.BuildingTemplateFile or '/lua/BuildingTemplates.lua')
        local baseTmplFile = import(cons.BaseTemplateFile or '/lua/BaseTemplates.lua')
        local buildingTmpl = buildingTmplFile[(cons.BuildingTemplate or 'BuildingTemplates')][factionIndex]
        local baseTmpl = baseTmplFile[(cons.BaseTemplate or 'BaseTemplates')][factionIndex]
        local baseTmplAtTarget = AIBuildStructures.AIBuildBaseTemplateFromLocation(baseTmpl, targetPos)

        self.SetupEngineerCallbacks(eng)

        -- Costruisce vicino a targetPos.
        -- closeToBuilder=nil, reference=targetPos (tabella) → AIExecuteBuildStructure di Uveso
        -- entra nel branch "reference and type(reference)=='table'" → relativeTo = targetPos.
        for _, buildType in buildList do
            if aiBrain:PlatoonExists(self) and not eng.Dead then
                AIBuildStructures.AIExecuteBuildStructure(
                    aiBrain, eng, buildType,
                    nil,             -- closeToBuilder nil → non usa posizione eng
                    false,           -- relative false
                    buildingTmpl,
                    baseTmplAtTarget,
                    targetPos,       -- reference tabella → Uveso usa come centro di ricerca
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

        -- Fase 9-F19: per gli avamposti OUT#, cattura il riferimento alla PRIMA
        -- fabbrica costruita e la registra in un BuilderManager vero tramite
        -- AddFactoryToClosestManager (funzione globale di Uveso, aiarchetype-
        -- managerloader.lua) — crea il manager E aggiunge la fabbrica nello stesso
        -- istante, quindi DeadBaseMonitor non lo trova mai vuoto. Da quel momento
        -- i builder standard di Uveso (produzione ingegneri con gate di tech,
        -- upgrade fabbrica, difese) iniziano a funzionare su questa fabbrica senza
        -- bisogno di comandi grezzi scritti da noi (vedi B11, AI_Mod_Spec.md, per
        -- l'idea di unificare anche i nodi dispersi di MAIN a questo approccio).
        if targetLocType and string.sub(targetLocType, 1, 3) == 'OUT'
            and not (aiBrain.OWPlusOutpostFactories and aiBrain.OWPlusOutpostFactories[targetLocType]) then
            ForkThread(function()
                local waitedBuild = 0
                while eng and not eng.Dead and eng:IsUnitState('Building') and waitedBuild < 300 do
                    WaitSeconds(5)
                    waitedBuild = waitedBuild + 5
                end
                WaitSeconds(2)
                local nearby = aiBrain:GetUnitsAroundPoint(categories.STRUCTURE * categories.FACTORY, targetPos, 15, 'Ally')
                for _, u in nearby or {} do
                    if not u.Dead and not u.BuilderManagerData then
                        aiBrain.OWPlusOutpostFactories = aiBrain.OWPlusOutpostFactories or {}
                        aiBrain.OWPlusOutpostFactories[targetLocType] = u
                        AddFactoryToClosestManager(aiBrain, u)
                        LOG('[OWPlus] Outpost: prima fabbrica (' .. tostring(u.UnitId) .. ') a ' .. targetLocType
                            .. ' registrata in un BuilderManager reale')
                        break
                    end
                end
            end)
        end
    end,
}
