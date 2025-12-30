#****************************************************************************
#**
#**  File     :  /cdimage/units/UAB0301/UAB0301_script.lua
#**  Author(s):  David Tomandl
#**
#**  Summary  :  Aeon Land Factory Tier 3 Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local TAirUnit = import('/lua/terranunits.lua').TAirUnit

local DEA0202OLD = DEA0202


DEA0202 = Class(DEA0202OLD) {

    RotateWings = function(self, target)
        if not self.LWingRotator then
            self.LWingRotator = CreateRotator(self, 'Left_Wing', 'y')
            self.Trash:Add(self.LWingRotator)
        end
        if not self.RWingRotator then
            self.RWingRotator = CreateRotator(self, 'Right_Wing', 'y')
            self.Trash:Add(self.RWingRotator)
        end
        local fighterAngle = 45
        local bomberAngle = 0
        local wingSpeed = 45
        if target and EntityCategoryContains(categories.AIR, target) then
            if self.LWingRotator then
                self.LWingRotator:SetSpeed(wingSpeed)
                self.LWingRotator:SetGoal(-fighterAngle)
            end
            if self.RWingRotator then
                self.RWingRotator:SetSpeed(wingSpeed)
                self.RWingRotator:SetGoal(fighterAngle)
            end
        else
            if self.LWingRotator then
                self.LWingRotator:SetSpeed(wingSpeed)
                self.LWingRotator:SetGoal(-bomberAngle)
            end
            if self.RWingRotator then
                self.RWingRotator:SetSpeed(wingSpeed)
                self.RWingRotator:SetGoal(bomberAngle)
            end                
        end  
    end,
    
    OnCreate = function(self)
        TAirUnit.OnCreate(self)
        self:ForkThread(self.MonitorWings)
    end,
    
    MonitorWings = function(self)
        local airTargetRight
        local airTargetLeft
        while self and not self:IsDead() do
            WaitSeconds(1)
            local airTargetWeapon = self:GetWeaponByLabel('RightBeam')
            if airTargetWeapon then     
                airTargetRight = airTargetWeapon:GetCurrentTarget()
            end
            airTargetWeapon = self:GetWeaponByLabel('LeftBeam')
            if airTargetWeapon then
                airTargetLeft = airTargetWeapon:GetCurrentTarget()
            end
            
            if airTargetRight then
                self:RotateWings(airTargetRight)              
            elseif airTargetLeft then
                self:RotateWings(airTargetLeft)             
            else
                self:RotateWings(nil)
            end
        end
    end,
}

TypeClass = DEA0202