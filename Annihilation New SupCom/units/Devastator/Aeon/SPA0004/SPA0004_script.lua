local Shield = import('/lua/shield.lua').Shield
local AWalkingLandUnit = import('/lua/aeonunits.lua').AWalkingLandUnit
local AWeapons = import('/lua/aeonweapons.lua')

local AIFCommanderDeathWeapon = import('/lua/aeonweapons.lua').AIFCommanderDeathWeapon
local ADFDisruptorCannonWeapon = AWeapons.ADFDisruptorCannonWeapon
local ADFChronoDampener = AWeapons.ADFChronoDampener
local AAAZealotMissileWeapon = import('/lua/aeonweapons.lua').AAAZealotMissileWeapon

local ADFOverchargeWeapon = AWeapons.ADFOverchargeWeapon

local Buff = import('/lua/sim/Buff.lua')

local EffectTemplate = import('/lua/EffectTemplates.lua')
local utilities = import('/lua/Utilities.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')
local Entity = import('/lua/sim/Entity.lua').Entity

SPA0004 = Class(AWalkingLandUnit) {

    DeathThreadDestructionWaitTime = 2,

    Weapons = {
        DeathWeapon = Class(AIFCommanderDeathWeapon) {},
        RightDisruptor = Class(ADFDisruptorCannonWeapon) {},
        ChronoDampener = Class(ADFChronoDampener) {},
	QuantumCooler01 = Class(ADFDisruptorCannonWeapon) {},
	LeftQuantum01 = Class(ADFDisruptorCannonWeapon) {},
	LeftAntiAir01 = Class(AAAZealotMissileWeapon) {},
	RightAntiAir01 = Class(AAAZealotMissileWeapon) {},
	Multimissile01 = Class(AAAZealotMissileWeapon) {},
	AdvChronoDampener01 = Class(ADFChronoDampener) {},
	LeftDisruptor01 = Class(ADFDisruptorCannonWeapon) {},
        OblivionGun01 = Class(import('/lua/aeonweapons.lua').ADFCannonOblivionWeapon) {
		FxMuzzleFlash = {
		'/effects/emitters/oblivion_cannon_flash_04_emit.bp',
		'/effects/emitters/oblivion_cannon_flash_05_emit.bp',
		'/effects/emitters/oblivion_cannon_flash_06_emit.bp',
							},        
        },
	OverCharge = Class(ADFOverchargeWeapon) {        
            OnCreate = function(self)
                ADFOverchargeWeapon.OnCreate(self)
                self:SetWeaponEnabled(false)
                self.AimControl:SetEnabled(false)
                self.AimControl:SetPrecedence(0)
				self.unit:SetOverchargePaused(false)
            end,

            OnEnableWeapon = function(self)
                if self:BeenDestroyed() then return end
                ADFOverchargeWeapon.OnEnableWeapon(self)
                self:SetWeaponEnabled(true)
                self.unit:SetWeaponEnabledByLabel('RightDisruptor', false)
                self.unit:BuildManipulatorSetEnabled(false)
                self.AimControl:SetEnabled(true)
                self.AimControl:SetPrecedence(20)
                self.unit.BuildArmManipulator:SetPrecedence(0)
                self.AimControl:SetHeadingPitch( self.unit:GetWeaponManipulatorByLabel('RightDisruptor'):GetHeadingPitch() )
            end,

            OnWeaponFired = function(self)
                ADFOverchargeWeapon.OnWeaponFired(self)
                self:OnDisableWeapon()
                self:ForkThread(self.PauseOvercharge)
            end,
            
            OnDisableWeapon = function(self)
                if self.unit:BeenDestroyed() then return end
                self:SetWeaponEnabled(false)
                self.unit:SetWeaponEnabledByLabel('RightDisruptor', true)
                self.unit:BuildManipulatorSetEnabled(false)
                self.AimControl:SetEnabled(false)
                self.AimControl:SetPrecedence(0)
                self.unit.BuildArmManipulator:SetPrecedence(0)
                self.unit:GetWeaponManipulatorByLabel('RightDisruptor'):SetHeadingPitch( self.AimControl:GetHeadingPitch() )
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
                    ADFOverchargeWeapon.OnFire(self)
                end
            end,
            IdleState = State(ADFOverchargeWeapon.IdleState) {
                OnGotTarget = function(self)
                    if not self.unit:IsOverchargePaused() then
                        ADFOverchargeWeapon.IdleState.OnGotTarget(self)
                    end
                end,            
                OnFire = function(self)
                    if not self.unit:IsOverchargePaused() then
                        ChangeState(self, self.RackSalvoFiringState)
                    end
                end,
            },
            RackSalvoFireReadyState = State(ADFOverchargeWeapon.RackSalvoFireReadyState) {
                OnFire = function(self)
                    if not self.unit:IsOverchargePaused() then
                        ADFOverchargeWeapon.RackSalvoFireReadyState.OnFire(self)
                    end
                end,
            },              
        },
    }, 

    OnStartBuild = function(self, unitBeingBuilt, order)
        AWalkingLandUnit.OnStartBuild(self, unitBeingBuilt, order)
        self.UnitBeingBuilt = unitBeingBuilt
        self.UnitBuildOrder = order
        self.BuildingUnit = true     
    end,

    OnStopBuild = function(self, unitBeingBuilt)
        AWalkingLandUnit.OnStopBuild(self, unitBeingBuilt)
        if self:BeenDestroyed() then return end
        self.UnitBeingBuilt = nil
        self.UnitBuildOrder = nil
        self.BuildingUnit = false          
    end,

    CreateBuildEffects = function( self, unitBeingBuilt, order )
        EffectUtil.CreateAeonCommanderBuildingEffects( self, unitBeingBuilt, self:GetBlueprint().General.BuildBones.BuildEffectBones, self.BuildEffectsBag )
    end,

    OnPaused = function(self)
        if self.BuildingUnit then
			AWalkingLandUnit.StopBuildingEffects(self, self:GetUnitBeingBuilt())
        end
		AWalkingLandUnit.OnPaused(self)
    end,
    
    OnUnpaused = function(self)
        if self.BuildingUnit then
            AWalkingLandUnit.StartBuildingEffects(self, self.UnitBeingBuilt, self.UnitBuildOrder)
        end
        AWalkingLandUnit.OnUnpaused(self)
    end,
	

	
}

TypeClass = SPA0004