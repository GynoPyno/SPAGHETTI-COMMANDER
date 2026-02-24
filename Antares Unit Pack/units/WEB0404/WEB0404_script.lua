local TStructureUnit = import('/lua/terranunits.lua').TStructureUnit
local TANTorpedoLandWeapon = import('/lua/terranweapons.lua').TANTorpedoLandWeapon
local WeaponsFile = import('/lua/terranweapons.lua')
local TIFCommanderDeathWeapon = import('/lua/terranweapons.lua').TIFCommanderDeathWeapon
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local EffectUtils = import('/lua/effectutilities.lua')
local Effects = import('/lua/effecttemplates.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')

WEB0404 = Class(TStructureUnit) {

    UpsideDown = false,

    Weapons = {
        DeathWeapon = Class(TIFCommanderDeathWeapon) {},
        RightTurret01 = Class(TDFGaussCannonWeapon) {},
        RightTurret02 = Class(TDFGaussCannonWeapon) {},
        LeftTurret01 = Class(TDFGaussCannonWeapon) {},
        LeftTurret02 = Class(TDFGaussCannonWeapon) {},
        CenterTurret = Class(TDFGaussCannonWeapon) {},
        RightRiotgun = Class(TANTorpedoLandWeapon) {},
        LeftRiotgun = Class(TANTorpedoLandWeapon) {},
        RightRiotgun2 = Class(TANTorpedoLandWeapon) {},
        LeftRiotgun2 = Class(TANTorpedoLandWeapon) {},
    },
}

TypeClass = WEB0404