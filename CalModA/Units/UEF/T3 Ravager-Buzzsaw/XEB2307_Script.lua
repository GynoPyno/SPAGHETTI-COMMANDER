--------------------------------------------------------------------------------
-- File     :  /cdimage/units/XEB2306/XEB2306_script.lua
-- Author(s):  John Comes, David Tomandl, Jessica St. Croix, Matt Vainio
-- Summary  :  Terran Light Gun Tower Script
-- Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
--------------------------------------------------------------------------------
local TStructureUnit = import("/lua/terranunits.lua").TStructureUnit
local TDFHeavyPlasmaCannonWeapon = import("/lua/terranweapons.lua").TDFHeavyPlasmaGatlingCannonWeapon
local TAMPhalanxWeapon = import('/lua/terranweapons.lua').TAMPhalanxWeapon
local EffectUtils = import("/lua/effectutilities.lua")
local Effects = import("/lua/effecttemplates.lua")

---@class XEB2306 : TStructureUnit
XEB2306 = ClassUnit(TStructureUnit) {
    Weapons = {
        MainGun = Class(TAMPhalanxWeapon) {
                IdleState = State (TAMPhalanxWeapon.IdleState) {
                Main = function(self)
                    TAMPhalanxWeapon.IdleState.Main(self)
                end,
                
                OnGotTarget = function(self)
                        if not self.SpinManip then 
                            self.SpinManip = CreateRotator(self.unit, 'Gun_Barrel', 'z', nil, 1000, 1000, 1000)
                            self.unit.Trash:Add(self.SpinManip)
                            self.SpinManip:SetTargetSpeed(750)
                        end 
                        TAMPhalanxWeapon.OnGotTarget(self)
                end,
                    OnFire = function(self)
                        TAMPhalanxWeapon.IdleState.OnFire(self)
                        if self.SpinManip then
                        self.SpinManip:SetTargetSpeed(750)
                        end 
                end,                
            },
                  
            OnLostTarget = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(0)
                end 

                self.ExhaustEffects = EffectUtils.CreateBoneEffects( self.unit, 'Exhaust', self.unit:GetArmy(), Effects.WeaponSteam01 )
                TAMPhalanxWeapon.OnLostTarget(self)
            end,  
        },
    },
}

TypeClass = XEB2306