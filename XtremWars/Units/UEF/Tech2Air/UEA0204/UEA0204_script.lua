#****************************************************************************
#**
#**  File     :  /cdimage/units/UEA0204/UEA0204_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  UEF Torpedo Bomber Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local TAirUnit = import('/lua/terranunits.lua').TAirUnit
local TANTorpedoAngler = import('/lua/terranweapons.lua').TANTorpedoAngler
local TDFRiotWeapon = import('/lua/terranweapons.lua').TDFRiotWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')

UEA0204 = Class(TAirUnit) {
    Weapons = {
        Torpedo = Class(TANTorpedoAngler) {
        },
		Riotgun01 = Class(TDFRiotWeapon) {
            FxMuzzleFlash = EffectTemplate.TRiotGunMuzzleFxTank
        },
		Riotgun02 = Class(TDFRiotWeapon) {
            FxMuzzleFlash = EffectTemplate.TRiotGunMuzzleFxTank
        },
		Torpedo2 = Class(TANTorpedoAngler) {
        },
    },
	
    OnCreate = function(self)
        TAirUnit.OnCreate(self)
		self:HideBone('Origine01', true)
    end,

	
}

TypeClass = UEA0204