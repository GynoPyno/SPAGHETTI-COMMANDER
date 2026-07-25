#****************************************************************************
#**
#**  File     :  /cdimage/units/UEL0307/UEL0307_script.lua
#**  Author(s):  David Tomandl, Jessica St. Croix
#**
#**  Summary  :  UEF Mobile Shield Generator Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TRadarUnit = import('/lua/terranunits.lua').TRadarUnit

UEL0307 = Class(TRadarUnit) {
	
    OnIntelDisabled = function(self)
        TRadarUnit.OnIntelDisabled(self)
        self.UpperRotator:SetTargetSpeed(0)
    end,


    OnIntelEnabled = function(self)
        TRadarUnit.OnIntelEnabled(self)
        if not self.UpperRotator then
            self.UpperRotator = CreateRotator( self, 'Spinner', 'y' )
            self.Trash:Add(self.UpperRotator)
        end
        self.UpperRotator:SetTargetSpeed(20)
        self.UpperRotator:SetAccel(10)
    end,

}

TypeClass = UEL0307