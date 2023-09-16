--[[#######################################################################
#  File     :  /units/UEA0105/UEA0105_script.lua
#  Author(s):  John Comes, David Tomandl, Jessica St. Croix, Gordon Duclos
#  Summary  :  UEF Gunship Script UEA0203
#  -----------------------------
#  Modif.by :  AsdrubaelVect
#  Rev.Date :  5 septembre 2009
#  -----------------------------
#  Revis.by :  Manimal
#  Rev.Date :  20 novembre 2009
#  -----------------------------
#  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#######################################################################]]--
local TAirUnit = import('/lua/terranunits.lua').TAirUnit
local TDFMachineGunWeapon = import('/lua/terranweapons.lua').TDFMachineGunWeapon
local CIFBombNeutronWeapon = import('/lua/cybranweapons.lua').CIFBombNeutronWeapon

UEA0105 = Class(TAirUnit) {
    EngineRotateBones = {'Jet_Center01','Upgrade01_01'},

    Weapons = {
        Turret01 = Class(TDFMachineGunWeapon) {},
		Turret02 = Class(TDFMachineGunWeapon) {},
		UpgradeGun01 = Class(CIFBombNeutronWeapon) {},

    },
	
    OnCreate = function(self)
		TAirUnit.OnCreate(self)

    end,
	
    OnStopBeingBuilt = function(self,builder,layer)
        TAirUnit.OnStopBeingBuilt(self,builder,layer)
        self.EngineManipulators = {}
        for key, value in self.EngineRotateBones do
            table.insert(self.EngineManipulators, CreateThrustController(self, "thruster", value))
        end
        for key,value in self.EngineManipulators do
            #                          XMAX, XMIN, YMAX,YMIN, ZMAX,ZMIN, TURNMULT, TURNSPEED
            value:SetThrustingParam( -0.0, 0.0, -0.25, 0.25, -0.1, 0.1, 1.0,      0.45 )
        end
        for k, v in self.EngineManipulators do
            self.Trash:Add(v)
        end

    end,
	
}

TypeClass = UEA0105
