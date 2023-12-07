------------------------------------------------------------------------------
-- Author(s):  Mikko Tyster, Atte Hulkkonen
-- Summary  :  Seraphim T3 Mobile Lightning Anti-Air
-- Copyright © 2008 Blade Braver!
------------------------------------------------------------------------------

local SLandUnit = import("/lua/seraphimunits.lua").SLandUnit
local SDFUltraChromaticBeamGenerator = import("/lua/seraphimweapons.lua").SDFUltraChromaticBeamGenerator
local ADFPhasonLaser = import("/lua/aeonweapons.lua").ADFPhasonLaser

DSLK004 = ClassUnit(SLandUnit) {
    Weapons = {
        PhasonBeamGround = ClassWeapon(ADFPhasonLaser) {},
    },

    OnStopBeingBuilt = function(self,builder,layer)
        SLandUnit.OnStopBeingBuilt(self,builder,layer)

        local EfctTempl = {
            '/Effects/Emitters/orbeffect_01.bp',
            '/Effects/Emitters/orbeffect_02.bp',
        }
        for k, v in EfctTempl do
            CreateAttachedEmitter(self, 'Orb', self.Army, v):ScaleEmitter(3)
        end
    end,
}
TypeClass = DSLK004