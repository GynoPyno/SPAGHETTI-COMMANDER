#****************************************************************************
#**
#**  File     :  /Mods/Expewars/units/URB2306/URB2306_script.lua
#**  Author(s):  Dru Staltman, Gordon Duclos
#**
#**  Summary  :  Cybran t3 Obelisc Defense tower
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CStructureUnit = import('/lua/cybranunits.lua').CStructureUnit
local CybranWeaponsFile = import( '/Mods/XtremWars/hook/lua/cybranweapons.lua')
local CDFHeavyMicrowaveLaserGeneratorDefense = CybranWeaponsFile.CDFHeavyMicrowaveLaserGeneratorDefense

URB2306 = Class(CStructureUnit) 
{
	Weapons = {
        MLG = Class(CDFHeavyMicrowaveLaserGeneratorDefense) {
        },
    },
}
TypeClass = URB2306