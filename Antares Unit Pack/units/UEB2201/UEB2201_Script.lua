local TStructureUnit = import('/lua/terranunits.lua').TStructureUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local WeaponFile = import('/lua/sim/defaultweapons.lua')
local TDFGaussCannonWeapon = import('/lua/terranweapons.lua').TDFGaussCannonWeapon
local EffectUtils = import('/lua/effectutilities.lua')
local Effects = import('/lua/effecttemplates.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')

UEB2201 = Class(TStructureUnit) {
    Weapons = {
        MainGun = Class(TDFGaussCannonWeapon) {},
	},
}

TypeClass = UEB2201


