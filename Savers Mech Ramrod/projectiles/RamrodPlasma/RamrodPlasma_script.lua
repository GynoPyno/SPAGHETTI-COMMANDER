#
# UEF Ramrod Heavy Plasma bolt
#
local THeavyPlasmaCannonProjectile = import('/mods/Savers Mech Ramrod/lua/Plasmaprojektil.lua').THeavyPlasmaCannonProjectile

TDFPlasmaHeavy03 = Class(THeavyPlasmaCannonProjectile) {
    PolyTrailScale = 20, 
    FxTrailScale = 2,
    FxNoneHitScale = 1.0,
    FxUnderWaterHitScale = 5,
    FxWaterHitScale = 6,
    FxLandHitScale = 1.0,
    FxUnitHitScale = 1.0,
	OnImpact = function(self, targetType, targetEntity)
        local pos = self:GetPosition()
        local radius = self.DamageData.DamageRadius
        local FriendlyFire = self.DamageData.DamageFriendly and radius ~=0
        
        DamageArea( self, pos, 0.5, 1, 'Force', FriendlyFire )
        DamageArea( self, pos, 0.5, 1, 'Force', FriendlyFire )

        self.DamageData.DamageAmount = self.DamageData.DamageAmount - 2
        
        if targetType ~= 'Shield' and targetType ~= 'Water' and targetType ~= 'Air' and targetType ~= 'UnitAir' and targetType ~= 'Projectile' and targetType ~= 'Unit' then
            local RandomFloat = import('/lua/utilities.lua').GetRandomFloat
            local rotation = RandomFloat(0,2*math.pi)
            local army = self.Army

            CreateDecal(pos, rotation, 'nuke_scorch_002_albedo', '', 'Albedo', 3, 3, 50, 15, army)
        end
        
        THeavyPlasmaCannonProjectile.OnImpact(self, targetType, targetEntity)
    end,
}
TypeClass = TDFPlasmaHeavy03

