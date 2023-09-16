--[[#######################################################################
#  File     :  /units/UAS0106/UAS0106_script.lua
#  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#  Summary  :  Aeon Aviso Script: UAS0106
#  -----------------------------
#  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#######################################################################]]--
local ASeaUnit = import('/lua/aeonunits.lua').ASeaUnit

local AeonWeapons = import('/lua/aeonweapons.lua')
local ADFCannonQuantumWeapon = AeonWeapons.ADFCannonQuantumWeapon
local AANChronoTorpedoWeapon = import('/lua/aeonweapons.lua').AANChronoTorpedoWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')

UAS0106 = Class( ASeaUnit ) {

    Weapons = {
        MainGun = Class( ADFCannonQuantumWeapon ) {
            FxMuzzleFlash = EffectTemplate.AQuantumCannonMuzzle02
        },
		UpgradeGun01 = Class(ADFCannonQuantumWeapon) {
            FxMuzzleFlash = EffectTemplate.AQuantumCannonMuzzle02
        },
		UpgradeGun02 = Class(ADFCannonQuantumWeapon) {
            FxMuzzleFlash = EffectTemplate.AQuantumCannonMuzzle02
        },
		Torpedo01 = Class(AANChronoTorpedoWeapon) {},
    },
	
	
    OnCreate = function(self)
		ASeaUnit.OnCreate(self)
		self:HideBone('Origine04_01', true)
    end,	
	

}

TypeClass = UAS0106
