#****************************************************************************
#**
#**  File     :  /cdimage/units/UES0202/UES0202_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  UEF Cruiser Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TSeaUnit = import('/lua/terranunits.lua').TSeaUnit
local WeaponFile = import('/lua/terranweapons.lua')
local TSAMLauncher = WeaponFile.TSAMLauncher
local TDFGaussCannonWeapon = WeaponFile.TDFGaussCannonWeapon
local TAMPhalanxWeapon = WeaponFile.TAMPhalanxWeapon
local TIFCruiseMissileLauncher = WeaponFile.TIFCruiseMissileLauncher

UES0202 = Class(TSeaUnit) {
    DestructionTicks = 200,

    Weapons = {
        PhalanxGun01 = Class(TAMPhalanxWeapon) {
            PlayFxWeaponUnpackSequence = function(self)
                if not self.SpinManip then 
                    self.SpinManip = CreateRotator(self.unit, 'Center_Turret_Barrel', 'z', nil, 270, 180, 60)
                    self.SpinManip:SetPrecedence(10)
                    self.unit.Trash:Add(self.SpinManip)
                end
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(270)
                end
                TAMPhalanxWeapon.PlayFxWeaponUnpackSequence(self)
            end,

            PlayFxWeaponPackSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(0)
                end
                TAMPhalanxWeapon.PlayFxWeaponPackSequence(self)
            end,
        },
        CruiseMissile = Class(TIFCruiseMissileLauncher) {               
            },
			#UPGRADE02
        CruiseMissile02 = Class(TIFCruiseMissileLauncher) {},
		FrontTurret02 = Class(TDFGaussCannonWeapon) {},
			#Upgrade03
		PhalanxGun02 = Class(TAMPhalanxWeapon) {
            PlayFxWeaponUnpackSequence = function(self)
                if not self.SpinManip then 
                    self.SpinManip = CreateRotator(self.unit, 'Center_Turret_Barrel01', 'z', nil, 270, 180, 60)
                    self.SpinManip:SetPrecedence(10)
                    self.unit.Trash:Add(self.SpinManip)
                end
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(270)
                end
                TAMPhalanxWeapon.PlayFxWeaponUnpackSequence(self)
            end,

            PlayFxWeaponPackSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(0)
                end
                TAMPhalanxWeapon.PlayFxWeaponPackSequence(self)
            end,
        },
		PhalanxGun03 = Class(TAMPhalanxWeapon) {
            PlayFxWeaponUnpackSequence = function(self)
                if not self.SpinManip then 
                    self.SpinManip = CreateRotator(self.unit, 'Center_Turret_Barrel02', 'z', nil, 270, 180, 60)
                    self.SpinManip:SetPrecedence(10)
                    self.unit.Trash:Add(self.SpinManip)
                end
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(270)
                end
                TAMPhalanxWeapon.PlayFxWeaponUnpackSequence(self)
            end,

            PlayFxWeaponPackSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(0)
                end
                TAMPhalanxWeapon.PlayFxWeaponPackSequence(self)
            end,
        },	
			##UPGRADE04
		AdvancedAATurret01 = Class(TSAMLauncher) {
            FxMuzzleFlash = EffectTemplate.TAAMissileLaunchNoBackSmoke,
        },	
		AdvancedAATurret02 = Class(TSAMLauncher) {
            FxMuzzleFlash = EffectTemplate.TAAMissileLaunchNoBackSmoke,
        },			
    },

    RadarThread = function(self)
        local spinner = CreateRotator(self, 'Spinner04', 'x', nil, 0, 30, -45)
		local spinner01 = CreateRotator(self, 'Spinner10', 'x', nil, 0, 30, -45)
		local spinner02 = CreateRotator(self, 'Spinner10b', 'x', nil, 0, 30, -45)
		--local spinner03 = CreateRotator(self, 'Spinner04', 'x', nil, 0, 30, -45)
        while true do
            WaitFor(spinner)
            spinner:SetTargetSpeed(-45)
			spinner01:SetTargetSpeed(-45)
			spinner02:SetTargetSpeed(-45)
            WaitFor(spinner)
            spinner:SetTargetSpeed(45)
			 spinner01:SetTargetSpeed(45)
			  spinner02:SetTargetSpeed(45)
        end
    end,
	
    OnCreate = function(self)
        TSeaUnit.OnCreate(self)
		self:HideBone('Origine01', true)
		self:HideBone('Object12', true)
		self:HideBone('Object07', true) --Back_Turret02
		self:HideBone('Back_Turret02', true)
    end,
	
    OnStopBeingBuilt = function(self, builder,layer)
        TSeaUnit.OnStopBeingBuilt(self, builder,layer)
        self:ForkThread(self.RadarThread)
        self.Trash:Add(CreateRotator(self, 'Spinner01', 'y', nil, 45, 0, 0))
		self.Trash:Add(CreateRotator(self, 'Spinner11', 'y', nil, 45, 0, 0))
		self.Trash:Add(CreateRotator(self, 'Spinner07', 'y', nil, 45, 0, 0))
        self.Trash:Add(CreateRotator(self, 'Spinner03', 'y', nil, -30, 0, 0))	
    end,
			

}

TypeClass = UES0202
