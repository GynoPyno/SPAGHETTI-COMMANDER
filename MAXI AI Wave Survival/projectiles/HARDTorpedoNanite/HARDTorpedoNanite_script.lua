--****************************************************************************
--  File     :  /data/projectiles/HARDTorpedoNanite/HARDTorpedoNanite_script.lua
--  Author(s):  John Comes, David Tomandl, Jessica St. Croix, Gordon Duclos
--  Summary  :  Cybran Anti-Navy Nanite Torpedo Script
--                Nanite Torpedo releases tiny nanites that do DoT
--  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
--****************************************************************************
local CTorpedoShipProjectile = import("/lua/cybranprojectiles.lua").CTorpedoShipProjectile

---@class HARDTorpedoNanite : CTorpedoShipProjectile
HARDTorpedoNanite = ClassProjectile(CTorpedoShipProjectile) {
    TrailDelay = 0,

    ---@param self HARDTorpedoNanite
    ---@param inWater boolean
    OnCreate = function(self, inWater)
        CTorpedoShipProjectile.OnCreate(self, inWater)
        self.Trash:Add(ForkThread( self.MovementThread,self ))
    end,

    ---@param self HARDTorpedoNanite
    MovementThread = function(self)
        while not self:BeenDestroyed() and (self:GetDistanceToTarget() > 8) do
            WaitTicks(3)
        end
        if not self:BeenDestroyed() then
			self:ChangeMaxZigZag(0)
			self:ChangeZigZagFrequency(0)
		end
    end,

    ---@param self HARDTorpedoNanite
    GetDistanceToTarget = function(self)
        local tpos = self:GetCurrentTargetPosition()
        local mpos = self:GetPosition()
        local dist = VDist2(mpos[1], mpos[3], tpos[1], tpos[3])
        return dist
    end,

    ---@param self HARDTorpedoNanite
    OnEnterWater = function(self)
        CTorpedoShipProjectile.OnEnterWater(self)
        self:CreateImpactEffects(self.Army, self.FxEnterWater, self.FxSplashScale )
        self:StayUnderwater(true)
        self:TrackTarget(true)
        self:SetTurnRate(120)
        self:SetMaxSpeed(18)
        self:SetVelocity(3)
    end,
}
TypeClass = HARDTorpedoNanite