#****************************************************************************
#**
#**  File     :  /units/UEB2106/UEB2106_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Terran Air Light Gun Tower Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TAirUnit = import('/lua/terranunits.lua').TAirUnit
local TDFLightPlasmaCannonWeapon = import('/lua/terranweapons.lua').TDFLightPlasmaCannonWeapon


UEB2106 = Class(TAirUnit) {
    Weapons = {
		UpgradeGun02 = Class(TDFLightPlasmaCannonWeapon) {},
    },
	
    OnCreate = function(self)
		TAirUnit.OnCreate(self)
		self:HideBone('Turret_Barrel', true)
		self:HideBone('Turret', true) 
    end,
	
    OnStopBeingBuilt = function(self, builder, layer)
        TAirUnit.OnStopBeingBuilt(self,builder,layer)
		    self.Trash:Add(CreateRotator(self, 'Helice', 'y', nil, 100, 0, 50))
    end,
	

}

TypeClass = UEB2106