#****************************************************************************
#**
#**  File     :  /cdimage/units/UAS0202/UAS0202_script.lua
#**  Author(s):  David Tomandl
#**
#**  Summary  :  Aeon Cruiser Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local ASeaUnit = import('/lua/aeonunits.lua').ASeaUnit
local AeonWeapons = import('/lua/aeonweapons.lua')
local AAAZealotMissileWeapon = AeonWeapons.AAAZealotMissileWeapon
local ADFCannonQuantumWeapon = AeonWeapons.ADFCannonQuantumWeapon
local AAMWillOWisp = AeonWeapons.AAMWillOWisp
local ADFCannonOblivionWeapon02 = import('/lua/aeonweapons.lua').ADFCannonOblivionWeapon02

UAS0202 = Class( ASeaUnit ) {
    Weapons = {
        FrontTurret = Class(ADFCannonQuantumWeapon) {},
        AntiAirMissiles01 = Class(AAAZealotMissileWeapon) {},
        AntiAirMissiles02 = Class(AAAZealotMissileWeapon) {},
        AntiMissile = Class(AAMWillOWisp) {},
		AntiAirMissiles03 = Class(AAAZealotMissileWeapon) {},
        AntiAirMissiles04 = Class(AAAZealotMissileWeapon) {},
		FrontTurret02 = Class(ADFCannonQuantumWeapon) {},
		Vet4Gun = Class(ADFCannonOblivionWeapon02) {},
    },

    BackWakeEffect = {},
	
	
    OnCreate = function(self)
        ASeaUnit.OnCreate(self)
		self:HideBone('Origine03', true)
		self:HideBone('Origine01', true)  --Upgrade04_01
		self:ShowBone('Upgrade04_01', true)
    end,	
	
}

TypeClass = UAS0202
