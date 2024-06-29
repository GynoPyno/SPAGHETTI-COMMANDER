#
# Aeon Very Fast Anti-Missile Missile
#

local AIMBombExpe01 = import('/Mods/XtremWars/hook/lua/modprojectiles.lua').AIMBombExpe01

AIMAntiMissile01 = Class(AIMBombExpe01) {
    OnCreate = function(self)
        AIMBombExpe01.OnCreate(self)
        self:SetCollisionShape('Sphere', 0, 0, 0, 5.0)
    end,
}

TypeClass = AIMAntiMissile01

