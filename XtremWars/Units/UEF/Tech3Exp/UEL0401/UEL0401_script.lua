#****************************************************************************
#**
#**  File     :  /cdimage/units/UEL0401/UEL0401_script.lua
#**  Author(s):  John Comes, David Tomandl, Gordon Duclos
#**
#**  Summary  :  UEF Mobile Factory Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local TLandUnit = import( '/lua/terranunits.lua').TLandUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local TDFRiotWeapon = WeaponsFile.TDFRiotWeapon
local TAALinkedRailgun = WeaponsFile.TAALinkedRailgun
local TANTorpedoAngler = WeaponsFile.TANTorpedoAngler
local TSAMLauncher = import('/lua/terranweapons.lua').TSAMLauncher
local EffectTemplate = import('/lua/EffectTemplates.lua')

UEL0401 = Class(TLandUnit) {
    Weapons = {
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
	
	OnCreate = function(self)
        TLandUnit.OnCreate(self)

    end,	

	OnScriptBitSet = function(self, bit)
        TLandUnit.OnScriptBitSet(self, bit)
        if bit == 1 then 
            self:SetWeaponEnabledByLabel('HeavyGrenade01', false)
			self:SetWeaponEnabledByLabel('HeavyGrenade02', false)
            self:SetWeaponEnabledByLabel('MissileRack01', true)
			self:SetWeaponEnabledByLabel('MissileRack02', true)
       end
    end,

    OnScriptBitClear = function(self, bit)
        TLandUnit.OnScriptBitClear(self, bit)
        if bit == 1 then 
            self:SetWeaponEnabledByLabel('HeavyGrenade01', true)
			self:SetWeaponEnabledByLabel('HeavyGrenade02', true)
            self:SetWeaponEnabledByLabel('MissileRack01', false)
			self:SetWeaponEnabledByLabel('MissileRack02', false)
        end
    end,
	

}

TypeClass = UEL0401