#
# Terran Anti Air Missile
#
local TMissileAAProjectile = import('/lua/terranprojectiles.lua').TMissileAAProjectile
local TIFMissileNuke = import('/lua/terranprojectiles.lua').TIFMissileNuke

TAAMissileFlayer06 = Class(TMissileAAProjectile) {

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
	
    BeamName = '/effects/emitters/missile_exhaust_fire_beam_06_emit.bp',
    InitialEffects = {'/effects/emitters/nuke_munition_launch_trail_02_emit.bp',},
    LaunchEffects = {
        '/effects/emitters/nuke_munition_launch_trail_03_emit.bp',
        '/effects/emitters/nuke_munition_launch_trail_05_emit.bp',
    },
	ThrustEffects = {'/effects/emitters/nuke_munition_launch_trail_04_emit.bp',},
}

TypeClass = TAAMissileFlayer06

