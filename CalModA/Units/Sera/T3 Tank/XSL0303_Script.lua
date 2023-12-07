--****************************************************************************
--**
--**  File     :  /cdimage/units/XSL0303/XSL0303_script.lua
--**  Author(s):  Dru Staltman, Aaron Lundquist
--**
--**  Summary  :  Seraphim Siege Tank Script
--**
--**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
--****************************************************************************

local SLandUnit = import("/lua/seraphimunits.lua").SLandUnit
local SANUallCavitationTorpedo = import("/lua/seraphimweapons.lua").SANUallCavitationTorpedo
local TDFHiroPlasmaCannon = import("/lua/terranweapons.lua").TDFHiroPlasmaCannon

---@class XSL0303 : SLandUnit
XSL0303 = ClassUnit(SLandUnit) {
    Weapons = {
        MainTurret = ClassWeapon(TDFHiroPlasmaCannon) {},
        LeftTurret = ClassWeapon(SANUallCavitationTorpedo) {},
        RightTurret = ClassWeapon(SANUallCavitationTorpedo) {},
    },
}

TypeClass = XSL0303