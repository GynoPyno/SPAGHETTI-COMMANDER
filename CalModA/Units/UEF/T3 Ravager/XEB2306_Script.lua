--------------------------------------------------------------------------------
-- File     :  /cdimage/units/XEB2306/XEB2306_script.lua
-- Author(s):  John Comes, David Tomandl, Jessica St. Croix, Matt Vainio
-- Summary  :  Terran Light Gun Tower Script
-- Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
--------------------------------------------------------------------------------
local TStructureUnit = import("/lua/terranunits.lua").TStructureUnit
local TDFHeavyPlasmaCannonWeapon = import("/lua/terranweapons.lua").TDFHeavyPlasmaGatlingCannonWeapon
local TAMPhalanxWeapon = import('/lua/terranweapons.lua').TAMPhalanxWeapon
local TAALinkedRailgun = import('/lua/terranweapons.lua').TAALinkedRailgun
local EffectUtils = import("/lua/effectutilities.lua")
local Effects = import("/lua/effecttemplates.lua")

---@class XEB2306 : TStructureUnit
XEB2306 = ClassUnit(TStructureUnit) {
    Weapons = {
        MainGun = ClassWeapon(TAALinkedRailgun) 
        {
            PlayFxWeaponPackSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(0)
                end
				EffectUtils.CreateBoneEffectsOpti(self.unit, 'Exhaust', self.unit.Army, Effects.WeaponSteam01)
                TAALinkedRailgun.PlayFxWeaponPackSequence(self)
            end,

            PlayFxRackSalvoChargeSequence = function(self)
                if not self.SpinManip then 
                    self.SpinManip = CreateRotator(self.unit, 'Gun_Barrel', 'z', nil, 550, 550, 350)
                    self.unit.Trash:Add(self.SpinManip)
                end
                
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(900)
                end
                TAALinkedRailgun.PlayFxRackSalvoChargeSequence(self)
            end,

            PlayFxRackSalvoReloadSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(200)
                end
                EffectUtils.CreateBoneEffectsOpti(self.unit, 'Exhaust', self.unit.Army, Effects.WeaponSteam01)
                TAALinkedRailgun.PlayFxRackSalvoChargeSequence(self)
            end,    
        }
    },
}

TypeClass = XEB2306