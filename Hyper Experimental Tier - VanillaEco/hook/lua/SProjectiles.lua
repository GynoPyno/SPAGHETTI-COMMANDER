------------------------------------------------------------
--
--  File     :  /mods/Hyper Experimental Tier/hook/lua/SProjectiles.lua
--  Author(s):  Cmd Draven
--
--  Summary  : Seraphim Projectiles
--
------------------------------------------------------------

local DefaultProjectileFile = import('/lua/sim/defaultprojectiles.lua')
local MultiPolyTrailProjectile = DefaultProjectileFile.MultiPolyTrailProjectile
local Explosion = import('/lua/defaultexplosions.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local SinglePolyTrailProjectile = DefaultProjectileFile.SinglePolyTrailProjectile

--------------------------------------------------------------------------
--  SERAPHIM OHWALLI STRATEGIC CANNON PROJECTILE
--------------------------------------------------------------------------
SOhwalliStrategicCannonProjectile = Class(MultiPolyTrailProjectile) {
    FxTrails = EffectTemplate.SOhwalliBombFxTrails01,
    PolyTrails = EffectTemplate.SOhwalliBombPolyTrails,
    FxImpactUnit = {},
    FxImpactProp = {},
    FxImpactAirUnit = {},
    FxImpactLand = {},
    FxImpactUnderWater = {},
    PolyTrailOffset = {0,0},
}
------------------------------------------------------------------------
-- SERAPHIM LAANSE TACTICAL MISSILE FOR IHWATHA
------------------------------------------------------------------------
SLaanseWathTacticalMissile = Class(SinglePolyTrailProjectile) {
    FxImpactLand = EffectTemplate.SLaanseMissleHit,
    FxImpactProp = EffectTemplate.SLaanseMissleHitUnit,
    FxImpactUnderWater = {},
    FxImpactUnit = EffectTemplate.SLaanseMissleHitUnit,
    FxTrails = EffectTemplate.SLaanseMissleExhaust02,
    PolyTrail = EffectTemplate.SLaanseMissleExhaust01,

    OnCreate = function(self)
        SinglePolyTrailProjectile.OnCreate(self)
        self:SetCollisionShape('Sphere', 0, 0, 0, 1.0)
    end,
}
