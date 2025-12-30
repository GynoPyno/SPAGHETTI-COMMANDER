#****************************************************************************
#** 
#**  File     :  /cdimage/units/UAC1201/UAC1201_script.lua 
#**  Author(s):  John Comes, David Tomandl 
#** 
#**  Summary  :  Aeon Science Lab, Ver1
#** 
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local AEnergyCreationUnit = import('/lua/aeonunits.lua').AEnergyCreationUnit

WAB1303 = Class(AEnergyCreationUnit) {
    ProductionEffects = {
	'/Mods/BattlePack/effects/emitters/illuminate_researchstation_02_emit.bp',
	'/Mods/BattlePack/effects/emitters/illuminate_researchstation_03_emit.bp',
	'/Mods/BattlePack/effects/emitters/illuminate_researchstation_04_emit.bp',
    },

    OnStopBeingBuilt = function(self, builder, layer)
	AEnergyCreationUnit.OnStopBeingBuilt(self)
	self.ProductionEffectsBag = {}

        if self.ProductionEffectsBag then
            for k, v in self.ProductionEffectsBag do
                v:Destroy()
            end
		    self.ProductionEffectsBag = {}
		end
        for k, v in self.ProductionEffects do
            table.insert( self.ProductionEffectsBag, CreateAttachedEmitter( self, 'EffectEmitter', self:GetArmy(), v):ScaleEmitter(1):OffsetEmitter(0,0.8,1))
        end
    end,
}


TypeClass = WAB1303

