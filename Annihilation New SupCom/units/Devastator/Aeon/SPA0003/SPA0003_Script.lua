local AStructureUnit = import('/lua/aeonunits.lua').AStructureUnit
local AIFArtilleryMiasmaShellWeapon = import('/lua/aeonweapons.lua').AIFArtilleryMiasmaShellWeapon

SPA0003 = Class(AStructureUnit) {

    Weapons = {
        MainGun = Class(AIFArtilleryMiasmaShellWeapon) {},
    },
}

TypeClass = SPA0003