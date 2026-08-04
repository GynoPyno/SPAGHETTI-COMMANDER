-- OWPlus PlatoonTemplates Economy Upgrade.lua
-- Sess.94: template PlatoonAI per l'upgrade NATIVO in-place (Plan='UnitUpgradeAI',
-- stesso meccanismo di 'OWPlus PlatoonTemplates Defenses.lua') di estrattori di
-- massa (T3->T4, mod Jaggeds Infrastructure Pack) e magazzini massa/energia
-- (T1->T2->T3, Jaggeds). A differenza delle difese TotalMayhem (un template per
-- unita', una fazione ciascuna), qui lo schema di naming Jaggeds e' coerente su
-- tutte e 4 le fazioni -- un solo template con FactionSquads per tutte e 4.
--
-- L'ID nel FactionSquads e' l'unita' SORGENTE da cercare/potenziare (il motore
-- IssueUpgrade legge la destinazione dal campo blueprint General.UpgradesTo,
-- gia' patchato dagli hook Jaggeds su queste unita' native/T2 -- vedi
-- hook/units/MassExtractors.bp, MassStorage.bp, EnergyStorage.bp).

PlatoonTemplate {
    Name = 'OWPlusExtractorUpgradeT4',
    Plan = 'UnitUpgradeAI',
    FactionSquads = {
        UEF = { { 'ueb1302', 0, 1, 'attack', 'None' } },
        Aeon = { { 'uab1302', 0, 1, 'attack', 'None' } },
        Cybran = { { 'urb1302', 0, 1, 'attack', 'None' } },
        Seraphim = { { 'xsb1302', 0, 1, 'attack', 'None' } },
    }
}

PlatoonTemplate {
    Name = 'OWPlusMassStorageUpgradeT2',
    Plan = 'UnitUpgradeAI',
    FactionSquads = {
        UEF = { { 'ueb1106', 0, 1, 'attack', 'None' } },
        Aeon = { { 'uab1106', 0, 1, 'attack', 'None' } },
        Cybran = { { 'urb1106', 0, 1, 'attack', 'None' } },
        Seraphim = { { 'xsb1106', 0, 1, 'attack', 'None' } },
    }
}

PlatoonTemplate {
    Name = 'OWPlusMassStorageUpgradeT3',
    Plan = 'UnitUpgradeAI',
    FactionSquads = {
        UEF = { { 'euebmst2', 0, 1, 'attack', 'None' } },
        Aeon = { { 'euabmst2', 0, 1, 'attack', 'None' } },
        Cybran = { { 'eurbmst2', 0, 1, 'attack', 'None' } },
        Seraphim = { { 'exsbmst2', 0, 1, 'attack', 'None' } },
    }
}

PlatoonTemplate {
    Name = 'OWPlusEnergyStorageUpgradeT2',
    Plan = 'UnitUpgradeAI',
    FactionSquads = {
        UEF = { { 'ueb1105', 0, 1, 'attack', 'None' } },
        Aeon = { { 'uab1105', 0, 1, 'attack', 'None' } },
        Cybran = { { 'urb1105', 0, 1, 'attack', 'None' } },
        Seraphim = { { 'xsb1105', 0, 1, 'attack', 'None' } },
    }
}

PlatoonTemplate {
    Name = 'OWPlusEnergyStorageUpgradeT3',
    Plan = 'UnitUpgradeAI',
    FactionSquads = {
        UEF = { { 'euebest2', 0, 1, 'attack', 'None' } },
        Aeon = { { 'euabest2', 0, 1, 'attack', 'None' } },
        Cybran = { { 'eurbest2', 0, 1, 'attack', 'None' } },
        Seraphim = { { 'exsbest2', 0, 1, 'attack', 'None' } },
    }
}
