#****************************************************************************
#** 
#**  File     :  /cdimage/units/URC1501/URC1501_script.lua 
#**  Author(s):  John Comes, David Tomandl 
#** 
#**  Summary  :  Cybran Manufacturing Center, Ver1
#** 
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local CStructureUnit = import('/lua/cybranunits.lua').CStructureUnit

WRB1303 = Class(CStructureUnit) {
    ProductionEffects = {
        '/Mods/BattlePack/effects/emitters/cybran_researchstation_01_emit.bp',
        '/Mods/BattlePack/effects/emitters/cybran_researchstation_02_emit.bp',
        '/Mods/BattlePack/effects/emitters/cybran_researchstation_03_emit.bp',
        '/Mods/BattlePack/effects/emitters/cybran_researchstation_04_emit.bp',
        '/Mods/BattlePack/effects/emitters/cybran_researchstation_05_emit.bp',
        '/Mods/BattlePack/effects/emitters/cybran_researchstation_06_emit.bp',
    },

	EffectBones01 = {
		'Smoke_Left01', 'Smoke_Left02', 'Smoke_Left03', 'Smoke_Left04',	'Smoke_Left05',					
		'Smoke_Right01', 'Smoke_Right02', 'Smoke_Right03', 'Smoke_Right04',	'Smoke_Right05',
		'Smoke_Center01', 'Smoke_Center02',						
	},
	EffectBones02 = {
		'Smoke_Left03', 'Smoke_Right03', 'Smoke_Center01',
	},

    OnStopBeingBuilt = function(self,builder,layer)
        CStructureUnit.OnStopBeingBuilt(self,builder,layer)
		local army = self:GetArmy()
	self.ProductionEffectsBag = {}

        if self.ProductionEffectsBag then
            for k, v in self.ProductionEffectsBag do
                v:Destroy()
            end
		    self.ProductionEffectsBag = {}
		end
        for k, v in self.ProductionEffects do
            table.insert( self.ProductionEffectsBag, CreateAttachedEmitter( self, 0, self:GetArmy(), v):ScaleEmitter(0.7):OffsetEmitter(0,-1,0.7))
        end
        for k, v in self.EffectBones01 do
            CreateAttachedEmitter(self,v,army,'/effects/emitters/urc1501_ambient_01_emit.bp')
            CreateAttachedEmitter(self,v,army,'/effects/emitters/urc1501_ambient_02_emit.bp')
        end
        for k, v in self.EffectBones02 do
            CreateAttachedEmitter(self,v,army,'/effects/emitters/uec1501_smoke_01_emit.bp')
        end	
    end,
}


TypeClass = WRB1303

