#****************************************************************************
#**
#**  File     :  /units/XSL0202/XSL0202_script.lua
#**
#**  Summary  :  Seraphim Heavy Bot Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local SWalkingLandUnit = import('/lua/seraphimunits.lua').SWalkingLandUnit
local SDFOhCannon = import('/lua/seraphimweapons.lua').SDFOhCannon
local SANUallCavitationTorpedo = import('/lua/seraphimweapons.lua').SANUallCavitationTorpedo

XSL0202 = Class(SWalkingLandUnit) {

    Weapons = {
        MainGun = Class(SDFOhCannon) {},
        Torpedo = Class(SANUallCavitationTorpedo) {},
    },
}

TypeClass = XSL0202