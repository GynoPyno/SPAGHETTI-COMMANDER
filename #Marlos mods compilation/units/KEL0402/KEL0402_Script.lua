-----------------------------------------------------------------
-- File     :  /cdimage/units/UAL0401/UAL0401_script.lua
-- Author(s):  John Comes, Gordon Duclos
-- Summary  :  Aeon Galactic Colossus Script
-- Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
-----------------------------------------------------------------

local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit
local MobileUnit = import('/lua/defaultunits.lua').MobileUnit
local TDFHeavyPlasmaCannonWeapon = import('/lua/terranweapons.lua').TDFHeavyPlasmaGatlingCannonWeapon
local TSAMLauncher = import('/lua/terranweapons.lua').TSAMLauncher

local EffectUtils = import('/lua/effectutilities.lua')
local Effects = import('/lua/effecttemplates.lua')
local utilities = import('/lua/utilities.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local explosion = import('/lua/defaultexplosions.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')
local CreateDeathExplosion = explosion.CreateDefaultHitExplosionAtBone
local EffectUtil = import('/lua/EffectUtilities.lua')
local CreateBuildCubeThread = EffectUtil.CreateBuildCubeThread


MK73 = Class(CWalkingLandUnit) {

    Weapons = {
        RocketBackpack = Class(import('/lua/cybranweapons.lua').CDFRocketIridiumWeapon02) {},
        MainGun = Class(import('/lua/cybranweapons.lua').CDFRocketIridiumWeapon02) 
        {
            PlayFxWeaponPackSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(0)
                end
                self.ExhaustEffects = EffectUtils.CreateBoneEffects(self.unit, 'Turret_Barrel_Spinner', self.unit.Army, Effects.WeaponSteam01)
                TDFHeavyPlasmaCannonWeapon.PlayFxWeaponPackSequence(self)
            end,

            PlayFxRackSalvoChargeSequence = function(self)
                if not self.SpinManip then 
                    self.SpinManip = CreateRotator(self.unit, 'Turret_Barrel_Spinner', 'z', nil, 270, 180, 60)
                    self.unit.Trash:Add(self.SpinManip)
                end
                
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(500)
                end
                TDFHeavyPlasmaCannonWeapon.PlayFxRackSalvoChargeSequence(self)
            end,

            PlayFxRackSalvoReloadSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(200)
                end
                self.ExhaustEffects = EffectUtils.CreateBoneEffects(self.unit, 'Turret_Barrel_Spinner', self.unit.Army, Effects.WeaponSteam01)
                TDFHeavyPlasmaCannonWeapon.PlayFxRackSalvoChargeSequence(self)
            end,    
        },
        MissileRack01 = Class(TSAMLauncher) {},
        MissileRack02 = Class(TSAMLauncher) {},
    },
	
    StartBeingBuiltEffects = function(self, builder, layer)
        self:SetMesh(self:GetBlueprint().Display.BuildMeshBlueprint, true)
        if self:GetBlueprint().General.UpgradesFrom ~= builder.UnitId then
            self:HideBone(0, true)
            self.OnBeingBuiltEffectsBag:Add(self:ForkThread(CreateBuildCubeThread, builder, self.OnBeingBuiltEffectsBag))
        end
    end,

    DeathThread = function(self, overkillRatio , instigator)
        self:PlayUnitSound('Destroyed')
        self.CreateUnitDestructionDebris(self, true, true, true)
        self.CreateUnitDestructionDebris(self, true, true, true)
        explosion.CreateDefaultHitExplosionAtBone(self, 'Turret_01', 12.0)
        explosion.CreateDefaultHitExplosionAtBone(self, 'Turret_03', 12.0)
        explosion.CreateDebrisProjectiles(self, explosion.GetAverageBoundingXYZRadius(self), {self:GetUnitSizes()})
        WaitSeconds(2)
        self.CreateUnitDestructionDebris(self, true, true, true)
        self.CreateUnitDestructionDebris(self, true, true, true)
        explosion.CreateDefaultHitExplosionAtBone(self, 'Leg_03_03', 4.0)
        explosion.CreateDefaultHitExplosionAtBone(self, 'Torso', 4.0)
        WaitSeconds(0.1)
        explosion.CreateDefaultHitExplosionAtBone(self, 'Leg_02_02', 4.0)
        explosion.CreateDefaultHitExplosionAtBone(self, 'Torso', 4.0)
        WaitSeconds(0.1)
        self.CreateUnitDestructionDebris(self, true, true, true)
        self.CreateUnitDestructionDebris(self, true, true, true)
        explosion.CreateDefaultHitExplosionAtBone(self, 'Leg_04_02', 4.0)
        explosion.CreateDefaultHitExplosionAtBone(self, 'Torso', 4.0)
        WaitSeconds(0.3)
        explosion.CreateDefaultHitExplosionAtBone(self, 'Leg_02_02', 4.0)
        explosion.CreateDefaultHitExplosionAtBone(self, 'Leg_03_03', 4.0)
        explosion.CreateDefaultHitExplosionAtBone(self, 'Torso', 4.0)
        self.CreateUnitDestructionDebris(self, true, true, true)
        self.CreateUnitDestructionDebris(self, true, true, true)

        WaitSeconds(1.5)
        explosion.CreateDefaultHitExplosionAtBone(self, 'Leg_02_02', 3.0)
        explosion.CreateDefaultHitExplosionAtBone(self, 'Turret_01', 4.0)
        explosion.CreateDefaultHitExplosionAtBone(self, 'Leg_03_03', 5.0)
        explosion.CreateDefaultHitExplosionAtBone(self, 'Turret_02', 6.0)
        explosion.CreateDefaultHitExplosionAtBone(self, 'Turret_02', 15.0)
        explosion.CreateDefaultHitExplosionAtBone(self, 'Turret_01', 15.0)

        if self.DeathAnimManip then
            WaitFor(self.DeathAnimManip)
        end

        local bp = self:GetBlueprint()
        local position = self:GetPosition()
        local qx, qy, qz, qw = unpack(self:GetOrientation())
        local a = math.atan2(2.0 * (qx * qz + qw * qy), qw * qw + qx * qx - qz * qz - qy * qy)
        for i, numWeapons in bp.Weapon do
            if bp.Weapon[i].Label == 'CollossusDeath' then
                position[3] = position[3]+5*math.cos(a)
                position[1] = position[1]+5*math.sin(a)
                DamageArea(self, position, bp.Weapon[i].DamageRadius, bp.Weapon[i].Damage, bp.Weapon[i].DamageType, bp.Weapon[i].DamageFriendly)
                break
            end
        end

        self:DestroyAllDamageEffects()
        self:CreateWreckage(overkillRatio)

        -- CURRENTLY DISABLED UNTIL DESTRUCTION
        -- Create destruction debris out of the mesh, currently these projectiles look like crap,
        -- since projectile rotation and terrain collision doesn't work that great. These are left in
        -- hopes that this will look better in the future.. =)
        if self.ShowUnitDestructionDebris and overkillRatio then
            if overkillRatio <= 1 then
                self.CreateUnitDestructionDebris(self, true, true, false)
            elseif overkillRatio <= 2 then
                self.CreateUnitDestructionDebris(self, true, true, false)
            elseif overkillRatio <= 3 then
                self.CreateUnitDestructionDebris(self, true, true, true)
                self.CreateUnitDestructionDebris(self, true, true, true)
            else -- Vaporized
                self.CreateUnitDestructionDebris(self, true, true, true)
            end
        end

        self:Destroy()
    end,

    OnLayerChange = function(self, new, old)
        CWalkingLandUnit.OnLayerChange(self, new, old)
        self:CreateUnitAmbientEffect(new)
        if new == 'Seabed' then
            self:EnableUnitIntel('Layer', 'Sonar')
        else
            self:DisableUnitIntel('Layer', 'Sonar')
        end
    end,

	
    AmbientExhaustBones = {
        'Exhaust_01',
        'Exhaust_02',
    },

    AmbientLandExhaustEffects = {
        '/effects/emitters/dirty_exhaust_smoke_02_emit.bp',
        '/effects/emitters/dirty_exhaust_sparks_02_emit.bp',
    },

    AmbientSeabedExhaustEffects = {
        '/effects/emitters/underwater_vent_bubbles_02_emit.bp',
    },

    CreateUnitAmbientEffect = function(self, layer)
        if self:GetFractionComplete() ~= 1 then
            return
        end
        if self.AmbientEffectThread ~= nil then
           self.AmbientEffectThread:Destroy()
        end
        if self.AmbientExhaustEffectsBag then
            EffectUtil.CleanupEffectBag(self, 'AmbientExhaustEffectsBag')
        end

        self.AmbientEffectThread = nil
        self.AmbientExhaustEffectsBag = {}
        if layer == 'Land' then
            self.AmbientEffectThread = self:ForkThread(self.UnitLandAmbientEffectThread)
        elseif layer == 'Seabed' then
            local army = self.Army
            for kE, vE in self.AmbientSeabedExhaustEffects do
                for kB, vB in self.AmbientExhaustBones do
                    table.insert(self.AmbientExhaustEffectsBag, CreateAttachedEmitter(self, vB, army, vE))
                end
            end
        end
    end,

    UnitLandAmbientEffectThread = function(self)
        while not self.Dead do
            local army = self.Army

            for kE, vE in self.AmbientLandExhaustEffects do
                for kB, vB in self.AmbientExhaustBones do
                    table.insert(self.AmbientExhaustEffectsBag, CreateAttachedEmitter(self, vB, army, vE))
                end
            end

            WaitSeconds(2)
            EffectUtil.CleanupEffectBag(self, 'AmbientExhaustEffectsBag')

            WaitSeconds(utilities.GetRandomFloat(1, 7))
        end
    end,

    OnKilled = function(self, inst, type, okr)
        if self.AmbientExhaustEffectsBag then
            EffectUtil.CleanupEffectBag(self, 'AmbientExhaustEffectsBag')
        end
        if not self.Dead then
            local wep = self:GetWeapon(1)
            if wep.Beams then
                if wep.Audio.BeamLoop and wep.Beams[1].Beam then
                    wep.Beams[1].Beam:SetAmbientSound(nil, nil)
                end
                for k, v in wep.Beams do
                    v.Beam:Disable()
                end
            end
        end
        CWalkingLandUnit.OnKilled(self, inst, type, okr)
    end,
	
}

TypeClass = MK73
