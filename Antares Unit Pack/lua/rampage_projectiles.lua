local Projectile = import('/lua/sim/projectile.lua').Projectile
local DefaultProjectileFile = import('/lua/sim/defaultprojectiles.lua')
local EmitterProjectile = DefaultProjectileFile.EmitterProjectile
local OnWaterEntryEmitterProjectile = DefaultProjectileFile.OnWaterEntryEmitterProjectile
local SingleBeamProjectile = DefaultProjectileFile.SingleBeamProjectile
local SinglePolyTrailProjectile = DefaultProjectileFile.SinglePolyTrailProjectile
local MultiPolyTrailProjectile = DefaultProjectileFile.MultiPolyTrailProjectile
local SingleCompositeEmitterProjectile = DefaultProjectileFile.SingleCompositeEmitterProjectile
local Explosion = import('/lua/defaultexplosions.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local DepthCharge = import('/lua/defaultantiprojectile.lua').DepthCharge
local util = import('/lua/utilities.lua')
EmtBpPath = '/effects/emitters/'
MOD_BpPath = '/mods/Antares Unit Pack/effects/emitters/'

#------------------------------------------------------------------------
#  Rampage Naplam Missile
#------------------------------------------------------------------------
NapalmMissileProjectile = Class(SingleCompositeEmitterProjectile) {
# Emitter Values
    FxInitial = {},
    TrailDelay = 0,
    FxTrails = {'/effects/emitters/missile_sam_munition_trail_01_emit.bp',},
    FxTrailOffset = 0,

    PolyTrail = '/effects/emitters/default_polytrail_01_emit.bp',
    BeamName = '/effects/emitters/rocket_iridium_exhaust_beam_01_emit.bp',

    # Hit Effects
    FxImpactUnit = {
    #EmtBpPath .. 'napalm_flash_emit.bp',
    #EmtBpPath .. 'napalm_thick_smoke_emit.bp',
    MOD_BpPath  .. 'napalm_fire_emit_2.bp',
    EmtBpPath .. 'napalm_01_emit.bp',
    },
    FxImpactProp = {
    #EmtBpPath .. 'napalm_flash_emit.bp',
    #EmtBpPath .. 'napalm_thick_smoke_emit.bp',
    MOD_BpPath  .. 'napalm_fire_emit_2.bp',
    EmtBpPath .. 'napalm_01_emit.bp',
    },
    FxImpactLand = {
    #EmtBpPath .. 'napalm_flash_emit.bp',
    #EmtBpPath .. 'napalm_thick_smoke_emit.bp',
    MOD_BpPath  .. 'napalm_fire_emit_2.bp',
    EmtBpPath .. 'napalm_01_emit.bp',
    },
    FxImpactUnderWater = EffectTemplate.WaterSplash01,
}

#------------------------------------------------------------------------
#  Rampage EMP Overcharge
#------------------------------------------------------------------------
Over_ChargeProjectile = Class(MultiPolyTrailProjectile) {
    FxUnitHitScale = 1,
    FxLandHitScale = 1,
    FxPropHitScale = 1,
    FxAirHitScale = 1,
    PolyTrails = {
        '/effects/emitters/laserturret_munition_trail_01_emit.bp',
        '/effects/emitters/default_polytrail_06_emit.bp',
    },
    PolyTrailOffset = {0,0},
    BeamName = '/effects/emitters/laserturret_munition_beam_03_emit.bp',
    FxImpactUnit = EffectTemplate.TCommanderOverchargeHit01,
    FxImpactProp = EffectTemplate.TCommanderOverchargeHit01,
    FxImpactLand = EffectTemplate.TCommanderOverchargeHit01,
    FxImpactAirUnit = EffectTemplate.TCommanderOverchargeHit01,
    FxImpactUnderWater = {},
}

#------------------------------------------------------------------------
#  Rapage Rapid Plasma 
#------------------------------------------------------------------------
Rapid_PlasmaProjectile = Class(EmitterProjectile) {
    FxUnitHitScale = 1.0,
    FxLandHitScale = 1.0,
    FxPropHitScale = 1.0,

    FxTrails = {
        '/effects/emitters/aeon_missiled_wisp_04_emit.bp',
    },
    FxTrailScale = 0.3,

    # Hit Effects
    FxImpactUnit =  EffectTemplate.AQuarkBombHitUnit01,
    FxImpactProp =  EffectTemplate.AQuarkBombHitUnit01,
    FxImpactLand =  EffectTemplate.AQuarkBombHitLand01,
    FxImpactAirUnit =  EffectTemplate.AQuarkBombHitAirUnit01,
    FxImpactUnderWater = {},
}

