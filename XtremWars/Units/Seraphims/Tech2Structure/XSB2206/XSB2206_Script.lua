#****************************************************************************
#**
#**  File     :  /cdimage/units/XSB2206/XSB2206_script.lua
#**  Author(s):  Greg Kohne
#**
#**  Summary  :  Seraphime Air Heavy Gun Tower Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local SAirUnit = import('/lua/seraphimunits.lua').SAirUnit
local SDFUltraChromaticBeamGenerator = import('/lua/seraphimweapons.lua').SDFUltraChromaticBeamGenerator

XSB2206 = Class(SAirUnit) {
    Weapons = {
        MainGun = Class(SDFUltraChromaticBeamGenerator) {}
    },
}

TypeClass = XSB2206