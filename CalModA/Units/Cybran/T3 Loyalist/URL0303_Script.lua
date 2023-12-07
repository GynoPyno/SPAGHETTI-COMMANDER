

local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit
local Weapon = import('/lua/sim/Weapon.lua').Weapon
local cWeapons = import('/lua/cybranweapons.lua')
local TWeapons = import('/lua/terranweapons.lua')

local CDFLaserDisintegratorWeapon = import('/lua/cybranweapons.lua').CDFLaserDisintegratorWeapon02
local TIFFragLauncherWeapon = TWeapons.TDFFragmentationGrenadeLauncherWeapon


URL0303 = Class(CWalkingLandUnit) 
{
    Weapons = {
        Disintigrator = Class(CDFLaserDisintegratorWeapon) {},
        Grenade = Class(TIFFragLauncherWeapon) {},
    },

    OnStopBeingBuilt = function(self,builder,layer)
        CWalkingLandUnit.OnStopBeingBuilt(self,builder,layer)
        self:SetMaintenanceConsumptionActive()
        self:HideBone('Turret', true)
    end,


    OnKilled = function(self, instigator, type, overkillRatio)

        CWalkingLandUnit.OnKilled(self, instigator, type, overkillRatio)
        CreateLightParticle( self, -1, -1, 30, 30, 'flare_lens_add_02', 'ramp_red_10' )
    end,

}

TypeClass = URL0303