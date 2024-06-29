--[[#######################################################################
#  File     :  /units/Usines/UAB2106/UAB2106_script.lua
#  Author(s):  John Comes, David Tomandl
#  Summary  :  Aeon Light Laser Tower Script
#  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#######################################################################]]--
local AAirUnit = import('/lua/aeonunits.lua').AAirUnit
local ADFGravitonProjectorWeapon = import('/lua/aeonweapons.lua').ADFGravitonProjectorWeapon

UAB2106 = Class(AAirUnit) {
    Weapons = {
		UpgradeGun01 = Class(ADFGravitonProjectorWeapon) {},
    },
	
    OnCreate = function(self)
		AAirUnit.OnCreate(self)
		self:HideBone('Turret_Barrel', true) 
    end,
	
}

TypeClass = UAB2106