local SWalkingLandUnit = import('/lua/seraphimunits.lua').SWalkingLandUnit
local SDFThauCannon = import('/lua/seraphimweapons.lua').SDFThauCannon

LED0010 = Class(SWalkingLandUnit) {
    Weapons = {
        MainGun = Class(SDFThauCannon) {},
    },
   
}
TypeClass = LED0010