#****************************************************************************
#**
#**  File     :  /units/XEL0209/XEL0209_script.lua
#**
#**  Summary  :  UEF Combat Engineer T2
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local TDFHiroPlasmaCannon = WeaponsFile.TDFHiroPlasmaCannon

WEL0207 = Class(TLandUnit) {
    Weapons = {
        RocketBackpack = Class(TDFHiroPlasmaCannon) {},
    },
}
TypeClass = WEL0207