#****************************************************************************
#**
#**  File     :  /cdimage/units/URB2302/URB2302_script.lua
#**  Author(s):  John Comes, David Tomandl
#**
#**  Summary  :  Cybran Long Range Artillery Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local EffectTemplate = import('/lua/EffectTemplates.lua')
local CStructureUnit = import('/lua/cybranunits.lua').CStructureUnit
local CIFArtilleryWeapon = import('/lua/cybranweapons.lua').CIFArtilleryWeapon
local DefaultProjectileWeapon = import('/lua/sim/DefaultWeapons.lua').DefaultProjectileWeapon

WRB2302 = Class(CStructureUnit) {
    Weapons = {
        MainGun = Class(CIFArtilleryWeapon) {
            FxMuzzleFlashScale = 0.6,
            FxGroundEffect = EffectTemplate.CDisruptorGroundEffect,
	        FxVentEffect = EffectTemplate.CDisruptorVentEffect,
	        FxMuzzleEffect = EffectTemplate.CElectronBolterMuzzleFlash01,
	        FxCoolDownEffect = EffectTemplate.CDisruptorCoolDownEffect,
    

	        PlayFxMuzzleSequence = function(self, muzzle)
		        local army = self.unit:GetArmy()
		        DefaultProjectileWeapon.PlayFxMuzzleSequence(self, muzzle)
	            for k, v in self.FxGroundEffect do
                    CreateAttachedEmitter(self.unit, 'WRB2302', army, v)
                end
  	            for k, v in self.FxVentEffect do
                    CreateAttachedEmitter(self.unit, 'Muzzle', army, v)
                    CreateAttachedEmitter(self.unit, 'Muzzle', army, v)
                end
  	            for k, v in self.FxMuzzleEffect do
                    CreateAttachedEmitter(self.unit, 'Muzzle', army, v)
                end
  	            for k, v in self.FxCoolDownEffect do
                    CreateAttachedEmitter(self.unit, 'Turret_Recoil', army, v)
                end
            end,
        }
    },
}

TypeClass = WRB2302