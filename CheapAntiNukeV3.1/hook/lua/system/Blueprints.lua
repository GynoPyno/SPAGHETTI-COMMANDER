#
# Script below works as follows:
#
# All units are scanned to find units categorized as "ANTIMISSILE". The weapons of these units are inspected to find
# whether the weapon is meant to intercept strategic missiles. If yes the projectile blueprint is remembered.
# The next step is to go through all projectiles and find the ones that were remembered in the previous steps. These
# projectiles have their cost changed according to the multipliers set below.
#

local oldModBlueprints = ModBlueprints

function ModBlueprints(all_bps)

    oldModBlueprints(all_bps)

    local EnergyCostMulti = 0.1
    local MassCostMulti = 0.1
    local BuildTimeMulti = 0.1


    local projectileBpFiles = {}
    local ANTIMISSILE

    for _, bp in all_bps.Unit do
        if not bp.Categories then
            continue
        end
        for k, cat in bp.Categories do
            if cat == 'ANTIMISSILE' then
                ANTIMISSILE = true
            end
        end
        if ANTIMISSILE and bp.Weapon then
            for i, wepBp in bp.Weapon do
                if wepBp.TargetRestrictOnlyAllow and wepBp.TargetType == 'RULEWTT_Projectile' and wepBp.TargetRestrictOnlyAllow == 'STRATEGIC MISSILE' then
                    table.insert(projectileBpFiles, string.lower(wepBp.ProjectileId))
                end
            end
        end
    end

    for _, bp in all_bps.Projectile do
        if table.find(projectileBpFiles, bp.Source) then
            if bp.Economy then
                if bp.Economy.BuildCostEnergy then
                    bp.Economy.BuildCostEnergy = bp.Economy.BuildCostEnergy * EnergyCostMulti
                end
                if bp.Economy.BuildCostMass then
                    bp.Economy.BuildCostMass = bp.Economy.BuildCostMass * MassCostMulti
                end
                if bp.Economy.BuildTime then
                    bp.Economy.BuildTime = bp.Economy.BuildTime * BuildTimeMulti
                end
            end
        end
    end

end
