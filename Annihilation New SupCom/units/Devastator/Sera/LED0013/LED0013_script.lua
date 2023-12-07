local SWalkingLandUnit = import('/lua/seraphimunits.lua').SWalkingLandUnit
local SWeapons = import('/lua/seraphimweapons.lua')

local Buff = import('/lua/sim/Buff.lua')
local Shield = import('/lua/shield.lua').Shield

local SIFCommanderDeathWeapon = SWeapons.SIFCommanderDeathWeapon
local SDFChronotronCannonWeapon = SWeapons.SDFChronotronCannonWeapon
local SDFAireauWeapon = import('/lua/seraphimweapons.lua').SDFAireauWeapon
local SIFLaanseTacticalMissileLauncher = SWeapons.SIFLaanseTacticalMissileLauncher
local SDFUnstablePhasonBeam = import('/lua/seraphimweapons.lua').SDFUnstablePhasonBeam
local SAALosaareAutoCannonWeapon = import('/lua/seraphimweapons.lua').SAALosaareAutoCannonWeapon
local SDFChronotronOverChargeCannonWeapon = SWeapons.SDFChronotronCannonOverChargeWeapon

local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')

local AIUtils = import('/lua/ai/aiutilities.lua')

LED0013 = Class( SWalkingLandUnit ) {
    DeathThreadDestructionWaitTime = 2,

    Weapons = {
        DeathWeapon = Class(SIFCommanderDeathWeapon) {},
        ChronotronCannon = Class(SDFChronotronCannonWeapon) {},
        MultiGun01 = Class(SDFAireauWeapon) {
        	OnCreate = function(self)
              SDFAireauWeapon.OnCreate(self)
            	if not self.SpinManip then 
              	self.SpinManip = CreateRotator(self.unit, 'SpinMultiGun', 'z', nil, 200, 200, 200)
                self.unit.Trash:Add(self.SpinManip)
              end
            end,
        },
        Missile = Class(SIFLaanseTacticalMissileLauncher) {
            OnCreate = function(self)
                SIFLaanseTacticalMissileLauncher.OnCreate(self)
                self:SetWeaponEnabled(false)
            end,
        },
        Electrobolter01 = Class(SDFUnstablePhasonBeam) 
    		{       
            OnCreate = function(self)
              SDFUnstablePhasonBeam.OnCreate(self)
            	if not self.SpinManip then 
                self.SpinManip = CreateRotator(self.unit, 'Electrobolter', 'z', nil, 250, 250, 250)
                self.unit.Trash:Add(self.SpinManip)
            	end
            end, 
    		},
    		AntiAirMissiles01 = Class(SAALosaareAutoCannonWeapon)
    		{
    				OnCreate = function(self)
              SAALosaareAutoCannonWeapon.OnCreate(self)
            	if not self.SpinManip then 
              	self.SpinManip = CreateRotator(self.unit, 'TurnPoint', 'y', nil, 40, 40, 40)
                self.unit.Trash:Add(self.SpinManip)
              end
            end,
        },
        AntiAirMissiles02 = Class(SAALosaareAutoCannonWeapon){},
        AntiAirMissiles03 = Class(SAALosaareAutoCannonWeapon){},
        AntiAirMissiles04 = Class(SAALosaareAutoCannonWeapon){},
        AntiAirMissiles05 = Class(SAALosaareAutoCannonWeapon){},
        AntiAirMissiles06 = Class(SAALosaareAutoCannonWeapon){},
        AntiAirMissiles07 = Class(SAALosaareAutoCannonWeapon){},
        AntiAirMissiles08 = Class(SAALosaareAutoCannonWeapon){},
        
        
        OverCharge = Class(SDFChronotronOverChargeCannonWeapon) {

            OnCreate = function(self)
                SDFChronotronOverChargeCannonWeapon.OnCreate(self)
                self:SetWeaponEnabled(false)
                self.AimControl:SetEnabled(false)
                self.AimControl:SetPrecedence(0)
				self.unit:SetOverchargePaused(false)
            end,

            OnEnableWeapon = function(self)
                if self:BeenDestroyed() then return end
                SDFChronotronOverChargeCannonWeapon.OnEnableWeapon(self)
                self:SetWeaponEnabled(true)
                self.unit:SetWeaponEnabledByLabel('ChronotronCannon', false)
                self.unit:BuildManipulatorSetEnabled(false)
                self.AimControl:SetEnabled(true)
                self.AimControl:SetPrecedence(20)
                self.unit.BuildArmManipulator:SetPrecedence(0)
                self.AimControl:SetHeadingPitch( self.unit:GetWeaponManipulatorByLabel('ChronotronCannon'):GetHeadingPitch() )
            end,
            
            OnWeaponFired = function(self)
                SDFChronotronOverChargeCannonWeapon.OnWeaponFired(self)
                self:OnDisableWeapon()
                self:ForkThread(self.PauseOvercharge)
            end,
            
            OnDisableWeapon = function(self)
                if self.unit:BeenDestroyed() then return end
                self:SetWeaponEnabled(false)
                self.unit:SetWeaponEnabledByLabel('ChronotronCannon', true)
                self.unit:BuildManipulatorSetEnabled(false)
                self.AimControl:SetEnabled(false)
                self.AimControl:SetPrecedence(0)
                self.unit.BuildArmManipulator:SetPrecedence(0)
                self.unit:GetWeaponManipulatorByLabel('ChronotronCannon'):SetHeadingPitch( self.AimControl:GetHeadingPitch() )
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
                    SDFChronotronOverChargeCannonWeapon.OnFire(self)
                end
            end,
            IdleState = State(SDFChronotronOverChargeCannonWeapon.IdleState) {
                OnGotTarget = function(self)
                    if not self.unit:IsOverchargePaused() then
                        SDFChronotronOverChargeCannonWeapon.IdleState.OnGotTarget(self)
                    end
                end,            
                OnFire = function(self)
                    if not self.unit:IsOverchargePaused() then
                        ChangeState(self, self.RackSalvoFiringState)
                    end
                end,
            },
            RackSalvoFireReadyState = State(SDFChronotronOverChargeCannonWeapon.RackSalvoFireReadyState) {
                OnFire = function(self)
                    if not self.unit:IsOverchargePaused() then
                        SDFChronotronOverChargeCannonWeapon.RackSalvoFireReadyState.OnFire(self)
                    end
                end,
            },  
        },
    },

    OnStartBuild = function(self, unitBeingBuilt, order)
        SWalkingLandUnit.OnStartBuild(self, unitBeingBuilt, order)
        self.UnitBeingBuilt = unitBeingBuilt
        self.UnitBuildOrder = order
        self.BuildingUnit = true     
    end,

    OnStopBuild = function(self, unitBeingBuilt)
        SWalkingLandUnit.OnStopBuild(self, unitBeingBuilt)
        if self:BeenDestroyed() then return end
        self.UnitBeingBuilt = nil
        self.UnitBuildOrder = nil
        self.BuildingUnit = false          
    end,

    CreateBuildEffects = function( self, unitBeingBuilt, order )
        EffectUtil.CreateAeonCommanderBuildingEffects( self, unitBeingBuilt, self:GetBlueprint().General.BuildBones.BuildEffectBones, self.BuildEffectsBag )
    end,

    OnPaused = function(self)
        SWalkingLandUnit.OnPaused(self)
        if self.BuildingUnit then
			SWalkingLandUnit.StopBuildingEffects(self, self:GetUnitBeingBuilt())
        end
    end,

    OnUnpaused = function(self)
        if self.BuildingUnit then
            SWalkingLandUnit.StartBuildingEffects(self, self:GetUnitBeingBuilt(), self.UnitBuildOrder)
        end
        SWalkingLandUnit.OnUnpaused(self)
    end,

}

TypeClass = LED0013