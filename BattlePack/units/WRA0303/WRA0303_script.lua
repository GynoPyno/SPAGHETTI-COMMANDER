#****************************************************************************
#**
#**  File     :  /cdimage/units/XRA0305/XRA0305_script.lua
#**  Author(s):  Drew Staltman, Jessica St. Croix, Gordon Duclos
#**
#**  Summary  :  Cybran Heavy Gunship Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local CAirUnit = import('/lua/cybranunits.lua').CAirUnit
local CDFRocketIridiumWeapon = import('/lua/cybranweapons.lua').CDFRocketIridiumWeapon
local CDFLaserDisintegratorWeapon = import('/lua/cybranweapons.lua').CDFLaserDisintegratorWeapon02

WRA0303 = Class(CAirUnit) {
    
    Weapons = {
        Missile01 = Class(CDFRocketIridiumWeapon) {},
        Disintegrator01 = Class(CDFLaserDisintegratorWeapon) {},
    },
    
}
TypeClass = WRA0303