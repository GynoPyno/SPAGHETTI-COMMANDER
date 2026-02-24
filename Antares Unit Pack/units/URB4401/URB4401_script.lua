local CStructureUnit = import('/lua/cybranunits.lua').CStructureUnit

local Weapon = import('/lua/sim/Weapon.lua').Weapon
local WeaponFile = import('/lua/sim/defaultweapons.lua')
local CybranWeaponsFile = import('/lua/cybranweapons.lua')

local CollisionBeamFile = import('/lua/defaultcollisionbeams.lua')
local DefaultBeamWeapon = WeaponFile.DefaultBeamWeapon
local CIFCommanderDeathWeapon = CybranWeaponsFile.CIFCommanderDeathWeapon

CDFMicrowaveLaserGenerator = Class(DefaultBeamWeapon) {
    BeamType = CollisionBeamFile.MicrowaveLaserCollisionBeam02,
    FxMuzzleFlash = {},
}

URB4401 = Class(CStructureUnit) {
    Weapons = {
        DeathWeapon = Class(CIFCommanderDeathWeapon) {},
        MainGun = Class(CDFMicrowaveLaserGenerator) {
            FxMuzzleFlash = {},
        },
    },
}


TypeClass = URB4401