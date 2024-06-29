#****************************************************************************
#**
#**  File     :  /cdimage/units/XEL0305/XEL0305_script.lua
#**
#**  Summary  :  UEF Siege Assault Bot Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local TerranWeaponFile = import('/lua/terranweapons.lua')
local TWalkingLandUnit = import('/lua/terranunits.lua').TWalkingLandUnit
local TDFIonizedPlasmaCannon = TerranWeaponFile.TDFIonizedPlasmaCannon
local TIFCruiseMissileUnpackingLauncher = TerranWeaponFile.TIFCruiseMissileUnpackingLauncher




XEL0305 = Class(TWalkingLandUnit) {

    Weapons = {
        PlasmaCannon01 = Class(TDFIonizedPlasmaCannon) {},
		PlasmaCannon02 = Class(TDFIonizedPlasmaCannon) {},
        MissileWeapon01 = Class(TIFCruiseMissileUnpackingLauncher) {},
    },
	
 OnCreate = function(self)
        TWalkingLandUnit.OnCreate(self)

    end,	
	
}

TypeClass = XEL0305