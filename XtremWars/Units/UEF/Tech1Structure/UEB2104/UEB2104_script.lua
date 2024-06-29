#****************************************************************************
#**
#**  File     :  /cdimage/units/UEB2104/UEB2104_script.lua
#**  Author(s):  John Comes, David Tomandl
#**
#**  Summary  :  Terran Anti-Air Gun Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local TAALinkedRailgun = import('/lua/terranweapons.lua').TAALinkedRailgun

UEB2104 = Class(TLandUnit) {
    Weapons = {
		UpgradeGun01 = Class(TAALinkedRailgun) {},
    },
	
    OnCreate = function(self)
		TLandUnit.OnCreate(self)
		self:HideBone('Turret_Barrel', true)
    end,
	

	
}

TypeClass = UEB2104
