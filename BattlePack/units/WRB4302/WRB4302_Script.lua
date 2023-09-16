#****************************************************************************
#**
#**  File     :  /cdimage/units/URL0107/URL0107_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Cybran Heavy Infantry Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CStructureUnit = import('/lua/cybranunits.lua').CStructureUnit
local cWeapons = import('/lua/cybranweapons.lua')
local CDFElectronBolterWeapon = cWeapons.CDFElectronBolterWeapon

WRB4302 = Class(CStructureUnit) {
    Weapons = {
        MainGun = Class(CDFElectronBolterWeapon) {},
    },
}

TypeClass = WRB4302
