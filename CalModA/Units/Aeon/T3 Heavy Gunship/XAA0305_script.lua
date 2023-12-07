#****************************************************************************
#**
#**  File     :  /data/units/XAA0305/XAA0305_script.lua
#**  Author(s):  Jessica St. Croix
#**
#**  Summary  :  Aeon AA Gunship Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local AAirUnit = import('/lua/aeonunits.lua').AAirUnit
local ADFQuantumAutogunWeapon = import('/lua/aeonweapons.lua').ADFQuantumAutogunWeapon
local AANDepthChargeBombWeapon = import('/lua/aeonweapons.lua').AANDepthChargeBombWeapon

XAA0305 = Class(AAirUnit) {
    Weapons = {
        Turret1 = Class(ADFQuantumAutogunWeapon) {},
        Turret2 = Class(ADFQuantumAutogunWeapon) {},
        DepthCharge = Class(AANDepthChargeBombWeapon) {},
    },

    OnCreate = function(self)
        AAirUnit.OnCreate(self)
        self:HideBone('C_Turret', true)	
    end,
}

TypeClass = XAA0305