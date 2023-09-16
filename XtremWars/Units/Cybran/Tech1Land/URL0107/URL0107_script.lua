#****************************************************************************
#**
#**  File     :  /cdimage/units/URL0107/URL0107_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Cybran Heavy Infantry Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit
local CybranWeaponsFile = import('/lua/cybranweapons.lua')
local CDFLaserHeavyWeapon = CybranWeaponsFile.CDFLaserHeavyWeapon
local EffectUtil = import('/lua/EffectUtilities.lua')
local CAANanoDartWeapon = CybranWeaponsFile.CAANanoDartWeapon

URL0107 = Class(CWalkingLandUnit) {
    Weapons = {
        LaserArms = Class(CDFLaserHeavyWeapon) {},
		UpgradeGun = Class(CDFLaserHeavyWeapon) {},
################ UPGRADE04
		Upgrade04Gun01 = Class(CAANanoDartWeapon) {},		
    },
    OnCreate = function(self)
        CWalkingLandUnit.OnCreate(self)
        if self:GetBlueprint().General.BuildBones then
            self:SetupBuildBones()
        end
    end,
	
    CreateBuildEffects = function( self, unitBeingBuilt, order )
       EffectUtil.SpawnBuildBots( self, unitBeingBuilt, 1, self.BuildEffectsBag )
       EffectUtil.CreateCybranBuildBeams( self, unitBeingBuilt, self:GetBlueprint().General.BuildBones.BuildEffectBones, self.BuildEffectsBag )
    end,
    		
}

TypeClass = URL0107
