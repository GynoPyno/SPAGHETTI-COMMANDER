#
# Depth Charge Script


local TTorpedoSubProjectile = import( '/Mods/XtremWars/hook/lua/modprojectiles.lua' ).UEFTorpedo01Projectile
local VizMarker = import('/lua/sim/VizMarker.lua').VizMarker

UEFTorpedo01Projectile = Class(TTorpedoSubProjectile) {

    --CountdownLength = 10,
    FxEnterWater= { '/effects/emitters/water_splash_ripples_ring_01_emit.bp',
                    '/effects/emitters/water_splash_plume_01_emit.bp',},
	FxEnterWaterScale = 20, 

    OnCreate = function(self)
        TTorpedoSubProjectile.OnCreate(self)
    end,


    OnEnterWater = function(self)
        TTorpedoSubProjectile.OnEnterWater(self)

        local army = self:GetArmy()

        for i in self.FxEnterWater do #splash
            CreateEmitterAtEntity(self,army,self.FxEnterWater[i])
        end

        self:SetMaxSpeed(10)
        self:SetVelocity(5)
        self:SetAcceleration(10)
        self:TrackTarget(true)
        self:StayUnderwater(true)
        self:SetTurnRate(240)
        self:SetVelocityAlign(true)
        self:SetStayUpright(false)
        self:ForkThread(self.EnterWaterMovementThread)

    end,
    
    EnterWaterMovementThread = function(self)
		--WaitTicks(0.1)
		--self:SetTurnRate(20)
        self:SetStayUpright(true)
		WaitTicks(0.2)
        self:SetVelocity(5.2)
    end,

    OnLostTarget = function(self)
        self:SetLifetime(0.1)
    end,

    CountdownMovement = function(self)
        WaitSeconds(0.1)
        self:SetMaxSpeed(0)
        self:SetAcceleration(0)
        self:SetVelocity(0)
    end,

    OnImpact = function(self, TargetType, TargetEntity)
        #LOG('Projectile impacted with: ' .. TargetType)
        local pos = self:GetPosition()
        local spec = {
            X = pos[1],
            Z = pos[3],
            Radius = 30,
            LifeTime = 10,
            Omni = false,
            Vision = false,
            Army = self:GetArmy(),
        }
        local vizEntity = VizMarker(spec)
        TTorpedoSubProjectile.OnImpact(self, TargetType, TargetEntity)
    end,
}

TypeClass = UEFTorpedo01Projectile