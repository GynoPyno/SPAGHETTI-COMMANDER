#****************************************************************************
#**
#**  File     :  /mods/Hyper Experimental Tier/units/Mouse/XUEL0202_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  UEF Hyper Experimental Heavy Tank
#**
#****************************************************************************
local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local TDFGaussCannonWeapon = import('/lua/terranweapons.lua').TDFGaussCannonWeapon

XUEL0202 = Class(TLandUnit) {
    Weapons = {
        FrontTurret01 = Class(TDFGaussCannonWeapon) {
        }
    },
}

TypeClass = XUEL0202
