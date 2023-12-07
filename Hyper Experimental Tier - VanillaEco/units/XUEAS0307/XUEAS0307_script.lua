#****************************************************************************
#**
#**  File     :  /mods/Hyper Experimental Tier/units/XUEAS0307/XUEAS0307_script.lua
#**  Author(s):  Cmd Draven
#**
#**  Summary  :  UEF Experimental Artillery Battleship
#**
#****************************************************************************
local TSeaUnit = import('/lua/terranunits.lua').TSeaUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local TAMPhalanxWeapon = WeaponsFile.TAMPhalanxWeapon
local TDFHiroPlasmaCannon = WeaponsFile.TDFHiroPlasmaCannon
local TANTorpedoAngler = WeaponsFile.TANTorpedoAngler
local TIFSmartCharge = WeaponsFile.TIFSmartCharge
local TIFArtilleryWeapon = import('/lua/terranweapons.lua').TIFArtilleryWeapon

XUEAS0307 = Class(TSeaUnit) {
    Weapons = {
        MainGun = Class(TIFArtilleryWeapon) {
            FxMuzzleFlashScale = 3,
        },
        HiroCannonBack = Class(TDFHiroPlasmaCannon) {},
        AntiTorpedo = Class(TIFSmartCharge) {},
        TorpedoLeft01 = Class(TANTorpedoAngler) {},
        TorpedoRight01 = Class(TANTorpedoAngler) {},

        OnKilled = function(self)
            local wep2 = self:GetWeaponByLabel('HiroCannonBack')
            local bp2 = wep2:GetBlueprint()
            if bp2.Audio.BeamStop then
                wep2:PlaySound(bp2.Audio.BeamStop)
            end
            if bp2.Audio.BeamLoop and wep2.Beams[1].Beam then
                wep2.Beams[1].Beam:SetAmbientSound(nil, nil)
            end
            for k, v in wep2.Beams do
                v.Beam:Disable()
            end

            TSeaUnit.OnKilled(self)
        end,
    },
}
TypeClass = XUEAS0307
