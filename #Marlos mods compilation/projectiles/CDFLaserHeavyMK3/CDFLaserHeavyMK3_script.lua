#
# Cybran laser 'bolt'
#
local CHeavyLaserProjectileMK3 = import('/Mods/#Marlos mods compilation/lua/MKProjectiles.lua').CHeavyLaserProjectileMK3
local RandomFloat = import('/lua/utilities.lua').GetRandomFloat
CDFLaserHeavy01 = Class(CHeavyLaserProjectileMK3) {

    FxAirUnitHitScale = 3,
    FxLandHitScale = 3,
    FxNoneHitScale = 3,
    FxPropHitScale = 3,
    FxProjectileHitScale = 3,
    FxProjectileUnderWaterHitScale = 3,
    FxShieldHitScale = 3,
    FxUnderWaterHitScale = 3,
    FxUnitHitScale = 3,
    FxWaterHitScale = 3,
    FxOnKilledScale = 3,


    OnImpact = function(self, TargetType, targetEntity)
		if TargetType != 'Water' then 
			local rotation = RandomFloat(0,2*math.pi)
			local size = RandomFloat(3.75,5.0)
	        
			CreateDecal(self:GetPosition(), rotation, 'scorch_001_albedo', '', 'Albedo', size, size, 150, 15, self:GetArmy())
		end
		CHeavyLaserProjectileMK3.OnImpact( self, TargetType, targetEntity )
    end,	

}

TypeClass = CDFLaserHeavy01

