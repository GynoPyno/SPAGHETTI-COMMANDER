#****************************************************************************
#**
#**  File     :  /units/XSB2106/XSB2106_script.lua
#**  Author(s):  Drew Staltman, Gordon Duclos, Aaron Lundquist
#**
#**  Summary  :  Seraphim Light Laser Tower Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local SAirUnit = import('/lua/seraphimunits.lua').SAirUnit
local SDFOhCannon = import('/lua/seraphimweapons.lua').SDFOhCannon

XSB2101 = Class(SAirUnit) {
    Weapons = {
        MainGun = Class(SDFOhCannon) {},
		UpgradeGun01 = Class(SDFOhCannon) {},
    },
	
    OnCreate = function(self)
		SAirUnit.OnCreate(self)
		self:HideBone('Turret', true) 
    end,
			
	
}
TypeClass = XSB2101