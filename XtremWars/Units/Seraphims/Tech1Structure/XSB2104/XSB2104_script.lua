#****************************************************************************
#**
#**  File     :  /cdimage/units/XSB2104/XSB2104_script.lua
#**
#**  Summary  :  Seraphim Anti-Air Gun Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local SLandUnit = import('/lua/seraphimunits.lua').SLandUnit
local SAAShleoCannonWeapon = import('/lua/seraphimweapons.lua').SAAShleoCannonWeapon

XSB2104 = Class(SLandUnit) {

    Weapons = {
        UpgradeGun01 = Class(SAAShleoCannonWeapon) {
            FxMuzzleScale = 2.25,
        },
    },
    OnCreate = function(self)
		SLandUnit.OnCreate(self)
		self:HideBone('Turret_Barrel', true)
    end,
	

}

TypeClass = XSB2104
