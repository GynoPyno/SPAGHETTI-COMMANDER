#****************************************************************************
#**
#**  File     :  /cdimage/units/URB2101/URB2101_script.lua
#**  Author(s):  John Comes, David Tomandl
#**
#**  Summary  :  Cybran Light Gun Tower Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CLandUnit = import('/lua/cybranunits.lua').CLandUnit
local CDFLaserHeavyWeapon = import('/lua/cybranweapons.lua').CDFLaserHeavyWeapon

URB2101 = Class(CLandUnit) {

    Weapons = {
		UpgradeGun01 = Class(CDFLaserHeavyWeapon) {},
    },

    OnCreate = function(self)
		CLandUnit.OnCreate(self)

    end,
	

	
}

TypeClass = URB2101
