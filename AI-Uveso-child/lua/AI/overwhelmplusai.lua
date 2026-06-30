-- Brain class per OverwhelmPlus.
-- Estende uveso-ai.AIBrain e imposta self.Uveso = true per le nostre personality custom,
-- che non contengono "uveso" nel nome e non passerebbero il check in OnCreateAI di uveso-ai.lua.
-- Fa anche il monkey-patch di GetScoutTable via pcall per silenziare il crash nil/sort.

local UvesoAIBrainClass = import('/mods/AI-Uveso/lua/ai/uveso-ai.lua').AIBrain

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
        local d = 46
        self.OWPlusSubBases = {
            BASE_NE = {startX + d, 0, startZ - d},
            BASE_SE = {startX + d, 0, startZ + d},
            BASE_SW = {startX - d, 0, startZ + d},
            BASE_NW = {startX - d, 0, startZ - d},
        }
        for name, pos in self.OWPlusSubBases do
            pos[2] = GetSurfaceHeight(pos[1], pos[3])
            LOG('[OWPlus] OWPlusSubBases: ' .. name .. string.format(' = (%.0f, %.0f, %.0f)', pos[1], pos[2], pos[3]))
        end
    end,

}
