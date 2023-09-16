#****************************************************************************
#**
#**  File     :  /data/units/XAL0203/XAL0203_script.lua
#**  Author(s):  Jessica St. Croix
#**
#**  Summary  :  Aeon Assault Tank Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local AHoverLandUnit = import('/lua/aeonunits.lua').AHoverLandUnit
local ADFQuantumAutogunWeapon = import('/lua/aeonweapons.lua').ADFQuantumAutogunWeapon

XAL0203 = Class( AHoverLandUnit ) {
    Weapons = {
        MainGun = Class(ADFQuantumAutogunWeapon) {},
		UpgradeGun01 = Class(ADFQuantumAutogunWeapon) {},
		UpgradeGun02 = Class(ADFQuantumAutogunWeapon) {},
		UpgradeGun03 = Class(ADFQuantumAutogunWeapon) {},
		UpgradeGun04 = Class(ADFQuantumAutogunWeapon) {},
		UpgradeGun05 = Class(ADFQuantumAutogunWeapon) {},
    },
	
    OnCreate = function(self)
		AHoverLandUnit.OnCreate(self)

    end,

}

TypeClass = XAL0203
