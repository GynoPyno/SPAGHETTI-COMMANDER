#****************************************************************************
#**
#**  File     :  /cdimage/units/UEB4201/UEB4201_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  UEF Phalanx Gun Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TStructureUnit = import('/lua/terranunits.lua').TStructureUnit
local TAMPhalanxWeapon = import('/lua/terranweapons.lua').TAMPhalanxWeapon

UEB4201 = Class(TStructureUnit) {
    Weapons = {
        Turret01 = Class(TAMPhalanxWeapon) {}
    },
}

TypeClass = UEB4201