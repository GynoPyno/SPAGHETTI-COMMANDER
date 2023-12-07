-----------------------------------------------------------------
-- File     :  /cdimage/units/UAA0310/UAA0310_script.lua
-- Author(s):  John Comes
-- Summary  :  Aeon CZAR Script
-- Copyright © 2006 Gas Powered Games, Inc.  All rights reserved.
-----------------------------------------------------------------

local AAirUnit = import('/lua/aeonunits.lua').AAirUnit
local AAAZealotMissileWeapon = import('/lua/aeonweapons.lua').AAAZealotMissileWeapon
local ADFQuantumAutogunWeapon = import('/lua/aeonweapons.lua').ADFQuantumAutogunWeapon
local ADFPhasonLaser = import('/lua/aeonweapons.lua').ADFPhasonLaser


UAA0310 = ClassUnit(AAirUnit) {

    Weapons = {
        Cannon = ClassWeapon(ADFPhasonLaser){},
        SonicPulseBattery1 = ClassWeapon(AAAZealotMissileWeapon) {},
        SonicPulseBattery2 = ClassWeapon(AAAZealotMissileWeapon) {},
        SonicPulseBattery3 = ClassWeapon(AAAZealotMissileWeapon) {},
        SonicPulseBattery4 = ClassWeapon(AAAZealotMissileWeapon) {},
    },

}

TypeClass = UAA0310
