#****************************************************************************
#**
#**  File     :  /cdimage/units/UAA0107/UAA0107_script.lua
#**  Author(s):  John Comes
#**
#**  Summary  :  Aeon T1 Transport Script
#**
#**  Copyright � 2006 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local SAirUnit = import('/lua/seraphimunits.lua').SAirUnit
local SDFUltraChromaticBeamGenerator = import('/lua/seraphimweapons.lua').SDFUltraChromaticBeamGenerator
local SDFUnstablePhasonBeam = import('/lua/seraphimweapons.lua').SDFUnstablePhasonBeam
local SAAOlarisCannonWeapon = import('/lua/seraphimweapons.lua').SAAOlarisCannonWeapon

SS4001b = Class(SAirUnit) {

    Weapons = {
        PhasonBeam = Class(SDFUnstablePhasonBeam) {},
        PhasonBeam1 =Class(SDFUnstablePhasonBeam) {},
        PhasonBeam2 = Class(SDFUnstablePhasonBeam) {},
        PhasonBeam3 = Class(SDFUnstablePhasonBeam) {},
        PhasonBeam4 = Class(SDFUnstablePhasonBeam) {},
        PhasonBeam5 = Class(SDFUnstablePhasonBeam) {},
        PhasonBeam6 = Class(SDFUnstablePhasonBeam) {},
        PhasonBeam7 = Class(SDFUnstablePhasonBeam) {},
        PhasonBeam8 = Class(SDFUnstablePhasonBeam) {},
        PhasonBeam9 = Class(SDFUltraChromaticBeamGenerator) {},
        PhasonBeam10 = Class(SDFUnstablePhasonBeam) {},
        PhasonBeam11 = Class(SDFUnstablePhasonBeam) {},
        PhasonBeam12 = Class(SDFUnstablePhasonBeam) {},
        PhasonBeam13 = Class(SDFUnstablePhasonBeam) {},
        PhasonBeam14 = Class(SDFUnstablePhasonBeam) {},
        PhasonBeam15 = Class(SDFUnstablePhasonBeam) {},
        PhasonBeam16 = Class(SDFUnstablePhasonBeam) {},
        PhasonBeam17 = Class(SDFUnstablePhasonBeam) {},
        AAFizz = Class(SAAOlarisCannonWeapon) {},
        AAFizz1 = Class(SAAOlarisCannonWeapon) {},
        AAFizz2 = Class(SAAOlarisCannonWeapon) {},
        AAFizz3 = Class(SAAOlarisCannonWeapon) {},
        AAFizz4 = Class(SAAOlarisCannonWeapon) {},
        AAFizz5 = Class(SAAOlarisCannonWeapon) {},
        AAFizz6 = Class(SAAOlarisCannonWeapon) {},
        AAFizz7 = Class(SAAOlarisCannonWeapon) {},
        AAFizz8 = Class(SAAOlarisCannonWeapon) {},
        AAFizz9 = Class(SAAOlarisCannonWeapon) {},
        AAFizz10 = Class(SAAOlarisCannonWeapon) {},
        AAFizz11 = Class(SAAOlarisCannonWeapon) {},
        AAFizz12 = Class(SAAOlarisCannonWeapon) {},
        AAFizz13 = Class(SAAOlarisCannonWeapon) {},
        AAFizz14 = Class(SAAOlarisCannonWeapon) {},
        AAFizz15 = Class(SAAOlarisCannonWeapon) {},
    },

}

TypeClass = SS4001b