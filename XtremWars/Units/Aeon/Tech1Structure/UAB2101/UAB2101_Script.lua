#****************************************************************************
#**
#**  File     :  /cdimage/units/UAB2101/UAB2101_script.lua
#**  Author(s):  John Comes, David Tomandl
#**
#**  Summary  :  Aeon Light Laser Tower Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local AStructureUnit = import('/lua/aeonunits.lua').AStructureUnit
local ADFGravitonProjectorWeapon = import('/lua/aeonweapons.lua').ADFGravitonProjectorWeapon


UAB2101 = Class( AStructureUnit ) {
    Weapons = {
		UpgradeGun01 = Class(ADFGravitonProjectorWeapon) {},
    },
	
    OnCreate = function(self)
		AStructureUnit.OnCreate(self)
		self:HideBone('Turret_Barrel', true) 
    end,
		
}

TypeClass = UAB2101
