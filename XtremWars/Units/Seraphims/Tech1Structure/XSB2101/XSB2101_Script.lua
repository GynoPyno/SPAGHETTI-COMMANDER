#****************************************************************************
#**
#**  File     :  /cdimage/units/XSB2101/XSB2101_script.lua
#**  Author(s):  Drew Staltman, Gordon Duclos, Aaron Lundquist
#**
#**  Summary  :  Seraphim Light Laser Tower Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local SLandUnit = import('/lua/seraphimunits.lua').SLandUnit
local SDFOhCannon = import('/lua/seraphimweapons.lua').SDFOhCannon

XSB2101 = Class(SLandUnit) {
    Weapons = {
		UpgradeGun01 = Class(SDFOhCannon) {},
    },
	
    OnCreate = function(self)
		SLandUnit.OnCreate(self)
		self:HideBone('Turret', true) 
    end,
	
	
}
TypeClass = XSB2101