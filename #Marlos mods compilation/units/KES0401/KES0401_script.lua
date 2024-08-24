#****************************************************************************
#**
#**  File     :  /cdimage/units/UES0202/UES0202_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  UEF Cruiser Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TSeaUnit = import('/lua/terranunits.lua').TSeaUnit
local WeaponFile = import('/lua/terranweapons.lua')
local TIFCruiseMissileLauncher = import('/lua/terranweapons.lua').TIFCruiseMissileLauncher
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TSAMLauncher = import('/lua/terranweapons.lua').TSAMLauncher
local Fatboy2Weapon02 = import('/Mods/#Marlos mods compilation/lua/MKweapons.lua').Fatboy2Weapon02
local MKZapperWeapon = import('/Mods/#Marlos mods compilation/lua/MKweapons.lua').MKZapperWeapon

UES0202 = Class(TSeaUnit) {
    DestructionTicks = 200,

    Weapons = {
        FrontTurret = Class(Fatboy2Weapon02) {},
        FrontTurret02 = Class(Fatboy2Weapon02) {},
        BackTurret = Class(Fatboy2Weapon02) {},
        MissileRack01 = Class(TSAMLauncher) {},
        MissileRack02 = Class(TSAMLauncher) {},
        MissileRack03 = Class(TSAMLauncher) {},
        MissileRack04 = Class(TSAMLauncher) {},
        CruiseMissile = Class(TIFCruiseMissileLauncher) {
            FxMuzzleFlash = EffectTemplate.TIFCruiseMissileLaunchBuilding,
        },
        Turret01 = Class(MKZapperWeapon) {},
	},
}

TypeClass = UES0202
