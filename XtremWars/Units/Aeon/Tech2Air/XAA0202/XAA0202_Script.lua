#****************************************************************************
#**
#**  File     :  /data/units/XAA0202/XAA0202_script.lua
#**  Author(s):  Jessica St. Croix
#**
#**  Summary  :  Aeon Combat Fighter Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local AAirUnit = import('/lua/aeonunits.lua').AAirUnit
local AAAAutocannonQuantumWeapon = import('/lua/aeonweapons.lua').AAALightDisplacementAutocannonMissileWeapon
local AAASonicPulseBatteryWeapon = import('/lua/aeonweapons.lua').AAASonicPulseBatteryWeapon


XAA0202 = Class(AAirUnit) {
    Weapons = {
		AutoCannon1 = Class(AAAAutocannonQuantumWeapon) {},
		AutoCannon2 = Class(AAAAutocannonQuantumWeapon) {},
		AutoCannon3 = Class(AAAAutocannonQuantumWeapon) {},
		SonicPulseBatterySpec = Class(AAASonicPulseBatteryWeapon) {
			FxMuzzleFlash = {'/effects/emitters/sonic_pulse_muzzle_flash_02_emit.bp',},
        },	
    },
	
	
    OnCreate = function(self)
		AAirUnit.OnCreate(self)

    end,	

}
	
TypeClass = XAA0202