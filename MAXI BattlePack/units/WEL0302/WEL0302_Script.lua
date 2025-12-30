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
local TDFPlasmaCannonWeapon = import('/lua/terranweapons.lua').TDFPlasmaCannonWeapon

local EffectUtils = import('/lua/effectutilities.lua')
local Effects = import('/lua/effecttemplates.lua')

WEL0302 = Class(TWalkingLandUnit) 
{
    Weapons = {
        GatlingCannon = Class(TDFPlasmaCannonWeapon) 
        {     

            FxChassisMuzzleFlash = {'/effects/emitters/phalanx_shells_01_emit.bp',},

            PlayFxMuzzleSequence = function(self, muzzle)
                if not self.SpinManip and not self.unit:IsDead() then 
                    self.SpinManip1 = CreateRotator(self.unit, 'RightArmBarrel', 'z', nil, 270, 180, 60)
                    self.SpinManip2 = CreateRotator(self.unit, 'LeftArmBarrel', 'z', nil, 270, 180, 60)
                    self.unit.Trash:Add(self.SpinManip1)
                    self.unit.Trash:Add(self.SpinManip2)
                end          
            
                for k, v in self.FxChassisMuzzleFlash do
                    CreateAttachedEmitter(self.unit, 'eject1', self.unit:GetArmy(), v):ScaleEmitter(0.5)
                    CreateAttachedEmitter(self.unit, 'eject2', self.unit:GetArmy(), v):ScaleEmitter(0.5)
                end
            end,                        

            CreateProjectileAtMuzzle = function(self, muzzle)
                local proj = TDFPlasmaCannonWeapon.CreateProjectileAtMuzzle(self, muzzle)
                if self.SpinManip1 and not self.unit:IsDead() then
                    self.SpinManip1:SetTargetSpeed(500)
                end
                if self.SpinManip2 and not self.unit:IsDead() then
                    self.SpinManip2:SetTargetSpeed(500)
                end
            end,

            OnLostTarget = function(self)
                if self.SpinManip1 and not self.unit:IsDead() then
                    self.SpinManip1:SetTargetSpeed(0)
                end
                if self.SpinManip2 and not self.unit:IsDead() then
                    self.SpinManip2:SetTargetSpeed(0)
                end
                self.ExhaustEffects = EffectUtils.CreateBoneEffects( self.unit, 'Right_Arm_Barrel_Muzzle', self.unit:GetArmy(), Effects.WeaponSteam01 )
		self.ExhaustEffects = EffectUtils.CreateBoneEffects( self.unit, 'Left_Arm_Barrel_Muzzle', self.unit:GetArmy(), Effects.WeaponSteam01 )
                TDFPlasmaCannonWeapon.OnLostTarget(self)
            end,
        },
    },
}

TypeClass = WEL0302