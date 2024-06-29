#****************************************************************************
#**
#**  File     :  /cdimage/units/UES0201/UES0201_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Terran Destroyer Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TSeaUnit = import('/lua/terranunits.lua').TSeaUnit
local WeaponFile = import('/lua/terranweapons.lua')
local TAALinkedRailgun = WeaponFile.TAALinkedRailgun
local TDFGaussCannonWeapon = WeaponFile.TDFGaussCannonWeapon
local TANTorpedoAngler = WeaponFile.TANTorpedoAngler
local TIFSmartCharge = WeaponFile.TIFSmartCharge

UES0201 = Class(TSeaUnit) {
    DestructionTicks = 200,

    Weapons = {
        FrontTurret01 = Class(TDFGaussCannonWeapon) {},
        BackTurret01 = Class(TDFGaussCannonWeapon) {},
		BackTurret02 = Class(TAALinkedRailgun) {},
        Torpedo01 = Class(TANTorpedoAngler) {},
        AntiTorpedo = Class(TIFSmartCharge) {},
		### UPGRADE CANNONS GRADE 02
		GaussUgradeTurret01 = Class(TDFGaussCannonWeapon) {},
		### UPGRADE ANTI AIR GRADE 02
		AAUpgradeTurret01 = Class(TAALinkedRailgun) {},
		AAUpgradeTurret02 = Class(TAALinkedRailgun) {},
		AAUpgradeTurret03 = Class(TAALinkedRailgun) {},
		### UPGRADE CANNONS GRADE 04
		GaussUgradeTurret02 = Class(TDFGaussCannonWeapon) {},
		GaussUgradeTurret03 = Class(TDFGaussCannonWeapon) {},
		GaussUgradeTurret04 = Class(TDFGaussCannonWeapon) {},
		GaussUgradeTurret05 = Class(TDFGaussCannonWeapon) {},
    },

    RadarThread = function(self)
        local spinner = CreateRotator(self, 'Spinner02', 'x', nil, 0, 90, -90)
        self.Trash:Add(spinner)
        while true do
            WaitFor(spinner)
            spinner:SetTargetSpeed(90)
            WaitFor(spinner)
            spinner:SetTargetSpeed(-90)
        end
    end,
	
    OnCreate = function(self)
		TSeaUnit.OnCreate(self)
		self:HideBone('Origine02', true)
		self:HideBone('Origine01', true)
		
    end,	
	


    OnStopBeingBuilt = function(self,builder,layer)
        TSeaUnit.OnStopBeingBuilt(self,builder,layer)
        self.Trash:Add(CreateRotator(self, 'Spinner01', 'y', nil, 180, 0, 180))
        self:ForkThread(self.RadarThread)
    end,
	


}

TypeClass = UES0201