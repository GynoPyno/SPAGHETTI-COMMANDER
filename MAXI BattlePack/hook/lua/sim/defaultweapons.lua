BattleNukeDeathWeapon = Class(BareBonesWeapon) {
    OnFire = function(self)
    end,

    Fire = function(self)
        local NukeDamage = import('/Mods/BattlePack/hook/lua/sim/NukeDamage.lua').NukeAOE
        local bp = self:GetBlueprint()
        local proj = self.unit:CreateProjectile(bp.ProjectileId, 0, 0, 0, nil, nil, nil):SetCollision(false)
        proj:ForkThread(proj.EffectThread)
        
        -- Play the explosion sound
        local projBp = proj:GetBlueprint()
        if projBp.Audio.NukeExplosion then
            self:PlaySound(projBp.Audio.NukeExplosion)
        end
        
        proj.InnerRing = NukeDamage()
        proj.InnerRing:OnCreate(bp.NukeInnerRingDamage, bp.NukeInnerRingRadius, bp.NukeInnerRingTicks, bp.NukeInnerRingTotalTime)
        proj.OuterRing = NukeDamage()
        proj.OuterRing:OnCreate(bp.NukeOuterRingDamage, bp.NukeOuterRingRadius, bp.NukeOuterRingTicks, bp.NukeOuterRingTotalTime)

        local launcher = self.unit
        local pos = proj:GetPosition()
        local army = launcher:GetArmy()
        local brain = launcher:GetAIBrain()
        local damageType = 'Deathnuke'
        proj.InnerRing:DoNukeDamage(launcher, pos, brain, army, damageType)
        proj.OuterRing:DoNukeDamage(launcher, pos, brain, army, damageType)
        
        -- Stop it calling DoDamage any time in the future.
        proj.DoDamage = function(self, instigator, DamageData, targetEntity) end
    end,
}

BattleSCUDeathWeapon = Class(BareBonesWeapon) {
    OnFire = function(self)
    end,

    Fire = function(self)
        local myBlueprint = self:GetBlueprint()
        local myProjectile = self.unit:CreateProjectile(myBlueprint.ProjectileId, 0, 0, 0, nil, nil, nil):SetCollision(false)
        myProjectile:PassDamageData(self:GetDamageTable())
    end,
}
