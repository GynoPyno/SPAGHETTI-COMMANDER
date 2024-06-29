#****************************************************************************
#**
#**  File     :  /cdimage/units/UEL0303/UEL0303_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  UEF Siege Assault Bot Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local TerranWeaponFile = import('/lua/terranweapons.lua')
local TWalkingLandUnit = import( '/lua/terranunits.lua').TWalkingLandUnit
local TDFHeavyPlasmaCannonWeapon = TerranWeaponFile.TDFHeavyPlasmaCannonWeapon
local TIFCruiseMissileUnpackingLauncher = TerranWeaponFile.TIFCruiseMissileUnpackingLauncher

UEL0303 = Class(TWalkingLandUnit) {

    Weapons = {
        HeavyPlasma01 = Class(TDFHeavyPlasmaCannonWeapon) {
            DisabledFiringBones = {
                'Torso', 'ArmG_B02', 'Barrel_G', 'ArmG_B03', 'ArmG_B04',
                'ArmD_B02', 'Barrel_D', 'ArmD_B03', 'ArmD_B04',
            },
        },
		####UPGRADE 2
		HeavyPlasma02 = Class(TDFHeavyPlasmaCannonWeapon) {},
		####UPGRADE 3
        MissileWeapon01 = Class(TIFCruiseMissileUnpackingLauncher) {},

    },
	
    OnCreate = function(self)
        TWalkingLandUnit.OnCreate(self)

    end,	

}

TypeClass = UEL0303