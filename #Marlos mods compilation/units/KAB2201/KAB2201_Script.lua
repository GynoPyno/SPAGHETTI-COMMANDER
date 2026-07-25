#****************************************************************************
#**
#**  File     :  /cdimage/units/KAB2201/KAB2201_script.lua
#**  Author(s):  John Comes
#**
#**  Summary  :  Aeon PD
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local AStructureUnit = import('/lua/aeonunits.lua').AStructureUnit
local ADFQuantumAutogunWeapon = import('/lua/aeonweapons.lua').ADFQuantumAutogunWeapon

KAB2201 = Class(AStructureUnit) {
    Weapons = {
        MainGun = Class(ADFQuantumAutogunWeapon) {}
    },
}

TypeClass = KAB2201