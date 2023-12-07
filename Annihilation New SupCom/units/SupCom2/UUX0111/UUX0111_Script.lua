#****************************************************************************
#**
#**  File     :  /cdimage/units/UAL0401/UAL0401_script.lua
#**  Author(s):  John Comes, Gordon Duclos
#**
#**  Summary  :  Aeon Galactic Colossus Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TWalkingLandUnit = import('/lua/terranunits.lua').TWalkingLandUnit
local MobileUnit = import('/lua/defaultunits.lua').MobileUnit
local EffectUtils = import('/lua/effectutilities.lua')
local Effects = import('/lua/effecttemplates.lua')
local utilities = import('/lua/utilities.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local explosion = import('/lua/defaultexplosions.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')
local CreateDeathExplosion = explosion.CreateDefaultHitExplosionAtBone
local CreateBuildCubeThread = EffectUtil.CreateBuildCubeThread
local WeaponsFile = import('/lua/terranweapons.lua')
local TMWeaponsFile = import('/mods/Annihilation New SupCom/lua/TMAeonWeapons.lua')
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local WeaponsFile1 = import ('/lua/aeonweapons.lua')
local ADFPhasonLaser = WeaponsFile1.ADFPhasonLaser


UUX0111 = Class(TWalkingLandUnit) {

    Weapons = {
        EyeWeapon = Class(ADFPhasonLaser) {},
		MainGun = Class(TDFGaussCannonWeapon) {  
			FxMuzzleFlashScale = 3.95,
			FxMuzzleFlash = EffectTemplate.ASDisruptorCannonChargeMuzzle01,
		}, 
		MainGun2 = Class(TDFGaussCannonWeapon) {  
			FxMuzzleFlashScale = 3.95,
			FxMuzzleFlash = EffectTemplate.ASDisruptorCannonChargeMuzzle01,
		}, 
		MainGun3 = Class(TDFGaussCannonWeapon) {  
			FxMuzzleFlashScale = 3.95,
			FxMuzzleFlash = EffectTemplate.ASDisruptorCannonChargeMuzzle01,
		},
		MainGun4 = Class(TDFGaussCannonWeapon) {  
			FxMuzzleFlashScale = 3.95,
			FxMuzzleFlash = EffectTemplate.ASDisruptorCannonChargeMuzzle01,
		}, 
		
        rocket1 = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 0,
	    },
        rocket2 = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 0,
	    },
		rocket3 = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 0,
	    },
        rocket4 = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 0,
	    },
        rocket5 = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 0,
	    },
        rocket6 = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 0,
	    },
        rocket7 = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 0,
	    },
        rocket8 = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 0,
	    },
        rocket9 = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 0,
	    },
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

        if self.ShowUnitDestructionDebris and overkillRatio then
            if overkillRatio <= 1 then
                self.CreateUnitDestructionDebris(self, true, true, false)
            elseif overkillRatio <= 2 then
                self.CreateUnitDestructionDebris(self, true, true, false)
            elseif overkillRatio <= 3 then
                self.CreateUnitDestructionDebris(self, true, true, true)
                self.CreateUnitDestructionDebris(self, true, true, true)
            else 
                self.CreateUnitDestructionDebris(self, true, true, true)
            end
        end

        self:Destroy()
    end,
}

TypeClass = UUX0111
