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
        if targetLocType then
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
        for _, buildType in cons.BuildStructures do
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

        if not eng.Dead and not eng:IsUnitState('Building') then
            -- Fase 9-F12: nome army nei log per distinguere piu' AI in parallelo.
            local ownerName = (ArmyBrains[aiBrain:GetArmyIndex()] and ArmyBrains[aiBrain:GetArmyIndex()].Nickname) or tostring(aiBrain:GetArmyIndex())

            -- FindPlaceToBuild fallito: terreno non valido alla sub-location.
            -- Attendi 30s prima di disbandare per evitare spam di retry (~10/s → 1/30s).
            LOG('[OWPlus] OWPlusDispersedBuildAI (' .. ownerName .. '): ' .. tostring(targetLocType)
                .. ' terreno non valido, throttle 30s')

            -- Fase 9-F11: reroll per gli slot forward base (FWD1-4). Dopo 3
            -- fallimenti consecutivi (~90s) sullo stesso slot, lo liberiamo cosi'
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
            if targetLocType and (string.sub(targetLocType, 1, 3) == 'FWD' or string.sub(targetLocType, 1, 5) == 'BASE_') then
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
    end,
}
