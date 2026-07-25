#****************************************************************************
#**
#**  File     :  /cdimage/units/UEL0304/UEL0304_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  UEF Mobile Heavy Artillery Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CLandUnit = import('/lua/terranunits.lua').TLandUnit
local CybranWeaponsFile = import('/lua/cybranweapons.lua')
local CDFHvyProtonCannonWeapon = CybranWeaponsFile.CDFHvyProtonCannonWeapon

MK66 = Class(CLandUnit) {
    Weapons = {
        MainGun = Class(CDFHvyProtonCannonWeapon) {
        }
    },
}

TypeClass = MK66