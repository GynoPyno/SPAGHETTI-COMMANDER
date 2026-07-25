--------------------------------------------------------------------------------
-- Auto reclaimer script
-- Totally rewritten by Balthazar
--------------------------------------------------------------------------------
local CConstructionStructureUnit = import('/lua/cybranunits.lua').CConstructionStructureUnit
local EffectUtil = import('/Mods/#Marlos mods compilation/lua/MKEffectUtillities.lua')

KRB0205 = Class(CConstructionStructureUnit) {

    RecycleEffectBones = { 'arm_fl', 'arm_fr', 'arm_cl', 'arm_cr', 'arm_bl', 'arm_br' },

    RecycleEffects = {
        'aim', '/Mods/#Marlos mods compilation/effects/emitters/cybran_recycler_01_rings_emit.bp',
        'aim', '/Mods/#Marlos mods compilation/effects/emitters/cybran_recycler_06_top_electricity_emit.bp',
        'shaft_spin', '/Mods/#Marlos mods compilation/effects/emitters/cybran_recycler_04_debris_ring_emit.bp',
        'shaft_spin', '/Mods/#Marlos mods compilation/effects/emitters/cybran_recycler_03_line_emit.bp'
    },

    OnStopBeingBuilt = function(self, builder, layer)
        CConstructionStructureUnit.OnStopBeingBuilt(self)
        self.CachePosition = self.CachePosition or self:GetPosition()
        self.Trash:Add( self:ForkThread(self.RecycleWatch) )
        self:InitRecyclerEffects()
    end,

    CreateReclaimEffects = function( self, target )
		EffectUtil.PlayReclaimEffects( self, target, self:GetBlueprint().General.BuildBones.BuildEffectBones or {0,}, self.ReclaimEffectsBag )
    end,

	RecycleWatch = function(self)
        local Brain = self:GetAIBrain()
        local Army = self:GetArmy()
        -- local bp = __blueprints.krb0205.Economy.MaxBuildDistance or 48 -- gets broken when using a build range multiplier mod, so we set a hard limit
        local bp = 48
        local bpSq = bp * bp
        local function ShouldDoReclaim()
            --NOTE: Script bits are true when toggled off
            return (not self:GetScriptBit('RULEUTC_ProductionToggle')) and Brain:GetEconomyStoredRatio('MASS') < 0.9
        end

        while self and not self.Dead do
            if ShouldDoReclaim() then
    			local posX, _, posZ = unpack(self.CachePosition)

                for i, targ in GetReclaimablesInRect(posX - bp, posZ - bp, posX + bp, posZ + bp) do
                    if targ then
                        targetX, _, targetZ = targ:GetPositionXYZ()
                        if VDist2Sq(posX, posZ, targetX, targetZ) <= bpSq then
                            --Exclude uncapturable units and allied units
                            if not ( IsUnit(targ) and ( not targ:IsCapturable() or IsAlly(Army, targ:GetArmy() ) ) ) then
                                IssueReclaim({self}, targ)
                            end
                        end
                    end
                end
            else
                IssueClearCommands({self})
				coroutine.yield(21)
            end
			coroutine.yield(21)
        end
    end,

    OnProductionPaused = function(self)
        CConstructionStructureUnit.OnProductionPaused(self)
        IssueClearCommands({self})
    end,

    OnStartReclaim = function( self, target )
    	CConstructionStructureUnit.OnStartReclaim( self, target )
		local posX, _, posZ = unpack(self.CachePosition)
		local targetX, _, targetZ = target:GetPositionXYZ()
		-- local bp = __blueprints.krb0205.Economy.MaxBuildDistance or 48 -- gets broken when using a build range multiplier mod, so we set a hard limit
        local bp = 48
        local bpSq = bp * bp
		if VDist2Sq(posX, posZ, targetX, targetZ) > bpSq then
			IssueClearCommands({self})
		end
    	self:SetRecyclerEffects(true)
    end,

    OnStopReclaim = function( self, target )
    	CConstructionStructureUnit.OnStopReclaim( self, target )
    	self:SetRecyclerEffects(false)
    end,

    InitRecyclerEffects = function(self)
        self.Trash:Add(
            CreateAttachedEmitter(
                self, 0, self:GetArmy(),
                '/effects/emitters/aeon_t3power_ambient_01_emit.bp'
            )
            :OffsetEmitter(0.2, -0.1, 0)
            :ScaleEmitter(0.45)
        )

		self.ShaftSpinner = CreateRotator( self, 'shaft_spin', 'x', nil, 0, 45 )
		self.ShaftSlider = CreateSlider( self, 'shaft', -30, 0, 0, 25, false )

		self.ArmRotators = {}

		for i, v in self.RecycleEffectBones do
			table.insert( self.ArmRotators, {
                Rotator = CreateRotator(self, v, 'x', --[[AngleOff =]] 0, 30, 30, 90),
                AngleOn = -55,
                AngleOff = 0
            })
		end
    end,

    SetRecyclerEffects = function(self, bToggle)
		for i, v in self.ArmRotators do
			v.Rotator:SetGoal( bToggle and v.AngleOn or v.AngleOff )
		end
		self.ShaftSpinner:SetTargetSpeed( bToggle and 180 or 0 )
		self.ShaftSlider:SetGoal( (bToggle and 0 or -30), 0, 0 )

        if bToggle then
			self:CreateRecyclerEffects()
    	else
    		self:DestroyRecyclerEffects()
    	end
    end,

    CreateRecyclerEffects = function(self)
        if not self.RecyclerEffectsBag then
            self.RecyclerEffectsBag = {}
        end
        local army = self:GetArmy()
        for i = 1, table.getn(self.RecycleEffects) * 0.5 do
            local i2 = i * 2
			table.insert(
                self.RecyclerEffectsBag,
                CreateAttachedEmitter(
                    self,
                    self.RecycleEffects[i2-1],
                    army,
                    self.RecycleEffects[i2]
                )
            )
        end
    end,

    DestroyRecyclerEffects = function(self)
        if self.RecyclerEffectsBag then
            for k, v in self.RecyclerEffectsBag do
                v:Destroy()
            end
            self.RecyclerEffectsBag = nil
        end
    end,
}

TypeClass = KRB0205
