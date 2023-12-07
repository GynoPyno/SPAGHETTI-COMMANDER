#****************************************************************************
#**
#**  File     :  /cdimage/units/DEL0204/DEL0204_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix, Matt Vainio 
#**
#**  Summary  :  UEF Ramrod Infantarie Mech
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TWalkingLandUnit = import('/lua/terranunits.lua').TWalkingLandUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local TIFCruiseMissileUnpackingLauncher = import("/lua/terranweapons.lua").TIFCruiseMissileUnpackingLauncher
local TWeapons = import("/lua/terranweapons.lua")
local TDFHeavyPlasmaCannonWeapon = TWeapons.TDFHeavyPlasmaCannonWeapon
local TDFLightPlasmaCannonWeapon = import("/lua/terranweapons.lua").TDFLightPlasmaCannonWeapon
local EffectUtils = import('/lua/effectutilities.lua')
local Effects = import('/lua/effecttemplates.lua')
local utilities = import('/lua/utilities.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')
local explosion = import('/lua/defaultexplosions.lua')
local TANTorpedoAngler = import("/lua/terranweapons.lua").TANTorpedoAngler
local TDFHiroPlasmaCannon = WeaponsFile.TDFHiroPlasmaCannon
local CWalkingLandUnit = import("/lua/cybranunits.lua").CWalkingLandUnit
local CreateDeathExplosion = explosion.CreateDefaultHitExplosionAtBone
local EffectTemplate = import("/lua/effecttemplates.lua")

Ramrod = Class(TWalkingLandUnit) {
    Weapons = {
    	RightHeavyPlasmaCannon = ClassWeapon(TDFHeavyPlasmaCannonWeapon) 
		{
            FxMuzzleFlashScale = 2,
        },
		AAGun = ClassWeapon(TDFLightPlasmaCannonWeapon) {},
		HiroCannonFront = ClassWeapon(TDFHiroPlasmaCannon) {},
		Torpedo01 = ClassWeapon(TANTorpedoAngler) {},
        MainGun = ClassWeapon(TIFCruiseMissileUnpackingLauncher) {
		FxMuzzleFlash = {'/effects/emitters/terran_mobile_missile_launch_01_emit.bp'},
        FxMuzzleFlashScale = 0.2,
        }
    },

    OnStartBeingBuilt = function(self, builder, layer)
        TWalkingLandUnit.OnStartBeingBuilt(self, builder, layer)
        if not self.AnimationManipulator then
            self.AnimationManipulator = CreateAnimator(self)
            self.Trash:Add(self.AnimationManipulator)
        end
        self.AnimationManipulator:PlayAnim(self:GetBlueprint().Display.AnimationActivate, false):SetRate(0)
    end,

    OnStopBeingBuilt = function(self,builder,layer)
        TWalkingLandUnit.OnStopBeingBuilt(self,builder,layer)

        if self.AnimationManipulator then
            self:SetUnSelectable(true)
            self.AnimationManipulator:SetRate(1)
            
            self:ForkThread(function()
                WaitSeconds(self.AnimationManipulator:GetAnimationDuration()*self.AnimationManipulator:GetRate())
                self:SetUnSelectable(false)
                self.AnimationManipulator:Destroy()
            end)
        end       
    end,
	
    OnCreate = function(self)
        TWalkingLandUnit.OnCreate(self)   
	end,
	
	OnKilled = function(self, inst, type, okr)
        CWalkingLandUnit.OnKilled(self, inst, type, okr)
    end,

    CreateDamageEffects = function(self, bone, army)
        for k, v in EffectTemplate.DamageFireSmoke01 do
            CreateAttachedEmitter(self, bone, army, v):ScaleEmitter(1.5)
        end
    end,

    CreateDeathExplosionDustRing = function(self)
        local blanketSides = 18
        local blanketAngle = (2 * math.pi) / blanketSides
        local blanketStrength = 1
        local blanketVelocity = 2.8

        for i = 0, (blanketSides - 1) do
            local blanketX = math.sin(i * blanketAngle)
            local blanketZ = math.cos(i * blanketAngle)

            local Blanketparts = self:CreateProjectile('/effects/entities/DestructionDust01/DestructionDust01_proj.bp', blanketX, 1.5, blanketZ + 4, blanketX, 0, blanketZ)
                :SetVelocity(blanketVelocity):SetAcceleration(-0.3)
        end
    end,

    CreateFirePlumes = function(self, army, bones, yBoneOffset)
        local proj, position, offset, velocity
        local basePosition = self:GetPosition()
        for k, vBone in bones do
            position = self:GetPosition(vBone)
            offset = utilities.GetDifferenceVector(position, basePosition)
            velocity = utilities.GetDirectionVector(position, basePosition)
            velocity.x = velocity.x + utilities.GetRandomFloat(-0.3, 0.3)
            velocity.z = velocity.z + utilities.GetRandomFloat(-0.3, 0.3)
            velocity.y = velocity.y + utilities.GetRandomFloat(0.0, 0.3)
            proj = self:CreateProjectile('/effects/entities/DestructionFirePlume01/DestructionFirePlume01_proj.bp', offset.x, offset.y + yBoneOffset, offset.z, velocity.x, velocity.y, velocity.z)
            proj:SetBallisticAcceleration(utilities.GetRandomFloat(-1, -2)):SetVelocity(utilities.GetRandomFloat(3, 4)):SetCollision(false)

            local emitter = CreateEmitterOnEntity(proj, army, '/effects/emitters/destruction_explosion_fire_plume_02_emit.bp')

            local lifetime = utilities.GetRandomFloat(12, 22)
        end
    end,

    CreateExplosionDebris = function(self, army)
        for k, v in EffectTemplate.ExplosionDebrisLrg01 do
            CreateAttachedEmitter(self, 'Ramrod', army, v)
        end
    end,

    DeathThread = function(self)
        self:PlayUnitSound('Destroyed')
        local army = self.Army

        -- Create Initial explosion effects
        explosion.CreateFlash(self, 'Torso', 3.0, army)
        CreateAttachedEmitter(self, 'Ramrod', army, '/effects/emitters/destruction_explosion_concussion_ring_03_emit.bp')
        CreateAttachedEmitter(self, 'Ramrod', army, '/effects/emitters/explosion_fire_sparks_02_emit.bp')
        self:CreateFirePlumes(army, {'Torso'}, 0)

        self:CreateFirePlumes(army, {'R_Leg_02', 'R_Leg_01', 'L_Leg_02', }, 0.5)

        self:CreateExplosionDebris(army)
        self:CreateExplosionDebris(army)
        self:CreateExplosionDebris(army)

        WaitSeconds(1)

        -- Create damage effects on turret bone
        CreateDeathExplosion(self, 'Torso', 1.2)
        self:CreateDamageEffects('Right_Launcher', army)
        self:CreateDamageEffects('Left_Arm_Barrel', army)

        WaitSeconds(1)
        self:CreateFirePlumes(army, {'L_Leg_02', 'L_Leg_01', 'R_Leg_02', }, 0.5)
        WaitSeconds(0.3)
        self:CreateDeathExplosionDustRing()
        WaitSeconds(0.4)


        -- When Ramrod bot impacts with the ground
        -- Effects: Explosion on turret, dust effects on the muzzle tip, large dust ring around unit
        -- Other: Damage force ring to force trees over and camera shake
        self:ShakeCamera(50, 5, 0, 1)
        CreateDeathExplosion(self, 'L_Torp1', 1)
        for k, v in EffectTemplate.FootFall01 do
            CreateAttachedEmitter(self, 'Torso', army, v):ScaleEmitter(2)
            CreateAttachedEmitter(self, 'Torso', army, v):ScaleEmitter(2)
        end


        self:CreateExplosionDebris(army)
        self:CreateExplosionDebris(army)

        local x, y, z = unpack(self:GetPosition())
        z = z + 3

        -- only apply death damage when the unit is sufficiently build
        local bp = self:GetBlueprint()
        local FractionThreshold = bp.General.FractionThreshold or 0.99
        if self:GetFractionComplete() >= FractionThreshold then 
            local bp = self:GetBlueprint()
            local position = self:GetPosition()
            local qx, qy, qz, qw = unpack(self:GetOrientation())
            local a = math.atan2(2.0 * (qx * qz + qw * qy), qw * qw + qx * qx - qz * qz - qy * qy)
            for i, numWeapons in bp.Weapon do
                if bp.Weapon[i].Label == 'RamrodDeath' then
                    position[3] = position[3]+3*math.cos(a)
                    position[1] = position[1]+3*math.sin(a)
                    DamageArea(self, position, bp.Weapon[i].DamageRadius, bp.Weapon[i].Damage, bp.Weapon[i].DamageType, bp.Weapon[i].DamageFriendly)
                    break
                end
            end
        end

        DamageRing(self, {x, y,z}, 0.1, 3, 1, 'Force', true)
        WaitSeconds(0.5)
        CreateDeathExplosion(self, 'Torso', 2)

        -- Finish up force ring to push trees
        DamageRing(self, {x, y,z}, 0.1, 3, 1, 'Force', true)

        -- Explosion on and damage fire on various bones
        CreateDeathExplosion(self, 'R_Leg_01', 0.25)
        CreateDeathExplosion(self, 'Left_Launcher', 2)
        self:CreateFirePlumes(army, {'Left_Launcher'}, -1)
        self:CreateDamageEffects('Right_Arm', army)
        WaitSeconds(0.5)

        CreateDeathExplosion(self, 'L_Leg_04', 0.25)
        self:CreateDamageEffects('R_Leg_03', army)
        WaitSeconds(0.5)
        CreateDeathExplosion(self, 'Left_Arm_Muzzle2', 1)
        self:CreateExplosionDebris(army)

        CreateDeathExplosion(self, 'R_Leg_03', 0.25)
        self:CreateDamageEffects('Right_Arm_Muzzle2', army)
        WaitSeconds(0.5)

        CreateDeathExplosion(self, 'L_Leg_01', 0.25)
        CreateDeathExplosion(self, 'Left_Arm_Muzzle1', 2)
        self:CreateDamageEffects('L_Leg_03', army)

        self:CreateWreckage(0.1)
        self:Destroy()
    end,

}

TypeClass = Ramrod