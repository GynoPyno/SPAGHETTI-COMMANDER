local CWalkingLandUnit = import( '/lua/cybranunits.lua').CWalkingLandUnit

local Weapon = import('/lua/sim/Weapon.lua').Weapon
local WeaponFile = import('/lua/sim/defaultweapons.lua')
local CybranWeaponsFile = import('/lua/cybranweapons.lua')

local CAABurstCloudFlakArtilleryWeapon = CybranWeaponsFile.CAABurstCloudFlakArtilleryWeapon
local CDFHvyProtonCannonWeapon = CybranWeaponsFile.CDFHvyProtonCannonWeapon
local CIFCommanderDeathWeapon = import('/lua/cybranweapons.lua').CIFCommanderDeathWeapon
local CollisionBeamFile = import('/lua/defaultcollisionbeams.lua')
local DefaultBeamWeapon = WeaponFile.DefaultBeamWeapon

local EffectTemplate = import('/lua/EffectTemplates.lua')
local utilities = import('/lua/Utilities.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')
local Entity = import('/lua/sim/Entity.lua').Entity

CDFMicrowaveLaserGenerator = Class(DefaultBeamWeapon) {
    BeamType = CollisionBeamFile.MicrowaveLaserCollisionBeam02,
    FxMuzzleFlash = {},
}

local CDFHeavyMicrowaveLaserGeneratorDefense = CDFMicrowaveLaserGenerator


WRL04044 = Class(CWalkingLandUnit) {
    Weapons = {
        DeathWeapon = Class(CIFCommanderDeathWeapon) {},
        MainGun = Class(CDFHvyProtonCannonWeapon) {},
        RightLaserTurret = Class(CDFHeavyMicrowaveLaserGeneratorDefense) {
            FxMuzzleFlash = {},
        },
        LeftLaserTurret = Class(CDFHeavyMicrowaveLaserGeneratorDefense) {
            FxMuzzleFlash = {},
        },
        AAGun = Class(CAABurstCloudFlakArtilleryWeapon) {},
    },
}

TypeClass = WRL04044
