local CWalkingLandUnit = import( '/lua/cybranunits.lua').CWalkingLandUnit

local Weapon = import('/lua/sim/Weapon.lua').Weapon
local WeaponFile = import('/lua/sim/defaultweapons.lua')
local CybranWeaponsFile = import('/lua/cybranweapons.lua')

local Buff = import('/lua/sim/Buff.lua')

local EffectTemplate = import('/lua/EffectTemplates.lua')
local utilities = import('/lua/Utilities.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')
local Entity = import('/lua/sim/Entity.lua').Entity

local CIFCommanderDeathWeapon = CybranWeaponsFile.CIFCommanderDeathWeapon
local CDFOverchargeWeapon = CybranWeaponsFile.CDFOverchargeWeapon

local CCannonMolecularWeapon = CybranWeaponsFile.CCannonMolecularWeapon
local CDFHeavyMicrowaveLaserGeneratorCom = CybranWeaponsFile.CDFHeavyMicrowaveLaserGeneratorCom
local CIFArtilleryWeapon = import('/lua/cybranweapons.lua').CIFArtilleryWeapon
local CDFParticleCannonWeapon = import('/lua/cybranweapons.lua').CDFParticleCannonWeapon
local CAMZapperWeapon = import('/lua/cybranweapons.lua').CAMZapperWeapon02
local CAAMissileNaniteWeapon = import('/lua/cybranweapons.lua').CAAMissileNaniteWeapon
local CANTorpedoLauncherWeapon = CybranWeaponsFile.CANTorpedoLauncherWeapon

VOS0013 = Class(CWalkingLandUnit) {
    DeathThreadDestructionWaitTime = 2,

    Weapons = {
        Arti01 = Class(CIFArtilleryWeapon) {
					DisabledFiringBones = {'Arti02'},
            FxMuzzleFlash = {
                '/effects/emitters/cybran_artillery_muzzle_flash_01_emit.bp',
                '/effects/emitters/cybran_artillery_muzzle_flash_02_emit.bp',
                '/effects/emitters/cybran_artillery_muzzle_smoke_01_emit.bp',
            },
        },

        AntiAir01 = Class(CDFParticleCannonWeapon) {
            FxMuzzleFlash = {'/effects/emitters/particle_cannon_muzzle_02_emit.bp'},
        },
        AntiAir02 = Class(CDFParticleCannonWeapon) {
            FxMuzzleFlash = {'/effects/emitters/particle_cannon_muzzle_02_emit.bp'},
        },

        Missile01 = Class(CAAMissileNaniteWeapon) {},
        Missile02 = Class(CAAMissileNaniteWeapon) {},
        Missile03 = Class(CAAMissileNaniteWeapon) {},
        Missile04 = Class(CAAMissileNaniteWeapon) {},
        
        AntiMissile01 = Class(CAMZapperWeapon) {},
        AntiMissile02 = Class(CAMZapperWeapon) {},
        
        Bullseye01 = Class(CDFHeavyMicrowaveLaserGeneratorCom) {},

        RightRipper = Class(CCannonMolecularWeapon) {},
        RightR01 = Class(CCannonMolecularWeapon) {},
	RightRipper_impr = Class(CCannonMolecularWeapon) {},
				
        DeathWeapon = Class(CIFCommanderDeathWeapon) {},
        
        Torpedo = Class(CANTorpedoLauncherWeapon) {},

        MLG = Class(CDFHeavyMicrowaveLaserGeneratorCom) {
            DisabledFiringBones = {'Turret_Muzzle_03'},
            
            SetOnTransport = function(self, transportstate)
                CDFHeavyMicrowaveLaserGeneratorCom.SetOnTransport(self, transportstate)
                self:ForkThread(self.OnTransportWatch)
            end,
            
            OnTransportWatch = function(self)
                while self:GetOnTransport() do
                    self:PlayFxBeamEnd()
                    self:SetWeaponEnabled(false)
                    WaitSeconds(0.3)
                end
            end,          
        },

        OverCharge = Class(CDFOverchargeWeapon) {
            OnCreate = function(self)
                CDFOverchargeWeapon.OnCreate(self)
                self:SetWeaponEnabled(false)
                self.AimControl:SetEnabled(false)
                self.AimControl:SetPrecedence(0)
				self.unit:SetOverchargePaused(false)
            end,

            OnEnableWeapon = function(self)
                if self:BeenDestroyed() then return end
                CDFOverchargeWeapon.OnEnableWeapon(self)
                self:SetWeaponEnabled(true)
                self.unit:SetWeaponEnabledByLabel('RightRipper', false)
                self.unit:BuildManipulatorSetEnabled(false)
                self.AimControl:SetEnabled(true)
                self.AimControl:SetPrecedence(20)
                self.unit.BuildArmManipulator:SetPrecedence(0)
                self.AimControl:SetHeadingPitch( self.unit:GetWeaponManipulatorByLabel('RightRipper'):GetHeadingPitch() )
            end,

            OnWeaponFired = function(self)
                CDFOverchargeWeapon.OnWeaponFired(self)
                self:OnDisableWeapon()
                self:ForkThread(self.PauseOvercharge)
            end,
            
            OnDisableWeapon = function(self)
                if self.unit:BeenDestroyed() then return end
                self:SetWeaponEnabled(false)
                self.unit:SetWeaponEnabledByLabel('RightRipper', true)
                self.unit:BuildManipulatorSetEnabled(false)
                self.AimControl:SetEnabled(false)
                self.AimControl:SetPrecedence(0)
                self.unit.BuildArmManipulator:SetPrecedence(0)
                self.unit:GetWeaponManipulatorByLabel('RightRipper'):SetHeadingPitch( self.AimControl:GetHeadingPitch() )
            end,
            
            PauseOvercharge = function(self)
                if not self.unit:IsOverchargePaused() then
                    self.unit:SetOverchargePaused(true)
                    WaitSeconds(1/self:GetBlueprint().RateOfFire)
                    self.unit:SetOverchargePaused(false)
                end
            end,
            
            OnFire = function(self)
                if not self.unit:IsOverchargePaused() then
                    CDFOverchargeWeapon.OnFire(self)
                end
            end,
            IdleState = State(CDFOverchargeWeapon.IdleState) {
                OnGotTarget = function(self)
                    if not self.unit:IsOverchargePaused() then
                        CDFOverchargeWeapon.IdleState.OnGotTarget(self)
                    end
                end,            
                OnFire = function(self)
                    if not self.unit:IsOverchargePaused() then
                        ChangeState(self, self.RackSalvoFiringState)
                    end
                end,
            },
            RackSalvoFireReadyState = State(CDFOverchargeWeapon.RackSalvoFireReadyState) {
                OnFire = function(self)
                    if not self.unit:IsOverchargePaused() then
                        CDFOverchargeWeapon.RackSalvoFireReadyState.OnFire(self)
                    end
                end,
            },    
        },
    },

    OnStartBuild = function(self, unitBeingBuilt, order)
        CWalkingLandUnit.OnStartBuild(self, unitBeingBuilt, order)
        self.UnitBeingBuilt = unitBeingBuilt
        self.UnitBuildOrder = order
        self.BuildingUnit = true     
    end,

    OnStopBuild = function(self, unitBeingBuilt)
        CWalkingLandUnit.OnStopBuild(self, unitBeingBuilt)
        if self:BeenDestroyed() then return end
        self.UnitBeingBuilt = nil
        self.UnitBuildOrder = nil
        self.BuildingUnit = false          
    end,

    CreateBuildEffects = function( self, unitBeingBuilt, order )
	
       EffectUtil.CreateCybranBuildBeams( self, unitBeingBuilt, self:GetBlueprint().General.BuildBones.BuildEffectBones, self.BuildEffectsBag )
    end,

    OnPaused = function(self)
        CWalkingLandUnit.OnPaused(self)
        if self.BuildingUnit then
            CWalkingLandUnit.StopBuildingEffects(self, self:GetUnitBeingBuilt())
        end    
    end,
    
    OnUnpaused = function(self)
        if self.BuildingUnit then
            CWalkingLandUnit.StartBuildingEffects(self, self:GetUnitBeingBuilt(), self.UnitBuildOrder)
        end
        CWalkingLandUnit.OnUnpaused(self)
    end,     
}   
    
TypeClass = VOS0013
