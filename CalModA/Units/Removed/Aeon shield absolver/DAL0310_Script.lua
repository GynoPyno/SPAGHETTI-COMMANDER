------------------------------------------------------------------------------
-- File     :  /cdimage/units/DAL0310/DAL0310_script.lua
-- Author(s):  Dru Staltman, Matt Vainio
-- Summary  :  Aeon Shield Disruptor Script
-- Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
------------------------------------------------------------------------------

--changes from ALandUnit to AHoverLandUnit
local AHoverLandUnit = import("/lua/aeonunits.lua").AHoverLandUnit

---@class DAL0310 : AHoverLandUnit
DAL0310 = ClassUnit(AHoverLandUnit) {
    Weapons = {
        MainGun = ClassWeapon(import("/lua/aeonweapons.lua").ADFCannonOblivionWeapon03) {}
    },
}
TypeClass = DAL0310

