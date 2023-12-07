#
# Cybran Anti Air Missile
#
local HellFireMissileProjectile = import('/mods/Annihilation New SupCom/lua/BlackOpsprojectiles.lua').HellFireMissileProjectile
local EffectTemplate = import('/lua/EffectTemplates.lua')
local RandomFloat = import('/lua/utilities.lua').GetRandomFloat
local VizMarker = import('/lua/sim/VizMarker.lua').VizMarker
HellFireMissile01 = Class(HellFireMissileProjectile) {
}

TypeClass = HellFireMissile01
