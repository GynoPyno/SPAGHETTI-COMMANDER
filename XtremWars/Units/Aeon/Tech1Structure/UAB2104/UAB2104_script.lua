#****************************************************************************
#**
#**  File     :  /cdimage/units/UAB2104/UAB2104_script.lua
#**  Author(s):  John Comes, David Tomandl
#**
#**  Summary  :  Aeon Anti-Air Gun Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local ALandUnit = import('/lua/aeonunits.lua').ALandUnit
local AAASonicPulseBatteryWeapon = import('/lua/aeonweapons.lua').AAASonicPulseBatteryWeapon

UAB2104 = Class(ALandUnit) {

    Weapons = {
        UpgradeGun01 = Class(AAASonicPulseBatteryWeapon) {
            FxMuzzleScale = 2.25,
        },
    },
	
    OnCreate = function(self)
		ALandUnit.OnCreate(self)
		self:HideBone('Turret_Barrel', true)
    end,

}

TypeClass = UAB2104
