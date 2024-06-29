--[[#######################################################################
#  File     :  /hook/lua/defaultcollisionbeams.lua
#  Author(s):  Gordon Duclos
#  Summary  :  default collision beams
#  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#######################################################################]]--

MicrowaveLaserCollisionBeam01 = Class( SCCollisionBeam ) {

    TerrainImpactType = 'LargeBeam01',
    TerrainImpactScale = 1,
    FxBeamStartPoint = EffectTemplate.CMicrowaveLaserMuzzle01,
    FxBeam = { '/effects/emitters/microwave_laser_beam_01_emit.bp' },
    FxBeamEndPoint = EffectTemplate.CMicrowaveLaserEndPoint01,
    SplatTexture = 'czar_mark01_albedo',
    ScorchSplatDropTime = 0.25,

    OnImpact = function( self, impactType, targetEntity )
        if impactType == 'Terrain' then
            if self.Scorching == nil then
                self.Scorching = self:ForkThread( self.ScorchThread )   
            end
        elseif not impactType == 'Unit' then
            KillThread( self.Scorching )
            self.Scorching = nil
        end
        CollisionBeam.OnImpact( self, impactType, targetEntity )
    end,

    OnDisable = function( self )
        CollisionBeam.OnDisable( self )
        KillThread( self.Scorching )
        self.Scorching = nil   
    end,

    ScorchThread = function(self)
        local army = self:GetArmy()
        local size = 1.5 + ( Random() * 1.5 ) 
        local CurrentPosition = self:GetPosition(1)
        local LastPosition = Vector(0,0,0)
        local skipCount = 1
        while true do
            if Util.GetDistanceBetweenTwoVectors( CurrentPosition, LastPosition ) > 0.25 or skipCount > 100 then
                CreateSplat( CurrentPosition, Util.GetRandomFloat(0,2*math.pi), self.SplatTexture, size, size, 100, 100, army )
                LastPosition = CurrentPosition
                skipCount = 1
            else
                skipCount = skipCount + self.ScorchSplatDropTime
            end
                
            WaitSeconds( self.ScorchSplatDropTime )
            size = 1.2 + ( Random() * 1.5 )
            CurrentPosition = self:GetPosition( 1 )
        end
    end,
}

MicrowaveLaserCollisionBeam02 = Class( MicrowaveLaserCollisionBeam01 ) {
    TerrainImpactScale = 5,
	FxBeamStartPointScale = 5,
	FxBeamEndPointScale = 5,
	FxBeamScale = 5,
    FxBeamStartPoint = EffectTemplate.CMicrowaveLaserMuzzle01,
    FxBeam = { '/mods/XtremWars/effects/emitters/microwave_laser_beam_03_emit.bp' },
    FxBeamEndPoint = EffectTemplate.CMicrowaveLaserEndPoint01,

}

MicrowaveLaserCollisionBeam03 = Class( MicrowaveLaserCollisionBeam01 ) {
    TerrainImpactScale = 0.1,
	FxBeamStartPointScale = 0.1,
	FxBeamEndPointScale = 0.1,
	FxBeamScale = 0.1,
    FxBeamStartPoint = EffectTemplate.CMicrowaveLaserMuzzle01,
    FxBeam = { '/Mods/XtremWars/effects/emitters/microwave_laser_beam_04_emit.bp' },
    FxBeamEndPoint = EffectTemplate.CMicrowaveLaserEndPoint01,
    
	OnImpact = function( self, impactType, targetEntity )
        if impactType == 'Terrain' then
            if self.Scorching == nil then
                self.Scorching = self:ForkThread( self.ScorchThread )   
            end
        elseif not impactType == 'Unit' then
            KillThread( self.Scorching )
            self.Scorching = nil
        end
        CollisionBeam.OnImpact( self, impactType, targetEntity )
    end,

    OnDisable = function( self )
        CollisionBeam.OnDisable( self )
        KillThread( self.Scorching )
        self.Scorching = nil   
    end,

    ScorchThread = function(self)
        local army = self:GetArmy()
        local size = 0.1 + ( Random() * 0.1 ) 
        local CurrentPosition = self:GetPosition( 1 )
        local LastPosition = Vector( 0, 0, 0 )
        local skipCount = 1
        while true do
            if Util.GetDistanceBetweenTwoVectors( CurrentPosition, LastPosition ) > 0.25 or skipCount > 100 then
                CreateSplat( CurrentPosition, Util.GetRandomFloat(0,2*math.pi), self.SplatTexture, size, size, 100, 100, army )
                LastPosition = CurrentPosition
                skipCount = 1
            else
                skipCount = skipCount + self.ScorchSplatDropTime
            end
                
            WaitSeconds( self.ScorchSplatDropTime )
            size = 0.1 + ( Random() * 0.1 )
            CurrentPosition = self:GetPosition( 1 )
        end
    end,
}

TractorClawCollisionBeam = Class( CollisionBeam ) {
    
    FxBeam = { EffectTemplate.ACollossusTractorBeam01 },
    FxBeamEndPoint = { EffectTemplate.ACollossusTractorBeamGlow02 },
    FxBeamEndPointScale = 1.0,
    FxBeamStartPoint = { EffectTemplate.ACollossusTractorBeamGlow01 },
}

TractorClawCollisionBeam02 = Class( CollisionBeam ) {
    
    FxBeam = { EffectTemplate.ACollossusTractorBeam01 },
    FxBeamEndPoint = { EffectTemplate.ACollossusTractorBeamGlow02 },
    FxBeamEndPointScale = 2.0,
    FxBeamStartPoint = { EffectTemplate.ACollossusTractorBeamGlow01 },
}



