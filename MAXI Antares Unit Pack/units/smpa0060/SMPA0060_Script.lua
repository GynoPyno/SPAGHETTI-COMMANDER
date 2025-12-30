#****************************************************************************
#**
#**  File     :  /data/units/XSL0201/XSL0201_script.lua
#**  Author(s):  Jessica St. Croix, Greg Kohne, Aaron Lundquist
#**
#**  Summary  :  Seraphim Medium Tank Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local SLandUnit = import('/lua/seraphimunits.lua').SLandUnit

#local WeaponsFile = import ('/lua/seraphimweapons.lua')
#local SDFSihEnergyRifleNormalMode = WeaponsFile.SDFSniperShotNormalMode
local utilities = import('/lua/utilities.lua')

local SDFUnstablePhasonBeam = import('/lua/seraphimweapons.lua').SDFUnstablePhasonBeam

#local SIFThunthoCannonWeapon = import('/lua/seraphimweapons.lua').SIFThunthoCannonWeapon
#local SDFThauCannon = import('/lua/seraphimweapons.lua').SDFThauCannon

SMPA0060 = Class(SLandUnit) {
    Weapons = {
        #MainGun = Class(SIFThunthoCannonWeapon) {},
        #TauCannon01 = Class(SDFThauCannon){
        TauCannon01 = Class(SDFUnstablePhasonBeam){
			FxMuzzleFlashScale = 0.3,
        },
    },

    OnStopBeingBuilt = function(self, builder, layer)
        SLandUnit.OnStopBeingBuilt(self, builder, layer)
        self.RingManip = CreateRotator(self, 'Box01', 'y', nil, 0, 1 + Random(0, 20), -20)
        self.Trash:Add(self.RingManip)
    end,

}
TypeClass = SMPA0060
