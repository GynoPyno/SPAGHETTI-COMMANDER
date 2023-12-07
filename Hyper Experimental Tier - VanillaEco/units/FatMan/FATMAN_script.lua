-----------------------------------------------------------------
-- File     :  /mods/Hyper Experimental Tier/units/FatMan/FATMAN_script.lua
-- Author(s):  Alek was here
-- Summary  :  UEF Extreme Strategic Missile Launcher Script
-----------------------------------------------------------------

local TStructureUnit = import('/lua/terranunits.lua').TStructureUnit
local TIFStrategicMissileWeapon = import('/lua/terranweapons.lua').TIFStrategicMissileWeapon

FATMAN = Class(TStructureUnit) {
    Weapons = {
        NukeMissiles = Class(TIFStrategicMissileWeapon) {},
    },
}

TypeClass = FATMAN
