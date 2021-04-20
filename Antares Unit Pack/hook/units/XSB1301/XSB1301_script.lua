#****************************************************************************
#**
#**  File     :  /data/units/XSB1301/XSB1301_script.lua
#**  Author(s):  Jessica St. Croix, Greg Kohne
#**
#**  Summary  :  Seraphim T3 Power Generator Script
#**
#**  Copyright � 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local SEnergyCreationUnit = import('/lua/seraphimunits.lua').SEnergyCreationUnit
local XSB1301OLD = XSB1301
XSB1301 = Class(XSB1301OLD) {

ProductionEffects = {
        '/mods/Antares Unit Pack/effects/emitters/seraphim_researchstation_03_emit.bp',
        '/mods/Antares Unit Pack/effects/emitters/seraphim_researchstation_04_emit.bp',
    },
    AmbientEffects = 'ST3PowerAmbient',
    
    OnStopBeingBuilt = function(self, builder, layer)
        SEnergyCreationUnit.OnStopBeingBuilt(self, builder, layer)
        self.Trash:Add(CreateRotator(self, 'Orb', 'y', nil, 0, 15, 80 + Random(0, 20)))
		self.ProductionEffectsBag = {}

        if self.ProductionEffectsBag then
            for k, v in self.ProductionEffectsBag do
                v:Destroy()
            end
		    self.ProductionEffectsBag = {}
		end
        for k, v in self.ProductionEffects do
            table.insert( self.ProductionEffectsBag, CreateAttachedEmitter( self, 0, self:GetArmy(), v):ScaleEmitter(1.5):OffsetEmitter(0,5,-2))
        end
    end,
}

TypeClass = XSB1301