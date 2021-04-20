#****************************************************************************
#**
#**  File     :  /lua/cybranweapons.lua
#**  Author(s):  David Tomandl, John Comes, Gordon Duclos
#**
#**  Summary  :  Cybran weapon definitions
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local WeaponFile = import('/lua/sim/DefaultWeapons.lua')
local KamikazeWeapon = WeaponFile.KamikazeWeapon
local BareBonesWeapon = WeaponFile.BareBonesWeapon
local DefaultProjectileWeapon = WeaponFile.DefaultProjectileWeapon
local DefaultBeamWeapon = WeaponFile.DefaultBeamWeapon

local CollisionBeamFile = import('/lua/defaultcollisionbeams.lua')
local Explosion = import('/lua/defaultexplosions.lua')
local EffectTemplate2 = import('/Mods/#Marlos mods compilation/lua/MKEffectTemplates.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local Util = import('/lua/utilities.lua')

local MKCollisionBeamFile = import('/Mods/#Marlos mods compilation/lua/MKDefaultCollisionBeams.lua')
local DreadnoughtLaserCollisionBeam = MKCollisionBeamFile.DreadnoughtLaserCollisionBeam
EmtBpPath = '/Mods/#Marlos mods compilation/effects/emitters/'

MARVArtilleryWeapon = Class(DefaultProjectileWeapon) {
	FxMuzzleFlash = {
    EmtBpPath .. 'MARV_artillery_muzzle_01_emit.bp',
	EmtBpPath .. 'MARV_artillery_muzzle_02_emit.bp',
	EmtBpPath .. 'MARV_artillery_muzzle_03_emit.bp',
	EmtBpPath .. 'MARV_artillery_muzzle_04_emit.bp',
	EmtBpPath .. 'MARV_artillery_muzzle_05_emit.bp',
	EmtBpPath .. 'MARV_artillery_muzzle_06_emit.bp',
	EmtBpPath .. 'MARV_artillery_muzzle_08_emit.bp',
	},
}

Fatboy2Weapon01 = Class(DefaultProjectileWeapon) {
	FxMuzzleFlash = {
    EmtBpPath .. 'w_u_gau02_l_01_flash_emit.bp',
    EmtBpPath .. 'w_u_gau02_l_02_fireline_emit.bp',
    EmtBpPath .. 'w_u_gau02_l_03_shockwave_emit.bp',
    EmtBpPath .. 'w_u_gau02_l_04_smoke_emit.bp',
    EmtBpPath .. 'w_u_gau02_l_05_flashdetail_emit.bp',
    EmtBpPath .. 'w_u_gau02_l_06_flashglow_emit.bp',
	},
    FxMuzzleFlashScale = 1.5,
}

Fatboy2Weapon02 = Class(DefaultProjectileWeapon) {
	FxMuzzleFlash = {
    EmtBpPath .. 'w_u_gau02_l_01_flash_emit.bp',
    EmtBpPath .. 'w_u_gau02_l_02_fireline_emit.bp',
    EmtBpPath .. 'w_u_gau02_l_03_shockwave_emit.bp',
    EmtBpPath .. 'w_u_gau02_l_04_smoke_emit.bp',
    EmtBpPath .. 'w_u_gau02_l_05_flashdetail_emit.bp',
    EmtBpPath .. 'w_u_gau02_l_06_flashglow_emit.bp',
	},
    FxMuzzleFlashScale = 0.8,
}

KingkriptorWeapon = Class(DefaultProjectileWeapon) {
	FxMuzzleFlash = {
	EmtBpPath .. 'w_u_hcn01_l_07_flash_emit.bp',
	EmtBpPath .. 'w_u_hcn01_l_08_firecloud_emit.bp',
	EmtBpPath .. 'w_u_hcn01_l_09_ring_emit.bp',
	EmtBpPath .. 'w_u_hcn01_l_13_backstreaks_emit.bp',
	EmtBpPath .. 'w_u_hcn01_l_14_backsmoke_emit.bp',
	EmtBpPath .. 'w_u_hcn01_l_15_backstreaks_emit.bp',
	EmtBpPath .. 'w_u_hcn01_l_16_backsmoke_emit.bp',
	EmtBpPath .. 'w_u_hcn01_l_17_flashline_emit.bp',
	},
    FxMuzzleFlashScale = 0.5,
    FxChargeMuzzleFlash = {
	EmtBpPath .. 'w_u_hcn01_l_18_preglow_emit.bp',
	EmtBpPath .. 'w_u_hcn01_l_19_preglow_emit.bp',
	EmtBpPath .. 'w_u_hcn01_l_20_preglow_emit.bp',
	EmtBpPath .. 'w_u_hcn01_l_21_preglow_emit.bp',
	EmtBpPath .. 'w_u_hcn01_l_22_predots_emit.bp',
	EmtBpPath .. 'w_u_hcn01_l_23_preinward_emit.bp',
	EmtBpPath .. 'w_u_hcn01_l_24_prelines_emit.bp',
	EmtBpPath .. 'w_u_hcn01_l_25_presmoke_emit.bp',
	EmtBpPath .. 'w_u_hcn01_l_26_prelargeglow_emit.bp',
    },
    FxChargeMuzzleFlashScale = 0.5,
}

-- KingkriptorWeapon = Class(DefaultProjectileWeapon) {
	-- FxMuzzleFlash = EffectTemplate2.MARVArtilleryWeaponFX
    -- FxChargeMuzzleFlash = {},
    -- FxUpackingChargeEffects = EffectTemplate.CMicrowaveLaserCharge01,
    -- FxUpackingChargeEffectScale = 0.0025,
-- }

DreadnoughtLaser = Class(DefaultBeamWeapon) {
    BeamType = MKCollisionBeamFile.DreadnoughtLaserCollisionBeam,
    FxMuzzleFlash = {},
    FxChargeMuzzleFlash = {},
    FxUpackingChargeEffects = EffectTemplate.CMicrowaveLaserCharge01,
    FxUpackingChargeEffectScale = 0.0025,

    PlayFxWeaponUnpackSequence = function(self)
        if not self.ContBeamOn then
            local army = self.unit:GetArmy()
            local bp = self:GetBlueprint()
            for k, v in self.FxUpackingChargeEffects do
                for ek, ev in bp.RackBones[self.CurrentRackSalvoNumber].MuzzleBones do
                    CreateAttachedEmitter(self.unit, ev, army, v):ScaleEmitter(self.FxUpackingChargeEffectScale):ScaleEmitter(0.0025)

                end
				
            end
            DefaultBeamWeapon.PlayFxWeaponUnpackSequence(self)
        end
    end,
}

BeamtankLaser = Class(DefaultBeamWeapon) {
    BeamType = MKCollisionBeamFile.BeamtankCollisionBeam,
    FxMuzzleFlash = {},
    FxChargeMuzzleFlash = {},
    FxUpackingChargeEffects = EffectTemplate.CMicrowaveLaserCharge01,
    FxUpackingChargeEffectScale = 0.0025,

    PlayFxWeaponUnpackSequence = function(self)
        if not self.ContBeamOn then
            local army = self.unit:GetArmy()
            local bp = self:GetBlueprint()
            for k, v in self.FxUpackingChargeEffects do
                for ek, ev in bp.RackBones[self.CurrentRackSalvoNumber].MuzzleBones do
                    CreateAttachedEmitter(self.unit, ev, army, v):ScaleEmitter(self.FxUpackingChargeEffectScale):ScaleEmitter(0.0025)

                end
				
            end
            DefaultBeamWeapon.PlayFxWeaponUnpackSequence(self)
        end
    end,
}

ColossusLaser = Class(DefaultBeamWeapon) {
    BeamType = MKCollisionBeamFile.ColossusLaserCollisionBeam,
    FxMuzzleFlash = {},
    FxChargeMuzzleFlash = {},
    FxUpackingChargeEffects = EffectTemplate.CMicrowaveLaserCharge01,
    FxUpackingChargeEffectScale = 2,

    PlayFxWeaponUnpackSequence = function(self)
        if not self.ContBeamOn then
            local army = self.unit:GetArmy()
            local bp = self:GetBlueprint()
            for k, v in self.FxUpackingChargeEffects do
                for ek, ev in bp.RackBones[self.CurrentRackSalvoNumber].MuzzleBones do
                    CreateAttachedEmitter(self.unit, ev, army, v):ScaleEmitter(self.FxUpackingChargeEffectScale):ScaleEmitter(2)

                end
				
            end
            DefaultBeamWeapon.PlayFxWeaponUnpackSequence(self)
        end
    end,
}

TIFGrenadeWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = {'/effects/emitters/antiair_muzzle_fire_02_emit.bp',}, 
}

MKZapperWeapon = Class(DefaultBeamWeapon) {

    BeamType = CollisionBeamFile.ZapperCollisionBeam,
    FxMuzzleFlash = {'/effects/emitters/cannon_muzzle_flash_01_emit.bp',}, 
}