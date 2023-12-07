#****************************************************************************
#**
#**  File     :  /cdimage/units/XSL0203/XSL0203_script.lua
#**  Author(s):  Greg Kohne, Gordon Duclos
#**
#**  Summary  :  Seraphim Amphibious Tank Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local SHoverLandUnit = import('/lua/seraphimunits.lua').SHoverLandUnit
local SDFAireauWeapon = import('/lua/seraphimweapons.lua').SDFAireauWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')

XSL0203 = Class(SHoverLandUnit) {
    Weapons = {
        GatlingPlasmaCannon = Class(SDFAireauWeapon){},
    },

    OnStopBeingBuilt = function(self,builder,layer)
        SHoverLandUnit.OnStopBeingBuilt(self,builder,layer)

        local EfctTempl = {
            '/mods/CalModU/Units/Sera/T4 Super Heavy Hover Tank/effects/seraphim_ohwalli_strategic_flight_fxtrails_07_emit.bp',
        }
    for k, v in EfctTempl do
        CreateAttachedEmitter(self, 'Turret', self.Army, v):ScaleEmitter(0.2)
    end
    end,

}

TypeClass = XSL0203