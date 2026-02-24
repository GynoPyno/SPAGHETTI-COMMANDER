local TAirUnit = import('/lua/terranunits.lua').TAirUnit

local WeaponFile = import('/lua/terranweapons.lua')

local TSAMLauncher = import('/lua/terranweapons.lua').TSAMLauncher
local TIFStrategicMissileWeapon = WeaponFile.TIFStrategicMissileWeapon
local TAMInterceptorWeapon = import('/lua/terranweapons.lua').TAMInterceptorWeapon
local nukeFiredOnGotTarget = false

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

SWEO05 = Class(TAirUnit) {
	DestroyNoFallRandomChance = 1.1,
    Weapons = {
        NukeMissiles = Class(TIFStrategicMissileWeapon) {},
        AntiNuke = Class(TAMInterceptorWeapon) {
            IdleState = State(TAMInterceptorWeapon.IdleState) {
                OnGotTarget = function(self)
                    local bp = self:GetBlueprint()
                    #only say we've fired if the parent fire conditions are met
                    if (bp.WeaponUnpackLockMotion != true or (bp.WeaponUnpackLocksMotion == true and not self.unit:IsUnitState('Moving'))) then
                        if (bp.CountedProjectile == false) or self:CanFire() then
                             nukeFiredOnGotTarget = true
                        end
                    end
                    TAMInterceptorWeapon.IdleState.OnGotTarget(self)
                end,
                # uses OnGotTarget, so we shouldn't do this.
                OnFire = function(self)
                    if not nukeFiredOnGotTarget then
                        TAMInterceptorWeapon.IdleState.OnFire(self)
                    end
                    nukeFiredOnGotTarget = false
                    
                    self:ForkThread(function()
                        self.unit:SetBusy(true)
                        WaitSeconds(1/self.unit:GetBlueprint().Weapon[1].RateOfFire + .2)
                        self.unit:SetBusy(false)
                    end)
                end,
            },    
        },
	MissileRack01 = Class(TSAMLauncher) {},
	MissileRack02 = Class(TSAMLauncher) {},
	MissileRack03 = Class(TSAMLauncher) {},
	MissileRack04 = Class(TSAMLauncher) {},
	MissileRack05 = Class(TSAMLauncher) {},
	MissileRack06 = Class(TSAMLauncher) {},
    },

    OnStopBeingBuilt = function(self,builder,layer)
        TAirUnit.OnStopBeingBuilt(self,builder,layer)
        self.Trash:Add(CreateRotator(self, 'Spinner01', 'y', nil, 360, 0, 180))
        self.Trash:Add(CreateRotator(self, 'Spinner02', 'y', nil, 90, 0, 180))
        self.Trash:Add(CreateRotator(self, 'Spinner03', 'y', nil, -180, 0, -180))
    end,

    MovementAmbientExhaustBones = {
                            'Projectile01',
                            'Projectile02',
                            'Projectile03',
    },

    OnMotionHorzEventChange = function(self, new, old )
		TAirUnit.OnMotionHorzEventChange(self, new, old)
	
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
				'/effects/emitters/nuke_munition_launch_trail_02_emit.bp',
			}
			local ExhaustBeam = '/mods/Antares Unit Pack/effects/emitters/missile_exhaust_fire_beam_12_emit.bp'
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

TypeClass = SWEO05