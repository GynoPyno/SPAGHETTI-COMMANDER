--[[#######################################################################
#  File     :  /hook/lua/modweapons.lua
#  Author(s):  John Comes, David Tomandl, Gordon Duclos
#  Summary  :  Mod specific weapon definitions
#  -----------------------------
#  Modif.by :  Asdrubaelvect
#  Rev.Date :  jj mmmmmm 2009
#  -----------------------------
#  -----------------------------
#  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#######################################################################]]--

local BareBonesWeapon = WeaponFile.BareBonesWeapon
local TractorClawCollisionBeam = CollisionBeamFile.TractorClawCollisionBeam
local TractorClawCollisionBeam02 = CollisionBeamFile.TractorClawCollisionBeam02

CDFHeavyMicrowaveLaserGeneratorCom = Class(DefaultBeamWeapon) {
    BeamType = CollisionBeamFile.MicrowaveLaserCollisionBeam02,
    FxMuzzleFlash = {},
    FxChargeMuzzleFlash = {},
    FxUpackingChargeEffects = EffectTemplate.CMicrowaveLaserCharge01,
    FxUpackingChargeEffectsScale = 5,
    FxUpackingChargeEffectScale = 5,
    FxMuzzleFlashScale = 5,
    FxChargeMuzzleFlash = 5,
}

CDFHeavyMicrowaveLaserGeneratorDefense =  Class(DefaultBeamWeapon) {
    BeamType = CollisionBeamFile.MicrowaveLaserCollisionBeam03,
    FxMuzzleFlash = {'/effects/emitters/laserturret_muzzle_flash_01_emit.bp',},
    FxChargeMuzzleFlash = {},
    FxUpackingChargeEffects = EffectTemplate.CMicrowaveLaserCharge01,
    FxUpackingChargeEffectScale = 0.5,

    PlayFxWeaponUnpackSequence = function( self )
        if not self:EconomySupportsBeam() then return end
        local army = self.unit:GetArmy()
        local bp = self:GetBlueprint()
        for k, v in self.FxUpackingChargeEffects do
            for ek, ev in bp.RackBones[self.CurrentRackSalvoNumber].MuzzleBones do 
                CreateAttachedEmitter(self.unit, ev, army, v):ScaleEmitter(self.FxUpackingChargeEffectScale)  
            end
        end
        DefaultBeamWeapon.PlayFxWeaponUnpackSequence(self)
    end,
}

CDFHeavyMicrowaveLaserGeneratorCom02 = Class(DefaultBeamWeapon) {
    BeamType = CollisionBeamFile.MicrowaveLaserCollisionBeam03,
    FxMuzzleFlash = {},
    FxChargeMuzzleFlash = {},
    FxUpackingChargeEffects = EffectTemplate.CMicrowaveLaserCharge01,
    FxUpackingChargeEffectsScale = 0.1,
    FxUpackingChargeEffectScale = 0.1,
    FxMuzzleFlashScale = 0.1,
    FxChargeMuzzleFlash = 0.1,

}
