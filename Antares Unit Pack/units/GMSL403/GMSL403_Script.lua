local SWalkingLandUnit = import('/lua/seraphimunits.lua').SWalkingLandUnit
local SeraphimWeapons = import('/lua/seraphimweapons.lua')
local SDFHeavyQuarnonCannon = SeraphimWeapons.SDFHeavyQuarnonCannon
local SAAOlarisCannonWeapon = SeraphimWeapons.SAAOlarisCannonWeapon
local utilities = import('/lua/utilities.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')
local explosion = import('/lua/defaultexplosions.lua')
local WeaponsFile = import ('/lua/seraphimweapons.lua')
local SIFCommanderDeathWeapon = import('/lua/seraphimweapons.lua').SIFCommanderDeathWeapon

GMSL403 = Class(SWalkingLandUnit) {
    Weapons = {
	DeathWeapon = Class(SIFCommanderDeathWeapon) {},
	AAGun = Class(SAAOlarisCannonWeapon) {},
	FrontTurret = Class(SDFHeavyQuarnonCannon) {},
    },
}

TypeClass = GMSL403