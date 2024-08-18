#****************************************************************************
#**  File     : ura0305_collisionbeams.lua
#**  Author(s): Author(s): Resin_Smoker (Weapon Templates by:Exavier Macbeth)
#**  Copyright � 2008
#****************************************************************************

local CollisionBeam = import('/lua/sim/CollisionBeam.lua').CollisionBeam
local EffectTemplate = import('/lua/EffectTemplates.lua')
local Util = import('/lua/utilities.lua')
EmtBpPath = '/effects/emitters/'

#-----------------------------
#   Base class that defines supreme commander specific defaults
#-----------------------------
SCCollisionBeam = Class(CollisionBeam) {
    FxImpactUnit = EffectTemplate.DefaultProjectileLandUnitImpact,
    FxImpactLand = {},#EffectTemplate.DefaultProjectileLandImpact,
    FxImpactWater = EffectTemplate.DefaultProjectileWaterImpact,
    FxImpactUnderWater = EffectTemplate.DefaultProjectileUnderWaterImpact,
    FxImpactAirUnit = EffectTemplate.DefaultProjectileAirUnitImpact,
    FxImpactProp = {},
    FxImpactShield = {},    
    FxImpactNone = {},
}

#-----------------------------
#   Start Your Code Here
#-----------------------------

RetributionGreenLaserCollisionBeam = Class(SCCollisionBeam) {
    TerrainImpactType = 'LargeBeam01',
    TerrainImpactScale = 2,
    SplatTexture = 'czar_mark01_albedo',
    ScorchSplatDropTime = 0.1,

    FxBeamStartPoint = {
        '/mods/Antares Unit Pack/effects/emitters/ura0305_green_beampoint_01_emit.bp',
    },

    FxBeam = {'/mods/Antares Unit Pack/effects/emitters/ura0305_green_laser_beam_emit.bp'},

    FxBeamEndPoint = {
        '/mods/Antares Unit Pack/effects/emitters/ura0305_green_beampoint_01_emit.bp',
    },
    FxBeamEndPointScale = 2.0,

    FxImpactUnit = {
        '/mods/Antares Unit Pack/effects/emitters/ura0305_green_hit_unit_emit.bp',
        '/mods/Antares Unit Pack/effects/emitters/ura0305_beam_hit_sparks_emit.bp',
        EmtBpPath .. 'beam_hit_sparks_01_emit.bp',
        EmtBpPath .. 'beam_hit_smoke_01_emit.bp',
    },
    FxUnitHitScale = 0.5,

    FxImpactLand = {  
        EmtBpPath .. 'dirtchunks_01_emit.bp',
        EmtBpPath .. 'dust_cloud_05_emit.bp',
        EmtBpPath .. 'beam_hit_smoke_01_emit.bp',
    },
    FxLandHitScale = 2,

    OnImpact = function(self, impactType, targetEntity)
        if impactType == 'Terrain' then
            if self.Scorching == nil then
                self.Scorching = self:ForkThread( self.ScorchThread )   
            end
        elseif impactType == 'Unit' then
            if self.Scorching == nil then
                self.Scorching = self:ForkThread( self.ScorchThread )   
            end
        else
            KillThread(self.Scorching)
            self.Scorching = nil
        end
        CollisionBeam.OnImpact(self, impactType, targetEntity)
    end,
  
    OnDisable = function( self )
        CollisionBeam.OnDisable(self)
        KillThread(self.Scorching)
        self.Scorching = nil   
    end,

    ScorchThread = function(self)
        local army = self:GetArmy()
        local size = 0.25 + (Random() * 0.75) 
        local CurrentPosition = self:GetPosition(1)
        local LastPosition = Vector(0,0,0)
        local skipCount = 1
        while true do
            if Util.GetDistanceBetweenTwoVectors( CurrentPosition, LastPosition ) > 0.25 or skipCount > 100 then
                CreateSplat( CurrentPosition, Util.GetRandomFloat(0,2*math.pi), self.SplatTexture, size, size, 100, 25, army )
                LastPosition = CurrentPosition
                skipCount = 1
            else
                skipCount = skipCount + self.ScorchSplatDropTime
            end
                
            WaitSeconds( self.ScorchSplatDropTime )
            size = 0.25 + (Random() * 0.75)
            CurrentPosition = self:GetPosition(1)
        end
    end,
}


