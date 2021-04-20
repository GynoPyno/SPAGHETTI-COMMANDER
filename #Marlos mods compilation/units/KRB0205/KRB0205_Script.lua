
local CConstructionStructureUnit = import('/lua/cybranunits.lua').CConstructionStructureUnit
local EffectUtil = import('/Mods/#Marlos mods compilation/lua/MKEffectUtillities.lua')
local StopReclaimThread = nil
local RecThread = nil
local StopReclaimThread = nil
local ActivatorThread = nil
local ReclaimerThread = nil

KRB0205 = Class(CConstructionStructureUnit) {
	
	RecycleEffectBones = {
		'arm_fl',
		'arm_fr',
		'arm_cl',
		'arm_cr',
		'arm_bl',
		'arm_br',
    },
    
    RecycleEffects = {
		'/Mods/#Marlos mods compilation/effects/emitters/cybran_recycler_05_debris_emit.bp',
		'/Mods/#Marlos mods compilation/effects/emitters/cybran_recycler_02_electricity_emit.bp',
    },

    OnCreate = function(self)
        CConstructionStructureUnit.OnCreate(self)
    	local RecThread = self:ForkThread(self.ReclaimerThread)
		self.Trash:Add( CreateAttachedEmitter( self, 0, self:GetArmy(), '/effects/emitters/aeon_t3power_ambient_01_emit.bp' ):OffsetEmitter(0.2, -0.1, 0):ScaleEmitter(0.45) )
        self:InitAnimatedBones()
		self.AmbientEffectsBag = {}
		self.RecyclerEffects = {}
		do
		self.AllowReclaim = true
		end
    end,

    CreateReclaimEffects = function( self, target )
		EffectUtil.PlayReclaimEffects( self, target, self:GetBlueprint().General.BuildBones.BuildEffectBones or {0,}, self.ReclaimEffectsBag )
    end,

	ReclaimerThread = function(self)

        local aiBrain = GetArmyBrain(self:GetArmy())
        local bp = self:GetBlueprint().Economy.MaxBuildDistance
        local curMass = 0
        local StorageFull = false
        local RecThread = true
        local reclaimMass = false
		
		if ActivatorThread then
		KillThread(ActivatorThread)
		end
		
        while not self.Dead do
            curMass = aiBrain:GetEconomyStoredRatio('MASS')

            -- Decide whether to start/stop reclaiming mass.
			if (reclaimMass and curMass > 0.95) then
                IssueClearCommands({self})
				coroutine.yield(3)
                self.RecThread = false
                reclaimMass = false
                local StorageFull = true
				-- LOG('Recycler: M Storage Full')
				ForkThread(self.ActivatorThread, self)
            elseif (not reclaimMass and curMass < 0.75) then
                reclaimMass = true
                local StorageFull = false
				-- LOG('Recycler: M Storage low, reclaiming')
            end

			-- Find all targets in range
			local pos = self:GetPosition()
			local reclaimTargets = GetReclaimablesInRect(pos[1] - bp, pos[3] - bp, pos[1] + bp, pos[3] + bp)
			
			-- LOG (repr(curMass))
			-- LOG (repr(AllowReclaim))
			-- LOG (repr(StorageFull))
			-- LOG (repr(reclaimMass))
			if self.AllowReclaim == true and not StorageFull and not table.getn(self:GetCommandQueue()) < 2 then
				-- LOG('Recycler: rechecking reclaim')

				for i, unit in reclaimTargets do
					-- Check unit is properly defined
					if unit then
						-- Check range to target
						targetpos = unit:GetPosition()
						if VDist2Sq(pos[1], pos[3], targetpos[1], targetpos[3]) <= bp * bp then
							if IsUnit(unit) then
									if unit:IsCapturable() then
										continue
									else
										-- LOG('AutoReclaim: Reclaiming uncapturable enemy')
										IssueReclaim({self}, unit)
									end
							elseif reclaimMass then
							IssueReclaim({self}, unit)
								-- LOG('Recycler: Reclaim Issued')
							end
						end
					end
				end
            end
			WaitSeconds(2)
        end
    end,
	
	ActivatorThread = function(self)
		local RecThread = true
		local aiBrain = GetArmyBrain(self:GetArmy())
        local curMass = 0
        while not self.Dead do
			-- local reclaimMass = false
			curMass = aiBrain:GetEconomyStoredRatio('MASS')
			-- Decide whether to start/stop reclaiming mass.
			if curMass > 0.95 then
				IssueClearCommands({self})
				coroutine.yield(3)
				self.RecThread = false
			elseif curMass < 0.75 then
				-- reclaimMass = true
				-- StorageFull = false
				if self.RecThread == false then
				ForkThread(self.ReclaimerThread, self)
				self.RecThread = true
				end
			end
			WaitSeconds(4)
		end
	end,
    
    InitAnimatedBones = function(self)
			-- x - Horizontal left,right y - vertical z - horizontal back,front
			-- self.Slider = CreateSlider(self, 0, 0, -20, 0, 5)
			-- self.SpinManip = (CreateRotator(self, 'Manip_Bone', 'y', nil, 180))
			-- self.Trash:Add(CreateRotator(self, 'Manip_Bone', 'y', nil, 180))
			
		self.ArmBones = {
			{Bone = 'arm_fl',	Axis= 'x',	AngleOn = -55,	AngleOff = 0},
			{Bone = 'arm_cl',	Axis= 'x',	AngleOn = -55,	AngleOff = 0},	
			{Bone = 'arm_bl',	Axis= 'x',	AngleOn = -55,	AngleOff = 0},	
			{Bone = 'arm_fr',	Axis= 'x',	AngleOn = -55,	AngleOff = 0},	
			{Bone = 'arm_cr',	Axis= 'x',	AngleOn = -55,	AngleOff = 0},	
			{Bone = 'arm_br',	Axis= 'x',	AngleOn = -55,	AngleOff = 0},	
		}
		
	    -- self.ShaftSpinner = (CreateRotator(self, 'shaft_spin', 'y', nil, 180))
		self.ShaftSpinner = CreateRotator(self, 'shaft_spin', 'x', nil, 0, 45 )
		self.Trash:Add( self.ShaftSpinner )
		-- PZ CreateSlider(unit, bone, [goal_x, goal_y, goal_z, [speed, [world_space]]])
		-- self.ShaftSlider = CreateSlider(self, 0, 0, 0, 0, 10)
		self.ShaftSlider = CreateSlider( self, 'shaft', -30,0,0, 25,false)
		self.Trash:Add( self.ShaftSlider )
		self.ArmRotators = {}
		for k, v in self.ArmBones do
			local rotator = CreateRotator(self, v.Bone, v.Axis, v.AngleOff, 30, 30, 90)
			table.insert( self.ArmRotators, { Rotator = rotator, AngleOn = v.AngleOn, AngleOff = v.AngleOff })
			self.Trash:Add( rotator )
		end
    end,
	
    ReclaimMode = function(self, bToggle)
    	if bToggle == true then
    		for k, v in self.ArmRotators do
    			v.Rotator:SetGoal(v.AngleOn)
    		end
    		self.ShaftSpinner:SetTargetSpeed(180)
    		self.ShaftSlider:SetGoal(0,0,0)
			
			
			-- self.RecyclerEffects:Add( CreateAttachedEmitter( self, 'aim', self:GetArmy(), '/Mods/#Marlos mods compilation/effects/emitters/cybran_recycler_01_rings_emit.bp' ) )		
			-- self.RecyclerEffects:Add( CreateAttachedEmitter( self, 'aim', self:GetArmy(), '/Mods/#Marlos mods compilation/effects/emitters/cybran_recycler_06_top_electricity_emit.bp' ) )			
			-- self.RecyclerEffects:Add( CreateAttachedEmitter( self, 'shaft_spin', self:GetArmy(), '/Mods/#Marlos mods compilation/effects/emitters/cybran_recycler_04_debris_ring_emit.bp' ) )
    		-- self.RecyclerEffects:Add( CreateAttachedEmitter( self, 'shaft_spin', self:GetArmy(), '/Mods/#Marlos mods compilation/effects/emitters/cybran_recycler_03_line_emit.bp' ) )
			
			table.insert( self.RecyclerEffects, CreateAttachedEmitter( self, 'aim', self:GetArmy(), '/Mods/#Marlos mods compilation/effects/emitters/cybran_recycler_01_rings_emit.bp' ) )		
			table.insert( self.RecyclerEffects, CreateAttachedEmitter( self, 'aim', self:GetArmy(), '/Mods/#Marlos mods compilation/effects/emitters/cybran_recycler_06_top_electricity_emit.bp' ) )			
			table.insert( self.RecyclerEffects, CreateAttachedEmitter( self, 'shaft_spin', self:GetArmy(), '/Mods/#Marlos mods compilation/effects/emitters/cybran_recycler_04_debris_ring_emit.bp' ) )
    		table.insert( self.RecyclerEffects, CreateAttachedEmitter( self, 'shaft_spin', self:GetArmy(), '/Mods/#Marlos mods compilation/effects/emitters/cybran_recycler_03_line_emit.bp' ) )
    		
    		-- for kE, vE in self.RecycleEffects do
				-- for kB, vB in self.RecycleEffectBones do
					-- table.insert( self.RecyclerEffects, CreateAttachedEmitter( self, vB, self:GetArmy(), vE ) )
				-- end
			-- end
    	
    	elseif bToggle == false then
    		for k, v in self.ArmRotators do
    			v.Rotator:SetGoal(v.AngleOff)
    		end
    		self.ShaftSpinner:SetTargetSpeed(0)
    		self.ShaftSlider:SetGoal(-30,0,0)
    		self:DestroyRecyclerEffects()
    	else
    		LOG("ERROR: ReclaimMode bToggle is not a boolean")
    	end
    end,
	
    ReclaimStopDelay = function(self)
    	WaitSeconds(3)
		if table.getn(self:GetCommandQueue()) < 2 then
			if ReclaimerThread then
			KillThread(ReclaimerThread)
			end
    	self:ReclaimMode(false)
		-- ForkThread(self.ReclaimerThread, self)
    	local RecThread = self:ForkThread(self.ReclaimerThread)
		ForkThread(self.ActivatorThread, self)
		end
    end,
	
    OnProductionPaused = function(self)
		self.AllowReclaim = false
		IssueClearCommands({self})
    end,
	
    OnProductionUnpaused = function(self)
		self.AllowReclaim = true
		ForkThread(self.ReclaimerThread, self)
    end,
    
    OnStartReclaim = function( self, target )
    	CConstructionStructureUnit.OnStartReclaim( self, target )
    	if self.RecThread then
    	KillThread(self.RecThread)
    	self.RecThread = nil
    	end
    	if StopReclaimThread then
    		KillThread(StopReclaimThread)
    		StopReclaimThread = nil
    	end
    	self:ReclaimMode(true)
    end,
    
    OnStopReclaim = function( self, target )
    	CConstructionStructureUnit.OnStopReclaim( self, target )
    	StopReclaimThread = self:ForkThread(self.ReclaimStopDelay)
		self:DestroyRecyclerEffects()
    end,
    
    DestroyRecyclerEffects = function(self)
		if self.RecyclerEffects then
			for k, v in self.RecyclerEffects do
				v:Destroy()
			end
			self.RecyclerEffects = {}	
		end
	end,
}

TypeClass = KRB0205
