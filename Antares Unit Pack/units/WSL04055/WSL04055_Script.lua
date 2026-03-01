local SHoverLandUnit = import('/lua/seraphimunits.lua').SHoverLandUnit
local WeaponsFile = import('/lua/seraphimweapons.lua')
local SDFUltraChromaticBeamGenerator = WeaponsFile.SDFUltraChromaticBeamGenerator
local SDFAireauBolter = WeaponsFile.SDFAireauBolterWeapon
local SAAShleoCannonWeapon = import('/lua/seraphimweapons.lua').SAAShleoCannonWeapon
local EffectUtil = import('/lua/EffectUtilities.lua')
local SIFCommanderDeathWeapon = import('/lua/seraphimweapons.lua').SIFCommanderDeathWeapon

WSL04055 = Class(SHoverLandUnit) {
    Weapons = {
	DeathWeapon = Class(SIFCommanderDeathWeapon) {},
        MainTurret = Class(SDFUltraChromaticBeamGenerator) {},
        MainTurret2 = Class(SDFUltraChromaticBeamGenerator) {},
        LeftTurret = Class(SDFAireauBolter) {},
        RightTurret = Class(SDFAireauBolter) {},
        RearLeftTurret = Class(SDFAireauBolter) {},
        RearRightTurret = Class(SDFAireauBolter) {},
        AAGun = Class(SAAShleoCannonWeapon) 
        {
            FxMuzzleScale = 2.25,
        },
    },
}

TypeClass = WSL04055