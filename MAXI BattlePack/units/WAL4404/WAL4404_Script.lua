#****************************************************************************
#**
#**  File     :  /cdimage/units/UEL0201/UEL0201_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  BRN Scavenger Medium Tank
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local AWeapons = import('/lua/aeonweapons.lua')
local ADFCannonOblivionWeapon = AWeapons.ADFCannonOblivionWeapon
local ADFQuantumAutogunWeapon = AWeapons.ADFQuantumAutogunWeapon
local AAAZealotMissileWeapon = AWeapons.AAAZealotMissileWeapon
local ADFLaserHighIntensityWeapon = import('/lua/aeonweapons.lua').ADFLaserHighIntensityWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtils = import('/lua/effectutilities.lua')
local SCUDeathWeapon = import('/lua/sim/defaultweapons.lua').BattleSCUDeathWeapon

WAL4404 = Class(CWalkingLandUnit) {
    Weapons = {
        ChinGun = Class(ADFLaserHighIntensityWeapon) {},
		LeftGun = Class(ADFCannonOblivionWeapon) {},  
		RightGun = Class(ADFCannonOblivionWeapon) {},  
		TopCannon = Class(ADFQuantumAutogunWeapon) {},
		AntiAirMissiles01 = Class(AAAZealotMissileWeapon) {},
        DeathWeapon = Class(SCUDeathWeapon) {},
    }, 
}

TypeClass = WAL4404