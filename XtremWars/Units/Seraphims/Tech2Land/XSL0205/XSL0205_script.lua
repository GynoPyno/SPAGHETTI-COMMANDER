#****************************************************************************
#**
#**  File     :  /cdimage/units/XSL0205/XSL0205_script.lua
#**  Author(s):  Aaron Lundquist
#**
#**  Summary  :  Seraphim Iashavoh Mobile Anit-Air Cannon
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local SHoverLandUnit = import('/lua/seraphimunits.lua').SHoverLandUnit
local SAAOlarisCannonWeapon = import('/lua/seraphimweapons.lua').SAAOlarisCannonWeapon

XSL0205 = Class(SHoverLandUnit) {
    Weapons = {
        AAGun = Class(SAAOlarisCannonWeapon) {},	
		AAGun01 = Class(SAAOlarisCannonWeapon) {},	
		AAGun02 = Class(SAAOlarisCannonWeapon) {},	
    },
	
    OnCreate = function(self)
		SHoverLandUnit.OnCreate(self)

    end,

}
TypeClass = XSL0205