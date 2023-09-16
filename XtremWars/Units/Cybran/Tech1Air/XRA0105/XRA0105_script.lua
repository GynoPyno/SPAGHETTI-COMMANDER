#****************************************************************************
#**
#**  File     :  /cdimage/units/XRA0105/XRA0105_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Cybran Gunship Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local CAirUnit = import('/lua/cybranunits.lua').CAirUnit

local CDFLaserHeavyWeapon = import('/lua/cybranweapons.lua').CDFLaserHeavyWeapon02


XRA0105 = Class(CAirUnit) {
    Weapons = {
		MainGun = Class(CDFLaserHeavyWeapon) {	
		},
		UpGun01 = Class(CDFLaserHeavyWeapon) {	
		},
		UpGun02 = Class(CDFLaserHeavyWeapon) {	
		},
		BackGun01 = Class(CDFLaserHeavyWeapon) {	
		},
    },

    DestructionPartsChassisToss = {'XRA0105','Upgrade01',},
    DestructionPartsHighToss = {'Upgrade01',},

    OnCreate = function(self)
		CAirUnit.OnCreate(self)
		self:HideBone('Origine01_01', true)
    end,

}

TypeClass = XRA0105
