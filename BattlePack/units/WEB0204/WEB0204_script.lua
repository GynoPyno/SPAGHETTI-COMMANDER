#****************************************************************************
#**
#**  File     :  /units/XEB0204/XEB0204_script.lua
#**  Author(s):  Dru Staltman
#**
#**  Summary  :  UEF Engineering tower
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local TPodTowerUnit = import('/lua/terranunits.lua').TPodTowerUnit

WEB0204 = Class(TPodTowerUnit) {
    OnStopBeingBuilt = function(self,builder,layer)
        TPodTowerUnit.OnStopBeingBuilt(self,builder,layer)
        if not self.OpenAnim then
            self.OpenAnim = CreateAnimator(self)
            self.Trash:Add(self.OpenAnim)
        end
        self.OpenAnim:PlayAnim(self:GetBlueprint().Display.AnimationOpen, false):SetRate(0.4)
		
		if not self:IsDead() then
           local myOrientation = self:GetOrientation()
           local location = self:GetPosition()
           local health = self:GetHealth()
           local FactoryB = CreateUnit('xeb0204', self:GetArmy(), location[1], location[2], location[3], myOrientation[1], myOrientation[2], myOrientation[3], myOrientation[4], 'Land')
           FactoryB:SetHealth(self,health)
           FactoryB = nil
           self:Destroy()
       end
    end,
}

TypeClass = WEB0204