#****************************************************************************
#**
#**  File     :  /cdimage/units/UAA0103/UAA0103_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Aeon Bomber Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local AAirUnit = import('/lua/aeonunits.lua').AAirUnit
local TIFCarpetBombWeapon = import('/lua/terranweapons.lua').TIFCarpetBombWeapon

WAA0305 = Class(AAirUnit) {
    Weapons = {
        Bomb = Class(TIFCarpetBombWeapon) {},
    },
}

TypeClass = WAA0305

