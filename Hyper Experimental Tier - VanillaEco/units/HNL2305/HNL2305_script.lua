-----------------------------------------------------------------
-- File     :  /mods/Hyper Experimental Tier/units/HNL2305/HNL2305_script.lua
-- Author(s):  Alek05
-- Summary  :  Cybran Hypersonic Strategic Missile Launcher Script
-----------------------------------------------------------------

local CStructureUnit = import('/lua/cybranunits.lua').CStructureUnit
local CIFMissileStrategicWeapon = import('/lua/cybranweapons.lua').CIFMissileStrategicWeapon

HNL2305 = Class(CStructureUnit) {
    Weapons = {
        NukeMissiles = Class(CIFMissileStrategicWeapon) {},
    },
}

TypeClass = HNL2305
