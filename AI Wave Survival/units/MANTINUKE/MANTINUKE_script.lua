#****************************************************************************
#**
#**  File     :  /units/XSL0307/XSL0307_script.lua
#**
#**  Summary  :  Seraphim Mobile Shield Generator Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local SShieldHoverLandUnit = import('/lua/seraphimunits.lua').SShieldHoverLandUnit
local SIFHuAntiNukeWeapon = import("/lua/seraphimweapons.lua").SIFHuAntiNukeWeapon
--local nukeFiredOnGotTarget = false

MANTINUKE = Class(SShieldHoverLandUnit) {

	Weapons = {
        MissileRack = ClassWeapon(SIFHuAntiNukeWeapon) {

            IdleState = State(SIFHuAntiNukeWeapon.IdleState) {

                OnGotTarget = function(self)
                    local bp = self.Blueprint
                    if (bp.WeaponUnpackLockMotion != true or (bp.WeaponUnpackLocksMotion == true and not self.unit:IsUnitState('Moving'))) then
                        if (bp.CountedProjectile == false) or self:CanFire() then
                             nukeFiredOnGotTarget = true
                        end
                    end
                    SIFHuAntiNukeWeapon.IdleState.OnGotTarget(self)
                end,

                OnFire = function(self)
                    if not nukeFiredOnGotTarget then
                        SIFHuAntiNukeWeapon.IdleState.OnFire(self)
                    end
                    nukeFiredOnGotTarget = false

                    self.Trash:Add(ForkThread(function()
                        self.unit:SetBusy(true)
                        WaitSeconds(1/self.unit.Blueprint.Weapon[1].RateOfFire + .2)
                        self.unit:SetBusy(false)
                    end,self))
                end,
            },
		},
	},
	
    --[[ShieldEffects = {
        '/effects/emitters/aeon_shield_generator_mobile_01_emit.bp',
    },]]--
    
    --[[OnStopBeingBuilt = function(self,builder,layer)
        IssueSiloBuildTactical(self)
    end,]]--
    
    --[[OnShieldEnabled = function(self)
        SShieldHoverLandUnit.OnShieldEnabled(self)
                
        if self.ShieldEffectsBag then
            for k, v in self.ShieldEffectsBag do
                v:Destroy()
            end
		    self.ShieldEffectsBag = {}
		end
        for k, v in self.ShieldEffects do
            table.insert( self.ShieldEffectsBag, CreateAttachedEmitter( self, 0, self:GetArmy(), v ) )
        end
    end,]]--

    --[[OnShieldDisabled = function(self)
        SShieldHoverLandUnit.OnShieldDisabled(self)
         
        if self.ShieldEffectsBag then
            for k, v in self.ShieldEffectsBag do
                v:Destroy()
            end
		    self.ShieldEffectsBag = {}
		end
    end,]]--


}

TypeClass = MANTINUKE
