local SSeaUnit = import('/lua/seraphimunits.lua').SSeaUnit
local SeraphimWeapons = import('/lua/seraphimweapons.lua')
local SAAOlarisCannonWeapon = SeraphimWeapons.SAAOlarisCannonWeapon
local SDFUltraChromaticBeamGenerator = SeraphimWeapons.SDFUltraChromaticBeamGenerator
local SDFAjelluAntiTorpedoDefense = SeraphimWeapons.SDFAjelluAntiTorpedoDefense
local SANHeavyCavitationTorpedo = SeraphimWeapons.SANHeavyCavitationTorpedo

WSS0301 = Class(SSeaUnit) {
    Weapons = {
 	NavalTurretFront = Class(SDFUltraChromaticBeamGenerator) {},
 	NavalTurretLeftFront = Class(SDFUltraChromaticBeamGenerator) {},
 	NavalTurretRightFront = Class(SDFUltraChromaticBeamGenerator) {},
 	NavalTurretLeftRear = Class(SDFUltraChromaticBeamGenerator) {},
 	NavalTurretRightRear = Class(SDFUltraChromaticBeamGenerator) {},
        AntiAirFront = Class(SAAOlarisCannonWeapon) {},
        AntiAirBack = Class(SAAOlarisCannonWeapon) {},
        Torpedo1 = Class(SANHeavyCavitationTorpedo) {},
        TorpedoDefense1 = Class(SDFAjelluAntiTorpedoDefense) {},
        Torpedo2 = Class(SANHeavyCavitationTorpedo) {},
        TorpedoDefense2 = Class(SDFAjelluAntiTorpedoDefense) {},
    },
}

TypeClass = WSS0301