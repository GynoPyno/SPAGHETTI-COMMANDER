local TStructureUnit = import('/lua/terranunits.lua').TStructureUnit
local TSAMLauncher = import('/lua/terranweapons.lua').TSAMLauncher
local WeaponsFile = import('/lua/terranweapons.lua')
local TIFCommanderDeathWeapon = import('/lua/terranweapons.lua').TIFCommanderDeathWeapon

TBU1000 = Class(TStructureUnit) {
    Weapons = {
        DeathWeapon = Class(TIFCommanderDeathWeapon) {},
        MissileRack01 = Class(TSAMLauncher) {},
    },
}

TypeClass = TBU1000