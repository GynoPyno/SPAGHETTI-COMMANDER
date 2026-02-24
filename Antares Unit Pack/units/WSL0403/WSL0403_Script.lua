local SHoverLandUnit = import('/lua/seraphimunits.lua').SHoverLandUnit
local WeaponsFile = import('/lua/seraphimweapons.lua')
local SDFExperimentalPhasonProj = WeaponsFile.SDFExperimentalPhasonProj
local SDFUltraChromaticBeamGenerator = WeaponsFile.SDFUltraChromaticBeamGenerator
local SAAShleoCannonWeapon = WeaponsFile.SAAShleoCannonWeapon
local EffectUtil = import('/lua/EffectUtilities.lua')
local SIFCommanderDeathWeapon = import('/lua/seraphimweapons.lua').SIFCommanderDeathWeapon

WSL0403 = Class(SHoverLandUnit) {
    Weapons = {
	DeathWeapon = Class(SIFCommanderDeathWeapon) {},
        MainWeapon = Class(SDFExperimentalPhasonProj) {},
        LeftTurret = Class(SDFUltraChromaticBeamGenerator) {},
        RightTurret = Class(SDFUltraChromaticBeamGenerator) {},
        AAGun = Class(SAAShleoCannonWeapon) {
            FxMuzzleScale = 2.25,
        },
        AAGun2 = Class(SAAShleoCannonWeapon) {
            FxMuzzleScale = 2.25,
        },
    },
}

TypeClass = WSL0403