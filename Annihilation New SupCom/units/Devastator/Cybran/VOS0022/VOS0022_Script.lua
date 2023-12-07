local TAirUnit = import('/lua/terranunits.lua').TAirUnit
local TIFSmallYieldNuclearBombWeapon = import('/lua/terranweapons.lua').TIFSmallYieldNuclearBombWeapon

VOS0022 = Class(TAirUnit) {
    Weapons = {
        RipperMissiles = Class(TIFSmallYieldNuclearBombWeapon) {},
    },
}

TypeClass = VOS0022
