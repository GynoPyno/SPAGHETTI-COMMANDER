--[[#######################################################################
#  File     :  /units/XSS0204/XSS0204_script.lua
#  Author(s):  GPG Devs
#  Summary  :  Seraphim Attack Sub Script XSS0203
#  -----------------------------
#  Modif.by :  AsdrubaelVect
#  Rev.Date :  5 septembre 2009
#  -----------------------------
#  Revis.by :  Manimal
#  Rev.Date :  20 novembre 2009
#  -----------------------------
#  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#######################################################################]]--
local SSubUnit = import('/lua/seraphimunits.lua').SSubUnit
local SWeapons = import('/lua/seraphimweapons.lua')
local SANUallCavitationTorpedo = SWeapons.SANUallCavitationTorpedo

XSS0204 = Class(SSubUnit) {
    DeathThreadDestructionWaitTime = 0,
    Weapons = {
        Torpedo01 = Class(SANUallCavitationTorpedo) {},
		Torpedo02 = Class(SANUallCavitationTorpedo) {},
    },

    OnCreate = function(self)
		SSubUnit.OnCreate(self)

    end,
	
	
}

TypeClass = XSS0204
