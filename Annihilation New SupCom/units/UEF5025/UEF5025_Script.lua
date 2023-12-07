
local TStructureUnit = import('/lua/terranunits.lua').TStructureUnit
local DeathNukeWeapon = import('/lua/sim/defaultweapons.lua').QuantumDeathWeapon

UEF5025 = Class(TStructureUnit) {

    Weapons = {
        DeathWeapon = Class(DeathNukeWeapon) {},
    },
    
    DestructionPartsLowToss = {'B01','B02',},
    DestructionPartsChassisToss = {'UEB1104'},
    GoToActive = false,
    Closed = false,

    OnCreate = function(self)
        TStructureUnit.OnCreate(self)
        self.SliderManip = CreateSlider(self, 'B03')
        ChangeState(self, self.CreateState)
    end,

    CreateState = State {
        Main = function(self)
            self:HideBone('UEB1104', true)              --   This units default position is open,
            self.SliderManip:SetGoal(0,-1,0)            --   so we have to hide the bone, close the unit,
            self.SliderManip:SetSpeed(-1)               --   and then show the bone once its in its closed position.
            WaitFor(self.SliderManip)
            self:ShowBone('UEB1104', true)
            self.Closed = true
            if self.GoToActive == true then
                ChangeState(self, self.ActiveState)
            end
        end,
    },

    OnStopBeingBuilt = function(self,builder,layer)
        TStructureUnit.OnStopBeingBuilt(self,builder,layer)
        self.Rotator = CreateRotator(self, 'B01', 'y', nil, 0 , 50 , 0)
        self.Rotator:SetSpinDown(false)
        self.Trash:Add(self.Rotator)
        if self.Closed == true then                     --   Had enough time to go through the CreateState already.
            ChangeState(self, self.ActiveState)         --   Most likely created with an engineer
        else                                            --   else.... Created with F2
            self.GoToActive = true                      
            ChangeState(self, self.CreateState)
        end
    end,


    ActiveState = State {
        Main = function(self)
            self:PlayUnitAmbientSound( 'ActiveLoop' )
            -- Animate the 4 Arms up
            self.SliderManip:SetGoal(0,0,0)
            self.SliderManip:SetSpeed(3)
            WaitFor(self.SliderManip)
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
            -- Animate the 4 Arms down
            self.SliderManip:SetGoal(0,-1,0)
            self.SliderManip:SetSpeed(3)
            WaitFor(self.SliderManip)
        end,
    },

    OnProductionPaused = function(self)
        if self:GetAIBrain().BrainType ~= 'Human' then
            return
        end
        TStructureUnit.OnProductionPaused(self)
        ChangeState(self, self.InActiveState)
    end,
    
    OnProductionUnpaused = function(self)
        TStructureUnit.OnProductionUnpaused(self)
        ChangeState(self, self.ActiveState)
    end,
 }

TypeClass = UEF5025