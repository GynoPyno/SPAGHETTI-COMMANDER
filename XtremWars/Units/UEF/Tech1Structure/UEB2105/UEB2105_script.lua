#****************************************************************************
#**
#**  File     :  /units/UEB2105/UEB2105_script.lua
#**  Author(s):  John Comes, David Tomandl
#**
#**  Summary  :  Terran Anti-Air Gun Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local TAirUnit = import('/lua/terranunits.lua').TAirUnit
local TAALinkedRailgun = import('/lua/terranweapons.lua').TAALinkedRailgun


UEB2105 = Class(TAirUnit) {
    Weapons = {
        AAGun = Class(TAALinkedRailgun) {},
    },
	

	OnStopBeingBuilt = function(self,builder,layer)
		TAirUnit.OnStopBeingBuilt(self,builder,layer)
        self.Trash:Add(CreateRotator(self, 'Helice', 'y', nil, 100, 0, 50))
	end,	
	
}

TypeClass = UEB2105
