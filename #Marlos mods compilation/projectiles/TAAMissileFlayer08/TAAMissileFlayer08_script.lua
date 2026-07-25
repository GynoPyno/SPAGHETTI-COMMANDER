#
# Terran Anti Air Missile
#
local TMissileAAProjectile = import('/lua/terranprojectiles.lua').TMissileAAProjectile
local EffectTemplate = import('/lua/EffectTemplates.lua')
local RandomFloat = import('/lua/utilities.lua').GetRandomFloat
local TIFMissileNuke = import('/lua/terranprojectiles.lua').TIFMissileNuke

TAAMissileFlayer01 = Class(TMissileAAProjectile) {

    FxAirUnitHitScale = 2,
    FxLandHitScale = 2,
    FxNoneHitScale = 2,
    FxPropHitScale = 2,
    FxProjectileHitScale = 2,
    FxProjectileUnderWaterHitScale = 2,
    FxShieldHitScale = 2,
    FxUnderWaterHitScale = 2,
    FxUnitHitScale = 2,
    FxWaterHitScale = 2,
    FxOnKilledScale = 2,	
	
    BeamName = '/effects/emitters/missile_exhaust_fire_beam_06_emit.bp',
    InitialEffects = {'/effects/emitters/nuke_munition_launch_trail_02_emit.bp',},
    LaunchEffects = {
        '/effects/emitters/nuke_munition_launch_trail_03_emit.bp',
        '/effects/emitters/nuke_munition_launch_trail_05_emit.bp',
    },
	ThrustEffects = {'/effects/emitters/nuke_munition_launch_trail_04_emit.bp',},
}

TypeClass = TAAMissileFlayer01

