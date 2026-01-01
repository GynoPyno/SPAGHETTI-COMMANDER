#****************************************************************************
#**
#**  File     :  /cdimage/units/UEL0401/UEL0401_script.lua
#**  Author(s):  John Comes, David Tomandl, Gordon Duclos
#**
#**  Summary  :  UEF Mobile Factory Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local TMobileFactoryUnit = import('/lua/terranunits.lua').TMobileFactoryUnit
local WeaponsFile = import('/lua/terranweapons.lua')

local TIFArtilleryWeapon = import('/lua/terranweapons.lua').TIFArtilleryWeapon
local TAAFlakArtilleryCannon = WeaponsFile.TAAFlakArtilleryCannon
local TIFCruiseMissileLauncher = WeaponsFile.TIFCruiseMissileLauncher
local TDFHiroPlasmaCannon = WeaponsFile.TDFHiroPlasmaCannon
local TANTorpedoAngler = WeaponsFile.TANTorpedoAngler
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local TDFRiotWeapon = WeaponsFile.TDFRiotWeapon

local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')


WEL0401 = Class(TMobileFactoryUnit) {
	Weapons = {
        RightTurret01 = Class(TDFGaussCannonWeapon) {},
        LeftTurret01 = Class(TDFGaussCannonWeapon) {},
		CenterTurret01 = Class(TDFGaussCannonWeapon) {},
        RightRiotgun = Class(TDFRiotWeapon) {
            FxMuzzleFlash = EffectTemplate.TRiotGunMuzzleFxTank
        },
        LeftRiotgun = Class(TDFRiotWeapon) {
            FxMuzzleFlash = EffectTemplate.TRiotGunMuzzleFxTank
        },
        Torpedo = Class(TANTorpedoAngler) {},
		MainGun = Class(TIFArtilleryWeapon) {
            FxMuzzleFlashScale = 1.5,
        },
		AAGun1 = Class(TAAFlakArtilleryCannon) {
            PlayOnlyOneSoundCue = true,
        },
		AAGun2 = Class(TAAFlakArtilleryCannon) {
            PlayOnlyOneSoundCue = true,
        },
		CruiseMissile01 = Class(TIFCruiseMissileLauncher) {},
		TMD1 = Class(TDFHiroPlasmaCannon) {},
		TMD2 = Class(TDFHiroPlasmaCannon) {},
		
    },
}

TypeClass = WEL0401