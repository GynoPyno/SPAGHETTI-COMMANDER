#****************************************************************************
#**
#**  File     :  /cdimage/units/URL0202/URL0202_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Cybran Heavy Tank Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CLandUnit = import('/lua/cybranunits.lua').CLandUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local Weaponfile2 = import('/mods/Annihilation New SupCom/lua/Hawkeyeweapons.lua')
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local MiniQuantumBeamGenerator = Weaponfile2.MiniQuantumBeamGenerator
local EffectTemplate = import('/lua/EffectTemplates.lua')


URL02021 = Class(CLandUnit) {
    Weapons = {
		Upgrade02Gun01 = Class(MiniQuantumBeamGenerator) {},
		MainGun2 = Class(TDFGaussCannonWeapon) {  
			FxMuzzleFlashScale = 3.95,
			FxMuzzleFlash = EffectTemplate.ASDisruptorCannonChargeMuzzle01,
		}, 
    },
}

TypeClass = URL02021