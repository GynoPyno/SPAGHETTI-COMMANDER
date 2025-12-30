local EffectTemplate = import('/lua/EffectTemplates.lua')
local TSeaUnit = import('/lua/terranunits.lua').TSeaUnit
local WeaponFile = import('/lua/terranweapons.lua')
local TAAFlakArtilleryCannon = import('/lua/terranweapons.lua').TAAFlakArtilleryCannon


XES0302 = Class(TSeaUnit) {
    DestructionTicks = 200,

    Weapons = {
        FrontTurret01 = Class(TAAFlakArtilleryCannon) {},
        FrontTurret02 = Class(TAAFlakArtilleryCannon) {},
        BackTurret01 = Class(TAAFlakArtilleryCannon) {},
        BackTurret02 = Class(TAAFlakArtilleryCannon) {},
        BackTurret03 = Class(TAAFlakArtilleryCannon) {},
        RightTurret01 = Class(TAAFlakArtilleryCannon) {},
        LeftTurret01 = Class(TAAFlakArtilleryCannon) {},
      
    },

    RadarThread = function(self)
        local spinner = CreateRotator(self, 'Spinner04', 'y', nil, 180, 0, 180)
        while true do
            WaitFor(spinner)
            spinner:SetTargetSpeed(-35)
            WaitFor(spinner)
            spinner:SetTargetSpeed(35)
        end
    end,

    OnStopBeingBuilt = function(self, builder,layer)
        TSeaUnit.OnStopBeingBuilt(self, builder,layer)
        self:ForkThread(self.RadarThread)
        self.Trash:Add(CreateRotator(self, 'Spinner01', 'y', nil, 180, 0, 180))
        self.Trash:Add(CreateRotator(self, 'Spinner02', 'y', nil, 180, 0, 180))
        self.Trash:Add(CreateRotator(self, 'Spinner03', 'y', nil, 180, 0, 180))
        self.Trash:Add(CreateRotator(self, 'Spinner05', 'y', nil, 180, 0, 180))
        self.Trash:Add(CreateRotator(self, 'Spinner06', 'y', nil, 180, 0, 180))
    end,

}

TypeClass = XES0302
