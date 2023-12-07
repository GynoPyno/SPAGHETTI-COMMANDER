#****************************************************************************
#**
#**  File     :  /data/lua/cybranprojectiles.lua
#**  Author(s): John Comes, Gordon Duclos
#**
#**  Summary  :
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
#------------------------------------------------------------------------
#  CYBRAN PROJECILES SCRIPTS
#------------------------------------------------------------------------
local DefaultProjectileFile = import('/lua/sim/defaultprojectiles.lua')
local EmitterProjectile = DefaultProjectileFile.EmitterProjectile
local OnWaterEntryEmitterProjectile = DefaultProjectileFile.OnWaterEntryEmitterProjectile
local SingleBeamProjectile = DefaultProjectileFile.SingleBeamProjectile
local MultiBeamProjectile = DefaultProjectileFile.MultiBeamProjectile
local SinglePolyTrailProjectile = DefaultProjectileFile.SinglePolyTrailProjectile
local MultiPolyTrailProjectile = DefaultProjectileFile.MultiPolyTrailProjectile 
local SingleCompositeEmitterProjectile = DefaultProjectileFile.SingleCompositeEmitterProjectile
local DepthCharge = import('/lua/defaultantiprojectile.lua').DepthCharge
local NullShell = DefaultProjectileFile.NullShell
local EffectTemplate = import('/lua/EffectTemplates.lua')
local RandomFloat = import('/lua/utilities.lua').GetRandomFloat


#------------------------------------------------------------------------
#  NANITE MISSILE PROJECTILE
#------------------------------------------------------------------------
CAAMissileNaniteProjectile = Class(SingleCompositeEmitterProjectile) {
# Emitter Values
    FxTrails = {},
    FxTrailOffset = 0.05,
    PolyTrail =  EffectTemplate.CNanoDartPolyTrail01, ###'/effects/emitters/caamissilenanite01_polytrail_01_emit.bp',
    BeamName = '/effects/emitters/missile_nanite_exhaust_beam_01_emit.bp',

    # Hit Effects
    FxUnitHitScale = 0.5,
    FxImpactAirUnit = EffectTemplate.CNanoDartUnitHit01,
    FxImpactNone = EffectTemplate.CNanoDartUnitHit01,
    FxImpactUnit = EffectTemplate.CNanoDartUnitHit01,
    FxImpactProp = EffectTemplate.CNanoDartUnitHit01,
    FxLandHitScale = 0.5,
    FxImpactLand = EffectTemplate.CMissileHit01,
    FxImpactUnderWater = {},
}

CAAMissileNaniteProjectile03 = Class(CAAMissileNaniteProjectile) {
    ###PolyTrail = '/effects/emitters/caamissilenanite01_polytrail_02_emit.bp',
}

