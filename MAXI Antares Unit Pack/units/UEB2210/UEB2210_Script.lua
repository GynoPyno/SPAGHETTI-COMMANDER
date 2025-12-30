local TStructureUnit = import('/lua/terranunits.lua').TStructureUnit

local WeaponsFile = import('/lua/terranweapons.lua')

local TAMPhalanxWeapon = import('/lua/terranweapons.lua').TAMPhalanxWeapon
local TIFArtilleryWeapon = import('/lua/terranweapons.lua').TIFArtilleryWeapon

UEB2210 = Class(TStructureUnit) {
    Weapons = {
		Gatling01 = Class(TIFArtilleryWeapon) {
				FxMuzzleFlashScale = 3,
                PlayFxWeaponUnpackSequence = function(self)
                    if not self.SpinManip then 
                        self.SpinManip = CreateRotator(self.unit, 'AxeGatling', 'z', nil, 130, 180, 60)
                        self.unit.Trash:Add(self.SpinManip)
                    end
                    if self.SpinManip then
                        self.SpinManip:SetTargetSpeed(130)
                    end
                    TAMPhalanxWeapon.PlayFxWeaponUnpackSequence(self)
                end,

                PlayFxWeaponPackSequence = function(self)
                    if self.SpinManip then
                        self.SpinManip:SetTargetSpeed(0)
                    end
                    TAMPhalanxWeapon.PlayFxWeaponUnpackSequence(self)
                end,
        },
    },
}

TypeClass = UEB2210