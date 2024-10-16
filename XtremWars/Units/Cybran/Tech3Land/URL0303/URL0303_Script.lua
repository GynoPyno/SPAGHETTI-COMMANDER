#****************************************************************************
#**
#**  File     :  /cdimage/units/URL0303/URL0303_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Cybran Siege Assault Bot Script
#**
#**  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local CWalkingLandUnit = import( '/lua/cybranunits.lua').CWalkingLandUnit
local Weapon = import('/lua/sim/Weapon.lua').Weapon
local cWeapons = import('/lua/cybranweapons.lua')
local CDFLaserDisintegratorWeapon = cWeapons.CDFLaserDisintegratorWeapon01
local CDFElectronBolterWeapon = cWeapons.CDFElectronBolterWeapon

local EMPDeathWeapon = Class(Weapon) {
    OnCreate = function(self)
        Weapon.OnCreate(self)
        self:SetWeaponEnabled(false)
    end,

    OnFire = function(self)
        local blueprint = self:GetBlueprint()
        DamageArea(self.unit, self.unit:GetPosition(), blueprint.DamageRadius,
                   blueprint.Damage, blueprint.DamageType, blueprint.DamageFriendly)
    end,
}

URL0303 = Class(CWalkingLandUnit) {
    PlayEndAnimDestructionEffects = false,

    Weapons = {
        Disintigrator = Class(CDFLaserDisintegratorWeapon) {},
       
        EMP = Class(EMPDeathWeapon) {},
		###UPGRADE02
		DisintigratorII = Class(CDFLaserDisintegratorWeapon) {},
		###UPGRADE03
		HeavyBolterI = Class(CDFElectronBolterWeapon) {
			OnCreate = function(self)
                CDFElectronBolterWeapon.OnCreate(self)
                #Disable buff 
                self:DisableBuff('STUN')
            end,
		},
		HeavyBolterII = Class(CDFElectronBolterWeapon) {
			OnCreate = function(self)
                CDFElectronBolterWeapon.OnCreate(self)
                #Disable buff 
                self:DisableBuff('STUN')
            end,
		},
    },
    
	OnCreate = function(self)
        CWalkingLandUnit.OnCreate(self)
		
    end,	
	
	
    
	
    OnKilled = function(self, instigator, type, overkillRatio)
        local emp = self:GetWeaponByLabel('EMP')
        local bp
        for k, v in self:GetBlueprint().Buffs do
            if v.Add.OnDeath then
                bp = v
            end
        end
        #if we could find a blueprint with v.Add.OnDeath, then add the buff 
        if bp != nil then 
            #Apply Buff
			self:AddBuff(bp)
        end
        #otherwise, we should finish killing the unit
           
		if self.UnitComplete then
            # Play EMP Effect
            CreateLightParticle( self, -1, -1, 24, 62, 'flare_lens_add_02', 'ramp_red_10' )
            # Fire EMP weapon
            emp:SetWeaponEnabled(true)
            emp:OnFire()
        end		
        CWalkingLandUnit.OnKilled(self, instigator, type, overkillRatio)
    end,
}

TypeClass = URL0303