local TWalkingLandUnit = import('/lua/terranunits.lua').TWalkingLandUnit
local TAAFlakArtilleryCannon = import('/lua/terranweapons.lua').TAAFlakArtilleryCannon

WEL0309 = Class(TWalkingLandUnit) {
    Weapons = {
        AAGun = Class(TAAFlakArtilleryCannon) {},
           
    },
    
}

TypeClass = WEL0309