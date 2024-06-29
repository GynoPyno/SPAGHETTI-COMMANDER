#****************************************************************************
#**
#**  File     :  /cdimage/units/DEL0204/DEL0204_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix, Matt Vainio
#**
#**  Summary  :  UEF Mongoose Gatling Bot
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local TWalkingLandUnit = import('/lua/terranunits.lua').TWalkingLandUnit

local TWeapons = import('/lua/terranweapons.lua')
local TDFPlasmaCannonWeapon = TWeapons.TDFPlasmaCannonWeapon
local TIFFragLauncherWeapon = TWeapons.TDFFragmentationGrenadeLauncherWeapon
local TDFMachineGunWeapon = import('/lua/terranweapons.lua').TDFMachineGunWeapon
local EffectUtils = import('/lua/effectutilities.lua')
local Effects = import('/lua/effecttemplates.lua')

DEL0204 = Class(TWalkingLandUnit) 
{
    Weapons = {
		MainGun = Class(TDFMachineGunWeapon) {},
		###UPGRADE02
        GatlingCannon = Class(TDFPlasmaCannonWeapon) 
        {
            PlayFxWeaponPackSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(0)
                end
				if self.SpinManip2 then
                    self.SpinManip2:SetTargetSpeed(0)
                end
                self.ExhaustEffects = EffectUtils.CreateBoneEffects( self.unit, 'Left_Arm_Barrel_Muzzle', self.unit:GetArmy(), Effects.WeaponSteam01 )
				self.ExhaustEffects = EffectUtils.CreateBoneEffects( self.unit, 'Left_Arm_Barrel_Muzzle01', self.unit:GetArmy(), Effects.WeaponSteam01 )
                TDFPlasmaCannonWeapon.PlayFxWeaponPackSequence(self)
            end,
        
            PlayFxRackSalvoChargeSequence = function(self)
                if not self.SpinManip then 
                    self.SpinManip = CreateRotator(self.unit, 'Left_Arm_Barrel', 'z', nil, 270, 180, 60)				
                    self.unit.Trash:Add(self.SpinManip)
                end
				if not self.SpinManip2 then 
                    self.SpinManip2 = CreateRotator(self.unit, 'Left_Arm_Barrel01', 'z', nil, 270, 180, 60)				
                    self.unit.Trash:Add(self.SpinManip2)
                end						
                
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(300)
                end
				if self.SpinManip2 then
                    self.SpinManip2:SetTargetSpeed(300)
                end
                TDFPlasmaCannonWeapon.PlayFxRackSalvoChargeSequence(self)
            end,            
            
            PlayFxRackSalvoReloadSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(180)
                end
				if self.SpinManip2 then
                    self.SpinManip2:SetTargetSpeed(180)
                end
                self.ExhaustEffects = EffectUtils.CreateBoneEffects( self.unit, 'Left_Arm_Barrel_Muzzle', self.unit:GetArmy(), Effects.WeaponSteam01 )
                self.ExhaustEffects = EffectUtils.CreateBoneEffects( self.unit, 'Left_Arm_Barrel_Muzzle01', self.unit:GetArmy(), Effects.WeaponSteam01 )
				TDFPlasmaCannonWeapon.PlayFxRackSalvoChargeSequence(self)
            end,			
        },
		###UPGRADE04	
		Grenade01 = Class(TIFFragLauncherWeapon) {},
		Grenade02 = Class(TIFFragLauncherWeapon) {},
    },

    OnCreate = function(self)
		TWalkingLandUnit.OnCreate(self)

    end,

}

TypeClass = DEL0204