#****************************************************************************
#**
#**  Authors  :  Alien Nation Modderation Team
#**
#**  Summary  :  Cybran Swarm Attack Craft Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
#
# Cybran Interceptor Script : URA0102
#
local CAirUnit = import('/lua/cybranunits.lua').CAirUnit
local CAAAutocannon = import('/lua/cybranweapons.lua').CAAAutocannon

ANC_URA102 = Class(CAirUnit) {
    Weapons = {
        AutoCannon = Class(CAAAutocannon) {},
        AutoCannon2 = Class(CAAAutocannon) {},
    },

    #############################
    #                           #                           
    #       Trail of Fire       #
    #                           #
    ############################# 

    #// Spawns a trail of fire from the plane when killed
   
    OnKilled = function(self, instigator, type, overkillRatio)
                CAirUnit.OnKilled(self, instigator, type, overkillRatio)

	 ##----------------------------##
	 ##     Fiery Death Effect     ##
	 ##----------------------------##     
	 
               CreateAttachedEmitter( self, 'Exhaust', self:GetArmy(), '/mods/AlienNationsUnitAdditions/effects/emitters/flamethrower_emit.bp'):ScaleEmitter(2.5) 
 
 
    end, 
   
}

TypeClass = ANC_URA102
