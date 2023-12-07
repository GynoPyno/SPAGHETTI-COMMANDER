#****************************************************************************
#**
#**  File     :  /data/projectiles/SIFInainoStrategicMissile02/SIFInainoStrategicMissile02_script.lua
#**  Author(s):  Gordon Duclos, Matt Vainio
#**
#**  Summary  :  Inaino Strategic Missile Projectile script, XSS0302
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local SIFInainoStrategicMissile = import('/lua/seraphimprojectiles.lua').SIFInainoStrategicMissile

SIFInainoStrategicMissile02 = Class(SIFInainoStrategicMissile) {

    FxSplashScale = 0.5,
    FxTrails = {},

    LaunchSound = 'Nuke_Launch',
    ExplodeSound = 'Nuke_Impact',
    AmbientSound = 'Nuke_Flight',

	InitialEffects = {
		'/effects/emitters/seraphim_inaino_fxtrails_01_emit.bp',
		'/effects/emitters/seraphim_inaino_fxtrails_02_emit.bp',
	},    
    ThrustEffects = {
		'/effects/emitters/seraphim_inaino_fxtrails_01_emit.bp',
		'/effects/emitters/seraphim_inaino_fxtrails_02_emit.bp',
	},
    LaunchEffects = {
		'/effects/emitters/seraphim_inaino_fxtrails_01_emit.bp',
		'/effects/emitters/seraphim_inaino_fxtrails_02_emit.bp',
	},
    
    OnCreate = function(self)
        SIFInainoStrategicMissile.OnCreate(self)
        local launcher = self:GetLauncher()
        if launcher and not launcher:IsDead() and launcher.EventCallbacks.ProjectileDamaged then
            self.ProjectileDamaged = {}
            for k,v in launcher.EventCallbacks.ProjectileDamaged do
                table.insert( self.ProjectileDamaged, v )
            end
        end 
        self:SetCollisionShape('Sphere', 0, 0, 0, 2.0)
        self.MovementTurnLevel = 1
        self:ForkThread( self.MovementThread )
    end,    

    OnImpact = function(self, TargetType, TargetEntity)
        if not TargetEntity or not EntityCategoryContains(categories.PROJECTILE, TargetEntity) then
            # Play the explosion sound
            local myBlueprint = self:GetBlueprint()
            if myBlueprint.Audio.Explosion then
                self:PlaySound(myBlueprint.Audio.Explosion)
            end
    
            nukeProjectile = self:CreateProjectile('/effects/entities/InainoEffectController01/InainoEffectController01_proj.bp', 0, 0, 0, nil, nil, nil):SetCollision(false)
            nukeProjectile:PassData(self.Data)
        end
        SIFInainoStrategicMissile.OnImpact(self, TargetType, TargetEntity)
    end,

    DoTakeDamage = function(self, instigator, amount, vector, damageType)
        if self.ProjectileDamaged then
            for k,v in self.ProjectileDamaged do
                v(self)
            end
        end
        SIFInainoStrategicMissile.DoTakeDamage(self, instigator, amount, vector, damageType)
    end,

    CreateEffects = function( self, EffectTable, army, scale)
        for k, v in EffectTable do
            self.Trash:Add(CreateAttachedEmitter(self, -1, army, v):ScaleEmitter(scale))
        end
    end,

    MovementThread = function(self)
        local army = self:GetArmy()
        local launcher = self:GetLauncher()
        self.CreateEffects( self, self.InitialEffects, army, 1 )
        self:TrackTarget(false)
        WaitSeconds(10)
        self:SetCollision(true)
        self.CreateEffects( self, self.LaunchEffects, army, 1 )
        WaitSeconds(3)
        self:SetTurnRate(5)
        self.CreateEffects( self, self.ThrustEffects, army, 3 )
        WaitSeconds(6)
        self:TrackTarget(true)
        self:SetDestroyOnWater(true)
        self:SetTurnRate(50)
        WaitSeconds(1.95)
        self:SetBallisticAcceleration(10)
        while not self:BeenDestroyed() do
            self:SetTurnRateByDist()
            WaitSeconds(0.5)
        end
    end,

    SetTurnRateByDist = function(self)
        local dist = self:GetDistanceToTarget()
        #Get the nuke as close to 90 deg as possible
        if dist > 100 and self.MovementTurnLevel < 2 then
            #Freeze the turn rate as to prevent steep angles at long distance targets
            self:SetTurnRate(0)
            self.MovementTurnLevel = 1
        elseif dist > 85 and dist <= 100 and self.MovementTurnLevel < 3 then
            self:SetTurnRate(30)
            self.MovementTurnLevel = 2
        elseif dist > 40 and dist <= 85 and self.MovementTurnLevel < 4 then
            self:SetTurnRate(40)
            self.MovementTurnLevel = 3
        elseif dist < 40 then
            self:SetTurnRate(40)
            self.MovementTurnLevel = 4
        end
    end,

    GetDistanceToTarget = function(self)
        local tpos = self:GetCurrentTargetPosition()
        local mpos = self:GetPosition()
        local dist = VDist2(mpos[1], mpos[3], tpos[1], tpos[3])
        return dist
    end,

}

TypeClass = SIFInainoStrategicMissile02
