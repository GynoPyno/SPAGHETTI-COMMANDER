#****************************************************************************
#**
#**  File     :  /cdimage/units/XSL0303/XSL0303_script.lua
#**  Author(s):  Dru Staltman, Aaron Lundquist
#**
#**  Summary  :  Seraphim Siege Tank Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local SLandUnit = import('/lua/seraphimunits.lua').SLandUnit
local WeaponsFile = import('/lua/seraphimweapons.lua')
local SDFThauCannon = WeaponsFile.SDFThauCannon
local SDFAireauBolter = WeaponsFile.SDFAireauBolterWeapon
local EffectUtil = import('/lua/EffectUtilities.lua')

XSL0303 = Class(SLandUnit) {
    Weapons = {
        Turret_01 = Class(SDFAireauBolter) {},
        RocketBackpack = Class(import('/lua/cybranweapons.lua').CDFRocketIridiumWeapon02) {},
    },
	
    StartBeingBuiltEffects = function(self, builder, layer)
		SLandUnit.StartBeingBuiltEffects(self, builder, layer)
		self:ForkThread( EffectUtil.CreateSeraphimExperimentalBuildBaseThread, builder, self.OnBeingBuiltEffectsBag )
    end, 
	
}

TypeClass = XSL0303