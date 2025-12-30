#****************************************************************************
#**
#**  File     :  /cdimage/units/UEL0401/UEL0401_script.lua
#**  Author(s):  John Comes, David Tomandl, Gordon Duclos
#**
#**  Summary  :  UEF Mobile Factory Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon

WEL1409 = Class(TLandUnit) {
    Weapons = {
        RightTurret01 = Class(TDFGaussCannonWeapon) {},
        RightTurret02 = Class(TDFGaussCannonWeapon) {},
        LeftTurret01 = Class(TDFGaussCannonWeapon) {},
        LeftTurret02 = Class(TDFGaussCannonWeapon) {},
		MainTurret01 = Class(TDFGaussCannonWeapon) {},
    },
	
	    CreateEnhancement = function(self, enh)
        TLandUnit.CreateEnhancement(self, enh)
        local bp = self:GetBlueprint().Enhancements[enh]
        if not bp then return end
        #Shield Field
        if enh == 'ShieldGeneratorField' then
                self:CreateShield(bp)
				self:AddToggleCap('RULEUTC_ShieldToggle')
                self:SetEnergyMaintenanceConsumptionOverride(bp.MaintenanceConsumptionPerSecondEnergy or 0)
                self:SetMaintenanceConsumptionActive()
        elseif enh == 'ShieldGeneratorFieldRemove' then
            self:DestroyShield()
            self:SetMaintenanceConsumptionInactive()
            self:RemoveToggleCap('RULEUTC_ShieldToggle')
        end
    end,
}

TypeClass = WEL1409