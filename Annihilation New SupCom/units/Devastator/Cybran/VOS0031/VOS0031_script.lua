#****************************************************************************
#**
#**  File     :  /cdimage/units/URA0101/URA0101_script.lua
#**  Author(s):  David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Cybran Scout Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local CAirUnit = import('/lua/cybranunits.lua').CAirUnit      
local CIFNaniteTorpedoWeapon = import('/lua/cybranweapons.lua').CIFNaniteTorpedoWeapon

VOS0031 = Class(CAirUnit) {
    DestroySeconds = 7.5,          
    Weapons = {
        Bomb = Class(CIFNaniteTorpedoWeapon) {},
    },
}
TypeClass = VOS0031
