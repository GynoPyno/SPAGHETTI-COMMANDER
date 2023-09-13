#****************************************************************************
#**
#**  File     :  /cdimage/units/UAS0303/UAS0303_script.lua
#**  Author(s):  John Comes
#**
#**  Summary  :  Aeon Aircraft Carrier Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local ASeaUnit = import('/lua/aeonunits.lua').ASeaUnit
local WeaponsFile = import('/lua/aeonweapons.lua')
local AAAZealotMissileWeapon = WeaponsFile.AAAZealotMissileWeapon
local NavalCannonOblivionWeapon = import('/lua/aeonweapons.lua').ADFCannonOblivionNaval
local DreadnoughtLaser = import('/mods/#Marlos mods compilation/lua/MKWeapons.lua').DreadnoughtLaser
local AAMWillOWisp = import('/lua/aeonweapons.lua').AAMWillOWisp

MK59 = Class(ASeaUnit) {
    BackWakeEffect = {},
	Weapons = {
        FrontTurret01 = Class(NavalCannonOblivionWeapon) {
			FxMuzzleFlash = {
				'/effects/emitters/oblivion_cannon_flash_04_emit.bp',
				'/effects/emitters/oblivion_cannon_flash_05_emit.bp',				
				'/effects/emitters/oblivion_cannon_flash_06_emit.bp',
			},        
        },

        FrontTurret02 = Class(NavalCannonOblivionWeapon) {
			FxMuzzleFlash = {
				'/effects/emitters/oblivion_cannon_flash_04_emit.bp',
				'/effects/emitters/oblivion_cannon_flash_05_emit.bp',				
				'/effects/emitters/oblivion_cannon_flash_06_emit.bp',
			},        
        },

        BackTurret01 = Class(NavalCannonOblivionWeapon) {
			FxMuzzleFlash = {
				'/effects/emitters/oblivion_cannon_flash_04_emit.bp',
				'/effects/emitters/oblivion_cannon_flash_05_emit.bp',				
				'/effects/emitters/oblivion_cannon_flash_06_emit.bp',
			},        
        },

        BackTurret02 = Class(NavalCannonOblivionWeapon) {
			FxMuzzleFlash = {
				'/effects/emitters/oblivion_cannon_flash_04_emit.bp',
				'/effects/emitters/oblivion_cannon_flash_05_emit.bp',				
				'/effects/emitters/oblivion_cannon_flash_06_emit.bp',
			},        
        },

        AntiAirMissiles01 = Class(AAAZealotMissileWeapon) {},
        AntiAirMissiles02 = Class(AAAZealotMissileWeapon) {},
		
        Laser01 = Class(DreadnoughtLaser) {},
        Laser02 = Class(DreadnoughtLaser) {},
        Laser03 = Class(DreadnoughtLaser) {},
        Laser04 = Class(DreadnoughtLaser) {},
		
        AntiMissile = Class(AAMWillOWisp) {},
	},
}

TypeClass = MK59

