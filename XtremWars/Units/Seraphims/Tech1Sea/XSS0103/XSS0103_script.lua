#****************************************************************************
#**
#**  File     :  /cdimage/units/XSS0103/XSS0103_script.lua
#**
#**  Summary  :  Seraphim Frigate Script: XSS0103
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local SSeaUnit = import('/lua/seraphimunits.lua').SSeaUnit
local SWeapon = import('/lua/seraphimweapons.lua')
local SDFUltraChromaticBeamGenerator = import('/lua/seraphimweapons.lua').SDFUltraChromaticBeamGenerator


XSS0103 = Class(SSeaUnit) {
    Weapons = {
        MainGun = Class(SWeapon.SDFShriekerCannon){},
        AntiAir = Class(SWeapon.SAAShleoCannonWeapon){},
		UpgradeAntiAir01 = Class(SWeapon.SAAShleoCannonWeapon){},
		UpgradeAntiAir02 = Class(SWeapon.SAAShleoCannonWeapon){},
		AntiNavyUpgradeGun01 = Class(SWeapon.SDFShriekerCannon){},
		AntiNavyUpgradeGun02 = Class(SWeapon.SDFShriekerCannon){},
		LaserGun01 = Class(SDFUltraChromaticBeamGenerator) {},
    },
	
    OnCreate = function(self)
		SSeaUnit.OnCreate(self)
		self:ShowBone('Upgrade05_01', true)
    end,	

}
TypeClass = XSS0103
