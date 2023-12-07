--
-- UEF Small Yield Nuclear Bomb
--
local TIFSmallYieldNuclearBombProjectile = import('/mods/Annihilation New SupCom/lua/EXBlackopsprojectiles.lua').UEFACUClusterMIssileProjectile02
local TMissileCruiseProjectile = import('/lua/terranprojectiles.lua').TMissileCruiseProjectile02
local CybranHailfire01Projectile = import('/mods/Annihilation New SupCom/lua/EXBlackOpsprojectiles.lua').CybranHailfire01ChildProjectile

CybranHailfire01child = Class(CybranHailfire01Projectile) {

   OnCreate = function(self)
        CybranHailfire01Projectile.OnCreate(self)
        for k, v in self.FxTrails do
            CreateEmitterOnEntity(self,self:GetArmy(),v)
        end
   end,
}

TypeClass = CybranHailfire01child