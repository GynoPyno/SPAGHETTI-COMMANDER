local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit

local Weapon = import('/lua/sim/Weapon.lua').Weapon
local WeaponFile = import('/lua/sim/defaultweapons.lua')
local CybranWeaponsFile = import('/lua/cybranweapons.lua')

local CDFLaserHeavyWeapon = import('/lua/cybranweapons.lua').CDFLaserHeavyWeapon

WRL0303 = Class(CWalkingLandUnit) {
    Weapons = {
        MainGun = Class(CDFLaserHeavyWeapon) {},
    },
	
	OnStopBeingBuilt = function(self,builder,layer)
        CWalkingLandUnit.OnStopBeingBuilt(self,builder,layer)
            self:SetMaintenanceConsumptionInactive()
            self:SetScriptBit('RULEUTC_CloakToggle', true)
            self:RequestRefreshUI()
    end,
}

TypeClass = WRL0303