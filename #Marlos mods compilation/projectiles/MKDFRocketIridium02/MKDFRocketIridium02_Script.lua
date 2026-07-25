#****************************************************************************
#**
#**  File     :  /data/projectiles/CDFRocketIridium02/CDFRocketIridium02_script.lua
#**  Author(s):  Matt Vainio
#**
#**  Summary  :  Cybran Iridium Rocket Tubes, DRL0204
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local MKDFRocketIridium02 = import('/Mods/#Marlos mods compilation/lua/MKProjectiles.lua').MKIridiumRocketProjectile
local RandomFloat = import('/lua/utilities.lua').GetRandomFloat

MKDFRocketIridium = Class(MKDFRocketIridium02) {

    FxAirUnitHitScale = 4,
    FxLandHitScale = 4,
    FxNoneHitScale = 4,
    FxPropHitScale = 4,
    FxProjectileHitScale = 4,
    FxProjectileUnderWaterHitScale = 4,
    FxShieldHitScale = 4,
    FxUnderWaterHitScale = 4,
    FxUnitHitScale = 4,
    FxWaterHitScale = 4,
    FxOnKilledScale = 4,


    OnImpact = function(self, TargetType, targetEntity)
		if TargetType != 'Water' then 
			local rotation = RandomFloat(0,2*math.pi)
			local size = RandomFloat(3.75,5.0)
	        
			CreateDecal(self:GetPosition(), rotation, 'scorch_001_albedo', '', 'Albedo', size, size, 150, 15, self:GetArmy())
		end
		MKDFRocketIridium02.OnImpact( self, TargetType, targetEntity )
    end,	
}

TypeClass = MKDFRocketIridium
