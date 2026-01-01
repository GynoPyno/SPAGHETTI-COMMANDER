#****************************************************************************
#**
#**  File     :  /data/units/XAA0305/XAA0305_script.lua
#**  Author(s):  Jessica St. Croix
#**
#**  Summary  :  Aeon AA Gunship Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local AAirUnit = import('/lua/aeonunits.lua').AAirUnit
local ADFLaserLightWeapon = import('/lua/aeonweapons.lua').ADFLaserLightWeapon
local ADFQuadLaserLightWeapon = import('/lua/aeonweapons.lua').ADFQuadLaserLightWeapon
local AAAZealot02MissileWeapon = import('/lua/aeonweapons.lua').AAAZealot02MissileWeapon

XAA0305 = Class(AAirUnit) {
    Weapons = {
        Turret2 = Class(ADFLaserLightWeapon) {
            FxChassisMuzzleFlash = {'/effects/emitters/aeon_gunship_body_illumination_01_emit.bp',},
            
            PlayFxMuzzleSequence = function(self, muzzle)
                local army = self.unit.Army
                for k, v in self.FxMuzzleFlash do
                    CreateAttachedEmitter(self.unit, muzzle, army, v)
                end

                for k, v in self.FxChassisMuzzleFlash do
                    CreateAttachedEmitter(self.unit, -1, army, v)
                end
            end,        
        },
        Turret3 = Class(ADFLaserLightWeapon) {
            FxChassisMuzzleFlash = {'/effects/emitters/aeon_gunship_body_illumination_01_emit.bp',},
            
            PlayFxMuzzleSequence = function(self, muzzle)
                local army = self.unit.Army
                for k, v in self.FxMuzzleFlash do
                    CreateAttachedEmitter(self.unit, muzzle, army, v)
                end

                for k, v in self.FxChassisMuzzleFlash do
                    CreateAttachedEmitter(self.unit, -1, army, v)
                end
            end,        
        },
		
        Turret = Class(import('/lua/aeonweapons.lua').ADFCannonOblivionWeapon) {
			FxMuzzleFlash = {
				'/effects/emitters/oblivion_cannon_flash_04_emit.bp',
				'/effects/emitters/oblivion_cannon_flash_05_emit.bp',				
				'/effects/emitters/oblivion_cannon_flash_06_emit.bp',
			},        
        },
		
        Turret4 = Class(ADFQuadLaserLightWeapon) {},
        Turret5 = Class(ADFQuadLaserLightWeapon) {},
		
        AAGun01 = Class(AAAZealot02MissileWeapon) {},
        AAGun02 = Class(AAAZealot02MissileWeapon) {},
		
    },
}

TypeClass = XAA0305