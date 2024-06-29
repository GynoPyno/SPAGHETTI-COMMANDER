--[[#######################################################################
#  File	 :  /units/XSSE0001/XSSE0001_script.lua
#  Author(s):  GPG Devs
#  Summary  :  Seraphim Frigate Script: XSS0103 / XSO1104
#  -----------------------------
#  Modif.by :  AsdrubaelVect
#  Rev.Date :  5 septembre 2009
#  -----------------------------
#  Revis.by :  Manimal
#  Rev.Date :  20 novembre 2009
#  -----------------------------
#  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#######################################################################]]--

local SAirUnit = import('/lua/seraphimunits.lua').SAirUnit
local SAAShleoCannonWeapon = import('/lua/seraphimweapons.lua').SAAShleoCannonWeapon
local SDFUltraChromaticBeamGenerator = import( '/mods/XtremWars/hook/lua/seraphweapons.lua' ).SDFUltraChromaticBeamGenerator

XSSE0001 = Class(SAirUnit) {
    Weapons = {
        MainGun = Class(SDFUltraChromaticBeamGenerator) {},
        AAGun = Class(SAAShleoCannonWeapon) {},
    },
}

TypeClass = XSSE0001
