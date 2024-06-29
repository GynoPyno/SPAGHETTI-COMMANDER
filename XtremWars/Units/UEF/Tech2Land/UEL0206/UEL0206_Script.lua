#****************************************************************************
#**
#**  File     :  /units/UEL0206/UEL0206_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  UEF Medium Arty Mobile
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local TIFArtilleryWeapon = import('/lua/terranweapons.lua').TIFArtilleryWeapon
local TIFCruiseMissileUnpackingLauncher = import('/lua/terranweapons.lua').TIFCruiseMissileUnpackingLauncher

UEL0206 = Class(TLandUnit) {
    Weapons = {
        MainGun = Class(TIFArtilleryWeapon) {},
		UpgradeTurret01 = Class(TIFArtilleryWeapon) {},
		UpgradeTurret02 = Class(TIFArtilleryWeapon) {},
		MissileWeapon01 = Class(TIFCruiseMissileUnpackingLauncher) {},
    },
	
    OnCreate = function(self)
		TLandUnit.OnCreate(self)

    end,

}

TypeClass = UEL0206