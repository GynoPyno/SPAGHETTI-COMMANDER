#****************************************************************************
#** 
#**  File     :  /cdimage/units/XAC2101/XAC2101_script.lua 
#** 
#** 
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local ACivilianStructureUnit = import('/lua/aeonunits.lua').ACivilianStructureUnit
local SCUDeathWeapon = import("/lua/sim/defaultweapons.lua").SCUDeathWeapon

B_SEC2101 = Class(ACivilianStructureUnit) {

Weapons = {
		DeathWeapon = ClassWeapon(SCUDeathWeapon) {},
    },
}

TypeClass = B_SEC2101

