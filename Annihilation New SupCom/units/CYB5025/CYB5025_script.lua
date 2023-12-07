
local CStructureUnit = import('/lua/cybranunits.lua').CStructureUnit
local DeathNukeWeapon = import('/lua/sim/defaultweapons.lua').QuantumDeathWeapon

CYB5025 = Class(CStructureUnit) {

    Weapons = {
        DeathWeapon = Class(DeathNukeWeapon) {},
    },
    DestructionPartsLowToss = {'Blade',},

    OnStopBeingBuilt = function(self,builder,layer)
        CStructureUnit.OnStopBeingBuilt(self,builder,layer)
        self.Rotator = CreateRotator(self, 'Blade', 'z', nil, 0 , 50 , 0)
        self.Rotator:SetSpinDown(false)
        self.Trash:Add(self.Rotator)
        ChangeState(self, self.ActiveState)
    end,

    ActiveState = State {
        Main = function(self)
            -- Spin up the Rotator
            self:PlayUnitAmbientSound( 'ActiveLoop' )
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
        CStructureUnit.OnProductionPaused(self)
        ChangeState(self, self.InActiveState)
    end,

    OnProductionUnpaused = function(self)
        CStructureUnit.OnProductionUnpaused(self)
        ChangeState(self, self.ActiveState)
    end,
}

TypeClass = CYB5025