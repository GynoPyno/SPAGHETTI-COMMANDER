--[[#######################################################################
#  File     :  /units/UEA0105/UEA0105_script.lua
#  Author(s):  John Comes, David Tomandl, Gordon Duclos
#  Summary  :  Terran Carpet Bomber Unit Script UEA0103
#  -----------------------------
#  Modif.by :  AsdrubaelVect
#  Rev.Date :  5 septembre 2009
#  -----------------------------
#  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#######################################################################]]--

local TAirUnit = import('/lua/terranunits.lua').TAirUnit
local TIFCarpetBombWeapon = import('/Mods/XtremWars/hook/lua/terranweapons.lua').TIFCarpetBombNextWarsWeapon

UEA0105 = Class(TAirUnit) {
    Weapons = {
        Bomb = Class(TIFCarpetBombWeapon) {},
		Bomb2 = Class(TIFCarpetBombWeapon) {},
    },
    
}

TypeClass = UEA0105
