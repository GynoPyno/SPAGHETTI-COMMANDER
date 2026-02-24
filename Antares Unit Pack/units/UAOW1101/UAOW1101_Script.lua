local AAirUnit = import('/lua/aeonunits.lua').AAirUnit

local WeaponsFile = import ('/lua/aeonweapons.lua')

local AAAZealotMissileWeapon = import('/lua/aeonweapons.lua').AAAZealotMissileWeapon
local AIFArtilleryMiasmaShellWeapon = import('/lua/aeonweapons.lua').AIFArtilleryMiasmaShellWeapon

local explosion = import('/lua/defaultexplosions.lua')

local util = import('/lua/utilities.lua')
local utilities = import('/lua/Utilities.lua')
local fxutil = import('/lua/effectutilities.lua')
local Effects = import('/lua/effecttemplates.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')
local EffectUtils = import('/lua/EffectUtilities.lua')
local ExhaustBeam = import('/lua/effecttemplates.lua')
local ExhaustEffects = import('/lua/effecttemplates.lua')

local AIUtils = import('/lua/ai/aiutilities.lua')

UAOW1101 = Class(AAirUnit) {
	DestroyNoFallRandomChance = 1.1,

    Weapons = {
        FirstGun = Class(AAAZealotMissileWeapon) {},
	SecondGun = Class(AAAZealotMissileWeapon) {},
        MainGun = Class(AIFArtilleryMiasmaShellWeapon) {},
    },
	
    OnStopBeingBuilt = function(self,builder,layer)
        AAirUnit.OnStopBeingBuilt(self,builder,layer)
        self.Trash:Add(CreateRotator(self, 'Rot01', 'z', nil, -190, 0, -190))
        self.Trash:Add(CreateRotator(self, 'Rot02', 'z', nil, -190, 0, -190))
        self.Trash:Add(CreateRotator(self, 'Rot03', 'z', nil, -190, 0, -190))
		self.Trash:Add(CreateRotator(self, 'Rot04', 'z', nil, -190, 0, -190))
    end,		
	
    MovementAmbientExhaustBones = {
        'Exhaust01',
        'Exhaust02',
	'Exhaust03',
	'Exhaust04',
    },

    OnMotionHorzEventChange = function(self, new, old )
		AAirUnit.OnMotionHorzEventChange(self, new, old)
	
		if self.ThrustExhaustTT1 == nil then 
			if self.MovementAmbientExhaustEffectsBag then
				fxutil.CleanupEffectBag(self,'MovementAmbientExhaustEffectsBag')
			else
				self.MovementAmbientExhaustEffectsBag = {}
			end
			self.ThrustExhaustTT1 = self:ForkThread(self.MovementAmbientExhaustThread)
		end
		
        if new == 'Stopped' and self.ThrustExhaustTT1 != nil then
			KillThread(self.ThrustExhaustTT1)
			fxutil.CleanupEffectBag(self,'MovementAmbientExhaustEffectsBag')
			self.ThrustExhaustTT1 = nil
        end		 
    end,
    
    MovementAmbientExhaustThread = function(self)
		while not self:IsDead() do
			local ExhaustEffects = {
				'/effects/emitters/aeon_serp_flash_02_emit.bp',
				'/effects/emitters/aeon_serp_flash_03_emit.bp',	
			}
			local ExhaustBeam = '/mods/Antares Unit Pack/effects/emitters/cybran_missile_exhaust_fire_beam_11_emit.bp'
			local army = self:GetArmy()			
			
			for kE, vE in ExhaustEffects do
				for kB, vB in self.MovementAmbientExhaustBones do
					table.insert( self.MovementAmbientExhaustEffectsBag, CreateAttachedEmitter(self, vB, army, vE ))
					table.insert( self.MovementAmbientExhaustEffectsBag, CreateBeamEmitterOnEntity( self, vB, army, ExhaustBeam ))
				end
			end
			WaitSeconds(5)
			fxutil.CleanupEffectBag(self,'MovementAmbientExhaustEffectsBag')
							
			--WaitSeconds(util.GetRandomFloat(0,3))
		end	
    end,		
			
  	
}

TypeClass = UAOW1101