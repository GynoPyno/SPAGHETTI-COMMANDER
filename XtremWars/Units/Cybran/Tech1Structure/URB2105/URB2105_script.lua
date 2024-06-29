#****************************************************************************
#**
#**  File     :  /units/URB2105/URB2105_script.lua
#**  Author(s):  John Comes, David Tomandl
#**
#**  Summary  :  Cybran Anti-Air Gun Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CAirUnit = import('/lua/cybranunits.lua').CAirUnit
local CAAAutocannon = import('/lua/cybranweapons.lua').CAAAutocannon

URB2105 = Class(CAirUnit) {

    EngineRotateBones = {'Echappement01', 'Echappement02',},
    BeamExhaustCruise = '/effects/emitters/missile_exhaust_fire_beam_06_emit.bp',
    BeamExhaustIdle = '/effects/emitters/missile_exhaust_fire_beam_06_emit.bp',
	
    Weapons = {
        AAGun = Class(CAAAutocannon) {
            FxMuzzleScale = 2.25,
        },
    },
	
    OnCreate = function(self)
		CAirUnit.OnCreate(self)

    end,
	
}


TypeClass = URB2105
