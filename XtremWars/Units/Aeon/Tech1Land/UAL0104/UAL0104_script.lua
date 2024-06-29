#****************************************************************************
#**
#**  File     :  /cdimage/units/UAL0104/UAL0104_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Aeon Mobile Anti-Air Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local AHoverLandUnit = import('/lua/aeonunits.lua').AHoverLandUnit
local AAASonicPulseBatteryWeapon = import('/lua/aeonweapons.lua').AAASonicPulseBatteryWeapon

UAL0104 = Class(AHoverLandUnit) {

    Weapons = {
        AAGun = Class(AAASonicPulseBatteryWeapon) {},
		UpgradeGun01 = Class(AAASonicPulseBatteryWeapon) {},

    },

    OnCreate = function(self)
        AHoverLandUnit.OnCreate(self)
		self:HideBone('Turret_Barrel', true)
    end,
	
}


TypeClass = UAL0104