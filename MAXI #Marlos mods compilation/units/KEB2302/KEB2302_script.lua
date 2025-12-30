#****************************************************************************
#**
#**  File     :  /cdimage/units/UEB2302/UEB2302_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  UEF Long Range Artillery Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local EffectUtil = import('/lua/EffectUtilities.lua')
local TStructureUnit = import('/lua/terranunits.lua').TStructureUnit
local TIFCruiseMissileLauncher = import('/lua/terranweapons.lua').TIFCruiseMissileLauncher
local EffectTemplate = import('/lua/EffectTemplates.lua')

local EffectTemplate = import('/lua/EffectTemplates.lua')
local TWeapons = import('/lua/terranweapons.lua')
local TIFCommanderDeathWeapon = import('/lua/sim/defaultweapons.lua').DeathNukeWeapon

UEB2302 = Class(TStructureUnit) {
    Weapons = {
        CruiseMissile = Class(TIFCruiseMissileLauncher) {
            FxMuzzleFlash = EffectTemplate.TIFCruiseMissileLaunchBuilding,
        },
    },
}

TypeClass = UEB2302