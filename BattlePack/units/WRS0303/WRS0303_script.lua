#****************************************************************************
#**
#**  File     :  /cdimage/units/URS0202/URS0202_script.lua
#**  Author(s):  David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Cybran Cruiser Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CSeaUnit = import('/lua/cybranunits.lua').CSeaUnit
local CybranWeaponsFile = import('/lua/cybranweapons.lua')
local CDFProtonCannonWeapon = CybranWeaponsFile.CDFProtonCannonWeapon
local CAANanoDartWeapon = CybranWeaponsFile.CAANanoDartWeapon

WRS0303 = Class(CSeaUnit) {
    Weapons = {
        ParticleGun1 = Class(CDFProtonCannonWeapon) {},
        ParticleGun2 = Class(CDFProtonCannonWeapon) {},
        ParticleGun3 = Class(CDFProtonCannonWeapon) {},
        AAGun1 = Class(CAANanoDartWeapon) {},
        AAGun2 = Class(CAANanoDartWeapon) {},
    },
}

TypeClass = WRS0303