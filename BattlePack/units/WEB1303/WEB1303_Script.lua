#****************************************************************************
#** 
#**  File     :  /cdimage/units/UEC1501/UEC1501_script.lua 
#**  Author(s):  John Comes, David Tomandl, Gordon Duclos
#** 
#**  Summary  :  Earth Manufacturing Center, Ver1
#** 
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local TEnergyCreationUnit = import('/lua/terranunits.lua').TEnergyCreationUnit

WEB1303 = Class(TEnergyCreationUnit) {

    ProductionEffects = {
		'/Mods/BattlePack/effects/emitters/uef_researchstation_01_emit.bp',
		'/Mods/BattlePack/effects/emitters/uef_researchstation_02_emit.bp',
		'/Mods/BattlePack/effects/emitters/uef_researchstation_03_emit.bp',
		'/Mods/BattlePack/effects/emitters/uef_researchstation_04_emit.bp',
    },
	
	EffectBones01 = {
		'Smoke_Left01', 'Smoke_Right01', 			
	},
	
	EffectBones02 = {
		'ElecEmitter01', 'ElecEmitter02',
	},

    OnStopBeingBuilt = function(self, builder, layer)
	TEnergyCreationUnit.OnStopBeingBuilt(self)
	local army = self:GetArmy()
	self.ProductionEffectsBag = {}

        if self.ProductionEffectsBag then
            for k, v in self.ProductionEffectsBag do
                v:Destroy()
            end
		    self.ProductionEffectsBag = {}
		end
        for k, v in self.ProductionEffects do
            table.insert( self.ProductionEffectsBag, CreateAttachedEmitter( self, 0, self:GetArmy(), v):ScaleEmitter(0.5):OffsetEmitter(-0.4,2,-0.5))
        end
        for k, v in self.EffectBones01 do
            CreateAttachedEmitter(self,v,army,'/effects/emitters/uec1501_smoke_01_emit.bp')
        end		
        for k, v in self.EffectBones02 do
            CreateAttachedEmitter(self,v,army,'/effects/emitters/economy_electricity_01_emit.bp'):ScaleEmitter(1.5)
        end	
    end,

}


TypeClass = WEB1303

