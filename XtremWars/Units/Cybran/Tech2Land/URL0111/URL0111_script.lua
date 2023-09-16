#****************************************************************************
#**
#**  File     :  /cdimage/units/URL0111/URL0111_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Cybran Mobile Missile Launcher Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CLandUnit = import('/lua/cybranunits.lua').CLandUnit
local CIFMissileLoaWeapon = import('/lua/cybranweapons.lua').CIFMissileLoaWeapon
local CAANanoDartWeapon = import('/lua/cybranweapons.lua').CAANanoDartWeapon

URL0111 = Class(CLandUnit) {
    Weapons = {
        MissileRack = Class(CIFMissileLoaWeapon) {},
		MissileRack01 = Class(CIFMissileLoaWeapon) {},
		MissileRack02 = Class(CIFMissileLoaWeapon) {},
		AAGun01 = Class(CAANanoDartWeapon) {},
    },
	
    OnCreate = function(self)
		CLandUnit.OnCreate(self)

    end,

		
}

TypeClass = URL0111
