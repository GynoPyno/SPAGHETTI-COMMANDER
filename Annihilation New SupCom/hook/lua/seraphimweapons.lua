--[[#######################################################################
#  File     :  /hook/lua/seraphweapons.lua
#  Author(s):  Greg Kohne, Gordon Duclos, Matt Vainio, Aaron Lundquist,
#                          Dru Staltman, Jessica St. Croix
#  Summary  :  Definitions of Seraphim Weapons for the Mod Exp Wars
#  -----------------------------
#  Modif.by :  AsdrubaelVect
#  Rev.Date :  5 septembre 2009
#  -----------------------------
#  Revis.by :  Manimal -> Restructuration
#  Rev.Date :  07 avril 2010
#  -----------------------------
#  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#######################################################################]]--


local Weapons = import( '/lua/sim/DefaultWeapons.lua' )
local DefaultBeamWeapon = Weapons.DefaultBeamWeapon
local DefaultProjectileWeapon = Weapons.DefaultProjectileWeapon

local CollisionBeams = import( '/lua/defaultcollisionbeams.lua' )

local EffectTemplate = import( '/lua/EffectTemplates.lua' )


SDFHeavyQuarnon01Cannon = Class( DefaultProjectileWeapon ) {
	FxMuzzleFlash = EffectTemplate.SHeavyQuarnonCannonMuzzleFlash,
}


SDFUltraChromaticBeamGenerator = Class( DefaultBeamWeapon ) {
    BeamType = CollisionBeams.UnstablePhasonLaserCollisionBeam,
	FxBeamTypeScale = 0.1,
    FxMuzzleFlash = {},
	FxMuzzleFlashScale = 0.1,
    FxChargeMuzzleFlash = {},
	FxChargeMuzzleFlashScale = 0.1,
    FxUpackingChargeEffects = EffectTemplate.SChargeUltraChromaticBeamGenerator,
    FxUpackingChargeEffectScale = 0.1,
    FxChargeMuzzleFlashScale = 0.1,
	ChargeEffectMuzzlesScale = 0.1,

    PlayFxWeaponUnpackSequence = function( self )
        if not self.ContBeamOn then
            local army = self.unit:GetArmy()
            local bp = self:GetBlueprint()
            for k, v in self.FxUpackingChargeEffects do
                for ek, ev in bp.RackBones[self.CurrentRackSalvoNumber].MuzzleBones do
                    CreateAttachedEmitter( self.unit, ev, army, v ):ScaleEmitter( self.FxUpackingChargeEffectScale )
                end
            end
            DefaultBeamWeapon.PlayFxWeaponUnpackSequence( self )
        end
    end,
}

SIFCommanderDeathWeapon = Class(BareBonesWeapon) {
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

SAALosaareAutoCannonWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.SLosaareAutoCannonMuzzleFlash,
}

SDFExperimentalPhasonLaser = Class(DefaultBeamWeapon) {
    BeamType = CollisionBeamFile.ExperimentalPhasonLaserCollisionBeam,
    FxMuzzleFlash = {},
    FxChargeMuzzleFlash = {},
    FxUpackingChargeEffects = EffectTemplate.SChargeExperimentalPhasonLaser,
    FxUpackingChargeEffectScale = 1,

    PlayFxWeaponUnpackSequence = function( self )
        if not self.ContBeamOn then
            local army = self.unit:GetArmy()
            local bp = self:GetBlueprint()
            for k, v in self.FxUpackingChargeEffects do
                for ek, ev in bp.RackBones[self.CurrentRackSalvoNumber].MuzzleBones do
                    CreateAttachedEmitter(self.unit, ev, army, v):ScaleEmitter(self.FxUpackingChargeEffectScale)
                end
            end
            DefaultBeamWeapon.PlayFxWeaponUnpackSequence(self)
        end
    end,
}

SIFExperimentalStrategicMissile = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.SIFExperimentalStrategicMissileLaunch01,
    FxChargeMuzzleFlash = EffectTemplate.SIFExperimentalStrategicMissileChargeLaunch01,
}
