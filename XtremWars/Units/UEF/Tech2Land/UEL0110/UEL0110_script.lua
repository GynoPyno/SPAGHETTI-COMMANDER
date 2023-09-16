#****************************************************************************
#**
#**  File     :  /cdimage/units/UEL0307/UEL0307_script.lua
#**  Author(s):  David Tomandl, Jessica St. Croix
#**
#**  Summary  :  UEF Mobile Shield Generator Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TConstructionUnit = import('/lua/terranunits.lua').TConstructionUnit
local Entity = import('/lua/sim/Entity.lua').Entity


UEL0110 = Class(TConstructionUnit) {
    
    OnCreate = function(self)
        TConstructionUnit.OnCreate(self)	
        self:SetMaintenanceConsumptionInactive()
        self:SetScriptBit('RULEUTC_JammingToggle', true)
        self:RequestRefreshUI()
	end,
		
    OnStopBeingBuilt = function(self,builder,layer)
        TConstructionUnit.OnStopBeingBuilt(self,builder,layer)
        --self.Trash:Add(CreateRotator(self, 'Spinner01', 'y', nil, 360, 0, 180))
        --self.Trash:Add(CreateRotator(self, 'Spinner02', 'y', nil, 90, 0, 180))
        --self.Trash:Add(CreateRotator(self, 'Spinner03', 'y', nil, -180, 0, -180))
        self.RadarEnt = Entity {}
        self.Trash:Add(self.RadarEnt)
        self.RadarEnt:InitIntel(self:GetArmy(), 'Radar', self:GetBlueprint().Intel.RadarRadius or 75)
        self.RadarEnt:EnableIntel('Radar')
        self.RadarEnt:AttachBoneTo(-1, self, 0)
    end,
}

TypeClass = UEL0110