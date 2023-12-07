
-- TODO: This should be made more general and put in defaultunits.lua in case other factions get similar buildings
-- CConstructionStructureUnit
---@class CConstructionStructureUnit : CStructureUnit, CConstructionTemplate
CConstructionStructureUnit = ClassUnit(CStructureUnit, CConstructionTemplate) {

    ---@param self CConstructionStructureUnit
    OnCreate = function(self)

        -- Initialize the class
        CStructureUnit.OnCreate(self)
        CConstructionTemplate.OnCreate(self)

        local bp = self:GetBlueprint()

        -- Construction stuff
        if bp.General.BuildBones then
            self:SetupBuildBones()
        end

        -- Save build effect bones for faster access when creating build effects
        self.BuildEffectBones = bp.General.BuildBones.BuildEffectBones

        -- Set up building animation
        if bp.Display.AnimationOpen then
            self.BuildingOpenAnim = bp.Display.AnimationOpen
        end

        self.AnimationManipulator = CreateAnimator(self)
        self.Trash:Add(self.AnimationManipulator)

        self.BuildingUnit = false
    end,

    ---@param self CConstructionStructureUnit
    DestroyAllBuildEffects = function(self)
        CStructureUnit.DestroyAllBuildEffects(self)
        CConstructionTemplate.DestroyAllBuildEffects(self)
    end,

    ---@param self CConstructionStructureUnit
    ---@param built boolean
    StopBuildingEffects = function(self, built)
        CStructureUnit.StopBuildingEffects(self, built)
        CConstructionTemplate.StopBuildingEffects(self, built)
    end,

    ---@param self CConstructionStructureUnit
    OnPaused = function(self)
        CStructureUnit.OnPaused(self)
        CStructureUnit.StopBuildingEffects(self, self.UnitBeingBuilt)
        CConstructionTemplate.OnPaused(self, 0)

        self.AnimationManipulator:SetRate(-0.25)
    end,

    ---@param self CConstructionStructureUnit
    OnUnpaused = function(self)
        CStructureUnit.OnUnpaused(self)

        -- make sure the unit is still there
        local unitBeingBuilt = self.UnitBeingBuilt
        if unitBeingBuilt then 
            CStructureUnit.StartBuildingEffects(self, unitBeingBuilt, self.UnitBuildOrder)
            self.AnimationManipulator:SetRate(1)
        end
    end,

    ---@param self CConstructionStructureUnit
    ---@param unitBeingBuilt Unit
    ---@param order string
    CreateBuildEffects = function(self, unitBeingBuilt, order)
        CConstructionTemplate.CreateBuildEffects(self, self.UnitBeingBuilt, self.UnitBuildOrder, true)
    end,

    ---@param self CConstructionStructureUnit
    OnDestroy = function(self) 
        CStructureUnit.OnDestroy(self)
        CConstructionTemplate.OnDestroy(self)
    end,

    ---@param self CConstructionStructureUnit
    ---@param unitBeingBuilt Unit
    ---@param order string
    OnStartBuild = function(self, unitBeingBuilt, order)
        CStructureUnit.OnStartBuild(self, unitBeingBuilt, order)

        -- play animation of the hive opening
        self.AnimationManipulator:PlayAnim(self.BuildingOpenAnim, false)

        -- keep track of who we are building
        self.UnitBeingBuilt = unitBeingBuilt
        self.UnitBuildOrder = order
        self.BuildingUnit = true
    end,

    ---@param self CConstructionStructureUnit
    ---@param builder Unit
    ---@param layer Layer
    OnStopBeingBuilt = function(self, builder, layer)
        CStructureUnit.OnStopBeingBuilt(self, builder, layer)

        -- If created with F2 on land, then play the transform anim.
        if self.Layer == 'Water' then
            self.TerrainLayerTransitionThread = self:ForkThread(self.TransformThread, true)
        end
    end,

    --- This will only be called if not in StructureUnit's upgrade state
    ---@param self CConstructionStructureUnit
    ---@param unitBeingBuilt Unit
    OnStopBuild = function(self, unitBeingBuilt)
        CStructureUnit.OnStopBuild(self, unitBeingBuilt)

        -- revert animation
        self.AnimationManipulator:SetRate(-0.25)

        -- lose track of who we are building
        self.UnitBeingBuilt = nil
        self.UnitBuildOrder = nil
        self.BuildingUnit = false
    end,

    ---@param self CConstructionStructureUnit
    OnProductionPaused = function(self)
        if self:IsUnitState('Building') then
            self:SetMaintenanceConsumptionInactive()
        end
        self:SetProductionActive(false)
    end,

    ---@param self CConstructionStructureUnit
    OnProductionUnpaused = function(self)
        if self:IsUnitState('Building') then
            self:SetMaintenanceConsumptionActive()
        end
        self:SetProductionActive(true)
    end,

    ---@param self CConstructionStructureUnit
    OnStopBuilderTracking = function(self)
        CStructureUnit.OnStopBuilderTracking(self)

        if self.StoppedBuilding then
            self.StoppedBuilding = false
            self.BuildArmManipulator:Disable()
            self.BuildingOpenAnimManip:SetRate(-(self:GetBlueprint().Display.AnimationBuildRate or 1))
        end
    end,

    ---@param self CConstructionStructureUnit
    ---@param target_bp UnitBlueprint
    ---@return boolean
    CheckBuildRestriction = function(self, target_bp)
        if self:CanBuild(target_bp.BlueprintId) then
            return true
        else
            return false
        end
    end,
}
