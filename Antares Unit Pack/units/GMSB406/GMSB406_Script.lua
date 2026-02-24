local SStructureUnit = import('/lua/seraphimunits.lua').SStructureUnit
local SWeapons = import('/lua/seraphimweapons.lua')
local SIFCommanderDeathWeapon = SWeapons.SIFCommanderDeathWeapon
local SDFExperimentalPhasonLaser = SWeapons.SDFExperimentalPhasonLaser

GMSB406 = Class(SStructureUnit) {
    Weapons = {
	DeathWeapon = Class(SIFCommanderDeathWeapon) {},
        MainGun = Class(SDFExperimentalPhasonLaser) {},
    },
}

TypeClass = GMSB406