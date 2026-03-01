#****************************************************************************
#**
#**  File     :  /units/UEB1107/UEB1107_script.lua
#**  Author(s):  Jessica St. Croix
#**
#**  Summary  :  UEF Hydrocarbon tech 2 Power Plant Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local TEnergyCreationUnit = import('/lua/terranunits.lua').TEnergyCreationUnit

UEB1107 = Class( TEnergyCreationUnit ) {
    DestructionPartsHighToss = {'Exhaust01',},
    DestructionPartsLowToss = {'Exhaust01','Exhaust02','Exhaust03','Exhaust04','Exhaust05',},
    DestructionPartsChassisToss = {'UEB1102'},
    AirEffects = {'/effects/emitters/hydrocarbon_smoke_01_emit.bp',},
    AirEffectsBones = {'Exhaust01'},
    WaterEffects = {'/effects/emitters/hydrocarbon_smoke_01_emit.bp',},
    WaterEffectsBones = {'Exhaust01'},


    OnStopBeingBuilt = function(self, builder, layer)
        TEnergyCreationUnit.OnStopBeingBuilt(self,builder,layer)
		    self.Trash:Add(CreateRotator(self, 'Rot01', 'y', nil, 100, 0, 50))
			self.Trash:Add(CreateRotator(self, 'Rot02', 'y', nil, 100, 0, 50))
			self.Trash:Add(CreateRotator(self, 'Rot03', 'y', nil, 100, 0, 50))
			self.Trash:Add(CreateRotator(self, 'Rot04', 'y', nil, 100, 0, 50))
			--[[
			self.Effect1 = CreateAttachedEmitter(self,'Exhaust01',self:GetArmy(), '/hook/effects/emitters/uec1501_smoke_03_emit.bp')
			self.Effect1 = CreateAttachedEmitter(self,'Exhaust02',self:GetArmy(), '/hook/effects/emitters/uec1501_smoke_03_emit.bp')
			self.Effect1 = CreateAttachedEmitter(self,'Exhaust03',self:GetArmy(), '/hook/effects/emitters/uec1501_smoke_03_emit.bp')
			self.Effect1 = CreateAttachedEmitter(self,'Exhaust04',self:GetArmy(), '/hook/effects/emitters/uec1501_smoke_03_emit.bp')
			self.Effect1 = CreateAttachedEmitter(self,'Exhaust05',self:GetArmy(), '/hook/effects/emitters/uec1501_smoke_03_emit.bp')
			]]--
	end,

}

TypeClass = UEB1107
