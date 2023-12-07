#****************************************************************************
#**
#**  File     :  /cdimage/units/URS0202/URS0202_script.lua
#**  Author(s):  David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Cybran Cruiser Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CSeaUnit = import('/lua/cybranunits.lua').CSeaUnit
local CybranWeaponsFile = import('/lua/cybranweapons.lua')
local CDFProtonCannonWeapon = CybranWeaponsFile.CDFProtonCannonWeapon
local TAAFlakArtilleryCannon = import('/lua/terranweapons.lua').TAAFlakArtilleryCannon

URS0202 = Class(CSeaUnit) {
    Weapons = {
        ParticleGun = Class(CDFProtonCannonWeapon) {},
        AAGun = Class(TAAFlakArtilleryCannon) {},
    },
    
    OnCreate = function(self)
        CSeaUnit.OnCreate(self)
        self:HideBone('zapper', true)
    end,
    
}

TypeClass = URS0202