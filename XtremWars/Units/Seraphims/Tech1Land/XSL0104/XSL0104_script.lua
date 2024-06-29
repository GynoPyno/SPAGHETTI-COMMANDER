#****************************************************************************
#**
#**  File     :  /cdimage/units/XAL0104/XAL0104_script.lua
#**  Author(s):  Jessica St. Croix, Gordon Duclos
#**
#**  Summary  :  Seraphim Mobile Anti-Air Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local SWalkingLandUnit = import('/lua/seraphimunits.lua').SWalkingLandUnit
local SAAShleoCannonWeapon = import('/lua/seraphimweapons.lua').SAAShleoCannonWeapon

XSL0104 = Class(SWalkingLandUnit) {
    Weapons = {
        AAGun = Class(SAAShleoCannonWeapon) {},
		######UPGRADE02
		UpgradeGun01 = Class(SAAShleoCannonWeapon) {},
		######UPGRADE04
		UpgradeGun02 = Class(SAAShleoCannonWeapon) {},
    },
	
    OnCreate = function(self)
        SWalkingLandUnit.OnCreate(self)

    end,
	
}
TypeClass = XSL0104