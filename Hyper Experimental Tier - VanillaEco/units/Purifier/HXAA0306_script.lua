#****************************************************************************
#**
#**  File     :  /mods/Hyper Experimental Tier/units/Purifier/HXAA0306_script.lua
#**  Author(s):  Cmd Draven
#**  Summary  :  Aeon Hyper Experimental ASF
#**
#**  Copyright © Cmd Draven
#****************************************************************************

local AAirUnit = import('/lua/aeonunits.lua').AAirUnit
local aWeapons = import('/lua/aeonweapons.lua')
local ADFPhasonLaser = aWeapons.ADFPhasonLaser
local AAATemporalFizzWeapon = aWeapons.AAATemporalFizzWeapon
local explosion = import('/lua/defaultexplosions.lua')


HXAA0306 = Class(AAirUnit) {
    Weapons = {
        Laser = Class(ADFPhasonLaser) {},
        AAFizz01 = Class(AAATemporalFizzWeapon) {},
        AAFizz02 = Class(AAATemporalFizzWeapon) {},
    },

    OnKilled = function(self, instigator, type, overkillRatio)
        self.detector = CreateCollisionDetector(self)
        self.Trash:Add(self.detector)
        self.detector:WatchBone('Purifier')
        self.detector:WatchBone('Contrail01')
        self.detector:WatchBone('Contrail02')
        self.detector:WatchBone('Exhaust')
        self.detector:WatchBone('Flak1')
        self.detector:WatchBone('Flak2')
        self.detector:WatchBone('Laser')
        self.detector:EnableTerrainCheck(true)
        self.detector:Enable()
    end,
	    OnKilled = function(self, instigator, type, overkillRatio)
        AAirUnit.OnKilled(self, instigator, type, overkillRatio)
        local wep = self:GetWeaponByLabel('Laser')
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

    OnAnimTerrainCollision = function(self, bone,x,y,z)
        DamageArea(self, {x,y,z}, 5, 1000, 'Default', true, false)
        explosion.CreateDefaultHitExplosionAtBone(self, bone, 5.0)
        explosion.CreateDebrisProjectiles(self, explosion.GetAverageBoundingXYZRadius(self), {self:GetUnitSizes()})
    end,


}

TypeClass = HXAA0306
