#
# Terran Land-Based Cruise Missile
#
local CAAMissileNaniteProjectile = import('/mods/Savers Mech Ramrod/lua/Missileprojektil.lua').CAAMissileNaniteProjectile
local EffectTemplate = import('/lua/EffectTemplates.lua')
local SingleBeamProjectile = import('/lua/sim/defaultprojectiles.lua').SingleBeamProjectile

MissileRAM = Class(CAAMissileNaniteProjectile) {

    FxTrails = EffectTemplate.TMissileExhaust01,
    FxTrailOffset = -0.8,
    
    FxAirUnitHitScale = 0.75,
    FxLandHitScale = 0.75,
    FxNoneHitScale = 0.75,
    FxPropHitScale = 0.75,
    FxProjectileHitScale = 0.75,
    FxProjectileUnderWaterHitScale = 1.75,
    FxShieldHitScale = 0.75,
    FxUnderWaterHitScale = 1.75,
    FxUnitHitScale = 0.75,
    FxWaterHitScale = 2.75,
    FxOnKilledScale = 0.75,
    
    OnCreate = function(self)
        CAAMissileNaniteProjectile.OnCreate(self)
        self:SetCollisionShape('Sphere', 0, 0, 0, 2)        
        self.MoveThread = self:ForkThread(self.MovementThread)
    end,

    MovementThread = function(self)        
        self.WaitTime = 0.1
        self.Distance = self:GetDistanceToTarget()
        self:SetTurnRate(150)
        WaitSeconds(0.3)        
        while not self:BeenDestroyed() do
            self:SetTurnRateByDist()
            WaitSeconds(self.WaitTime)
        end
    end,

    SetTurnRateByDist = function(self)
        local dist = self:GetDistanceToTarget()
        if dist > self.Distance then
        	self:SetTurnRate(150)
        	WaitSeconds(2)
        	self:SetTurnRate(100)
        	self.Distance = self:GetDistanceToTarget()
        end
        #Get the nuke as close to 90 deg as possible
        if dist > 50 then        
            #Freeze the turn rate as to prevent steep angles at long distance targets
            WaitSeconds(2)
            self:SetTurnRate(150)
        elseif dist > 30 and dist <= 50 then
						# Increase check intervals
						self:SetTurnRate(12)
						WaitSeconds(1.5)
            self:SetTurnRate(12)
        elseif dist > 10 and dist <= 25 then
						# Further increase check intervals
            WaitSeconds(0.3)
            self:SetTurnRate(150)
				elseif dist > 0 and dist <= 10 then
						# Further increase check intervals            
            self:SetTurnRate(100)   
            KillThread(self.MoveThread)         
        end
    end,        

    GetDistanceToTarget = function(self)
        local tpos = self:GetCurrentTargetPosition()
        local mpos = self:GetPosition()
        local dist = VDist2(mpos[1], mpos[3], tpos[1], tpos[3])
        return dist
    end,
        
    OnImpact = function(self, targetType, targetEntity)
        local army = self:GetArmy()
        SingleBeamProjectile.OnImpact(self, targetType, targetEntity)
    end,
}
TypeClass = MissileRAM

