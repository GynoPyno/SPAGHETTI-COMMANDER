#****************************************************************************
#**
#**  File     :  /data/units/XAL0203/XAL0203_script.lua
#**  Author(s):  Jessica St. Croix
#**
#**  Summary  :  Aeon Assault Tank Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local AHoverLandUnit = import('/lua/aeonunits.lua').AHoverLandUnit
local AWeapons = import('/lua/aeonweapons.lua')
local ADFCannonOblivionWeapon = AWeapons.ADFCannonOblivionWeapon

WAL0305 = Class(AHoverLandUnit) {
    Weapons = {
        MainGun = Class(ADFCannonOblivionWeapon) {}
    },
}
TypeClass = WAL0305