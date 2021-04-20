local CSeaUnit = import('/lua/cybranunits.lua').CSeaUnit

local Weapon = import('/lua/sim/Weapon.lua').Weapon
local WeaponFile = import('/lua/sim/defaultweapons.lua')
local CybranWeaponsFile = import('/lua/cybranweapons.lua')

local CDFHvyProtonCannonWeapon = CybranWeaponsFile.CDFHvyProtonCannonWeapon
local CAAAutocannon = CybranWeaponsFile.CAAAutocannon
local CDFProtonCannonWeapon = CybranWeaponsFile.CDFProtonCannonWeapon
local CANNaniteTorpedoWeapon = CybranWeaponsFile.CANNaniteTorpedoWeapon
local CAMZapperWeapon02 = CybranWeaponsFile.CAMZapperWeapon02

       
XRS0402= Class(CSeaUnit) {
    Weapons = {
        MainCannon01 = Class(CDFHvyProtonCannonWeapon) {},
        MainCannon02 = Class(CDFHvyProtonCannonWeapon) {},
        BackCannon01 = Class(CDFProtonCannonWeapon) {},
        RightCannon01 = Class(CDFProtonCannonWeapon) {},
        RightCannon02 = Class(CDFProtonCannonWeapon) {},
        LeftCannon01 = Class(CDFProtonCannonWeapon) {},
        LeftCannon02 = Class(CDFProtonCannonWeapon) {},
        AAGun01 = Class(CAAAutocannon) {},
        AAGun02 = Class(CAAAutocannon) {},
        LeftZapper = Class(CAMZapperWeapon02) {},
        RightZapper = Class(CAMZapperWeapon02) {},
        Torpedoes = Class(CANNaniteTorpedoWeapon) {},
    },
}

TypeClass = XRS0402