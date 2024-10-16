#****************************************************************************
#**
#**  File     :  /cdimage/units/UAS0201/UAS0201_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Aeon Destroyer Script
#**
#**  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local ASeaUnit = import('/lua/aeonunits.lua').ASeaUnit
local AeonWeapons = import('/lua/aeonweapons.lua')
local ADFCannonOblivionWeapon = AeonWeapons.ADFCannonOblivionWeapon
local AANDepthChargeBombWeapon = AeonWeapons.AANDepthChargeBombWeapon
local AANChronoTorpedoWeapon = AeonWeapons.AANChronoTorpedoWeapon
local AIFQuasarAntiTorpedoWeapon = AeonWeapons.AIFQuasarAntiTorpedoWeapon

UAS0201 = Class( ASeaUnit ) {
    BackWakeEffect = {},
    Weapons = {
        FrontTurret = Class(ADFCannonOblivionWeapon) {},
        DepthCharge = Class(AANDepthChargeBombWeapon) {},
        Torpedo1 = Class(AANChronoTorpedoWeapon) {},
        Torpedo2 = Class(AANChronoTorpedoWeapon) {},
        AntiTorpedo = Class(AIFQuasarAntiTorpedoWeapon) {},
        AntiTorpedo2 = Class(AIFQuasarAntiTorpedoWeapon) {},
		FrontTurret02 = Class(ADFCannonOblivionWeapon) {},
		FrontTurret03 = Class(ADFCannonOblivionWeapon) {},
		FrontTurret04 = Class(ADFCannonOblivionWeapon) {},
    },
	

    OnCreate = function(self)
        ASeaUnit.OnCreate(self)
		self:HideBone('Origine01', true) 
		self:HideBone('Origine02', true) 
    end,

}

TypeClass = UAS0201
