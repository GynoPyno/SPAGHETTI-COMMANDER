--[[#######################################################################
#  File	 :  /units/UAL0405/UAL0405_script.lua
#  Author(s):  John Comes, Gordon Duclos
#  Summary  :  Aeon Galactic Colossus Script UAL0401
#  -----------------------------
#  Modif.by :  AsdrubaelVect
#  Rev.Date :  5 septembre 2009
#  -----------------------------
#  Revis.by :  Manimal
#  Rev.Date :  20 novembre 2009
#  -----------------------------
#  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#######################################################################]]--
local AWalkingLandUnit = import( '/lua/aeonunits.lua' ).AWalkingLandUnit
local WeaponsFile = import ('/lua/aeonweapons.lua')
local ADFPhasonLaser = WeaponsFile.ADFPhasonLaser
local ADFTractorClaw = WeaponsFile.ADFTractorClaw
local AIFArtilleryMiasmaShellWeapon1 = WeaponsFile.AIFArtilleryMiasmaShellWeapon
local AIFArtilleryMiasmaShellWeapon2 = WeaponsFile.AIFArtilleryMiasmaShellWeapon
local explosion = import('/lua/defaultexplosions.lua')
local EffectUtils = import('/lua/effectutilities.lua')
local Effects = import('/lua/effecttemplates.lua')

UAL0405 = Class( AWalkingLandUnit ) {
    Weapons = {
        EyeWeapon = Class(ADFPhasonLaser) {},
        RightArmTractor = Class(ADFTractorClaw) {},
        LeftArmTractor = Class(ADFTractorClaw) {},
		ArtyGun01 = Class(AIFArtilleryMiasmaShellWeapon1) {
			PlayFxWeaponPackSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(0)
                end
                self.ExhaustEffects = EffectUtils.CreateBoneEffects( self.unit, 'RightArtyMuzzle01', self.unit:GetArmy(), Effects.WeaponSteam01 )
                AIFArtilleryMiasmaShellWeapon1.PlayFxWeaponPackSequence(self)
            end,
        
            PlayFxRackSalvoChargeSequence = function(self)
                if not self.SpinManip then 
                    self.SpinManip = CreateRotator(self.unit, 'RightRotator01', 'z', nil, 70, 50, 60)
                    self.unit.Trash:Add(self.SpinManip)
                end
                
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(100)
                end
                AIFArtilleryMiasmaShellWeapon1.PlayFxRackSalvoChargeSequence(self)
            end,            
            
            PlayFxRackSalvoReloadSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(50)
                end
                self.ExhaustEffects = EffectUtils.CreateBoneEffects( self.unit, 'RightArtyMuzzle01', self.unit:GetArmy(), Effects.WeaponSteam01 )
                AIFArtilleryMiasmaShellWeapon1.PlayFxRackSalvoChargeSequence(self)
            end,
		},
		ArtyGun02 = Class(AIFArtilleryMiasmaShellWeapon2) {
			PlayFxWeaponPackSequence = function(self)
                if self.SpinManip1 then
                    self.SpinManip1:SetTargetSpeed(0)
                end
                self.ExhaustEffects = EffectUtils.CreateBoneEffects( self.unit, 'LeftArtyMuzzle01', self.unit:GetArmy(), Effects.WeaponSteam01 )
                AIFArtilleryMiasmaShellWeapon2.PlayFxWeaponPackSequence(self)
            end,
        
            PlayFxRackSalvoChargeSequence = function(self)
                if not self.SpinManip1 then 
                    self.SpinManip1 = CreateRotator(self.unit, 'LeftRotator01', 'z', nil, 70, 50, 60)
                    self.unit.Trash:Add(self.SpinManip1)
                end
                
                if self.SpinManip1 then
                    self.SpinManip1:SetTargetSpeed(100)
                end
                AIFArtilleryMiasmaShellWeapon2.PlayFxRackSalvoChargeSequence(self)
            end,            
            
            PlayFxRackSalvoReloadSequence = function(self)
                if self.SpinManip1 then
                    self.SpinManip1:SetTargetSpeed(50)
                end
                self.ExhaustEffects = EffectUtils.CreateBoneEffects( self.unit, 'LeftArtyMuzzle01', self.unit:GetArmy(), Effects.WeaponSteam01 )
                AIFArtilleryMiasmaShellWeapon2.PlayFxRackSalvoChargeSequence(self)
            end,
		},
		Upgrade05Gun01 = Class(import('/lua/aeonweapons.lua').ADFCannonOblivionWeapon) {
			FxMuzzleFlash = {
				'/effects/emitters/oblivion_cannon_flash_04_emit.bp',
				'/effects/emitters/oblivion_cannon_flash_05_emit.bp',				
				'/effects/emitters/oblivion_cannon_flash_06_emit.bp',
			},        
        },
		Upgrade05Gun02 = Class(import('/lua/aeonweapons.lua').ADFCannonOblivionWeapon) {
			FxMuzzleFlash = {
				'/effects/emitters/oblivion_cannon_flash_04_emit.bp',
				'/effects/emitters/oblivion_cannon_flash_05_emit.bp',				
				'/effects/emitters/oblivion_cannon_flash_06_emit.bp',
			},        
        },
    },
    
	OnCreate = function(self)
        AWalkingLandUnit.OnCreate(self)

    end,	
				

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

        AWalkingLandUnit.DeathThread( self, overkillRatio , instigator)
    end,
    
}

TypeClass = UAL0405
