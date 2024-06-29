local WeaponFile = import('/lua/sim/DefaultWeapons.lua')
local KamikazeWeapon = WeaponFile.KamikazeWeapon
local BareBonesWeapon = WeaponFile.BareBonesWeapon
local DefaultProjectileWeapon = WeaponFile.DefaultProjectileWeapon
local DefaultBeamWeapon = WeaponFile.DefaultBeamWeapon

local CollisionBeamFile = import('/lua/defaultcollisionbeams.lua')
local TMCollisionBeamFile = import('/mods/TotalMayhem/lua/TMcollisionbeams.lua')
local Explosion = import('/lua/defaultexplosions.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TMEffectTemplate = import('/mods/TotalMayhem/lua/TMEffectTemplates.lua')
local Util = import('/lua/utilities.lua')
local TMNovaCatBlueLaserBeam = TMCollisionBeamFile.TMNovaCatBlueLaserBeam
local TMNovaCatGreenLaserBeam = TMCollisionBeamFile.TMNovaCatGreenLaserBeam
local TMMizuraBlueLaserBeam = TMCollisionBeamFile.TMMizuraBlueLaserBeam
local TMMadCatmk4Beam = TMCollisionBeamFile.TMMadCatmk4Beam
local TMSpiderBeam = TMCollisionBeamFile.TMSpiderBeam

TMAnovacatbluelaserweapon = Class(DefaultBeamWeapon) {
    BeamType = TMCollisionBeamFile.TMNovaCatBlueLaserBeam,
    FxMuzzleFlash = {},
    FxChargeMuzzleFlash = {},
    FxUpackingChargeEffects = EffectTemplate.CMicrowaveLaserCharge01,
    FxUpackingChargeEffectScale = 1,
}

TMCSpiderLaserweapon = Class(DefaultBeamWeapon) {
    BeamType = TMCollisionBeamFile.TMSpiderBeam,
    FxMuzzleFlash = EffectTemplate.SExperimentalUnstablePhasonLaserMuzzle01,
    FxChargeMuzzleFlash = {},
    FxUpackingChargeEffects = EffectTemplate.CMicrowaveLaserCharge01,
    FxUpackingChargeEffectScale = 2,
}

TMAcougarbluelaserweapon = Class(DefaultBeamWeapon) {
    BeamType = TMCollisionBeamFile.TMCougarBlueLaserBeam,
    FxMuzzleFlash = {},
    FxChargeMuzzleFlash = {},
    FxUpackingChargeEffects = EffectTemplate.CMicrowaveLaserCharge01,
    FxUpackingChargeEffectScale = 1,
}

TMAnovacatgreenlaserweapon = Class(DefaultBeamWeapon) {
    BeamType = TMCollisionBeamFile.TMNovaCatGreenLaserBeam,
    FxMuzzleFlash = {},
    FxChargeMuzzleFlash = EffectTemplate.SDFExperimentalPhasonProjChargeMuzzleFlash,
    FxUpackingChargeEffects = EffectTemplate.SDFExperimentalPhasonProjChargeMuzzleFlash,
    FxUpackingChargeEffectScale = 1,
}

TMAmizurabluelaserweapon = Class(DefaultBeamWeapon) {
    BeamType = TMCollisionBeamFile.TMMizuraBlueLaserBeam,
    FxMuzzleFlash = {},
    FxChargeMuzzleFlash = {},
    FxUpackingChargeEffects = EffectTemplate.CMicrowaveLaserCharge01,
    FxUpackingChargeEffectScale = 1,
}

TMMadCatmk4laserweapon = Class(DefaultBeamWeapon) {
    BeamType = TMCollisionBeamFile.TMMadCatmk4Beam,
    FxMuzzleFlash = {},
    FxChargeMuzzleFlash = {},
    FxUpackingChargeEffects = EffectTemplate.CMicrowaveLaserCharge01,
    FxUpackingChargeEffectScale = 1,
}