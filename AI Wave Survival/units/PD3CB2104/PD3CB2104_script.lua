#****************************************************************************
#**
#**  File     :  /cdimage/units/URB2104/URB2104_script.lua
#**  Author(s):  John Comes, David Tomandl
#**
#**  Summary  :  Cybran Anti-Air Gun Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CWeapons = import("/lua/cybranweapons.lua")
local CStructureUnit = import('/lua/cybranunits.lua').CStructureUnit
--local CAAAutocannon = import('/lua/cybranweapons.lua').CAAAutocannon
local CDFHeavyDisintegratorWeapon = CWeapons.CDFHeavyDisintegratorWeapon


PD3CB2104 = Class(CStructureUnit) {

    Weapons = {
        MainGun = ClassWeapon(CDFHeavyDisintegratorWeapon) {}
    },
}


TypeClass = PD3CB2104
