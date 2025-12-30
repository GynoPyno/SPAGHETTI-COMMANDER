local SStructureUnit = import('/lua/seraphimunits.lua').SStructureUnit
local SWeapons = import('/lua/seraphimweapons.lua')
local SIFCommanderDeathWeapon = SWeapons.SIFCommanderDeathWeapon
local SAALosaareAutoCannonWeapon = SWeapons.SAALosaareAutoCannonWeapon
local SDFExperimentalPhasonLaser = SWeapons.SDFExperimentalPhasonLaser

GSB2401 = Class(SStructureUnit) {
    Weapons = {
        MainGun = Class(SDFExperimentalPhasonLaser) {},
        DeathWeapon = Class(SIFCommanderDeathWeapon) {},
        AntiAirMissiles = Class(SAALosaareAutoCannonWeapon) {},
    },
}

TypeClass = GSB2401