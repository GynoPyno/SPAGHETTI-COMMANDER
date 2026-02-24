local CStructureUnit = import('/lua/cybranunits.lua').CStructureUnit

local Weapon = import('/lua/sim/Weapon.lua').Weapon
local WeaponFile = import('/lua/sim/defaultweapons.lua')
local CybranWeaponsFile = import('/lua/cybranweapons.lua')

local CDFHeavyDisintegratorWeapon = import('/lua/cybranweapons.lua').CDFHeavyDisintegratorWeapon
local CDFParticleCannonWeapon = import('/lua/cybranweapons.lua').CDFParticleCannonWeapon
local CollisionBeamFile = import('/lua/defaultcollisionbeams.lua')
local DefaultBeamWeapon = WeaponFile.DefaultBeamWeapon
local CIFCommanderDeathWeapon = CybranWeaponsFile.CIFCommanderDeathWeapon

local util = import('/lua/utilities.lua')
local utilities = import('/lua/Utilities.lua')
local fxutil = import('/lua/effectutilities.lua')
local Effects = import('/lua/effecttemplates.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')

CDFMicrowaveLaserGenerator02 = Class(DefaultBeamWeapon) {
    BeamType = CollisionBeamFile.MicrowaveLaserCollisionBeam02,
    FxMuzzleFlash = {},
}

CT4_AA2 = Class(CStructureUnit) {
    Weapons = {
        DeathWeapon = Class(CIFCommanderDeathWeapon) {},
        AAGun = Class(CDFMicrowaveLaserGenerator02) {},
            FxMuzzleFlash = {'/effects/emitters/particle_cannon_muzzle_02_emit.bp'},
    },
}

TypeClass = CT4_AA2