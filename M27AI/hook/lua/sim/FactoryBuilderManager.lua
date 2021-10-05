local M27Logic = import('/mods/M27AI/lua/AI/M27GeneralLogic.lua')

M27FactoryBuilderManager = FactoryBuilderManager
FactoryBuilderManager = Class(M27FactoryBuilderManager) {
    FactoryFinishBuilding = function(self,factory,finishedUnit)
        if not self.Brain.M27AI then
            M27FactoryBuilderManager.FactoryFinishBuilding(self,factory,finishedUnit)
        else
            local bDebugMessages = false
            --Custom code extract: Add in cumulative unit count tracking here:
            local aiBrain = self.Brain
            local sUnitID = finishedUnit:GetUnitId()
            if aiBrain.M27LifetimeUnitCount == nil then aiBrain.M27LifetimeUnitCount = {} end
            if aiBrain.M27LifetimeUnitCount[sUnitID] == nil then aiBrain.M27LifetimeUnitCount[sUnitID] = 0 end
            aiBrain.M27LifetimeUnitCount[sUnitID] = aiBrain.M27LifetimeUnitCount[sUnitID] + 1
            if bDebugMessages == true then LOG('FactoryFinishBuilding: sUnitID='..sUnitID..'; M27LifetimeUnitCount='..aiBrain.M27LifetimeUnitCount[sUnitID]) end



            if EntityCategoryContains(categories.ENGINEER, finishedUnit) then
                self.Brain.BuilderManagers[self.LocationType].EngineerManager:AddUnit(finishedUnit)
            elseif EntityCategoryContains(categories.FACTORY, finishedUnit) then
                self:AddFactory(finishedUnit)
            end
            self:AssignBuildOrder(factory, factory.BuilderManagerData.BuilderType)
        end
    end,

    SetRallyPoint = function(self, factory)
        local M27bDebugMessages = false
        if M27bDebugMessages == true then LOG('SetRallyPoint: Hook start') end

        if not self.Brain.M27AI then
            if M27bDebugMessages == true then LOG('SetRallyPoint: Not using M27AI') end
            M27FactoryBuilderManager.SetRallyPoint(self, factory)
        else
            if M27bDebugMessages == true then LOG('SetRallyPoint: About to run custom code to set rallypoint') end
            M27Logic.SetFactoryRallyPoint(factory)
        end
    end,
    --RallyPointMonitor = function(self)
        --if not self.Brain.M27AI then
            --LOG('RallyPointMonitor: Not using M27AI')
            --return M27FactoryBuilderManager.RallyPointMonitor(self)
        --else
            --LOG('RallyPointMonitor: Using M27AI')
        --end
    --end,


}