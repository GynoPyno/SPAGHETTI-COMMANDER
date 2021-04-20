-----------------------------------------------------------------
-- File     :  /cdimage/units/UAL0401/UAL0401_script.lua
-- Author(s):  John Comes, Gordon Duclos
-- Summary  :  Aeon Galactic Colossus Script
-- Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
-----------------------------------------------------------------

local TWalkingLandUnit = import('/lua/terranunits.lua').TWalkingLandUnit
local MobileUnit = import('/lua/defaultunits.lua').MobileUnit
local KingkriptorWeapon = import('/Mods/#Marlos mods compilation/lua/MKweapons.lua').KingkriptorWeapon
local Fatboy2Weapon01 = import('/Mods/#Marlos mods compilation/lua/MKweapons.lua').Fatboy2Weapon01
local Fatboy2Weapon02 = import('/Mods/#Marlos mods compilation/lua/MKweapons.lua').Fatboy2Weapon02
local TIFCruiseMissileUnpackingLauncher = import('/lua/terranweapons.lua').TIFCruiseMissileUnpackingLauncher
local TIFHighBallisticMortarWeapon = import('/lua/terranweapons.lua').TIFHighBallisticMortarWeapon


local EffectUtils = import('/lua/effectutilities.lua')
local Effects = import('/lua/effecttemplates.lua')
local utilities = import('/lua/utilities.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local explosion = import('/lua/defaultexplosions.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')
local CreateDeathExplosion = explosion.CreateDefaultHitExplosionAtBone
local EffectUtil = import('/lua/EffectUtilities.lua')
local CreateBuildCubeThread = EffectUtil.CreateBuildCubeThread

MK75 = Class(TWalkingLandUnit) {

    Weapons = {
	
        -- BodyYaw = Class(CDFLaserHeavyWeapon) {},
        RightMainWeapon = Class(KingkriptorWeapon) {       
            OnCreate = function(self)            
                self.RightSpinner = CreateRotator(self.unit, 'UUX0111_T01_B01_Recoil01', 'z')
                self.RightSpinnerGoal = 180
                self.unit.Trash:Add(self.RightSpinner)        
                KingkriptorWeapon.OnCreate(self)
            end,
              
            PlayFxRackReloadSequence = function(self)
                self.RightSpinner:SetCurrentAngle(0)
                self.RightSpinner:SetGoal(self.RightSpinnerGoal)
                self.RightSpinner:SetSpeed(100)
                self.RightSpinner:SetAccel(10)
		        KingkriptorWeapon.PlayFxRackReloadSequence(self)
	        end,
	        
	        CreateProjectileAtMuzzle = function(self, muzzle)
				KingkriptorWeapon.CreateProjectileAtMuzzle(self, muzzle)
            end,
        },
        LeftMainWeapon = Class(KingkriptorWeapon) {
            OnCreate = function(self)            
                self.LeftSpinner = CreateRotator(self.unit, 'UUX0111_T01_B02_Recoil01', '-z')
                self.LeftSpinnerGoal = 180
                self.unit.Trash:Add(self.LeftSpinner)        
                KingkriptorWeapon.OnCreate(self)
            end,
              
            PlayFxRackReloadSequence = function(self)
                self.LeftSpinner:SetCurrentAngle(0)
                self.LeftSpinner:SetGoal(self.LeftSpinnerGoal)
                self.LeftSpinner:SetSpeed(100)
                self.LeftSpinner:SetAccel(10)
		        KingkriptorWeapon.PlayFxRackReloadSequence(self)
	        end,
	        
	        CreateProjectileAtMuzzle = function(self, muzzle)
				KingkriptorWeapon.CreateProjectileAtMuzzle(self, muzzle)
            end,
        },
		
		TacticalMissile01 = Class(TIFCruiseMissileUnpackingLauncher) {},
		
        CenterTurret = Class(Fatboy2Weapon01) {},
        ShoulderTurret01 = Class(Fatboy2Weapon02) {},
        ShoulderTurret02 = Class(Fatboy2Weapon02) {},
		
        HeadGun01 = Class(TIFHighBallisticMortarWeapon) {
		CreateProjectileAtMuzzle = function(self, muzzle)
                local proj = TIFHighBallisticMortarWeapon.CreateProjectileAtMuzzle(self, muzzle)
                local bp = self:GetBlueprint()
                local data = {
                    Radius = bp.CameraVisionRadius or 5,
                    Lifetime = bp.CameraLifetime or 5,
                    Army = self.unit.Army,
                }
                if proj and not proj:BeenDestroyed() then
                    proj:PassData(data)
                end
            end,
		},
        HeadGun02 = Class(TIFHighBallisticMortarWeapon) {},
        HeadGun03 = Class(TIFHighBallisticMortarWeapon) {},
        HeadGun04 = Class(TIFHighBallisticMortarWeapon) {},
        HeadGun05 = Class(TIFHighBallisticMortarWeapon) {},
        HeadGun06 = Class(TIFHighBallisticMortarWeapon) {},
        HeadGun07 = Class(TIFHighBallisticMortarWeapon) {},
        HeadGun08 = Class(TIFHighBallisticMortarWeapon) {},

    },
	
    StartBeingBuiltEffects = function(self, builder, layer)
        self:SetMesh(self:GetBlueprint().Display.BuildMeshBlueprint, true)
        if self:GetBlueprint().General.UpgradesFrom ~= builder.UnitId then
            self:HideBone(0, true)
            self.OnBeingBuiltEffectsBag:Add(self:ForkThread(CreateBuildCubeThread, builder, self.OnBeingBuiltEffectsBag))
        end
    end,

    OnCreate = function(self, createArgs)
		TWalkingLandUnit.OnCreate(self, createArgs)
		self.Spinner = CreateRotator(self, 'UUX0111_Crown', 'y', nil, 0, 60, 360):SetTargetSpeed(-30)
		self.Trash:Add(self.Spinner)

        -- Create missile doors
        self.TopLeftDoor = CreateRotator(self, 'UUX0111_LeftMissileTop', 'x', 0, 90, 360)
        self.TopRightDoor = CreateRotator(self, 'UUX0111_RightMissileTop', 'x', 0, 90, 360)
        self.BottomLeftDoor = CreateRotator(self, 'UUX0111_LeftMissileBottom', 'x', 0, 90, 360)
        self.BottomRightDoor = CreateRotator(self, 'UUX0111_RightMissileBottom', 'x', 0, 90, 360)
	end,

    -- OnStartBeingBuilt = function(self, builder, layer)
        -- TWalkingLandUnit.OnStartBeingBuilt(self, builder, layer)
        -- if not self.AnimationManipulator then
            -- self.AnimationManipulator = CreateAnimator(self)
            -- self.Trash:Add(self.AnimationManipulator)
        -- end
        -- self.AnimationManipulator:PlayAnim(self:GetBlueprint().Display.AnimationActivate, false):SetRate(0)
    -- end,

    -- OnStopBeingBuilt = function(self, builder, layer)
        -- TWalkingLandUnit.OnStopBeingBuilt(self, builder, layer)
        -- if self.AnimationManipulator then
            -- self:SetUnSelectable(true)
            -- self.AnimationManipulator:SetRate(1)

            -- self:ForkThread(function()
                -- WaitSeconds(self.AnimationManipulator:GetAnimationDuration() * self.AnimationManipulator:GetRate())
                -- self:SetUnSelectable(false)
                -- self.AnimationManipulator:Destroy()
            -- end)
        -- end
    -- end,

    DeathThread = function(self, overkillRatio , instigator)
        self:PlayUnitSound('Destroyed')
        self.CreateUnitDestructionDebris(self, true, true, true)
        self.CreateUnitDestructionDebris(self, true, true, true)
        explosion.CreateDefaultHitExplosionAtBone(self, 'UUX0111_Crown', 6.0)
        explosion.CreateDefaultHitExplosionAtBone(self, 'UUX0111_T01_Barrel02', 4.0)
        explosion.CreateDebrisProjectiles(self, explosion.GetAverageBoundingXYZRadius(self), {self:GetUnitSizes()})
        WaitSeconds(2)
        self.CreateUnitDestructionDebris(self, true, true, true)
        self.CreateUnitDestructionDebris(self, true, true, true)
        explosion.CreateDefaultHitExplosionAtBone(self, 'UUX0111_LeftKnee', 2.0)
        explosion.CreateDefaultHitExplosionAtBone(self, 'UUX0111_T01_Barrel01', 2.0)
        WaitSeconds(0.1)
        explosion.CreateDefaultHitExplosionAtBone(self, 'UUX0111_RightHip', 2.0)
        explosion.CreateDefaultHitExplosionAtBone(self, 'UUX0111_T01_Barrel02', 2.0)
        WaitSeconds(0.1)
        self.CreateUnitDestructionDebris(self, true, true, true)
        self.CreateUnitDestructionDebris(self, true, true, true)
        explosion.CreateDefaultHitExplosionAtBone(self, 'UUX0111_RightHip', 2.0)
        explosion.CreateDefaultHitExplosionAtBone(self, 'UUX0111_T01_Barrel01', 2.0)
        WaitSeconds(0.3)
        explosion.CreateDefaultHitExplosionAtBone(self, 'UUX0111_RightHip', 2.0)
        explosion.CreateDefaultHitExplosionAtBone(self, 'UUX0111_LeftKnee', 2.0)
        explosion.CreateDefaultHitExplosionAtBone(self, 'UUX0111_T01_Barrel02', 2.0)
        self.CreateUnitDestructionDebris(self, true, true, true)
        self.CreateUnitDestructionDebris(self, true, true, true)

        WaitSeconds(1.5)
        explosion.CreateDefaultHitExplosionAtBone(self, 'UUX0111_RightHip', 1.5)
        explosion.CreateDefaultHitExplosionAtBone(self, 'UUX0111_Crown', 2.0)
        explosion.CreateDefaultHitExplosionAtBone(self, 'UUX0111_LeftKnee', 5.0)
        explosion.CreateDefaultHitExplosionAtBone(self, 'UUX0111_RightShoulder', 6.0)
        explosion.CreateDefaultHitExplosionAtBone(self, 'UUX0111_RightShoulder', 5.0)
        explosion.CreateDefaultHitExplosionAtBone(self, 'UUX0111_Crown', 7.0)

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
}

TypeClass = MK75
