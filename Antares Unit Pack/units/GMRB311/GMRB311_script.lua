local CEnergyCreationUnit = import('/lua/cybranunits.lua').CEnergyCreationUnit
local CWeapons = import('/lua/cybranweapons.lua')
local WeaponFile = import('/lua/sim/defaultweapons.lua')
local CStructureUnit = import('/lua/cybranunits.lua').CStructureUnit
local CIFCommanderDeathWeapon = CWeapons.CIFCommanderDeathWeapon

GMRB311 = Class(CEnergyCreationUnit) {
    Weapons = {
        DeathWeapon = Class(CIFCommanderDeathWeapon) {},
    },
    
    AmbientEffects = 'CT3PowerAmbient',
    
    OnStopBeingBuilt = function(self, builder, layer)
        CEnergyCreationUnit.OnStopBeingBuilt(self, builder, layer)
        for i = 1, 36 do
            local fxname
            if i < 10 then
                fxname = 'BlinkyLight0' .. i
            else
                fxname = 'BlinkyLight' .. i
            end
            local fx = CreateAttachedEmitter(self, fxname, self:GetArmy(), '/effects/emitters/light_yellow_02_emit.bp'):OffsetEmitter(0, 0, 0.01):ScaleEmitter(1)
            self.Trash:Add(fx)
        end
    end
}

TypeClass = GMRB311