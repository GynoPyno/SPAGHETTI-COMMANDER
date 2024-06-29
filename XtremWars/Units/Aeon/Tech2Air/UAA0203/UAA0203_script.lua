--[[#######################################################################
#  File     :  /units/Usines/UAA0203/UAA0203_script.lua
#  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#  Summary  :  Aeon Gunship Script
#  -----------------------------
#  Modif.by :  Asdrubaelvect
#  Rev.Date :  jj mmmmm aaaa
#  -----------------------------
#  Revis.by :  Manimal
#  Rev.Date :  18 mars 2010
#  -----------------------------
#  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#######################################################################]]--

local AAirUnit = import('/lua/aeonunits.lua').AAirUnit
local ADFLaserLightWeapon = import('/lua/aeonweapons.lua').ADFLaserLightWeapon
local AAASonicPulseBatteryWeapon = import('/lua/aeonweapons.lua').AAASonicPulseBatteryWeapon

UAA0203 = Class( AAirUnit ) {
    Weapons = {
        Turret = Class( ADFLaserLightWeapon ) {
			FxChassisMuzzleFlash = {'/effects/emitters/aeon_gunship_body_illumination_01_emit.bp',},
			
			PlayFxMuzzleSequence = function(self, muzzle)
				local bp = self:GetBlueprint()
				local army = self.unit:GetArmy()
				for k, v in self.FxMuzzleFlash do
					CreateAttachedEmitter(self.unit, muzzle, army, v)
				end
				
				for k, v in self.FxChassisMuzzleFlash do
					CreateAttachedEmitter(self.unit, -1, army, v)
				end
				
				if self.unit:GetCurrentLayer() == 'Water' and bp.Audio.FireUnderWater then
					self:PlaySound(bp.Audio.FireUnderWater)
				elseif bp.Audio.Fire then
					self:PlaySound(bp.Audio.Fire)
				end
			end,        
        },
		Turret02 = Class( ADFLaserLightWeapon ) {
			FxChassisMuzzleFlash = {'/effects/emitters/aeon_gunship_body_illumination_01_emit.bp',},
			
			PlayFxMuzzleSequence = function(self, muzzle)
				local bp = self:GetBlueprint()
				local army = self.unit:GetArmy()
				for k, v in self.FxMuzzleFlash do
					CreateAttachedEmitter(self.unit, muzzle, army, v)
				end
				
				for k, v in self.FxChassisMuzzleFlash do
					CreateAttachedEmitter(self.unit, -1, army, v)
				end
				
				if self.unit:GetCurrentLayer() == 'Water' and bp.Audio.FireUnderWater then
					self:PlaySound(bp.Audio.FireUnderWater)
				elseif bp.Audio.Fire then
					self:PlaySound(bp.Audio.Fire)
				end
			end,        
        },	
		Turret03 = Class( ADFLaserLightWeapon ) {
			FxChassisMuzzleFlash = {'/effects/emitters/aeon_gunship_body_illumination_01_emit.bp',},
			
			PlayFxMuzzleSequence = function(self, muzzle)
				local bp = self:GetBlueprint()
				local army = self.unit:GetArmy()
				for k, v in self.FxMuzzleFlash do
					CreateAttachedEmitter(self.unit, muzzle, army, v)
				end
				
				for k, v in self.FxChassisMuzzleFlash do
					CreateAttachedEmitter(self.unit, -1, army, v)
				end
				
				if self.unit:GetCurrentLayer() == 'Water' and bp.Audio.FireUnderWater then
					self:PlaySound(bp.Audio.FireUnderWater)
				elseif bp.Audio.Fire then
					self:PlaySound(bp.Audio.Fire)
				end
			end,        
        },
		SonicPulseBattery1 = Class(AAASonicPulseBatteryWeapon) {
			FxMuzzleFlash = {'/effects/emitters/sonic_pulse_muzzle_flash_02_emit.bp',},
        },
		SonicPulseBatterySpec = Class(AAASonicPulseBatteryWeapon) {
			FxMuzzleFlash = {'/effects/emitters/sonic_pulse_muzzle_flash_02_emit.bp',},
        },	
    },
	

    OnCreate = function(self)
		AAirUnit.OnCreate(self)

    end,	
	
}


TypeClass = UAA0203