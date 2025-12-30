#****************************************************************************
#**
#**  File     :  /cdimage/units/XSL0303/XSL0303_script.lua
#**  Author(s):  Dru Staltman, Aaron Lundquist
#**
#**  Summary  :  Seraphim Siege Tank Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local SHoverLandUnit = import('/lua/seraphimunits.lua').SHoverLandUnit
local WeaponsFile = import('/lua/seraphimweapons.lua')
local SDFExperimentalPhasonProj = WeaponsFile.SDFExperimentalPhasonProj
local SDFUltraChromaticBeamGenerator = WeaponsFile.SDFUltraChromaticBeamGenerator
local SAAShleoCannonWeapon = WeaponsFile.SAAShleoCannonWeapon
local EffectUtil = import('/lua/EffectUtilities.lua')

WSL0403 = Class(SHoverLandUnit) {
    Weapons = {
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