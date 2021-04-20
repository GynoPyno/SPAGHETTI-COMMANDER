#****************************************************************************
#**
#**  File     :  /cdimage/units/UEL0401/UEL0401_script.lua
#**  Author(s):  John Comes, David Tomandl, Gordon Duclos
#**
#**  Summary  :  UEF Mobile Factory Script
#**
#**  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

# This unit needs to not be allowed to build while underwater
# Additionally, if it goes underwater while building it needs to cancel the
#   current order
local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local TAMPhalanxWeapon = import('/lua/terranweapons.lua').TAMPhalanxWeapon
local TDFHeavyPlasmaCannonWeapon = WeaponsFile.TDFHeavyPlasmaCannonWeapon
local TSAMLauncher = import('/lua/terranweapons.lua').TSAMLauncher
local TIFArtilleryWeapon = import('/lua/terranweapons.lua').TIFArtilleryWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')
UEL0401 = Class(TLandUnit) {
    Weapons = {
        NukeTurret = Class(TIFArtilleryWeapon) {},
        TMDTurret = Class(TAMPhalanxWeapon) {},
        PDC1 = Class(TDFHeavyPlasmaCannonWeapon) {},
        PDC4 = Class(TDFHeavyPlasmaCannonWeapon) {},
        PDC2 = Class(TDFHeavyPlasmaCannonWeapon) {},
        PDC3 = Class(TDFHeavyPlasmaCannonWeapon) {},
        AAMissileRack = Class(TSAMLauncher) {},
    },
}
TypeClass = UEL0401