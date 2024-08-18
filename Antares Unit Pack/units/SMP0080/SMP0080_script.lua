local TStructureUnit = import('/lua/terranunits.lua').TStructureUnit
local TAMPhalanxWeapon = import('/lua/terranweapons.lua').TAMPhalanxWeapon
local WeaponsFile = import('/lua/terranweapons.lua')
local WeaponFile = import('/lua/sim/defaultweapons.lua')

SMP0080 = Class(TStructureUnit) {
    Weapons = {
        Turret01 = Class(TAMPhalanxWeapon) {
                PlayFxWeaponUnpackSequence = function(self)
                    if not self.SpinManip then 
                        self.SpinManip = CreateRotator(self.unit, 'Turret_Barrel_B01', 'z', nil, 270, 180, 60)
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

TypeClass = SMP0080