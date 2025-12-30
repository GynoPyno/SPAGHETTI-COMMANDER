#****************************************************************************
#**
#**  File     :  /cdimage/units/URB1301/URB1301_script.lua
#**  Author(s):  John Comes, Dave Tomandl, Jessica St. Croix
#**
#**  Summary  :  Cybran Power Generator Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CEnergyCreationUnit = import('/lua/cybranunits.lua').CEnergyCreationUnit

local URB1301OLD = URB1301
URB1301 = Class(URB1301OLD) {

	ProductionEffects = {
        '/mods/BattlePack/effects/emitters/cybran_researchstation_01_emit.bp',
        '/mods/BattlePack/effects/emitters/cybran_researchstation_02_emit.bp',
        '/mods/BattlePack/effects/emitters/cybran_researchstation_03_emit.bp',
        '/mods/BattlePack/effects/emitters/cybran_researchstation_04_emit.bp',
        '/mods/BattlePack/effects/emitters/cybran_researchstation_05_emit.bp',
        '/mods/BattlePack/effects/emitters/cybran_researchstation_06_emit.bp',
    },
    
    AmbientEffects = 'CT3PowerAmbient',
    
    OnStopBeingBuilt = function(self, builder, layer)
        CEnergyCreationUnit.OnStopBeingBuilt(self, builder, layer)
        for i = 1, 36 do
            local fxname
            if i < 10 then
                fxname = 'BlinkyLight0' .. i
            else
                fxname = 'BlinkyLight' .. i
            end
            local fx = CreateAttachedEmitter(self, fxname, self:GetArmy(), '/effects/emitters/light_yellow_02_emit.bp'):OffsetEmitter(0, 0, 0.01):ScaleEmitter(1)
            self.Trash:Add(fx)
        end
		local army = self:GetArmy()
	self.ProductionEffectsBag = {}

        if self.ProductionEffectsBag then
            for k, v in self.ProductionEffectsBag do
                v:Destroy()
            end
		    self.ProductionEffectsBag = {}
		end
        for k, v in self.ProductionEffects do
            table.insert( self.ProductionEffectsBag, CreateAttachedEmitter( self, 0, self:GetArmy(), v):ScaleEmitter(0.7):OffsetEmitter(0,2.5,-2))
        end
    end
}

TypeClass = URB1301