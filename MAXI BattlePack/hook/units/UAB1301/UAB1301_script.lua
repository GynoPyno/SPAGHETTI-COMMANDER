#****************************************************************************
#**
#**  File     :  /cdimage/units/UAB1301/UAB1301_script.lua
#**  Author(s):  John Comes, Dave Tomandl, Jessica St. Croix
#**
#**  Summary  :  Aeon Power Generator Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local AEnergyCreationUnit = import('/lua/aeonunits.lua').AEnergyCreationUnit
local UAB1301OLD = UAB1301
UAB1301 = Class(UAB1301OLD) {

	ProductionEffects = {
	'/mods/BattlePack/effects/emitters/illuminate_researchstation_02_emit.bp',
	'/mods/BattlePack/effects/emitters/illuminate_researchstation_03_emit.bp',
	'/mods/BattlePack/effects/emitters/illuminate_researchstation_04_emit.bp',
    },

    AmbientEffects = 'AT3PowerAmbient',
    
    OnStopBeingBuilt = function(self, builder, layer)
        AEnergyCreationUnit.OnStopBeingBuilt(self, builder, layer)
        self.Trash:Add(CreateRotator(self, 'Sphere', 'x', nil, 0, 15, 80 + Random(0, 20)))
        self.Trash:Add(CreateRotator(self, 'Sphere', 'y', nil, 0, 15, 80 + Random(0, 20)))
        self.Trash:Add(CreateRotator(self, 'Sphere', 'z', nil, 0, 15, 80 + Random(0, 20)))
		self.ProductionEffectsBag = {}

        if self.ProductionEffectsBag then
            for k, v in self.ProductionEffectsBag do
                v:Destroy()
            end
		    self.ProductionEffectsBag = {}
		end
        for k, v in self.ProductionEffects do
            table.insert( self.ProductionEffectsBag, CreateAttachedEmitter( self, 0, self:GetArmy(), v):ScaleEmitter(1):OffsetEmitter(0,5,0))
        end
    end,
}

TypeClass = UAB1301