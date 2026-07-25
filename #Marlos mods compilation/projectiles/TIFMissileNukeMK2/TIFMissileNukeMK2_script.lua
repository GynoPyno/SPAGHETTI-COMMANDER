#
# Terran Nuke Missile
#
local TIFMissileNuke = import('/lua/terranprojectiles.lua').TIFMissileNuke

TIFMissileNukeCDR = Class(TIFMissileNuke) {

    OnCreate = function(self)
        TIFMissileNuke.OnCreate(self)
        self.effectEntityPath = '/effects/Entities/SCUDeath01/SCUDeath01_proj.bp'
        self:LauncherCallbacks()
    end,
	
    OnEnterWater = function(self)
        TIFMissileNuke.OnEnterWater(self)
        self:SetDestroyOnWater(true)
    end,

}

TypeClass = TIFMissileNukeCDR
