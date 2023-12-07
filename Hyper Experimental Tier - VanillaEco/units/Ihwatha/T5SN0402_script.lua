#****************************************************************************
#**
#**  Summary  :  Seraphim Hyper-Experimental Battleship Script
#**
#**  Copyright © Nope
#****************************************************************************

local SSeaUnit = import('/lua/seraphimunits.lua').SSeaUnit
local SeraphimWeapons = import('/lua/seraphimweapons.lua')
local SANUallCavitationTorpedo = SeraphimWeapons.SANUallCavitationTorpedo
local SDFHeavyQuarnonCannon = SeraphimWeapons.SDFHeavyQuarnonCannon
local SAALosaareAutoCannonWeapon = SeraphimWeapons.SAALosaareAutoCannonWeapon
local SB0OhwalliExperimentalStrategicBombWeapon = SeraphimWeapons.SB0OhwalliExperimentalStrategicBombWeapon
local SLaanseMissileWeapon = SeraphimWeapons.SLaanseMissileWeapon
local SDFAjelluAntiTorpedoDefense = SeraphimWeapons.SDFAjelluAntiTorpedoDefense
local EffectUtil = import('/lua/EffectUtilities.lua')
local explosion = import('/lua/defaultexplosions.lua')

T5SN0402 = Class(SSeaUnit) {
    DeathThreadDestructionWaitTime = 1,
    Weapons = {
        OhwalliStrategicCannon = Class(SDFHeavyQuarnonCannon) {},
		CruiseMissiles = Class(SLaanseMissileWeapon) {},
        RightFrontAutocannon = Class(SAALosaareAutoCannonWeapon) {},
        LeftFrontAutocannon = Class(SAALosaareAutoCannonWeapon) {},
        RightRearAutocannon = Class(SAALosaareAutoCannonWeapon) {},
        LeftRearAutocannon = Class(SAALosaareAutoCannonWeapon) {},
		TorpedoFront = Class(SANUallCavitationTorpedo) {},
        AntiTorpedoLeft = Class(SDFAjelluAntiTorpedoDefense) {},
        AntiTorpedoRight = Class(SDFAjelluAntiTorpedoDefense) {},
    },
    StartBeingBuiltEffects = function(self, builder, layer)
		SSeaUnit.StartBeingBuiltEffects(self, builder, layer)
		self:ForkThread( EffectUtil.CreateSeraphimExperimentalBuildBaseThread, builder, self.OnBeingBuiltEffectsBag )
    end,
	BackWakeEffect = {},
    OnStopBeingBuilt = function(self,builder,layer)
        SSeaUnit.OnStopBeingBuilt(self,builder,layer)
        if layer == 'Water' then
            ChangeState( self, self.OpenState )
        else
            ChangeState( self, self.ClosedState )
        end
    end,

    OnLayerChange = function( self, new, old )
        SSeaUnit.OnLayerChange(self, new, old)
        if new == 'Water' then
            ChangeState( self, self.OpenState )
        elseif new == 'Sub' then
            ChangeState( self, self.ClosedState )
        end
    end,

    OpenState = State() {
        Main = function(self)
            local bp = self:GetBlueprint()
            self:SetWeaponEnabledByLabel ('RightFrontAutoCannon', true)
			self:SetWeaponEnabledByLabel ('CruiseMissiles', true)
			self:SetWeaponEnabledByLabel ('AntiTorpedoLeft', true)
			self:SetWeaponEnabledByLabel ('AntiTorpedoRight', true)
			self:SetWeaponEnabledByLabel ('TorpedoFront', true)
			self:SetWeaponEnabledByLabel ('MainCannon', true)
			self:SetWeaponEnabledByLabel ('LeftFrontAutocannon', true)
			self:SetWeaponEnabledByLabel ('RightRearAutocannon', true)
			self:SetWeaponEnabledByLabel ('LeftRearAutocannon', true)
        end
    },

    ClosedState = State() {
        Main = function(self)
            self:SetWeaponEnabledByLabel ('RightFrontAutoCannon', false)
			self:SetWeaponEnabledByLabel ('MainCannon', false)
			self:SetWeaponEnabledByLabel ('LeftFrontAutocannon', false)
			self:SetWeaponEnabledByLabel ('RightRearAutocannon', false)
			self:SetWeaponEnabledByLabel ('LeftRearAutocannon', false)
        end
    },
}
TypeClass = T5SN0402
