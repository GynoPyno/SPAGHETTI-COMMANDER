#****************************************************************************
#**
#**  File     :  /cdimage/units/XSB2104/XSB2104_script.lua
#**
#**  Summary  :  Seraphim Anti-Air Gun Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local SStructureUnit = import('/lua/seraphimunits.lua').SStructureUnit
local SAALosaareAutoCannonWeapon = import('/lua/seraphimweapons.lua').SAALosaareAutoCannonWeapon
local EffectUtil = import('/lua/EffectUtilities.lua')

WSB4404 = Class(SStructureUnit) {

    Weapons = {
        AAGun1 = Class(SAALosaareAutoCannonWeapon) { FxMuzzleScale = 1.25, },
		AAGun2 = Class(SAALosaareAutoCannonWeapon) { FxMuzzleScale = 1.25, },
		AAGun3 = Class(SAALosaareAutoCannonWeapon) { FxMuzzleScale = 1.25, },
    },
	
	StartBeingBuiltEffects = function(self, builder, layer)
		SStructureUnit.StartBeingBuiltEffects(self, builder, layer)
		self:ForkThread( EffectUtil.CreateSeraphimExperimentalBuildBaseThread, builder, self.OnBeingBuiltEffectsBag )
    end,  
}

TypeClass = WSB4404
