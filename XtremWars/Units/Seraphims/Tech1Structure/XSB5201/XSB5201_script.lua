#****************************************************************************
#**
#**  File     :  /cdimage/units/UAB5201/UAB5201_script.lua
#**  Author(s):  John Comes, David Tomandl
#**					Modified By Asdrubaelvect for Experiementals Wars.
#**  Summary  :  Aeon Air Staging Platform
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local SAirStagingPlatformUnit = import('/lua/seraphimunits.lua').SAirStagingPlatformUnit
local SeraphimAirStagePlat01 = import('/lua/EffectTemplates.lua').SeraphimAirStagePlat01

XSB5201 = Class(SAirStagingPlatformUnit) {
    OnStopBeingBuilt = function(self,builder,layer)
        
        for k, v in SeraphimAirStagePlat01 do
            CreateAttachedEmitter(self, 'Pod01', self:GetArmy(), v)
            CreateAttachedEmitter(self, 'Pod05', self:GetArmy(), v)
            CreateAttachedEmitter(self, 'Pod06', self:GetArmy(), v)
        end        

        SAirStagingPlatformUnit.OnStopBeingBuilt(self, builder, layer)
    end,
}

TypeClass = XSB5201