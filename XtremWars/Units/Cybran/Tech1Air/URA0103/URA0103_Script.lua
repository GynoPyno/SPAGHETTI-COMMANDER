#****************************************************************************
#**
#**  File     :  /cdimage/units/URA0103/URA0103_script.lua
#**  Author(s):  John Comes, David Tomandl
#**
#**  Summary  :  Cybran Bomber Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local CAirUnit = import('/lua/cybranunits.lua').CAirUnit

local CIFBombNeutronWeapon = import('/lua/cybranweapons.lua').CIFBombNeutronWeapon
local CAAAutocannon = import('/lua/cybranweapons.lua').CAAAutocannon

URA0103 = Class(CAirUnit) {
    Weapons = {
        Bomb = Class(CIFBombNeutronWeapon) {},
		Bomb02 = Class(CIFBombNeutronWeapon) {},
		BackGun01 = Class(CAAAutocannon) {},
		BackGun02 = Class(CAAAutocannon) {},
        },
		
    ExhaustBones = {'Exhaust_L','Exhaust_R',},
    ContrailBones = {'Contrail_L','Contrail_R',},
	
    OnCreate = function(self)
		CAirUnit.OnCreate(self)
			self:HideBone('Origine01_01', true)
			self:HideBone('Origine02_01', true)
			
    end,				
}

TypeClass = URA0103