local SAirUnit = import('/lua/seraphimunits.lua').SAirUnit
local SeraphimWeapons = import('/lua/seraphimweapons.lua')
local SAALosaareAutoCannonWeapon = import('/lua/seraphimweapons.lua').SAALosaareAutoCannonWeaponAirUnit
local SDFUltraChromaticBeamGenerator = SeraphimWeapons.SDFUltraChromaticBeamGenerator02
local SDFHeavyQuarnonCannon = SeraphimWeapons.SDFHeavyQuarnonCannon

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

XSOW1103 = Class(SAirUnit) {
	DestroyNoFallRandomChance = 1.1,
	
    Weapons = {
        MainGun = Class(SDFUltraChromaticBeamGenerator) {},
        AAGun = Class(SAALosaareAutoCannonWeapon) {},
	AntiVaisseaux = Class(SDFHeavyQuarnonCannon) {},
    },
	
    OnStopBeingBuilt = function(self,builder,layer)
	local army = self:GetArmy()
        SAirUnit.OnStopBeingBuilt(self,builder,layer)
		CreateAttachedEmitter(self, 'Effect01', army, '/effects/emitters/seraphim_gate_06_emit.bp'):OffsetEmitter( 0, 0, 0 )
		CreateAttachedEmitter(self, 'Effect01', army, '/effects/emitters/seraphim_gate_05_emit.bp'):OffsetEmitter( 0, 0, 0 )
		CreateAttachedEmitter(self, 'Effect01', army, '/effects/emitters/seraphim_gate_04_emit.bp'):OffsetEmitter( 0, 0, 0 )
		CreateAttachedEmitter(self, 'Effect01', army, '/effects/emitters/seraphim_gate_03_emit.bp'):OffsetEmitter( 0, -2, 0 )
		CreateAttachedEmitter(self, 'Effect01', army, '/effects/emitters/seraphim_gate_02_emit.bp'):OffsetEmitter( 0, -2, 0 )
		
        self.Trash:Add(CreateRotator(self, 'Rotator01', 'z', nil, 50, 0, 50))
    end,		
	
}
TypeClass = XSOW1103
