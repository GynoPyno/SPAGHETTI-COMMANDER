#****************************************************************************
#**
#**  File     :  /cdimage/units/XSL0303/XSL0303_script.lua
#**  Author(s):  Dru Staltman, Aaron Lundquist
#**
#**  Summary  :  Seraphim Assault Tank Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local SLandUnit = import('/lua/seraphimunits.lua').SLandUnit
local WeaponsFile = import('/lua/seraphimweapons.lua')
local SDFThauCannon = WeaponsFile.SDFThauCannon


WSL0308 = Class(SLandUnit) {
    Weapons = {
        MainTurret = Class(SDFThauCannon) {},
    },
}
TypeClass = WSL0308