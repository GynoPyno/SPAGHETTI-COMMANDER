#****************************************************************************
#**
#**  File     :  ura0305_weapons.lua
#**  Author(s):  Author(s): Resin_Smoker (Weapon Templates by:Exavier Macbeth)
#**  Copyright © 2008
#****************************************************************************

local WeaponFile = import('/lua/sim/defaultweapons.lua')
local CollisionBeams = import('/lua/defaultcollisionbeams.lua')
local BareBonesWeapon = WeaponFile.BareBonesWeapon
local DefaultProjectileWeapon = WeaponFile.DefaultProjectileWeapon
local DefaultBeamWeapon = WeaponFile.DefaultBeamWeapon
local GinsuCollisionBeam = CollisionBeams.GinsuCollisionBeam
local EffectTemplate = import('/lua/EffectTemplates.lua')

RetributionGreenLaser = Class(DefaultBeamWeapon) {
    BeamType = CollisionBeamFile.RetributionGreenLaserCollisionBeam,
    FxMuzzleFlash = {},
}




