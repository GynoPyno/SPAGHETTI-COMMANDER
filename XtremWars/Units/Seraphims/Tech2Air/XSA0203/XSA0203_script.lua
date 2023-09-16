#****************************************************************************
#**
#**  File     :  /cdimage/units/UAA0203/UAA0203_script.lua
#**  Author(s):  Drew Staltman, Gordon Duclos
#**
#**  Summary  :  Seraphim Gunship Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local SAirUnit = import('/lua/seraphimunits.lua').SAirUnit
local SDFPhasicAutoGunWeapon = import('/lua/seraphimweapons.lua').SDFPhasicAutoGunWeapon

XSA0203 = Class(SAirUnit) {
    Weapons = {
        TurretLeft = Class(SDFPhasicAutoGunWeapon) {},
        TurretRight = Class(SDFPhasicAutoGunWeapon) {},
		TurretLeft01 = Class(SDFPhasicAutoGunWeapon) {},
        TurretRight01 = Class(SDFPhasicAutoGunWeapon) {},
		TurretLeft02 = Class(SDFPhasicAutoGunWeapon) {},
        TurretRight02 = Class(SDFPhasicAutoGunWeapon) {},
    },
	
   OnCreate = function(self)
		SAirUnit.OnCreate(self)
		self:HideBone('Origine01', true)	
		self:HideBone('Origine02', true)	
    end,
		
	
}
TypeClass = XSA0203