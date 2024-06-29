#****************************************************************************
#**
#**  File     :  /cdimage/units/URS0202/URS0202_script.lua
#**  Author(s):  David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Cybran Cruiser Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CSeaUnit = import('/lua/cybranunits.lua').CSeaUnit
local CybranWeaponsFile = import('/lua/cybranweapons.lua')
local CDFLaserDisintegratorWeapon = CybranWeaponsFile.CDFLaserDisintegratorWeapon02
local CAMZapperWeapon = import('/lua/cybranweapons.lua').CAMZapperWeapon
local CDFParticleCannonWeapon = import('/lua/cybranweapons.lua').CDFParticleCannonWeapon
local CAABurstCloudFlakArtilleryWeapon = import('/lua/cybranweapons.lua').CAABurstCloudFlakArtilleryWeapon

URS0202 = Class(CSeaUnit) {
    Weapons = {
        ParticleGun = Class(CDFLaserDisintegratorWeapon) {},
        Zapper = Class(CAMZapperWeapon) {},
		##UPGRADE02
		LateralGaucheGun01 = Class(CDFParticleCannonWeapon) {
            FxMuzzleFlash = {'/effects/emitters/particle_cannon_muzzle_02_emit.bp'},
        },
		LateralGaucheGun02 = Class(CDFParticleCannonWeapon) {
            FxMuzzleFlash = {'/effects/emitters/particle_cannon_muzzle_02_emit.bp'},
        },
		LateralGaucheGun03 = Class(CDFParticleCannonWeapon) {
            FxMuzzleFlash = {'/effects/emitters/particle_cannon_muzzle_02_emit.bp'},
        },
		LateralGaucheGun04 = Class(CDFParticleCannonWeapon) {
            FxMuzzleFlash = {'/effects/emitters/particle_cannon_muzzle_02_emit.bp'},
        },
		LateralDroitGun05 = Class(CDFParticleCannonWeapon) {
            FxMuzzleFlash = {'/effects/emitters/particle_cannon_muzzle_02_emit.bp'},
        },
		LateralDroitGun06 = Class(CDFParticleCannonWeapon) {
            FxMuzzleFlash = {'/effects/emitters/particle_cannon_muzzle_02_emit.bp'},
        },
		LateralDroitGun07 = Class(CDFParticleCannonWeapon) {
            FxMuzzleFlash = {'/effects/emitters/particle_cannon_muzzle_02_emit.bp'},
        },
		LateralDroitGun08 = Class(CDFParticleCannonWeapon) {
            FxMuzzleFlash = {'/effects/emitters/particle_cannon_muzzle_02_emit.bp'},
        },	
		###UPGRADE03
		ParticleGun03 = Class(CDFLaserDisintegratorWeapon) {},			
		###UPGRADE04
		ParticleGun04 = Class(CDFLaserDisintegratorWeapon) {},	
		AAGun01 = Class(CAABurstCloudFlakArtilleryWeapon) {
		  PlayFxWeaponUnpackSequence = function(self)
                if not self.SpinManip03 then 
                    self.SpinManip03 = CreateRotator(self.unit, 'Rotator03', 'z', nil, 270, 270, 80)
                    self.SpinManip03:SetPrecedence(10)
                    self.unit.Trash:Add(self.SpinManip03)
                end
				if not self.SpinManip04 then 
                    self.SpinManip04 = CreateRotator(self.unit, 'Rotator04', 'z', nil, 270, 270, 80)
                    self.SpinManip04:SetPrecedence(10)
                    self.unit.Trash:Add(self.SpinManip04)
                end
                if self.SpinManip03 then
                    self.SpinManip03:SetTargetSpeed(270)
                end
				if self.SpinManip04 then
                    self.SpinManip04:SetTargetSpeed(270)
                end
                CAABurstCloudFlakArtilleryWeapon.PlayFxWeaponUnpackSequence(self)
            end,

            PlayFxWeaponPackSequence = function(self)
                if self.SpinManip03 then
                    self.SpinManip03:SetTargetSpeed(0)
                end
				if self.SpinManip04 then
                    self.SpinManip04:SetTargetSpeed(0)
                end
                CAABurstCloudFlakArtilleryWeapon.PlayFxWeaponPackSequence(self)
            end,		
		},
		AAGun02 = Class(CAABurstCloudFlakArtilleryWeapon) {
		  PlayFxWeaponUnpackSequence = function(self)
                if not self.SpinManip01 then 
                    self.SpinManip01 = CreateRotator(self.unit, 'Rotator01', 'z', nil, 270, 270, 270)
                    self.SpinManip01:SetPrecedence(10)
                    self.unit.Trash:Add(self.SpinManip01)
                end
				if not self.SpinManip02 then 
                    self.SpinManip02 = CreateRotator(self.unit, 'Rotator02', 'z', nil, 270, 270, 270)
                    self.SpinManip02:SetPrecedence(10)
                    self.unit.Trash:Add(self.SpinManip02)
                end
                if self.SpinManip01 then
                    self.SpinManip01:SetTargetSpeed(270)
                end
				if self.SpinManip02 then
                    self.SpinManip02:SetTargetSpeed(270)
                end
                CAABurstCloudFlakArtilleryWeapon.PlayFxWeaponUnpackSequence(self)
            end,

            PlayFxWeaponPackSequence = function(self)
                if self.SpinManip01 then
                    self.SpinManip01:SetTargetSpeed(0)
                end
				if self.SpinManip02 then
                    self.SpinManip02:SetTargetSpeed(0)
                end
                CAABurstCloudFlakArtilleryWeapon.PlayFxWeaponPackSequence(self)
            end,
		},
    },
    
    OnCreate = function(self)
        CSeaUnit.OnCreate(self)
		self:HideBone('Light_turret01', true)
		self:HideBone('Origine01', true)
    end,
    

	
}

TypeClass = URS0202