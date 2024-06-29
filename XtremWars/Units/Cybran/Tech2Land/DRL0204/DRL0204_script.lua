#****************************************************************************
#**
#**  File     :  /cdimage/units/DRL0204/DRL0204_script.lua
#**  Author(s):  Dru Staltman, Eric Williamson, Gordon Duclos
#**
#**  Summary  :  Cybran Rocket Bot Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit
local CAANanoDartWeapon = import('/lua/cybranweapons.lua').CAANanoDartWeapon

DRL0204 = Class(CWalkingLandUnit){
    Weapons = {
        RocketBackpack = Class(import('/lua/cybranweapons.lua').CDFRocketIridiumWeapon02) {},
		RocketBackpackupgrade = Class(import('/lua/cybranweapons.lua').CDFRocketIridiumWeapon02) {},
		AAGun01 = Class(CAANanoDartWeapon) {},
    },
	
    OnCreate = function(self)
		CWalkingLandUnit.OnCreate(self)

    end,

}
TypeClass = DRL0204
