#****************************************************************************
#**
#**  File     :  /cdimage/units/URL0402/URL0402_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix, Gordon Duclos
#**
#**  Summary  :  Cybran Spider Bot Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local WeaponsFile2 = import('/lua/cybranweapons.lua')
local WeaponsFile3 = import('/mods/BattlePack/lua/BattlePackweapons.lua')
local CDFHvyProtonCannonWeapon = WeaponsFile2.CDFHvyProtonCannonWeapon
local CDFElectronBolterWeapon = WeaponsFile2.CDFElectronBolterWeapon
local MissileRedirect = import('/lua/defaultantiprojectile.lua').MissileRedirect
local CAAMissileNaniteWeapon = WeaponsFile2.CAAMissileNaniteWeapon
local EXCEMPArrayBeam01 = import('/mods/BattlePack/lua/BattlePackweapons.lua').EXCEMPArrayBeam01 

local MobileUnit = import('/lua/defaultunits.lua').MobileUnit
local explosion = import('/lua/defaultexplosions.lua')
local CreateDeathExplosion = explosion.CreateDefaultHitExplosionAtBone
local EffectTemplate = import('/lua/EffectTemplates.lua')
local utilities = import('/lua/Utilities.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')
local Entity = import('/lua/sim/Entity.lua').Entity

WRL2466 = Class(CWalkingLandUnit) {

    Weapons = {
		EXTargetPainter = Class(EXCEMPArrayBeam01) {},
		ParticleGunRight = Class(CDFHvyProtonCannonWeapon) {},
        ParticleGunLeft = Class(CDFHvyProtonCannonWeapon) {},
		LeftBolterCannon1 = Class(CDFElectronBolterWeapon) {},
		LeftBolterCannon2 = Class(CDFElectronBolterWeapon) {},
		RightBolterCannon1 = Class(CDFElectronBolterWeapon) {},		
		RightBolterCannon2 = Class(CDFElectronBolterWeapon) {},		
		AAMissiles = Class(CAAMissileNaniteWeapon) {},
		FrontLaser01 = Class(CDFElectronBolterWeapon) {},
        LeftLaser01 = Class(CDFElectronBolterWeapon) {},
        RightLaser01 = Class(CDFElectronBolterWeapon) {},
        TopBackLaser01 = Class(CDFElectronBolterWeapon) {},
        BackLaser01 = Class(CDFElectronBolterWeapon) {},
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
        local bp = self:GetBlueprint().Defense.AntiMissile
        local antiMissile = MissileRedirect {
            Owner = self,
            Radius = bp.Radius,
            AttachBone = bp.AttachBone,
            RedirectRateOfFire = bp.RedirectRateOfFire
        }
        self.Trash:Add(antiMissile)
        self.UnitComplete = true
		
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

TypeClass = WRL2466
