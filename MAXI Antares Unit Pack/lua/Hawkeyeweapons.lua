#****************************************************************************
#**
#**  File     :  /cdimage/lua/modules/Hawkeyeweapons.lua
#**  Author(s):  Lt_hawkeye
#**
#**  Summary  :  
#**
#**  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local WeaponFile = import('/lua/sim/defaultweapons.lua')
local CollisionBeams = import('/lua/defaultcollisionbeams.lua')
local CollisionBeamFile = import('/lua/defaultcollisionbeams.lua')
local HawkeyeCollisionBeamFile = import('/mods/Antares Unit Pack/lua/hawkeyedefaultcollisionbeams.lua')
local MiniQuantumBeamGeneratorCollisionBeam = HawkeyeCollisionBeamFile.MiniQuantumBeamGeneratorCollisionBeam
local HawkTractorClawCollisionBeam = HawkeyeCollisionBeamFile.HawkTractorClawCollisionBeam
local MiniPhasonLaserCollisionBeam = HawkeyeCollisionBeamFile.MiniPhasonLaserCollisionBeam
local BareBonesWeapon = WeaponFile.BareBonesWeapon
local DefaultProjectileWeapon = WeaponFile.DefaultProjectileWeapon
local DefaultBeamWeapon = WeaponFile.DefaultBeamWeapon
local GinsuCollisionBeam = CollisionBeams.GinsuCollisionBeam
local EffectTemplate = import('/lua/EffectTemplates.lua')
local QuantumBeamGeneratorCollisionBeam = CollisionBeamFile.QuantumBeamGeneratorCollisionBeam
local PhasonLaserCollisionBeam = CollisionBeamFile.PhasonLaserCollisionBeam
local MicrowaveLaserCollisionBeam01 = CollisionBeamFile.MicrowaveLaserCollisionBeam01

HawkeyeAirGroundMissileWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.CZealotLaunch01,
}

HawkNapalmWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.TGaussCannonFlash,
}
MiniQuantumBeamGenerator = Class(DefaultBeamWeapon) {
    BeamType = MiniQuantumBeamGeneratorCollisionBeam,

    FxUpackingChargeEffects = {},#'/effects/emitters/quantum_generator_charge_01_emit.bp'},
    FxUpackingChargeEffectScale = 0.2,

    PlayFxWeaponUnpackSequence = function( self )
        local army = self.unit:GetArmy()
        local bp = self:GetBlueprint()
        for k, v in self.FxUpackingChargeEffects do
            for ek, ev in bp.RackBones[self.CurrentRackSalvoNumber].MuzzleBones do
                CreateAttachedEmitter(self.unit, ev, army, v):ScaleEmitter(self.FxUpackingChargeEffectScale):ScaleEmitter(0.2)
            end
        end
        DefaultBeamWeapon.PlayFxWeaponUnpackSequence(self)
    end,
}

MiniPhasonLaser = Class(DefaultBeamWeapon) {
    BeamType = HawkeyeCollisionBeamFile.MiniPhasonLaserCollisionBeam,
    FxMuzzleFlash = {},
    FxChargeMuzzleFlash = {},
    FxUpackingChargeEffects = EffectTemplate.CMicrowaveLaserCharge01,
    FxUpackingChargeEffectScale = 0.002,

    PlayFxWeaponUnpackSequence = function( self )
        if not self.ContBeamOn then
            local army = self.unit:GetArmy()
            local bp = self:GetBlueprint()
            for k, v in self.FxUpackingChargeEffects do
                for ek, ev in bp.RackBones[self.CurrentRackSalvoNumber].MuzzleBones do
                    CreateAttachedEmitter(self.unit, ev, army, v):ScaleEmitter(self.FxUpackingChargeEffectScale):ScaleEmitter(0.002)
                end
            end
            DefaultBeamWeapon.PlayFxWeaponUnpackSequence(self)
        end
    end,
}
# SPIDER BOT WEAPON!
MiniHeavyMicrowaveLaserGenerator = Class(DefaultBeamWeapon) {
    BeamType = HawkeyeCollisionBeamFile.MiniMicrowaveLaserCollisionBeam01,
    FxMuzzleFlash = {},
    FxChargeMuzzleFlash = {},
    FxUpackingChargeEffects = EffectTemplate.CMicrowaveLaserCharge01,
    FxUpackingChargeEffectScale = 1,

    PlayFxWeaponUnpackSequence = function( self )
        if not self.ContBeamOn then
            local army = self.unit:GetArmy()
            local bp = self:GetBlueprint()
            for k, v in self.FxUpackingChargeEffects do
                for ek, ev in bp.RackBones[self.CurrentRackSalvoNumber].MuzzleBones do 
                    CreateAttachedEmitter(self.unit, ev, army, v):ScaleEmitter(self.FxUpackingChargeEffectScale):ScaleEmitter(0.2)  
                end
            end
            DefaultBeamWeapon.PlayFxWeaponUnpackSequence(self)
        end
    end,
}

HawkTractorClaw = Class(DefaultBeamWeapon) {
    BeamType = HawkTractorClawCollisionBeam,
    FxMuzzleFlash = {},

    PlayFxBeamStart = function(self, muzzle)
        local target = self:GetCurrentTarget()
        if not target or
            EntityCategoryContains(categories.STRUCTURE, target) or
            EntityCategoryContains(categories.COMMAND, target) or
            EntityCategoryContains(categories.EXPERIMENTAL, target) or
            EntityCategoryContains(categories.NAVAL, target) or
            EntityCategoryContains(categories.SUBCOMMANDER, target) or
           EntityCategoryContains(categories.TECH3, target) or
            not EntityCategoryContains(categories.ALLUNITS, target) then
            return
        end
        DefaultBeamWeapon.PlayFxBeamStart(self, muzzle)

        self.TT1 = self:ForkThread(self.TractorThread, target)
        self:ForkThread(self.TractorWatchThread, target)
    end,

    OnLostTarget = function(self)
        self:AimManipulatorSetEnabled(true)
        DefaultBeamWeapon.OnLostTarget(self)
    end,

    TractorThread = function(self, target)
        self.unit.Trash:Add(target)
        local beam = self.Beams[1].Beam
        if not beam then return end


        local muzzle = self:GetBlueprint().MuzzleSpecial
        if not muzzle then return end


        local pos0 = beam:GetPosition(0)
        local pos1 = beam:GetPosition(1)

        local dist = VDist3(pos0, pos1)

        self.Slider = CreateSlider(self.unit, muzzle, 0, 0, dist, -1, true)

        WaitFor(self.Slider)

        target:AttachBoneTo(-1, self.unit, muzzle)

        self.AimControl:SetResetPoseTime(10)
        target:SetDoNotTarget(true)

        self.Slider:SetSpeed(15)
        self.Slider:SetGoal(0,0,0)

        WaitFor(self.Slider)

        if not target:IsDead() then
            target:Kill()
        end
        self.AimControl:SetResetPoseTime(2)
    end,

    TractorWatchThread = function(self, target)
        while not target:IsDead() do
            WaitTicks(1)
        end
        KillThread(self.TT1)
        self.TT1 = nil
        if self.Slider then
            self.Slider:Destroy()
            self.Slider = nil
        end
        self.unit:DetachAll(self:GetBlueprint().MuzzleSpecial or 0)
        self:ResetTarget()
        self.AimControl:SetResetPoseTime(2)
    end,
}