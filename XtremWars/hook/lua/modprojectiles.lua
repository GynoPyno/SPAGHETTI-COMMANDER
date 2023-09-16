--[[#######################################################################
#  File     :  /hook/lua/modprojectiles.lua
#  Author(s):  John Comes, Gordon Duclos
#  Summary  :  PROJECTILES SCRIPTS
#  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#######################################################################]]--

local DefaultProjectileFile = import('/lua/sim/defaultprojectiles.lua')
local EmitterProjectile = DefaultProjectileFile.EmitterProjectile
local MultiPolyTrailProjectile = DefaultProjectileFile.MultiPolyTrailProjectile
local OnWaterEntryEmitterProjectile = DefaultProjectileFile.OnWaterEntryEmitterProjectile
local SingleBeamProjectile = DefaultProjectileFile.SingleBeamProjectile
local SingleCompositeEmitterProjectile = DefaultProjectileFile.SingleCompositeEmitterProjectile
local SinglePolyTrailProjectile = DefaultProjectileFile.SinglePolyTrailProjectile
local Projectile = import('/lua/sim/projectile.lua').Projectile
local util = import('/lua/utilities.lua')
local GetRandomFloat = util.GetRandomFloat
local EffectTemplate = import('/lua/EffectTemplates.lua')

AIMBombExpe01 = Class(EmitterProjectile) {
    FxTrails = EffectTemplate.AAntiMissileFlare,
    FxTrailScale = 5.0,
    FxImpactUnit = EffectTemplate.ABombHit01,
    FxImpactAirUnit = EffectTemplate.ABombHit01,
    FxImpactNone = EffectTemplate.ABombHit01,
    FxImpactProjectile = EffectTemplate.ABombHit01,
    FxOnKilled = EffectTemplate.ABombHit01,
    FxUnitHitScale = 4.4,
    FxLandHitScale = 4.4,
    FxWaterHitScale = 4.4,
    FxUnderWaterHitScale = 4.4,
    FxAirUnitHitScale = 4.4,
    FxNoneHitScale = 4.4,
    FxImpactLand = {},
    FxImpactUnderWater = {},
    DestroyOnImpact = false,

    OnImpact = function(self, TargetType, targetEntity)
        EmitterProjectile.OnImpact(self, TargetType, targetEntity)
        if TargetType == 'Terrain' or TargetType == 'Water' or TargetType == 'Prop' then
            if self.Trash then
                self.Trash:Destroy()
            end
            self:Destroy()
        end
    end,
}

TDFAntiShipGaussCannonProjectile = Class(MultiPolyTrailProjectile) {
	FxImpactTrajectoryAligned = false,
    FxTrails = {},
    PolyTrails = EffectTemplate.TGaussCannonPolyTrail,
    PolyTrailOffset = {0,0},
    FxUnitHitScale = 0.5,
    FxImpactUnit = EffectTemplate.TGaussCannonHitUnit01,
    FxImpactProp = EffectTemplate.WaterSplash01,
    FxImpactWater = EffectTemplate.WaterSplash01,
	FxImpactWaterScale = 1.6, 
    FxTrailOffset = 0,
    FxImpactUnderWater = {},
}

TNextWarsCarpetBombProjectile = Class(SinglePolyTrailProjectile) {
    FxTrails = {},
    
	FxProjectileHitScale = 5,
	FxPropHitScale = 5,
    FxUnitHitScale = 5,
	FxWaterHitScale = 5,
	FxOnKilledScale = 5,
	
    FxImpactTrajectoryAligned = false,

    # Hit Effects
    FxImpactUnit = EffectTemplate.TLandGaussCannonHitUnit01,
    FxImpactProp = EffectTemplate.TLandGaussCannonHit01,
    FxImpactLand = EffectTemplate.TLandGaussCannonHit01,
    FxImpactWater = EffectTemplate.TTorpedoHitUnit01,
	FxImpactWaterUnit = EffectTemplate.TTorpedoHitUnit01,
    FxImpactUnderWater = {},
    PolyTrail = '/effects/emitters/default_polytrail_01_emit.bp',
}


UEFTorpedo01Projectile = Class(OnWaterEntryEmitterProjectile) {
    FxInitial = {},
    FxTrails = {'/effects/emitters/torpedo_underwater_wake_01_emit.bp',},
	FxTrailScale = 10,
    FxImpactLand = {},
	
	FxProjectileHitScale = 1.5,
	FxPropHitScale = 1.5,
    FxUnitHitScale = 1.5,
	FxWaterHitScale = 1.5,
	FxUnderWaterHitScale = 1.5,
	FxOnKilledScale = 2,
	
    FxImpactUnit = EffectTemplate.TTorpedoHitUnit01,
    FxImpactProp = EffectTemplate.TTorpedoHitUnit01,
	FxImpactWater = EffectTemplate.TTorpedoHitUnit01,
	FxImpactWaterUnit = EffectTemplate.TTorpedoHitUnit01,
    FxImpactUnderWater = EffectTemplate.TTorpedoHitUnit01,
	FxImpactProjectile = EffectTemplate.TTorpedoHitUnit01,
    FxImpactProjectileUnderWater = EffectTemplate.TTorpedoHitUnit01,
    FxImpactNone = {},
	
	OnCreate = function(self, inWater)
        self:SetCollisionShape('Sphere', 0, 0, 0, 1.0)
        OnWaterEntryEmitterProjectile.OnCreate(self, inWater)
    end,
}

TATMachineGunProjectile = Class(SinglePolyTrailProjectile) {
    PolyTrail = EffectTemplate.TMachineGunPolyTrail,
    FxTrails = {},
    
	# Hit Effects
    FxImpactLand = {},
    FxHitScale = 1.25,
    FxImpactUnit = EffectTemplate.TTorpedoHitUnit01,
    FxImpactProp = EffectTemplate.TTorpedoHitUnit01,
    FxImpactUnderWater = EffectTemplate.TTorpedoHitUnit01,
	FxImpactWater = EffectTemplate.TTorpedoHitUnit01,
    FxImpactProjectile = EffectTemplate.TTorpedoHitUnit01,
    FxImpactNone = {},
    FxEnterWater= EffectTemplate.WaterSplash01,



    
}

UEFTorpedoe01Projectile = Class(OnWaterEntryEmitterProjectile) {
    FxInitial = {},
    FxTrails = {'/effects/emitters/torpedo_underwater_wake_01_emit.bp',},
	FxTrailScale = 5,
    TrailDelay = 0,

    # Hit Effects
    FxImpactLand = {},
    FxUnitHitScale = 1.25,
    FxImpactUnit = EffectTemplate.TTorpedoHitUnit01,
    FxImpactProp = EffectTemplate.TTorpedoHitUnit01,
    FxImpactUnderWater = EffectTemplate.TTorpedoHitUnitUnderwater01,
    FxImpactNone = {},
    FxEnterWater= EffectTemplate.WaterSplash01,

    OnCreate = function(self, inWater)
        OnWaterEntryEmitterProjectile.OnCreate(self)
        if inWater == true then
            self:TrackTarget(true):StayUnderwater(true)
            self:OnEnterWater(self)
        end
    end,

    OnEnterWater = function(self)
        OnWaterEntryEmitterProjectile.OnEnterWater(self)
        self:SetCollisionShape('Sphere', 0, 0, 0, 1.0)
        local army = self:GetArmy()

        for k, v in self.FxEnterWater do #splash
            CreateEmitterAtEntity(self,army,v)
        end
        self:TrackTarget(true)
        self:StayUnderwater(true)
        self:SetTurnRate(120)
        self:SetMaxSpeed(18)
        #self:SetVelocity(0)
        self:ForkThread(self.MovementThread)
    end,
    
    MovementThread = function(self)
        WaitTicks(1)
        self:SetVelocity(3)
    end,
}

TArtilleryAntiMatterSmallProjectile = Class(SinglePolyTrailProjectile) {
	PolyTrail = '/effects/emitters/default_polytrail_07_emit.bp',

    # Hit Effects
    FxImpactUnit = EffectTemplate.TShipGaussCannonHitUnit01,
    FxImpactProp = EffectTemplate.TShipGaussCannonHit01,
    FxImpactLand = EffectTemplate.TShipGaussCannonHit01,
    FxLandHitScale = 1.5,
	FxUnitHitScale = 1.5,
	FxPropHitScale = 1.5,
    FxImpactUnderWater = {},
    FxSplatScale = 1.8,

    OnImpact = function(self, targetType, targetEntity)
        local army = self:GetArmy()
        if targetType == 'Terrain' then
            CreateDecal( self:GetPosition(), util.GetRandomFloat(0,2*math.pi), 'nuke_scorch_001_normals', '', 'Alpha Normals', self.FxSplatScale, self.FxSplatScale, 150, 50, army )
            CreateDecal( self:GetPosition(), util.GetRandomFloat(0,2*math.pi), 'nuke_scorch_002_albedo', '', 'Albedo', self.FxSplatScale * 2, self.FxSplatScale * 2, 150, 50, army )
            --self:ShakeCamera(20, 1, 0, 1)
        end
        local pos = self:GetPosition()
        DamageArea(self, pos, self.DamageData.DamageRadius, 1, 'Force', true)
		DamageArea(self, pos, self.DamageData.DamageRadius, 1, 'Force', true)
        EmitterProjectile.OnImpact(self, targetType, targetEntity)
    end,
}

CEMPMissileProjectile = Class(SingleCompositeEmitterProjectile) {
    # Emitter Values
    FxInitial = {},
    TrailDelay = 1,
	FxTrailScale = 5,
    FxTrails = {'/effects/emitters/missile_sam_munition_trail_01_emit.bp',},
    FxTrailOffset = -0.1,

    BeamName = '/effects/emitters/missile_sam_munition_exhaust_beam_01_emit.bp',

    # Hit Effects
    FxUnitHitScale = 2,
    FxImpactUnit = EffectTemplate.CMissileHit01,
    FxImpactProp = EffectTemplate.CMissileHit01,    
    FxLandHitScale = 2,
    FxImpactLand = EffectTemplate.CMissileHit01,
    FxImpactUnderWater = {},

    OnCreate = function(self)
        self:SetCollisionShape('Sphere', 0, 0, 0, 1.0)
        SingleBeamProjectile.OnCreate(self)
    end,
}
