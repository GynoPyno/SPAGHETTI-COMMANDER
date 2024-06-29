#****************************************************************************
#**
#**  File     :  /cdimage/units/UAS0103/UAS0103_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Aeon Frigate Script: UAS0103
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local ASeaUnit = import('/lua/aeonunits.lua').ASeaUnit
local AeonWeapons = import('/lua/aeonweapons.lua')
local ADFCannonQuantumWeapon = AeonWeapons.ADFCannonQuantumWeapon
local AIFQuasarAntiTorpedoWeapon = AeonWeapons.AIFQuasarAntiTorpedoWeapon
local AANChronoTorpedoWeapon = import('/lua/aeonweapons.lua').AANChronoTorpedoWeapon
local AIFArtilleryMiasmaShellWeapon = import('/lua/aeonweapons.lua').AIFArtilleryMiasmaShellWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')

UAS0103 = Class(ASeaUnit) {

    Weapons = {
        MainGun = Class(ADFCannonQuantumWeapon) {
            FxMuzzleFlash = EffectTemplate.AQuantumCannonMuzzle02
        },
        MainGun2 = Class(ADFCannonQuantumWeapon) {
            FxMuzzleFlash = EffectTemplate.AQuantumCannonMuzzle02
        },
        AntiTorpedo01 = Class(AIFQuasarAntiTorpedoWeapon) {},
        AntiTorpedo02 = Class(AIFQuasarAntiTorpedoWeapon) {},
		UpgradeGun01 = Class(ADFCannonQuantumWeapon) {
            FxMuzzleFlash = EffectTemplate.AQuantumCannonMuzzle02
        },
		UpgradeGun02 = Class(ADFCannonQuantumWeapon) {
            FxMuzzleFlash = EffectTemplate.AQuantumCannonMuzzle02
        },
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
		
    end,				
	
}

TypeClass = UAS0103
