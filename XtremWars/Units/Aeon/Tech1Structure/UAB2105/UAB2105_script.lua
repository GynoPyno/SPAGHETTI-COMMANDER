--[[#######################################################################
#  File     :  /units/Usines/UAB2105/UAB2105_script.lua
#  Author(s):  John Comes, David Tomandl
#  Summary  :  Aeon Anti-Air Gun Script
#  -----------------------------
#  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#######################################################################]]--
local AAirUnit = import('/lua/aeonunits.lua').AAirUnit
local AAASonicPulseBatteryWeapon = import('/lua/aeonweapons.lua').AAASonicPulseBatteryWeapon

UAB2105 = Class( AAirUnit ) {

    Weapons = {
        UpgradeGun01 = Class(AAASonicPulseBatteryWeapon) {
            FxMuzzleScale = 2.25,
        },
    },
	
    OnCreate = function(self)
		AAirUnit.OnCreate(self)
		self:HideBone('Turret_Barrel', true)
    end,

}

TypeClass = UAB2105
