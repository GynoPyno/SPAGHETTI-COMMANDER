#****************************************************************************
#**
#**  File     :  /units/XSS0202/XSS0202_script.lua
#**  Author(s):  Drew Staltman, Gordon Duclos, Aaron Lundquist
#**
#**  Summary  :  Seraphim Cruiser Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local SeraphimWeapons = import('/lua/seraphimweapons.lua')
local SSeaUnit = import('/lua/seraphimunits.lua').SSeaUnit
local SLaanseMissileWeapon = SeraphimWeapons.SLaanseMissileWeapon
local SAAOlarisCannonWeapon = SeraphimWeapons.SAAOlarisCannonWeapon
local SAAShleoCannonWeapon = SeraphimWeapons.SAAShleoCannonWeapon
local SAMElectrumMissileDefense = SeraphimWeapons.SAMElectrumMissileDefense
local SDFThauCannon = SeraphimWeapons.SDFThauCannon

XSS0202 = Class(SSeaUnit) {
    Weapons = {
        Missile = Class(SLaanseMissileWeapon) {},
		RightAAGun = Class(SAAShleoCannonWeapon) {},
		LeftAAGun = Class(SAAOlarisCannonWeapon) {},
        AntiMissile = Class(SAMElectrumMissileDefense) {},
		###UPGRADE2
		Upgrade02_01Turret = Class(SDFThauCannon) {},
		Upgrade02_02Turret = Class(SDFThauCannon) {},
		####UPGRADE3
		Missile02 = Class(SLaanseMissileWeapon) {},
		Missile03 = Class(SLaanseMissileWeapon) {},
		####UPGRADE4
		RightAAGun01 = Class(SAAShleoCannonWeapon) {},
		LeftAAGun01 = Class(SAAOlarisCannonWeapon) {},
    },

    BackWakeEffect = {},
	
	
    OnCreate = function(self)
        SSeaUnit.OnCreate(self)
	
    end,	
	
}

TypeClass = XSS0202