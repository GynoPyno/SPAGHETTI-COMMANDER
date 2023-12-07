#****************************************************************************
#**
#**  File     :  /cdimage/units/UAB1104/UAB1104_script.lua
#**  Author(s):  Jessica St. Croix, David Tomandl, John Comes
#**
#**  Summary  :  Aeon Mass Fabricator
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local ALandUnit = import('/lua/aeonunits.lua').ALandUnit
local AWeapons = import('/lua/aeonweapons.lua')
local ADFChronoDampener = import('/lua/aeonweapons.lua').ADFChronoDampener
local AAMWillOWisp = import('/lua/aeonweapons.lua').AAMWillOWisp

UAB1104 = Class(ALandUnit) {

    Weapons = {
        Inner = Class(AAMWillOWisp) {},
        Middle = Class(AAMWillOWisp) {},
        Outer = Class(AAMWillOWisp) {},
        ChronoDampener = Class(ADFChronoDampener) {},
    },

    OnCreate = function(self)
        ALandUnit.OnCreate(self)
        self.Damaged = false
        self.Open = false
        self.AnimFinished = true
        self.RotFinished = true
        self.Clockwise = true
        self.AnimManip = CreateAnimator(self)
        self.Trash:Add(self.AnimManip)
    end,

    OnStopBeingBuilt = function(self,builder,layer)
        ALandUnit.OnStopBeingBuilt(self,builder,layer)
        ChangeState(self, self.OpenState)

        local EfctTempl = {
            '/Mods/CalModA/units/aeon/T4 Radiation Weapon/effects/aeon_t1_massfab_ambient_01_emit.bp',
        }
        for k, v in EfctTempl do
            CreateAttachedEmitter(self, 'UAB1104', self.Army, v):ScaleEmitter(5.8)
        end
    end,

    OpenState = State {
        Main = function(self)
			
            if not self.Open then
                self.Open = true
                self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationOpen):SetRate(1)
                WaitFor(self.AnimManip)
            end
            if not self.Rotator then
                self.Rotator = CreateRotator(self, 'Axis', 'z', nil, 0, 50, 0)
                self.Trash:Add(self.Rotator)
            else
                self.Rotator:SetSpinDown(false)
            end
            self.Goal = Random(18,20)

            while not self:IsDead() do
                # spin clockwise
                if not self.Clockwise then
                    self.Rotator:SetTargetSpeed(self.Goal)
                    self.Clockwise = true
                else
                    self.Rotator:SetTargetSpeed(self.Goal)
                    self.Clockwise = true
                end
                WaitFor(self.Rotator)

                # slow down to change directions
                self.Rotator:SetTargetSpeed(19)
                WaitFor(self.Rotator)
                self.Rotator:SetSpeed(19)
                self.Goal = Random(18,20)
            end
        end,
    },
}

TypeClass = UAB1104