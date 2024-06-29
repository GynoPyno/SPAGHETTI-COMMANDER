#****************************************************************************
#**
#**  File     :  /units/URL0311/URL0311_script.lua
#**  Author(s):  Dru Staltman, Eric Williamson, Gordon Duclos
#**					Modified by Asdrubaelvect
#**  Summary  :  Cybran Missile TEch3 Bot Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local CWalkingLandUnit = import( '/lua/cybranunits.lua').CWalkingLandUnit
local CDFRocketIridiumWeapon02 = import('/lua/cybranweapons.lua').CDFRocketIridiumWeapon02

URL0311 = Class(CWalkingLandUnit) {
    Weapons = {
        CruiseMissile = Class(CDFRocketIridiumWeapon02) {
			OnCreate = function(self)
                CDFRocketIridiumWeapon02.OnCreate(self)
                #Disable buff 
                self:DisableBuff('STUN')
            end,
		},
		####UPGRADE02
		CruiseMissile02 = Class(CDFRocketIridiumWeapon02) {},
		####UPGRADE02
		CruiseMissile03  = Class(CDFRocketIridiumWeapon02) {
			OnCreate = function(self)
                CDFRocketIridiumWeapon02.OnCreate(self)
                #Disable buff 
                self:DisableBuff('STUN')
            end,
		},
		CruiseMissile04 = Class(CDFRocketIridiumWeapon02) {
			OnCreate = function(self)
                CDFRocketIridiumWeapon02.OnCreate(self)
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
TypeClass = URL0311

