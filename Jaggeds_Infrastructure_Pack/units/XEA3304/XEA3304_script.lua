local TConstructionUnit = import("/lua/terranunits.lua").TConstructionUnit

---@class XEA3304 : TConstructionUnit
XEA3304 = ClassUnit(TConstructionUnit) {
    OnCreate = function(self)
        TConstructionUnit.OnCreate(self)
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
        TConstructionUnit.OnKilled(self, instigator, type, overkillRatio)
    end,

    OnStartBuild = function(self, unitBeingBuilt, order)
        TConstructionUnit.OnStartBuild(self, unitBeingBuilt, order)
    end,

    OnStopBuild = function(self, unitBuilding)
        TConstructionUnit.OnStopBuild(self, unitBuilding)
    end,

    OnFailedToBuild = function(self)
        TConstructionUnit.OnFailedToBuild(self)
    end,

    -- Don't make wreckage
    CreateWreckage = function (self, overkillRatio)
        overkillRatio = 1.1
        TConstructionUnit.CreateWreckage(self, overkillRatio)
    end,
}

TypeClass = XEA3304