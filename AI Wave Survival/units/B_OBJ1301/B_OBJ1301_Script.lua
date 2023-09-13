#****************************************************************************
#** 
#**  File     :  /cdimage/units/URC1301/URC1301_script.lua 
#**  Author(s):  John Comes, David Tomandl 
#** 
#**  Summary  :  Cybran Administrative Building, Ver1
#** 
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local CCivilianStructureUnit = import('/lua/cybranunits.lua').CCivilianStructureUnit
local SCUDeathWeapon = import("/lua/sim/defaultweapons.lua").SCUDeathWeapon

B_OBJ1301 = Class(CCivilianStructureUnit) {

Weapons = { 
		DeathWeapon = ClassWeapon(SCUDeathWeapon) {},
    },
}


TypeClass = B_OBJ1301

