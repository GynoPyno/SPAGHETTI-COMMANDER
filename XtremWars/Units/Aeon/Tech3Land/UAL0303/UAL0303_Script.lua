#****************************************************************************
#**
#**  File     :  /cdimage/units/UAL0303/UAL0303_script.lua
#**  Author(s):  John Comes, David Tomandl
#**
#**  Summary  :  Aeon Siege Assault Bot Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local AWalkingLandUnit = import( '/lua/aeonunits.lua').AWalkingLandUnit
local ADFLaserHighIntensityWeapon = import('/lua/aeonweapons.lua').ADFLaserHighIntensityWeapon
local ADFDisruptorCannonWeapon = import('/lua/aeonweapons.lua').ADFDisruptorWeapon
local EffectUtil = import('/lua/EffectUtilities.lua')

UAL0303 = Class(AWalkingLandUnit) {    

    CreateBuildEffects = function( self, unitBeingBuilt, order )
        EffectUtil.CreateAeonCommanderBuildingEffects( self, unitBeingBuilt, self:GetBlueprint().General.BuildBones.BuildEffectBones, self.BuildEffectsBag )
    end,  


    Weapons = {
        FrontTurret01 = Class(ADFLaserHighIntensityWeapon) {},
		###UPGRADE2
		Upgrade02Weapon = Class(ADFLaserHighIntensityWeapon) {},
		###UPGRADE3
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

TypeClass = UAL0303