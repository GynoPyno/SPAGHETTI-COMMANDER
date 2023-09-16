#****************************************************************************
#**
#**  File     :  /units/XSB2105/XSB2105_script.lua
#**
#**  Summary  :  Seraphim Anti-Air Gun Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local SAirUnit = import('/lua/seraphimunits.lua').SAirUnit
local SAAShleoCannonWeapon = import('/lua/seraphimweapons.lua').SAAShleoCannonWeapon

XSB2105 = Class(SAirUnit) {

    Weapons = {
        UpgradeGun01 = Class(SAAShleoCannonWeapon) {
            FxMuzzleScale = 2.25,
        },
    },
    OnCreate = function(self)
		SAirUnit.OnCreate(self)
		self:HideBone('Turret_Barrel', true)
    end,

	
}

TypeClass = XSB2105
