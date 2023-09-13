#****************************************************************************
#**
#**  File     :  /cdimage/units/UAB2101/UAB2101_script.lua
#**  Author(s):  John Comes, David Tomandl
#**
#**  Summary  :  Aeon Light Laser Tower Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local AStructureUnit = import('/lua/aeonunits.lua').AStructureUnit
--local ADFGravitonProjectorWeapon = import('/lua/aeonweapons.lua').ADFGravitonProjectorWeapon

PD3AN2101 = Class(AStructureUnit) {
    Weapons = {
        MainGun = ClassWeapon(import("/lua/aeonweapons.lua").ADFCannonOblivionWeapon03) {}
    },
}

TypeClass = PD3AN2101