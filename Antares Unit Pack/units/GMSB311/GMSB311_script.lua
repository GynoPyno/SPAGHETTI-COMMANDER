local SEnergyCreationUnit = import('/lua/seraphimunits.lua').SEnergyCreationUnit
local SStructureUnit = import('/lua/seraphimunits.lua').SStructureUnit
local SIFCommanderDeathWeapon = import('/lua/seraphimweapons.lua').SIFCommanderDeathWeapon

GMSB311 = Class(SEnergyCreationUnit) {
    Weapons = {
        DeathWeapon = Class(SIFCommanderDeathWeapon) {},
    },

    AmbientEffects = 'ST3PowerAmbient',
    
    OnStopBeingBuilt = function(self, builder, layer)
        SEnergyCreationUnit.OnStopBeingBuilt(self, builder, layer)
        self.Trash:Add(CreateRotator(self, 'Orb', 'y', nil, 0, 15, 80 + Random(0, 20)))
    end,
}

TypeClass = GMSB311