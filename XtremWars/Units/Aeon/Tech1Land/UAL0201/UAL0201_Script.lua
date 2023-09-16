#****************************************************************************
#**
#**  File     :  /cdimage/units/UAL0201/UAL0201_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Aeon Light Tank Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local AHoverLandUnit = import('/lua/aeonunits.lua').AHoverLandUnit
local ADFDisruptorCannonWeapon = import('/lua/aeonweapons.lua').ADFDisruptorCannonWeapon


UAL0201 = Class(AHoverLandUnit) {
    Weapons = {
        MainGun = Class(ADFDisruptorCannonWeapon) {},
		UpgradeGun01 = Class(ADFDisruptorCannonWeapon) {},
		UpgradeGun02 = Class(ADFDisruptorCannonWeapon) {},
		UpgradeGun03 = Class(ADFDisruptorCannonWeapon) {},
    },
	
    OnCreate = function(self)
		AHoverLandUnit.OnCreate(self)
			self:HideBone('Upgrade05_01', true)
			self:HideBone('Origine01_01', true)	
    end,
	
	
}
TypeClass = UAL0201

