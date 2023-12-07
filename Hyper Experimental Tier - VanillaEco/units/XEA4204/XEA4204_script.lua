-----------------------------------------------------------------
-- File     :  /mods/Hyper Experimetnal Tier/units/XEA4204/XEA4204_script.lua
-- Author(s):  Alek Was Here
-- Summary  :  Scooby Den Unit
-----------------------------------------------------------------

local SEnergyBallUnit = import('/lua/seraphimunits.lua').SEnergyBallUnit


XEA4204 = Class(SEnergyBallUnit) {
    OnCreate = function(self)
        SEnergyBallUnit.OnCreate(self)
        self.docked = true
    end,

    SetParent = function(self, parent, podName)
        self.Parent = parent
        self.PodName = podName
        self:SetCreator(parent)
    end,

    OnKilled = function(self, instigator, type, overkillRatio)
        if self.Parent and not self.Parent.Dead then
            self.Parent:NotifyOfPodDeath(self.PodName)
            self.Parent = nil
        end
        SEnergyBallUnit.OnKilled(self, instigator, type, overkillRatio)
    end,

    OnStartBuild = function(self, unitBeingBuilt, order)
        SEnergyBallUnit.OnStartBuild(self, unitBeingBuilt, order)
    end,

    OnStopBuild = function(self, unitBuilding)
        SEnergyBallUnit.OnStopBuild(self, unitBuilding)
    end,

    OnFailedToBuild = function(self)
        SEnergyBallUnit.OnFailedToBuild(self)
    end,

    -- Don't make wreckage
    CreateWreckage = function (self, overkillRatio)
        overkillRatio = 1.1
        SEnergyBallUnit.CreateWreckage(self, overkillRatio)
    end,
}

TypeClass = XEA4204
