#****************************************************************************
#**
#**  File     :  /cdimage/units/URL0303/URL0303_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Cybran Siege Assault Bot Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit
--local CConstructionUnit = import('/lua/cybranunits.lua').CConstructionUnit
local EffectUtil = import('/lua/EffectUtilities.lua')

URL0310 = Class(CWalkingLandUnit) 
{

    Weapons = {
        RocketBackpack = Class(import('/lua/cybranweapons.lua').CDFRocketIridiumWeapon02) {},
    },

    OnCreate = function(self)
        CWalkingLandUnit.OnCreate(self)
        self.Rotator1 = CreateRotator(self, 'Furtif', 'y', nil, 100, 15, 100)
        self.Trash:Add(self.Rotator1)
        self:SetMaintenanceConsumptionInactive()
        self:SetScriptBit('RULEUTC_StealthToggle', true)
        self:RequestRefreshUI()
        if self:GetBlueprint().General.BuildBones then
            self:SetupBuildBones()
        end
    end,
	
    OnPrepareArmToBuild = function(self)
        CWalkingLandUnit.OnPrepareArmToBuild(self)
        self:BuildManipulatorSetEnabled(true)
    end,

    # ********
    # Engineering effects
    # ********
    OnStartBuild = function(self, unitBeingBuilt, order)    
        CWalkingLandUnit.OnStartBuild(self, unitBeingBuilt, order)
        self.UnitBeingBuilt = unitBeingBuilt
        self.UnitBuildOrder = order
        self.BuildingUnit = true   
    end,    

    OnStopBuild = function(self, unitBeingBuilt)
        CWalkingLandUnit.OnStopBuild(self, unitBeingBuilt)
        self.UnitBeingBuilt = nil
        self.UnitBuildOrder = nil
        self.BuildingUnit = false
        self:BuildManipulatorSetEnabled(false)
        self.BuildArmManipulator:SetPrecedence(0)   

    end,    
    
    OnFailedToBuild = function(self)
        CWalkingLandUnit.OnFailedToBuild(self)
        self:BuildManipulatorSetEnabled(false)
    end,
    
    CreateBuildEffects = function( self, unitBeingBuilt, order )
       --EffectUtil.SpawnBuildBots( self, unitBeingBuilt, 0, self.BuildEffectsBag )
       EffectUtil.CreateCybranBuildBeams( self, unitBeingBuilt, self:GetBlueprint().General.BuildBones.BuildEffectBones, self.BuildEffectsBag )
    end,

    OnStopBeingBuilt = function(self,builder,layer)
        CWalkingLandUnit.OnStopBeingBuilt(self,builder,layer)
        self:BuildManipulatorSetEnabled(false)
    end,

}

TypeClass = URL0310