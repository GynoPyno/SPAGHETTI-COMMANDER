#****************************************************************************
#**
#**  File     : /lua/terranprojectiles.lua
#**  Author(s): John Comes, Gordon Duclos, Matt Vainio
#**
#**  Summary  :
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
#------------------------------------------------------------------------
#  TERRAN PROJECTILES SCRIPTS
#------------------------------------------------------------------------
local Projectile = import('/lua/sim/projectile.lua').Projectile
local DefaultProjectileFile = import('/lua/sim/defaultprojectiles.lua')
local EmitterProjectile = DefaultProjectileFile.EmitterProjectile
local OnWaterEntryEmitterProjectile = DefaultProjectileFile.OnWaterEntryEmitterProjectile
local SingleBeamProjectile = DefaultProjectileFile.SingleBeamProjectile
local SinglePolyTrailProjectile = DefaultProjectileFile.SinglePolyTrailProjectile
local MultiPolyTrailProjectile = DefaultProjectileFile.MultiPolyTrailProjectile
local SingleCompositeEmitterProjectile = DefaultProjectileFile.SingleCompositeEmitterProjectile
local Explosion = import('/lua/defaultexplosions.lua')
local EffectTemplate = import('/mods/Savers Mech Ramrod/lua/Ramrod_Effect.lua')
local DepthCharge = import('/lua/defaultantiprojectile.lua').DepthCharge
local util = import('/lua/utilities.lua')


#------------------------------------------------------------------------
#  TERRAN HEAVY PLASMA CANNON PROJECTILES
#------------------------------------------------------------------------
THeavyPlasmaCannonProjectile = Class(MultiPolyTrailProjectile) {
    FxTrails = EffectTemplate.TPlasmaCannonHeavyMunition,
    RandomPolyTrails = 0,
    PolyTrailOffset = {0,0,0},
    PolyTrails = EffectTemplate.TPlasmaCannonHeavyPolyTrails,
    FxImpactUnit = EffectTemplate.TPlasmaCannonHeavyHitUnit01,
    FxImpactProp = EffectTemplate.TPlasmaCannonHeavyHitUnit01,
    FxImpactLand = EffectTemplate.TPlasmaCannonHeavyHit01,
}


