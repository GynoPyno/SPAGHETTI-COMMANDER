#****************************************************************************
#**
#**  File     :  /cdimage/units/XSL0111/XSL0111_script.lua
#**  Author(s):  Drew Staltman, Gordon Duclos
#**
#**  Summary  :  Seraphim Mobile Missile Launcher Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local SLandUnit = import('/lua/seraphimunits.lua').SLandUnit
local SLaanseMissileWeapon = import('/lua/seraphimweapons.lua').SLaanseMissileWeapon
local SLaanseMissileWeapon01 = import('/lua/seraphimweapons.lua').SLaanseMissileWeapon
local SAAOlarisCannonWeapon = import('/lua/seraphimweapons.lua').SAAOlarisCannonWeapon

XSL0111 = Class(SLandUnit) {
    Weapons = {
        MissileRack = Class(SLaanseMissileWeapon) {},
        MissileRack01 = Class(SLaanseMissileWeapon01) {},		
		AAGun01 = Class(SAAOlarisCannonWeapon) {},	
		AAGun02 = Class(SAAOlarisCannonWeapon) {},	
    },
	
    OnCreate = function(self)
		SLandUnit.OnCreate(self)

    end,
	
}
TypeClass = XSL0111