local TStructureUnit = import('/lua/terranunits.lua').TStructureUnit
local TWeapons = import('/lua/terranweapons.lua')
local TDFGaussCannonWeapon = TWeapons.TDFGaussCannonWeapon
local TSAMLauncher = TWeapons.TSAMLauncher
local TAMPhalanxWeapon = TWeapons.TAMPhalanxWeapon
local TIFCommanderDeathWeapon = TWeapons.TIFCommanderDeathWeapon

GEB2401 = Class(TStructureUnit) {
    Weapons = {
        MainGun = Class(TDFGaussCannonWeapon) {},
	MissileRack = Class(TSAMLauncher) {},
        Turret = Class(TAMPhalanxWeapon) {
	    PlayFxWeaponUnpackSequence = function(self)
		if not self.SpinManip then 
                    self.SpinManip = CreateRotator(self.unit, 'TMD_Rotator', 'z', nil, 270, 180, 60)
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
        DeathWeapon = Class(TIFCommanderDeathWeapon) {},
    },
}

TypeClass = GEB2401