--****************************************************************************
--**
--**  File     :  /cdimage/units/XSB2101/XSB2101_script.lua
--**  Author(s):  Drew Staltman, Gordon Duclos, Aaron Lundquist
--**
--**  Summary  :  Seraphim Light Laser Tower Script
--**
--**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
--****************************************************************************
local SStructureUnit = import("/lua/seraphimunits.lua").SStructureUnit
local SDFOhCannon = import("/lua/seraphimweapons.lua").SDFOhCannon
local WeaponsFile = import("/lua/terranweapons.lua")
local TDFHiroPlasmaCannon = WeaponsFile.TDFHiroPlasmaCannon

---@class XSB2101 : SStructureUnit
XSB2101 = ClassUnit(SStructureUnit) {
    Weapons = {
        MainGun = ClassWeapon(TDFHiroPlasmaCannon) {},
    },
}
TypeClass = XSB2101