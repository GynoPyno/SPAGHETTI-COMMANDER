#****************************************************************************
#**
#**  File     :  /cdimage/units/URL0106/URL0106_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Cybran Light Infantry Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit
local CDFLaserPulseLightWeapon = import('/lua/cybranweapons.lua').CDFLaserPulseLightWeapon
#########UPGRADE04
local CAANanoDartWeapon = import('/lua/cybranweapons.lua').CAANanoDartWeapon

URL0106 = Class(CWalkingLandUnit) {
    Weapons = {
        MainGun = Class(CDFLaserPulseLightWeapon) {},
		UpgradeGun = Class(CDFLaserPulseLightWeapon) {},
		UpgradeGun02 = Class(CAANanoDartWeapon) {},
    },
	
    OnCreate = function(self)
		CWalkingLandUnit.OnCreate(self)
    end,
	
}

TypeClass = URL0106