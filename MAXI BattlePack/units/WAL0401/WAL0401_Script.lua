#****************************************************************************
#**
#**  File     :  /cdimage/units/UAL0401/UAL0401_script.lua
#**  Author(s):  John Comes, Gordon Duclos
#**
#**  Summary  :  Aeon Galactic Colossus Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local AWalkingLandUnit = import('/lua/aeonunits.lua').AWalkingLandUnit
local WeaponsFile = import ('/lua/aeonweapons.lua')
local ADFPhasonLaser = WeaponsFile.ADFPhasonLaser
local ADFTractorClaw = WeaponsFile.ADFTractorClaw

WAL0401 = Class(AWalkingLandUnit) {
    Weapons = {
        EyeWeapon = Class(ADFPhasonLaser) {},
        RightArmTractor = Class(ADFTractorClaw) {},
        LeftArmTractor = Class(ADFTractorClaw) {},
    },

    OnKilled = function(self, instigator, type, overkillRatio)
        AWalkingLandUnit.OnKilled(self, instigator, type, overkillRatio)
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
TypeClass = WAL0401