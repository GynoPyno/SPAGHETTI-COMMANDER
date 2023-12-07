-----------------------------------------------------------------
-- File     :  /cdimage/units/URL0301/URL0301_script.lua
-- Author(s):  David Tomandl, Jessica St. Croix
-- Summary  :  Cybran Sub Commander Script
-- Copyright Š 2005 Gas Powered Games, Inc.  All rights reserved.
-----------------------------------------------------------------

---@alias CybranSCUEnhancementBuffType
---| "SCUBUILDRATE"
---| "SCUCLOAKBONUS"
---| "SCUREGENERATEBONUS"

---@alias CybranSCUEnhancementBuffName        # BuffType
---| "CybranSCUBuildRate"                     # SCUBUILDRATE
---| "CybranSCUCloakBonus"                    # SCUCLOAKBONUS
---| "CybranSCURegenerateBonus"               # SCUREGENERATEBONUS


local CybranUnits = import("/lua/cybranunits.lua")
local CCommandUnit = CybranUnits.CCommandUnit
local CWeapons = import("/lua/cybranweapons.lua")
local EffectUtil = import("/lua/effectutilities.lua")
local Buff = import("/lua/sim/buff.lua")
local CAAMissileNaniteWeapon = CWeapons.CAAMissileNaniteWeapon
local CDFLaserDisintegratorWeapon = CWeapons.CDFLaserDisintegratorWeapon02
local ADFDisruptorCannonWeapon = import("/lua/aeonweapons.lua").ADFDisruptorWeapon

---@class URL0301 : CCommandUnit
URL0301 = ClassUnit(CCommandUnit) {
    LeftFoot = 'Left_Foot02',
    RightFoot = 'Right_Foot02',

    Weapons = {
        RightDisintegrator = ClassWeapon(CDFLaserDisintegratorWeapon) {
            CreateProjectileAtMuzzle = function(self, muzzle)
                local proj = ADFDisruptorCannonWeapon.CreateProjectileAtMuzzle(self, muzzle)
                local data = self:GetBlueprint().DamageToShields
                if proj and not proj:BeenDestroyed() then
                    proj:PassData(data)
                end
                return proj
            end,
        },
    },

    __init = function(self)
        CCommandUnit.__init(self, 'RightDisintegrator')
    end,

    OnStopBeingBuilt = function(self, builder, layer)
        CCommandUnit.OnStopBeingBuilt(self, builder, layer)
        self:BuildManipulatorSetEnabled(false)
        self:SetMaintenanceConsumptionInactive()
        self:DisableUnitIntel('Enhancement', 'RadarStealth')
        self:DisableUnitIntel('Enhancement', 'SonarStealth')
        self:DisableUnitIntel('Enhancement', 'Cloak')
        self.LeftArmUpgrade = 'EngineeringArm'
        self.RightArmUpgrade = 'Disintegrator'
        self:SetCapturable(false)
        self:HideBone('AA_Gun', true)
        self:HideBone('Power_Pack', true)
        self:HideBone('Rez_Protocol', true)
        self:HideBone('Torpedo', true)
        self:HideBone('Turbine', true)
        self:SetWeaponEnabledByLabel('NMissile', false)
        if self.Blueprint.General.BuildBones then
            self:SetupBuildBones()
        end
    end,

}

TypeClass = URL0301
