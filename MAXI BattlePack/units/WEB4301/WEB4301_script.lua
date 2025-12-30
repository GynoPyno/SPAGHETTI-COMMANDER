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
local WeaponsFile = import('/lua/terranweapons.lua')
local TDFHiroPlasmaCannon = WeaponsFile.TDFHiroPlasmaCannon

WEB4301 = Class(TStructureUnit) {
    Weapons = {
        Turret01 = Class(TDFHiroPlasmaCannon) {},
    },
}

TypeClass = WEB4301