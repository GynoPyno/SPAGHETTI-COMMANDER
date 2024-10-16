#****************************************************************************
#**
#**  File     :  /units/XSS0104/XSS0104_script.lua
#**
#**  Summary  :  Seraphim ARty Frigate Script: XSS0103
#**
#**  Copyright � 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local SSeaUnit = import('/lua/seraphimunits.lua').SSeaUnit
local SIFZthuthaamArtilleryCannon = import('/lua/seraphimweapons.lua').SIFZthuthaamArtilleryCannon
local SWeapon = import('/lua/seraphimweapons.lua')
local SDFUltraChromaticBeamGenerator = import('/lua/seraphimweapons.lua').SDFUltraChromaticBeamGenerator


XSS0104 = Class(SSeaUnit) {
    Weapons = {
        MainGun = Class(SIFZthuthaamArtilleryCannon) {},
	 	###UPGRADE01
		UpgradeAntiAir01 = Class(SWeapon.SAAShleoCannonWeapon){},
		UpgradeAntiAir02 = Class(SWeapon.SAAShleoCannonWeapon){},
		####UPGRADE 03
		AntiNavyUpgradeGun01 = Class(SWeapon.SDFShriekerCannon){},
		AntiNavyUpgradeGun02 = Class(SWeapon.SDFShriekerCannon){},
		####UPGRADE 04
		LaserGun01 = Class(SDFUltraChromaticBeamGenerator) {},
    },
	
    OnCreate = function(self)
		SSeaUnit.OnCreate(self)
		self:ShowBone('Upgrade05_01', true)

    end,		
	
}
TypeClass = XSS0104
