#****************************************************************************
#**
#**  File     :  /units/XSB2207/XSB2207_script.lua
#**  Author(s):  Drew Staltman, Jessica St. Croix, Gordon Duclos, Aaron Lundquist
#**
#**  Summary  :  Seraphim Sinnatha Anti-Air Defense
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local SAirUnit = import('/lua/seraphimunits.lua').SAirUnit
local SAAOlarisCannonWeapon = import('/lua/seraphimweapons.lua').SAAOlarisCannonWeapon

XSB2207 = Class(SAirUnit) {
    Weapons = {
        AAFizz = Class(SAAOlarisCannonWeapon) {},
    },
}
TypeClass = XSB2207