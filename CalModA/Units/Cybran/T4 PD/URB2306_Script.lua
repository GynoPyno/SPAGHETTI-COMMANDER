#****************************************************************************
#**
#**  File     :  /cdimage/units/URB2301/URB2301_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Cybran Heavy Gun Tower Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CStructureUnit = import('/lua/cybranunits.lua').CStructureUnit
local CDFHeavyMicrowaveLaserGeneratorCom = import('/lua/cybranweapons.lua').CDFHeavyMicrowaveLaserGeneratorCom


URB2301 = Class(CStructureUnit) {
    Weapons = {
        MainGun = Class(CDFHeavyMicrowaveLaserGeneratorCom) {},
    },
}

TypeClass = URB2301