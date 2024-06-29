#****************************************************************************
#**
#**  File     :  /cdimage/units/UEL0203/UEL0203_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix, Gordon Duclos
#**
#**  Summary  :  UEF Amphibious Tank Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
local THoverLandUnit = import('/lua/terranunits.lua').THoverLandUnit
local TDFRiotWeapon = import('/lua/terranweapons.lua').TDFRiotWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')

UEL0203 = Class(THoverLandUnit) {
    Weapons = {
        Riotgun01 = Class(TDFRiotWeapon) {
            FxMuzzleFlash = EffectTemplate.TRiotGunMuzzleFxTank
        },
		Riotgun02 = Class(TDFRiotWeapon) {
            FxMuzzleFlash = EffectTemplate.TRiotGunMuzzleFxTank
        },
		Riotgun03 = Class(TDFRiotWeapon) {
            FxMuzzleFlash = EffectTemplate.TRiotGunMuzzleFxTank
        },	
		Riotgun04 = Class(TDFRiotWeapon) {
            FxMuzzleFlash = EffectTemplate.TRiotGunMuzzleFxTank
        },		
    },

    OnCreate = function(self)
		THoverLandUnit.OnCreate(self)
    end,


}

TypeClass = UEL0203