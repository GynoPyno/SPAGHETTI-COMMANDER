local SWalkingLandUnit = import('/lua/seraphimunits.lua').SWalkingLandUnit
local WeaponsFile = import('/lua/seraphimweapons.lua')
local SDFOhCannon = WeaponsFile.SDFOhCannon
local SIFSuthanusArtilleryCannon = WeaponsFile.SIFSuthanusMobileArtilleryCannon

LED0003 = Class(SWalkingLandUnit) {
    Weapons = {
        MainGun = Class(SDFOhCannon) {},
        MainGun02 = Class(SIFSuthanusArtilleryCannon) {}
    },
}
TypeClass = LED0003