#****************************************************************************
#**
#**  File     :  /cdimage/units/DEL0204/DEL0204_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix, Matt Vainio
#**
#**  Summary  :  UEF Mongoose Gatling Bot
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TStructureUnit = import('/lua/terranunits.lua').TStructureUnit
local TWeapons = import('/lua/terranweapons.lua')
local TIFFragLauncherWeapon = TWeapons.TDFFragmentationGrenadeLauncherWeapon

local EffectUtils = import('/lua/effectutilities.lua')
local Effects = import('/lua/effecttemplates.lua')

DEL0204 = Class(TStructureUnit) 
{
    Weapons = {
	
        Grenade = Class(TIFFragLauncherWeapon) {}
	
    },
}

TypeClass = DEL0204