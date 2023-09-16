--[[#######################################################################
#  File     :  /units/UEA0111/UEA0111_script.lua
#  Author(s):  John Comes, David Tomandl, Gordon Duclos
#  Summary  :  Terran Carpet Bomber Unit Script UEA0103
#  -----------------------------
#  Modif.by :  AsdrubaelVect
#  Rev.Date :  5 septembre 2009
#  -----------------------------
#  Revis.by :  Manimal
#  Rev.Date :  20 novembre 2009
#  -----------------------------
#  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#######################################################################]]--
local TAirUnit = import('/lua/terranunits.lua').TAirUnit
local TWeapons = import('/lua/terranweapons.lua')
local TDFHeavyPlasmaCannonWeapon = TWeapons.TDFHeavyPlasmaCannonWeapon


UEA0111 = Class(TAirUnit) {
    Weapons = {
        Plasma01 = Class(TDFHeavyPlasmaCannonWeapon) {},
        Plasma02 = Class(TDFHeavyPlasmaCannonWeapon) {},
    },
    
}

TypeClass = UEA0111
