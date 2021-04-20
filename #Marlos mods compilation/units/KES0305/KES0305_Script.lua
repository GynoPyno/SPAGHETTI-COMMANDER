
local TSeaUnit = import('/lua/terranunits.lua').TSeaUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local TAALinkedRailgun = WeaponsFile.TAALinkedRailgun
local TAAFlakArtilleryCannon = import('/lua/terranweapons.lua').TAAFlakArtilleryCannon
local TDFGaussCannonWeapon = WeaponsFile.TDFShipGaussCannonWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local utilities = import('/lua/Utilities.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')

local CreateBuildCubeThread = EffectUtil.CreateBuildCubeThread

local MobileUnit = import('/lua/defaultunits.lua').MobileUnit
local explosion = import('/lua/defaultexplosions.lua')
local CreateDeathExplosion = explosion.CreateDefaultHitExplosionAtBone
local EffectTemplate = import('/lua/EffectTemplates.lua')
local utilities = import('/lua/Utilities.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')
local Entity = import('/lua/sim/Entity.lua').Entity
Mk56 = Class(TSeaUnit) {


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
	
  --  OnMotionHorzEventChange
	OnStopBeingBuilt = function(self,builder,layer)
		local army = self:GetArmy()
		CreateAttachedEmitter(self,'Exhaust_1',self:GetArmy(),'/Mods/#Marlos mods compilation/effects/emitters/02dirty_exhaust_smoke_02_emit.bp')
		CreateAttachedEmitter(self,'Exhaust_2',self:GetArmy(),'/Mods/#Marlos mods compilation/effects/emitters/02dirty_exhaust_smoke_02_emit.bp')
		CreateAttachedEmitter(self,'Exhaust_3',self:GetArmy(),'/Mods/#Marlos mods compilation/effects/emitters/02dirty_exhaust_smoke_02_emit.bp')
		CreateAttachedEmitter(self,'Exhaust_4',self:GetArmy(),'/Mods/#Marlos mods compilation/effects/emitters/02dirty_exhaust_smoke_02_emit.bp')
		CreateAttachedEmitter(self,'Exhaust_5',self:GetArmy(),'/Mods/#Marlos mods compilation/effects/emitters/02dirty_exhaust_smoke_02_emit.bp')
		CreateAttachedEmitter(self,'Exhaust_6',self:GetArmy(),'/Mods/#Marlos mods compilation/effects/emitters/02dirty_exhaust_smoke_02_emit.bp')
		CreateAttachedEmitter(self,'Exhaust_7',self:GetArmy(),'/Mods/#Marlos mods compilation/effects/emitters/02dirty_exhaust_smoke_02_emit.bp')
        TSeaUnit.OnStopBeingBuilt(self,builder,layer)
        ChangeState(self, self.IdleState)
    end,
	
	
  -- Factory part

    StartBeingBuiltEffects = function(self, builder, layer)
		self:SetMesh(self:GetBlueprint().Display.BuildMeshBlueprint, true)
        if self:GetBlueprint().General.UpgradesFrom != builder:GetUnitId() then
			self:HideBone(0, true)        
            self.OnBeingBuiltEffectsBag:Add( self:ForkThread( CreateBuildCubeThread, builder, self.OnBeingBuiltEffectsBag ))
        end
    end,

    BuildAttachBone = 'MK56',

    OnFailedToBuild = function(self)
        TSeaUnit.OnFailedToBuild(self)
        ChangeState(self, self.IdleState)
    end,

    IdleState = State {
        Main = function(self)
            self:DetachAll(self.BuildAttachBone)
            self:SetBusy(false)
        end,

        OnStartBuild = function(self, unitBuilding, order)
            TSeaUnit.OnStartBuild(self, unitBuilding, order)
            self.UnitBeingBuilt = unitBuilding
            ChangeState(self, self.BuildingState)
        end,
    },

    BuildingState = State {
        Main = function(self)
            local unitBuilding = self.UnitBeingBuilt
            self:SetBusy(true)
            local bone = self.BuildAttachBone
            self:DetachAll(bone)
            unitBuilding:HideBone(0, true)
            self.UnitDoneBeingBuilt = false
        end,

        OnStopBuild = function(self, unitBeingBuilt)
            TSeaUnit.OnStopBuild(self, unitBeingBuilt)
            ChangeState(self, self.FinishedBuildingState)
        end,
    },

    FinishedBuildingState = State {
        Main = function(self)
            self:SetBusy(true)
            local unitBuilding = self.UnitBeingBuilt
            unitBuilding:DetachFrom(true)
            self:DetachAll(self.BuildAttachBone)
            if self:TransportHasAvailableStorage() then
                self:AddUnitToStorage(unitBuilding)
            else
                local worldPos = self:CalculateWorldPositionFromRelative({0, 0, -20})
                IssueMoveOffFactory({unitBuilding}, worldPos)
                unitBuilding:ShowBone(0,true)
            end
            self:SetBusy(false)
            self:RequestRefreshUI()
            ChangeState(self, self.IdleState)
        end,
		
		
		
		
		
		--------------------------
		-- Create Death Effects --
		--------------------------
		
    CreateDamageEffects = function(self, bone, army)
        for k, v in EffectTemplate.DamageFireSmoke01 do
            CreateAttachedEmitter(self, bone, army, v):ScaleEmitter(2.0)
        end
    end,

    CreateDeathExplosionDustRing = function(self)
        local blanketSides = 18
        local blanketAngle = (2*math.pi) / blanketSides
        local blanketStrength = 1
        local blanketVelocity = 2.8

        for i = 0, (blanketSides-1) do
            local blanketX = math.sin(i*blanketAngle)
            local blanketZ = math.cos(i*blanketAngle)

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

    DeathThread = function(self)
        self:PlayUnitSound('Destroyed')
        local army = self.Army

        -- Create Initial explosion effects
        explosion.CreateFlash(self, 'Secondary_Turret11', 4.5, army)
        explosion.CreateFlash(self, 'Front_Turret02_Muzzle02', 4.5, army)
        explosion.CreateFlash(self, 'Secondary_Turret03', 4.5, army)
        CreateAttachedEmitter(self, 'Front_Turret02_Muzzle02', army, '/effects/emitters/destruction_explosion_concussion_ring_03_emit.bp')
        CreateAttachedEmitter(self, 'Attachpoint03', army, '/effects/emitters/destruction_explosion_concussion_ring_03_emit.bp')
        CreateAttachedEmitter(self,'Secondary_Turret03', army, '/effects/emitters/explosion_fire_sparks_02_emit.bp')
        CreateAttachedEmitter(self,'Secondary_Turret03', army, '/effects/emitters/explosion_fire_sparks_02_emit.bp')
        CreateAttachedEmitter(self,'Attachpoint03', army, '/effects/emitters/distortion_ring_01_emit.bp')
		
        explosion.CreateFlash(self, 'Front_Turret03', 4.5, army)
        CreateAttachedEmitter(self, 'Front_Turret03', army, '/effects/emitters/destruction_explosion_concussion_ring_03_emit.bp')
        CreateAttachedEmitter(self,'Front_Turret03', army, '/effects/emitters/explosion_fire_sparks_02_emit.bp')
        explosion.CreateFlash(self, 'Front_Turret01', 4.5, army)
        CreateAttachedEmitter(self, 'Front_Turret01', army, '/effects/emitters/destruction_explosion_concussion_ring_03_emit.bp')
        CreateAttachedEmitter(self,'Front_Turret01', army, '/effects/emitters/explosion_fire_sparks_02_emit.bp')
        explosion.CreateFlash(self, 'Front_Turret05', 4.5, army)
        CreateAttachedEmitter(self, 'Front_Turret05', army, '/effects/emitters/destruction_explosion_concussion_ring_03_emit.bp')
        CreateAttachedEmitter(self,'Front_Turret05', army, '/effects/emitters/explosion_fire_sparks_02_emit.bp')
        explosion.CreateFlash(self, 'Back_Turret_02', 4.5, army)
        CreateAttachedEmitter(self, 'Back_Turret_02', army, '/effects/emitters/destruction_explosion_concussion_ring_03_emit.bp')
        CreateAttachedEmitter(self,'Back_Turret_02', army, '/effects/emitters/explosion_fire_sparks_02_emit.bp')
        explosion.CreateFlash(self, 'Back_Turret_04', 4.5, army)
        CreateAttachedEmitter(self, 'Back_Turret_04', army, '/effects/emitters/destruction_explosion_concussion_ring_03_emit.bp')
        CreateAttachedEmitter(self,'Back_Turret_04', army, '/effects/emitters/explosion_fire_sparks_02_emit.bp')
        explosion.CreateFlash(self, 'Back_Turret_01', 4.5, army)
        CreateAttachedEmitter(self, 'Back_Turret_01', army, '/effects/emitters/destruction_explosion_concussion_ring_03_emit.bp')
        CreateAttachedEmitter(self,'Back_Turret_01', army, '/effects/emitters/explosion_fire_sparks_02_emit.bp')
		
        self:CreateFirePlumes(army, {'MK56'}, 0)

        self:CreateFirePlumes(army, {'Secondary_Turret11','Secondary_Turret02','Secondary_Turret07',}, 0.5)

        self:CreateExplosionDebris(army)
        self:CreateExplosionDebris(army)
        self:CreateExplosionDebris(army)

        WaitSeconds(1)

        -- Create damage effects on turret bone
        CreateDeathExplosion(self, 'Front_Turret03', 1.5)
        self:CreateDamageEffects('Front_Turret03', army)
        self:CreateDamageEffects('Front_Turret03', army)
        CreateDeathExplosion(self, 'Front_Turret01', 1.5)
        self:CreateDamageEffects('Front_Turret01', army)
        self:CreateDamageEffects('Front_Turret01', army)
        CreateDeathExplosion(self, 'Front_Turret05', 1.5)
        self:CreateDamageEffects('Front_Turret05', army)
        self:CreateDamageEffects('Front_Turret05', army)
        CreateDeathExplosion(self, 'Back_Turret_02', 1.5)
        self:CreateDamageEffects('Back_Turret_02', army)
        self:CreateDamageEffects('Back_Turret_02', army)
        CreateDeathExplosion(self, 'Back_Turret_04', 1.5)
        self:CreateDamageEffects('Back_Turret_04', army)
        self:CreateDamageEffects('Back_Turret_04', army)

        WaitSeconds(1)
        self:CreateFirePlumes(army, {'Front_Turret03','Front_Turret05','Back_Turret_04',}, 0.5)
        WaitSeconds(0.4)
        self:CreateDeathExplosionDustRing()
        
        WaitSeconds(0.4)


        -- When the spider bot impacts with the ground
        -- Effects: Explosion on turret, dust effects on the muzzle tip, large dust ring around unit
        -- Other: Damage force ring to force trees over and camera shake
        self:ShakeCamera(40, 4, 1, 3.8)
        CreateDeathExplosion(self, 'Left_Turret_Barrel', 1)

        self:CreateExplosionDebris(army)
        self:CreateExplosionDebris(army)
        self:CreateExplosionDebris(army)
        self:CreateExplosionDebris(army)

        WaitSeconds(0.5)
        CreateDeathExplosion(self, 'Front_Turret03', 2)

        -- Finish up force ring to push trees
        DamageRing(self, {x,y,z}, 0.1, 3, 1, 'Force', true)

        -- Explosion on and damage fire on various bones
        CreateDeathExplosion(self, 'Back_Turret_' .. Random(1,4), 0.25)
        CreateDeathExplosion(self, 'Back_Turret_02', 2)
        self:CreateFirePlumes(army, {'Back_Turret_02'}, -1)
        self:CreateDamageEffects('Back_Turret_02', army)
        WaitSeconds(0.5)

        CreateDeathExplosion(self, 'Front_Turret_' .. Random(1,4), 0.25)
        self:CreateDamageEffects('Front_Turret05', army)
        WaitSeconds(0.5)
        CreateDeathExplosion(self, 'Front_Turret05', 1)
        self:CreateExplosionDebris(army)

        CreateDeathExplosion(self, 'Back_Turret_' .. Random(1,4), 0.25)
        self:CreateDamageEffects('Torpedo_Muzzle01', army)
        WaitSeconds(0.5)

        CreateDeathExplosion(self, 'Front_Turret_' .. Random(1,4), 0.25)
        CreateDeathExplosion(self, 'MK56', 2)
        self:CreateDamageEffects('MK56', army)
        explosion.CreateFlash(self, 'MK56', 7, army)

        -- WaitSeconds(0.5)
        -- self:CreateWreckage(0.1)
        self:ShakeCamera(3, 2, 0, 0.15)
        self:Destroy()
    end,
		
    },
}

TypeClass = Mk56