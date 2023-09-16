#****************************************************************************
#**
#**  File     :  /units/URB2206/URB2206_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Cybran Heavy Gun Tower Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CAirUnit = import('/lua/cybranunits.lua').CAirUnit
local CDFParticleCannonWeapon = import('/lua/cybranweapons.lua').CDFParticleCannonWeapon

URB2206 = Class(CAirUnit) {
    Weapons = {
        MainGun = Class(CDFParticleCannonWeapon) {
            FxMuzzleFlash = {'/effects/emitters/particle_cannon_muzzle_02_emit.bp'},
        },
    },
	
    EngineRotateBones = {'URB01', 'URB03', 'URB04', },
    BeamExhaustCruise = '/effects/emitters/missile_exhaust_fire_beam_06_emit.bp',
    BeamExhaustIdle = '/effects/emitters/missile_exhaust_fire_beam_06_emit.bp',	
	
    OnStopBeingBuilt = function(self, builder, layer)
        CAirUnit.OnStopBeingBuilt(self,builder,layer)
    end,	
}

TypeClass = URB2206