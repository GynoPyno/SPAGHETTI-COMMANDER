#****************************************************************************
#**
#**  File     :  /units/XSL0206/XSL0206_script.lua
#**  Author(s):  Aaron Lundquist And Asdrubaelvect
#**
#**  Summary  :  Seraphim Iashavoh Mobile Torpille Launcher
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local SHoverLandUnit = import('/lua/seraphimunits.lua').SHoverLandUnit
local SDFOhCannon = import('/lua/seraphimweapons.lua').SDFOhCannon
local SANUallCavitationTorpedo = import('/lua/seraphimweapons.lua').SANUallCavitationTorpedo
local SAAOlarisCannonWeapon = import('/lua/seraphimweapons.lua').SAAOlarisCannonWeapon

XSL0206 = Class(SHoverLandUnit) {
    Weapons = {
        MainGun = Class(SDFOhCannon) {},
		Torpedo01 = Class(SANUallCavitationTorpedo) {},
		Torpedo02 = Class(SANUallCavitationTorpedo) {},
		AAGun01 = Class(SAAOlarisCannonWeapon) {},	
    },
	
	
    OnCreate = function(self)
		SHoverLandUnit.OnCreate(self)

    end,

}
TypeClass = XSL0206