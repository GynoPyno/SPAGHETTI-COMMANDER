#****************************************************************************
#**
#**  File     :  /cdimage/units/UEB1106/UEB1106_script.lua
#**  Author(s):  Jessica St. Croix
#**
#**  Summary  :  UEF Mass Storage
#**
#**  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TMassStorageUnit = import('/lua/terranunits.lua').TMassStorageUnit
local AdjacencyBuffs = import('/Mods/Jaggeds_Infrastructure_Pack/hook/lua/sim/AdjacencyBuffs.lua')

euebmst2 = Class(TMassStorageUnit) {

    OnStopBeingBuilt = function(self,builder,layer)
        TMassStorageUnit.OnStopBeingBuilt(self,builder,layer)
        self.Trash:Add(CreateStorageManip(self, 'Block', 'MASS', 0, 0, -0.3, 0, 0, 0))
    end,
    
    OnStartBuild = function(self, unitBeingBuilt, order )
        TMassStorageUnit.OnStartBuild(self,unitBeingBuilt, order)
        local unitid = self:GetBlueprint().General.UpgradesTo
        self.UnitBeingBuilt = unitBeingBuilt
        if unitBeingBuilt:GetUnitId() == unitid and order == 'Upgrade' then
            ChangeState(self, self.UpgradingState)
        end
    end,

    UpgradingState = State {
        Main = function(self)
            self:StopRocking()
            local bp = self:GetBlueprint().Display
            self:PlayUnitSound('UpgradeStart')
            self:DisableDefaultToggleCaps()
            if bp.AnimationUpgrade then
                local unitBuilding = self.UnitBeingBuilt
                self.AnimatorUpgradeManip = CreateAnimator(self)
                self.Trash:Add(self.AnimatorUpgradeManip)
                local fractionOfComplete = 0
                self:StartUpgradeEffects(unitBuilding)
                self.AnimatorUpgradeManip:PlayAnim(bp.AnimationUpgrade, false):SetRate(0)

                while fractionOfComplete < 1 and not self:IsDead() do
                    fractionOfComplete = unitBuilding:GetFractionComplete()
                    self.AnimatorUpgradeManip:SetAnimationFraction(fractionOfComplete)
                    WaitTicks(1)
                end
                if not self:IsDead() then
                    self.AnimatorUpgradeManip:SetRate(1)
                end
            end
        end,

        OnStopBuild = function(self, unitBuilding)
            TMassStorageUnit.OnStopBuild(self, unitBuilding)
            self:EnableDefaultToggleCaps()
            if unitBuilding:GetFractionComplete() == 1 then
                NotifyUpgrade(self, unitBuilding)
                self:StopUpgradeEffects(unitBuilding)
                self:PlayUnitSound('UpgradeEnd')
                self:Destroy()
            end
        end,

        OnFailedToBuild = function(self)
            TMassStorageUnit.OnFailedToBuild(self)
            self:EnableDefaultToggleCaps()
            self.AnimatorUpgradeManip:Destroy()
            if self:GetCurrentLayer() == 'Water' then
                self:StartRocking()
            end
            self:PlayUnitSound('UpgradeFailed')
            self:PlayActiveAnimation()
            ChangeState(self, self.IdleState)
        end,
       
    },

    StartUpgradeEffects = function(self, unitBeingBuilt)
        unitBeingBuilt:HideBone(0, true)
    end,
   
    StopUpgradeEffects = function(self, unitBeingBuilt)
        unitBeingBuilt:ShowBone(0, true)
    end, 
}

TypeClass = euebmst2