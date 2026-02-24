local TStructureUnit = import('/lua/terranunits.lua').TStructureUnit
local TIFCommanderDeathWeapon = import('/lua/terranweapons.lua').TIFCommanderDeathWeapon
local TOrbitalDeathLaserBeamWeapon = import('/lua/terranweapons.lua').TOrbitalDeathLaserBeamWeapon
local util = import('/lua/utilities.lua')
local fxutil = import('/lua/effectutilities.lua')


GMEB401 = Class(TStructureUnit) {

    Weapons = {
        DeathWeapon = Class(TIFCommanderDeathWeapon) {},
        MainGun = Class(TOrbitalDeathLaserBeamWeapon) {
		FxMuzzleFlashScale = 2,
        },
    },
}

TypeClass = GMEB401