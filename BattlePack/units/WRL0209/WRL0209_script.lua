#****************************************************************************
#**
#**  File     :  /cdimage/units/URL0106/URL0106_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Cybran Light Infantry Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit
local CDFParticleCannonWeapon = import('/lua/cybranweapons.lua').CDFParticleCannonWeapon
local EffectUtil = import('/lua/EffectUtilities.lua')

WRL0209 = Class(CWalkingLandUnit) {
    Weapons = {
		MainGun = Class(CDFParticleCannonWeapon) {
            FxMuzzleFlash = {'/effects/emitters/particle_cannon_muzzle_02_emit.bp'},
			FxMuzzleFlashScale = 0.5,
        },
    },
	OnCreate = function(self)
        CWalkingLandUnit.OnCreate(self)
        if self:GetBlueprint().General.BuildBones then
            self:SetupBuildBones()
        end
    end,

	CreateBuildEffects = function( self, unitBeingBuilt, order )
       EffectUtil.CreateCybranBuildBeams( self, unitBeingBuilt, self:GetBlueprint().General.BuildBones.BuildEffectBones, self.BuildEffectsBag )
    end,
}

TypeClass = WRL0209