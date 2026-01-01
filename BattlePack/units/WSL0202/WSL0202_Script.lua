#****************************************************************************
#**
#**  File     :  /cdimage/units/XSL0303/XSL0303_script.lua
#**  Author(s):  Dru Staltman, Aaron Lundquist
#**
#**  Summary  :  Seraphim Siege Tank Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local SLandUnit = import('/lua/seraphimunits.lua').SLandUnit
local SDFThauCannon = import('/lua/seraphimweapons.lua').SDFThauCannon
WEL0202 = Class(SLandUnit) {
    Weapons = {
        FrontTurret01 = Class(SDFThauCannon) {
        }
    },
}

TypeClass = WEL0202