#****************************************************************************
#**
#**  File     :  /cdimage/units/UAA0204/UAA0204_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Aeon Torpedo Bomber Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local AAirUnit = import('/lua/aeonunits.lua').AAirUnit
local AANDepthChargeBombWeapon = import('/lua/aeonweapons.lua').AANDepthChargeBombWeapon
local AAASonicPulseBatteryWeapon = import('/lua/aeonweapons.lua').AAASonicPulseBatteryWeapon

UAA0204 = Class(AAirUnit) {
    Weapons = {
        Bomb = Class(AANDepthChargeBombWeapon) {},
		Bomb2 = Class(AANDepthChargeBombWeapon) {},
		SonicPulseBattery1 = Class(AAASonicPulseBatteryWeapon) {
			FxMuzzleFlash = {'/effects/emitters/sonic_pulse_muzzle_flash_02_emit.bp',},
        },
		SonicPulseBatterySpec = Class(AAASonicPulseBatteryWeapon) {
			FxMuzzleFlash = {'/effects/emitters/sonic_pulse_muzzle_flash_02_emit.bp',},
        },	
    },
	

    OnCreate = function(self)
		AAirUnit.OnCreate(self)


    end,	
	
	
}

TypeClass = UAA0204