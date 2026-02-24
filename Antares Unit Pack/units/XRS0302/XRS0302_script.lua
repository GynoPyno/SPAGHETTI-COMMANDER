local CSeaUnit = import('/lua/cybranunits.lua').CSeaUnit

local Weapon = import('/lua/sim/Weapon.lua').Weapon
local WeaponFile = import('/lua/sim/defaultweapons.lua')
local CybranWeaponsFile = import('/lua/cybranweapons.lua')

local CAANanoDartWeapon = CybranWeaponsFile.CAANanoDartWeapon


XRS0302 = Class(CSeaUnit) {
    Weapons = {
        AAGun01 = Class(CAANanoDartWeapon) {},
        AAGun02 = Class(CAANanoDartWeapon) {},
        AAGun03 = Class(CAANanoDartWeapon) {},
        AAGun04 = Class(CAANanoDartWeapon) {},

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
        self.Trash:Add(CreateRotator(self, 'Spinner05', 'y', nil, 180, 0, 180))
    end,
}

TypeClass = XRS0302