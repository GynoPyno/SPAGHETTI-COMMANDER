#****************************************************************************
#**
#**  File     :  /cdimage/units/SPA0014/UAL0103_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**				Model By Asdrubaelvect, Script By Manimal For Experimental Wars 1.8
#**  Summary  :  Aeon Mobile Light Artillery Script
#**
#**  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local AHoverLandUnit = import('/lua/aeonunits.lua').AHoverLandUnit
local AIFMortarWeapon = import('/lua/aeonweapons.lua').AIFMortarWeapon

SPA0014 = Class(AHoverLandUnit) {
    Weapons = {
        MainGun = Class(AIFMortarWeapon) {
            FxMuzzleFlash = {
                '/effects/emitters/aeon_mortar_flash_01_emit.bp',
                '/effects/emitters/aeon_mortar_flash_02_emit.bp',
            },
        },
		UpgradeGun02 = Class(AIFMortarWeapon) {
            FxMuzzleFlash = {
                '/effects/emitters/aeon_mortar_flash_01_emit.bp',
                '/effects/emitters/aeon_mortar_flash_02_emit.bp',
            },
        },
    },
    OnCreate = function(self)
        AHoverLandUnit.OnCreate(self)
		self:HideBone('Upgrade02_01', true) ###Masquer arme 2
		self:HideBone('Upgrade05_01', true)
        self.Trash:Add(CreateRotator(self, 'Upgrade05_01', 'x', nil, 120, 0, 120))
		self:HideBone('Upgrade05_02', true)
        self.Trash:Add(CreateRotator(self, 'Upgrade05_02', 'x', nil, 120, 0, 120))
    end,
	

}

TypeClass = SPA0014