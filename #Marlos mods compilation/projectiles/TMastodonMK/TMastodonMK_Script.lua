#****************************************************************************
#**
#**  File     :  /data/projectiles/CDFRocketIridium02/CDFRocketIridium02_script.lua
#**  Author(s):  Matt Vainio
#**
#**  Summary  :  Cybran Iridium Rocket Tubes, DRL0205
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local TMastodonMK = import('/Mods/#Marlos mods compilation/lua/MKProjectiles.lua').TMastodonMKProjectile
local RandomFloat = import('/lua/utilities.lua').GetRandomFloat

MKDFRocketIridium = Class(TMastodonMK) {

    FxAirUnitHitScale = 5,
    FxLandHitScale = 5,
    FxNoneHitScale = 5,
    FxPropHitScale = 5,
    FxProjectileHitScale = 5,
    FxProjectileUnderWaterHitScale = 5,
    FxShieldHitScale = 5,
    FxUnderWaterHitScale = 5,
    FxUnitHitScale = 5,
    FxWaterHitScale = 5,
    FxOnKilledScale = 5,


    OnImpact = function(self, TargetType, targetEntity)
		if TargetType != 'Water' then 
			local rotation = RandomFloat(0,2*math.pi)
			local size = RandomFloat(3.75,5.0)
	        
			CreateDecal(self:GetPosition(), rotation, 'scorch_001_albedo', '', 'Albedo', size, size, 150, 15, self:GetArmy())
		end
		TMastodonMK.OnImpact( self, TargetType, targetEntity )
    end,	
}

TypeClass = MKDFRocketIridium
