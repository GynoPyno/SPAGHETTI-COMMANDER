local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit
local Weapon = import('/lua/sim/Weapon.lua').Weapon
local cWeapons = import('/lua/cybranweapons.lua')
local CDFLaserDisintegratorWeapon = cWeapons.CDFLaserDisintegratorWeapon01
local CDFElectronBolterWeapon = cWeapons.CDFElectronBolterWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local utilities = import('/lua/Utilities.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')

URL0302 = Class(CWalkingLandUnit) {
    ---PlayEndAnimDestructionEffects = false,
    motion = 'Stopped',
    OnCreate = function(self)
        CWalkingLandUnit.OnCreate(self)
        self.AnimManip = CreateAnimator(self)
        self.Trash:Add(self.AnimManip)
    end,
	
	   OnStopBeingBuilt = function(self, builder, layer)
		local army = self:GetArmy()
		CWalkingLandUnit.OnStopBeingBuilt(self, builder, layer)
		local layer = self:GetCurrentLayer()
		if(layer == 'Land') then
            self:CreateUnitAmbientEffect(layer)
        elseif (layer == 'Seabed') then
            self:CreateUnitAmbientEffect(layer)
		end
	---end
        --self.WeaponsEnabled = true
    end,

    OnMotionHorzEventChange = function( self, new, old )
		CWalkingLandUnit.OnMotionHorzEventChange(self, new, old)
		if old == 'Stopped' then
            self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationWalk)
			self.motion = 'Moving'
        elseif new == 'Stopped' then
            self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationIdle):SetRate(0.25)
			self.motion = 'Stopped'
		end
	end,

	OnLayerChange = function(self, new, old)
		CWalkingLandUnit.OnLayerChange(self, new, old)
		---if self.WeaponsEnabled then
			if( new == 'Land' ) then
			    self:CreateUnitAmbientEffect(new)
			elseif ( new == 'Seabed' ) then
			    self:CreateUnitAmbientEffect(new)
    
			end
		---end
	end,

    AmbientExhaustBones = {
		'exhaust_01',
		'exhaust_02',
    },	
    
    AmbientLandExhaustEffects = {
		'/effects/emitters/dirty_exhaust_smoke_02_emit.bp',
		'/effects/emitters/dirty_exhaust_sparks_02_emit.bp',			
	},
	
    AmbientSeabedExhaustEffects = {
		'/effects/emitters/underwater_vent_bubbles_02_emit.bp',			
	},	
	
	CreateUnitAmbientEffect = function(self, layer)
	    if( self.AmbientEffectThread != nil ) then
	       self.AmbientEffectThread:Destroy()
        end	 
        if self.AmbientExhaustEffectsBag then
            EffectUtil.CleanupEffectBag(self,'AmbientExhaustEffectsBag')
        end        
        
        self.AmbientEffectThread = nil
        self.AmbientExhaustEffectsBag = {} 
	    if layer == 'Land' then
	        self.AmbientEffectThread = self:ForkThread(self.UnitLandAmbientEffectThread)
	    elseif layer == 'Seabed' then
	        local army = self:GetArmy()
			for kE, vE in self.AmbientSeabedExhaustEffects do
				for kB, vB in self.AmbientExhaustBones do
					table.insert( self.AmbientExhaustEffectsBag, CreateAttachedEmitter(self, vB, army, vE ))
				end
			end	        
	    end          
	end, 
	
	UnitLandAmbientEffectThread = function(self)
		while not self:IsDead() do
            local army = self:GetArmy()			
			
			for kE, vE in self.AmbientLandExhaustEffects do
				for kB, vB in self.AmbientExhaustBones do
					table.insert( self.AmbientExhaustEffectsBag, CreateAttachedEmitter(self, vB, army, vE ))
				end
			end
			
			WaitSeconds(2)
			EffectUtil.CleanupEffectBag(self,'AmbientExhaustEffectsBag')
							
			WaitSeconds(utilities.GetRandomFloat(1,7))
		end		
	end,

	Weapons = {
        Disintigrator = Class(CDFLaserDisintegratorWeapon) {},
        HeavyBolter = Class(CDFElectronBolterWeapon) {},
    },
}
	TypeClass = URL0302