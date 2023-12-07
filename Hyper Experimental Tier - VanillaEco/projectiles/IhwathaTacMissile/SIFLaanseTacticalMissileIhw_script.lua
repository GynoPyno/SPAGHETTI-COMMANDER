#****************************************************************************
#**
#**  File     :  /mods/Hyper Experimental Tier/projectile/IhwathaTacMisile/SIFLaanseTacticalMissileIhw_script.lua
#**  Author(s):   Cmd Draven
#**
#**  Summary  :  Laanse Tactical Missile Projectile script, T5SN0402
#**
#****************************************************************************

local SLaanseWathTacticalMissile = import('/mods/Hyper Experimental Tier/hook/lua/SProjectiles.lua').SLaanseWathTacticalMissile

SIFLaanseWathTacticalMissile = Class(SLaanseWathTacticalMissile) {

    OnCreate = function(self)
        SLaanseWathTacticalMissile.OnCreate(self)
        self:SetCollisionShape('Sphere', 0, 0, 0, 2)
        self.MoveThread = self:ForkThread(self.MovementThread)
    end,

    MovementThread = function(self)
        self.WaitTime = 0.1
        self:SetTurnRate(8)
        WaitSeconds(0.3)
        while not self:BeenDestroyed() do
            self:SetTurnRateByDist()
            self:SetDestroyOnWater(false)
            WaitSeconds(self.WaitTime)
        end
    end,

    SetTurnRateByDist = function(self)
        local dist = self:GetDistanceToTarget()
        #Get the nuke as close to 90 deg as possible
        if dist > 50 then
            #Freeze the turn rate as to prevent steep angles at long distance targets
            WaitSeconds(2)
            self:SetTurnRate(10)
        elseif dist > 30 and dist <= 50 then
			# Increase check intervals
			self:SetTurnRate(12)
			WaitSeconds(1.5)
            self:SetTurnRate(12)
        elseif dist > 10 and dist <= 25 then
			# Further increase check intervals
            WaitSeconds(0.3)
            self:SetTurnRate(25)
		elseif dist > 0 and dist <= 10 then
			# Further increase check intervals
            self:SetTurnRate(50)
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
TypeClass = SIFLaanseWathTacticalMissile

