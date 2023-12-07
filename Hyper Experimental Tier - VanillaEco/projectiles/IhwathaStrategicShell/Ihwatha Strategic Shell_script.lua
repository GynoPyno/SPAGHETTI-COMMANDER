#****************************************************************************
#**
#**  File     :  /mods/Hyper Experimental Tier/projectiles/Ihwatha Strategic Shell_script.lua
#**  Author(s):  Cmd Draven
#**
#**  Summary  :  Ohwalli-Strategic Bomb script, used on XSA402, turned into a Cannon/Shell re; T5SN0402
#**
#**  Copyright © Cmd Draven
#****************************************************************************
local SOhwalliStrategicCannonProjectile = import('/mods/Hyper Experimental Tier/hook/lua/SProjectiles.lua').SOhwalliStrategicCannonProjectile


SBOOhwalliStategicCannon = Class(SOhwalliStrategicCannonProjectile){
    OnImpact = function(self, targetType, targetEntity)
        local pos = self:GetPosition()
        local radius = self.DamageData.DamageRadius
        local FriendlyFire = self.DamageData.DamageFriendly and radius ~=0

        DamageArea( self, pos, radius, 1, 'Force', FriendlyFire )
        DamageArea( self, pos, radius, 1, 'Force', FriendlyFire )

        self.DamageData.DamageAmount = self.DamageData.DamageAmount - 2

        if targetType ~= 'Shield' and targetType ~= 'Water' and targetType ~= 'Air' and targetType ~= 'UnitAir' and targetType ~= 'Projectile' then
            self:CreateProjectile('/effects/entities/SBOOhwalliBombEffectController01/SBOOhwalliBombEffectController01_proj.bp', 0, 0, 0, 0, 0, 0):SetCollision(false)
        end
        SOhwalliStrategicCannonProjectile.OnImpact(self, targetType, targetEntity)
    end,
}
TypeClass = SBOOhwalliStategicCannon
