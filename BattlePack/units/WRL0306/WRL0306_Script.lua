local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit

local Weapon = import('/lua/sim/Weapon.lua').Weapon
local WeaponFile = import('/lua/sim/defaultweapons.lua')
local CybranWeaponsFile = import('/lua/cybranweapons.lua')

local CDFHvyProtonCannonWeapon = CybranWeaponsFile.CDFHvyProtonCannonWeapon
local CDFParticleCannonWeapon = CybranWeaponsFile.CDFParticleCannonWeapon
local CAANanoDartWeapon = CybranWeaponsFile.CAANanoDartWeapon
local MissileRedirect = import('/lua/defaultantiprojectile.lua').MissileRedirect

WRL0306 = Class(CWalkingLandUnit) {
	Weapons = {
        ParticleGun = Class(CDFHvyProtonCannonWeapon) {},
		LaserGun = Class(CDFParticleCannonWeapon) {
		OnWeaponFired = function(self)
                if self.unit:IsIntelEnabled('Cloak') then
                    self:ForkThread(self.DecloakForTimeout)
                end
            end,
			
            DecloakForTimeout = function(self)
                self.unit:DisableUnitIntel('Cloak')
                WaitSeconds(5)
                self.unit:EnableUnitIntel('Cloak')
            end, 
		},
        AAGun = Class(CAANanoDartWeapon) {},
    },
	
	OnStopBeingBuilt = function(self,builder,layer)
        CWalkingLandUnit.OnStopBeingBuilt(self,builder,layer)
            self:SetMaintenanceConsumptionInactive()
            self:SetScriptBit('RULEUTC_CloakToggle', true)
            self:RequestRefreshUI()
    end,
	
	OnScriptBitSet = function(self, bit)
        if bit == 8 then # cloak toggle
            self:StopUnitAmbientSound( 'ActiveLoop' )
            self:SetMaintenanceConsumptionInactive()
            self:DisableUnitIntel('Cloak')
            self:DisableUnitIntel('RadarStealth')
        end
    end,

    OnScriptBitClear = function(self, bit)
        if bit == 8 then # cloak toggle
            self:PlayUnitAmbientSound( 'ActiveLoop' )
            self:SetMaintenanceConsumptionActive()
            self:EnableUnitIntel('Cloak')
            self:EnableUnitIntel('RadarStealth')
        end
    end,
	
}

TypeClass = WRL0306