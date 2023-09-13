#****************************************************************************
#**
#**  File     :  /cdimage/units/UEB2301/UEB2301_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  UEF Heavy Gun Tower Script
#**
#**  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TStructureUnit = import('/lua/terranunits.lua').TStructureUnit
local TIFCarpetBombWeapon = import("/lua/terranweapons.lua").TIFCarpetBombWeapon
local SCUDeathWeapon = import("/lua/sim/defaultweapons.lua").SCUDeathWeapon

PDUEF2301 = Class(TStructureUnit) {
    Weapons = { 
		Bomb = ClassWeapon(TIFCarpetBombWeapon) {},
		DeathWeapon = ClassWeapon(SCUDeathWeapon) {},
    },
}

TypeClass = PDUEF2301