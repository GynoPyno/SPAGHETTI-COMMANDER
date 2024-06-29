#****************************************************************************
#**
#**  File     :  /units/uas0204/uas0204_script.lua
#**  Author(s):  John Comes, Jessica St. Croix
#**
#**  Summary  :  Aeon Light Attack Sub Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local ASubUnit = import('/lua/aeonunits.lua').ASubUnit
local AANChronoTorpedoWeapon = import('/lua/aeonweapons.lua').AANChronoTorpedoWeapon
local AIFQuasarAntiTorpedoWeapon = import('/lua/aeonweapons.lua').AIFQuasarAntiTorpedoWeapon
local AAAZealotMissileWeapon = import('/lua/aeonweapons.lua').AAAZealotMissileWeapon

UAS0204 = Class( ASubUnit ) {
    DeathThreadDestructionWaitTime = 0,
    Weapons = {
        Torpedo01 = Class(AANChronoTorpedoWeapon) {},
		Torpedo02 = Class(AANChronoTorpedoWeapon) {},
		AntiTorpedo01 = Class(AIFQuasarAntiTorpedoWeapon) {},
		AntiAirMissiles = Class(AAAZealotMissileWeapon) {},
    },
	
    OnCreate = function(self)
		ASubUnit.OnCreate(self)

    end,	
}

TypeClass = UAS0204
