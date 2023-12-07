local AWalkingLandUnit = import('/lua/aeonunits.lua').AWalkingLandUnit
local ADFLaserHighIntensityWeapon = import('/lua/aeonweapons.lua').ADFLaserHighIntensityWeapon

SPA0006 = Class(AWalkingLandUnit) {
    Weapons = {
        MainGun = Class(ADFLaserHighIntensityWeapon) {}
    },

}


TypeClass = SPA0006