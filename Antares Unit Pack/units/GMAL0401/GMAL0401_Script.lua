local AWalkingLandUnit = import('/lua/aeonunits.lua').AWalkingLandUnit

local Shield = import('/lua/shield.lua').Shield

local WeaponsFile = import ('/lua/aeonweapons.lua')

local ADFPhasonLaser = import ('/lua/aeonweapons.lua').ADFPhasonLaser
local ADFCannonOblivionWeapon = import ('/lua/aeonweapons.lua').ADFCannonOblivionWeapon
local ADFCannonOblivionWeapon02 = import ('/lua/aeonweapons.lua').ADFCannonOblivionWeapon02

local Effects = import('/lua/effecttemplates.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local utilities = import('/lua/utilities.lua')
local EffectUtils = import('/lua/effectutilities.lua')

local Entity = import('/lua/sim/Entity.lua').Entity
local explosion = import('/lua/defaultexplosions.lua')

GMAL0401 = Class(AWalkingLandUnit) {
    Weapons = {
        AA_Gun = Class(ADFCannonOblivionWeapon02) {
		FxMuzzleFlashScale = 2.5,
	},
        EyeWeapon = Class(ADFPhasonLaser) {},
        RightArmCannon = Class(ADFCannonOblivionWeapon) {
			CreateProjectileAtMuzzle = function(self, muzzle)
			numProjectiles = 10
			for i = 0, (numProjectiles -1) do
				local proj = ADFCannonOblivionWeapon.CreateProjectileAtMuzzle(self, muzzle)
			end
		end,
	},
        LeftArmCannon = Class(ADFCannonOblivionWeapon) {
			CreateProjectileAtMuzzle = function(self, muzzle)
			numProjectiles = 10
			for i = 0, (numProjectiles -1) do
				local proj = ADFCannonOblivionWeapon.CreateProjectileAtMuzzle(self, muzzle)
			end
		end,

            PlayFxWeaponPackSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(0)
                end
                if self.SpinManip2 then
                    self.SpinManip2:SetTargetSpeed(0)
                end
                self.ExhaustEffects = EffectUtil.CreateBoneEffects( self.unit, 'Left_Arm_Muzzle01', self.unit:GetArmy(), Effects.WeaponSteam01 )
                self.ExhaustEffects = EffectUtil.CreateBoneEffects( self.unit, 'Right_Arm_Muzzle01', self.unit:GetArmy(), Effects.WeaponSteam01 )
                ADFCannonOblivionWeapon.PlayFxWeaponPackSequence(self)
            end,
        
            PlayFxWeaponUnpackSequence = function(self)
                if not self.SpinManip then 
                    self.SpinManip = CreateRotator(self.unit, 'Left_Spinner', 'z', nil, 270, 180, 60)
                    self.unit.Trash:Add(self.SpinManip)
                end
                if not self.SpinManip2 then 
                    self.SpinManip2 = CreateRotator(self.unit, 'Right_Spinner', 'z', nil, 270, 180, 60)
                    self.unit.Trash:Add(self.SpinManip2)
                end
                
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(300)
                end
                if self.SpinManip2 then
                    self.SpinManip2:SetTargetSpeed(300)
                end
                ADFCannonOblivionWeapon.PlayFxWeaponUnpackSequence(self)
            end,                             
	},
    },

    OnKilled = function(self, instigator, type, overkillRatio)
        AWalkingLandUnit.OnKilled(self, instigator, type, overkillRatio)
        local wep = self:GetWeaponByLabel('EyeWeapon')
        local bp = wep:GetBlueprint()
        if bp.Audio.BeamStop then
            wep:PlaySound(bp.Audio.BeamStop)
        end
        if bp.Audio.BeamLoop and wep.Beams[1].Beam then
            wep.Beams[1].Beam:SetAmbientSound(nil, nil)
        end
        for k, v in wep.Beams do
            v.Beam:Disable()
        end     
    end,
        
    DeathThread = function( self, overkillRatio , instigator)
        explosion.CreateDefaultHitExplosionAtBone( self, 'Torso', 4.0 )
        explosion.CreateDebrisProjectiles(self, explosion.GetAverageBoundingXYZRadius(self), {self:GetUnitSizes()})           
        WaitSeconds(2)
        explosion.CreateDefaultHitExplosionAtBone( self, 'Right_Leg_B02', 1.0 )
        WaitSeconds(0.1)
        explosion.CreateDefaultHitExplosionAtBone( self, 'Right_Leg_B01', 1.0 )
        WaitSeconds(0.1)
        explosion.CreateDefaultHitExplosionAtBone( self, 'Left_Arm_B02', 1.0 )
        WaitSeconds(0.3)
        explosion.CreateDefaultHitExplosionAtBone( self, 'Right_Arm_B01', 1.0 )
        explosion.CreateDefaultHitExplosionAtBone( self, 'Right_Leg_B01', 1.0 )

        WaitSeconds(3.5)
        explosion.CreateDefaultHitExplosionAtBone( self, 'Torso', 5.0 )        

        if self.DeathAnimManip then
            WaitFor(self.DeathAnimManip)
        end
    
        local bp = self:GetBlueprint()
        for i, numWeapons in bp.Weapon do
            if(bp.Weapon[i].Label == 'CollossusDeath') then
                DamageArea(self, self:GetPosition(), bp.Weapon[i].DamageRadius, bp.Weapon[i].Damage, bp.Weapon[i].DamageType, bp.Weapon[i].DamageFriendly)
                break
            end
        end

        self:DestroyAllDamageEffects()
        self:CreateWreckage( overkillRatio )

        # CURRENTLY DISABLED UNTIL DESTRUCTION
        # Create destruction debris out of the mesh, currently these projectiles look like crap,
        # since projectile rotation and terrain collision doesn't work that great. These are left in
        # hopes that this will look better in the future.. =)
        if( self.ShowUnitDestructionDebris and overkillRatio ) then
            if overkillRatio <= 1 then
                self.CreateUnitDestructionDebris( self, true, true, false )
            elseif overkillRatio <= 2 then
                self.CreateUnitDestructionDebris( self, true, true, false )
            elseif overkillRatio <= 3 then
                self.CreateUnitDestructionDebris( self, true, true, true )
            else #VAPORIZED
                self.CreateUnitDestructionDebris( self, true, true, true )
            end
        end

        self:PlayUnitSound('Destroyed')
        self:Destroy()
    end,
    
}

TypeClass = GMAL0401