#****************************************************************************
#** 
#**  File     :  /cdimage/units/XSC1501/XSC1501_script.lua 
#** 
#** 
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local SShieldStructureUnit = import('/lua/seraphimunits.lua').SShieldStructureUnit

WSB1401 = Class(SShieldStructureUnit) {
	ShieldEffects = {
        '/effects/emitters/seraphim_shield_generator_t3_01_emit.bp',
        '/effects/emitters/seraphim_shield_generator_t3_02_emit.bp',
        '/effects/emitters/seraphim_shield_generator_t3_03_emit.bp', 
        '/effects/emitters/seraphim_shield_generator_t3_04_emit.bp',        
        '/effects/emitters/seraphim_shield_generator_t3_05_emit.bp',
    },
	OrbEffects = {
        '/effects/emitters/quark_bomb2_02_emit.bp',
    },
	PhasonEffects = {
        '/effects/emitters/phason_laser_muzzle_01_emit.bp',
    },
	SmallBeamEffects = {
        '/mods/BattlePack/effects/emitters/seratank_beam_emit.bp',
    },
	
	OnStopBeingBuilt = function(self,builder,layer)
        SShieldStructureUnit.OnStopBeingBuilt(self,builder,layer)
		self.Rotator1 = CreateRotator(self, 'Float_Platform', 'y', nil, 45, 25, 45)
		self.Trash:Add(self.Rotator1)
		self.ShieldEffectsBag = {}
		self.OrbEffectsBag = {}
		self.LargeBeamEffectsBag = {}
		self.SmallBeamEffectsBag = {}
    end,

    OnShieldEnabled = function(self)
        SShieldStructureUnit.OnShieldEnabled(self)
		if self.Rotator1 then
            self.Rotator1:SetTargetSpeed(45)
        end
        if self.ShieldEffectsBag then
            for k, v in self.ShieldEffectsBag do
                v:Destroy()
            end
		    self.ShieldEffectsBag = {}
		end
		if self.OrbEffectsBag then
            for k, v in self.OrbEffectsBag do
                v:Destroy()
            end
		    self.OrbEffectsBag = {}
		end
		if self.PhasonEffectsBag then
            for k, v in self.PhasonEffectsBag do
                v:Destroy()
            end
		    self.PhasonEffectsBag = {}
		end
		if self.SmallBeamEffectsBag then
            for k, v in self.SmallBeamEffectsBag do
                v:Destroy()
            end
		    self.SmallBeamEffectsBag = {}
		end
        for k, v in self.ShieldEffects do
            table.insert( self.ShieldEffectsBag, CreateAttachedEmitter( self, 0, self:GetArmy(), v ) )
        end
		for k, v in self.OrbEffects do
            table.insert( self.OrbEffectsBag, CreateAttachedEmitter( self, 'LargeEnergySphere', self:GetArmy(), v ):ScaleEmitter(2)  )
			table.insert( self.OrbEffectsBag, CreateAttachedEmitter( self, 'EnergySphere001', self:GetArmy(), v ):ScaleEmitter(1)  )
			table.insert( self.OrbEffectsBag, CreateAttachedEmitter( self, 'EnergySphere002', self:GetArmy(), v ):ScaleEmitter(1)  )
			table.insert( self.OrbEffectsBag, CreateAttachedEmitter( self, 'EnergySphere003', self:GetArmy(), v ):ScaleEmitter(1)  )			
			table.insert( self.OrbEffectsBag, CreateAttachedEmitter( self, 'BeamSphere001', self:GetArmy(), v ):ScaleEmitter(1)  )
			table.insert( self.OrbEffectsBag, CreateAttachedEmitter( self, 'BeamSphere002', self:GetArmy(), v ):ScaleEmitter(1)  )
			table.insert( self.OrbEffectsBag, CreateAttachedEmitter( self, 'BeamSphere003', self:GetArmy(), v ):ScaleEmitter(1)  )
			table.insert( self.OrbEffectsBag, CreateAttachedEmitter( self, 'BeamSphere004', self:GetArmy(), v ):ScaleEmitter(1)  )
			table.insert( self.OrbEffectsBag, CreateAttachedEmitter( self, 'BeamSphere005', self:GetArmy(), v ):ScaleEmitter(1)  )
			table.insert( self.OrbEffectsBag, CreateAttachedEmitter( self, 'BeamSphere006', self:GetArmy(), v ):ScaleEmitter(1)  )
        end
		for k, v in self.PhasonEffects do
			table.insert( self.OrbEffectsBag, CreateAttachedEmitter( self, 'EnergyDown_Effect', self:GetArmy(), v ):ScaleEmitter(1)  )
			table.insert( self.OrbEffectsBag, CreateAttachedEmitter( self, 'EnergyUp_Effect', self:GetArmy(), v ):ScaleEmitter(1)  )
        end
		for k, v in self.SmallBeamEffects do
			table.insert( self.SmallBeamEffectsBag, AttachBeamEntityToEntity( self, 'BeamSphere001', self, 'BeamSphere002', self:GetArmy(), v )  )
			table.insert( self.SmallBeamEffectsBag, AttachBeamEntityToEntity( self, 'BeamSphere002', self, 'BeamSphere003', self:GetArmy(), v )  )
			table.insert( self.SmallBeamEffectsBag, AttachBeamEntityToEntity( self, 'BeamSphere003', self, 'BeamSphere004', self:GetArmy(), v )  )
			table.insert( self.SmallBeamEffectsBag, AttachBeamEntityToEntity( self, 'BeamSphere004', self, 'BeamSphere005', self:GetArmy(), v )  )
			table.insert( self.SmallBeamEffectsBag, AttachBeamEntityToEntity( self, 'BeamSphere005', self, 'BeamSphere006', self:GetArmy(), v )  )
			table.insert( self.SmallBeamEffectsBag, AttachBeamEntityToEntity( self, 'BeamSphere006', self, 'BeamSphere001', self:GetArmy(), v )  )			
        end
    end,

    OnShieldDisabled = function(self)
        SShieldStructureUnit.OnShieldDisabled(self)
		self.Rotator1:SetTargetSpeed(0)
        if self.ShieldEffectsBag then
            for k, v in self.ShieldEffectsBag do
                v:Destroy()
            end
		    self.ShieldEffectsBag = {}
		end
		if self.OrbEffectsBag then
            for k, v in self.OrbEffectsBag do
                v:Destroy()
            end
		    self.OrbEffectsBag = {}
		end
		if self.PhasonEffectsBag then
            for k, v in self.PhasonEffectsBag do
                v:Destroy()
            end
		    self.PhasonEffectsBag = {}
		end
		if self.SmallBeamEffectsBag then
            for k, v in self.SmallBeamEffectsBag do
                v:Destroy()
            end
		    self.SmallBeamEffectsBag = {}
		end
    end,
    
    OnKilled = function(self, instigator, type, overkillRatio)
        SShieldStructureUnit.OnKilled(self, instigator, type, overkillRatio)
        if self.ShieldEffectsBag then
            for k,v in self.ShieldEffectsBag do
                v:Destroy()
            end
        end
		if self.OrbEffectsBag then
            for k,v in self.OrbEffectsBag do
                v:Destroy()
            end
        end
		if self.PhasonEffectsBag then
            for k,v in self.PhasonEffectsBag do
                v:Destroy()
            end
        end
		if self.SmallBeamEffectsBag then
            for k,v in self.SmallBeamEffectsBag do
                v:Destroy()
            end
        end
    end,

}


TypeClass = WSB1401

