local TEnergyCreationUnit = import('/lua/terranunits.lua').TEnergyCreationUnit
local TStructureUnit = import('/lua/terranunits.lua').TStructureUnit
local TIFCommanderDeathWeapon = import('/lua/terranweapons.lua').TIFCommanderDeathWeapon

GMEB311 = Class(TEnergyCreationUnit) {
    Weapons = {
        DeathWeapon = Class(TIFCommanderDeathWeapon) {},
    },

    OnStopBeingBuilt = function(self,builder,layer)
        TEnergyCreationUnit.OnStopBeingBuilt(self,builder,layer)
        ChangeState(self, self.ActiveState)
    end,

    ActiveState = State {
        Main = function(self)
            # Play the "activate" sound
            local myBlueprint = self:GetBlueprint()
            if myBlueprint.Audio.Activate then
                self:PlaySound(myBlueprint.Audio.Activate)
            end
        end,

        OnInActive = function(self)
            ChangeState(self, self.InActiveState)
        end,
    },

    InActiveState = State {
        Main = function(self)
        end,

        OnActive = function(self)
            ChangeState(self, self.ActiveState)
        end,
    },
}

TypeClass = GMEB311