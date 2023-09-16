#****************************************************************************
#**
#**  File     :  /cdimage/units/URL0103/URL0103_script.lua
#**  Author(s):  John Comes, David Tomandl
#**			Model By Asdrubaelvect Script By Manimal For Experimental Wars 1.8
#**  Summary  :  Cybran Mobile Mortar Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit
local CybranWeaponsFile = import('/lua/cybranweapons.lua')
local CIFGrenadeWeapon = CybranWeaponsFile.CIFGrenadeWeapon
local CAANanoDartWeapon = CybranWeaponsFile.CAANanoDartWeapon

URL0103 = Class(CWalkingLandUnit) {
    DestructionTicks = 400,
	--DeathThreadDestructionWaitTime = 8,

    Weapons = {
        MainGun = Class(CIFGrenadeWeapon) {
            FxMuzzleFlash = {
                '/effects/emitters/cybran_artillery_muzzle_flash_01_emit.bp',
                '/effects/emitters/cybran_artillery_muzzle_flash_02_emit.bp',
                '/effects/emitters/cannon_muzzle_smoke_02_emit.bp',
            },
            FxMuzzleFlashScale = 0.5,
        },
#########UPGRADE03
        UpgradeGun = Class(CIFGrenadeWeapon) {
            FxMuzzleFlash = {
                '/effects/emitters/cybran_artillery_muzzle_flash_01_emit.bp',
                '/effects/emitters/cybran_artillery_muzzle_flash_02_emit.bp',
                '/effects/emitters/cannon_muzzle_smoke_02_emit.bp',
            },
            FxMuzzleFlashScale = 0.5,
        },
################ UPGRADE04
		Upgrade04Gun01 = Class(CAANanoDartWeapon) {},		
    },
	
    OnCreate = function(self)
        CWalkingLandUnit.OnCreate(self)

    end,
	

}

TypeClass = URL0103

