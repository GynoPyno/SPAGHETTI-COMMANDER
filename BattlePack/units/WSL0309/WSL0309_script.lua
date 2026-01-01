#****************************************************************************
#**
#**  File     :  /cdimage/units/XSL0205/XSL0205_script.lua
#**  Author(s):  Aaron Lundquist
#**
#**  Summary  :  Seraphim Iashavoh Mobile Anit-Air Cannon
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local SLandUnit = import('/lua/seraphimunits.lua').SLandUnit
local SAALosaareAutoCannonWeapon = import('/lua/seraphimweapons.lua').SAALosaareAutoCannonWeapon

WSL0309 = Class(SLandUnit) {
    Weapons = {
        AntiAirMissiles = Class(SAALosaareAutoCannonWeapon) {},
    },
}
TypeClass = WSL0309