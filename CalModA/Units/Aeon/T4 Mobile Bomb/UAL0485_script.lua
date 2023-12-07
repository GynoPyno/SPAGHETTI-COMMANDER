




local AConstructionUnit = import('/lua/aeonunits.lua').AConstructionUnit
local AWeapons = import('/lua/aeonweapons.lua')
local AIFQuantumWarhead = import('/lua/aeonweapons.lua').AIFQuantumWarhead
local ADFDisruptorCannonWeapon = import('/lua/aeonweapons.lua').ADFDisruptorCannonWeapon

UAL0105 = Class(AConstructionUnit) {

    DeathThreadDestructionWaitTime = 2,

    Weapons = {
        NukeMissiles = Class(AIFQuantumWarhead) {},
        MainGun = Class(ADFDisruptorCannonWeapon) {},
        DummyWeapon = Class(ADFDisruptorCannonWeapon) {},
    },
}

TypeClass = UAL0105