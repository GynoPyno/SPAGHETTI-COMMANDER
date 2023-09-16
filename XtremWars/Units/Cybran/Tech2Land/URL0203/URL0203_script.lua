#****************************************************************************
#**
#**  File     :  /cdimage/units/URL0203/URL0203_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Cybran Ambphibious Tank Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local CLandUnit = import('/lua/cybranunits.lua').CLandUnit
local CybranWeaponsFile = import('/lua/cybranweapons.lua')
local CDFElectronBolterWeapon = CybranWeaponsFile.CDFElectronBolterWeapon
local CDFMissileMesonWeapon = CybranWeaponsFile.CDFMissileMesonWeapon
local CANTorpedoLauncherWeapon = CybranWeaponsFile.CANTorpedoLauncherWeapon
local CAANanoDartWeapon = import('/lua/cybranweapons.lua').CAANanoDartWeapon

URL0203 = Class(CLandUnit) {

    Weapons = {
        Bolter = Class(CDFElectronBolterWeapon) {},
        Rocket = Class(CDFMissileMesonWeapon) {},
        Torpedo = Class(CANTorpedoLauncherWeapon) {},
		####UPGRADE02
		Torpedo01 = Class(CANTorpedoLauncherWeapon) {},
		Bolter01 = Class(CDFElectronBolterWeapon) {},
		################ UPGRADE04
		AAGun01 = Class(CAANanoDartWeapon) {},
    },
    OnCreate = function(self)
		CLandUnit.OnCreate(self)

    end,
}
TypeClass = URL0203