--#****************************************************************************
--#**
--#**  File     :  /mods/Hyper Experimental Tier/units/EXEB2306/EXEB2306_script.lua
--#**  Author(s):  Cmd Draven
--#**
--#**  Summary  :  Terran Experimental Gatling Tower Script
--#**
--#****************************************************************************
local TStructureUnit = import('/lua/terranunits.lua').TStructureUnit
local TDFHeavyPlasmaCannonWeapon = import('/lua/terranweapons.lua').TDFHeavyPlasmaGatlingCannonWeapon
local EffectUtils = import('/lua/effectutilities.lua')
local Effects = import('/lua/effecttemplates.lua')

EXEB2306 = Class(TStructureUnit) {
    Weapons = {
        LeftGun = Class(TDFHeavyPlasmaCannonWeapon)
        {
            PlayFxWeaponPackSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(0)
                end
                TDFHeavyPlasmaCannonWeapon.PlayFxWeaponPackSequence(self)
            end,

            PlayFxRackSalvoChargeSequence = function(self)
                if not self.SpinManip then
                    self.SpinManip = CreateRotator(self.unit, 'LBarrelSpin', 'z', nil, 270, 180, 60)
                    self.unit.Trash:Add(self.SpinManip)
                end

                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(500)
                end
                TDFHeavyPlasmaCannonWeapon.PlayFxRackSalvoChargeSequence(self)
            end,

            PlayFxRackSalvoReloadSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(200)
                end
                TDFHeavyPlasmaCannonWeapon.PlayFxRackSalvoChargeSequence(self)
            end,
        },
		RightGun = Class(TDFHeavyPlasmaCannonWeapon)
        {
            PlayFxWeaponPackSequence = function(self)
                if self.SpinManipulator then
                    self.SpinManipulator:SetTargetSpeed(0)
                end
                TDFHeavyPlasmaCannonWeapon.PlayFxWeaponPackSequence(self)
            end,

            PlayFxRackSalvoChargeSequence = function(self)
                if not self.SpinManipulator then
                    self.SpinManipulator = CreateRotator(self.unit, 'RBarrelSpin', 'z', nil, 270, 180, 60)
                    self.unit.Trash:Add(self.SpinManipulator)
                end

                if self.SpinManipulator then
                    self.SpinManipulator:SetTargetSpeed(500)
                end
                TDFHeavyPlasmaCannonWeapon.PlayFxRackSalvoChargeSequence(self)
            end,

            PlayFxRackSalvoReloadSequence = function(self)
                if self.SpinManipulator then
                    self.SpinManipulator:SetTargetSpeed(200)
                end
                TDFHeavyPlasmaCannonWeapon.PlayFxRackSalvoChargeSequence(self)
            end,
        },
    },
}

TypeClass = EXEB2306
