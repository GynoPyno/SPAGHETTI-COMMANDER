#****************************************************************************
#**
#**  File     :  /cdimage/units/XSS0201/XSS0201_script.lua
#**  Author(s):  Greg Kohne, Gordon Duclos, Aaron Lundquist
#**
#**  Summary  :  Seraphim Destroyer Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local SSubUnit = import('/lua/seraphimunits.lua').SSubUnit
local SeraphimWeapons = import('/lua/seraphimweapons.lua')
local SDFHeavyQuarnonCannon = SeraphimWeapons.SDFHeavyQuarnonCannon
local SANAnaitTorpedo = SeraphimWeapons.SANAnaitTorpedo
local SDFAjelluAntiTorpedoDefense = SeraphimWeapons.SDFAjelluAntiTorpedoDefense

XSS0201 = Class(SSubUnit) {
    BackWakeEffect = {},
    Weapons = {
        FrontTurret = Class(SDFHeavyQuarnonCannon) {},
        BackTurret = Class(SDFHeavyQuarnonCannon) {},
        Torpedo1 = Class(SANAnaitTorpedo) {},
        AntiTorpedo = Class(SDFAjelluAntiTorpedoDefense) {},
    },
    
    OnMotionVertEventChange = function( self, new, old )
        SSubUnit.OnMotionVertEventChange(self, new, old)
        if new == 'Top' then
            self:SetWeaponEnabledByLabel('FrontTurret', true)
            self:SetWeaponEnabledByLabel('BackTurret', true)
        elseif new == 'Down' then
            self:SetWeaponEnabledByLabel('FrontTurret', false)
            self:SetWeaponEnabledByLabel('BackTurret', false)
        end
    end,
    
	OnStopBeingBuilt = function(self, builder, layer)
		SSubUnit.OnStopBeingBuilt(self, builder, layer)
		IssueDive({self})
	end,
}
TypeClass = XSS0201