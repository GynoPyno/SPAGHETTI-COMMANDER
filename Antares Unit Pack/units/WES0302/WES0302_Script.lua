local TSeaUnit = import('/lua/terranunits.lua').TSeaUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local TSAMLauncher = WeaponsFile.TSAMLauncher
local TAMPhalanxWeapon = WeaponsFile.TAMPhalanxWeapon
local TDFGaussCannonWeapon = WeaponsFile.TDFShipGaussCannonWeapon
local TANTorpedoAngler = WeaponsFile.TANTorpedoAngler

WES0302 = Class(TSeaUnit) {


    Weapons = {
        RightAAGun01 = Class(TSAMLauncher) {},
        RightAAGun02 = Class(TSAMLauncher) {},
        LeftAAGun01 = Class(TSAMLauncher) {},
        LeftAAGun02 = Class(TSAMLauncher) {},
        LeftPhalanxGun01 = Class(TAMPhalanxWeapon) {
            PlayFxWeaponUnpackSequence = function(self)
                if not self.SpinManip then 
                    self.SpinManip = CreateRotator(self.unit, 'Left_Turret02_Barrel', 'z', nil, 270, 180, 60)
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
        FrontTurret01 = Class(TDFGaussCannonWeapon) {},
        FrontTurret02 = Class(TDFGaussCannonWeapon) {},
        BackTurret = Class(TDFGaussCannonWeapon) {},
        Torpedo01 = Class(TANTorpedoAngler) {},
    },
}

TypeClass = WES0302