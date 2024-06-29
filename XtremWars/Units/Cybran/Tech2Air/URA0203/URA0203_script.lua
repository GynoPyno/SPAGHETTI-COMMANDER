#****************************************************************************
#**
#**  File     :  /cdimage/units/URA0203/URA0203_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Cybran Gunship Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local CAirUnit = import('/lua/cybranunits.lua').CAirUnit
local CDFRocketIridiumWeapon = import('/lua/cybranweapons.lua').CDFRocketIridiumWeapon
local CAAAutocannon = import('/lua/cybranweapons.lua').CAAAutocannon

URA0203 = Class(CAirUnit) {
    Weapons = {
        Missile01 = Class(CDFRocketIridiumWeapon) {},
		Missile02 = Class(CDFRocketIridiumWeapon) {},
		BackGun01 = Class(CAAAutocannon) {},
    },

    DestructionPartsChassisToss = {'URA0203',},

    OnCreate = function(self)
        CAirUnit.OnCreate(self)

    end,		
	
    OnMotionVertEventChange = function(self, new, old)
        CAirUnit.OnMotionVertEventChange(self, new, old)
        if (new == 'Down') then
            # Keep the ambient hover sound going
            self:PlayUnitAmbientSound('AmbientMove')
        end
        if new == 'Bottom' then
            self:StopUnitAmbientSound( 'AmbientMove' )
        end
    end,

}

TypeClass = URA0203