#****************************************************************************
#**
#**  File     :  /mods/Hyper Experimental Tier/units/XUAL0104/XUAL0104_script.lua
#**  Author(s):  Cmd Draven
#**
#**  Summary  :  Aeon Experimental Sniper
#**
#****************************************************************************
local AHoverLandUnit = import('/lua/aeonunits.lua').AHoverLandUnit
local AAASonicPulseBatteryWeapon = import('/lua/aeonweapons.lua').AAASonicPulseBatteryWeapon


XUAL0104 = Class(AHoverLandUnit) {

    Weapons = {
        Sniper = Class(AAASonicPulseBatteryWeapon) {},
    },
    OnStopBeingBuilt = function(self,builder,layer)
        AHoverLandUnit.OnStopBeingBuilt(self,builder,layer)
        self:SetMaintenanceConsumptionInactive()
        self:SetScriptBit('RULEUTC_StealthToggle', true)
        self:RequestRefreshUI()
    end,
}


TypeClass = XUAL0104
