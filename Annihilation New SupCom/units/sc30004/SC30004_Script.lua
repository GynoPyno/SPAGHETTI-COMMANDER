#****************************************************************************
#**
#**  File     :  /cdimage/units/URA0102/URA0102_script.lua
#**  Author(s):  John Comes, David Tomandl
#**
#**  Summary  :  Cybran Unit Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
#
# Cybran Interceptor Script : URA0102
#
local CAirUnit = import('/lua/cybranunits.lua').CAirUnit
local CWeapons = import('/lua/cybranweapons.lua')
local CDFElectronBolterWeapon = CWeapons.CDFElectronBolterWeapon

SC30004 = Class(CAirUnit) {
    Weapons = {
        AutoCannon = Class(CDFElectronBolterWeapon) {},
        AutoCannon2 = Class(CDFElectronBolterWeapon) {},
        AutoCannon3 = Class(CDFElectronBolterWeapon) {},
        AutoCannon4 = Class(CDFElectronBolterWeapon) {},
    },
    OnStopBeingBuilt = function(self,builder,layer)
        CAirUnit.OnStopBeingBuilt(self,builder,layer)
        #enable cloaking economy
        #self:SetMaintenanceConsumptionActive()
        self:SetMaintenanceConsumptionInactive()
        self:SetScriptBit('RULEUTC_CloakToggle', true)
        self:RequestRefreshUI()
    end,
}

TypeClass = SC30004
