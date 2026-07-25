#****************************************************************************
#**
#**  File     :  /cdimage/units/UAS0201/UAS0201_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Aeon Destroyer Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local ASeaUnit = import('/lua/aeonunits.lua').ASeaUnit
local AeonWeapons = import('/lua/aeonweapons.lua')
local ADFCannonOblivionWeapon = AeonWeapons.ADFCannonOblivionWeapon
local AANChronoTorpedoWeapon = AeonWeapons.AANChronoTorpedoWeapon


UAS0201 = Class(ASeaUnit) {
    BackWakeEffect = {},
    Weapons = {
        FrontTurret01 = Class(ADFCannonOblivionWeapon) {},
        FrontTurret02 = Class(ADFCannonOblivionWeapon) {},
        FrontTurret03 = Class(ADFCannonOblivionWeapon) {},
        FrontTurret04 = Class(ADFCannonOblivionWeapon) {},
        Torpedo1 = Class(AANChronoTorpedoWeapon) {},
    },
}

TypeClass = UAS0201