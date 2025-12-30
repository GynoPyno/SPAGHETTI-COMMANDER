#****************************************************************************
#**
#**  File     :  /cdimage/units/UES0302/UES0302_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  UEF Battleship Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TSeaUnit = import('/lua/terranunits.lua').TSeaUnit
local TerranWeaponFile = import('/lua/terranweapons.lua')
local TDFIonizedPlasmaCannon = TerranWeaponFile.TDFIonizedPlasmaCannon
local TAMPhalanxWeapon = TerranWeaponFile.TAMPhalanxWeapon
local TSAMLauncher = TerranWeaponFile.TSAMLauncher
local TANTorpedoAngler = TerranWeaponFile.TANTorpedoAngler

WES0303 = Class(TSeaUnit) {

 Weapons = {
        RightPhalanxGun01 = Class(TAMPhalanxWeapon) {
            PlayFxWeaponUnpackSequence = function(self)
                if not self.SpinManip then 
                    self.SpinManip = CreateRotator(self.unit, 'TMD_Turret_Barrel', 'z', nil, 270, 180, 60)
                    self.unit.Trash:Add(self.SpinManip)
                end
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(500):SetPrecedence(100)
                end
                TAMPhalanxWeapon.PlayFxWeaponUnpackSequence(self)
            end,

            PlayFxWeaponPackSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(0)
                end
                TAMPhalanxWeapon.PlayFxWeaponPackSequence(self)
            end,
            
        },
        FrontTurret01 = Class(TDFIonizedPlasmaCannon) {},
        FrontTurret02 = Class(TDFIonizedPlasmaCannon) {},
        BackTurret = Class(TDFIonizedPlasmaCannon) {},
		RightRearAA = Class(TSAMLauncher) {},
		RightFrontAA = Class(TSAMLauncher) {},
		LeftFrontAA = Class(TSAMLauncher) {},
		LeftRearAA = Class(TSAMLauncher) {},
		Torpedo01 = Class(TANTorpedoAngler) {},
		Torpedo02 = Class(TANTorpedoAngler) {},
    },

}

TypeClass = WES0303