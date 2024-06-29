#****************************************************************************
#**
#**  File     :  /cdimage/units/UEB2301/UEB2301_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  UEF Heavy Gun Tower Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TAirUnit = import('/lua/terranunits.lua').TAirUnit
local TDFGaussCannonWeapon = import('/lua/terranweapons.lua').TDFGaussCannonWeapon

UEB2206 = Class(TAirUnit) {
    Weapons = {
        Gauss01 = Class(TDFGaussCannonWeapon) {},      
    },
	
    OnStopBeingBuilt = function(self, builder, layer)
        TAirUnit.OnStopBeingBuilt(self,builder,layer)
		    self.Trash:Add(CreateRotator(self, 'Helice01', 'y', nil, 180, 0, 150))
			self.Trash:Add(CreateRotator(self, 'Helice02', 'y', nil, -180, 0, 150))
			self:SetSpeedMult(0)
			self:SetTurnMult(0)
	end,			
	
}

TypeClass = UEB2206