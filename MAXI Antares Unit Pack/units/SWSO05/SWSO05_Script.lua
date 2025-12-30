local SAirUnit = import('/lua/seraphimunits.lua').SAirUnit

local SeraphimWeapons = import('/lua/seraphimweapons.lua')

local SIFInainoWeapon = import('/lua/seraphimweapons.lua').SIFInainoWeapon
local SIFHuAntiNukeWeapon = import('/lua/seraphimweapons.lua').SIFHuAntiNukeWeapon
local nukeFiredOnGotTarget = false
local SDFHeavyQuarnonCannon = import('/lua/seraphimweapons.lua').SDFHeavyQuarnonCannon

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

SWSO05 = Class(SAirUnit) {
	DestroyNoFallRandomChance = 1.1,
    FxDamageScale = 2,
    DestructionTicks = 400,

    Weapons = {
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
        FrontTurret01 = Class(SDFHeavyQuarnonCannon) {},
        FrontTurret02 = Class(SDFHeavyQuarnonCannon) {},
        BackTurret01 = Class(SDFHeavyQuarnonCannon) {},
        BackTurret02 = Class(SDFHeavyQuarnonCannon) {},
    },
	
    ContrailEffects = {'/effects/emitters/contrail_ser_ohw_polytrail_01_emit.bp',},		
	
}

TypeClass = SWSO05