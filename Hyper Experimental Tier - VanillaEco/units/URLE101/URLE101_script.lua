#****************************************************************************
#**
#**  Author(s):  Cmd Draven
#**
#**  Summary  :  Terran T4 Engineer
#**
#****************************************************************************

local TConstructionUnit = import('/lua/terranunits.lua').TConstructionUnit

URLE101 = Class(TConstructionUnit) {
    CreateEnhancement = function(self, enh)
        TConstructionUnit.CreateEnhancement(self, enh)

        local bp = self:GetBlueprint().Enhancements[enh]
        if not bp then return end
        if enh =='MoreBuildEngi' then
            if not Buffs['MoreBuildEngiT'] then
                BuffBlueprint {
                    Name = 'MoreBuildEngiC',
                    DisplayName = 'Advanced Fabricator',
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
            Buff.ApplyBuff(self, 'MoreBuildEngiT')
        end
    end,
}

TypeClass = URLE101
