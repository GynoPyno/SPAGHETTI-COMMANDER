#
# Cybran "Loa" Tactical Missile, mobile unit launcher variant of this missile,
# lower and straighter trajectory. Splits into child projectile if it takes enough
# damage.
#
local CLOATacticalMissileProjectile = import('/lua/cybranprojectiles.lua').CLOATacticalMissileProjectile

MBeetleMissileTactical01 = Class(CLOATacticalMissileProjectile) {

    OnCreate = function(self)
        CLOATacticalMissileProjectile.OnCreate(self)
        #self:SetCollisionShape('Sphere', 0, 0, 0, 2)
        self.MoveThread = self:ForkThread(self.MovementThread)
    end,

    MovementThread = function(self)        
        self.WaitTime = 0.1
        self.Distance = self:GetDistanceToTarget()
        self:SetTurnRate(8)
        WaitSeconds(0.3)        
        while not self:BeenDestroyed() do
            self:SetTurnRateByDist()
            WaitSeconds(self.WaitTime)
        end
    end,

    SetTurnRateByDist = function(self)
        local dist = self:GetDistanceToTarget()
        if dist > self.Distance then
        	self:SetTurnRate(40)
        	WaitSeconds(1.5)
        	#self:SetTurnRate(8)
        	self.Distance = self:GetDistanceToTarget()
        end
        if dist > 25 then        
            #Freeze the turn rate as to prevent steep angles at long distance targets
            WaitSeconds(1)
            self:SetTurnRate(30)
        elseif dist > 15 and dist <= 25 then
						self:SetTurnRate(12)
						WaitSeconds(0.5)
            self:SetTurnRate(12)
        elseif dist > 5 and dist <= 10 then
            WaitSeconds(0.1)
            self:SetTurnRate(50)
				elseif dist > 0 and dist <= 10 then       
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
    
}
TypeClass = MBeetleMissileTactical01

