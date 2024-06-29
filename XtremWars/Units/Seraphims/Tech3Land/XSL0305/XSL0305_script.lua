#****************************************************************************
#**
#**  File     :  /data/units/XSL0305/XSL0305_script.lua
#**
#**  Summary  :  Seraphim Sniper Bot Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local SLandUnit = import( '/lua/seraphimunits.lua').SLandUnit
local SeraphimWeapons = import('/lua/seraphimweapons.lua')
local SDFSihEnergyRifleSniperMode = SeraphimWeapons.SDFSniperShotSniperMode
local SDFUltraChromaticBeamGenerator = import('/lua/seraphimweapons.lua').SDFUltraChromaticBeamGenerator

XSL0305 = Class(SLandUnit) {
    Weapons = {
        SniperGun = Class(SDFSihEnergyRifleSniperMode) {},
		###UPGRADE02
		SniperGun02 = Class(SDFSihEnergyRifleSniperMode) {},
		###UPGRADE03
		LaserGun = Class(SDFUltraChromaticBeamGenerator) {},
    },

	OnCreate = function(self)
		SLandUnit.OnCreate(self)

    end,
	

}

TypeClass = XSL0305