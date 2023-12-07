#****************************************************************************
#**
#**  File     :  /data/units/XAL0203/XAL0203_script.lua
#**  Author(s):  bbkineebee
#**
#**  Summary  :  Cybran Hover Tank
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local DefaultUnitsFile = import('/lua/defaultunits.lua')
local EffectUtils = import('/lua/effectutilities.lua')
local Entity = import('/lua/sim/Entity.lua').Entity
local CDFElectronBolterWeapon = import('/lua/cybranweapons.lua').CDFElectronBolterWeapon



-- HOVERING LAND UNITS
CHoverLandUnit = Class(DefaultUnitsFile.HoverLandUnit) {
    FxHoverScale = 1,
    HoverEffects = nil,
    HoverEffectBones = nil,
}


GGA0003 = Class(CHoverLandUnit) {

    Weapons = {
		HeavyBolter = Class(CDFElectronBolterWeapon) {},
    },

    OnStopBeingBuilt = function(self,builder,layer)
	CHoverLandUnit.OnStopBeingBuilt(self,builder,layer)

        #Radar
        local bp = self:GetBlueprint()
        self.RadarEnt = Entity {}
        self.Trash:Add(self.RadarEnt)
        self.RadarEnt:InitIntel(self:GetArmy(), 'Radar', bp.Intel.RadarRadius)
        self.RadarEnt:EnableIntel('Radar')
        self.RadarEnt:AttachBoneTo(-1, self, 0)

        self:SetMaintenanceConsumptionInactive()

	if self:GetAIBrain().BrainType == 'Human' then
		#Human (switch off cloaking,   true = Not Cloaked!!!)
		self:SetScriptBit('RULEUTC_CloakToggle', true)

	else
		# AI - auto enable cloak
		self:DisableUnitIntel('ToggleBit8', 'Cloak')
		self:ForkThread(self.SwitchOnCloak)
	end

        self:RequestRefreshUI()

	# Hover effect
	self.MovementAmbientExhaustEffectsBag = {}
	table.insert( self.MovementAmbientExhaustEffectsBag, CreateAttachedEmitter(self, 'HoverEffect', self:GetArmy(), '/effects/Emitters/tt_crystal_hover01_01_emit.bp' ))

    end,

    SwitchOnCloak = function(self)
        WaitTicks(5)
	self:EnableUnitIntel('ToggleBit8', 'Cloak')
    end,

}
TypeClass = GGA0003
