#
# Terran CDR Nuke
#
local TIFMissileNuke = import('/lua/terranprojectiles.lua').TIFMissileNuke

TIFMissileNukeCDR = Class(TIFMissileNuke) {
  
    BeamName = '/effects/emitters/missile_exhaust_fire_beam_06_emit.bp',
    InitialEffects = {'/effects/emitters/nuke_munition_launch_trail_02_emit.bp',},
    LaunchEffects = {
        '/effects/emitters/nuke_munition_launch_trail_03_emit.bp',
        '/effects/emitters/nuke_munition_launch_trail_05_emit.bp',
    },
	ThrustEffects = {'/effects/emitters/nuke_munition_launch_trail_04_emit.bp',},

    OnCreate = function(self)
        TIFMissileNuke.OnCreate(self)
        self.effectEntityPath = '/effects/Entities/SCUDeath01/SCUDeath01_proj.bp'
        self:LauncherCallbacks()
    end,

    MovementThread = function(self)        
        self.WaitTime = 0.1
        self:SetTurnRate(0)
        WaitSeconds(0.3)        
        while not self:BeenDestroyed() do
            self:SetTurnRateByDist()
            WaitSeconds(self.WaitTime)
        end
    end,

    DoDamage = function(self, instigator, DamageData, targetEntity)
        local nukeDamage = function(self, instigator, pos, brain, army, damageType)
            if self.TotalTime == 0 then
                DamageArea(instigator, pos, self.Radius, self.Damage, (damageType or 'Nuke'), true, true)
            end
        end

        TIFMissileNuke.DoDamage(self, instigator, DamageData, targetEntity)
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

    OnEnterWater = function(self)
        TIFMissileNuke.OnEnterWater(self)
        self:SetDestroyOnWater(true)
    end,
}
TypeClass = TIFMissileNukeCDR

