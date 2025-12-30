#****************************************************************************
#**
#**  File     :  /cdimage/units/UAB4302/UAB4302_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Aeon Strategic Missile Defense Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local AStructureUnit = import('/lua/aeonunits.lua').AStructureUnit
local AAASonicPulseBatteryWeapon = import('/lua/aeonweapons.lua').AAASonicPulseBatteryWeapon

WAB2303 = Class(AStructureUnit) {

    Weapons = {
        MissileRack = Class(AAASonicPulseBatteryWeapon) {},
    },
	
	OnStopBeingBuilt = function(self,builder,layer)
        AStructureUnit.OnStopBeingBuilt(self,builder,layer)
        self.Trash:Add(CreateRotator(self, 'Sera_Stone', 'y', nil, -15))
    end,
	
}

TypeClass = WAB2303