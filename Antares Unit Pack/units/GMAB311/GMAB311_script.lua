local AStructureUnit = import('/lua/aeonunits.lua').AStructureUnit
local AEnergyCreationUnit = import('/lua/aeonunits.lua').AEnergyCreationUnit

local AIFCommanderDeathWeapon = import('/lua/aeonweapons.lua').AIFCommanderDeathWeapon

local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtils = import('/lua/effectutilities.lua')
local utilities = import('/lua/utilities.lua')

GMAB311 = Class(AEnergyCreationUnit) {
    Weapons = {
        DeathWeapon = Class(AIFCommanderDeathWeapon) {},
    },

    AmbientEffects = 'AT3PowerAmbient',
    
    OnStopBeingBuilt = function(self, builder, layer)
        AEnergyCreationUnit.OnStopBeingBuilt(self, builder, layer)
        self.Trash:Add(CreateRotator(self, 'Sphere', 'x', nil, 0, 15, 80 + Random(0, 20)))
        self.Trash:Add(CreateRotator(self, 'Sphere', 'y', nil, 0, 15, 80 + Random(0, 20)))
        self.Trash:Add(CreateRotator(self, 'Sphere', 'z', nil, 0, 15, 80 + Random(0, 20)))
    end,
}

TypeClass = GMAB311