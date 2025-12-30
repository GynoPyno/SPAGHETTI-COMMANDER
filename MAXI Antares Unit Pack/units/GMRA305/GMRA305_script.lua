local CAirUnit = import('/lua/cybranunits.lua').CAirUnit

local Weapon = import('/lua/sim/Weapon.lua').Weapon
local WeaponFile = import('/lua/sim/defaultweapons.lua')
local CybranWeaponsFile = import('/lua/cybranweapons.lua')

local CAAMissileNaniteWeapon = import('/lua/cybranweapons.lua').CAAMissileNaniteWeapon
local CDFLaserHeavyWeapon = import('/lua/cybranweapons.lua').CDFLaserHeavyWeapon

GMRA305 = Class(CAirUnit) {
    
    Weapons = {
        Missiles = Class(CAAMissileNaniteWeapon) {},
        Disintegrator01 = Class(CDFLaserHeavyWeapon) {},
        Disintegrator02 = Class(CDFLaserHeavyWeapon) {},
    },
    OnStopBeingBuilt = function(self,builder,layer)
        CAirUnit.OnStopBeingBuilt(self,builder,layer)
        self.Trash:Add(CreateRotator(self, 'RearBlade', 'y', nil, -200))
        self.Trash:Add(CreateRotator(self, 'MainBlade', 'y', nil, 360))
    end,    
}
TypeClass = GMRA305