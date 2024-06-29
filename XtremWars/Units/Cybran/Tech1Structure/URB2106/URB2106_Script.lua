#****************************************************************************
#**
#**  File     :  /units/URB2106/URB2106_script.lua
#**  Author(s):  John Comes, David Tomandl
#**
#**  Summary  :  Air Cybran Light Gun Tower Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CAirUnit = import('/lua/cybranunits.lua').CAirUnit
local CDFLaserHeavyWeapon = import('/lua/cybranweapons.lua').CDFLaserHeavyWeapon

URB2106 = Class(CAirUnit) {

    EngineRotateBones = {'Echappement01', 'Echappement02',},
    BeamExhaustCruise = '/effects/emitters/missile_exhaust_fire_beam_06_emit.bp',
    BeamExhaustIdle = '/effects/emitters/missile_exhaust_fire_beam_06_emit.bp',

    Weapons = {
		UpgradeGun01 = Class(CDFLaserHeavyWeapon) {},
    },

    OnCreate = function(self)
		CAirUnit.OnCreate(self)
		self:HideBone('Turret', true) 
		
    end,
	
    OnStopBeingBuilt = function(self, builder, layer)
        CAirUnit.OnStopBeingBuilt(self,builder,layer)
        self.EngineManipulators = {}
        for key, value in self.EngineRotateBones do
            table.insert(self.EngineManipulators, CreateThrustController(self, 'Thruster', value))
        end
        for key,value in self.EngineManipulators do
            #                          XMAX, XMIN, YMAX,YMIN, ZMAX,ZMIN, TURNMULT, TURNSPEED
            value:SetThrustingParam( -0.0, 0.0, -0.25, 0.25, -0.1, 1, 1.0,      0.25 )
        end
        for k, v in self.EngineManipulators do
            self.Trash:Add(v)
        end		
    end,
	
}

TypeClass = URB2106
