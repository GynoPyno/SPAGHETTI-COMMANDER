#****************************************************************************
#**
#**  File     :  /cdimage/units/URS0203/URS0203_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Cybran Attack Sub Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CSubUnit = import('/lua/cybranunits.lua').CSubUnit
local CANNaniteTorpedoWeapon = import('/lua/cybranweapons.lua').CANNaniteTorpedoWeapon
local CDFLaserHeavyWeapon = import('/lua/cybranweapons.lua').CDFLaserHeavyWeapon

URS0203 = Class(CSubUnit) {
    DeathThreadDestructionWaitTime = 0,
    
    Weapons = {
        MainGun = Class(CDFLaserHeavyWeapon) {},
		MainGun02 = Class(CDFLaserHeavyWeapon) {},
        Torpedo01 = Class(CANNaniteTorpedoWeapon) {},
		Torpedo02 = Class(CANNaniteTorpedoWeapon) {},
    },

    OnCreate = function(self,builder,layer)
        CSubUnit.OnCreate(self,builder,layer)

    end,		

}

TypeClass = URS0203