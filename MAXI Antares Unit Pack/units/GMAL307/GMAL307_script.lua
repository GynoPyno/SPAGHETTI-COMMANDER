local ALandUnit = import('/lua/aeonunits.lua').ALandUnit

local ADFCannonOblivionWeapon = import ('/lua/aeonweapons.lua').ADFCannonOblivionWeapon

GMAL307 = Class(ALandUnit) {

    Weapons = {
        MainGun = Class(ADFCannonOblivionWeapon) {},
    }, 
}

TypeClass = GMAL307