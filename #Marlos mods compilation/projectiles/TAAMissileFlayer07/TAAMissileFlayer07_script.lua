#
# Terran Anti Air Missile
#
local TMissileAAProjectile = import('/lua/terranprojectiles.lua').TMissileAAProjectile
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TNapalmHvyCarpetBombProjectile = import('/lua/terranprojectiles.lua').TNapalmHvyCarpetBombProjectile
local RandomFloat = import('/lua/utilities.lua').GetRandomFloat

TAAMissileFlayer01 = Class(TMissileAAProjectile) {

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
        local ChildProjectileBP = '/projectiles/TIFNapalmCarpetBomb02/TIFNapalmCarpetBomb02_proj.bp'  
        
        local vx, vy, vz = self:GetVelocity()
        local velocity = 1
		
        self:CreateChildProjectile(ChildProjectileBP):SetVelocity(vx, vy, vz):SetVelocity(velocity):PassDamageData(self.DamageData)
		
		if TargetType != 'Water' then 
			local rotation = RandomFloat(0,2*math.pi)
			local size = RandomFloat(3.75,5.0)
	        
			CreateDecal(self:GetPosition(), rotation, 'scorch_001_albedo', '', 'Albedo', size, size, 150, 15, self:GetArmy())
		end	 
		TMissileAAProjectile.OnImpact( self, TargetType, targetEntity )
    end,	
	
}

TypeClass = TAAMissileFlayer01

