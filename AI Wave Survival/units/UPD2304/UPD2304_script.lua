#****************************************************************************
#**
#**  File     :  /cdimage/units/UEB2304/UEB2304_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  UEF Advanced AA System Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TStructureUnit = import('/lua/terranunits.lua').TStructureUnit
local TSAMLauncher = import('/lua/terranweapons.lua').TSAMLauncher
local AANDepthChargeBombWeapon02 = import("/lua/aeonweapons.lua").AANDepthChargeBombWeapon02

UPD2304 = Class(TStructureUnit) {
    Weapons = {
        MissileRack01 = Class(TSAMLauncher) {},
		DepthCharge = ClassWeapon(AANDepthChargeBombWeapon02) {},
    },
}

TypeClass = UPD2304