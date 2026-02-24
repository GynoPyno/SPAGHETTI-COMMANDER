local TSeaUnit = import('/lua/terranunits.lua').TSeaUnit

local WeaponsFile = import('/lua/terranweapons.lua')

local TAALinkedRailgun = WeaponsFile.TAALinkedRailgun
local TAMPhalanxWeapon = WeaponsFile.TAMPhalanxWeapon
local TDFGaussCannonWeapon = WeaponsFile.TDFShipGaussCannonWeapon
local TANTorpedoAngler = import('/lua/terranweapons.lua').TANTorpedoAngler
local TSAMLauncher = import('/lua/terranweapons.lua').TSAMLauncher

local explosion = import('/lua/defaultexplosions.lua')
local util = import('/lua/utilities.lua')
local fxutil = import('/lua/effectutilities.lua')
local Effects = import('/lua/effecttemplates.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')

UT4BS = Class(TSeaUnit) {

    Weapons = {
        RightAAGun01 = Class(TAALinkedRailgun) {},
        RightAAGun02 = Class(TAALinkedRailgun) {},
        RightAAGun03 = Class(TAALinkedRailgun) {},
        LeftAAGun01 = Class(TAALinkedRailgun) {},
        LeftAAGun02 = Class(TAALinkedRailgun) {},
        LeftAAGun03 = Class(TAALinkedRailgun) {},
        RightPhalanxGun01 = Class(TAMPhalanxWeapon) {
            PlayFxWeaponUnpackSequence = function(self)
                if not self.SpinManip then 
                    self.SpinManip = CreateRotator(self.unit, 'Right_Turret02_Barrel', 'z', nil, 270, 180, 60)
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
        LeftPhalanxGun01 = Class(TAMPhalanxWeapon) {
            PlayFxWeaponUnpackSequence = function(self)
                if not self.SpinManip then 
                    self.SpinManip = CreateRotator(self.unit, 'Left_Turret02_Barrel', 'z', nil, 270, 180, 60)
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
        FrontTurret01 = Class(TDFGaussCannonWeapon) {},
        FrontTurret02 = Class(TDFGaussCannonWeapon) {},
        BackTurret = Class(TDFGaussCannonWeapon) {},
        BackTurret01 = Class(TDFGaussCannonWeapon) {},
        RightCannon = Class(TDFGaussCannonWeapon) {},
        RightCannon2 = Class(TDFGaussCannonWeapon) {},
        RightCannon3 = Class(TDFGaussCannonWeapon) {},
        LeftCannon = Class(TDFGaussCannonWeapon) {},
        LeftCannon2 = Class(TDFGaussCannonWeapon) {},
        LeftCannon3 = Class(TDFGaussCannonWeapon) {},
	LeftSam = Class(TSAMLauncher) {},
	RightSam = Class(TSAMLauncher) {},
	TorpedoLeft = Class(TANTorpedoAngler) {},
	TorpedoRight = Class(TANTorpedoAngler) {}, 

    },

    OnStopBeingBuilt = function(self,builder,layer)
        TSeaUnit.OnStopBeingBuilt(self,builder,layer)
        self.Trash:Add(CreateRotator(self, 'Spinner01', 'y', nil, 180, 0, 180))
        self.Trash:Add(CreateRotator(self, 'Spinner02', 'y', nil, 180, 0, 180))
    end,

    AmbientExhaustBones = {
		'Exhaust',
    },	
    
    AmbientLandExhaustEffects = {
		'/effects/emitters/smoke_exhuast_01_emit.bp',
	},
}

TypeClass = UT4BS