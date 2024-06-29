#****************************************************************************
#**
#**  File     :  /units/URL0206/URL0206_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix And Asdrubaelvect
#**
#**  Summary  :  Cybran Ambphibious Heavy Tank Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local CLandUnit = import('/lua/cybranunits.lua').CLandUnit
local CybranWeaponsFile = import('/lua/cybranweapons.lua')
local CDFElectronBolterWeapon = CybranWeaponsFile.CDFElectronBolterWeapon
local CAANanoDartWeapon = CybranWeaponsFile.CAANanoDartWeapon

URL0206 = Class(CLandUnit) {

    Weapons = {
        Bolter = Class(CDFElectronBolterWeapon) {},
		Bolter02 = Class(CDFElectronBolterWeapon) {},
		UpgradeGun01 = Class(CDFElectronBolterWeapon) {},
		UpgradeGun02 = Class(CDFElectronBolterWeapon) {},
		UpgradeGun03 = Class(CAANanoDartWeapon) {},
		UpgradeGun04 = Class(CAANanoDartWeapon) {},
    },
	
    OnStopBeingBuilt = function(self,builder,layer)
		CLandUnit.OnStopBeingBuilt(self,builder,layer)		

	end,
	

}
TypeClass = URL0206