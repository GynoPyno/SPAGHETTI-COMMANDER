#****************************************************************************
#**
#**  File     :  /cdimage/units/UEL0401/UEL0401_script.lua
#**  Author(s):  John Comes, David Tomandl, Gordon Duclos
#**
#**  Summary  :  UEF Mobile Factory Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CLandUnit = import('/lua/cybranunits.lua').CLandUnit
local CybranWeapons = import('/lua/cybranweapons.lua')
local CAAAutocannon = CybranWeapons.CAAAutocannon
local CDFProtonCannonWeapon = CybranWeapons.CDFProtonCannonWeapon
local CANNaniteTorpedoWeapon = CybranWeapons.CANNaniteTorpedoWeapon
local CDFParticleCannonWeapon = CybranWeapons.CDFParticleCannonWeapon
local CAMZapperWeapon02 = CybranWeapons.CAMZapperWeapon02

WRL0402 = Class(CLandUnit) {

    Weapons = {
        RightTurret01 = Class(CDFProtonCannonWeapon) {},
        RightTurret02 = Class(CDFProtonCannonWeapon) {},
        LeftTurret01 = Class(CDFProtonCannonWeapon) {},
        LeftTurret02 = Class(CDFProtonCannonWeapon) {},
        RightRiotgun = Class(CAAAutocannon) {},
        LeftRiotgun = Class(CAAAutocannon) {},
        RightAAGun = Class(CAAAutocannon) {},
        LeftAAGun = Class(CAAAutocannon) {},
        Torpedo = Class(CANNaniteTorpedoWeapon) {},
		LeftZapper = Class(CAMZapperWeapon02) {},
        RightZapper = Class(CAMZapperWeapon02) {},
		},
}

TypeClass = WRL0402