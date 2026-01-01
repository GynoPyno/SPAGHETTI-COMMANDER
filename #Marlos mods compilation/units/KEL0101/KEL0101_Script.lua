#****************************************************************************
#**
#**  File     :  /cdimage/units/UEL0201/UEL0201_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  UEF Medium Tank Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local TDFGaussCannonWeapon = import('/lua/terranweapons.lua').TDFGaussCannonWeapon

UEL0201 = Class(TLandUnit) {
    Weapons = {
        MainGun = Class(TDFGaussCannonWeapon) {}
    },
	
    OnStartBuild = function(self, unitBeingBuilt, order)
        TLandUnit.OnStartBuild(self, unitBeingBuilt, order)
		self:HideBone(0, true)
    end,

    OnStopBuild = function(self, unitBuilding)
		if unitBuilding:GetFractionComplete() == 1 then
		self:Destroy()
		else
		self:HideBone(0, false)
		end
    end,

    OnFailedToBuild = function(self)
	self:HideBone(0, false)
    end,
	
}

TypeClass = UEL0201