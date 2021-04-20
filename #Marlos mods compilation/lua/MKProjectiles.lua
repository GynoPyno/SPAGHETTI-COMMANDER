local Projectile = import('/lua/sim/projectile.lua').Projectile
local DefaultProjectileFile = import('/lua/sim/defaultprojectiles.lua')
local EmitterProjectile = DefaultProjectileFile.EmitterProjectile
local OnWaterEntryEmitterProjectile = DefaultProjectileFile.OnWaterEntryEmitterProjectile
local SingleBeamProjectile = DefaultProjectileFile.SingleBeamProjectile
local SinglePolyTrailProjectile = DefaultProjectileFile.SinglePolyTrailProjectile
local MultiPolyTrailProjectile = DefaultProjectileFile.MultiPolyTrailProjectile
local SingleCompositeEmitterProjectile = DefaultProjectileFile.SingleCompositeEmitterProjectile
local Explosion = import('/lua/defaultexplosions.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectTemplate2 = import('/Mods/#Marlos mods compilation/lua/MKEffectTemplates.lua')
local DepthCharge = import('/lua/defaultantiprojectile.lua').DepthCharge
local util = import('/lua/utilities.lua')
EmtBpPath = '/Mods/#Marlos mods compilation/effects/emitters/'



TArtilleryAntiMatterProjectile05 = Class(SinglePolyTrailProjectile) {
    FxLandHitScale = 1,
    FxUnitHitScale = 0.4,
    FxSplatScale = 5,
	PolyTrail = '/effects/emitters/default_polytrail_07_emit.bp',
	
    # Hit Effects
    FxImpactUnit = EffectTemplate.TAntiMatterShellHit02,
    FxImpactLand = EffectTemplate.TAntiMatterShellHit02,
    FxImpactProp = EffectTemplate.TAntiMatterShellHit02,
    FxImpactWater = EffectTemplate2.DefaultProjectileWaterImpact,
    FxSplatScale = 5,
	
    OnImpact = function(self, targetType, targetEntity)
        local army = self:GetArmy()
        #CreateLightParticle( self, -1, army, 16, 6, 'glow_03', 'ramp_antimatter_02' )
        if targetType == 'Terrain' then
            CreateDecal( self:GetPosition(), util.GetRandomFloat(0,2*math.pi), 'nuke_scorch_001_normals', '', 'Alpha Normals', self.FxSplatScale, self.FxSplatScale, 150, 30, army )
            CreateDecal( self:GetPosition(), util.GetRandomFloat(0,2*math.pi), 'nuke_scorch_002_albedo', '', 'Albedo', self.FxSplatScale * 2, self.FxSplatScale * 2, 150, 30, army )
            self:ShakeCamera(20, 1, 0, 1)
        end
        local pos = self:GetPosition()
        DamageArea(self, pos, self.DamageData.DamageRadius, 1, 'Force', true)
        DamageArea(self, pos, self.DamageData.DamageRadius, 1, 'Force', true)
        EmitterProjectile.OnImpact(self, targetType, targetEntity)
    end,
}

TArtilleryNuclearProjectile = Class(SinglePolyTrailProjectile) {
	FxImpactTrajectoryAligned = false,
    PolyTrail = '/effects/emitters/antimatter_polytrail_01_emit.bp',
    PolyTrailOffset = 0,

    # Hit Effects
    FxImpactUnit = EffectTemplate2.TAntiNuclearshellHit01,
    FxImpactProp = EffectTemplate2.TAntiNuclearshellHit01,
    FxImpactLand = EffectTemplate2.TAntiNuclearshellHit01,
    FxLandHitScale = 1,
    FxImpactUnderWater = {},
    FxSplatScale = 8,

    OnImpact = function(self, targetType, targetEntity)
        local army = self:GetArmy()
        if targetType == 'Terrain' then
            CreateDecal( self:GetPosition(), util.GetRandomFloat(0,2*math.pi), 'nuke_scorch_001_normals', '', 'Alpha Normals', self.FxSplatScale, self.FxSplatScale, 150, 50, army )
            CreateDecal( self:GetPosition(), util.GetRandomFloat(0,2*math.pi), 'nuke_scorch_002_albedo', '', 'Albedo', self.FxSplatScale * 2, self.FxSplatScale * 2, 150, 50, army )
            self:ShakeCamera(20, 1, 0, 1)
        end
        local pos = self:GetPosition()
        DamageArea(self, pos, self.DamageData.DamageRadius, 1, 'Force', true)
        DamageArea(self, pos, self.DamageData.DamageRadius, 1, 'Force', true)
        EmitterProjectile.OnImpact(self, targetType, targetEntity)
    end,
}

TFragmentationGrenadeMK02 = Class(EmitterProjectile) {
    FxImpactUnit = EffectTemplate2.THeavyFragmentationGrenadeHitMK,
    FxImpactLand = EffectTemplate2.THeavyFragmentationGrenadeHitMK,
    FxImpactWater = EffectTemplate2.THeavyFragmentationGrenadeHitMK,
    FxImpactNone = EffectTemplate2.THeavyFragmentationGrenadeHitMK,
    FxImpactProp = EffectTemplate2.THeavyFragmentationGrenadeHitMK,
    FxImpactUnderWater = {},
    FxTrails= EffectTemplate.THeavyFragmentationGrenadeFxTrails,
    #PolyTrail= EffectTemplate.THeavyFragmentationGrenadePolyTrail,
}

CHeavyLaserProjectileMK = Class(MultiPolyTrailProjectile) {
    PolyTrails = {
        '/Mods/#Marlos mods compilation/effects/emitters/cybran_laser_trail_MK_emit.bp',
        '/Mods/#Marlos mods compilation/effects/emitters/default_polytrail_MK_emit.bp',
    },
    PolyTrailOffset = {0,0},

    # Hit Effects
    FxImpactUnit = EffectTemplate.AMissileHit01,
    FxImpactProp = EffectTemplate.AMissileHit01,
    FxImpactLand = EffectTemplate.AMissileHit01,
    FxImpactUnderWater = {},
}

CHeavyLaserProjectileMK2 = Class(MultiPolyTrailProjectile) {
    PolyTrails = {
        '/Mods/#Marlos mods compilation/effects/emitters/cybran_laser_trail_MK2_emit.bp',
        '/Mods/#Marlos mods compilation/effects/emitters/default_polytrail_MK2_emit.bp',
    },
    PolyTrailOffset = {0,0},

    # Hit Effects
    FxImpactUnit = EffectTemplate.AMissileHit01,
    FxImpactProp = EffectTemplate.AMissileHit01,
    FxImpactLand = EffectTemplate.AMissileHit01,
    FxImpactUnderWater = {},
}

CHeavyLaserProjectileMK3 = Class(MultiPolyTrailProjectile) {
    PolyTrails = {
        '/Mods/#Marlos mods compilation/effects/emitters/cybran_laser_trail_MK3.bp',
        '/Mods/#Marlos mods compilation/effects/emitters/default_polytrail_MK3.bp',
    },
    PolyTrailOffset = {0,0},

    # Hit Effects
    FxImpactUnit = EffectTemplate.AMissileHit01,
    FxImpactProp = EffectTemplate.AMissileHit01,
    FxImpactLand = EffectTemplate.AMissileHit01,
    FxImpactUnderWater = {},
}

AMissileAAProjectileMK = Class(SinglePolyTrailProjectile) {
    PolyTrail = '/effects/emitters/aeon_missile_trail_01_emit.bp',

    FxImpactUnit = EffectTemplate.AMissileHit01,
    FxImpactAirUnit = EffectTemplate.AMissileHit01,
    FxImpactProp = EffectTemplate.AMissileHit01,
    FxImpactNone = EffectTemplate.AMissileHit01,
    FxImpactLand = EffectTemplate.AMissileHit01,
    FxImpactUnderWater = {},
}

MKIridiumRocketProjectile = Class(SingleCompositeEmitterProjectile) {
    FxTrails = {},
	PolyTrail = '/Mods/#Marlos mods compilation/effects/emitters/MK_iridium_missile_polytrail_01_emit.bp',    
    BeamName = '/Mods/#Marlos mods compilation/effects/emitters/MK_iridium_exhaust_beam_01_emit.bp',
    FxImpactUnit = EffectTemplate2.MKMissileHit02a,
    FxImpactProp = EffectTemplate2.MKMissileHit02a,
    FxImpactLand = EffectTemplate2.MKMissileHit02a,
    FxImpactUnderWater = {},
}

TMastodonMKProjectile = Class(SingleCompositeEmitterProjectile) {
    FxTrails = {},
	PolyTrail = '/Mods/#Marlos mods compilation/effects/emitters/MK_iridium_missile_polytrail_02_emit.bp',    
    BeamName = '/Mods/#Marlos mods compilation/effects/emitters/MK_iridium_exhaust_beam_01_emit.bp',
    FxImpactUnit = EffectTemplate2.MKMissileHit02b,
    FxImpactProp = EffectTemplate2.MKMissileHit02b,
    FxImpactLand = EffectTemplate2.MKMissileHit02b,
    FxImpactUnderWater = {},
}

TDFGaussCannonProjectile = Class(MultiPolyTrailProjectile) {
    PolyTrails = {
    EmtBpPath .. 'w_u_gau03_p_01_polytrails_emit.bp',
    EmtBpPath .. 'w_u_gau03_p_02_polytrails_emit.bp',
    EmtBpPath .. 'gauss_cannon_munition_trail_03_emit.bp',
    },
    PolyTrailOffset = {0,0},
    FxImpactUnit = EffectTemplate.TGaussCannonHitUnit01,
    FxImpactProp = EffectTemplate.TGaussCannonHitUnit01,
    FxImpactLand = EffectTemplate.TGaussCannonHitLand01,
    FxImpactUnderWater = {},
}