#****************************************************************************
#**
#**  File     :  
#**  Author(s):  
#**
#**  Summary  :  UEF Heavy Gun Tower Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local SStructureUnit = import('/lua/seraphimunits.lua').SStructureUnit
local SWeapon = import('/lua/seraphimweapons.lua')

Mk50 = Class(SStructureUnit) {
    Weapons = {
        MainGun = Class(SWeapon.SDFShriekerCannon){}, 
    },
}

TypeClass = Mk50