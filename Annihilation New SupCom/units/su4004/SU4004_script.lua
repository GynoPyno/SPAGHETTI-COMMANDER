#****************************************************************************
#**
#**  File     :  /cdimage/units/UEB4301/UEB4301_script.lua
#**  Author(s):  John Comes, Greg Kohne
#**
#**  Summary  :  UEF Heavy Shield Generator Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TShieldStructureUnit = import('/lua/terranunits.lua').TShieldStructureUnit

SU4004 = Class(TShieldStructureUnit) {
    
    ShieldEffects = {
        '/effects/emitters/terran_shield_generator_t2_01_emit.bp',
        '/effects/emitters/terran_shield_generator_T3_02_emit.bp',
        ###'/effects/emitters/terran_shield_generator_t2_03_emit.bp',
    },
    
    OnStopBeingBuilt = function(self,builder,layer)
        TShieldStructureUnit.OnStopBeingBuilt(self,builder,layer)
    --    self.Rotator1 = CreateRotator(self, 'Shaft', 'z', nil, 30, 5, 30)
		self.ShieldEffectsBag = {}
    end,

    OnShieldEnabled = function(self)
        TShieldStructureUnit.OnShieldEnabled(self)
        
        if self.ShieldEffectsBag then
            for k, v in self.ShieldEffectsBag do
                v:Destroy()
            end
		    self.ShieldEffectsBag = {}
		end
        for k, v in self.ShieldEffects do
            table.insert( self.ShieldEffectsBag, CreateAttachedEmitter( self, 'Shaft', self:GetArmy(), v ) )
        end
    end,

    OnShieldDisabled = function(self)
        TShieldStructureUnit.OnShieldDisabled(self)
    --    self.Rotator1:SetTargetSpeed(0)
        
        if self.ShieldEffectsBag then
            for k, v in self.ShieldEffectsBag do
                v:Destroy()
            end
		    self.ShieldEffectsBag = {}
		end
    end,
}

TypeClass = SU4004