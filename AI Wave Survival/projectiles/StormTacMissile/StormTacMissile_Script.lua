#****************************************************************************
#**
#**  File     :  /data/projectiles/SIFLaanseTacticalMissile04/SIFLaanseTacticalMissile04_script.lua
#**  Author(s):  Gordon Duclos, Aaron Lundquist
#**
#**  Summary  :  Laanse Tactical Missile Projectile script, XSB2108
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local SLaanseTacticalMissile = import('/lua/seraphimprojectiles.lua').SLaanseTacticalMissile
local utilities = import('/lua/utilities.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')

StormTacMissile = Class(SLaanseTacticalMissile) {

	DestroyOnImpact = false,
	 
    
    OnCreate = function(self)
        SLaanseTacticalMissile.OnCreate(self)
        self:SetCollisionShape('Sphere', 0, 0, 0, 2.0)
		MissileArmy = self:GetArmy()
        self:ForkThread( self.MovementThread )
    end,

    MovementThread = function(self)        
        self.WaitTime = 0.1
        self:SetTurnRate(8)
        WaitSeconds(0.3)        
        while not self:BeenDestroyed() do
            self:SetTurnRateByDist()
            WaitSeconds(self.WaitTime)
        end
		
    end,
		
    SetTurnRateByDist = function(self)
        local dist = self:GetDistanceToTarget()
        #Get the nuke as close to 90 deg as possible
        if dist > 50 then        
            #Freeze the turn rate as to prevent steep angles at long distance targets
            WaitSeconds(2)
            self:SetTurnRate(20)
        elseif dist > 128 and dist <= 213 then
						# Increase check intervals
						self:SetTurnRate(30)
						WaitSeconds(1.5)
            self:SetTurnRate(30)
        elseif dist > 43 and dist <= 107 then
						# Further increase check intervals
            WaitSeconds(0.3)
            self:SetTurnRate(50)
				elseif dist > 0 and dist <= 43 then
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
	
	OnImpact = function(self, TargetType, targetEntity)
		
		SLaanseTacticalMissile.OnImpact( self, TargetType, targetEntity )
		local position = self:GetPosition()
		local spiritUnit = CreateUnitHPR('SPIRIT0402', self:GetArmy(), position[1], position[2], position[3], 0, 0, 0)
		local spiritUnit = CreateUnitHPR('SPIRIT0402', self:GetArmy(), position[1], position[2], position[3], 0, 0, 0)
		if Random(1, 2) == 1 then
			local spiritUnit = CreateUnitHPR('SPIRIT0402', self:GetArmy(), position[1], position[2], position[3], 0, 0, 0)
		end
		if Random(1, 8) == 5 then
			local spiritUnit = CreateUnitHPR('SPIRIT0402', self:GetArmy(), position[1], position[2], position[3], 0, 0, 0)
		end
		self:Destroy()
	end,
	
	OnKilled = function(self)
		local position = self:GetPosition()
		local spiritUnit = CreateUnitHPR('SPIRIT0402', self:GetArmy(), position[1], position[2], position[3], 0, 0, 0)
		if Random(1, 3) == 2 then
			local spiritUnit = CreateUnitHPR('SPIRIT0402', self:GetArmy(), position[1], position[2], position[3], 0, 0, 0)
		end
		self:Destroy()
	end,
	
}
TypeClass = StormTacMissile

