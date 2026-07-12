-- Brain class per OverwhelmPlus.
-- Estende uveso-ai.AIBrain e imposta self.Uveso = true per le nostre personality custom,
-- che non contengono "uveso" nel nome e non passerebbero il check in OnCreateAI di uveso-ai.lua.
-- Fa anche il monkey-patch di GetScoutTable via pcall per silenziare il crash nil/sort.

local UvesoAIBrainClass = import('/mods/AI-Uveso/lua/ai/uveso-ai.lua').AIBrain
local OWPlusOutpostGen = import('/mods/AI-Uveso-child/lua/AI/OWPlusOutpostGenerator.lua')

-- Fase 9-F13: cerca un punto valido lungo la diagonale (segnoX, segnoZ) partendo
-- da (startX, startZ), provando piu' distanze finche' il terreno non supera il check
-- (stesso usato in ExpansionFunction: divergenza surfaceHeight/terrainHeight <= 0.5).
-- Necessario perche' l'offset fisso originale (d=46, nessun check) falliva il 100%
-- delle volte su Setons/scmp_009 per entrambe le AI, per tutta la partita — la
-- diagonale cadeva ripetutamente in acqua/terreno irregolare senza alcun fallback.
local function OWPlusFindValidDispersedOffset(startX, startZ, signX, signZ)
    local distances = {46, 30, 60, 20, 76, 90}
    for _, d in distances do
        local x = startX + signX * d
        local z = startZ + signZ * d
        local terrainH = GetTerrainHeight(x, z)
        local surfaceH = GetSurfaceHeight(x, z)
        if math.abs(surfaceH - terrainH) <= 0.5 then
            return { x, surfaceH, z }
        end
    end
    return nil
end

local function PatchGetScoutTable()
    local mod = import('/mods/AI-Uveso/lua/AI/AITargetManager.lua')
    -- rawget bypassa __index del modulo (strict mode FAF) per campi inesistenti
    if not mod or rawget(mod, '_scoutTablePatched') then return end
    mod._scoutTablePatched = true
    local origGetScoutTable = mod.GetScoutTable
    -- Wrap con pcall: l'originale ha HeatMap nel closure, pcall cattura il crash nil/sort
    -- e restituisce liste vuote anziche propagare l'errore.
    mod.GetScoutTable = function(armyIndex)
        local ok, highList, lowList = pcall(origGetScoutTable, armyIndex)
        if ok then
            return highList, lowList
        end
        return {}, {}
    end
end


AIBrain = Class(UvesoAIBrainClass) {

    OnCreateAI = function(self, planName)
        UvesoAIBrainClass.OnCreateAI(self, planName)
        local per = ScenarioInfo.ArmySetup[self.Name].AIPersonality
        if per == 'overwhelmplus' or per == 'overwhelmpluscheat' then
            self.Uveso = true
        end
        -- FAF platoon-adaptive-reclaim.lua usa questi campi senza nil-guard.
        -- I brain FAF standard li inizializzano in OnCreateAI; uveso-ai.lua non lo fa.
        self.ReclaimFailCounter = 0
        self.ReclaimFailTimeStamp = 0
        PatchGetScoutTable()
        LOG('[overwhelmplusai] OnCreateAI: debug thread rimosso, OK')
        -- Memorizza le 4 sub-location diagonali in OWPlusSubBases (tabella custom sul brain).
        -- NON usare AddBuilderManagers: DeadBaseMonitor rimuove dopo 5s ogni manager non-MAIN
        -- che non ha ingegneri né fabbriche — le nostre sub-location vuote verrebbero eliminate.
        -- OWPlusDispersedBuildAI legge da aiBrain.OWPlusSubBases[locType] direttamente.
        local startX, startZ = self:GetArmyStartPos()
        self.OWPlusSubBases = {}
        local diagonals = {
            BASE_NE = { 1, -1 },
            BASE_SE = { 1, 1 },
            BASE_SW = { -1, 1 },
            BASE_NW = { -1, -1 },
        }
        for name, signs in diagonals do
            local pos = OWPlusFindValidDispersedOffset(startX, startZ, signs[1], signs[2])
            if pos then
                self.OWPlusSubBases[name] = pos
                LOG('[OWPlus] OWPlusSubBases: ' .. name .. string.format(' = (%.0f, %.0f, %.0f)', pos[1], pos[2], pos[3]))
            else
                LOG('[OWPlus] OWPlusSubBases: ' .. name .. ' nessuna distanza valida trovata (terreno non valido su tutte le prove), slot non impostato')
            end
        end

        -- Fase 9-F18: thread avamposti, forkato dall'aiBrain (sopravvive per tutta
        -- la partita, stesso pattern di PriorityManagerThread/LocationRangeManagerThread
        -- di Uveso in aiarchetype-managerloader.lua — MAI forkare da un platoon/unita',
        -- che muore quando quell'oggetto viene distrutto/disbandato).
        self:ForkThread(OWPlusOutpostGen.OWPlusOutpostScanThread)
    end,

    -- Fix sess.77: root cause reale del "buco nero" post tier-up inseguito per
    -- tutta la sessione B16. DeadBaseMonitor (ereditato da /lua/aibrains/base-ai.lua,
    -- la classe che uveso-ai.lua estende — verificato leggendo la catena di
    -- ereditarieta' reale, non assunto) distrugge ogni BuilderManager non-MAIN
    -- privo di ingegneri E fabbriche ogni 5s. Durante un upgrade fabbrica esiste
    -- una finestra reale (vecchia entita' T-inferiore gia' .Dead, nuova non
    -- ancora ri-registrata nel FactoryList) in cui il manager di un avamposto
    -- risulta "vuoto" e viene cancellato — confermato in game con diagnostica
    -- dedicata (dump FactoryList al salto di tier + heartbeat 15s): il manager
    -- spariva esattamente al tier-up e non tornava mai piu' per il resto della
    -- partita, bloccando tutta la valutazione builder per quella location.
    --
    -- DeadBaseMonitor e' un ciclo `while true` autosufficiente, non compone con
    -- un override parziale (non c'e' un punto dove richiamare l'originale e poi
    -- continuare) — a differenza della regola 1 (mai copiare funzioni vanilla
    -- ridondanti), qui la sostituzione integrale e' l'unica via strutturale.
    -- Unica modifica rispetto all'originale (base-ai.lua riga ~414): esclude
    -- anche i manager registrati in self.OWPlusOutpostLocationTypes (whitelist
    -- per posizione, stesso principio gia' usato in AddGlobalBaseTemplate,
    -- hook/lua/AI/AIAddBuilderTable.lua). Il rescue-watcher reattivo in
    -- hook/lua/platoon.lua resta come rete di sicurezza per casi imprevisti,
    -- ma con questo fix non dovrebbe piu' scattare in condizioni normali.
    DeadBaseMonitor = function(self)
        while true do
            WaitSeconds(5)
            local needSort = false
            for k, v in self.BuilderManagers do
                if k ~= 'MAIN'
                    and not (self.OWPlusOutpostLocationTypes and self.OWPlusOutpostLocationTypes[k])
                    and v.EngineerManager:GetNumCategoryUnits('Engineers', categories.ALLUNITS) <= 0
                    and v.FactoryManager:GetNumCategoryFactories(categories.ALLUNITS) <= 0 then
                    v.EngineerManager:SetEnabled(false)
                    v.EngineerManager:Destroy()
                    v.FactoryManager:SetEnabled(false)
                    v.FactoryManager:Destroy()
                    v.PlatoonFormManager:SetEnabled(false)
                    v.PlatoonFormManager:Destroy()
                    self.BuilderManagers[k] = nil
                    self.NumBases = self.NumBases - 1
                    needSort = true
                end
            end
            if needSort then
                self.BuilderManagers = self:RebuildTable(self.BuilderManagers)
            end
        end
    end,

}
