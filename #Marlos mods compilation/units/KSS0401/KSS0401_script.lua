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
local SAALosaareAutoCannonWeapon = SeraphimWeapons.SAALosaareAutoCannonWeapon

XSS0202 = Class(SSeaUnit) {
    Weapons = {
        Missile = Class(SLaanseMissileWeapon) {},
		RightAAGun1 = Class(SAAShleoCannonWeapon) {},
		RightAAGun2 = Class(SAALosaareAutoCannonWeapon) {},
		LeftAAGun1 = Class(SAAOlarisCannonWeapon) {},
		LeftAAGun2 = Class(SAALosaareAutoCannonWeapon) {},
        AntiMissile1 = Class(SAMElectrumMissileDefense) {},
        AntiMissile2 = Class(SAMElectrumMissileDefense) {},
        AntiMissile3 = Class(SAMElectrumMissileDefense) {},
        AntiMissile4 = Class(SAMElectrumMissileDefense) {},
    },

    BackWakeEffect = {},
}

TypeClass = XSS0202