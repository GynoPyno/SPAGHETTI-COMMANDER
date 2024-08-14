#****************************************************************************
#**
#**  File     :  /cdimage/units/XRB0304/XRB0304_script.lua
#**  Author(s):  Dru Staltman, Gordon Duclos
#**
#**  Summary  :  Cybran Engineering tower
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local CConstructionStructureUnit = import('/lua/cybranunits.lua').CConstructionStructureUnit

WRB0304 = Class(CConstructionStructureUnit) 
{
    OnStartBeingBuilt = function(self, builder, layer)
        CConstructionStructureUnit.OnStartBeingBuilt(self, builder, layer)
        self:HideBone('xrb0304', true)
        self:ShowBone('TurretT3', true)
        self:ShowBone('Door3_B03', true)
        self:ShowBone('B03', true)
        self:ShowBone('Attachpoint03', true)
    end,   
    
    OnStartBuild = function(self, unitBeingBuilt, order)
        CConstructionStructureUnit.OnStartBuild(self, unitBeingBuilt, order)
        
        if not self.AnimationManipulator then
            self.AnimationManipulator = CreateAnimator(self)
            self.Trash:Add(self.AnimationManipulator)
        end
        self.AnimationManipulator:PlayAnim(self:GetBlueprint().Display.AnimationOpen, false):SetRate(1)
    end,
    
    OnStopBuild = function(self, unitBeingBuilt)
        CConstructionStructureUnit.OnStopBuild(self, unitBeingBuilt)
        
        if not self.AnimationManipulator then
            self.AnimationManipulator = CreateAnimator(self)
            self.Trash:Add(self.AnimationManipulator)
        end
        self.AnimationManipulator:SetRate(-1)
    end,
	
		OnStopBeingBuilt = function(self)
       if not self:IsDead() then
           local myOrientation = self:GetOrientation()
           local location = self:GetPosition()
           local health = self:GetHealth()
           local FactoryB = CreateUnit('xrb0304', self:GetArmy(), location[1], location[2], location[3], myOrientation[1], myOrientation[2], myOrientation[3], myOrientation[4], 'Land')
           FactoryB:SetHealth(self,health)
           FactoryB = nil
           self:Destroy()
       end
    end,
}
TypeClass = WRB0304