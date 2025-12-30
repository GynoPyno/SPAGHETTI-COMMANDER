local TWalkingLandUnit = import('/lua/terranunits.lua').TWalkingLandUnit

local Shield = import('/lua/shield.lua').Shield

local TerranWeaponFile = import('/lua/terranweapons.lua')

local TDFZephyrCannonWeapon = TerranWeaponFile.TDFZephyrCannonWeapon
local TDFHeavyPlasmaCannonWeapon = TerranWeaponFile.TDFHeavyPlasmaCannonWeapon
local TIFCommanderDeathWeapon = TerranWeaponFile.TIFCommanderDeathWeapon
local TIFCruiseMissileLauncher = TerranWeaponFile.TIFCruiseMissileLauncher
local TSAMLauncher = import('/lua/terranweapons.lua').TSAMLauncher
local TDFOverchargeWeapon = TerranWeaponFile.TDFOverchargeWeapon

local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')
local Buff = import('/lua/sim/Buff.lua')

UEL00011 = Class(TWalkingLandUnit) { 
    DeathThreadDestructionWaitTime = 2,

    Weapons = {
		###### Heavy Bolter #### Left And Right #### Debut ####
		HeavyPlasma01 = Class(TDFHeavyPlasmaCannonWeapon) {},
		HeavyPlasma02 = Class(TDFHeavyPlasmaCannonWeapon) {},
		###### Heavy Bolter #### Left And Right #### Fin ####
        DeathWeapon = Class(TIFCommanderDeathWeapon) {},
		###### Heavy MEGA OVER CANON #### Left And Right #### debut ####
		Megacannon01 = Class(TDFZephyrCannonWeapon) {},
		Megacannon02 = Class(TDFZephyrCannonWeapon) {},	
		Megacannon03 = Class(TDFZephyrCannonWeapon) {},
		Megacannon04 = Class(TDFZephyrCannonWeapon) {},	
		###### Heavy MEGA OVER CANON #### Left And Right #### FIN ####
		###### Heavy Anti Air #### Left And Right #### debut ####
		MissileRack01 = Class(TSAMLauncher) {},		
		MissileRack02 = Class(TSAMLauncher) {},	
		###### Heavy Anti Air #### Left And Right #### Fin ####
    Minigun01 = Class(TDFHeavyPlasmaCannonWeapon) 
    {       
          OnCreate = function(self)
            	TDFHeavyPlasmaCannonWeapon.OnCreate(self)
            	if not self.SpinManip then 
                   self.SpinManip = CreateRotator(self.unit, 'Minigun01_Barrel', 'z', nil, 350, 350, 350)
                   self.unit.Trash:Add(self.SpinManip)
            	end
           end,
    },
    Minigun02 = Class(TDFHeavyPlasmaCannonWeapon) 
    {       
          OnCreate = function(self)
            	TDFHeavyPlasmaCannonWeapon.OnCreate(self)
            	if not self.SpinManip then 
                   self.SpinManip = CreateRotator(self.unit, 'Minigun02_Barrel', 'z', nil, 350, 350, 350)
                   self.unit.Trash:Add(self.SpinManip)
            	end
           end,
    },  
        RightZephyr = Class(TDFZephyrCannonWeapon) {},
        LeftZephyr = Class(TDFZephyrCannonWeapon) {},
        OverCharge = Class(TDFOverchargeWeapon) {
            OnCreate = function(self)
                TDFOverchargeWeapon.OnCreate(self)
                self:SetWeaponEnabled(false)
                self.AimControl:SetEnabled(false)
                self.AimControl:SetPrecedence(0)
                self.unit:SetOverchargePaused(false)
            end,

            OnEnableWeapon = function(self)
                if self:BeenDestroyed() then return end
                self:SetWeaponEnabled(true)
                self.unit:SetWeaponEnabledByLabel('RightZephyr', false)
                self.unit:ResetWeaponByLabel('RightZephyr')
                self.unit:BuildManipulatorSetEnabled(false)
                self.AimControl:SetEnabled(true)
                self.AimControl:SetPrecedence(20)
                self.unit.BuildArmManipulator:SetPrecedence(0)
                self.AimControl:SetHeadingPitch( self.unit:GetWeaponManipulatorByLabel('RightZephyr'):GetHeadingPitch() )
            end,

            OnWeaponFired = function(self)
                TDFOverchargeWeapon.OnWeaponFired(self)
                self:OnDisableWeapon()
                self:ForkThread(self.PauseOvercharge)
            end,
            
            OnDisableWeapon = function(self)
                if self.unit:BeenDestroyed() then return end
                self:SetWeaponEnabled(false)
                self.unit:SetWeaponEnabledByLabel('RightZephyr', true)
                self.unit:BuildManipulatorSetEnabled(false)
                self.AimControl:SetEnabled(false)
                self.AimControl:SetPrecedence(0)
                self.unit.BuildArmManipulator:SetPrecedence(0)
                self.unit:GetWeaponManipulatorByLabel('RightZephyr'):SetHeadingPitch( self.AimControl:GetHeadingPitch() )
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
                    TDFOverchargeWeapon.OnFire(self)
                end
            end,
            IdleState = State(TDFOverchargeWeapon.IdleState) {
                OnGotTarget = function(self)
                    if not self.unit:IsOverchargePaused() then
                        TDFOverchargeWeapon.IdleState.OnGotTarget(self)
                    end
                end,            
                OnFire = function(self)
                    if not self.unit:IsOverchargePaused() then
                        ChangeState(self, self.RackSalvoFiringState)
                    end
                end,
            },
            RackSalvoFireReadyState = State(TDFOverchargeWeapon.RackSalvoFireReadyState) {
                OnFire = function(self)
                    if not self.unit:IsOverchargePaused() then
                        TDFOverchargeWeapon.RackSalvoFireReadyState.OnFire(self)
                    end
                end,
            },                        
        },
    },

    OnPrepareArmToBuild = function(self)
        TWalkingLandUnit.OnPrepareArmToBuild(self)
        if self:BeenDestroyed() then return end
        self:BuildManipulatorSetEnabled(true)
        self.BuildArmManipulator:SetPrecedence(20)
        self.BuildArmManipulator:SetHeadingPitch( self:GetWeaponManipulatorByLabel('RightZephyr'):GetHeadingPitch() )
    end,

    OnStopCapture = function(self, target)
        TWalkingLandUnit.OnStopCapture(self, target)
        if self:BeenDestroyed() then return end
        self:BuildManipulatorSetEnabled(false)
        self.BuildArmManipulator:SetPrecedence(0)
        self:GetWeaponManipulatorByLabel('RightZephyr'):SetHeadingPitch( self.BuildArmManipulator:GetHeadingPitch() )
    end,

    OnFailedCapture = function(self, target)
        TWalkingLandUnit.OnFailedCapture(self, target)
        self:BuildManipulatorSetEnabled(false)
        self.BuildArmManipulator:SetPrecedence(0)
        self:GetWeaponManipulatorByLabel('RightZephyr'):SetHeadingPitch( self.BuildArmManipulator:GetHeadingPitch() )
    end,

    OnStopReclaim = function(self, target)
        TWalkingLandUnit.OnStopReclaim(self, target)
        if self:BeenDestroyed() then return end
        self:BuildManipulatorSetEnabled(false)
        self.BuildArmManipulator:SetPrecedence(0)
        self:GetWeaponManipulatorByLabel('RightZephyr'):SetHeadingPitch( self.BuildArmManipulator:GetHeadingPitch() )
    end,

    OnStartBuild = function(self, unitBeingBuilt, order)
        TWalkingLandUnit.OnStartBuild(self, unitBeingBuilt, order)
        if self.Animator then
            self.Animator:SetRate(0)
        end
        self.UnitBeingBuilt = unitBeingBuilt
        self.UnitBuildOrder = order
        self.BuildingUnit = true        
    end,

    OnFailedToBuild = function(self)
        TWalkingLandUnit.OnFailedToBuild(self)
        if self:BeenDestroyed() then return end
        self:BuildManipulatorSetEnabled(false)
        self.BuildArmManipulator:SetPrecedence(0)
        self:GetWeaponManipulatorByLabel('RightZephyr'):SetHeadingPitch( self.BuildArmManipulator:GetHeadingPitch() )
    end,

    CreateBuildEffects = function( self, unitBeingBuilt, order )
        local UpgradesFrom = unitBeingBuilt:GetBlueprint().General.UpgradesFrom
        if (order == 'Repair' and not unitBeingBuilt:IsBeingBuilt()) or (UpgradesFrom and UpgradesFrom != 'none' and self:IsUnitState('Guarding'))then
            EffectUtil.CreateDefaultBuildBeams( self, unitBeingBuilt, self:GetBlueprint().General.BuildBones.BuildEffectBones, self.BuildEffectsBag )
        else
            EffectUtil.CreateUEFCommanderBuildSliceBeams( self, unitBeingBuilt, self:GetBlueprint().General.BuildBones.BuildEffectBones, self.BuildEffectsBag )        
        end           
    end,

    OnStopBuild = function(self, unitBeingBuilt)
        TWalkingLandUnit.OnStopBuild(self, unitBeingBuilt)
        if self:BeenDestroyed() then return end
        if (self.IdleAnim and not self:IsDead()) then
            self.Animator:PlayAnim(self.IdleAnim, true)
        end
        self:BuildManipulatorSetEnabled(false)
        self.BuildArmManipulator:SetPrecedence(0)
        self:GetWeaponManipulatorByLabel('RightZephyr'):SetHeadingPitch( self.BuildArmManipulator:GetHeadingPitch() )
        self.UnitBeingBuilt = nil
        self.UnitBuildOrder = nil
        self.BuildingUnit = false          
    end,

    OnTeleportUnit = function(self, teleporter, location, orientation)
    #LOG('OnTeleportUnit')
    TWalkingLandUnit.OnTeleportUnit(self, teleporter, location, orientation)
    end,

    OnPaused = function(self)
        TWalkingLandUnit.OnPaused(self)
        if self.BuildingUnit then
            TWalkingLandUnit.StopBuildingEffects(self, self:GetUnitBeingBuilt())
        end    
    end,
    
    OnUnpaused = function(self)
        if self.BuildingUnit then
            TWalkingLandUnit.StartBuildingEffects(self, self:GetUnitBeingBuilt(), self.UnitBuildOrder)
        end
        TWalkingLandUnit.OnUnpaused(self)
    end,      

}

TypeClass = UEL00011