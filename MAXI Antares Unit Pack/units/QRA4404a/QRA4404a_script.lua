#****************************************************************************
#**
#**  File     :  /cdimage/units/URA0401/URA0401_script.lua
#**  Author(s):  John Comes, Andres Mendez, Gordon Duclos
#**
#**  Summary  :  Cybran Gunship Script
#**
#**  Copyright © 2006 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CAirUnit = import('/lua/cybranunits.lua').CAirUnit
local CDFRocketIridiumWeapon = import('/lua/cybranweapons.lua').CDFRocketIridiumWeapon
local CAAMissileNaniteWeapon = import('/lua/cybranweapons.lua').CAAMissileNaniteWeapon
local CDFHeavyElectronBolterWeapon = import('/lua/cybranweapons.lua').CDFHeavyElectronBolterWeapon
local util = import('/lua/utilities.lua')
local fxutil = import('/lua/effectutilities.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TMEffectTemplate = import('/mods/TotalMayhem/lua/TMEffectTemplates.lua')

URA0401 = Class(CAirUnit) {
	

    Weapons = {
        Missile01 = Class(CDFRocketIridiumWeapon) {FxMuzzleFlashScale = 6.75,},
        Missile02 = Class(CDFRocketIridiumWeapon) {FxMuzzleFlashScale = 6.75,},
        HeavyBolter = Class(CDFHeavyElectronBolterWeapon){FxMuzzleFlashScale = 6.75,},
        HeavyBolterBack = Class(CDFHeavyElectronBolterWeapon){FxMuzzleFlashScale = 6.75,},
        AAMissile01 = Class(CAAMissileNaniteWeapon) {
		FxMuzzleFlash = {
        '/effects/emitters/cannon_muzzle_flash_04_emit.bp',
        '/effects/emitters/cannon_muzzle_smoke_11_emit.bp',
    }, 
		FxMuzzleFlashScale = 6.75,},
        AAMissile02 = Class(CAAMissileNaniteWeapon) {
		FxMuzzleFlash = {
        '/effects/emitters/cannon_muzzle_flash_04_emit.bp',
        '/effects/emitters/cannon_muzzle_smoke_11_emit.bp',
    }, 
		FxMuzzleFlashScale = 6.75,},


    },
    
  

    DestructionPartsChassisToss = {'URA0401',},
    DestroyNoFallRandomChance = 1.1,

    OnStopBeingBuilt = function(self,builder,layer)
        CAirUnit.OnStopBeingBuilt(self,builder,layer)
        self.AnimManip = CreateAnimator(self)
        self.Trash:Add(self.AnimManip)
		self:CreatTheEffects()
        #self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationTakeOff, false):SetRate(1)
    end,
    
	CreatTheEffects = function(self)
	local army =  self:GetArmy()
	for k, v in EffectTemplate['CT2PowerAmbient'] do
		self.Trash:Add(CreateAttachedEmitter(self, -1, army, v):ScaleEmitter(1.1 * 3))
	end
	for k, v in TMEffectTemplate['BRMT3EXBMPOWEREFFECT'] do
		self.Trash:Add(CreateAttachedEmitter(self, 'RightFront_Turret_Muzzle01', army, v):ScaleEmitter(2.00 * 3))
	end
	for k, v in TMEffectTemplate['BRMT3EXBMPOWEREFFECT'] do
		self.Trash:Add(CreateAttachedEmitter(self, -1, army, v):ScaleEmitter(2.00 * 3))
	end
	
	for k, v in TMEffectTemplate['BRMT3EXBMPOWEREFFECT'] do
		self.Trash:Add(CreateAttachedEmitter(self, -1, army, v):ScaleEmitter(2.00 * 3))
	end
	for k, v in TMEffectTemplate['BRMT3EXBMPOWEREFFECT'] do
		self.Trash:Add(CreateAttachedEmitter(self, 'Front_Turret_Muzzle08', army, v):ScaleEmitter(2.50 * 3))
	end
	for k, v in TMEffectTemplate['BRMT3EXBMPOWEREFFECT'] do
		self.Trash:Add(CreateAttachedEmitter(self, -1, army, v):ScaleEmitter(3.00 * 3))
	end
	for k, v in EffectTemplate['CT2PowerAmbient'] do
		self.Trash:Add(CreateAttachedEmitter(self, -1, army, v):ScaleEmitter(0.4 * 3))
	end
	for k, v in EffectTemplate['DamageSparks01'] do
		self.Trash:Add(CreateAttachedEmitter(self, 'RightFront_Turret_Muzzle01', army, v):ScaleEmitter(1.7 * 5))
	end
	#for k, v in EffectTemplate['DamageSparks01'] do
	#	self.Trash:Add(CreateAttachedEmitter(self, -1, army, v):ScaleEmitter(1.9 * 5))
	#end
	for k, v in EffectTemplate['DamageSparks01'] do
		self.Trash:Add(CreateAttachedEmitter(self, 'RightFront_Turret_Muzzle02', army, v):ScaleEmitter(2.1 * 7))
	end
	for k, v in EffectTemplate['GenericTeleportCharge01'] do
		self.Trash:Add(CreateAttachedEmitter(self, 'RightFront_Turret_Muzzle03', army, v):ScaleEmitter(0.3 * 5))
	end
	#for k, v in EffectTemplate['GenericTeleportCharge01'] do
	#	self.Trash:Add(CreateAttachedEmitter(self, -1, army, v):ScaleEmitter(0.3 * 5))
	#end
	for k, v in EffectTemplate['GenericTeleportCharge01'] do
		self.Trash:Add(CreateAttachedEmitter(self, 'RightFront_Turret_Muzzle03', army, v):ScaleEmitter(0.3 * 5))
	end
	for k, v in EffectTemplate['GenericTeleportCharge01'] do
		self.Trash:Add(CreateAttachedEmitter(self, 'Front_Turret_Muzzle08', army, v):ScaleEmitter(0.3 * 5))
	end
	for k, v in EffectTemplate['GenericTeleportCharge01'] do
		self.Trash:Add(CreateAttachedEmitter(self, 'Front_Turret_Muzzle09', army, v):ScaleEmitter(0.3 * 5))
	end
	for k, v in EffectTemplate['GenericTeleportCharge01'] do
		self.Trash:Add(CreateAttachedEmitter(self, 'Front_Turret_Muzzle10', army, v):ScaleEmitter(0.3 * 5))
	end
end,

OnKilled = function(self, instigator, damagetype, overkillRatio)
        CAirUnit.OnKilled(self, instigator, damagetype, overkillRatio)
        self:CreatTheEffectsDeath()  
    end,

CreatTheEffectsDeath = function(self)
	local army =  self:GetArmy()
	for k, v in TMEffectTemplate['UEFHEAVYMISSILE01'] do
		self.Trash:Add(CreateAttachedEmitter(self, -1, army, v):ScaleEmitter(12.65))
	end
	for k, v in TMEffectTemplate['CYBRANHEAVYPROTONARTILLERYHIT01'] do
		self.Trash:Add(CreateAttachedEmitter(self, 'Front_Turret_Muzzle10', army, v):ScaleEmitter(16.65))
	end
	for k, v in TMEffectTemplate['CYBRANHEAVYPROTONARTILLERYHIT01'] do
		self.Trash:Add(CreateAttachedEmitter(self, 'RightFront_Turret_Muzzle03', army, v):ScaleEmitter(16.65))
	end
	for k, v in TMEffectTemplate['CYBRANHEAVYPROTONARTILLERYHIT01'] do
		self.Trash:Add(CreateAttachedEmitter(self, -1, army, v):ScaleEmitter(16.65))
	end
end,
   
    
   
}

TypeClass = URA0401