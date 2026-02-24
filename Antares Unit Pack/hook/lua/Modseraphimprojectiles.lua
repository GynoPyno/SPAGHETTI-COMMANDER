#------------------------------------------------------------------------
#  SERAPHIM PROJECTILES SCRIPTS
#------------------------------------------------------------------------
local DefaultProjectileFile = import('/lua/sim/defaultprojectiles.lua')
local SinglePolyTrailProjectile = DefaultProjectileFile.SinglePolyTrailProjectile
local MultiPolyTrailProjectile = DefaultProjectileFile.MultiPolyTrailProjectile 
local SingleBeamProjectile = DefaultProjectileFile.SingleBeamProjectile
local EffectTemplate = import('/mods/Antares Unit Pack/Hook/lua/ModEffectTemplates.lua')
local EmitterProjectile = DefaultProjectileFile.EmitterProjectile
local util = import('/lua/utilities.lua')

MultigunProjectile = Class(MultiPolyTrailProjectile) {
    FxImpactNone = EffectTemplate.MultiGunWeaponHit01,
    FxImpactUnit = EffectTemplate.MultigunWeaponHitUnit,
    FxImpactProp = EffectTemplate.MultiGunWeaponHit01,
    FxImpactLand = EffectTemplate.MultiGunWeaponHit01,
    FxImpactWater= EffectTemplate.MultiGunWeaponHit01,
    RandomPolyTrails = 1,
    
    PolyTrails = EffectTemplate.MultiGunWeaponPolytrails01,
    PolyTrailOffset = {0,0,0},
}
