local CSeaUnit = import('/lua/cybranunits.lua').CSeaUnit

local Weapon = import('/lua/sim/Weapon.lua').Weapon
local WeaponFile = import('/lua/sim/defaultweapons.lua')
local CybranWeaponsFile = import('/lua/cybranweapons.lua')

local CAAAutocannon = CybranWeaponsFile.CAAAutocannon
local CDFProtonCannonWeapon = CybranWeaponsFile.CDFProtonCannonWeapon
local CANNaniteTorpedoWeapon = CybranWeaponsFile.CANNaniteTorpedoWeapon
local CDFParticleCannonWeapon = CybranWeaponsFile.CDFParticleCannonWeapon

URS_Prg = Class(CSeaUnit) {
    Weapons = {
        FrontCannon01 = Class(CDFProtonCannonWeapon) {},

       LZRFrontTurret = Class(CDFParticleCannonWeapon) {},
       LZRFrontLeftTurret = Class(CDFParticleCannonWeapon) {},
       LZRFrontRightTurret = Class(CDFParticleCannonWeapon) {},
       LZRRearLeftTurret = Class(CDFParticleCannonWeapon) {},
       LZRRearRightTurret = Class(CDFParticleCannonWeapon) {},

        AAGunCF = Class(CAAAutocannon) {},
        AAGunCC = Class(CAAAutocannon) {},
        AAGunCR = Class(CAAAutocannon) {},
        AAGunRC = Class(CAAAutocannon) {},
        TorpedoA = Class(CANNaniteTorpedoWeapon) {},
        TorpedoB = Class(CANNaniteTorpedoWeapon) {},
        TorpedoC = Class(CANNaniteTorpedoWeapon) {},
        TorpedoD = Class(CANNaniteTorpedoWeapon) {},
    },
    OnKilled = function(self, inst, type, okr)
        self.Trash:Destroy()
        self.Trash = TrashBag()
#        spawn some crazy nekkid japanese party girls
	CSeaUnit.OnKilled(self, inst, type, okr)
    end,
}

TypeClass = URS_Prg