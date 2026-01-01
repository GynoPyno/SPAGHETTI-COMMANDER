#****************************************************************************
#**
#**  File     :  /cdimage/units/UAB2301/UAB2301_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Aeon Heavy Gun Tower Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local WeaponsFile = import("/lua/aeonweapons.lua")
local AStructureUnit = import('/lua/aeonunits.lua').AStructureUnit
local SCUDeathWeapon = import("/lua/sim/defaultweapons.lua").SCUDeathWeapon
local ADFCannonOblivionWeapon = WeaponsFile.ADFCannonOblivionWeapon02

PDAN2301 = Class(AStructureUnit) {
    Weapons = {
        MainGun = ClassWeapon(ADFCannonOblivionWeapon) {
			FxMuzzleFlash = {
				'/effects/emitters/oblivion_cannon_flash_04_emit.bp',
				'/effects/emitters/oblivion_cannon_flash_05_emit.bp',				
				'/effects/emitters/oblivion_cannon_flash_06_emit.bp',
			},        
        },
		DeathWeapon = ClassWeapon(SCUDeathWeapon) {},
    },
	
}

TypeClass = PDAN2301