local TWalkingLandUnit = import('/lua/terranunits.lua').TWalkingLandUnit

local WeaponsFile = import('/lua/terranweapons.lua')
local TerranWeapons = import('/lua/terranweapons.lua')

local TDFIonizedPlasmaCannon = import('/lua/terranweapons.lua').TDFIonizedPlasmaCannon
local TAAGinsuRapidPulseWeapon = import('/lua/terranweapons.lua').TAAGinsuRapidPulseWeapon
local TIFCruiseMissileUnpackingLauncher = import('/lua/terranweapons.lua').TIFCruiseMissileUnpackingLauncher
local TIFCommanderDeathWeapon = import('/lua/terranweapons.lua').TIFCommanderDeathWeapon

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

local Shield = import('/lua/shield.lua').Shield

UELEW0004 = Class(TWalkingLandUnit) {

    Weapons = {
        DeathWeapon = Class(TIFCommanderDeathWeapon) {},
	PlasmaCannon01 = Class(TDFIonizedPlasmaCannon) {},
	RightBeam = Class(TAAGinsuRapidPulseWeapon) {},
        LeftBeam = Class(TAAGinsuRapidPulseWeapon) {},
        MissileWeapon01 = Class(TIFCruiseMissileUnpackingLauncher) 
        {
            FxMuzzleFlash = {'/effects/emitters/terran_mobile_missile_launch_01_emit.bp'},
            
            
            OnLostTarget = function(self)
                self:ForkThread( self.LostTargetThread )
            end,
            
            RackSalvoFiringState = State(TIFCruiseMissileUnpackingLauncher.RackSalvoFiringState) {
                OnLostTarget = function(self)
                    self:ForkThread( self.LostTargetThread )
                end,            
            },            

            LostTargetThread = function(self)
                while not self.unit:IsDead() and self.unit:IsUnitState('Busy') do
                    WaitSeconds(2)
                end

                if self.unit:IsDead() then
                    return
                end
                
                local bp = self:GetBlueprint()

                if bp.WeaponUnpacks then
                    ChangeState(self, self.WeaponPackingState)
                else
                    ChangeState(self, self.IdleState)
                end
            end,
        },
		MissileWeapon02 = Class(TIFCruiseMissileUnpackingLauncher) 
        {
            FxMuzzleFlash = {'/effects/emitters/terran_mobile_missile_launch_01_emit.bp'},
            
            
            OnLostTarget = function(self)
                self:ForkThread( self.LostTargetThread )
            end,
            
            RackSalvoFiringState = State(TIFCruiseMissileUnpackingLauncher.RackSalvoFiringState) {
                OnLostTarget = function(self)
                    self:ForkThread( self.LostTargetThread )
                end,            
            },            

            LostTargetThread = function(self)
                while not self.unit:IsDead() and self.unit:IsUnitState('Busy') do
                    WaitSeconds(2)
                end

                if self.unit:IsDead() then
                    return
                end
                
                local bp = self:GetBlueprint()

                if bp.WeaponUnpacks then
                    ChangeState(self, self.WeaponPackingState)
                else
                    ChangeState(self, self.IdleState)
                end
            end,
        },
    },
}

TypeClass = UELEW0004