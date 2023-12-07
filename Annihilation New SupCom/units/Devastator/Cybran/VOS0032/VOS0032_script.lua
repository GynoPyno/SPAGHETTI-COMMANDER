#****************************************************************************
#**
#**  File     :  /cdimage/units/URL0402/URL0402_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix, Gordon Duclos
#**
#**  Summary  :  Cybran Spider Bot Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local CWalkingLandUnit = import( '/lua/cybranunits.lua').CWalkingLandUnit
local CybranWeaponsFile = import( '/lua/cybranweapons.lua')
--local CybranWeaponsFile2 = import('/lua/cybranweapons.lua')
--local CDFHeavyMicrowaveLaserGeneratorDefense = CybranWeaponsFile.CDFHeavyMicrowaveLaserGeneratorDefense
--local CDFHvyProtonCannonWeapon = CybranWeaponsFile2.CDFHvyProtonCannonWeapon
--local CDFElectronBolterWeapon = CybranWeaponsFile2.CDFElectronBolterWeapon
--local CAAMissileNaniteWeapon = CybranWeaponsFile2.CAAMissileNaniteWeapon

local WeaponsFile = import('/lua/terranweapons.lua')
local TOrbitalDeathLaserBeamWeapon = WeaponsFile.TOrbitalDeathLaserBeamWeapon
local CybranWeaponsFile2 = import('/mods/Annihilation New SupCom/lua/BlackOpsWeapons.lua')
local XCannonWeapon01 = CybranWeaponsFile2.XCannonWeapon01
local CDFHvyProtonCannonWeapon = CybranWeaponsFile.CDFHvyProtonCannonWeapon

local AWeaponsFile = import('/lua/aeonweapons.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local ACruiseMissileWeapon = AWeaponsFile.ACruiseMissileWeapon

local CAAMissileNaniteWeapon = CybranWeaponsFile.CAAMissileNaniteWeapon

local WeaponsFile2 = import('/lua/terranweapons.lua')
local TDFGaussCannonWeapon = WeaponsFile2.TDFLandGaussCannonWeapon
local BlackOpsEffectTemplate = import('/mods/Annihilation New SupCom/lua/BlackOpsEffectTemplates.lua')
local TMEffectTemplate = import('/mods/Annihilation New SupCom/lua/TMEffectTemplates.lua')
local AIFCommanderDeathWeapon = import('/lua/aeonweapons.lua').AIFCommanderDeathWeapon

VOS0032 = Class(CWalkingLandUnit) {

	Weapons = {
        MainGun = Class(TOrbitalDeathLaserBeamWeapon) {
            FxMuzzleFlashScale = 5.6,
        },
        ParticleGun = Class(XCannonWeapon01) {
            FxMuzzleFlashScale = 8.6,
        },
        ParticleGunD = Class(XCannonWeapon01) {
            FxMuzzleFlashScale = 8.6,
        },
        ParticleGunG = Class(XCannonWeapon01) {
            FxMuzzleFlashScale = 8.6,
        },
         LaserTurretI = Class(CDFHvyProtonCannonWeapon) {
            FxMuzzleFlashScale = 4.6,
        },
         LaserTurretII = Class(CDFHvyProtonCannonWeapon) {
            FxMuzzleFlashScale = 4.6,
        },
         LaserTurretIII = Class(CDFHvyProtonCannonWeapon) {
            FxMuzzleFlashScale = 4.6,
        },
         LaserTurretIV = Class(CDFHvyProtonCannonWeapon) {
            FxMuzzleFlashScale = 4.6,
        },
         LaserTurretV = Class(CDFHvyProtonCannonWeapon) {
            FxMuzzleFlashScale = 4.6,
        },
         LaserTurretVI = Class(CDFHvyProtonCannonWeapon) {
            FxMuzzleFlashScale = 4.6,
        },
         LaserTurretVII = Class(CDFHvyProtonCannonWeapon) {
            FxMuzzleFlashScale = 4.6,
        },
         LaserTurretVIII = Class(CDFHvyProtonCannonWeapon) {
            FxMuzzleFlashScale = 4.6,
        },
        rocket1 = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlashScale = 0,
		},
        AntiAirMissileI = Class(CAAMissileNaniteWeapon) {
        },
        AntiAirMissileII = Class(CAAMissileNaniteWeapon) {
        },
        AntiAirMissileIII = Class(CAAMissileNaniteWeapon) {
        },
        AntiAirMissileIV = Class(CAAMissileNaniteWeapon) {
        },
        EMPgun = Class(TDFGaussCannonWeapon) {
                FxMuzzleFlash = BlackOpsEffectTemplate.ArtemisMuzzleChargeFlash,
                            FxMuzzleFlashScale = 3.0, 
        },
        DeathWeapon = Class(AIFCommanderDeathWeapon) {},

    },

    OnCreate = function(self,builder,layer)
       CWalkingLandUnit.OnCreate(self,builder,layer)
    end,
    

    OnStartBeingBuilt = function(self, builder, layer)
        CWalkingLandUnit.OnStartBeingBuilt(self, builder, layer)
        if not self.AnimationManipulator then
            self.AnimationManipulator = CreateAnimator(self)
            self.Trash:Add(self.AnimationManipulator)
        end
        self.AnimationManipulator:PlayAnim(self:GetBlueprint().Display.AnimationActivate, false):SetRate(0)
    end,
     
    OnStopBeingBuilt = function(self,builder,layer)
        if self.AnimationManipulator then
            self:SetUnSelectable(true)
            self.AnimationManipulator:SetRate(0.7)
            self:ForkThread(function()
                WaitSeconds(self.AnimationManipulator:GetAnimationDuration()*self.AnimationManipulator:GetRate())
                self:SetUnSelectable(false)
                self.AnimationManipulator:Destroy()
            end)
        end        
        self:SetMaintenanceConsumptionActive()
        local layer = self:GetCurrentLayer()
        self.WeaponsEnabled = true

         --self:CreatTheEffects()
    
        -- Assist management globals
        self.MyAttacker = nil
        self.MyTarget = nil

        self.spoof = false
        self.gettingBuilt = false
        self:ForkThread(self.CheckAIThread)
        
       CWalkingLandUnit.OnStopBeingBuilt(self,builder,layer)
    end,   

    

    CheckAIThread = function(self)
        if self:GetAIBrain().BrainType ~= 'Human' then
            self:SetScriptBit('RULEUTC_IntelToggle', false)
        end
    end,

    OnKilled = function(self, instigator, damagetype, overkillRatio)
         
        CWalkingLandUnit.OnKilled(self, instigator, damagetype, overkillRatio)        
        self:CreatTheEffectsDeath()
    end,

    CreatTheEffectsDeath = function(self)
        local army =  self:GetArmy()
        for k, v in TMEffectTemplate['MadCatDeath01'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'Head01Turret', army, v):ScaleEmitter(8.5))
        end
    end,

    OnDestroy = function(self)
        
        -- Don't make the energy being if not built
        if self:GetFractionComplete() ~= 1 then return end
        
        
        CWalkingLandUnit.OnDestroy(self)
    end,

    DeathThread = function(self)
        self:PlayUnitSound('Destroyed')
        local army = self:GetArmy()

        -- Spawn the nuke effect end energy beings
        local position = self:GetPosition()
        --WaitTicks(5)
        
        WaitSeconds(8)
        local spiritUnit2 = CreateUnitHPR('UEL0001', self:GetArmy(), position[1], position[2], position[3], 0, 0, 0)
            if (spiritUnit2 != nil) then
                spiritUnit2:Kill();
            end

        WaitSeconds(4)

        self:CreateWreckage(0.1)
        self:Destroy()
    end,

    -- Enables economy drain
    EnableResourceConsumption = function(self, econdata)
        local energy_rate = econdata.BuildCostEnergy / (econdata.BuildTime / self.BuildRate)
        local mass_rate = econdata.BuildCostMass / (econdata.BuildTime / self.BuildRate)
        self:SetConsumptionPerSecondEnergy(energy_rate)
        self:SetConsumptionPerSecondMass(mass_rate)
        self:SetConsumptionActive(true)
    end,

    -- Disables economy drain
    DisableResourceConsumption = function(self)
        self:SetConsumptionPerSecondEnergy(0)
        self:SetConsumptionPerSecondMass(0)
        self:SetConsumptionActive(false)
    end,
    

    -- Returns a hostile gunship/transport in range for drone targeting, or nil if none
    SearchForGunshipTarget = function(self, radius)
        local targetindex, target
        local units = self:GetAIBrain():GetUnitsAroundPoint(categories.AIR - (categories.UNTARGETABLE), self:GetPosition(), radius, 'Enemy')
        if next(units) then
            targetindex, target = next(units)
        end
        return target
    end,
    
    -- De-blip a weapon target - stolen from the GC tractorclaw script
    GetRealTarget = function(self, target)
        if target and not IsUnit(target) then
            local unitTarget = target:GetSource()
            local unitPos = unitTarget:GetPosition()
            local reconPos = target:GetPosition()
            local dist = VDist2(unitPos[1], unitPos[3], reconPos[1], reconPos[3])
            if dist < 5 then
                return unitTarget
            end
        end
        return target      
    end,
    
    -- Runs a potential target through filters to insure that drones can attack it; checks are as simple and efficient as possible
    IsValidDroneTarget = function(self, target)
        local ivdt
        if target ~= nil
        and target.Dead ~= nil
        and not target:IsDead()
        and IsEnemy(self:GetArmy(), target:GetArmy())
        and not EntityCategoryContains(categories.UNTARGETABLE, target)
        and target:GetCurrentLayer() ~= 'Sub'
        and target:GetBlip(self:GetArmy()) ~= nil then
            ivdt = true
        end
        return ivdt
    end,
    
    -- Insures that potential retaliation targets are within drone control range
    IsTargetInRange = function(self, target)
        local tpos = target:GetPosition()
        local mpos = self:GetPosition()
        local dist = VDist2(mpos[1], mpos[3], tpos[1], tpos[3])
        local itir
        if dist <= self.AssistRange then
            itir = true
        end
        return itir
    end,

    OnScriptBitClear = function(self, bit)
        CWalkingLandUnit.OnScriptBitClear(self, bit)
        if bit == 3 then 
            self.spoof = true
            self:SetMaintenanceConsumptionActive()
            self:EnableUnitIntel('Radar')
            self:EnableUnitIntel('RadarStealth')
    --        self:ForkThread(self.SpoofingThread)
        end
    end,
    
    OnScriptBitSet = function(self, bit)
        CWalkingLandUnit.OnScriptBitSet(self, bit)
        if bit == 3 then
            self.spoof = false
            self:SetMaintenanceConsumptionInactive()
            self:DisableUnitIntel('Radar')
            self:DisableUnitIntel('RadarStealth')
        end
    end,
    
}

TypeClass = VOS0032
