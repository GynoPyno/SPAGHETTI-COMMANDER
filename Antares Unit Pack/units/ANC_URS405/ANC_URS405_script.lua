local CSubUnit = import('/lua/cybranunits.lua').CSubUnit

local Weapon = import('/lua/sim/Weapon.lua').Weapon
local WeaponFile = import('/lua/sim/defaultweapons.lua')
local CybranWeaponsFile = import('/lua/cybranweapons.lua')

local CIFMissileStrategicWeapon = CybranWeaponsFile.CIFMissileStrategicWeapon
local CIFMissileLoaWeapon = CybranWeaponsFile.CIFMissileLoaWeapon
local CANTorpedoLauncherWeapon = CybranWeaponsFile.CANTorpedoLauncherWeapon
local CIFSmartCharge = import('/lua/cybranweapons.lua').CIFSmartCharge
local CIFCommanderDeathWeapon = CybranWeaponsFile.CIFCommanderDeathWeapon

local explosion = import('/lua/defaultexplosions.lua')
local util = import('/lua/utilities.lua')
local utilities = import('/lua/Utilities.lua')
local fxutil = import('/lua/effectutilities.lua')
local Effects = import('/lua/effecttemplates.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')

ANC_URS405 = Class(CSubUnit) {
    Weapons = {
        DeathWeapon = Class(CIFCommanderDeathWeapon) {},
        NukeMissile = Class(CIFMissileStrategicWeapon) {},
        CruiseMissile = Class(CIFMissileLoaWeapon) {},
        Torpedo01 = Class(CANTorpedoLauncherWeapon) {},
        Torpedo02 = Class(CANTorpedoLauncherWeapon) {},
        AntiTorpedoF = Class(CIFSmartCharge) {},
        AntiTorpedoB = Class(CIFSmartCharge) {},
    },

    OnStopBeingBuilt = function(self,builder,layer)
        CSubUnit.OnStopBeingBuilt(self,builder,layer)
        self:SetMaintenanceConsumptionActive()
        self:RequestRefreshUI() 
     end,  	
}

TypeClass = ANC_URS405

