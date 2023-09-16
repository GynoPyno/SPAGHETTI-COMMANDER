--****************************************************************************
--**
--**  File     :  /cdimage/units/UEL0106/UEL0106_script.lua
--**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
--**
--**  Summary  :  UEF Light Assault Bot Script
--**
--**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
--****************************************************************************

local TWalkingLandUnit = import('/lua/terranunits.lua').TWalkingLandUnit
local TDFMachineGunWeapon = import('/lua/terranweapons.lua').TDFMachineGunWeapon
local TSAMLauncher = import('/lua/terranweapons.lua').TSAMLauncher

UEL0106 = Class(TWalkingLandUnit) {
    Weapons = {
        ArmCannonTurret = Class(TDFMachineGunWeapon) {
            DisabledFiringBones = {
                'Torso', 'Head',  'Arm_Right_B01', 'Arm_Right_B02','Arm_Right_Muzzle',
                'Arm_Left_B01', 'Arm_Left_B02','Arm_Left_Muzzle'
                },
        },
        UpgradeGun01 = Class(TSAMLauncher) {},
        UpgradeGun02 = Class(TDFMachineGunWeapon) {},
    },

    OnCreate = function(self)
        TWalkingLandUnit.OnCreate(self)

    end,
}
TypeClass = UEL0106
