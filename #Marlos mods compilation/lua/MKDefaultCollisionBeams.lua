
-- MK Collision Beams for new beam weapons 

local CollisionBeam = import('/lua/sim/CollisionBeam.lua').CollisionBeam
local EffectTemplate = import('/lua/EffectTemplates.lua')
local Util = import('/lua/utilities.lua')
local EffectTemplate2 = import('/Mods/#Marlos mods compilation/lua/MKEffectTemplates.lua')


MKCollisionBeam = Class(CollisionBeam) {
    FxImpactUnit = EffectTemplate.DefaultProjectileLandUnitImpact,
    FxImpactWater = EffectTemplate.DefaultProjectileWaterImpact,
    FxImpactUnderWater = EffectTemplate.DefaultProjectileUnderWaterImpact,
    FxImpactAirUnit = EffectTemplate.DefaultProjectileAirUnitImpact,
    FxImpactLand = {},
    FxImpactProp = {},
    FxImpactShield = {},
    FxImpactNone = {},
}

DreadnoughtLaserCollisionBeam = Class(MKCollisionBeam) {
    TerrainImpactType = 'LargeBeam01',
    TerrainImpactScale = 0.5,
    FxBeamStartPoint = EffectTemplate.APhasonLaserMuzzle01,
    FxBeam = {'/mods/#Marlos mods compilation/effects/emitters/Dreadnought_laser_beam_01_emit.bp'},
    FxBeamStartPointScale = 0.3,
    FxBeamEndPoint = EffectTemplate.APhasonLaserImpact01,
    FxBeamEndPointScale = 0.4,
    SplatTexture = 'czar_mark01_albedo',
    ScorchSplatDropTime = 0.25,

    OnImpact = function(self, impactType, targetEntity)
        if impactType == 'Terrain' and not impactType == 'Water' then
            if self.Scorching == nil then
                self.Scorching = self:ForkThread(self.ScorchThread)
            end
        elseif not impactType == 'Unit' then
            KillThread(self.Scorching)
            self.Scorching = nil
        end
        CollisionBeam.OnImpact(self, impactType, targetEntity)
    end,

    OnDisable = function(self)
        CollisionBeam.OnDisable(self)
        KillThread(self.Scorching)
        self.Scorching = nil
    end,

    ScorchThread = function(self)
        local army = self:GetArmy()
        local size = 1.4 + (Random() * 1.4)
        local CurrentPosition = self:GetPosition(1)
        local LastPosition = Vector(0,0,0)
        local skipCount = 1
        while true do
            if Util.GetDistanceBetweenTwoVectors(CurrentPosition, LastPosition) > 0.25 or skipCount > 100 then
                CreateSplat(CurrentPosition, Util.GetRandomFloat(0,3*math.pi), self.SplatTexture, size, size, 100, 100, army)
                LastPosition = CurrentPosition
                skipCount = 1
            else
                skipCount = skipCount + self.ScorchSplatDropTime
            end

            WaitSeconds(self.ScorchSplatDropTime)
            size = 1.2 + (Random() * 1.4)
            CurrentPosition = self:GetPosition(1)
        end
    end,
}

BeamtankCollisionBeam = Class(MKCollisionBeam) {
    TerrainImpactType = 'LargeBeam01',
    TerrainImpactScale = 0.5,
    FxBeamStartPoint = EffectTemplate.APhasonLaserMuzzle01,
    FxBeam = {'/mods/#Marlos mods compilation/effects/emitters/Dreadnought_laser_beam_02_emit.bp'},
    FxBeamStartPointScale = 0.3,
    FxBeamEndPoint = EffectTemplate.APhasonLaserImpact01,
    FxBeamEndPointScale = 0.4,
    SplatTexture = 'czar_mark01_albedo',
    ScorchSplatDropTime = 0.25,

    OnImpact = function(self, impactType, targetEntity)
        if impactType == 'Terrain' and not impactType == 'Water' then
            if self.Scorching == nil then
                self.Scorching = self:ForkThread(self.ScorchThread)
            end
        elseif not impactType == 'Unit' then
            KillThread(self.Scorching)
            self.Scorching = nil
        end
        CollisionBeam.OnImpact(self, impactType, targetEntity)
    end,

    OnDisable = function(self)
        CollisionBeam.OnDisable(self)
        KillThread(self.Scorching)
        self.Scorching = nil
    end,

    ScorchThread = function(self)
        local army = self:GetArmy()
        local size = 1.4 + (Random() * 1.4)
        local CurrentPosition = self:GetPosition(1)
        local LastPosition = Vector(0,0,0)
        local skipCount = 1
        while true do
            if Util.GetDistanceBetweenTwoVectors(CurrentPosition, LastPosition) > 0.25 or skipCount > 100 then
                CreateSplat(CurrentPosition, Util.GetRandomFloat(0,3*math.pi), self.SplatTexture, size, size, 100, 100, army)
                LastPosition = CurrentPosition
                skipCount = 1
            else
                skipCount = skipCount + self.ScorchSplatDropTime
            end

            WaitSeconds(self.ScorchSplatDropTime)
            size = 1.2 + (Random() * 1.4)
            CurrentPosition = self:GetPosition(1)
        end
    end,
}

ColossusLaserCollisionBeam = Class(MKCollisionBeam) {
    TerrainImpactType = 'LargeBeam01',
    TerrainImpactScale = 0.5,
    FxBeamStartPoint = EffectTemplate2.AColossusLaserMuzzle01,
    FxBeam = {'/mods/#Marlos mods compilation/effects/emitters/Colossus_laser_beam_01_emit.bp'},
    FxBeamStartPointScale = 0.3,
    FxBeamEndPoint = EffectTemplate2.AColossusLaserImpact01,
    FxBeamEndPointScale = 0.7,
    SplatTexture = 'czar_mark01_albedo',
    ScorchSplatDropTime = 0.25,

    OnImpact = function(self, impactType, targetEntity)
        if impactType == 'Terrain' and not impactType == 'Water' then
            if self.Scorching == nil then
                self.Scorching = self:ForkThread(self.ScorchThread)
            end
        elseif not impactType == 'Unit' then
            KillThread(self.Scorching)
            self.Scorching = nil
        end
        CollisionBeam.OnImpact(self, impactType, targetEntity)
    end,

    OnDisable = function(self)
        CollisionBeam.OnDisable(self)
        KillThread(self.Scorching)
        self.Scorching = nil
    end,

    ScorchThread = function(self)
        local army = self:GetArmy()
        local size = 1.4 + (Random() * 1.4)
        local CurrentPosition = self:GetPosition(1)
        local LastPosition = Vector(0,0,0)
        local skipCount = 1
        while true do
            if Util.GetDistanceBetweenTwoVectors(CurrentPosition, LastPosition) > 0.25 or skipCount > 100 then
                CreateSplat(CurrentPosition, Util.GetRandomFloat(0,3*math.pi), self.SplatTexture, size, size, 100, 100, army)
                LastPosition = CurrentPosition
                skipCount = 1
            else
                skipCount = skipCount + self.ScorchSplatDropTime
            end

            WaitSeconds(self.ScorchSplatDropTime)
            size = 1.2 + (Random() * 1.4)
            CurrentPosition = self:GetPosition(1)
        end
    end,
}