local WeaponsFile = import('/lua/terranweapons.lua')
local TAALinkedRailgun = WeaponsFile.TAALinkedRailgun
local TAAFlakArtilleryCannon = import('/lua/terranweapons.lua').TAAFlakArtilleryCannon
local TDFGaussCannonWeapon = WeaponsFile.TDFShipGaussCannonWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local utilities = import('/lua/Utilities.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')
local RandomFloat = utilities.GetRandomFloat

-- local CreateBuildCubeThread = EffectUtil.CreateBuildCubeThread
local ExternalFactoryComponent = import("/lua/defaultcomponents.lua").ExternalFactoryComponent
local AircraftCarrier = import("/lua/defaultunits.lua").AircraftCarrier

local MobileUnit = import('/lua/defaultunits.lua').MobileUnit
local explosion = import('/lua/defaultexplosions.lua')
local CreateDeathExplosion = explosion.CreateDefaultHitExplosionAtBone
local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')
local Entity = import('/lua/sim/Entity.lua').Entity
Mk56 = Class(AircraftCarrier, ExternalFactoryComponent) {

    Weapons = {
        RightAAGun01 = Class(TAALinkedRailgun) {},
        RightAAGun02 = Class(TAALinkedRailgun) {},
        AAGun = Class(TAALinkedRailgun) {},
        AAGun2 = Class(TAAFlakArtilleryCannon) {
            PlayOnlyOneSoundCue = true,
        },
        FrontTurret01 = Class(TDFGaussCannonWeapon) {},
        FrontTurret02 = Class(TDFGaussCannonWeapon) {},
        BackTurret = Class(TDFGaussCannonWeapon) {},
		},
		
    EffectsBones = {
        'Exhaust_1',
        'Exhaust_2',
        'Exhaust_3',
        'Exhaust_4',
        'Exhaust_5',
        'Exhaust_6',
        'Exhaust_7',
    },
	
    AirEffects = {'/Mods/#Marlos mods compilation/effects/emitters/02dirty_exhaust_smoke_02_emit.bp',},
	
    OnKilled = function(self, instigator, type, overkillRatio)
        ExternalFactoryComponent.OnKilled(self, instigator, type, overkillRatio)
		
		local watchBone = self:GetBlueprint().WatchBone or 0
		
        if self.SmokeEmitters then
            for k, v in self.SmokeEmitters do
                v:Destroy()
            end
            self.SmokeEmitters = nil
        end
		
        self:ForkThread(function()
            local pos = self:GetPosition()
            local seafloor = GetTerrainHeight(pos[1], pos[3]) + GetTerrainTypeOffset(pos[1], pos[3]) - 1
            while self:GetPosition(watchBone)[2] > seafloor do
                WaitSeconds(0.1)
            end
			
            self:CreateWreckage(overkillRatio, instigator)
            self:Destroy()
			self:ShakeCamera(3, 2, 0, 0.15)
        end)

        local layer = self.Layer
        self:DestroyIdleEffects()
        if layer == 'Water' or layer == 'Seabed' or layer == 'Sub' then
            self.SinkExplosionThread = self:ForkThread(self.ExplosionThread)
            self.SinkThread = self:ForkThread(self.SinkingThread)
        end

        AircraftCarrier.OnKilled(self, instigator, type, overkillRatio)
    end,
	
  --  OnMotionHorzEventChange
	OnStopBeingBuilt = function(self,builder,layer)
		local army = self:GetArmy()
		self.SmokeEmitters = {
			CreateAttachedEmitter(self,'Exhaust_1',self:GetArmy(),'/Mods/#Marlos mods compilation/effects/emitters/02dirty_exhaust_smoke_02_emit.bp'),
			CreateAttachedEmitter(self,'Exhaust_2',self:GetArmy(),'/Mods/#Marlos mods compilation/effects/emitters/02dirty_exhaust_smoke_02_emit.bp'),
			CreateAttachedEmitter(self,'Exhaust_3',self:GetArmy(),'/Mods/#Marlos mods compilation/effects/emitters/02dirty_exhaust_smoke_02_emit.bp'),
			CreateAttachedEmitter(self,'Exhaust_4',self:GetArmy(),'/Mods/#Marlos mods compilation/effects/emitters/02dirty_exhaust_smoke_02_emit.bp'),
			CreateAttachedEmitter(self,'Exhaust_5',self:GetArmy(),'/Mods/#Marlos mods compilation/effects/emitters/02dirty_exhaust_smoke_02_emit.bp'),
			CreateAttachedEmitter(self,'Exhaust_6',self:GetArmy(),'/Mods/#Marlos mods compilation/effects/emitters/02dirty_exhaust_smoke_02_emit.bp'),
			CreateAttachedEmitter(self,'Exhaust_7',self:GetArmy(),'/Mods/#Marlos mods compilation/effects/emitters/02dirty_exhaust_smoke_02_emit.bp')
		}
        AircraftCarrier.OnStopBeingBuilt(self, builder, layer)
        ExternalFactoryComponent.OnStopBeingBuilt(self, builder, layer)
        ChangeState(self, self.IdleState)
		
        -- if not self.SinkSlider then -- Setup the slider and get blueprint values
            -- self.SinkSlider = CreateSlider(self, 0, 0, 0, 0, 5, true) -- Create sink controller to overlay ontop of original collision detection
            -- self.Trash:Add(self.SinkSlider)
        -- end

        -- self.WatchDepth = false
    end,
	
    OnMotionVertEventChange = function(self, new, old)
    end,
	
  -- Factory part

    -- StartBeingBuiltEffects = function(self, builder, layer)
        -- self:SetMesh(self:GetBlueprint().Display.BuildMeshBlueprint, true)
        -- if self:GetBlueprint().General.UpgradesFrom ~= builder.UnitId then
            -- self:HideBone(0, true)
            -- self.OnBeingBuiltEffectsBag:Add(self:ForkThread(CreateBuildCubeThread, builder, self.OnBeingBuiltEffectsBag))
        -- end
    -- end,

    BuildAttachBone = 'MK56',
    FactoryAttachBone = 'ExternalFactoryPoint',

    -- OnFailedToBuild = function(self)
        -- AircraftCarrier.OnFailedToBuild(self)
        -- ChangeState(self, self.IdleState)
    -- end,

    -- IdleState = State {
        -- Main = function(self)
            -- self:DetachAll(self.BuildAttachBone)
            -- self:SetBusy(false)
        -- end,

        -- OnStartBuild = function(self, unitBuilding, order)
            -- AircraftCarrier.OnStartBuild(self, unitBuilding, order)
            -- self.UnitBeingBuilt = unitBuilding
            -- ChangeState(self, self.BuildingState)
        -- end,
    -- },

    -- BuildingState = State {
        -- Main = function(self)
            -- local unitBuilding = self.UnitBeingBuilt
            -- self:SetBusy(true)
            -- local bone = self.BuildAttachBone
            -- self:DetachAll(bone)
            -- unitBuilding:HideBone(0, true)
            -- self.UnitDoneBeingBuilt = false
        -- end,

        -- OnStopBuild = function(self, unitBeingBuilt)
            -- AircraftCarrier.OnStopBuild(self, unitBeingBuilt)
            -- ChangeState(self, self.FinishedBuildingState)
        -- end,
    -- },

    -- FinishedBuildingState = State {
        -- Main = function(self)
            -- self:SetBusy(true)
            -- local unitBuilding = self.UnitBeingBuilt
            -- unitBuilding:DetachFrom(true)
            -- self:DetachAll(self.BuildAttachBone)
            -- if self:TransportHasAvailableStorage() then
                -- self:AddUnitToStorage(unitBuilding)
            -- else
                -- local worldPos = self:CalculateWorldPositionFromRelative({0, 0, -20})
                -- IssueMoveOffFactory({unitBuilding}, worldPos)
                -- unitBuilding:ShowBone(0,true)
            -- end
            -- self:SetBusy(false)
            -- self:RequestRefreshUI()
            -- ChangeState(self, self.IdleState)
        -- end,

    OnFailedToBuild = function(self)
        AircraftCarrier.OnFailedToBuild(self)
        ChangeState(self, self.IdleState)
    end,

    OnLayerChange = function(self, new, old)
        AircraftCarrier.OnLayerChange(self, new, old)
    end,

    IdleState = State {
        Main = function(self)
            self:DetachAll(self.BuildAttachBone)
            self:SetBusy(false)
            self:OnIdle()
        end,

        OnStartBuild = function(self, unitBuilding, order)
            AircraftCarrier.OnStartBuild(self, unitBuilding, order)
            self.UnitBeingBuilt = unitBuilding
            ChangeState(self, self.BuildingState)
        end,
    },

    BuildingState = State {
        Main = function(self)
            ---@type Unit
            local unitBuilding = self.UnitBeingBuilt
            self:SetBusy(true)
            local bone = self.BuildAttachBone
            self:DetachAll(bone)
            unitBuilding:AttachTo(self, bone)
            unitBuilding:HideBone(0, true)
            self.UnitDoneBeingBuilt = false
        end,

        OnStopBuild = function(self, unitBeingBuilt)
            AircraftCarrier.OnStopBuild(self, unitBeingBuilt)
            ExternalFactoryComponent.OnStopBuildWithStorage(self, unitBeingBuilt)
        end,
    },
		
		--------------------------
		-- Create Death Effects --
		--------------------------
		
    CreateDamageEffects = function(self, bone, army)
        for k, v in EffectTemplate.DamageFireSmoke01 do
            CreateAttachedEmitter(self, bone, army, v):ScaleEmitter(2.0)
        end
    end,

    CreateDeathExplosionMiniDustRing = function(self)
        local blanketSides = 6
        local blanketAngle = (2*math.pi) / blanketSides
        local blanketStrength = 1
        local blanketVelocity = 1.8

        for i = 0, (blanketSides-1) do
            local blanketX = math.sin(i*blanketAngle)
            local blanketZ = math.cos(i*blanketAngle)

            local Blanketparts = self:CreateProjectile('/effects/entities/DestructionDust01/DestructionDust01_proj.bp', blanketX, 1.5, blanketZ + 4, blanketX, 0, blanketZ)
                :SetVelocity(blanketVelocity):SetAcceleration(-1.3)
        end
    end,
	
	CreateOvalDeathExplosionDustRing = function(self, rectWidth, rectHeight)
		local blanketSides = 32
		local blanketAngle = (2 * math.pi) / blanketSides
		local blanketVelocity = 2.9

		for i = 0, (blanketSides - 1) do
			local angle = i * blanketAngle

			-- Calculate position based on the oval shape
			local blanketX = rectWidth / 2 * math.sin(angle)
			local blanketZ = rectHeight / 2 * math.cos(angle)

			local Blanketparts = self:CreateProjectile('/effects/entities/DestructionDust01/DestructionDust01_proj.bp', blanketX, 1.5, blanketZ + 4, blanketX, 0, blanketZ)
				:SetVelocity(blanketVelocity):SetAcceleration(-0.3)
		end
	end,

    CreateFirePlumes = function(self, army, bones, yBoneOffset)
        local proj, position, offset, velocity
        local basePosition = self:GetPosition()
        for k, vBone in bones do
            position = self:GetPosition(vBone)
            offset = utilities.GetDifferenceVector(position, basePosition)
            velocity = utilities.GetDirectionVector(position, basePosition) --
            velocity.x = velocity.x + utilities.GetRandomFloat(-0.3, 0.3)
            velocity.z = velocity.z + utilities.GetRandomFloat(-0.3, 0.3)
            velocity.y = velocity.y + utilities.GetRandomFloat(0.0, 0.3)
            proj = self:CreateProjectile('/effects/entities/DestructionFirePlume01/DestructionFirePlume01_proj.bp', offset.x, offset.y + yBoneOffset, offset.z, velocity.x, velocity.y, velocity.z)
            proj:SetBallisticAcceleration(utilities.GetRandomFloat(-1, -2)):SetVelocity(utilities.GetRandomFloat(3, 4)):SetCollision(false)

            local emitter = CreateEmitterOnEntity(proj, army, '/effects/emitters/destruction_explosion_fire_plume_02_emit.bp')

            local lifetime = utilities.GetRandomFloat(12, 22)
        end
    end,

    CreateExplosionDebris = function(self, army)
        for k, v in EffectTemplate.ExplosionDebrisLrg01 do
            CreateAttachedEmitter(self, 'MK56', army, v):OffsetEmitter(0, 5, 0)
        end
    end,
	
    StarCloudDispersal = function(self)
        local numProjectiles = 12
        local angle = (2*math.pi) / numProjectiles
        local angleInitial = RandomFloat( 0, angle )
        local angleVariation = angle * 0.5
        local projectiles = {}

        local xVec = 0 
        local yVec = 0.3
        local zVec = 0
        local velocity = 0

        -- yVec -0.2, requires 2 initial velocity to start
        -- yVec 0.3, requires 3 initial velocity to start
        -- yVec 1.8, requires 8.5 initial velocity to start

        -- Launch projectiles at semi-random angles away from the sphere, with enough
        -- initial velocity to escape sphere core
        local x, y, z = self:GetPositionXYZ()
        for i = 0, (numProjectiles -1) do
            xVec = math.sin(angleInitial + (i*angle) + RandomFloat(-angleVariation, angleVariation))
            yVec = 0.3 + RandomFloat(-0.6, 0.9)
            zVec = math.cos(angleInitial + (i*angle) + RandomFloat(-angleVariation, angleVariation)) 
            velocity = 2.4 + (yVec * 3)
            table.insert(projectiles, self:CreateProjectile('/projectiles/CIFEMPFluxWarhead03/CIFEMPFluxWarhead03_proj.bp', x, y, z, xVec, yVec, zVec):SetVelocity(velocity):SetBallisticAcceleration(0.5):SetScale(0.6, 0.6, 0.6):SetLifetime(30.0) )
        end

        WaitSeconds( 3 )

        -- Slow projectiles down to normal speed
        for k, v in projectiles do
            v:SetVelocity(2):SetBallisticAcceleration(-0.15)
        end
    end,

    DeathThread = function(self)
        self:PlayUnitSound('Destroyed')
        local army = self.Army

        -- Create Initial explosion effects
        explosion.CreateFlash(self, 'MK56', 5.5, army)
        CreateAttachedEmitter(self, 'MK56', army, '/effects/emitters/destruction_explosion_concussion_ring_03_emit.bp')
		-- create an oval shaped Dust ring closely matching the ship using its hitbox demensions
        self:CreateOvalDeathExplosionDustRing(5, 10)
        self:CreateExplosionDebris(army)
        explosion.CreateFlash(self, 'Secondary_Turret11', 2.5, army)
        WaitSeconds(0.4)
        explosion.CreateFlash(self, 'Front_Turret02_Muzzle02', 2.5, army)
        WaitSeconds(0.5)
        explosion.CreateFlash(self, 'Secondary_Turret03', 2.5, army)
        CreateAttachedEmitter(self, 'Front_Turret02_Muzzle02', army, '/effects/emitters/destruction_explosion_concussion_ring_03_emit.bp')
        CreateAttachedEmitter(self, 'Attachpoint03', army, '/effects/emitters/destruction_explosion_concussion_ring_03_emit.bp')
        CreateAttachedEmitter(self,'Secondary_Turret03', army, '/effects/emitters/explosion_fire_sparks_02_emit.bp')
        CreateAttachedEmitter(self,'Secondary_Turret03', army, '/effects/emitters/explosion_fire_sparks_02_emit.bp')
        CreateAttachedEmitter(self,'Attachpoint03', army, '/effects/emitters/distortion_ring_01_emit.bp')
		
		
        explosion.CreateFlash(self, 'Front_Turret03', 3.5, army)
        -- CreateAttachedEmitter(self, 'Front_Turret03', army, '/effects/emitters/destruction_explosion_concussion_ring_03_emit.bp')
        CreateAttachedEmitter(self,'Front_Turret03', army, '/effects/emitters/explosion_fire_sparks_02_emit.bp')
        WaitSeconds(0.5)
        explosion.CreateFlash(self, 'Front_Turret01', 3.5, army)
        -- CreateAttachedEmitter(self, 'Front_Turret01', army, '/effects/emitters/destruction_explosion_concussion_ring_03_emit.bp')
        CreateAttachedEmitter(self,'Front_Turret01', army, '/effects/emitters/explosion_fire_sparks_02_emit.bp')
        WaitSeconds(0.5)
        explosion.CreateFlash(self, 'Front_Turret05', 3.5, army)
        -- CreateAttachedEmitter(self, 'Front_Turret05', army, '/effects/emitters/destruction_explosion_concussion_ring_03_emit.bp')
        CreateAttachedEmitter(self,'Front_Turret05', army, '/effects/emitters/explosion_fire_sparks_02_emit.bp')
        WaitSeconds(0.2)
        explosion.CreateFlash(self, 'Back_Turret_02', 3.5, army)
        -- CreateAttachedEmitter(self, 'Back_Turret_02', army, '/effects/emitters/destruction_explosion_concussion_ring_03_emit.bp')
        CreateAttachedEmitter(self,'Back_Turret_02', army, '/effects/emitters/explosion_fire_sparks_02_emit.bp')
        WaitSeconds(0.6)
        explosion.CreateFlash(self, 'Back_Turret_04', 3.5, army)
        -- CreateAttachedEmitter(self, 'Back_Turret_04', army, '/effects/emitters/destruction_explosion_concussion_ring_03_emit.bp')
        CreateAttachedEmitter(self,'Back_Turret_04', army, '/effects/emitters/explosion_fire_sparks_02_emit.bp')
        WaitSeconds(0.2)
        explosion.CreateFlash(self, 'Back_Turret_01', 3.5, army)
        -- CreateAttachedEmitter(self, 'Back_Turret_01', army, '/effects/emitters/destruction_explosion_concussion_ring_03_emit.bp')
        CreateAttachedEmitter(self,'Back_Turret_01', army, '/effects/emitters/explosion_fire_sparks_02_emit.bp')
		
        self:CreateFirePlumes(army, {'MK56'}, 0)
        self:CreateFirePlumes(army, {'Secondary_Turret11','Secondary_Turret02','Secondary_Turret07',}, 0.5)
        self:StarCloudDispersal()

        WaitSeconds(2)

        -- Create damage effects on turret bone
        -- CreateDeathExplosion(self, 'Front_Turret03', 1.5)
        -- self:CreateDamageEffects('Front_Turret03', army)
        -- CreateDeathExplosion(self, 'Front_Turret01', 1.5)
        -- self:CreateDamageEffects('Front_Turret01', army)
        -- CreateDeathExplosion(self, 'Front_Turret05', 1.5)
        -- self:CreateDamageEffects('Front_Turret05', army)
        -- CreateDeathExplosion(self, 'Back_Turret_02', 1.5)
        -- self:CreateDamageEffects('Back_Turret_02', army)
        -- CreateDeathExplosion(self, 'Back_Turret_04', 1.5)
        -- self:CreateDamageEffects('Back_Turret_04', army)
        self:CreateFirePlumes(army, {'Front_Turret03','Front_Turret05','Back_Turret_04',}, 0.5)
        
        WaitSeconds(1.4)
        self:ShakeCamera(10, 4, 1, 3.8)
        CreateDeathExplosion(self, 'MK56', 1)

        self:CreateExplosionDebris(army)
        self:CreateExplosionDebris(army)
        self:CreateExplosionDebris(army)
        self:CreateExplosionDebris(army)
        CreateDeathExplosion(self, 'Front_Turret03', 2)

        local x, y, z = self:GetPositionXYZ()
        DamageRing(self, {x,y,z}, 0.1, 3, 1, 'Force', true)

        -- Explosion on and damage fire on various bones
        CreateDeathExplosion(self, 'Back_Turret_0' .. Random(1,4), 0.25)
        CreateDeathExplosion(self, 'Back_Turret_02', 2)
        self:CreateFirePlumes(army, {'Back_Turret_02'}, -1)
        -- self:CreateDamageEffects('Back_Turret_02', army)
        CreateDeathExplosion(self, 'Front_Turret0' .. Random(1,3), 0.25)
        -- self:CreateDamageEffects('Front_Turret05', army)
        CreateDeathExplosion(self, 'Front_Turret05', 1)
        self:CreateExplosionDebris(army)
        CreateDeathExplosion(self, 'Back_Turret_0' .. Random(1,4), 0.25)
        -- self:CreateDamageEffects('Attachpoint01', army)
        CreateDeathExplosion(self, 'Front_Turret0' .. Random(1,3), 0.25)
        CreateDeathExplosion(self, 'MK56', 2)
        -- self:CreateDamageEffects('MK56', army)
        explosion.CreateFlash(self, 'MK56', 7, army)
    end,
}

TypeClass = Mk56