local CollisionBeam = import('/lua/sim/CollisionBeam.lua').CollisionBeam
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TMEffectTemplate = import('/mods/TotalMayhem/lua/TMEffectTemplates.lua')
local Util = import('/lua/utilities.lua')

TMCollisionBeam = Class(CollisionBeam) {
    FxImpactUnit = EffectTemplate.DefaultProjectileLandUnitImpact,
    FxImpactLand = {},#EffectTemplate.DefaultProjectileLandImpact,
    FxImpactWater = EffectTemplate.DefaultProjectileWaterImpact,
    FxImpactUnderWater = EffectTemplate.DefaultProjectileUnderWaterImpact,
    FxImpactAirUnit = EffectTemplate.DefaultProjectileAirUnitImpact,
    FxImpactProp = {},
    FxImpactShield = {},    
    FxImpactNone = {},
}

TMNovaCatBlueLaserBeam = Class(TMCollisionBeam) {
    TerrainImpactType = 'LargeBeam01',
    TerrainImpactScale = 0.2,
    FxBeamStartPointScale = 0.8,
    FxBeamStartPoint = EffectTemplate.SDFExperimentalPhasonProjMuzzleFlash,
    FxBeam = {'/mods/TotalMayhem/effects/emitters/novacat_bluelaser_emit.bp'},
    FxBeamEndPoint = TMEffectTemplate.AeonNocaCatBlueLaserHit,
    FxBeamEndPointScale = 0.5,
    SplatTexture = 'czar_mark01_albedo',
    ScorchSplatDropTime = 0.25,
}

TMCougarBlueLaserBeam = Class(TMCollisionBeam) {
    TerrainImpactType = 'LargeBeam01',
    TerrainImpactScale = 0.2,
    FxBeamStartPointScale = 0.35,
    FxBeamStartPoint = EffectTemplate.SDFExperimentalPhasonProjMuzzleFlash,
    FxBeam = {'/mods/TotalMayhem/effects/emitters/novacat_bluelaser_emit.bp'},
    FxBeamEndPoint = TMEffectTemplate.AeonCougarBlueLaserHit,
    FxBeamEndPointScale = 0.35,
    SplatTexture = 'czar_mark01_albedo',
    ScorchSplatDropTime = 0.25,
}

TMNovaCatGreenLaserBeam = Class(TMCollisionBeam) {
    TerrainImpactType = 'LargeBeam01',
    TerrainImpactScale = 0.2,
    FxBeamStartPointScale = 1.4,
    FxBeamStartPoint = EffectTemplate.SDFExperimentalPhasonProjMuzzleFlash,
    FxBeam = {'/mods/TotalMayhem/effects/emitters/novacat_greenlaser_emit.bp'},
    FxBeamEndPoint = EffectTemplate.APhasonLaserImpact01,
    FxBeamEndPointScale = 2.0,
    SplatTexture = 'czar_mark01_albedo',
    ScorchSplatDropTime = 0.25,
}

TMSpiderBeam = Class(TMCollisionBeam) {
    TerrainImpactType = 'LargeBeam01',
    TerrainImpactScale = 0.8,
    FxBeamStartPointScale = 1.4,
    FxBeamStartPoint = EffectTemplate.SDFExperimentalPhasonProjMuzzleFlash,
    FxBeam = {'/mods/TotalMayhem/effects/emitters/battlespider_laser_emit.bp'},
    FxBeamEndPoint = EffectTemplate.APhasonLaserImpact01,
    FxBeamEndPointScale = 2.0,
    SplatTexture = 'czar_mark01_albedo',
    ScorchSplatDropTime = 0.4,
}

TMMizuraBlueLaserBeam = Class(TMCollisionBeam) {
    TerrainImpactType = 'LargeBeam01',
    TerrainImpactScale = 0.2,
    FxBeamStartPointScale = 1.2,
    FxBeamStartPoint = EffectTemplate.ASDisruptorCannonMuzzle01,
    FxBeam = {'/mods/TotalMayhem/effects/emitters/mizura_bluelaser_emit.bp'},
    FxBeamEndPoint = TMEffectTemplate.AeonNocaCatBlueLaserHit,
    FxBeamEndPointScale = 0.07,
    SplatTexture = 'czar_mark01_albedo',
    ScorchSplatDropTime = 0.25,
}

TMMadCatmk4Beam = Class(TMCollisionBeam) {
    TerrainImpactType = 'LargeBeam01',
    TerrainImpactScale = 0.2,
    FxBeamStartPointScale = 1.2,
    FxBeamStartPoint = EffectTemplate.CMicrowaveLaserMuzzle01,
    FxBeam = {'/mods/TotalMayhem/effects/emitters/madcatmk4laser_emit.bp'},
    FxBeamEndPoint = EffectTemplate.CMicrowaveLaserEndPoint01,
    FxBeamEndPointScale = 1.00,
    SplatTexture = 'czar_mark01_albedo',
    ScorchSplatDropTime = 0.25,
}