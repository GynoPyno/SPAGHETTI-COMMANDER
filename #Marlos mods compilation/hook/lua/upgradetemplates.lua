
-- Platoon template for Unit upgrades.
-- called from AIBuilders

PlatoonTemplate {
    Name = 'T1TankUpgrade',
    Plan = 'UnitUpgradeAI',
    GlobalSquads = {
        {categories.MODDEDUPGRADEUNIT * categories.TECH1, 3, 8, 'support', 'None'},
    }
}
PlatoonTemplate {
    Name = 'T2TankUpgrade',
    Plan = 'UnitUpgradeAI',
    GlobalSquads = {
        {categories.MODDEDUPGRADEUNIT2 * categories.TECH2, 3, 8, 'support', 'None'},
    }
}


-- StructureUpgradeTemplates for Unit upgrades.
-- called from platoon.lua -> UnitUpgradeAI()

-- earth Unit upgrades
table.insert(UnitUpgradeTemplates[1], {'KEL0101', 'KEL0205'}) -- T1 Tank. Upgrade from TECH1 to TECH2
