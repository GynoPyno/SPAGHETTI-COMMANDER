#****************************************************************************
#**
#**  File     :  /units/URB2207/URB2207_script.lua
#**  Author(s):  John Comes, David Tomandl
#**
#**  Summary  :  Cybran Anti-Air Flak Battery Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CAirUnit = import('/lua/cybranunits.lua').CAirUnit
local CAABurstCloudFlakArtilleryWeapon = import('/lua/cybranweapons.lua').CAABurstCloudFlakArtilleryWeapon

URB2207 = Class(CAirUnit) {
    Weapons = {
        AAGun = Class(CAABurstCloudFlakArtilleryWeapon) {},
    },
	
    EngineRotateBones = {'URB01', 'URB03', 'URB04', },
    BeamExhaustCruise = '/effects/emitters/missile_exhaust_fire_beam_06_emit.bp',
    BeamExhaustIdle = '/effects/emitters/missile_exhaust_fire_beam_06_emit.bp',	
	
    OnStopBeingBuilt = function(self, builder, layer)
        CAirUnit.OnStopBeingBuilt(self,builder,layer)
    end,	
}

TypeClass = URB2207