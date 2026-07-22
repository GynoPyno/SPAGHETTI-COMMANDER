-- OWPlus PlatoonTemplates Defenses.lua
-- Fase C (B16), sess.83: template PlatoonAI per l'upgrade NATIVO in-place
-- (Plan='UnitUpgradeAI', stesso meccanismo delle fabbriche T1LandFactoryUpgrade
-- ecc. in /lua/AI/PlatoonTemplates/StructurePlatoonTemplates.lua vanilla, e degli
-- scudi T2Shield/T2Shield1-4 in AIDefenseBuilders.lua) delle 4 famiglie di difese
-- modded TotalMayhem con una versione MK2 nota (General.UpgradesTo nel .bp —
-- vedi OWPlusOutpostDefensePool.OWPlusModdedUpgradeChain). Un template per unita'
-- (non un unico template con piu' squad per fazione), stesso pattern gia' usato
-- da Uveso per i 4 scudi Cybran (T2Shield1-4, una unita' diversa ciascuno).
--
-- FactionSquads con l'ID BLUEPRINT letterale (minuscolo) invece di una categoria:
-- serve trovare ESATTAMENTE quell'unita' (non una qualunque difesa T1), l'unica
-- via affidabile per un ID modded che DecideWhatToBuild non risolverebbe (stesso
-- principio di Conoscenze_AI_40 §40.1 per il build diretto, qui applicato alla
-- ricerca del BERSAGLIO da potenziare invece che alla costruzione).

PlatoonTemplate {
    Name = 'OWPlusMayorUpgrade',
    Plan = 'UnitUpgradeAI',
    FactionSquads = {
        UEF = {
            { 'brnt1expd', 0, 1, 'attack', 'None' }
        },
    }
}

PlatoonTemplate {
    Name = 'OWPlusThugUpgrade',
    Plan = 'UnitUpgradeAI',
    FactionSquads = {
        UEF = {
            { 'brnt1hpd', 0, 1, 'attack', 'None' }
        },
    }
}

PlatoonTemplate {
    Name = 'OWPlusCoyoteUpgrade',
    Plan = 'UnitUpgradeAI',
    FactionSquads = {
        Cybran = {
            { 'brmt1pd', 0, 1, 'attack', 'None' }
        },
    }
}

PlatoonTemplate {
    Name = 'OWPlusPenUpgrade',
    Plan = 'UnitUpgradeAI',
    FactionSquads = {
        Cybran = {
            { 'brmt1expd', 0, 1, 'attack', 'None' }
        },
    }
}

-- Fix Fase F (sess.88, bug reale segnalato dall'utente in test live: "Tower
-- Boss MK2 non si potenzia"): Tower Boss (BRNT2EPD, T2->T3) non era in
-- NESSUN meccanismo di upgrade nativo — non qui (le 4 famiglie sopra sono
-- tutte T1->T2), e nemmeno nel builder nativo di Uveso 'ShieldUpgrades'
-- (quello copre solo scudi vanilla, non unita' modded TotalMayhem). Stesso
-- identico pattern delle 4 sopra.
PlatoonTemplate {
    Name = 'OWPlusTowerBossUpgrade',
    Plan = 'UnitUpgradeAI',
    FactionSquads = {
        UEF = {
            { 'brnt2epd', 0, 1, 'attack', 'None' }
        },
    }
}
