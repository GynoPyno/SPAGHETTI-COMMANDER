#****************************************************************************
#**
#**  File     :  /cdimage/units/UAL0111/UAL0111_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Aeon Mobile Missile Launcher Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local ALandUnit = import('/lua/aeonunits.lua').ALandUnit
local AIFMissileTacticalSerpentineWeapon = import('/lua/aeonweapons.lua').AIFMissileTacticalSerpentineWeapon

UAL0111 = Class( ALandUnit ) {
    Weapons = {
        MissileRack = Class(AIFMissileTacticalSerpentineWeapon) {},
		MissileRack01 = Class(AIFMissileTacticalSerpentineWeapon) {},
		MissileRack02 = Class(AIFMissileTacticalSerpentineWeapon) {},
    },
	
    OnCreate = function(self)
		ALandUnit.OnCreate(self)

    end,

}

TypeClass = UAL0111
