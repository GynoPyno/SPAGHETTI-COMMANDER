local CSeaUnit = import('/lua/cybranunits.lua').CSeaUnit

local Weapon = import('/lua/sim/Weapon.lua').Weapon
local WeaponFile = import('/lua/sim/defaultweapons.lua')
local CybranWeaponsFile = import('/lua/cybranweapons.lua')

local CAAAutocannon = CybranWeaponsFile.CAAAutocannon
local CDFProtonCannonWeapon = CybranWeaponsFile.CDFProtonCannonWeapon
local CANNaniteTorpedoWeapon = CybranWeaponsFile.CANNaniteTorpedoWeapon
local CAMZapperWeapon02 = CybranWeaponsFile.CAMZapperWeapon02
local CAAMissileNaniteWeapon = import('/lua/cybranweapons.lua').CAAMissileNaniteWeapon

local util = import('/lua/utilities.lua')
local utilities = import('/lua/Utilities.lua')
local fxutil = import('/lua/effectutilities.lua')
local Effects = import('/lua/effecttemplates.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')

CT4BS = Class(CSeaUnit) {
    Weapons = {
        FrontCannon01 = Class(CDFProtonCannonWeapon) {},
        FrontCannon02 = Class(CDFProtonCannonWeapon) {},
        BackCannon01 = Class(CDFProtonCannonWeapon) {},
        BackCannon02 = Class(CDFProtonCannonWeapon) {},
        RightCannon01 = Class(CDFProtonCannonWeapon) {},
        RightCannon02 = Class(CDFProtonCannonWeapon) {},
        LeftCannon01 = Class(CDFProtonCannonWeapon) {},
        LeftCannon02 = Class(CDFProtonCannonWeapon) {},
        Torpedo01 = Class(CANNaniteTorpedoWeapon) {},
        Torpedo02 = Class(CANNaniteTorpedoWeapon) {},
        AAGun01 = Class(CAAAutocannon) {},
        AAGun02 = Class(CAAAutocannon) {},
        AAGun03 = Class(CAAAutocannon) {},
        LeftZapper = Class(CAMZapperWeapon02) {},
        RightZapper = Class(CAMZapperWeapon02) {},
        LeftSam = Class(CAAMissileNaniteWeapon) {},
        LeftSam2 = Class(CAAMissileNaniteWeapon) {},
        RightSam = Class(CAAMissileNaniteWeapon) {},
        RightSam2 = Class(CAAMissileNaniteWeapon) {},
    },

    RadarThread = function(self)
        local spinner = CreateRotator(self, 'Spinner01', 'y', nil, 180, 0, 180)
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
    end,
}
TypeClass = CT4BS