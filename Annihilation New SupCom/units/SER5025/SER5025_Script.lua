
local SStructureUnit = import('/lua/seraphimunits.lua').SStructureUnit
local DeathNukeWeapon = import('/lua/sim/defaultweapons.lua').QuantumDeathWeapon

SER5025 = Class(SStructureUnit) {

    Weapons = {
        DeathWeapon = Class(DeathNukeWeapon) {},
    },

    OnStopBeingBuilt = function(self,builder,layer)
        SStructureUnit.OnStopBeingBuilt(self,builder,layer)
        self.Rotator = CreateRotator(self, 'Blades', 'y', nil, 0, 50, 0)
        self.Rotator:SetSpinDown(false)
        self.Trash:Add(self.Rotator)
        ChangeState(self, self.ActiveState)
    end,

    ActiveState = State {
        Main = function(self)
            self:PlayUnitAmbientSound( 'ActiveLoop' )
            -- Spin up the Rotator
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
            -- Spin down the Rotator
            self.Rotator:SetTargetSpeed(0)
            WaitFor(self.Rotator)
        end,
    },
    
    OnProductionPaused = function(self)
        if self:GetAIBrain().BrainType ~= 'Human' then
            return
        end
        SStructureUnit.OnProductionPaused(self)
        ChangeState(self, self.InActiveState)
    end,

    OnProductionUnpaused = function(self)
        SStructureUnit.OnProductionUnpaused(self)
        ChangeState(self, self.ActiveState)
    end,
}

TypeClass = SER5025