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
local TDFGaussCannonWeapon = WeaponFile.TDFShipGaussCannonWeapon

MK54 = Class(TSeaUnit) {
    DestructionTicks = 200,

    Weapons = {
        FrontTurret = Class(TDFGaussCannonWeapon) {},
        BackTurret = Class(TDFGaussCannonWeapon) {},
	},
}

TypeClass = MK54
