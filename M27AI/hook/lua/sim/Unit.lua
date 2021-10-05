
M27Unit = Unit
Unit = Class(M27Unit) {
    --[[CreateEnhancementEffects = function(self, enhancement)
        local bp = self:GetBlueprint().Enhancements[enhancement]
        local effects = TrashBag()
        local bpTime = bp.BuildTime
        local bpBuildCostEnergy = bp.BuildCostEnergy
        if bpTime == nil then LOG('ERROR: CreateEnhancementEffects: bp.bpTime is nil; bp='..self:GetBlueprint().BlueprintId)
            bpTime = 1 end --Avoid infinite loop
        if bpBuildCostEnergy == nil then
            LOG('ERROR: CreateEnhancementEffects: bp.BuildCostEnergy is nil; bp='..self:GetBlueprint().BlueprintId)
            bpBuildCostEnergy = 1 end
        local scale = math.min(4, math.max(1, (bpBuildCostEnergy / bpTime or 1) / 50))

        if bp.UpgradeEffectBones then
            for _, v in bp.UpgradeEffectBones do
                if self:IsValidBone(v) then
                    EffectUtilities.CreateEnhancementEffectAtBone(self, v, self.UpgradeEffectsBag)
                end
            end
        end

        if bp.UpgradeUnitAmbientBones then
            for _, v in bp.UpgradeUnitAmbientBones do
                if self:IsValidBone(v) then
                    EffectUtilities.CreateEnhancementUnitAmbient(self, v, self.UpgradeEffectsBag)
                end
            end
        end

        for _, e in effects do
            e:ScaleEmitter(scale)
            self.UpgradeEffectsBag:Add(e)
        end
    end, ]]--

}