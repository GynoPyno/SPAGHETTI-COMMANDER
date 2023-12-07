#****************************************************************************
#**
#**  File     :  /cdimage/units/LED0012/LED0012_script.lua
#**  Author(s):  Drew Staltman, Jessica St. Croix, Gordon Duclos, Aaron Lundquist
#**
#**  Summary  :  Seraphim Long Range Artillery Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local SStructureUnit = import('/lua/seraphimunits.lua').SStructureUnit
local SIFSuthanusArtilleryCannon = import('/lua/seraphimweapons.lua').SIFSuthanusArtilleryCannon

LED0012 = Class(SStructureUnit) {
    Weapons = {
        MainGun = Class(SIFSuthanusArtilleryCannon) {},
    },
}
TypeClass = LED0012