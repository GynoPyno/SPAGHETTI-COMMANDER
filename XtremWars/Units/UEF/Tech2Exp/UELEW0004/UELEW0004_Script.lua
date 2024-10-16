#****************************************************************************
#**
#**  File     :  /cdimage/units/UEL0303/UEL0303_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**
#**  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TWalkingLandUnit = import('/lua/terranunits.lua').TWalkingLandUnit
local TDFIonizedPlasmaCannon = import('/lua/terranweapons.lua').TDFIonizedPlasmaCannon
local TAAGinsuRapidPulseWeapon = import('/lua/terranweapons.lua').TAAGinsuRapidPulseWeapon
local TIFCruiseMissileUnpackingLauncher = import('/lua/terranweapons.lua').TIFCruiseMissileUnpackingLauncher

UELEW0004 = Class(TWalkingLandUnit) {

    Weapons = {
		PlasmaCannon01 = Class(TDFIonizedPlasmaCannon) {},
		RightBeam = Class(TAAGinsuRapidPulseWeapon) {},
        LeftBeam = Class(TAAGinsuRapidPulseWeapon) {},
        MissileWeapon01 = Class(TIFCruiseMissileUnpackingLauncher) 
        {
            FxMuzzleFlash = {'/effects/emitters/terran_mobile_missile_launch_01_emit.bp'},
            
            
            OnLostTarget = function(self)
                self:ForkThread( self.LostTargetThread )
            end,
            
            RackSalvoFiringState = State(TIFCruiseMissileUnpackingLauncher.RackSalvoFiringState) {
                OnLostTarget = function(self)
                    self:ForkThread( self.LostTargetThread )
                end,            
            },            

            LostTargetThread = function(self)
                while not self.unit.Dead and self.unit:IsUnitState('Busy') do
                    WaitSeconds(2)
                end

                if self.unit.Dead then
                    return
                end
                
                local bp = self:GetBlueprint()

                if bp.WeaponUnpacks then
                    ChangeState(self, self.WeaponPackingState)
                else
                    ChangeState(self, self.IdleState)
                end
            end,
        },
		MissileWeapon02 = Class(TIFCruiseMissileUnpackingLauncher) 
        {
            FxMuzzleFlash = {'/effects/emitters/terran_mobile_missile_launch_01_emit.bp'},
            
            
            OnLostTarget = function(self)
                self:ForkThread( self.LostTargetThread )
            end,
            
            RackSalvoFiringState = State(TIFCruiseMissileUnpackingLauncher.RackSalvoFiringState) {
                OnLostTarget = function(self)
                    self:ForkThread( self.LostTargetThread )
                end,            
            },            

            LostTargetThread = function(self)
                while not self.unit.Dead and self.unit:IsUnitState('Busy') do
                    WaitSeconds(2)
                end

                if self.unit.Dead then
                    return
                end
                
                local bp = self:GetBlueprint()

                if bp.WeaponUnpacks then
                    ChangeState(self, self.WeaponPackingState)
                else
                    ChangeState(self, self.IdleState)
                end
            end,
        },
    },
    
}

TypeClass = UELEW0004