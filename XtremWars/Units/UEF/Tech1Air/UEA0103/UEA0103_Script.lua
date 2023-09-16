#****************************************************************************
#**
#**  File     :  /cdimage/units/UEA0103/UEA0103_script.lua
#**  Author(s):  John Comes, David Tomandl, Gordon Duclos
#**
#**  Summary  :  Terran Carpet Bomber Unit Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local TAirUnit = import('/lua/terranunits.lua').TAirUnit

local TIFCarpetBombWeapon = import('/lua/terranweapons.lua').TIFCarpetBombWeapon
local CIFBombNeutronWeapon = import('/lua/cybranweapons.lua').CIFBombNeutronWeapon


UEA0103 = Class(TAirUnit) {
    Weapons = {
        Bomb = Class(TIFCarpetBombWeapon) {
        },
		BombUpgrade = Class(TIFCarpetBombWeapon) {
        },
		UpgradeGun01 = Class(CIFBombNeutronWeapon) {
        
        },
		UpgradeGun02 = Class(CIFBombNeutronWeapon) {      
        },
	},
    DamageEffectPullback = 0.5,
	
    OnCreate = function(self)
		TAirUnit.OnCreate(self)
			self:HideBone('Origine01_01', true)
    end,	
	
}

TypeClass = UEA0103

