--[[#######################################################################
#  File	 :  /units/UAAEW0004/UAAEW0004_script.lua
#  Author(s):  John Comes, David Tomandl
#  Summary  :  Aeon Tech 2 Experimental Bomber
#  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#######################################################################]]--

local AAirUnit = import('/lua/aeonunits.lua' ).AAirUnit

local AIFBombQuarkWeapon = import( '/lua/aeonweapons.lua' ).AIFBombQuarkWeapon


UAAEW0004 = Class( AAirUnit ) {
    Weapons = {
        Bomb = Class( AIFBombQuarkWeapon ) {},
    },
}

TypeClass = UAAEW0004
