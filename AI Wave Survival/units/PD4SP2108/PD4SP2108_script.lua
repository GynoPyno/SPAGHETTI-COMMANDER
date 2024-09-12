#****************************************************************************
#**
#**  File     :  /cdimage/units/UAB2108/UAB2108_script.lua
#**  Author(s):  Greg Kohne, Aaron Lundquist
#**
#**  Summary  :  Seraphim Tactical Missile Launcher Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local SStructureUnit = import('/lua/seraphimunits.lua').SStructureUnit
local SLaanseMissileWeapon = import('/lua/seraphimweapons.lua').SLaanseMissileWeapon
local SLaanseMissileWeapon2 = import('/lua/seraphimweapons.lua').SLaanseMissileWeapon

PD4SP2108 = Class(SStructureUnit) {
    Weapons = {
        CruiseMissile = Class(SLaanseMissileWeapon) {},
		Missile = Class(SLaanseMissileWeapon2) {},
    },
	
	DeathThread = function(self)
		local position = self:GetPosition()
		local spiritUnit = CreateUnitHPR('SPIRIT0402', self:GetArmy(), position[1], position[2], position[3], 0, 0, 0)
		local spiritUnit = CreateUnitHPR('SPIRIT0402', self:GetArmy(), position[1], position[2], position[3], 0, 0, 0)
		self:Destroy()
	end,
}
TypeClass = PD4SP2108
