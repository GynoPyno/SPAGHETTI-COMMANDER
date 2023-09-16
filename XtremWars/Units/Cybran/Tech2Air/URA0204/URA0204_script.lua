#****************************************************************************
#**
#**  File     :  /cdimage/units/URA0204/URA0204_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix, Gordon Duclos
#**
#**  Summary  :  Cybran Torpedo Bomber Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local CAirUnit = import('/lua/cybranunits.lua').CAirUnit
local CIFNaniteTorpedoWeapon = import('/lua/cybranweapons.lua').CIFNaniteTorpedoWeapon
local CAAAutocannon = import('/lua/cybranweapons.lua').CAAAutocannon

URA0204 = Class(CAirUnit) {
    Weapons = {
        Bomb = Class(CIFNaniteTorpedoWeapon) {},
		Bomb2 = Class(CIFNaniteTorpedoWeapon) {},
		BackGun01 = Class(CAAAutocannon) {},
    },

    OnCreate = function(self)
        CAirUnit.OnCreate(self)

    end,		
	
}

TypeClass = URA0204