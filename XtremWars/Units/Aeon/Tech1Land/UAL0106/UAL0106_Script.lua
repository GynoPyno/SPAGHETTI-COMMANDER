#****************************************************************************
#**
#**  File     :  /cdimage/units/UAL0106/UAL0106_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Aeon Light Assault Bot Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local AWalkingLandUnit = import('/lua/aeonunits.lua').AWalkingLandUnit
local ADFLaserLightWeapon = import('/lua/aeonweapons.lua').ADFLaserLightWeapon
local ADFGravitonProjectorWeapon = import('/lua/aeonweapons.lua').ADFGravitonProjectorWeapon

UAL0106 = Class(AWalkingLandUnit) {
    Weapons = {
        ArmLaserTurret = Class(ADFLaserLightWeapon) {},
		####UPGRADE04
		UpgradeGun02 = Class(ADFGravitonProjectorWeapon) {},
    },
	
    OnCreate = function(self)
		AWalkingLandUnit.OnCreate(self)
			self:HideBone('Upgrade05_01', true)	
			self:HideBone('Upgrade05_02', true)	

    end,
	
}


TypeClass = UAL0106