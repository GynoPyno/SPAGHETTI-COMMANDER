#****************************************************************************
#**
#**  File     :  /cdimage/units/UEL0202/UEL0202_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  UEF Heavy Tank Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local TDFMachineGunWeapon = import('/lua/terranweapons.lua').TDFMachineGunWeapon

UEL0202 = Class(TLandUnit) {
    Weapons = {
        FrontTurret01 = Class(TDFMachineGunWeapon) {
        }
    },

    OnStopBeingBuilt = function(self, builder, layer)
        TLandUnit.OnStopBeingBuilt(self, builder, layer)
        self:SetMaintenanceConsumptionActive()
    end,
    
}

TypeClass = UEL0202