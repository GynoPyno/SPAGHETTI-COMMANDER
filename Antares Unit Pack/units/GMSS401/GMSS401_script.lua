local SSeaUnit = import('/lua/seraphimunits.lua').SSeaUnit

local WeaponsFile = import('/lua/seraphimweapons.lua')
local SeraphimWeapons = import('/lua/seraphimweapons.lua')
local SWeapons = import('/lua/seraphimweapons.lua')

local SIFHuAntiNukeWeapon = import('/lua/seraphimweapons.lua').SIFHuAntiNukeWeapon
local nukeFiredOnGotTarget = false
local SIFInainoWeapon = import('/lua/seraphimweapons.lua').SIFInainoWeapon
local SDFHeavyQuarnonCannon = SeraphimWeapons.SDFHeavyQuarnonCannon
local SDFUltraChromaticBeamGenerator = WeaponsFile.SDFUltraChromaticBeamGenerator
local SANHeavyCavitationTorpedo = SeraphimWeapons.SANHeavyCavitationTorpedo
local SLaanseMissileWeapon = SeraphimWeapons.SLaanseMissileWeapon
local SIFCommanderDeathWeapon = SWeapons.SIFCommanderDeathWeapon

local explosion = import('/lua/defaultexplosions.lua')

local util = import('/lua/utilities.lua')
local utilities = import('/lua/Utilities.lua')
local fxutil = import('/lua/effectutilities.lua')
local Effects = import('/lua/effecttemplates.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')
local EffectUtils = import('/lua/EffectUtilities.lua')
local ExhaustBeam = import('/lua/effecttemplates.lua')
local ExhaustEffects = import('/lua/effecttemplates.lua')

local AIUtils = import('/lua/ai/aiutilities.lua')

GMSS401 = Class(SSeaUnit) {
    Weapons = {
        DeathWeapon = Class(SIFCommanderDeathWeapon) {},
        MainGun = Class(SDFHeavyQuarnonCannon) {},
        MainTurret2 = Class(SDFUltraChromaticBeamGenerator) {},
        Torpedo = Class(SANHeavyCavitationTorpedo) {},
        AntiAirMissile01 = Class(SLaanseMissileWeapon) {},
        AntiAirMissile02 = Class(SLaanseMissileWeapon) {},
        Missile01 = Class(SIFHuAntiNukeWeapon) {
        
            IdleState = State(SIFHuAntiNukeWeapon.IdleState) {
                OnGotTarget = function(self)
                    local bp = self:GetBlueprint()
                    #only say we've fired if the parent fire conditions are met
                    if (bp.WeaponUnpackLockMotion != true or (bp.WeaponUnpackLocksMotion == true and not self.unit:IsUnitState('Moving'))) then
                        if (bp.CountedProjectile == false) or self:CanFire() then
                             nukeFiredOnGotTarget = true
                        end
                    end
                    SIFHuAntiNukeWeapon.IdleState.OnGotTarget(self)
                end,
                # uses OnGotTarget, so we shouldn't do this.
                OnFire = function(self)
                    if not nukeFiredOnGotTarget then
                        SIFHuAntiNukeWeapon.IdleState.OnFire(self)
                    end
                    nukeFiredOnGotTarget = false
                    
                    self:ForkThread(function()
                        self.unit:SetBusy(true)
                        WaitSeconds(1/self.unit:GetBlueprint().Weapon[1].RateOfFire + .2)
                        self.unit:SetBusy(false)
                    end)
                end,
            },        
        },
        Missile02 = Class(SIFInainoWeapon) {},
    },

    OnCreate = function(self)
        SSeaUnit.OnCreate(self)
        self:SetWeaponEnabledByLabel('AntiAirMissile01', false)
        self:SetWeaponEnabledByLabel('AntiAirMissile02', false)
    end,
    
    OnScriptBitSet = function(self, bit)
        SSeaUnit.OnScriptBitSet(self, bit)
        if bit == 1 then 
            self:SetWeaponEnabledByLabel('AntiAirMissile01', true)
            self:SetWeaponEnabledByLabel('AntiAirMissile02', true)
            self:SetWeaponEnabledByLabel('Missile01', false)
            self:SetWeaponEnabledByLabel('Missile02', false)
            self:RemoveCommandCap('RULEUCC_Nuke')
            self:RemoveCommandCap('RULEUCC_SiloBuildNuke')
            self:RemoveCommandCap('RULEUCC_SiloBuildTactical')
        end
    end,

    OnScriptBitClear = function(self, bit)
        SSeaUnit.OnScriptBitClear(self, bit)
        if bit == 1 then 
            self:SetWeaponEnabledByLabel('AntiAirMissile01', false)
            self:SetWeaponEnabledByLabel('AntiAirMissile02', false)
            self:SetWeaponEnabledByLabel('Missile01', true)
            self:SetWeaponEnabledByLabel('Missile02', true)
            self:AddCommandCap('RULEUCC_Nuke')
            self:AddCommandCap('RULEUCC_SiloBuildNuke')
            self:AddCommandCap('RULEUCC_SiloBuildTactical')
        end
    end,
}

TypeClass = GMSS401