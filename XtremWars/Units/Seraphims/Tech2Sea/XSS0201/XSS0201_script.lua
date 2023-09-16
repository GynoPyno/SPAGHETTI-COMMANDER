#****************************************************************************
#**
#**  File     :  /cdimage/units/XSS0201/XSS0201_script.lua
#**  Author(s):  Greg Kohne, Gordon Duclos, Aaron Lundquist
#**
#**  Summary  :  Seraphim Destroyer Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local SSubUnit = import('/lua/seraphimunits.lua').SSubUnit
local SeraphimWeapons = import('/lua/seraphimweapons.lua')
local SDFUltraChromaticBeamGenerator = SeraphimWeapons.SDFUltraChromaticBeamGenerator02
local SANAnaitTorpedo = SeraphimWeapons.SANAnaitTorpedo
local SDFAjelluAntiTorpedoDefense = SeraphimWeapons.SDFAjelluAntiTorpedoDefense

XSS0201 = Class(SSubUnit) {
    BackWakeEffect = {},
    Weapons = {
        FrontTurret01 = Class(SDFUltraChromaticBeamGenerator) {},
		FrontTurret02 = Class(SDFUltraChromaticBeamGenerator) {},
		BackTurret = Class(SDFUltraChromaticBeamGenerator) {},
        AntiTorpedo = Class(SDFAjelluAntiTorpedoDefense) {},
		Torpedo2 = Class(SANAnaitTorpedo) {},
		UpgradeTurret01 = Class(SDFUltraChromaticBeamGenerator) {}, 
		UpgradeTurret02 = Class(SDFUltraChromaticBeamGenerator) {}, 
    },

    OnCreate = function(self)
        SSubUnit.OnCreate(self)
		self:HideBone('Upgrade01_02', true)
	
    end,	

	OnStopBeingBuilt = function(self, builder, layer)
		IssueDive({self})
	end,  
	
    OnKilled = function(self, instigator, type, overkillRatio)       
        SSubUnit.OnKilled(self, instigator, type, overkillRatio)
    end,

}
TypeClass = XSS0201