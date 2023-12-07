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
local TDFMachineGunWeapon = import('/lua/terranweapons.lua').TDFMachineGunWeapon
local TANTorpedoAngler = WeaponFile.TANTorpedoAngler
local TIFSmartCharge = import('/lua/terranweapons.lua').TIFSmartCharge

UES0201 = Class(TSeaUnit) {
    DestructionTicks = 200,

    Weapons = {
        FrontTurret01 = Class(TDFMachineGunWeapon) {},
        BackTurret01 = Class(TDFMachineGunWeapon) {},
        FrontTurret02 = Class(TAALinkedRailgun) {},
        TorpedoRight = Class(TANTorpedoAngler) {},
        TorpedoLeft = Class(TANTorpedoAngler) {},
        AntiTorpedo = Class(TIFSmartCharge) {},
    },

    OnStopBeingBuilt = function(self,builder,layer)
        TSeaUnit.OnStopBeingBuilt(self,builder,layer)
        self.Trash:Add(CreateRotator(self, 'Spinner01', 'y', nil, 180, 0, 180))
        self:ForkThread(self.RadarThread)
        self:HideBone( 'Back_Turret02', true )
    end,
}

TypeClass = UES0201