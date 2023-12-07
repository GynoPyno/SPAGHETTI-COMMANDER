--[[#######################################################################
#  File     :  /units/LED0015/LED0015_script.lua
#  Author(s):  GPG Devs
#  Summary  :  Seraphim Heavy Bot Script
#  -----------------------------
#  Modif.by :  AsdrubaelVect
#  Rev.Date :  5 septembre 2009
#  -----------------------------
#  Revis.by :  Manimal
#  Rev.Date :  20 novembre 2009
#  -----------------------------
#  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#######################################################################]]--


local SWalkingLandUnit = import('/lua/seraphimunits.lua').SWalkingLandUnit
local SeraphimWeapons = import('/lua/seraphimweapons.lua')
local SDFAireauBolterWeapon = SeraphimWeapons.SDFAireauBolterWeapon02
local SAAOlarisCannonWeapon = SeraphimWeapons.SAAOlarisCannonWeapon
local SDFHeavyQuarnonCannon = SeraphimWeapons.SDFHeavyQuarnonCannon

LED0015 = Class(SWalkingLandUnit) {
    Weapons = {
        MainGun = Class(SDFAireauBolterWeapon) {},
		AAGun = Class(SAAOlarisCannonWeapon) {},
		FrontTurret = Class(SDFHeavyQuarnonCannon) {},
    },
}

TypeClass = LED0015
