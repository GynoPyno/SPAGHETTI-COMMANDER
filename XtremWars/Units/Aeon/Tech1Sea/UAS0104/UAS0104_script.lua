#****************************************************************************
#**
#**  File     :  /units/UAS0104/UAS0104_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Aeon Arty Frigate Script: UAS0103
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local ASeaUnit = import('/lua/aeonunits.lua').ASeaUnit
local AeonWeapons = import('/lua/aeonweapons.lua')
local AIFArtilleryMiasmaShellWeapon = AeonWeapons.AIFArtilleryMiasmaShellWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local ADFCannonQuantumWeapon = AeonWeapons.ADFCannonQuantumWeapon
local AANChronoTorpedoWeapon = import('/lua/aeonweapons.lua').AANChronoTorpedoWeapon

UAS0104 = Class( ASeaUnit ) {

    Weapons = {
		MainGun = Class(AIFArtilleryMiasmaShellWeapon) {},
		UpgradeGun03 = Class(ADFCannonQuantumWeapon) {
            FxMuzzleFlash = EffectTemplate.AQuantumCannonMuzzle02
        },
		UpgradeGun04 = Class(ADFCannonQuantumWeapon) {
            FxMuzzleFlash = EffectTemplate.AQuantumCannonMuzzle02
        },
		Torpedo01 = Class(AANChronoTorpedoWeapon) {},
		ArtyUpgrade = Class(AIFArtilleryMiasmaShellWeapon) {},
    },
	
   OnCreate = function(self)
		ASeaUnit.OnCreate(self)
		self:HideBone('Origine04_01', true)
		self:HideBone('Turret_Center_Barrel01', true)
		self:HideBone('Turret_Center_Barrel02', true)
    end,	
	
}

TypeClass = UAS0104
