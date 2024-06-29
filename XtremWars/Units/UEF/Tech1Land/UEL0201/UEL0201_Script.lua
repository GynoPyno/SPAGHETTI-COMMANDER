#****************************************************************************
#**
#**  File     :  /cdimage/units/UEL0201/UEL0201_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  UEF Medium Tank Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local TDFGaussCannonWeapon = import('/lua/terranweapons.lua').TDFGaussCannonWeapon
local TSAMLauncher = import('/lua/terranweapons.lua').TSAMLauncher

UEL0201 = Class(TLandUnit) {
    Weapons = {
        MainGun = Class(TDFGaussCannonWeapon) {},
		UpgradeGun = Class(TDFGaussCannonWeapon) {},
		MissileRack01 = Class(TSAMLauncher) {},
    },

    OnCreate = function(self)
		TLandUnit.OnCreate(self)

    end,
	
	
}

TypeClass = UEL0201
