#****************************************************************************
#**
#**  File     :  /cdimage/units/UEL0202/UEL0202_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  UEF Heavy Tank Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CLandUnit = import('/lua/terranunits.lua').TLandUnit
local CDFGaussCannonWeapon = import('/lua/terranweapons.lua').TDFGaussCannonWeapon
local CDFRiotWeapon = import('/lua/terranweapons.lua').TDFRiotWeapon
local CConstructionUnit = import('/lua/terranunits.lua').TConstructionUnit

local cWeapons = import('/lua/cybranweapons.lua')
local CDFLaserDisintegratorWeapon = cWeapons.CDFLaserDisintegratorWeapon01
local CDFElectronBolterWeapon = cWeapons.CDFElectronBolterWeapon
local CANNaniteTorpedoWeapon = import('/lua/cybranweapons.lua').CANNaniteTorpedoWeapon

MK60 = Class(CConstructionUnit) {
    Weapons = {
        Disintigrator = Class(CDFLaserDisintegratorWeapon) {},
        HeavyBolter = Class(CDFElectronBolterWeapon) {},
        Turret01 = Class(CANNaniteTorpedoWeapon) {},
    },
}

TypeClass = MK60