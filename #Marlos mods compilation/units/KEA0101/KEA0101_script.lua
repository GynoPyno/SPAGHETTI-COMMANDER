#****************************************************************************
#**
#**  File     :  /cdimage/units/UEA0203/UEA0203_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix, Gordon Duclos
#**
#**  Summary  :  UEF Gunship Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TAirUnit = import('/lua/terranunits.lua').TAirUnit
local TDFRiotWeapon = import('/lua/terranweapons.lua').TDFRiotWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TSAMLauncher = import('/lua/terranweapons.lua').TSAMLauncher

UEA0203 = Class(TAirUnit) {
    EngineRotateBones = {'Jet_Front','Jet_Dummy',},

    Weapons = {
        Turret01 = Class(TDFRiotWeapon) {},
        MissileRack01 = Class(TSAMLauncher) {},
    },

    OnStopBeingBuilt = function(self,builder,layer)
        TAirUnit.OnStopBeingBuilt(self,builder,layer)
        self.EngineManipulators = {}

        # create the engine thrust manipulators
        for key, value in self.EngineRotateBones do
            table.insert(self.EngineManipulators, CreateThrustController(self, "thruster", value))
        end

        # set up the thursting arcs for the engines
        for key,value in self.EngineManipulators do
            #                          XMAX, XMIN, YMAX,YMIN, ZMAX,ZMIN, TURNMULT, TURNSPEED
            value:SetThrustingParam( -0.0, 0.0, -0.0, 0.0, -0.001, 0.001, 1.0,      0.25 )
        end
        
        for k, v in self.EngineManipulators do
            self.Trash:Add(v)
        end

        TAirUnit.OnStopBeingBuilt(self,builder,layer)
        self.Trash:Add(CreateRotator(self, 'Rotor_Right', 'z', nil, 2600))
        self.Trash:Add(CreateRotator(self, 'Rotor_Left', 'z', nil, 2600))

    end,
}

TypeClass = UEA0203