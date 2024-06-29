#****************************************************************************
#**
#**  File     :  /cdimage/units/URL0104/URL0104_script.lua
#**  Author(s):  John Comes, David Tomandl
#**
#**  Summary  :  Cybran Anti-Air Tank Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local CLandUnit = import('/lua/cybranunits.lua').CLandUnit
local CybranWeaponsFile = import('/lua/cybranweapons.lua')
local CAANanoDartWeapon = CybranWeaponsFile.CAANanoDartWeapon

URL0104 = Class(CLandUnit) {
    Weapons = {
        AAGun = Class(CAANanoDartWeapon) {},
		UpgradeGun = Class(CAANanoDartWeapon) {},
		UpgradeGun01 = Class(CAANanoDartWeapon) {},
		UpgradeGun02 = Class(CAANanoDartWeapon) {},
		UpgradeGun03 = Class(CAANanoDartWeapon) {},
		UpgradeGun04 = Class(CAANanoDartWeapon) {},
    },
    
    OnCreate = function(self)
        CLandUnit.OnCreate(self)

    end,
	
}
TypeClass = URL0104

