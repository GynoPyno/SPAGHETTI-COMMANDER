local SStructureUnit = import('/lua/seraphimunits.lua').SStructureUnit

local SeraphimWeapons = import('/lua/seraphimweapons.lua')
local SANHeavyCavitationTorpedo = SeraphimWeapons.SANHeavyCavitationTorpedo

WSB2308 = Class(SStructureUnit) {
    Weapons = {
        TorpedoTurrets = Class(SANHeavyCavitationTorpedo) {},
    },
}
TypeClass = WSB2308