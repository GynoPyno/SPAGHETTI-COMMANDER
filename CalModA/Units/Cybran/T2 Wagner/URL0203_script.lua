#****************************************************************************
#**
#**  File     :  /cdimage/units/URL0203/URL0203_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Cybran Ambphibious Tank Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CLandUnit = import('/lua/cybranunits.lua').CLandUnit
local CybranWeaponsFile = import('/lua/cybranweapons.lua')
local CDFElectronBolterWeapon = CybranWeaponsFile.CDFElectronBolterWeapon

URL0203 = Class(CLandUnit) {

    Weapons = {
        Bolter = Class(CDFElectronBolterWeapon) {},
    },
    
    OnStopBeingBuilt = function(self,builder,layer)
        CLandUnit.OnCreate(self,builder,layer)
        self:SetMaintenanceConsumptionActive()
        self:HideBone('Turret02', true)		
        
    end,
}
TypeClass = URL0203