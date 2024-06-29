#****************************************************************************
#**
#**  File     :  /cdimage/units/UEB2101/UEB2101_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Terran Light Gun Tower Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local TDFLightPlasmaCannonWeapon = import('/lua/terranweapons.lua').TDFLightPlasmaCannonWeapon


UEB2101 = Class(TLandUnit) {
    Weapons = {
		UpgradeGun02 = Class(TDFLightPlasmaCannonWeapon) {},
    },
	
    OnCreate = function(self)
		TLandUnit.OnCreate(self)
		self:HideBone('Turret_Barrel', true) 
		self:HideBone('Turret', true) 
		
    end,

}

TypeClass = UEB2101