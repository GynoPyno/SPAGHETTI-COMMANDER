#****************************************************************************
#**
#**  File     :  /cdimage/units/XRL0305/XRL0305_script.lua
#**  Author(s):  Drew Staltman, Jessica St. Croix, Gordon Duclos
#**
#**  Summary  :  Cybran Siege Assault Bot Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit
local CDFHeavyMicrowaveLaserGeneratorCom = import('/lua/cybranweapons.lua').CDFHeavyMicrowaveLaserGeneratorCom
local TSAMLauncher = import('/lua/terranweapons.lua').TSAMLauncher

XRL0305 = Class(CWalkingLandUnit)
{
    Weapons = {
        Disintigrator = Class(CDFHeavyMicrowaveLaserGeneratorCom) {},
        Sam = Class(TSAMLauncher) {},
    },

    OnStopBeingBuilt = function(self,builder,layer)
        CWalkingLandUnit.OnStopBeingBuilt(self,builder,layer)
        self:SetMaintenanceConsumptionActive()
    end,

}

TypeClass = XRL0305