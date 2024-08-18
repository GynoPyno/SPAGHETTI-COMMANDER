local SSeaUnit = import('/lua/seraphimunits.lua').SSeaUnit

local SeraphimWeapons = import('/lua/seraphimweapons.lua')
local SWeapons = import('/lua/seraphimweapons.lua')

local SIFHuAntiNukeWeapon = import('/lua/seraphimweapons.lua').SIFHuAntiNukeWeapon
local nukeFiredOnGotTarget = false
local SDFHeavyQuarnonCannon = SeraphimWeapons.SDFHeavyQuarnonCannon
local SAMElectrumMissileDefense = SeraphimWeapons.SAMElectrumMissileDefense
local SAAOlarisCannonWeapon = SeraphimWeapons.SAAOlarisCannonWeapon
local SIFInainoWeapon = import('/lua/seraphimweapons.lua').SIFInainoWeapon

local explosion = import('/lua/defaultexplosions.lua')
local util = import('/lua/utilities.lua')
local fxutil = import('/lua/effectutilities.lua')
local Effects = import('/lua/effecttemplates.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')

XSS0302 = Class(SSeaUnit) {
    FxDamageScale = 2,
    DestructionTicks = 400,

    Weapons = {
        BackTurret = Class(SDFHeavyQuarnonCannon) {},
        FrontTurret = Class(SDFHeavyQuarnonCannon) {},
        MidTurret = Class(SDFHeavyQuarnonCannon) {},
        AntiMissileLeft = Class(SAMElectrumMissileDefense) {},
        AntiMissileRight = Class(SAMElectrumMissileDefense) {},
        AntiAirLeft = Class(SAAOlarisCannonWeapon) {},
        AntiAirRight = Class(SAAOlarisCannonWeapon) {},
        InainoMissiles = Class(SIFInainoWeapon) {},
        MissileRack = Class(SIFHuAntiNukeWeapon) {
        
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
    },
}

TypeClass = XSS0302