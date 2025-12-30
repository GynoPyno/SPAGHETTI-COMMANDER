local TStructureUnit = import('/lua/terranunits.lua').TStructureUnit
local TANTorpedoLandWeapon = import('/lua/terranweapons.lua').TANTorpedoLandWeapon
local WeaponsFile = import('/lua/terranweapons.lua')
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local EffectUtils = import('/lua/effectutilities.lua')
local Effects = import('/lua/effecttemplates.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local SCUDeathWeapon = import('/lua/sim/defaultweapons.lua').BattleSCUDeathWeapon

WEB0404 = Class(TStructureUnit) {

    UpsideDown = false,

    Weapons = {
        RightTurret01 = Class(TDFGaussCannonWeapon) {},
        RightTurret02 = Class(TDFGaussCannonWeapon) {},
        LeftTurret01 = Class(TDFGaussCannonWeapon) {},
        LeftTurret02 = Class(TDFGaussCannonWeapon) {},
        CenterTurret = Class(TDFGaussCannonWeapon) {},
        RightRiotgun = Class(TANTorpedoLandWeapon) {},
        LeftRiotgun = Class(TANTorpedoLandWeapon) {},
        RightRiotgun2 = Class(TANTorpedoLandWeapon) {},
        LeftRiotgun2 = Class(TANTorpedoLandWeapon) {},
        DeathWeapon = Class(SCUDeathWeapon) {},
    },
}

TypeClass = WEB0404