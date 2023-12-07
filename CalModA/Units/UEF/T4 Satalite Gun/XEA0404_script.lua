#****************************************************************************
#**
#**  File     :  /cdimage/units/XEA0002/XEA0002_script.lua
#**  Author(s):  Drew Staltman, Gordon Duclos
#**
#**  Summary  :  UEF Defense Satelite Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local TAirUnit = import('/lua/terranunits.lua').TAirUnit
local SDFHeavyQuarnonCannon = import('/lua/seraphimweapons.lua').SDFHeavyQuarnonCannon
local VizMarker = import('/lua/sim/VizMarker.lua').VizMarker

XEA0002 = Class(TAirUnit) {
    DestroyNoFallRandomChance = 1.1,
    
    Weapons = {
        OrbitalDeathLaserWeapon = Class(SDFHeavyQuarnonCannon){},
    },
    
    OnKilled = function(self, instigator, type, overkillRatio)
        if self.IsDying then 
            return 
        end
        
        local wep = self:GetWeaponByLabel('OrbitalDeathLaserWeapon')
        for k, v in wep.Beams do
            v.Beam:Disable()
        end      
        
        self.IsDying = true
        self.Parent:Kill(instigator, type, 0)
        
        TAirUnit.OnKilled(self, instigator, type, overkillRatio)        
    end,
    
    --Make this unit invulnerable
    OnDamage = function()
    end,
}
TypeClass = XEA0002