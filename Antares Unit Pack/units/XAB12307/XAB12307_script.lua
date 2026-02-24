local AStructureUnit = import('/lua/aeonunits.lua').AStructureUnit
local AIFQuanticArtillery = import('/lua/aeonweapons.lua').AIFQuanticArtillery
local utilities = import('/lua/utilities.lua')
local AIFCommanderDeathWeapon = import('/lua/aeonweapons.lua').AIFCommanderDeathWeapon
local EffectUtil = import('/lua/EffectUtilities.lua')

XAB12307 = Class(AStructureUnit) {
    Weapons = {
        DeathWeapon = Class(AIFCommanderDeathWeapon) {},
        MainGun = Class(AIFQuanticArtillery) {},
    },
}
TypeClass = XAB12307