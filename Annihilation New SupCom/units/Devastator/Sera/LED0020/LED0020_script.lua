#****************************************************************************
#**
#**  File     :  /data/units/XSL0305/XSL0305_script.lua
#**
#**  Summary  :  Seraphim Sniper Bot Script
#**
#**  Copyright � 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local SHoverLandUnit = import('/lua/seraphimunits.lua').SHoverLandUnit
local SeraphimWeapons = import('/lua/seraphimweapons.lua')
local SDFSihEnergyRifleSniperMode = SeraphimWeapons.SDFSniperShotSniperMode
local SDFUltraChromaticBeamGenerator = import('/lua/seraphimweapons.lua').SDFUltraChromaticBeamGenerator


LED0020 = Class(SHoverLandUnit) {
    Weapons = {
        SniperGun = Class(SDFSihEnergyRifleSniperMode) {},
		###UPGRADE02
		SniperGun02 = Class(SDFSihEnergyRifleSniperMode) {},
		###UPGRADE03
		LaserGun = Class(SDFUltraChromaticBeamGenerator) {},
    },

	OnCreate = function(self)
		SHoverLandUnit.OnCreate(self)
		self.Effect1 = CreateAttachedEmitter(self,'Upgrade04_01',self:GetArmy(), '/effects/emitters/seraphim_being_built_ambient_02_emit.bp')
		self.Trash:Add(self.Effecct1)
    end,
	

}

TypeClass = LED0020