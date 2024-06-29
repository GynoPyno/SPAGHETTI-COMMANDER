--[[#######################################################################
#  File     :  /units/URB4401/URB4401_script.lua
#  Author(s):  Dru Staltman, Ted Snook
#  Summary  :  Cybran Anti Nuke Experimental
#  -----------------------------
#  Modif.by :  AsdrubaelVect
#  Rev.Date :  5 septembre 2009
#  -----------------------------
#  Revis.by :  Manimal
#  Rev.Date :  20 novembre 2009
#  -----------------------------
#  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#######################################################################]]--

local CRadarUnit = import('/lua/cybranunits.lua').CRadarUnit
local CybranWeaponsFile = import( '/Mods/XtremWars/hook/lua/cybranweapons.lua' )
local CDFHeavyMicrowaveLaserGeneratorCom = CybranWeaponsFile.CDFHeavyMicrowaveLaserGeneratorCom

URB4401 = Class(CRadarUnit) {   
    Weapons = {
        MainGun = Class(CDFHeavyMicrowaveLaserGeneratorCom) {
            },
    },
}

TypeClass = URB4401
