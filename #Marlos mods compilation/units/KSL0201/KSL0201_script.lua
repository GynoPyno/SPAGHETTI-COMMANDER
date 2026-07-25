#****************************************************************************
#**
#**  File     :  
#**  Author(s):  
#**
#**  Summary  :  Seraphim Heavy APC Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local SHoverLandUnit = import('/lua/seraphimunits.lua').SHoverLandUnit
local SDFThauCannon = import('/lua/seraphimweapons.lua').SDFThauCannon
local SLaanseMissileWeapon = import('/lua/seraphimweapons.lua').SLaanseMissileWeapon

MK49 = Class(SHoverLandUnit) {
    Weapons = {
        TauCannon01 = Class(SDFThauCannon) { FxMuzzleFlashScale = 0.5, },
        MissileRack = Class(SLaanseMissileWeapon) {},
    },
}

TypeClass = MK49
