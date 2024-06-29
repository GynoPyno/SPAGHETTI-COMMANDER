#****************************************************************************
#**
#**  File     :  /Mods/ExpeWars/units/UEL0305/UEL0305_script.lua
#**  Author(s):  John Comes, David Tomandl, Gordon Duclos
#**
#**  Summary  :  UEF T3 Heavy Tank Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local WeaponFile = import('/lua/terranweapons.lua')
local TDFGaussCannonWeapon = WeaponFile.TDFGaussCannonWeapon
local TIFCruiseMissileUnpackingLauncher = WeaponFile.TIFCruiseMissileUnpackingLauncher

UEL0305 = Class(TLandUnit) {
    Weapons = {
		FrontTurret = Class(TDFGaussCannonWeapon) {},
		#######UPGRADE02
		BackTurret = Class(TDFGaussCannonWeapon) {},
		####UPGRADE 3
        MissileWeapon01 = Class(TIFCruiseMissileUnpackingLauncher) {},
		MissileWeapon02 = Class(TIFCruiseMissileUnpackingLauncher) {},
    },
	
	
	OnCreate = function(self)
        TLandUnit.OnCreate(self)

    end,	

}

TypeClass = UEL0305