#****************************************************************************
#**
#**  File     :  /cdimage/units/URS0302/URS0302_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix, Gordon Duclos
#**
#**  Summary  :  Cybran Battleship Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local CSeaUnit = import('/lua/cybranunits.lua').CSeaUnit
local CybranWeaponsFile = import('/lua/cybranweapons.lua')
local CAAAutocannon = CybranWeaponsFile.CAAAutocannon
local CDFProtonCannonWeapon = CybranWeaponsFile.CDFProtonCannonWeapon
local CANNaniteTorpedoWeapon = CybranWeaponsFile.CANNaniteTorpedoWeapon
local CDFElectronBolterWeapon = CybranWeaponsFile.CDFElectronBolterWeapon
local BPPPlasmaPPCProj = import('/mods/BattlePack/lua/BattlePackweapons.lua').BPPPlasmaPPCProj
local CAAMissileNaniteWeapon = CybranWeaponsFile.CAAMissileNaniteWeapon

WRS0401 = Class(CSeaUnit) {
    Weapons = {
		ShadowTurret = Class(BPPPlasmaPPCProj) {},
        MicrowaveTurret001 = Class(CDFElectronBolterWeapon) {},
		MicrowaveTurret002 = Class(CDFElectronBolterWeapon) {},
        LeftMiniTurret001 = Class(CDFProtonCannonWeapon) {},
		LeftMiniTurret002 = Class(CDFProtonCannonWeapon) {},
		RightMiniTurret001 = Class(CDFProtonCannonWeapon) {},
		RightMiniTurret002 = Class(CDFProtonCannonWeapon) {},
        Torpedo01 = Class(CANNaniteTorpedoWeapon) {},
        AAGun01 = Class(CAAMissileNaniteWeapon) {},
        AAGun02 = Class(CAAMissileNaniteWeapon) {},
    },
}
TypeClass = WRS0401