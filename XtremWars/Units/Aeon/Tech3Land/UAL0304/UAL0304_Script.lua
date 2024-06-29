#****************************************************************************
#**
#**  File     :  /cdimage/units/UAL0304/UAL0304_script.lua
#**  Author(s):  John Comes, David Tomandl
#**
#**  Summary  :  Aeon Heavy Mobile Artillery Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local ALandUnit = import( '/lua/aeonunits.lua').ALandUnit
local AIFArtillerySonanceShellWeapon = import('/lua/aeonweapons.lua').AIFArtillerySonanceShellWeapon
local ADFDisruptorCannonWeapon = import('/lua/aeonweapons.lua').ADFDisruptorWeapon

UAL0304 = Class(ALandUnit) {
    Weapons = {
        MainGun = Class(AIFArtillerySonanceShellWeapon) {
            FxMuzzleFlash = { 
                '/effects/emitters/aeon_heavy_artillery_flash_01_emit.bp', 
                '/effects/emitters/aeon_heavy_artillery_flash_02_emit.bp', 
            },
        },
		Upgrade02Weapon = Class(AIFArtillerySonanceShellWeapon) {
            FxMuzzleFlash = { 
                '/effects/emitters/aeon_heavy_artillery_flash_01_emit.bp', 
                '/effects/emitters/aeon_heavy_artillery_flash_02_emit.bp', 
            },
        },
		###UPGRADE3
		Upgrade03Weapon = Class(ADFDisruptorCannonWeapon) {
			CreateProjectileAtMuzzle = function(self, muzzle)
                local proj = ADFDisruptorCannonWeapon.CreateProjectileAtMuzzle(self, muzzle)
                local data = self:GetBlueprint().DamageToShields
                if proj and not proj:BeenDestroyed() then
                    proj:PassData(data)
                end
            end,
		},
    },
	
	OnCreate = function(self)
        ALandUnit.OnCreate(self)

    end,	

	
}

TypeClass = UAL0304