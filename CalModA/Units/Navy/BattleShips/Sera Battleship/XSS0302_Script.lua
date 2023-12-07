#****************************************************************************
#**
#**  File     :  /cdimage/units/XSS0302/XSS0302_script.lua
#**  Author(s):  Jessica St. Croix, Gordon Duclos, Aaron Lundquist
#**
#**  Summary  :  Seraphim Battleship Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local SSeaUnit = import('/lua/seraphimunits.lua').SSeaUnit
local SeraphimWeapons = import('/lua/seraphimweapons.lua')

local SDFHeavyQuarnonCannon = SeraphimWeapons.SDFHeavyQuarnonCannon
local SDFUltraChromaticBeamGenerator = SeraphimWeapons.SDFUltraChromaticBeamGenerator02
local SAAOlarisCannonWeapon = SeraphimWeapons.SAAOlarisCannonWeapon
local SIFInainoWeapon = import('/lua/seraphimweapons.lua').SIFInainoWeapon
local SDFAjelluAntiTorpedoDefense = import('/lua/seraphimweapons.lua').SDFAjelluAntiTorpedoDefense
local CIFSmartCharge = import('/lua/cybranweapons.lua').CIFSmartCharge


XSS0302 = Class(SSeaUnit) {
    FxDamageScale = 2,
    DestructionTicks = 400,

    Weapons = {
        BackTurret = Class(SDFHeavyQuarnonCannon) {},
        FrontTurret = Class(SDFHeavyQuarnonCannon) {},
        MidTurret = Class(SDFHeavyQuarnonCannon) {},
        AntiMissileLeft = Class(SDFUltraChromaticBeamGenerator) {},
        AntiMissileRight = Class(SDFUltraChromaticBeamGenerator) {},
        AntiAirLeft = Class(SAAOlarisCannonWeapon) {},
        AntiAirRight = Class(SAAOlarisCannonWeapon) {},
        InainoMissiles = Class(SIFInainoWeapon) {},
        AntiTorpedo1 = Class(CIFSmartCharge) {},
        AntiTorpedo2 = Class(CIFSmartCharge) {},
    },
}

TypeClass = XSS0302