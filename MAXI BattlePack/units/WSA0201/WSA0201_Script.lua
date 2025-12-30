#****************************************************************************
#**
#**  File     :  /cdimage/units/XSA0101/XSA0101_script.lua
#**
#**  Summary  :  Seraphim Scout Aircraft
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local SAirUnit = import('/lua/seraphimunits.lua').SAirUnit
local SeraphimWeapons = import('/lua/seraphimweapons.lua')
local SAAShleoCannonWeapon = SeraphimWeapons.SAAShleoCannonWeapon

WSA0201 = Class(SAirUnit) {
    Weapons = {
        ShleoAAGun01 = Class(SAAShleoCannonWeapon) {
	  FxMuzzleFlash = {'/effects/emitters/sonic_pulse_muzzle_flash_02_emit.bp',},
        },
    },
}

TypeClass = WSA0201