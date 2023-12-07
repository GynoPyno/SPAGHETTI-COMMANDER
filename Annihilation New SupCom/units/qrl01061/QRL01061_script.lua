#****************************************************************************
#**
#**  File     :  /cdimage/units/URL0106/URL0106_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Cybran Rocket Bot Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit
local CDFRocketWeapon = import('/lua/cybranweapons.lua').CDFRocketIridiumWeapon02
local CDFLaserPulseLightWeapon = import('/lua/cybranweapons.lua').CDFLaserPulseLightWeapon

QRL0106 = Class(CWalkingLandUnit) {
    Weapons = {
        MainGun = Class(CDFRocketWeapon) {},
    },
}

TypeClass = QRL0106