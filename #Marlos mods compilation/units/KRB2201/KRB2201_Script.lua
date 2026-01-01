#****************************************************************************
#**
#**  File     :  /cdimage/units/KAB2201/KAB2201_script.lua
#**  Author(s):  John Comes
#**
#**  Summary  :  Aeon PD
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CStructureUnit = import('/lua/cybranunits.lua').CStructureUnit
local CybranWeaponsFile = import('/lua/cybranweapons.lua')
local CDFElectronBolterWeapon = CybranWeaponsFile.CDFElectronBolterWeapon

KRB2201 = Class(CStructureUnit) {
    Weapons = {
        MainGun = Class(CDFElectronBolterWeapon) {}
    },
}

TypeClass = KRB2201