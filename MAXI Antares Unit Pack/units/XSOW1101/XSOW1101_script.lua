local SAirUnit = import('/lua/seraphimunits.lua').SAirUnit
local SeraphimWeapons = import('/lua/seraphimweapons.lua')

local SAAShleoCannonWeapon = SeraphimWeapons.SAAShleoCannonWeapon

local SDFUltraChromaticBeamGenerator = import('/lua/seraphimweapons.lua').SDFUltraChromaticBeamGenerator

local explosion = import('/lua/defaultexplosions.lua')

local util = import('/lua/utilities.lua')
local utilities = import('/lua/Utilities.lua')
local fxutil = import('/lua/effectutilities.lua')
local Effects = import('/lua/effecttemplates.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')
local EffectUtils = import('/lua/EffectUtilities.lua')
local ExhaustBeam = import('/lua/effecttemplates.lua')
local ExhaustEffects = import('/lua/effecttemplates.lua')

local AIUtils = import('/lua/ai/aiutilities.lua')

XSOW1101 = Class(SAirUnit) {
	DestroyNoFallRandomChance = 1.1,
	
    Weapons = {
        SonicPulseBattery01 = Class(SAAShleoCannonWeapon) {},
		SonicPulseBattery02 = Class(SAAShleoCannonWeapon) {},
		SonicPulseBattery03 = Class(SAAShleoCannonWeapon) {},
		SonicPulseBattery04 = Class(SAAShleoCannonWeapon) {},
		SonicPulseBattery05 = Class(SAAShleoCannonWeapon) {},
		SonicPulseBattery06 = Class(SAAShleoCannonWeapon) {},
		
		ASGun = Class(SDFUltraChromaticBeamGenerator) {},
    },
	
    OnStopBeingBuilt = function(self,builder,layer)
	local army = self:GetArmy()
        SAirUnit.OnStopBeingBuilt(self,builder,layer)
		CreateAttachedEmitter(self, 'Effect01', army, '/effects/emitters/seraphim_gate_06_emit.bp'):OffsetEmitter( 0, 0, 0 )
		CreateAttachedEmitter(self, 'Effect01', army, '/effects/emitters/seraphim_gate_05_emit.bp'):OffsetEmitter( 0, 0, 0 )
		CreateAttachedEmitter(self, 'Effect01', army, '/effects/emitters/seraphim_gate_04_emit.bp'):OffsetEmitter( 0, 0, 0 )
	    CreateAttachedEmitter(self, 'Effect01', army, '/effects/emitters/seraphim_gate_03_emit.bp'):OffsetEmitter( 0, -2, 0 )
		CreateAttachedEmitter(self, 'Effect01', army, '/effects/emitters/seraphim_gate_02_emit.bp'):OffsetEmitter( 0, -2, 0 )
		
        self.Trash:Add(CreateRotator(self, 'Pod01', 'z', nil, 120, 0, 120))
    end,		
	
}
TypeClass = XSOW1101
