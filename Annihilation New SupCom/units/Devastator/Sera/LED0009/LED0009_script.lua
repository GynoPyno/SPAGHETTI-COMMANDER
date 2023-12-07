local SStructureUnit = import('/lua/seraphimunits.lua').SStructureUnit

local SeraphimWeapons = import('/lua/seraphimweapons.lua')
local SANHeavyCavitationTorpedo = SeraphimWeapons.SANHeavyCavitationTorpedo

LED0009 = Class(SStructureUnit) {
    Weapons = {
        TorpedoTurrets = Class(SANHeavyCavitationTorpedo) {},
    },
}
TypeClass = LED0009