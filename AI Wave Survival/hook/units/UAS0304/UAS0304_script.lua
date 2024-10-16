-----------------------------------------------------------------
-- File     :  /cdimage/units/UAS0304/UAS0304_script.lua
-- Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- Summary  :  Aeon Strategic Missile Submarine Script
-- Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
-----------------------------------------------------------------

local ASubUnit = import("/lua/aeonunits.lua").ASubUnit
local WeaponFile = import("/lua/aeonweapons.lua")
local AIFMissileTacticalSerpentineWeapon = WeaponFile.AIFMissileTacticalSerpentineWeapon
local AANChronoTorpedoWeapon = import("/lua/aeonweapons.lua").AANChronoTorpedoWeapon
local AIFQuantumWarhead = WeaponFile.AIFQuantumWarhead
local EffectTemplate = import('/lua/effecttemplates.lua')

---@class UAS0304 : ASubUnit
UAS0304 = ClassUnit(ASubUnit) {
    DeathThreadDestructionWaitTime = 0,
    Weapons = {
        CruiseMissiles = ClassWeapon(AIFMissileTacticalSerpentineWeapon) {
        	FxMuzzleFlash = EffectTemplate.TIFCruiseMissileLaunchUnderWater,
        },
        NukeMissiles = ClassWeapon(AIFQuantumWarhead) {
        	FxMuzzleFlash = EffectTemplate.TIFCruiseMissileLaunchUnderWater,
        },
		Torpedo01 = ClassWeapon(AANChronoTorpedoWeapon) {},
    },
}

TypeClass = UAS0304