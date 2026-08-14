-- OWPlus PlatoonTemplates Economy Upgrade.lua
-- Sess.94: template PlatoonAI per l'upgrade NATIVO in-place (Plan='UnitUpgradeAI',
-- stesso meccanismo di 'OWPlus PlatoonTemplates Defenses.lua') di magazzini
-- massa/energia (T1->T2->T3->T4, mod Jaggeds Infrastructure Pack). A differenza
-- delle difese TotalMayhem (un template per unita', una fazione ciascuna), qui
-- lo schema di naming Jaggeds e' coerente su tutte e 4 le fazioni -- un solo
-- template con FactionSquads per tutte e 4.
--
-- L'ID nel FactionSquads e' l'unita' SORGENTE da cercare/potenziare (il motore
-- IssueUpgrade legge la destinazione dal campo blueprint General.UpgradesTo,
-- gia' patchato dagli hook Jaggeds su queste unita' native/T2 -- vedi
-- hook/units/MassExtractors.bp, MassStorage.bp, EnergyStorage.bp).
--
-- Sess.98: RIMOSSO 'OWPlusExtractorUpgradeT4' (estrattori massa T3->T4) --
-- CanFormPlatoon tornava sempre false per questo template (causa nativa/
-- compilata, non identificabile a livello Lua). L'upgrade estrattori T3->T4
-- ora passa da un meccanismo diverso, vedi 'OWPlus Economy Upgrade.lua'.

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

-- Sess.97: nuovo -- sorgente T3, il motore legge la destinazione (magazzino
-- ibrido T4 bab1106 & co.) dal campo blueprint General.UpgradesTo/UpgradesFrom
-- gia' presente su queste unita' (mod Jaggeds), stesso meccanismo di tutti gli
-- altri template in questo file.
PlatoonTemplate {
    Name = 'OWPlusMassStorageUpgradeT4',
    Plan = 'UnitUpgradeAI',
    FactionSquads = {
        UEF = { { 'euebmst3', 0, 1, 'attack', 'None' } },
        Aeon = { { 'euabmst3', 0, 1, 'attack', 'None' } },
        Cybran = { { 'eurbmst3', 0, 1, 'attack', 'None' } },
        Seraphim = { { 'exsbmst3', 0, 1, 'attack', 'None' } },
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

-- Sess.98 (bis): RIMOSSO 'OWPlusEnergyGeneratorUpgradeT4' (Plan='UnitUpgradeAI')
-- -- log confermato: gate economico vero e stabile per 20+ minuti consecutivi
-- (stored=1.9M/40000, inUpgrade=0, cap=2, 12 candidati T3 liberi) eppure zero
-- nuovi upgrade tentati -- stesso identico sintomo CanFormPlatoon=sempre-falso
-- gia' isolato per gli estrattori (vedi RIMOSSO sopra). Sostituito dal
-- meccanismo Plan='PlatoonMerger'+AIPlan (nativo Uveso, 'Base Mass.lua' +
-- 'AddToMassExtractorUpgradePlatoon') che gli estrattori usano gia' con
-- successo per T1->T2->T3: MAI passa da CanFormPlatoon (assegnazione
-- permanente al plotone merger via GlobalSquads, non formazione per-candidato)
-- e non usa BuilderHandle/InstanceCount (elimina anche il rischio leak visto
-- in sess.98). Vedi hook/lua/platoon.lua per il nuovo metodo
-- 'OWPlusEnergyGeneratorUpgradeAI' e 'OWPlus Economy Upgrade.lua' per il
-- builder aggiornato.
PlatoonTemplate {
    Name = 'AddToEnergyGeneratorUpgradePlatoon',
    Plan = 'PlatoonMerger',
    GlobalSquads = {
        { categories.STRUCTURE * categories.ENERGYPRODUCTION * categories.TECH3, 1, 300, 'support', 'none' }
    },
}
