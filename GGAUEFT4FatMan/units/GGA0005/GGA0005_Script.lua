#****************************************************************************
#**
#**  File     : 
#**  Author(s):  bbkineebee
#**
#**  Summary  :  UEF Fat Man
#**
#****************************************************************************
local TWalkingLandUnit = import('/lua/terranunits.lua').TWalkingLandUnit
local WeaponsFile = import ('/lua/terranweapons.lua')
local TDFHiroPlasmaCannon = WeaponsFile.TDFHiroPlasmaCannon
local TDFHeavyPlasmaCannonWeapon = WeaponsFile.TDFHeavyPlasmaGatlingCannonWeapon


GGA0005 = Class(TWalkingLandUnit) {
    Weapons = {
        EyeWeapon = Class(TDFHiroPlasmaCannon) {},  
        RightArmGun = Class(TDFHeavyPlasmaCannonWeapon) {},
        LeftArmGun = Class(TDFHeavyPlasmaCannonWeapon) {},
    },

    OnKilled = function(self, instigator, type, overkillRatio)
        TWalkingLandUnit.OnKilled(self, instigator, type, overkillRatio)

        local wep = self:GetWeaponByLabel('EyeWeapon')
        local bp = wep:GetBlueprint()

        if bp.Audio.BeamStop then
            wep:PlaySound(bp.Audio.BeamStop)
        end

        if bp.Audio.BeamLoop and wep.Beams[1].Beam then
            wep.Beams[1].Beam:SetAmbientSound(nil, nil)
        end

        for k, v in wep.Beams do
            v.Beam:Disable()
        end   
	
    end,
    
}
TypeClass = GGA0005