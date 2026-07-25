#****************************************************************************
#**
#**  File     :  /cdimage/units/UEL0202/UEL0202_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  UEF Heavy Tank Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local TSAMLauncher = import('/lua/terranweapons.lua').TSAMLauncher
local TargetingLaser = import('/lua/kirvesweapons.lua').TargetingLaserInvisible
local CybranWeaponsFile = import('/lua/cybranweapons.lua')

MK42 = Class(TLandUnit) {
    Weapons = {
        TargetPainter = Class(TargetingLaser) {

            -- Unit in range. Cease ground fire and turn on AA
            OnWeaponFired = function(self)
                if not self.AA then
                    self.unit:SetWeaponEnabledByLabel('GroundGun', false)
                    self.unit:SetWeaponEnabledByLabel('AAGun', true)
                    self.unit:GetWeaponManipulatorByLabel('AAGun'):SetHeadingPitch(self.unit:GetWeaponManipulatorByLabel('GroundGun'):GetHeadingPitch())
                    self.AA = true
                end
                TargetingLaser.OnWeaponFired(self)
            end,

            IdleState = State(TargetingLaser.IdleState) {
                -- Start with the AA gun off to reduce twitching of ground fire
                Main = function(self)
                    self.unit:SetWeaponEnabledByLabel('GroundGun', true)
                    self.unit:SetWeaponEnabledByLabel('AAGun', false)
                    self.unit:GetWeaponManipulatorByLabel('GroundGun'):SetHeadingPitch(self.unit:GetWeaponManipulatorByLabel('AAGun'):GetHeadingPitch())
                    self.AA = false
                    TargetingLaser.IdleState.Main(self)
                end,
            },
        },
        AAGun = Class(TSAMLauncher) {},
        GroundGun = Class(TSAMLauncher) {},
    },
}

TypeClass = MK42