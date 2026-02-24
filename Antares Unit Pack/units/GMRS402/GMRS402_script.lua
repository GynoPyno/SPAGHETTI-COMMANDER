local CSeaUnit = import('/lua/cybranunits.lua').CSeaUnit

local Weapon = import('/lua/sim/Weapon.lua').Weapon
local WeaponFile = import('/lua/sim/defaultweapons.lua')
local CybranWeaponsFile = import('/lua/cybranweapons.lua')

local CAAMissileNaniteWeapon = CybranWeaponsFile.CAAMissileNaniteWeapon
local CANNaniteTorpedoWeapon = CybranWeaponsFile.CANNaniteTorpedoWeapon
local CAMZapperWeapon = CybranWeaponsFile.CAMZapperWeapon
local CIFMissileLoaWeapon = CybranWeaponsFile.CIFMissileLoaWeapon
local CIFCommanderDeathWeapon = CybranWeaponsFile.CIFCommanderDeathWeapon

local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')

GMRS402 = Class(CSeaUnit) {
    DestructionTicks = 200,

    Weapons = {
        DeathWeapon = Class(CIFCommanderDeathWeapon) {},
        AAGun = Class(CAAMissileNaniteWeapon) {},
        LeftZapper = Class(CAMZapperWeapon) {},
        RightZapper = Class(CAMZapperWeapon) {},
        Torpedo = Class(CANNaniteTorpedoWeapon) {},
        MissileRack = Class(CIFMissileLoaWeapon) {},
    },

    RadarThread = function(self)
        local spinner = CreateRotator(self, 'Spinner01', 'y', nil, 180, 0, 180)
        local spinner = CreateRotator(self, 'Spinner06', 'y', nil, 180, 0, 180)
        while true do
            WaitFor(spinner)
            spinner:SetTargetSpeed(-35)
            WaitFor(spinner)
            spinner:SetTargetSpeed(35)
        end
    end,

    OnStopBeingBuilt = function(self, builder,layer)
        CSeaUnit.OnStopBeingBuilt(self, builder,layer)
        self:ForkThread(self.RadarThread)
        self.Trash:Add(CreateRotator(self, 'Spinner02', 'y', nil, 180, 0, 180))
        self.Trash:Add(CreateRotator(self, 'Spinner03', 'y', nil, 180, 0, 180))
        self.Trash:Add(CreateRotator(self, 'Spinner04', 'y', nil, 180, 0, 180))
        self.Trash:Add(CreateRotator(self, 'Spinner05', 'y', nil, 180, 0, 180))
        self.Trash:Add(CreateRotator(self, 'Spinner07', 'y', nil, 180, 0, 180))
        self.Trash:Add(CreateRotator(self, 'Spinner08', 'y', nil, 180, 0, 180))
        while true do
            WaitFor(spinner)
            spinner:SetTargetSpeed(-45)
            WaitFor(spinner)
            spinner:SetTargetSpeed(45)
        end
    end,
}

TypeClass = GMRS402