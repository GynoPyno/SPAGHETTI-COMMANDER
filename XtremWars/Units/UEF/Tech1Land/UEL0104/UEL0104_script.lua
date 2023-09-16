#****************************************************************************
#**
#**  File     :  /cdimage/units/UEL0104/UEL0104_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**				Upgrades Model By Asdrubaelvect Script By Manimal For Experimental Wars 1.8
#**  Summary  :  UEF Mobile Anti-Air Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local TAALinkedRailgun = import('/lua/terranweapons.lua').TAALinkedRailgun
local TSAMLauncher = import('/lua/terranweapons.lua').TSAMLauncher

UEL0104 = Class(TLandUnit) {
    Weapons = {
        AAGun02 = Class(TAALinkedRailgun) {
            FxMuzzleFlashScale = 0.25,
        },
		MissileRack01 = Class(TSAMLauncher) {},
		MissileRack02 = Class(TSAMLauncher) {},
    },

    OnCreate = function(self)
        TLandUnit.OnCreate(self)
		self:HideBone('Turret', true)
    end,
	

}

TypeClass = UEL0104