local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit

local Weapon = import('/lua/sim/Weapon.lua').Weapon
local WeaponFile = import('/lua/sim/defaultweapons.lua')
local CybranWeaponsFile = import('/lua/cybranweapons.lua')

local CDFHvyProtonCannonWeapon = CybranWeaponsFile.CDFHvyProtonCannonWeapon
local CDFElectronBolterWeapon = CybranWeaponsFile.CDFElectronBolterWeapon
local CAAMissileNaniteWeapon = CybranWeaponsFile.CAAMissileNaniteWeapon
local MissileRedirect = import('/lua/defaultantiprojectile.lua').MissileRedirect
local CIFArtilleryWeapon = CybranWeaponsFile.CIFArtilleryWeapon
local CDFHeavyMicrowaveLaserGenerator = CybranWeaponsFile.CDFHeavyMicrowaveLaserGenerator

local MobileUnit = import('/lua/defaultunits.lua').MobileUnit
local explosion = import('/lua/defaultexplosions.lua')
local CreateDeathExplosion = explosion.CreateDefaultHitExplosionAtBone
local EffectTemplate = import('/lua/EffectTemplates.lua')
local utilities = import('/lua/Utilities.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')
local Entity = import('/lua/sim/Entity.lua').Entity

WRL1466 = Class(CWalkingLandUnit) {
    WalkingAnimRate = 1.2,

    Weapons = {
		EXTargetPainter = Class(CDFHeavyMicrowaveLaserGenerator) {},
                MainGun = Class(CDFHvyProtonCannonWeapon) {},
		SubGun = Class(CDFHvyProtonCannonWeapon) {},
		LeftMiniTurret = Class(CDFElectronBolterWeapon) {},
		RightMiniTurret = Class(CDFElectronBolterWeapon) {},
		FrontMiniTurret = Class(CDFElectronBolterWeapon) {},
		AATurret01 = Class(CAAMissileNaniteWeapon) {},
		AATurret02 = Class(CAAMissileNaniteWeapon) {},
		ArtyTurret01 = Class(CIFArtilleryWeapon) {
                FxMuzzleFlash = {
                '/effects/emitters/cybran_artillery_muzzle_flash_01_emit.bp',
                '/effects/emitters/cybran_artillery_muzzle_flash_02_emit.bp',
                '/effects/emitters/cybran_artillery_muzzle_smoke_01_emit.bp',
            },
        }, 
		ArtyTurret02 = Class(CIFArtilleryWeapon) {
                FxMuzzleFlash = {
                '/effects/emitters/cybran_artillery_muzzle_flash_01_emit.bp',
                '/effects/emitters/cybran_artillery_muzzle_flash_02_emit.bp',
                '/effects/emitters/cybran_artillery_muzzle_smoke_01_emit.bp',
            },
        },
    },
	
	OnStartBeingBuilt = function(self, builder, layer)
        CWalkingLandUnit.OnStartBeingBuilt(self, builder, layer)
        if not self.AnimationManipulator then
            self.AnimationManipulator = CreateAnimator(self)
            self.Trash:Add(self.AnimationManipulator)
        end
        self.AnimationManipulator:PlayAnim(self:GetBlueprint().Display.AnimationActivate, false):SetRate(0)
    end,
	
	OnStopBeingBuilt = function(self,builder,layer)
        CWalkingLandUnit.OnStopBeingBuilt(self,builder,layer)
        if self.AnimationManipulator then
            self:SetUnSelectable(true)
            self.AnimationManipulator:SetRate(1)
            
            self:ForkThread(function()
                WaitSeconds(self.AnimationManipulator:GetAnimationDuration()*self.AnimationManipulator:GetRate())
                self:SetUnSelectable(false)
                self.AnimationManipulator:Destroy()
            end)
        end
    end,
	
	    CreateDamageEffects = function(self, bone, army )
        for k, v in EffectTemplate.DamageFireSmoke01 do
            CreateAttachedEmitter( self, bone, army, v ):ScaleEmitter(1.5)
        end
    end,	
    
    
    OnMotionHorzEventChange = function( self, new, old )
        CWalkingLandUnit.OnMotionHorzEventChange(self, new, old)
        
        if ( old == 'Stopped' ) then
            local bpDisplay = self:GetBlueprint().Display
            if bpDisplay.AnimationWalk and self.Animator then
                self.Animator:SetDirectionalAnim(true)
                self.Animator:SetRate(bpDisplay.AnimationWalkRate)
            end
         end
    end,
}

TypeClass = WRL1466
