#****************************************************************************
#**
#**  File     :  /units/UES0204/UES0204_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  UEF Light Attack Sub Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local TSubUnit = import('/lua/terranunits.lua').TSubUnit
local TANTorpedoAngler = import('/lua/terranweapons.lua').TANTorpedoAngler
local TAALinkedRailgun = import('/lua/terranweapons.lua').TAALinkedRailgun
local TIFCruiseMissileLauncherSub = import('/lua/terranweapons.lua').TIFCruiseMissileLauncherSub

UES0204 = Class(TSubUnit) {
    PlayDestructionEffects = true,
    DeathThreadDestructionWaitTime = 0,

    Weapons = {
        Torpedo01 = Class(TANTorpedoAngler) {},
		AAUpgradeGun = Class(TAALinkedRailgun) {
            FxMuzzleFlashScale = 0.25,
        },
		TorpedoUpgrade01 = Class(TANTorpedoAngler) {},
		CruiseMissiles = Class(TIFCruiseMissileLauncherSub) {
 
        },
    },

    OnCreate = function(self)
		TSubUnit.OnCreate(self)

    end,
	
}

TypeClass = UES0204
