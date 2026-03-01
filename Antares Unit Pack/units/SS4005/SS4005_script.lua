#****************************************************************************
#**
#**  File     :  /cdimage/units/XSB0304/XSB0304_script.lua
#**  Author(s):  Greg Kohne
#**
#**  Summary  :  Seraphim Sub Commander Gateway Unit Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
#
# script for UAB0304
#
local SQuantumGateUnit = import('/lua/seraphimunits.lua').SQuantumGateUnit
local SSeraphimSubCommanderGateway01 = import('/lua/EffectTemplates.lua').SeraphimSubCommanderGateway01
local SSeraphimSubCommanderGateway02 = import('/lua/EffectTemplates.lua').SeraphimSubCommanderGateway02
local SSeraphimSubCommanderGateway03 = import('/lua/EffectTemplates.lua').SeraphimSubCommanderGateway03
SS4005 = Class(SQuantumGateUnit) {

    OnStopBeingBuilt = function(self,builder,layer)
        ###Place emitters at the center of the gateway.
        for k, v in SSeraphimSubCommanderGateway01 do
            CreateAttachedEmitter(self, 'XSC2201', self:GetArmy(), v)
        end
        
        SQuantumGateUnit.OnStopBeingBuilt(self, builder, layer)
    end,
}

TypeClass = SS4005