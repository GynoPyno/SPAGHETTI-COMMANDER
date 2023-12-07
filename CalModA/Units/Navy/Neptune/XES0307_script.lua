----------------------------------------------------------------------------
--
--  File     :  /cdimage/units/UES0307/UES0307_script.lua
--  Author(s):  Drew Staltman, Gordon Duclos, Greg Kohne
--
--  Summary  :  UEF Battleship Script
--
--  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
----------------------------------------------------------------------------
local TSeaUnit = import('/lua/terranunits.lua').TSeaUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local TAMPhalanxWeapon = import('/lua/terranweapons.lua').TAMPhalanxWeapon
local TDFHeavyPlasmaCannonWeapon = import('/lua/terranweapons.lua').TDFHeavyPlasmaCannonWeapon
local TANTorpedoAngler = WeaponsFile.TANTorpedoAngler
local TIFSmartCharge = WeaponsFile.TIFSmartCharge

UES0302 = Class(TSeaUnit) {
    Weapons = {
        FrontTurret = Class(TDFHeavyPlasmaCannonWeapon) {},
        BackTurret = Class(TDFHeavyPlasmaCannonWeapon) {},
        AntiTorpedo = Class(TIFSmartCharge) {},
        Torp = Class(TANTorpedoAngler) {},
        PhalanxGun = Class(TAMPhalanxWeapon) {},
    },

    OnStopBeingBuilt = function(self,builder,layer)
        TSeaUnit.OnStopBeingBuilt(self,builder,layer)
        self:SetMaintenanceConsumptionActive()
    end,
}

TypeClass = UES0302