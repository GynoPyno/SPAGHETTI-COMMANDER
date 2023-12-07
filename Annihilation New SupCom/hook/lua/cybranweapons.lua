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

local WeaponFile = import('/lua/sim/defaultweapons.lua')
local BareBonesWeapon = WeaponFile.BareBonesWeapon
local DefaultProjectileWeapon = WeaponFile.DefaultProjectileWeapon
local DefaultBeamWeapon = WeaponFile.DefaultBeamWeapon

local CollisionBeamFile = import( '/lua/defaultcollisionbeams.lua' )

local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')

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

CIFCommanderDeathWeapon = Class(BareBonesWeapon) {
    FiringMuzzleBones = {0}, # just fire from the base bone of the unit

    OnCreate = function(self)
        BareBonesWeapon.OnCreate(self)
        local myBlueprint = self:GetBlueprint()
        # The "or x" is supplying default values in case the blueprint doesn't have an overriding value
        self.Data = {
            NukeOuterRingDamage = myBlueprint.NukeOuterRingDamage or 10,
            NukeOuterRingRadius = myBlueprint.NukeOuterRingRadius or 40,
            NukeOuterRingTicks = myBlueprint.NukeOuterRingTicks or 20,
            NukeOuterRingTotalTime = myBlueprint.NukeOuterRingTotalTime or 10,

            NukeInnerRingDamage = myBlueprint.NukeInnerRingDamage or 2000,
            NukeInnerRingRadius = myBlueprint.NukeInnerRingRadius or 30,
            NukeInnerRingTicks = myBlueprint.NukeInnerRingTicks or 24,
            NukeInnerRingTotalTime = myBlueprint.NukeInnerRingTotalTime or 24,
        }
        self:SetWeaponEnabled(false)
    end,
        
    OnFire = function(self)

    end,
    
    Fire = function(self)
        local myBlueprint = self:GetBlueprint()
        local myProjectile = self.unit:CreateProjectile( myBlueprint.ProjectileId, 0, 0, 0, nil, nil, nil):SetCollision(false)
        myProjectile:PassDamageData(self:GetDamageTable())
        if self.Data then
            myProjectile:PassData(self.Data)
        end
    end,
}

CDFMicrowaveLaserGenerator = Class(DefaultBeamWeapon) {
    BeamType = CollisionBeamFile.MicrowaveLaserCollisionBeam02,
    FxMuzzleFlash = {},
}


