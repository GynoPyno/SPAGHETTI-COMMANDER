#****************************************************************************
#** 
#**  File     :  /cdimage/units/XSC1501/XSC1501_script.lua 
#** 
#** 
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local SEnergyCreationUnit = import('/lua/seraphimunits.lua').SEnergyCreationUnit

WSB1303 = Class(SEnergyCreationUnit) {
    ProductionEffects = {
	'/Mods/BattlePack/effects/emitters/seraphim_researchstation_03_emit.bp',
	'/Mods/BattlePack/effects/emitters/seraphim_researchstation_04_emit.bp',
    },

    OnStopBeingBuilt = function(self, builder, layer)
	SEnergyCreationUnit.OnStopBeingBuilt(self)
	self.ProductionEffectsBag = {}

        if self.ProductionEffectsBag then
            for k, v in self.ProductionEffectsBag do
                v:Destroy()
            end
		    self.ProductionEffectsBag = {}
		end
        for k, v in self.ProductionEffects do
            table.insert( self.ProductionEffectsBag, CreateAttachedEmitter( self, 0, self:GetArmy(), v):ScaleEmitter(1.5):OffsetEmitter(-1,4,-2.1))
        end
    end,
}


TypeClass = WSB1303

