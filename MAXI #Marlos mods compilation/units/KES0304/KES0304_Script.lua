#****************************************************************************
#**
#**  File     :  /cdimage/units/UES0302/UES0302_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  UEF Battleship Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TSeaUnit = import('/lua/terranunits.lua').TSeaUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local TAMPhalanxWeapon = WeaponsFile.TAMPhalanxWeapon
local TDFIonizedPlasmaCannon = WeaponsFile.TDFIonizedPlasmaCannon
local TSAMLauncher = import('/lua/terranweapons.lua').TSAMLauncher
local TANTorpedoAngler = WeaponsFile.TANTorpedoAngler
local TIFSmartCharge = WeaponsFile.TIFSmartCharge
local EffectUtil = import('/lua/EffectUtilities.lua')
local CreateBuildCubeThread = EffectUtil.CreateBuildCubeThread

local TAMPhalanxWeapon = WeaponsFile.TAMPhalanxWeapon

MK52 = Class(TSeaUnit) {

    ShieldEffects = {
        '/effects/emitters/terran_shield_generator_t2_01_emit.bp',
        '/effects/emitters/terran_shield_generator_t2_02_emit.bp',
        ###'/effects/emitters/terran_shield_generator_t2_03_emit.bp',
    },

    Weapons = {
        PlasmaCannon01 = Class(TDFIonizedPlasmaCannon) {},
        PlasmaCannon02 = Class(TDFIonizedPlasmaCannon) {},
        PlasmaCannon03 = Class(TDFIonizedPlasmaCannon) {},
        PlasmaCannon04 = Class(TDFIonizedPlasmaCannon) {},
        RightPhalanxGun01 = Class(TAMPhalanxWeapon) {},
        RightPhalanxGun02 = Class(TAMPhalanxWeapon) {},
        RightPhalanxGun03 = Class(TAMPhalanxWeapon) {},
        RightPhalanxGun04 = Class(TAMPhalanxWeapon) {},
        MissileRack01 = Class(TSAMLauncher) {},
        MissileRack02 = Class(TSAMLauncher) {},
        MissileRack03 = Class(TSAMLauncher) {},
        MissileRack04 = Class(TSAMLauncher) {},
        MissileRack05 = Class(TSAMLauncher) {},
        MissileRack06 = Class(TSAMLauncher) {},
        AntiTorpedo = Class(TIFSmartCharge) {},
        Torpedo01 = Class(TANTorpedoAngler) {},
        Torpedo02 = Class(TANTorpedoAngler) {},
		
        -- SpecialMissileRack01 = Class(TSAMLauncher) {
            -- RackSalvoFireReadyState = State(TSAMLauncher.RackSalvoFireReadyState) {
                -- Main = function(self)
                    -- local MuzzleSalvoSize = 80
                    -- if self.unit:GetTacticalSiloAmmoCount() < MuzzleSalvoSize then
                        -- self:ForkThread(
                            -- function(self)
                                -- WaitTicks(1)
                                -- if self.unit:GetTacticalSiloAmmoCount() > MuzzleSalvoSize - 1 then
                                    -- --Last minute panic check, not sure if it will actually work, very hard to test chance to test it
                                    -- TSAMLauncher.RackSalvoFireReadyState.Main(self)
                                -- end
                            -- end
                        -- )
                        -- return
                    -- else
                        -- TSAMLauncher.RackSalvoFireReadyState.Main(self)
                    -- end
                -- end,
			-- },
		-- },
		
        GatlingCannon01 = Class(TAMPhalanxWeapon) {
            PlayFxWeaponUnpackSequence = function(self)
                if not self.SpinManip then 
                    self.SpinManip = CreateRotator(self.unit, 'CIWS_Barrel_Rotate_01', 'z', nil, 270, 180, 60)
                    self.unit.Trash:Add(self.SpinManip)
                end
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(500):SetPrecedence(100)
                end
                TAMPhalanxWeapon.PlayFxWeaponUnpackSequence(self)
            end,

            PlayFxWeaponPackSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(0)
                end
                TAMPhalanxWeapon.PlayFxWeaponPackSequence(self)
            end,
        },
        GatlingCannon02 = Class(TAMPhalanxWeapon) {
            PlayFxWeaponUnpackSequence = function(self)
                if not self.SpinManip then 
                    self.SpinManip = CreateRotator(self.unit, 'CIWS_Barrel_Rotate_02', 'z', nil, 270, 180, 60)
                    self.unit.Trash:Add(self.SpinManip)
                end
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(500):SetPrecedence(100)
                end
                TAMPhalanxWeapon.PlayFxWeaponUnpackSequence(self)
            end,

            PlayFxWeaponPackSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(0)
                end
                TAMPhalanxWeapon.PlayFxWeaponPackSequence(self)
            end,
        },
        GatlingCannon03 = Class(TAMPhalanxWeapon) {
            PlayFxWeaponUnpackSequence = function(self)
                if not self.SpinManip then 
                    self.SpinManip = CreateRotator(self.unit, 'CIWS_Barrel_Rotate_03', 'z', nil, 270, 180, 60)
                    self.unit.Trash:Add(self.SpinManip)
                end
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(500):SetPrecedence(100)
                end
                TAMPhalanxWeapon.PlayFxWeaponUnpackSequence(self)
            end,

            PlayFxWeaponPackSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(0)
                end
                TAMPhalanxWeapon.PlayFxWeaponPackSequence(self)
            end,
        },
        GatlingCannon04 = Class(TAMPhalanxWeapon) {
            PlayFxWeaponUnpackSequence = function(self)
                if not self.SpinManip then 
                    self.SpinManip = CreateRotator(self.unit, 'CIWS_Barrel_Rotate_04', 'z', nil, 270, 180, 60)
                    self.unit.Trash:Add(self.SpinManip)
                end
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(500):SetPrecedence(100)
                end
                TAMPhalanxWeapon.PlayFxWeaponUnpackSequence(self)
            end,

            PlayFxWeaponPackSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(0)
                end
                TAMPhalanxWeapon.PlayFxWeaponPackSequence(self)
            end,
        },
		
    },
	
    StartBeingBuiltEffects = function(self, builder, layer)
        self:SetMesh(self:GetBlueprint().Display.BuildMeshBlueprint, true)
        if self:GetBlueprint().General.UpgradesFrom ~= builder.UnitId then
            self:HideBone(0, true)
            self.OnBeingBuiltEffectsBag:Add(self:ForkThread(CreateBuildCubeThread, builder, self.OnBeingBuiltEffectsBag))
        end
    end,

    OnStopBeingBuilt = function(self,builder,layer)
        TSeaUnit.OnStopBeingBuilt(self,builder,layer)
        self.Rotator1 = CreateRotator(self, 'Shieldgen01', 'y', nil, 30, 5, 30)
        self.Rotator2 = CreateRotator(self, 'Shieldgen02', 'y', nil, -30, 5, -30)
        self.Rotator3 = CreateRotator(self, 'Shieldgen03', 'y', nil, 30, 5, 30)
        self.Rotator4 = CreateRotator(self, 'Shieldgen04', 'y', nil, -30, 5, -30)
        self.Rotator5 = CreateRotator(self, 'Shieldgen05', 'y', nil, -30, 5, -30)
        self.Trash:Add(self.Rotator1)
        self.Trash:Add(self.Rotator2)
        self.Trash:Add(self.Rotator3)
        self.Trash:Add(self.Rotator4)
        self.Trash:Add(self.Rotator5)
		self.ShieldEffectsBag = {}
    end,

    OnShieldEnabled = function(self)
        TSeaUnit.OnShieldEnabled(self)
        if self.Rotator1 then
            self.Rotator1:SetTargetSpeed(30)
            self.Rotator3:SetTargetSpeed(30)
        end
        if self.Rotator2 then
            self.Rotator2:SetTargetSpeed(-30)
            self.Rotator4:SetTargetSpeed(-30)
            self.Rotator5:SetTargetSpeed(-30)
        end
        
        if self.ShieldEffectsBag then
            for k, v in self.ShieldEffectsBag do
                v:Destroy()
            end
		    self.ShieldEffectsBag = {}
		end
        for k, v in self.ShieldEffects do
            table.insert( self.ShieldEffectsBag, CreateAttachedEmitter( self, 0, self:GetArmy(), v ) )
        end
    end,

    OnShieldDisabled = function(self)
        TSeaUnit.OnShieldDisabled(self)
        self.Rotator1:SetTargetSpeed(0)
        self.Rotator2:SetTargetSpeed(0)
        self.Rotator3:SetTargetSpeed(0)
        self.Rotator4:SetTargetSpeed(0)
        self.Rotator5:SetTargetSpeed(0)
        
        if self.ShieldEffectsBag then
            for k, v in self.ShieldEffectsBag do
                v:Destroy()
            end
		    self.ShieldEffectsBag = {}
		end
    end,
}

TypeClass = MK52