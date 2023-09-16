#****************************************************************************
#**
#**  File     :  /data/units/XAL0305/XAL0305_script.lua
#**  Author(s):  Jessica St. Croix
#**
#**  Summary  :  Aeon Sniper Bot Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local AWalkingLandUnit = import( '/lua/aeonunits.lua').AWalkingLandUnit
local ADFHeavyDisruptorCannonWeapon = import('/lua/aeonweapons.lua').ADFHeavyDisruptorCannonWeapon
local ADFDisruptorCannonWeapon = import('/lua/aeonweapons.lua').ADFDisruptorWeapon


XAL0305 = Class(AWalkingLandUnit) {
    Weapons = {
        MainGun = Class(ADFHeavyDisruptorCannonWeapon) {},
		Upgrade02Weapon = Class(ADFHeavyDisruptorCannonWeapon) {},
		Upgrade03Weapon = Class(ADFDisruptorCannonWeapon) {
			CreateProjectileAtMuzzle = function(self, muzzle)
                local proj = ADFDisruptorCannonWeapon.CreateProjectileAtMuzzle(self, muzzle)
                local data = self:GetBlueprint().DamageToShields
                if proj and not proj:BeenDestroyed() then
                    proj:PassData(data)
                end
            end,
		},
    },
	
	
	OnCreate = function(self)
        AWalkingLandUnit.OnCreate(self)
	
    end,

}

TypeClass = XAL0305