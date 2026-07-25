#****************************************************************************
#**
#**  File     :  /cdimage/units/URS0303/URS0303_script.lua
#**  Author(s):  David Tomandl, Andres Mendez
#**
#**  Summary  :  Cybran Aircraft Carrier Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CLandUnit = import('/lua/cybranunits.lua').CLandUnit
local CybranWeaponsFile = import('/lua/cybranweapons.lua')
local CDFLaserHeavyWeapon = CybranWeaponsFile.CDFLaserHeavyWeapon
local CAAAutocannon = CybranWeaponsFile.CAAAutocannon
local CDFProtonCannonWeapon = CybranWeaponsFile.CDFProtonCannonWeapon
local CANNaniteTorpedoWeapon = CybranWeaponsFile.CANNaniteTorpedoWeapon

URS0303 = Class(CLandUnit) {

    FxDamageScale = 2.5,
	
    Weapons = {

        AAGun01 = Class(CAAAutocannon) {},
        AAGun02 = Class(CAAAutocannon) {},
        Torpedo = Class(CANNaniteTorpedoWeapon) {},
        RightRiotgun = Class(CDFLaserHeavyWeapon) {},
        LeftRiotgun = Class(CDFLaserHeavyWeapon) {},

        RightTurret01 = Class(CDFProtonCannonWeapon) {},
        RightTurret02 = Class(CDFProtonCannonWeapon) {},
        LeftTurret01 = Class(CDFProtonCannonWeapon) {},
        LeftTurret02 = Class(CDFProtonCannonWeapon) {},
		
    },

}

TypeClass = URS0303

