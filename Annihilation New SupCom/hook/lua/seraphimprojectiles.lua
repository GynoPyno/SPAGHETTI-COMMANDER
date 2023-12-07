#****************************************************************************
#**
#**  File     :  /cdimage/lua/seraphimprojectiles.lua
#**  Author(s):  Gordon Duclos, Greg Kohne, Matt Vainio, Aaron Lundquist
#**
#**  Summary  : Seraphim projectile base class definitions
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

#------------------------------------------------------------------------
#  SERAPHIM PROJECTILES SCRIPTS
#------------------------------------------------------------------------
local DefaultProjectileFile = import('/lua/sim/defaultprojectiles.lua')
local SinglePolyTrailProjectile = DefaultProjectileFile.SinglePolyTrailProjectile
local MultiPolyTrailProjectile = DefaultProjectileFile.MultiPolyTrailProjectile 
local SingleBeamProjectile = DefaultProjectileFile.SingleBeamProjectile
local EffectTemplate = import('/lua/EffectTemplates.lua')
local EmitterProjectile = DefaultProjectileFile.EmitterProjectile
local util = import('utilities.lua')
local RandomInt = util.GetRandomInt

#------------------------------------------------------------------------
#  SERAPHIM Inaino STRATEGIC MISSILE
#------------------------------------------------------------------------
SIFInainoStrategicMissile = Class(EmitterProjectile) {
    ###BeamName = '/effects/emitters/missile_exhaust_fire_beam_01_emit.bp',
	ExitWaterTicks = 9,
	FxExitWaterEmitter = EffectTemplate.DefaultProjectileWaterImpact,
    FxInitialAtEntityEmitter = {},
    FxImpactUnit = {},
    FxImpactLand = {},
    FxImpactUnderWater = {},
    FxLaunchTrails = {},
    FxOnEntityEmitter = {},
    FxSplashScale = 0.65,
    FxTrailOffset = -0.5,
    FxTrails = {'/effects/emitters/missile_cruise_munition_trail_01_emit.bp',},
    FxUnderWaterTrail = {'/effects/emitters/missile_cruise_munition_underwater_trail_01_emit.bp',},
}

#------------------------------------------------------------------------
#  SERAPHIM SUTHANUS ARTILLERY SHELL
#------------------------------------------------------------------------
SSuthanusArtilleryShell4 = Class(EmitterProjectile) {
	FxImpactTrajectoryAligned = false,
	FxImpactLand = EffectTemplate.SRifterArtilleryHit,
	FxImpactWater = EffectTemplate.SRifterArtilleryWaterHit,
    FxImpactNone = EffectTemplate.SRifterArtilleryHit,
    FxImpactProjectile = {},
    FxImpactProp = EffectTemplate.SRifterArtilleryHit,    
    FxImpactUnderWater = EffectTemplate.SRifterArtilleryWaterHit,
    FxImpactUnit = EffectTemplate.SRifterArtilleryHit,
    FxTrails = EffectTemplate.SRifterArtilleryProjectileFxTrails,
    PolyTrail = EffectTemplate.SRifterArtilleryProjectilePolyTrail,
}