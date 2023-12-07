
local CAirUnit = import('/lua/cybranunits.lua').CAirUnit
local CAAMissileNaniteWeapon = import('/lua/cybranweapons.lua').CAAMissileNaniteWeapon
local EffectUtil = import('/lua/EffectUtilities.lua')

XRA0305 = Class(CAirUnit) {
    
    Weapons = {
        MainGun = Class(CAAMissileNaniteWeapon) {},
    },

    OnStopBeingBuilt = function(self,builder,layer)
        CAirUnit.OnStopBeingBuilt(self,builder,layer)

        local EfctTempl = {
            '/Mods/calmoda/units/cybran/t1 hover scout/effects/cybran_hover_01_emit.bp',
        }
	for k, v in EfctTempl do
	    CreateAttachedEmitter(self, 'XRA0305', self.Army, v):ScaleEmitter(0.25)
	end
    end,

    OnCreate = function(self)
        CAirUnit.OnCreate(self)
        self:SetWeaponEnabledByLabel('MissileWeapon2', false)
        self:HideBone('Turret_Down_01', true)	
        self:HideBone('Turret_Down_02', true)		
    end,

}
TypeClass = XRA0305