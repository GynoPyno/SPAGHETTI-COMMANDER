
local AStructureUnit = import('/lua/aeonunits.lua').AStructureUnit
local DeathNukeWeapon = import('/lua/sim/defaultweapons.lua').QuantumDeathWeapon

ION5025 = Class(AStructureUnit) {

    Weapons = {
        DeathWeapon = Class(DeathNukeWeapon) {},
    },

    OnCreate = function(self)
        AStructureUnit.OnCreate(self)
        self.Open = false
        self.AnimManip = CreateAnimator(self)
        self.Trash:Add(self.AnimManip)
    end,

    OnStopBeingBuilt = function(self,builder,layer)
        AStructureUnit.OnStopBeingBuilt(self,builder,layer)
        self.Rotator = CreateRotator(self, 'Axis', 'z', nil, 0, 50, 0)
        self.Rotator:SetSpinDown(false)
        self.Trash:Add(self.Rotator)
        ChangeState(self, self.ActiveState)
    end,

    ActiveState = State {
        Main = function(self)
            self:PlayUnitAmbientSound( 'ActiveLoop' )
            if not self.Open then
                self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationOpen):SetRate(1)
                self.Open = true
                WaitFor(self.AnimManip)
            end
            if not self.AmbientEffects then
                self.AmbientEffects = CreateEmitterAtEntity(self, self:GetArmy(), '/effects/emitters/aeon_t1_massfab_ambient_01_emit.bp'):ScaleEmitter(6)
                self.Trash:Add(self.AmbientEffects)
            end
            while not self.Dead do
                self.Rotator:SetTargetSpeed(Random(120,300))    WaitFor(self.Rotator)
                self.Rotator:SetTargetSpeed(0)                  WaitFor(self.Rotator)
                self.Rotator:SetTargetSpeed(-Random(120,300))   WaitFor(self.Rotator)
                self.Rotator:SetTargetSpeed(0)                  WaitFor(self.Rotator)
            end
        end,
    },

    InActiveState = State {
        Main = function(self)
            self:StopUnitAmbientSound( 'ActiveLoop' )
            if self.AmbientEffects then
                self.AmbientEffects:Destroy()
                self.AmbientEffects = nil
            end
            if self.Open then
                self.Rotator:SetTargetSpeed(0)
                WaitFor(self.Rotator)
                self.AnimManip:SetRate(-1)
                self.Open = false
                WaitFor(self.AnimManip)
            end
        end,

    },

    OnProductionPaused = function(self)
        if self:GetAIBrain().BrainType ~= 'Human' then
            return
        end
        AStructureUnit.OnProductionPaused(self)
        ChangeState(self, self.InActiveState)
    end,

    OnProductionUnpaused = function(self)
        AStructureUnit.OnProductionUnpaused(self)
        ChangeState(self, self.ActiveState)
    end,
}

TypeClass = ION5025