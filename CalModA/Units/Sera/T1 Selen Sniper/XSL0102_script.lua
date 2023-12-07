-----------------------------------------------------------------
-- File     :  /cdimage/units/XSL0101/XSL0101_script.lua
-- Summary  :  Seraphim Land Scout Script
-- Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
-----------------------------------------------------------------

---@alias SelenBuffType "SELENCLOAKBONUS"
---@alias SelenBuffName "SelenCloakVisionDebuff"

local SWalkingLandUnit = import("/lua/seraphimunits.lua").SWalkingLandUnit
local SDFPhasicAutoGunWeapon = import("/lua/seraphimweapons.lua").SDFPhasicAutoGunWeapon

---@class XSL0101 : SWalkingLandUnit
XSL0101 = ClassUnit(SWalkingLandUnit) {
    Weapons = {
        LaserTurret = ClassWeapon(SDFPhasicAutoGunWeapon) {},
    },
}

TypeClass = XSL0101
