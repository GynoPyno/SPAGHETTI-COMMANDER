#****************************************************************************
#**
#**  File     :  /cdimage/units/UEL0205/UEL0205_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  UEF Mobile Flak Artillery Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local TAAFlakArtilleryCannon = import('/lua/terranweapons.lua').TAAFlakArtilleryCannon
local TDFMachineGunWeapon = import('/lua/terranweapons.lua').TDFMachineGunWeapon

UEL0205 = Class(TLandUnit) {
    Weapons = {
        AAGun = Class(TAAFlakArtilleryCannon) {
            PlayOnlyOneSoundCue = true,
        },
		AAGunUpgrade = Class(TAAFlakArtilleryCannon) {
            PlayOnlyOneSoundCue = true,
        },
		ALGunUpgrade = Class(TDFMachineGunWeapon) {},
    },

    OnCreate = function(self)
		TLandUnit.OnCreate(self)
		self:HideBone('Origine04_01', true)
    end,

}

TypeClass = UEL0205