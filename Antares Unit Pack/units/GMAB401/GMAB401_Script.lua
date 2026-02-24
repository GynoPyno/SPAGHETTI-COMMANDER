local AStructureUnit = import('/lua/aeonunits.lua').AStructureUnit

local WeaponsFile = import ('/lua/aeonweapons.lua')

local ADFPhasonLaser = import('/lua/aeonweapons.lua').ADFPhasonLaser
local AIFCommanderDeathWeapon = import('/lua/aeonweapons.lua').AIFCommanderDeathWeapon

local utilities = import('/lua/utilities.lua')

GMAB401 = Class(AStructureUnit) {

    Weapons = {
        DeathWeapon = Class(AIFCommanderDeathWeapon) {},
        MainGun = Class(ADFPhasonLaser) {
		FxMuzzleFlashScale = 2.0,
	},
    },
}

TypeClass = GMAB401