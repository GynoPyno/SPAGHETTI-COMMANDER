#****************************************************************************
#**
#**  File     :  /units/XRLE0004/XRLE0004_script.lua
#**
#**  Summary  :  Mega Bot T2 Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit
local EffectTemplate = import('/lua/EffectTemplates.lua')
local CybranWeaponsFile = import('/lua/cybranweapons.lua')
local CDFHvyProtonCannonWeapon = CybranWeaponsFile.CDFHvyProtonCannonWeapon
local CAANanoDartWeapon = CybranWeaponsFile.CAANanoDartWeapon
local CIFArtilleryWeapon = import('/lua/cybranweapons.lua').CIFArtilleryWeapon
local DefaultProjectileWeapon = import('/lua/sim/DefaultWeapons.lua').DefaultProjectileWeapon

XRLE0004 = Class(CWalkingLandUnit) {

    SwitchAnims = true,
    IsWaiting = false,

    Weapons = {
		Missile02 = Class(CAANanoDartWeapon) {},
		Missile01 = Class(CAANanoDartWeapon) {},
        ParticleGun01 = Class(CDFHvyProtonCannonWeapon) {},
		ParticleGun02 = Class(CDFHvyProtonCannonWeapon) {},
        ArtyGun = Class(CIFArtilleryWeapon) {
            FxMuzzleFlashScale = 0.6,
            FxGroundEffect = EffectTemplate.CDisruptorGroundEffect,
	        FxVentEffect = EffectTemplate.CDisruptorVentEffect,
	        FxMuzzleEffect = EffectTemplate.CElectronBolterMuzzleFlash01,
	        FxCoolDownEffect = EffectTemplate.CDisruptorCoolDownEffect,
    

	        PlayFxMuzzleSequence = function(self, muzzle)
		        local army = self.unit:GetArmy()
		        DefaultProjectileWeapon.PlayFxMuzzleSequence(self, muzzle)
	            for k, v in self.FxGroundEffect do
                    CreateAttachedEmitter(self.unit, 'XRLEW0004', army, v)
                end
  	            for k, v in self.FxVentEffect do
                    CreateAttachedEmitter(self.unit, 'XRL417', army, v)
                    CreateAttachedEmitter(self.unit, 'XRL420', army, v)
					CreateAttachedEmitter(self.unit, 'XRL08', army, v)
                    CreateAttachedEmitter(self.unit, 'XRL13', army, v)
                end
  	            for k, v in self.FxMuzzleEffect do
					CreateAttachedEmitter(self.unit, 'Tir_Arty_02', army, v)
					CreateAttachedEmitter(self.unit, 'Tir_Arty_01', army, v)
                end
  	            for k, v in self.FxCoolDownEffect do
                    CreateAttachedEmitter(self.unit, 'Exaust01', army, v)
					CreateAttachedEmitter(self.unit, 'Exaust02', army, v)
                    CreateAttachedEmitter(self.unit, 'Exaust03', army, v)
					CreateAttachedEmitter(self.unit, 'Exaust04', army, v)					
                end
            end,
        },		
    },
	
     OnStopBeingBuilt = function(self,builder,layer)
        CWalkingLandUnit.OnStopBeingBuilt(self,builder,layer)
		# If created with F2 on land, then play the transform anim.
        if(self:GetCurrentLayer() == 'Land') then
            self.AT1 = self:ForkThread(self.TransformThread, false)
        end
    end,

    TransformThread = function(self, land)
        if( not self.AnimManip ) then
            self.AnimManip = CreateAnimator(self)
        end
        local bp = self:GetBlueprint()
        local scale = bp.Display.UniformScale or 1

        if( land ) then
			self:SetImmobile(true)
			self:SetSpeedMult(0)
		self:SetWeaponEnabledByLabel('Missile02', false)
		self:SetWeaponEnabledByLabel('ParticleGun01', false)
		self:SetWeaponEnabledByLabel('ParticleGun02', false)
            
            
            self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationTransform)
            self.AnimManip:SetRate(1)
            self.IsWaiting = true
            WaitFor(self.AnimManip)
			self.IsWaiting = false
            self.Trash:Add(self.AnimManip)
			self:SetWeaponEnabledByLabel('ArtyGun', true)
			self.SwitchAnims = true
        else
            self:SetImmobile(true)
            self:SetWeaponEnabledByLabel('ArtyGun', false)
            self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationTransform)
            self.AnimManip:SetAnimationFraction(1)
            self.AnimManip:SetRate(-1)
            self.IsWaiting = true
            WaitFor(self.AnimManip)
			self.IsWaiting = false
			self:SetSpeedMult(1)
            self.AnimManip:Destroy()
            self.AnimManip = nil
            self:SetImmobile(false)


			self:SetWeaponEnabledByLabel('Missile02', true)
			self:SetWeaponEnabledByLabel('ParticleGun01', true)
			self:SetWeaponEnabledByLabel('ParticleGun02', true)			
        end
    end,

	
    OnScriptBitSet = function(self, bit)
        CWalkingLandUnit.OnScriptBitSet(self, bit)
		local bp = self:GetBlueprint()
        if bit == 1 then 
			self.AT1 = self:ForkThread(self.TransformThread, true)
        end
    end,

    OnScriptBitClear = function(self, bit)
        CWalkingLandUnit.OnScriptBitClear(self, bit)
        if bit == 1 then 
			self.AT1 = self:ForkThread(self.TransformThread, false)
        end
    end,	

}

TypeClass = XRLE0004
