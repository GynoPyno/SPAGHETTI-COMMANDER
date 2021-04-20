local AStructureUnit = import('/lua/aeonunits.lua').AStructureUnit
local AIFArtillerySonanceShellWeapon = import('/lua/aeonweapons.lua').AIFArtillerySonanceShellWeapon
local EffectUtils = import('/lua/effectutilities.lua')
local Effects = import('/lua/effecttemplates.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local WeaponFile = import('/lua/sim/defaultweapons.lua')
local WeaponsFile = import ('/lua/aeonweapons.lua')
local utilities = import('/lua/utilities.lua')
local explosion = import('/lua/defaultexplosions.lua')
local Entity = import('/lua/sim/Entity.lua').Entity

T4PD_Retribution = Class(AStructureUnit) {
    Weapons = {
        MainGun = Class(AIFArtillerySonanceShellWeapon) {},
    },
}

TypeClass = T4PD_Retribution