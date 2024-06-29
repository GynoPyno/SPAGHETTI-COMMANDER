#****************************************************************************
#**
#**  File     :  /cdimage/units/XSL0203/XSL0203_script.lua
#**  Author(s):  Greg Kohne, Gordon Duclos
#**
#**  Summary  :  Seraphim Amphibious Tank Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local SHoverLandUnit = import('/lua/seraphimunits.lua').SHoverLandUnit
local SDFThauCannon = import('/lua/seraphimweapons.lua').SDFThauCannon
local SAAOlarisCannonWeapon = import('/lua/seraphimweapons.lua').SAAOlarisCannonWeapon

XSL0203 = Class(SHoverLandUnit) {
    Weapons = {
        TauCannon01 = Class(SDFThauCannon){
			FxMuzzleFlashScale = 0.5,
        },
		TauCannon02 = Class(SDFThauCannon){
			FxMuzzleFlashScale = 0.5,
        },
		AAGun01 = Class(SAAOlarisCannonWeapon) {},	
		AAGun02 = Class(SAAOlarisCannonWeapon) {},	
		AAGun03 = Class(SAAOlarisCannonWeapon) {},	
		AAGun04 = Class(SAAOlarisCannonWeapon) {},	
    },
	
    OnCreate = function(self)
		SHoverLandUnit.OnCreate(self)
    end,

}
TypeClass = XSL0203