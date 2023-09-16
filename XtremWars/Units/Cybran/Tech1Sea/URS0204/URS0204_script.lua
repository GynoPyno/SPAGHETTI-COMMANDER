#****************************************************************************
#**
#**  File     :  /units/URS0204/URS0204_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Cybran Attack Sub Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CSubUnit = import('/lua/cybranunits.lua').CSubUnit
local CANNaniteTorpedoWeapon = import('/lua/cybranweapons.lua').CANNaniteTorpedoWeapon

URS0204 = Class(CSubUnit) {
    DeathThreadDestructionWaitTime = 0,
    
    Weapons = {
        Torpedo01 = Class(CANNaniteTorpedoWeapon) {},
		####UPGRADE 03 Torp EMP
		TorpedoEMP01 = Class(CANNaniteTorpedoWeapon) {},
    },
    OnCreate = function(self)
		CSubUnit.OnCreate(self)

    end,

	
}

TypeClass = URS0204