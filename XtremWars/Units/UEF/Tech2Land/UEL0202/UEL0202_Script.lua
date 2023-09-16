#****************************************************************************
#**
#**  File     :  /cdimage/units/UEL0202/UEL0202_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  UEF Heavy Tank Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local TDFGaussCannonWeapon = import('/lua/terranweapons.lua').TDFGaussCannonWeapon
local TIFCruiseMissileUnpackingLauncher = import('/lua/terranweapons.lua').TIFCruiseMissileUnpackingLauncher

UEL0202 = Class(TLandUnit) {
    Weapons = {
        FrontTurret01 = Class(TDFGaussCannonWeapon) {},
		UpgradeTurret01 = Class(TDFGaussCannonWeapon) {},
        MissileWeapon01 = Class(TIFCruiseMissileUnpackingLauncher) {},
        MissileWeapon02 = Class(TIFCruiseMissileUnpackingLauncher) {},			
    },
	
    OnCreate = function(self)
		TLandUnit.OnCreate(self)
    end,

}

TypeClass = UEL0202