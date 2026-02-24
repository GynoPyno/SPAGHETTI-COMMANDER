local TStructureUnit = import('/lua/terranunits.lua').TStructureUnit

local WeaponsFile = import('/lua/terranweapons.lua')
local TAAFlakArtilleryCannon = import('/lua/terranweapons.lua').TAAFlakArtilleryCannon

UEB2204 = Class(TStructureUnit) {
    Weapons = {
        AAGun = Class(TAAFlakArtilleryCannon) {},
           
    },
}

TypeClass = UEB2204