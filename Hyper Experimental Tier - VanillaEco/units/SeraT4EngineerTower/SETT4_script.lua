#****************************************************************************
#**
#**  File     :  /mods/Hyper Experimental Tier/units/SeraT4EngineerTower/SETT4_script.lua
#**  Author(s):  Dru Staltman
#**
#**  Summary  :  Alek Was Not Here
#****************************************************************************
local TPodTowerUnit = import('/lua/terranunits.lua').TPodTowerUnit

SETT4 = Class(TPodTowerUnit) {
    OnStopBeingBuilt = function(self,builder,layer)
        TPodTowerUnit.OnStopBeingBuilt(self,builder,layer)
        if not self.OpenAnim then
            self.OpenAnim = CreateAnimator(self)
            self.Trash:Add(self.OpenAnim)
        end
        self.OpenAnim:PlayAnim(self:GetBlueprint().Display.AnimationOpen, false):SetRate(0.4)
    end,
}

TypeClass = SETT4