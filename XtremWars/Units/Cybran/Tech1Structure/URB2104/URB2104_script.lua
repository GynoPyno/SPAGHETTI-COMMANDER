#****************************************************************************
#**
#**  File     :  /cdimage/units/URB2104/URB2104_script.lua
#**  Author(s):  John Comes, David Tomandl
#**
#**  Summary  :  Cybran Anti-Air Gun Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local CLandUnit = import('/lua/cybranunits.lua').CLandUnit
local CAAAutocannon = import('/lua/cybranweapons.lua').CAAAutocannon

URB2104 = Class(CLandUnit) {

    Weapons = {
        UpgradeGun01 = Class(CAAAutocannon) {
            FxMuzzleScale = 2.25,
        },
    },
	
    OnCreate = function(self)
		CLandUnit.OnCreate(self)

    end,

}


TypeClass = URB2104
