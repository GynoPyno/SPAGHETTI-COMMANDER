-----------------------------------
-- Author(s):  Cmd Draven
-- Summary  :  Cybran T4 Engineer
-----------------------------------

local CConstructionUnit = import('/lua/cybranunits.lua').CConstructionUnit
local Buff = import('/lua/sim/Buff.lua')

DRLE101 = Class(CConstructionUnit) {
    CreateEnhancement = function(self, enh)
        CConstructionUnit.CreateEnhancement(self, enh)

        local bp = self:GetBlueprint().Enhancements[enh]
        if not bp then return end
        if enh =='MoreBuildEngi' then
            if not Buffs['MoreBuildEngiC'] then
                BuffBlueprint {
                    Name = 'MoreBuildEngiC',
                    DisplayName = 'Nanite Overclocking',
                    BuffType = 'ACUBUILDRATE',
                    Stacks = 'REPLACE',
                    Duration = -1,
                    Affects = {
                        BuildRate = {
                            Add =  bp.NewBuildRate - self:GetBlueprint().Economy.BuildRate,
                            Mult = 1,
                        },
                        MaxHealth = {
                            Add = bp.NewHealth,
                            Mult = 1.0,
                        },
                        Regen = {
                            Add = bp.NewRegenRate,
                            Mult = 1.0,
                        },
                    },
                }
            end
            Buff.ApplyBuff(self, 'MoreBuildEngiC')
        end
    end,
}

TypeClass = DRLE101
