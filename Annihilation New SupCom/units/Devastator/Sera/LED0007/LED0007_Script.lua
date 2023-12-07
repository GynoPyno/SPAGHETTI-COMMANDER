local SStructureUnit = import('/lua/seraphimunits.lua').SStructureUnit
local SIFZthuthaamArtilleryCannon = import('/lua/seraphimweapons.lua').SIFZthuthaamArtilleryCannon

LED0007 = Class(SStructureUnit) {

    Weapons = {
        MainGun = Class(SIFZthuthaamArtilleryCannon) {},
    },
}

TypeClass = LED0007