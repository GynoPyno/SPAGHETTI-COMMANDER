#****************************************************************************
#**
#**  File     :  /units/UEL0310/UEL0310_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  UEF Mobile Flak Artillery Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local TerranWeaponFile = import('/lua/terranweapons.lua')
local TSAMLauncher = TerranWeaponFile.TSAMLauncher
local EffectTemplate = import('/lua/EffectTemplates.lua')

UEL0310 = Class(TLandUnit) {
    Weapons = {
        AntiAirMissiles = Class(TSAMLauncher) {
		FxMuzzleFlash = EffectTemplate.TAAMissileLaunchNoBackSmoke,
        },
    },
}

TypeClass = UEL0310