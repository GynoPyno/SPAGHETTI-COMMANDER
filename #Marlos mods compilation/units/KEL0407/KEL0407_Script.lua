
-- Super Heavy

local TLandUnit = import('/lua/terranunits.lua').TLandUnit

local TDFGaussCannonWeapon = import('/lua/terranweapons.lua').TDFGaussCannonWeapon
local TIFArtilleryWeapon = import('/lua/terranweapons.lua').TIFArtilleryWeapon
local TAAFlakArtilleryCannon = import('/lua/terranweapons.lua').TAAFlakArtilleryCannon
local TIFCruiseMissileUnpackingLauncher = import('/lua/terranweapons.lua').TIFCruiseMissileUnpackingLauncher
local EffectUtil = import('/lua/EffectUtilities.lua')
local CreateBuildCubeThread = EffectUtil.CreateBuildCubeThread


UEL0101 = Class(TLandUnit) {
    
    Weapons = {
        MainGun = Class(TIFArtilleryWeapon) {
            FxMuzzleFlashScale = 3,
        },
        MainGunU = Class(TIFArtilleryWeapon) {
            FxMuzzleFlashScale = 3,
        },
		FrontTurret01 = Class(TDFGaussCannonWeapon) {
		},
		FrontTurret02 = Class(TDFGaussCannonWeapon) {
		},
        AAGun1 = Class(TAAFlakArtilleryCannon) {},
        AAGun2 = Class(TAAFlakArtilleryCannon) {},
		TacticalMissile01 = Class(TIFCruiseMissileUnpackingLauncher) {},
	},
	
    OnStopBeingBuilt = function(self, builder, layer)
        TLandUnit.OnStopBeingBuilt(self, builder, layer)
        if self:BeenDestroyed() then return end
        self:HideBone('R_AA_Mount', true)
        self:HideBone('L_AA_Mount', true)
        self:HideBone('RM_Rack', true)
        self:HideBone('LM_Rack', true)
        self:HideBone('RG_Turret', true)
        self:HideBone('LG_Turret', true)
        self:HideBone('MGE_Barrel02', true)
        self:SetWeaponEnabledByLabel('MainGun', true)
        self:SetWeaponEnabledByLabel('MainGunU', false)
        self:SetWeaponEnabledByLabel('FrontTurret01', false)
        self:SetWeaponEnabledByLabel('FrontTurret02', false)
        self:SetWeaponEnabledByLabel('AAGun1', false)
        self:SetWeaponEnabledByLabel('AAGun2', false)
        self:SetWeaponEnabledByLabel('TacticalMissile01', false)
    end,
	

    CreateEnhancement = function(self, enh)
        TLandUnit.CreateEnhancement(self, enh)

        if enh == 'DamageStabilization' then
        self:SetWeaponEnabledByLabel('AAGun1', true)
        self:SetWeaponEnabledByLabel('AAGun2', true)
		
        elseif enh =='DamageStabilizationRemove' then
        self:SetWeaponEnabledByLabel('AAGun1', false)
        self:SetWeaponEnabledByLabel('AAGun2', false)
		
        elseif enh == 'SideWeapons' then
        self:SetWeaponEnabledByLabel('FrontTurret01', true)
        self:SetWeaponEnabledByLabel('FrontTurret02', true)
        -- self:HideBone('R_AA_Mount', true)
        -- self:HideBone('L_AA_Mount', true)
		
        elseif enh =='SideWeaponsRemove' then
        self:SetWeaponEnabledByLabel('FrontTurret01', false)
        self:SetWeaponEnabledByLabel('FrontTurret02', false)
		
        elseif enh =='HeavyAntiMatterCannon' then
        self:SetWeaponEnabledByLabel('MainGunU', true)
        self:SetWeaponEnabledByLabel('MainGun', false)
		
        elseif enh =='HeavyAntiMatterCannonRemove' then
        self:SetWeaponEnabledByLabel('MainGun', true)
        self:SetWeaponEnabledByLabel('MainGunU', false)
		
        elseif enh =='TacticalMissile' then
            self:SetWeaponEnabledByLabel('TacticalMissile01', true)
			
        elseif enh == 'TacticalMissileRemove' then
            self:SetWeaponEnabledByLabel('TacticalMissile01', false)
        end
    end,
	
    StartBeingBuiltEffects = function(self, builder, layer)
        self:SetMesh(self:GetBlueprint().Display.BuildMeshBlueprint, true)
        if self:GetBlueprint().General.UpgradesFrom ~= builder.UnitId then
            self:HideBone(0, true)
            self.OnBeingBuiltEffectsBag:Add(self:ForkThread(CreateBuildCubeThread, builder, self.OnBeingBuiltEffectsBag))
        end
    end,
}


TypeClass = UEL0101
