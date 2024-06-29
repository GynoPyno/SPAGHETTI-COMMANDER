#****************************************************************************
#**
#**  File     :  /cdimage/units/URL0304/URL0304_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Cybran Heavy Mobile Artillery Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local CLandUnit = import('/lua/cybranunits.lua').CLandUnit
local CIFArtilleryWeapon = import('/lua/cybranweapons.lua').CIFArtilleryWeapon
local CIFMissileLoaWeapon = import('/lua/cybranweapons.lua').CIFMissileLoaWeapon

URL0304 = Class(CLandUnit) {
    Weapons = {
        MainGun = Class(CIFArtilleryWeapon) {
            FxMuzzleFlash = {
                '/effects/emitters/cybran_artillery_muzzle_flash_01_emit.bp',
                '/effects/emitters/cybran_artillery_muzzle_flash_02_emit.bp',
                '/effects/emitters/cybran_artillery_muzzle_smoke_01_emit.bp',
            },
        },
		ArtyII = Class(CIFArtilleryWeapon) {
            FxMuzzleFlash = {
                '/effects/emitters/cybran_artillery_muzzle_flash_01_emit.bp',
                '/effects/emitters/cybran_artillery_muzzle_flash_02_emit.bp',
                '/effects/emitters/cybran_artillery_muzzle_smoke_01_emit.bp',
            },
        },
		GroundGunI = Class(CIFMissileLoaWeapon) {
			OnCreate = function(self)
                CIFMissileLoaWeapon.OnCreate(self)
                #Disable buff 
                self:DisableBuff('STUN')
            end,
		},
		GroundGunII = Class(CIFMissileLoaWeapon) {
			OnCreate = function(self)
                CIFMissileLoaWeapon.OnCreate(self)
                #Disable buff 
                self:DisableBuff('STUN')
            end,
		},
		
    },
	
	OnCreate = function(self)
        CLandUnit.OnCreate(self)

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
        CLandUnit.OnKilled(self, instigator, type, overkillRatio)
    end,	
	
}

TypeClass = URL0304