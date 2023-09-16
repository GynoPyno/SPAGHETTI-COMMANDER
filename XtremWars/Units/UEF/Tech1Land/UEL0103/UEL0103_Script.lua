#****************************************************************************
#**
#**  File     :  /cdimage/units/UEL0103/UEL0103_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**				Upgrades Model By Asdrubaelvect Script By Manimal For Experimental Wars 1.8
#**  Summary  :  Mobile Light Artillery Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local TIFHighBallisticMortarWeapon02 = import('/lua/terranweapons.lua').TIFHighBallisticMortarWeapon
local EffectUtil = import('/lua/EffectUtilities.lua')
local Effects = import('/lua/effecttemplates.lua')

UEL0103 = Class(TLandUnit) {
    Weapons = {
		UpgradeGun04 = Class(TIFHighBallisticMortarWeapon02) {    
            CreateProjectileAtMuzzle = function(self, muzzle)
                    local proj = TIFHighBallisticMortarWeapon02.CreateProjectileAtMuzzle(self, muzzle)
                    local data = {
                        Radius = self:GetBlueprint().CameraVisionRadius or 5,
                        Lifetime = self:GetBlueprint().CameraLifetime or 5,
                        Army = self.unit:GetArmy(),
                    }
                    if proj and not proj:BeenDestroyed() then
                        proj:PassData(data)
                    end
                end,
				
			PlayFxWeaponPackSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(0)
                end
                self.ExhaustEffects = EffectUtil.CreateBoneEffects( self.unit, 'Turret_Barrel02', self.unit:GetArmy(), Effects.WeaponSteam01 )
                TIFHighBallisticMortarWeapon02.PlayFxWeaponPackSequence(self)
            end,
        
            PlayFxRackSalvoChargeSequence = function(self)
                if not self.SpinManip then 
                    self.SpinManip = CreateRotator(self.unit, 'Turret_Barrel02', 'z', nil, 100, 30, 40)
                    self.unit.Trash:Add(self.SpinManip)
                end
                
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(80)
                end
                TIFHighBallisticMortarWeapon02.PlayFxRackSalvoChargeSequence(self)
            end,            
            
            PlayFxRackSalvoReloadSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(0)
                end
                self.ExhaustEffects = EffectUtil.CreateBoneEffects( self.unit, 'Turret_Barrel02', self.unit:GetArmy(), Effects.WeaponSteam01 )
                TIFHighBallisticMortarWeapon02.PlayFxRackSalvoChargeSequence(self)
            end,	
            },	
		
    },

    OnCreate = function(self)
        TLandUnit.OnCreate(self)
		self:HideBone('Origine_01', true)
		self:HideBone('Origine_04', true)
		self:HideBone('Turret', true)

    end,
	

}

TypeClass = UEL0103