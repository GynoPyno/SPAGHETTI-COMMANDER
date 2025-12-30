local AStructureUnit = import('/lua/aeonunits.lua').AStructureUnit
local AAAZealotMissileWeapon = import('/lua/aeonweapons.lua').AAAZealotMissileWeapon
local utilities = import('/lua/utilities.lua')
local AIFCommanderDeathWeapon = import('/lua/aeonweapons.lua').AIFCommanderDeathWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtils = import('/lua/effectutilities.lua')

SWAB05 = Class(AStructureUnit) {
    Weapons = {
        DeathWeapon = Class(AIFCommanderDeathWeapon) {},
        AntiAirMissiles = Class(AAAZealotMissileWeapon) {},
    },
    
    OnStopBeingBuilt = function(self,builder,layer)
        AStructureUnit.OnStopBeingBuilt(self,builder,layer)
        self.Trash:Add(CreateRotator(self, 'Floatation', 'y', nil, 350))
    end,

}

TypeClass = SWAB05