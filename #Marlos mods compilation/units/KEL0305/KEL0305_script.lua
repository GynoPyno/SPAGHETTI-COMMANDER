#****************************************************************************
#**
#**  File     :  
#**  Author(s):  MarLo
#**
#**  Summary  :  UEF Mobile Defense Platform Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local TSAMLauncher = import('/lua/terranweapons.lua').TSAMLauncher
local TAMPhalanxWeapon = import('/lua/terranweapons.lua').TAMPhalanxWeapon

XEL0306 = Class(TLandUnit) {
    Weapons = {
        MissileRack01 = Class(TSAMLauncher) {},
		
        Turret01 = Class(TAMPhalanxWeapon) {
                PlayFxWeaponUnpackSequence = function(self)
                    if not self.SpinManip then 
                        self.SpinManip = CreateRotator(self.unit, 'Turret_Barrel_02', 'z', nil, 270, 180, 60)
                        self.unit.Trash:Add(self.SpinManip)
                    end
                    if self.SpinManip then
                        self.SpinManip:SetTargetSpeed(270)
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
    },
}

TypeClass = XEL0306