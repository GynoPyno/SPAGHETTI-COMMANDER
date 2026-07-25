#****************************************************************************
#**
#**  File     :  /cdimage/units/UEL0202/UEL0202_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  UEF Heavy Tank Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TStructureUnit = import('/lua/terranunits.lua').TStructureUnit
local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local TSAMLauncher = import('/lua/terranweapons.lua').TSAMLauncher

MK31 = Class(TLandUnit) {
    Weapons = {
        MissileRack01 = Class(TSAMLauncher) {},
    },
}

TypeClass = MK31