#****************************************************************************
#**
#**  File     :  /cdimage/units/UES0202/UES0202_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  UEF Cruiser Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TSeaUnit = import('/lua/terranunits.lua').TSeaUnit
local WeaponFile = import('/lua/terranweapons.lua')
local TDFGaussCannonWeapon = WeaponFile.TDFGaussCannonWeapon
local TANTorpedoAngler = import('/lua/terranweapons.lua').TANTorpedoAngler

UES0202 = Class(TSeaUnit) {
    DestructionTicks = 200,

    Weapons = {
        FrontTurret01 = Class(TDFGaussCannonWeapon) {},
        FrontTurret02 = Class(TDFGaussCannonWeapon) {},
        FrontTurret03 = Class(TDFGaussCannonWeapon) {},
        Torpedo = Class(TANTorpedoAngler) {
       },
	},
}

TypeClass = UES0202
