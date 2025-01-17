#****************************************************************************
#**
#**  File     :  /cdimage/units/URB2301/URB2301_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Cybran Heavy Gun Tower Script
#**
#**  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CybranWeaponsFile = import("/lua/cybranweapons.lua")
local CStructureUnit = import('/lua/cybranunits.lua').CStructureUnit
local SCUDeathWeapon = import("/lua/sim/defaultweapons.lua").SCUDeathWeapon
local CDFHvyProtonCannonWeapon = CybranWeaponsFile.CDFHvyProtonCannonWeapon
local CDFLaserHeavyWeapon = import("/lua/cybranweapons.lua").CDFLaserHeavyWeapon

PDCB2301 = Class(CStructureUnit) {
    Weapons = {
		MainGun = ClassWeapon(CDFLaserHeavyWeapon) {FxMuzzleFlash = {'/effects/emitters/particle_cannon_muzzle_02_emit.bp'},
        },
		ExperimentalGun = ClassWeapon(CDFHvyProtonCannonWeapon) {},
		DeathWeapon = ClassWeapon(SCUDeathWeapon) {},
    },
}

TypeClass = PDCB2301