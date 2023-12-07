#****************************************************************************
#**
#**  File     :  /units/XSL0202/XSL0202_script.lua
#**
#**  Summary  :  Seraphim Heavy Bot Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************


local SAirUnit = import("/lua/seraphimunits.lua").SAirUnit
local SDFOhCannon = import('/lua/seraphimweapons.lua').SDFOhCannon

XSL0202 = Class(SAirUnit) {

    Weapons = {
        MainGun = Class(SDFOhCannon) {},
    },

    OnStopBeingBuilt = function(self,builder,layer)
        SAirUnit.OnStopBeingBuilt(self,builder,layer)
        self:HideBone('Left_Leg_B01', true)
        self:HideBone('Left_Leg_B03', true)
        self:HideBone('Right_Leg_B01', true)
        self:HideBone('Right_Leg_B03', true)
    end,

    OnCreate= function(self)
        SAirUnit.OnCreate(self)
        self:HideBone('Left_Leg_B01', true)
        self:HideBone('Left_Leg_B03', true)
        self:HideBone('Right_Leg_B01', true)
        self:HideBone('Right_Leg_B03', true)
    end, 

    OnStartBeingBuilt = function(self, builder, layer)
        SAirUnit.OnStartBeingBuilt(self,builder,layer)
        self:HideBone('Left_Leg_B01', true)
        self:HideBone('Left_Leg_B03', true)
        self:HideBone('Right_Leg_B01', true)
        self:HideBone('Right_Leg_B03', true)
    end,

}

TypeClass = XSL0202