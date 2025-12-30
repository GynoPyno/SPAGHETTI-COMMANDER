#****************************************************************************
#**
#**  File     :  /cdimage/units/UEB1301/UEB1301_script.lua
#**  Author(s):  John Comes, Dave Tomandl, Jessica St. Croix
#**
#**  Summary  :  UEF Tier 3 Power Generator Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TEnergyCreationUnit = import('/lua/terranunits.lua').TEnergyCreationUnit

local UEB1301OLD = UEB1301


UEB1301 = Class(UEB1301OLD) {
    ProductionEffects = {
		'/mods/BattlePack/effects/emitters/uef_researchstation_01_emit.bp',
		'/mods/BattlePack/effects/emitters/uef_researchstation_02_emit.bp',
		'/mods/BattlePack/effects/emitters/uef_researchstation_03_emit.bp',
		'/mods/BattlePack/effects/emitters/uef_researchstation_04_emit.bp',
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
            table.insert( self.ProductionEffectsBag, CreateAttachedEmitter( self, 0, self:GetArmy(), v):ScaleEmitter(0.5):OffsetEmitter(-0.3,0.5,3))
        end
    end,
}

TypeClass = UEB1301