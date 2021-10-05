--****************************************************************************
--**
--**  File     :  /data/units/XAA0305/XAA0305_script.lua
--**  Author(s):  Jessica St. Croix
--**
--**  Summary  :  Aeon AA Gunship Script
--**
--**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
--****************************************************************************

local SAirUnit = import('/lua/seraphimunits.lua').SAirUnit
local WeaponsFile = import('/lua/seraphimweapons.lua')
local SANUallCavitationTorpedo = WeaponsFile.SANUallCavitationTorpedo
local SDFSinnuntheWeapon = WeaponsFile.SDFSinnuntheWeapon
local TSAMLauncher = import('/lua/terranweapons.lua').TSAMLauncher
local EffectUtil = import('/lua/EffectUtilities.lua')
local EmitterBasePath = '/effects/emitters/'

KSA0401 = Class(SAirUnit) {

    EngineRotateBones = {'Jet_Front', 'Jet_Back',},
	
    BeamExhaustIdle = '/effects/emitters/air_idle_trail_beam_01_emit.bp',
	BeamExhaustCruise = '/effects/emitters/air_idle_trail_beam_01_emit.bp',
		
Weapons = {
		
        MissileRack01 = Class(TSAMLauncher) {},
		
        RightTurret01 = Class(SDFSinnuntheWeapon) {
            PlayFxMuzzleChargeSequence = function(self, muzzle)
            SDFSinnuntheWeapon.PlayFxMuzzleChargeSequence(self, muzzle)
            end,
        },
        LeftTurret01 = Class(SDFSinnuntheWeapon) {
            PlayFxMuzzleChargeSequence = function(self, muzzle)
            SDFSinnuntheWeapon.PlayFxMuzzleChargeSequence(self, muzzle)
            end,
        },
		
        Torpedo = Class(SANUallCavitationTorpedo) {},
		
    },
	
    StartBeingBuiltEffects = function(self, builder, layer)
		SAirUnit.StartBeingBuiltEffects(self, builder, layer)
		self:ForkThread( EffectUtil.CreateSeraphimExperimentalBuildBaseThread, builder, self.OnBeingBuiltEffectsBag )
    end,  
	
    OnStopBeingBuilt = function(self,builder,layer)
        SAirUnit.OnStopBeingBuilt(self,builder,layer)
        self.EngineManipulators = {}

        -- create the engine thrust manipulators
        for key, value in self.EngineRotateBones do
            table.insert(self.EngineManipulators, CreateThrustController(self, "thruster", value))
        end

        -- set up the thursting arcs for the engines
        for key,value in self.EngineManipulators do
            --                       XMAX, XMIN, YMAX,YMIN, ZMAX,ZMIN, TURNMULT, TURNSPEED
            value:SetThrustingParam( -0.0, 0.0, -0.25, 0.25, -0.1, 0.1, 1.0,      0.25 )
        end
        
        for k, v in self.EngineManipulators do
            self.Trash:Add(v)
        end

		CreateAttachedEmitter(self,'Exhaust_Front01',self:GetArmy(),EmitterBasePath .. 'seraphim_ohwalli_strategic_flight_fxtrails_05_emit.bp')
		CreateAttachedEmitter(self,'Exhaust_Front01',self:GetArmy(),EmitterBasePath .. 'seraphim_ohwalli_strategic_flight_fxtrails_06_emit.bp')
		CreateAttachedEmitter(self,'Exhaust_Front01',self:GetArmy(),EmitterBasePath .. 'seraphim_ohwalli_strategic_flight_fxtrails_07_emit.bp')
		CreateAttachedEmitter(self,'Exhaust_Front01',self:GetArmy(),EmitterBasePath .. 'seraphim_ohwalli_strategic_flight_fxtrails_08_emit.bp')
		
		CreateAttachedEmitter(self,'Exhaust_Front02',self:GetArmy(),EmitterBasePath .. 'seraphim_ohwalli_strategic_flight_fxtrails_05_emit.bp')
		CreateAttachedEmitter(self,'Exhaust_Front02',self:GetArmy(),EmitterBasePath .. 'seraphim_ohwalli_strategic_flight_fxtrails_06_emit.bp')
		CreateAttachedEmitter(self,'Exhaust_Front02',self:GetArmy(),EmitterBasePath .. 'seraphim_ohwalli_strategic_flight_fxtrails_07_emit.bp')
		CreateAttachedEmitter(self,'Exhaust_Front02',self:GetArmy(),EmitterBasePath .. 'seraphim_ohwalli_strategic_flight_fxtrails_08_emit.bp')
		
		CreateAttachedEmitter(self,'Exhaust_Back01',self:GetArmy(),EmitterBasePath .. 'seraphim_ohwalli_strategic_flight_fxtrails_05_emit.bp')
		CreateAttachedEmitter(self,'Exhaust_Back01',self:GetArmy(),EmitterBasePath .. 'seraphim_ohwalli_strategic_flight_fxtrails_06_emit.bp')
		CreateAttachedEmitter(self,'Exhaust_Back01',self:GetArmy(),EmitterBasePath .. 'seraphim_ohwalli_strategic_flight_fxtrails_07_emit.bp')
		CreateAttachedEmitter(self,'Exhaust_Back01',self:GetArmy(),EmitterBasePath .. 'seraphim_ohwalli_strategic_flight_fxtrails_08_emit.bp')
		
		CreateAttachedEmitter(self,'Exhaust_Back02',self:GetArmy(),EmitterBasePath .. 'seraphim_ohwalli_strategic_flight_fxtrails_05_emit.bp')
		CreateAttachedEmitter(self,'Exhaust_Back02',self:GetArmy(),EmitterBasePath .. 'seraphim_ohwalli_strategic_flight_fxtrails_06_emit.bp')
		CreateAttachedEmitter(self,'Exhaust_Back02',self:GetArmy(),EmitterBasePath .. 'seraphim_ohwalli_strategic_flight_fxtrails_07_emit.bp')
		CreateAttachedEmitter(self,'Exhaust_Back02',self:GetArmy(),EmitterBasePath .. 'seraphim_ohwalli_strategic_flight_fxtrails_08_emit.bp')
        ChangeState(self, self.IdleState)
    end,

    FxDamageScale = 2.5,
}

TypeClass = KSA0401