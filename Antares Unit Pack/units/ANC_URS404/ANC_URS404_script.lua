#****************************************************************************
#**
#**  File     :  /cdimage/units/URS0302/URS0302_script.lua
#**  Author(s):  Bob Smith/PUREVENOM
#**
#**  Summary  :  Cybran Experimental Battleship Script
#**
#**  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CSeaUnit = import('/lua/cybranunits.lua').CSeaUnit
local EffectTemplate = import('/lua/EffectTemplates.lua')
local CybranWeaponsFile = import('/lua/cybranweapons.lua')
local CAAAutocannon = CybranWeaponsFile.CAAAutocannon
local CDFProtonCannonWeapon = CybranWeaponsFile.CDFProtonCannonWeapon
local CANNaniteTorpedoWeapon = CybranWeaponsFile.CANNaniteTorpedoWeapon
local CIFSmartCharge = import('/lua/cybranweapons.lua').CIFSmartCharge
local CIFArtilleryWeapon = import('/lua/cybranweapons.lua').CIFArtilleryWeapon
local DefaultProjectileWeapon = import('/lua/sim/DefaultWeapons.lua').DefaultProjectileWeapon


        
ANC_URS404 = Class(CSeaUnit) {
    Weapons = {
	    FlankCannon01 = Class(CDFProtonCannonWeapon) {},
	    FlankCannon02 = Class(CDFProtonCannonWeapon) {},
        MainCannon01 = Class(CDFProtonCannonWeapon) {},
        BackCannon01 = Class(CDFProtonCannonWeapon) {},
        Torpedo01 = Class(CANNaniteTorpedoWeapon) {},
        Torpedo02 = Class(CANNaniteTorpedoWeapon) {},
        AAGun01 = Class(CAAAutocannon) {},
        AAGun02 = Class(CAAAutocannon) {},
        LeftZapper = Class(CDFProtonCannonWeapon) {},
        RightZapper = Class(CDFProtonCannonWeapon) {},
        AntiTorpedo01 = Class(CIFSmartCharge) {},
        AntiTorpedo02 = Class(CIFSmartCharge) {},
        AntiTorpedo03 = Class(CIFSmartCharge) {},
        FrontCannon01 = Class(CIFArtilleryWeapon) {
            FxMuzzleFlashScale = 3,
	        FxVentEffect = EffectTemplate.CDisruptorVentEffect,
	        FxMuzzleEffect = EffectTemplate.CDisruptorMuzzleEffect,
	        FxCoolDownEffect = EffectTemplate.CDisruptorCoolDownEffect,
    

	        PlayFxMuzzleSequence = function(self, muzzle)
		        local army = self.unit:GetArmy()
		        DefaultProjectileWeapon.PlayFxMuzzleSequence(self, muzzle)
  	            for k, v in self.FxVentEffect do
                    CreateAttachedEmitter(self.unit, 'Front_Turret_Barrel01', army, v)
                    CreateAttachedEmitter(self.unit, 'Front_Turret_Barrel01', army, v)
                end
  	            for k, v in self.FxMuzzleEffect do
                    CreateAttachedEmitter(self.unit, 'Front_Muzzle01', army, v)
                end
  	            for k, v in self.FxCoolDownEffect do
                    CreateAttachedEmitter(self.unit, 'Front_Turret_Barrel01', army, v)
                end
            end
        },
    },
}

TypeClass = ANC_URS404