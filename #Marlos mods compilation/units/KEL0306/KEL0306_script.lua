#****************************************************************************
#**
#**  File     :  /cdimage/units/UEL0203/UEL0203_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix, Gordon Duclos
#**
#**  Summary  :  UEF Amphibious Tank Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local EffectTemplate = import('/lua/EffectTemplates.lua')
local THoverLandUnit = import('/lua/terranunits.lua').THoverLandUnit
local TDFGaussCannonWeapon = import('/lua/terranweapons.lua').TDFGaussCannonWeapon
local TANTorpedoAngler = import('/lua/terranweapons.lua').TANTorpedoAngler
local TConstructionUnit = import('/lua/terranunits.lua').TConstructionUnit

UEL0203 = Class(TConstructionUnit) {
    Weapons = {
        FrontTurret01 = Class(TDFGaussCannonWeapon) {},
        Torpedo01 = Class(TANTorpedoAngler) {},
    },
}

TypeClass = UEL0203