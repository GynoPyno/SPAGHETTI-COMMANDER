#****************************************************************************
#**
#**  File     :  /cdimage/units/UEA0302/UEA0302_script.lua
#**  Author(s):  Jessica St. Croix, David Tomandl
#**
#**  Summary  :  UEF Spy Plane Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TAirUnit = import('/lua/terranunits.lua').TAirUnit
local TIFCarpetBombWeapon = import('/lua/terranweapons.lua').TIFCarpetBombWeapon
local WeaponsFile = import('/lua/terranweapons.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TWeapons = import('/lua/terranweapons.lua')
local TIFCommanderDeathWeapon = import('/lua/sim/defaultweapons.lua').DeathNukeWeapon

UEA0302 = Class(TAirUnit) {
    Weapons = {
        Bomb = Class(TIFCarpetBombWeapon) {      
        },
	},

    BeamExhaustIdle = '/mods/#Marlos mods compilation/effects/emitters/gunship_thruster_beam_04_emit.bp',
	BeamExhaustCruise = '/mods/#Marlos mods compilation/effects/emitters/gunship_thruster_beam_04_emit.bp',
	
}

TypeClass = UEA0302