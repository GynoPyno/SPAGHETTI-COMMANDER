local SLandUnit = import('/lua/seraphimunits.lua').SLandUnit
local SAAOlarisCannonWeapon = import('/lua/seraphimweapons.lua').SAAOlarisCannonWeapon

GMSL303 = Class(SLandUnit) {
    Weapons = {
        AAGun = Class(SAAOlarisCannonWeapon) {},
    },
}
TypeClass = GMSL303