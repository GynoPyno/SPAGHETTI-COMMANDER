#****************************************************************************
#**
#**  File     :  /cdimage/units/URL0205/URL0205_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Cybran Mobile Flak Artillery Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CLandUnit = import('/lua/cybranunits.lua').CLandUnit
local CybranWeaponsFile = import('/lua/cybranweapons.lua')
local CAANanoDartWeapon = CybranWeaponsFile.CAANanoDartWeapon

WRL0309 = Class(CLandUnit) {
    Weapons = {
        MainGun = Class(CAANanoDartWeapon) {},
    },
}

TypeClass = WRL0309