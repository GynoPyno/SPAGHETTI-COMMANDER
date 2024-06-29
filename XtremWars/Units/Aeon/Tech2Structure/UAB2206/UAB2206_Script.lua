--[[#######################################################################
#  File     :  /units/Usines/UAB2206/UAB2206_script.lua
#  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#  Summary  :  Aeon Heavy AA Gun Tower Script
#  -----------------------------
#  Modif.by :  Asdrubaelvect
#  Rev.Date :  jj mmmmm aaaa
#  -----------------------------
#  Revis.by :  Manimal
#  Rev.Date :  18 mars 2010 -- minor bug fixes
#  -----------------------------
#  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#######################################################################]]--

local AAirUnit = import( '/lua/aeonunits.lua' ).AAirUnit
local ADFCannonOblivionWeapon = import( '/lua/aeonweapons.lua' ).ADFCannonOblivionWeapon

UAB2206 = Class( AAirUnit ) {
    Weapons = {
        MainGun = Class( ADFCannonOblivionWeapon ) {
			FxMuzzleFlash = {
				'/effects/emitters/oblivion_cannon_flash_04_emit.bp',
				'/effects/emitters/oblivion_cannon_flash_05_emit.bp',				
				'/effects/emitters/oblivion_cannon_flash_06_emit.bp',
			},        
        }
    },
}

TypeClass = UAB2206
