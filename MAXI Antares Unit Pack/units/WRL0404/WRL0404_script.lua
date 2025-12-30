local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit
local CybranWeaponsFile = import('/lua/cybranweapons.lua')
local weaponfile2 = import('/mods/Antares Unit Pack/lua/Hawkeyeweapons.lua')
local MiniHeavyMicrowaveLaserGenerator = weaponfile2.MiniHeavyMicrowaveLaserGenerator
local CDFHvyProtonCannonWeapon = CybranWeaponsFile.CDFHvyProtonCannonWeapon
local CAABurstCloudFlakArtilleryWeapon = CybranWeaponsFile.CAABurstCloudFlakArtilleryWeapon

WRL0404 = Class(CWalkingLandUnit) {
    Weapons = {
        MainGun = Class(CDFHvyProtonCannonWeapon) {},
		
        RightLaserTurret = Class(MiniHeavyMicrowaveLaserGenerator) {},
        LeftLaserTurret = Class(MiniHeavyMicrowaveLaserGenerator) {},
		
        AAGun1 = Class(CAABurstCloudFlakArtilleryWeapon) {},
        AAGun2 = Class(CAABurstCloudFlakArtilleryWeapon) {},
        AAGun3 = Class(CAABurstCloudFlakArtilleryWeapon) {},
        AAGun4 = Class(CAABurstCloudFlakArtilleryWeapon) {},
    },
}

TypeClass = WRL0404