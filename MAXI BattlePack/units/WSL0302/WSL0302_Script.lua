#****************************************************************************
#**
#**  File     :  /units/XSL0310/XSL0310_script.lua
#**
#**  Summary  :  Seraphim Heavy Bot Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local SWalkingLandUnit = import('/lua/seraphimunits.lua').SWalkingLandUnit
local SIFBombZhanaseeWeapon = import('/lua/seraphimweapons.lua').SIFBombZhanaseeWeapon

WSL0302 = Class(SWalkingLandUnit) {
    Weapons = {
        MainGun = Class(SIFBombZhanaseeWeapon) {},
    },
   
}
TypeClass = WSL0302