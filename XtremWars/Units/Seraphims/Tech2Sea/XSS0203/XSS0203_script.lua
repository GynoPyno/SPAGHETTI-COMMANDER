#****************************************************************************
#**
#**  File     :  /units/XSS0203/XSS0203_script.lua
#**
#**  Summary  :  Seraphim Attack Sub Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local SSubUnit = import('/lua/seraphimunits.lua').SSubUnit
local SWeapons = import('/lua/seraphimweapons.lua')
local SANUallCavitationTorpedo = SWeapons.SANUallCavitationTorpedo
local SDFOhCannon = SWeapons.SDFOhCannon02
local SDFAjelluAntiTorpedoDefense = SWeapons.SDFAjelluAntiTorpedoDefense

XSS0203 = Class(SSubUnit) {
    DeathThreadDestructionWaitTime = 0,
    Weapons = {
        Torpedo01 = Class(SANUallCavitationTorpedo) {},
		Torpedo02 = Class(SANUallCavitationTorpedo) {},
        Cannon = Class(SDFOhCannon) {},
		Cannon02 = Class(SDFOhCannon) {},
        AntiTorpedo = Class(SDFAjelluAntiTorpedoDefense) {},
    },

    OnCreate = function(self)
		SSubUnit.OnCreate(self)
			self:HideBone('Turret01', true)  

    end,

}
TypeClass = XSS0203