--[[#######################################################################
#  File     :  /units/XSS0106/XSS0106_script.lua
#  Author(s):  GPG Devs
#  Summary  :  Seraphim Frigate Script: XSS0103
#  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#######################################################################]]--

local SSeaUnit = import('/lua/seraphimunits.lua').SSeaUnit
local SWeapon = import('/lua/seraphimweapons.lua')
local Buff = import('/lua/sim/Buff.lua')

###UPGRADE 04
local SDFUltraChromaticBeamGenerator = import('/lua/seraphimweapons.lua').SDFUltraChromaticBeamGenerator


XSS0106 = Class(SSeaUnit) {
    Weapons = {
        MainGun = Class(SWeapon.SDFShriekerCannon){},
        AntiAir = Class(SWeapon.SAAShleoCannonWeapon){},
		UpgradeAntiAir01 = Class(SWeapon.SAAShleoCannonWeapon){},
		UpgradeAntiAir02 = Class(SWeapon.SAAShleoCannonWeapon){},
		AntiNavyUpgradeGun01 = Class(SWeapon.SDFShriekerCannon){},
		LaserGun01 = Class(SDFUltraChromaticBeamGenerator) {},
    },
	
    OnCreate = function(self)
		SSeaUnit.OnCreate(self)
		self:ShowBone('Upgrade05_01', true)
    end,	
		
}

TypeClass = XSS0106

