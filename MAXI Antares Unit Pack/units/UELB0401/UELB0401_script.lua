local TLandUnit = import( '/lua/terranunits.lua').TLandUnit
local TMobileFactoryUnit = import('/lua/terranunits.lua').TMobileFactoryUnit

local WeaponsFile = import('/lua/terranweapons.lua')

local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local TDFRiotWeapon = WeaponsFile.TDFRiotWeapon
local TAALinkedRailgun = WeaponsFile.TAALinkedRailgun
local TANTorpedoAngler = WeaponsFile.TANTorpedoAngler
local TIFFragLauncherWeapon = WeaponsFile.TDFFragmentationGrenadeLauncherWeapon
local TIFCommanderDeathWeapon = import('/lua/terranweapons.lua').TIFCommanderDeathWeapon
local TSAMLauncher = import('/lua/terranweapons.lua').TSAMLauncher

local explosion = import('/lua/defaultexplosions.lua')

local util = import('/lua/utilities.lua')
local utilities = import('/lua/Utilities.lua')
local fxutil = import('/lua/effectutilities.lua')
local Effects = import('/lua/effecttemplates.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')
local EffectUtils = import('/lua/EffectUtilities.lua')
local ExhaustBeam = import('/lua/effecttemplates.lua')
local ExhaustEffects = import('/lua/effecttemplates.lua')

local AIUtils = import('/lua/ai/aiutilities.lua')

UELB0401 = Class(TLandUnit) {
    Weapons = {
        DeathWeapon = Class(TIFCommanderDeathWeapon) {},
        RightTurret01 = Class(TDFGaussCannonWeapon) {},
        RightTurret02 = Class(TDFGaussCannonWeapon) {},
        LeftTurret01 = Class(TDFGaussCannonWeapon) {},
        LeftTurret02 = Class(TDFGaussCannonWeapon) {},
        RightRiotgun = Class(TDFRiotWeapon) {
            FxMuzzleFlash = EffectTemplate.TRiotGunMuzzleFxTank
        },
        LeftRiotgun = Class(TDFRiotWeapon) {
            FxMuzzleFlash = EffectTemplate.TRiotGunMuzzleFxTank
        },
        RightAAGun = Class(TAALinkedRailgun) {},
        LeftAAGun = Class(TAALinkedRailgun) {},
        Torpedo = Class(TANTorpedoAngler) {},
		CenterTurret01 = Class(TDFGaussCannonWeapon) {},
        CenterTurret02 = Class(TDFGaussCannonWeapon) {},
		FrontRiotgun01 = Class(TDFRiotWeapon) {
            FxMuzzleFlash = EffectTemplate.TRiotGunMuzzleFxTank
        },
		FrontRiotgun02 = Class(TDFRiotWeapon) {
            FxMuzzleFlash = EffectTemplate.TRiotGunMuzzleFxTank
        },
		FrontRiotgun03 = Class(TDFRiotWeapon) {
            FxMuzzleFlash = EffectTemplate.TRiotGunMuzzleFxTank
        },
		FrontRiotgun04 = Class(TDFRiotWeapon) {
            FxMuzzleFlash = EffectTemplate.TRiotGunMuzzleFxTank
        },
		FrontRiotgun05 = Class(TDFRiotWeapon) {
            FxMuzzleFlash = EffectTemplate.TRiotGunMuzzleFxTank
        },
		FrontRiotgun06 = Class(TDFRiotWeapon) {
            FxMuzzleFlash = EffectTemplate.TRiotGunMuzzleFxTank
        },
		FrontRiotgun07 = Class(TDFRiotWeapon) {
            FxMuzzleFlash = EffectTemplate.TRiotGunMuzzleFxTank
        },
		FrontRiotgun08 = Class(TDFRiotWeapon) {
            FxMuzzleFlash = EffectTemplate.TRiotGunMuzzleFxTank
        },
		HeavyGrenade01 = Class(TSAMLauncher) {},
		HeavyGrenade02 = Class(TSAMLauncher) {},
		####Toggled
		MissileRack01 = Class(TSAMLauncher) {},
		MissileRack02 = Class(TSAMLauncher) {},
    },

    CreateRollOffEffects = function(self)
        local army = self:GetArmy()
        local unitB = self.UnitBeingBuilt
        for k, v in self.RollOffBones do
            local fx = AttachBeamEntityToEntity(self, v, unitB, -1, army, EffectTemplate.TTransportBeam01)
            table.insert( self.ReleaseEffectsBag, fx)
            self.Trash:Add(fx)
            fx = AttachBeamEntityToEntity( unitB, -1, self, v, army, EffectTemplate.TTransportBeam02)
            table.insert( self.ReleaseEffectsBag, fx)
            self.Trash:Add(fx)
            fx = CreateEmitterAtBone( self, v, army, EffectTemplate.TTransportGlow01)
            table.insert( self.ReleaseEffectsBag, fx)
            self.Trash:Add(fx)
        end
    end,

    DestroyRollOffEffects = function(self)
        for k, v in self.ReleaseEffectsBag do
            v:Destroy()
        end
        self.ReleaseEffectsBag = {}
    end,
}

TypeClass = UELB0401