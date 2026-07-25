#
# UEF Marv Cannon projectile
#
local AOblivionCannonProjectile = import('/lua/aeonprojectiles.lua').AOblivionCannonProjectile
local RandomFloat = import('/lua/utilities.lua').GetRandomFloat

local EffectTemplate = import('/lua/EffectTemplates.lua')

Marv_Projectile = Class(AOblivionCannonProjectile) {
	FxTrails = {'/Mods/#Marlos mods compilation/effects/emitters/MARV_cannon_munition_02_emit.bp'},
	
    OnImpact = function(self, TargetType, targetEntity)
		if TargetType != 'Water' then 
			local rotation = RandomFloat(0,2*math.pi)
			local size = RandomFloat(3.75,5.0)
	        
			CreateDecal(self:GetPosition(), rotation, 'scorch_001_albedo', '', 'Albedo', size, size, 150, 15, self:GetArmy())
		end	 
		AOblivionCannonProjectile.OnImpact( self, TargetType, targetEntity )
    end,	
}
TypeClass = Marv_Projectile