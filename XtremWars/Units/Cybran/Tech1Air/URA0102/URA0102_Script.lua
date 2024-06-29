#****************************************************************************
#**
#**  File     :  /cdimage/units/URA0102/URA0102_script.lua
#**  Author(s):  John Comes, David Tomandl
#**
#**  Summary  :  Cybran Unit Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local CAirUnit = import('/lua/cybranunits.lua').CAirUnit
local CAAAutocannon = import('/lua/cybranweapons.lua').CAAAutocannon

URA0102 = Class(CAirUnit) {


    Weapons = {
        AutoCannon = Class(CAAAutocannon) {},
        AutoCannon2 = Class(CAAAutocannon) {},
		UpgradeGun01 = Class(CAAAutocannon) {},
		UpgradeGun02 = Class(CAAAutocannon) {},
		UpgradeGun03 = Class(CAAAutocannon) {},
		UpgradeGun04 = Class(CAAAutocannon) {},
    },
	
    OnCreate = function(self)
		CAirUnit.OnCreate(self)
		self:HideBone('Origine01_01', true)
    end,

	
}

TypeClass = URA0102
