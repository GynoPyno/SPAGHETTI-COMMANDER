#****************************************************************************
#**
#**  File     :  /cdimage/units/URL0202/URL0202_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Cybran Very Heavy Tank Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CLandUnit = import('/lua/cybranunits.lua').CLandUnit
local CDFLaserHeavyWeapon = import('/lua/cybranweapons.lua').CDFLaserHeavyWeapon
local CDFElectronBolterWeapon = import('/lua/cybranweapons.lua').CDFElectronBolterWeapon

WRL0301 = Class(CLandUnit) {
    Weapons = {
        MainGun = Class(CDFElectronBolterWeapon) {},
    },


    OnStopBeingBuilt = function(self,builder,layer)
       CLandUnit.OnStopBeingBuilt(self,builder,layer)
       self:SetMaintenanceConsumptionActive()
    end,

}

TypeClass = WRL0301