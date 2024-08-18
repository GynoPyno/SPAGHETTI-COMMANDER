#****************************************************************************
#**
#**  File     :  /cdimage/units/UEA0303/UEA0303_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  UEF Supersonic Fighter Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TAirUnit = import('/lua/terranunits.lua').TAirUnit
local TWeapons = import('/lua/terranweapons.lua')
local TDFHeavyPlasmaCannonWeapon = TWeapons.TDFHeavyPlasmaCannonWeapon

UME_A0101 = Class(TAirUnit) {
    Weapons = {
        RightBeam = Class(TDFHeavyPlasmaCannonWeapon) {},
        LeftBeam = Class(TDFHeavyPlasmaCannonWeapon) {},
    },
}

TypeClass = UME_A0101