#****************************************************************************
#**
#**  File     :  /cdimage/units/URL0202/URL0202_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Cybran Heavy Tank Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CLandUnit = import('/lua/cybranunits.lua').CLandUnit
local CDFParticleCannonWeapon = import('/lua/cybranweapons.lua').CDFParticleCannonWeapon
local CDFLaserHeavyWeapon = import('/lua/cybranweapons.lua').CDFLaserHeavyWeapon
local CAANanoDartWeapon = import('/lua/cybranweapons.lua').CAANanoDartWeapon

URL0202 = Class(CLandUnit) {
    Weapons = {
        MainGun = Class(CDFParticleCannonWeapon) {},
		LaserArms01 = Class(CDFLaserHeavyWeapon) {},
		LaserArms02 = Class(CDFLaserHeavyWeapon) {},
		AAGun01 = Class(CAANanoDartWeapon) {},
    },
	
    OnCreate = function(self)
		CLandUnit.OnCreate(self)

    end,
	
}

TypeClass = URL0202