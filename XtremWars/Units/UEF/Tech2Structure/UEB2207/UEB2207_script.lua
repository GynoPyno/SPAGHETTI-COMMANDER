#****************************************************************************
#**
#**  File     :  /cdimage/units/UEB2204/UEB2204_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  UEF Flak Cannon Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TAirUnit = import('/lua/terranunits.lua').TAirUnit
local TAAFlakArtilleryCannon = import('/lua/terranweapons.lua').TAAFlakArtilleryCannon

UEB2207 = Class(TAirUnit) {
    Weapons = {
        AAGun = Class(TAAFlakArtilleryCannon) {},   
    },
	
    OnStopBeingBuilt = function(self, builder, layer)
        TAirUnit.OnStopBeingBuilt(self,builder,layer)
		   self.Trash:Add(CreateRotator(self, 'Helice01', 'y', nil, 180, 0, 150))
		   self.Trash:Add(CreateRotator(self, 'Helice02', 'y', nil, -180, 0, 150))
			self:SetSpeedMult(0)
			self:SetTurnMult(0)
	end,			
	
}

TypeClass = UEB2207