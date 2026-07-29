-- OWPlus PlatoonTemplates Outpost.lua
-- Fase D1 (B24), espansione 2026-07-29: un PlatoonTemplate per candidato (vanilla +
-- modded) invece di un unico template multi-fazione per cella. Necessario perche'
-- FactionSquads con piu' righe per la stessa fazione le costruirebbe TUTTE insieme
-- nello stesso ordine (non 'scegline una') -- un template per fazione singola e' il
-- solo modo per far competere piu' candidati via Builder/PriorityFunction separati.
-- Generato da script (generate_production.py) a partire dal catalogo unita' di terra
-- (ricerca su 9 mod, Categories verificate nei blueprint reali). Nome unita' -> vedi
-- commento a fianco per la mod di provenienza.

-- Bot T1
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T1 UEF uel0106',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'uel0106', 1, 1, 'Attack', 'none' } }, -- Vanilla
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T1 UEF kel0101',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'kel0101', 1, 1, 'Attack', 'none' } }, -- #Marlos
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T1 UEF brnt1advbot',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'brnt1advbot', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T1 UEF brnt1bt',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'brnt1bt', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T1 UEF brnt1btt2',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'brnt1btt2', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T1 UEF brnt1extk',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'brnt1extk', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T1 UEF uel0108',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'uel0108', 1, 1, 'Attack', 'none' } }, -- Antares
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T1 UEF bel0109',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'bel0109', 1, 1, 'Attack', 'none' } }, -- BlackOps-Unleashed
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T1 UEF brnt1exm1',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'brnt1exm1', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T1 UEF brnt1exmob',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'brnt1exmob', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T1 Aeon ual0106',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Aeon = { { 'ual0106', 1, 1, 'Attack', 'none' } }, -- Vanilla
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T1 Aeon bal0110',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Aeon = { { 'bal0110', 1, 1, 'Attack', 'none' } }, -- BlackOps-Unleashed
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T1 Aeon brot1bt',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Aeon = { { 'brot1bt', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T1 Aeon brot1btt2',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Aeon = { { 'brot1btt2', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T1 Aeon brot1btt2a',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Aeon = { { 'brot1btt2a', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T1 Aeon brot1btt3',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Aeon = { { 'brot1btt3', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T1 Aeon brot1exm1',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Aeon = { { 'brot1exm1', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T1 Cybran url0106',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'url0106', 1, 1, 'Attack', 'none' } }, -- Vanilla
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T1 Cybran brl0110',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'brl0110', 1, 1, 'Attack', 'none' } }, -- BlackOps-Unleashed
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T1 Cybran brmt1advbot',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'brmt1advbot', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T1 Cybran brmt1at',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'brmt1at', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T1 Cybran brmt1beetle',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'brmt1beetle', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T1 Cybran brmt1exm1',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'brmt1exm1', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T1 Cybran orl0111',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'orl0111', 1, 1, 'Attack', 'none' } }, -- Antares
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T1 Seraphim bsl0106',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Seraphim = { { 'bsl0106', 1, 1, 'Attack', 'none' } }, -- BlackOps-Unleashed
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T1 Seraphim brpt1asta',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Seraphim = { { 'brpt1asta', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T1 Seraphim brpt1bt',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Seraphim = { { 'brpt1bt', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T1 Seraphim brpt1btbot',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Seraphim = { { 'brpt1btbot', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T1 Seraphim brpt1exm1',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Seraphim = { { 'brpt1exm1', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T1 Seraphim brpt1expbot',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Seraphim = { { 'brpt1expbot', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T1 Seraphim brpt1htt3',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Seraphim = { { 'brpt1htt3', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}

-- Bot T2
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T2 UEF kel0201',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'kel0201', 1, 1, 'Attack', 'none' } }, -- #Marlos
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T2 UEF kel0202',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'kel0202', 1, 1, 'Attack', 'none' } }, -- #Marlos
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T2 UEF kel0204',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'kel0204', 1, 1, 'Attack', 'none' } }, -- #Marlos
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T2 UEF kel0205',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'kel0205', 1, 1, 'Attack', 'none' } }, -- #Marlos
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T2 UEF wel0207',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'wel0207', 1, 1, 'Attack', 'none' } }, -- BattlePack
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T2 UEF bel0211',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'bel0211', 1, 1, 'Attack', 'none' } }, -- BlackOps-Unleashed
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T2 UEF brnt2bm',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'brnt2bm', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T2 UEF brnt2exlm',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'brnt2exlm', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T2 UEF brnt2exm1',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'brnt2exm1', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T2 UEF brnt2exmdf',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'brnt2exmdf', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T2 UEF brnt2sniper',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'brnt2sniper', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T2 Aeon brot2exbm',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Aeon = { { 'brot2exbm', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T2 Aeon brot2exm2',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Aeon = { { 'brot2exm2', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T2 Aeon brot2asb',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Aeon = { { 'brot2asb', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T2 Aeon brot2exth',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Aeon = { { 'brot2exth', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T2 Cybran brmt2bm',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'brmt2bm', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T2 Seraphim xsl0202',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Seraphim = { { 'xsl0202', 1, 1, 'Attack', 'none' } }, -- Vanilla
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T2 Seraphim ksl0201',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Seraphim = { { 'ksl0201', 1, 1, 'Attack', 'none' } }, -- #Marlos
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T2 Seraphim xsl0207',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Seraphim = { { 'xsl0207', 1, 1, 'Attack', 'none' } }, -- Antares
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T2 Seraphim wsl0205',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Seraphim = { { 'wsl0205', 1, 1, 'Attack', 'none' } }, -- BattlePack
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T2 Seraphim brpt2btbot',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Seraphim = { { 'brpt2btbot', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T2 Seraphim brpt2exbot',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Seraphim = { { 'brpt2exbot', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T2 Seraphim brpt2hvbot',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Seraphim = { { 'brpt2hvbot', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}

-- Bot T3
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T3 UEF xel0305',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'xel0305', 1, 1, 'Attack', 'none' } }, -- Vanilla
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T3 UEF kel0301',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'kel0301', 1, 1, 'Attack', 'none' } }, -- #Marlos
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T3 UEF kel0302',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'kel0302', 1, 1, 'Attack', 'none' } }, -- #Marlos
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T3 UEF kel0303',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'kel0303', 1, 1, 'Attack', 'none' } }, -- #Marlos
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T3 UEF kel0306',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'kel0306', 1, 1, 'Attack', 'none' } }, -- #Marlos
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T3 UEF kel0307',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'kel0307', 1, 1, 'Attack', 'none' } }, -- #Marlos
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T3 UEF brnt3advbtbot',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'brnt3advbtbot', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T3 UEF wel0302',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'wel0302', 1, 1, 'Attack', 'none' } }, -- BattlePack
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T3 UEF wel0309',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'wel0309', 1, 1, 'Attack', 'none' } }, -- BattlePack
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T3 UEF bel0307',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'bel0307', 1, 1, 'Attack', 'none' } }, -- BlackOps-Unleashed
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T3 UEF bel0308',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'bel0308', 1, 1, 'Attack', 'none' } }, -- BlackOps-Unleashed
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T3 UEF brnt3abb',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'brnt3abb', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T3 UEF brnt3ow',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'brnt3ow', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T3 Aeon ual0303',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Aeon = { { 'ual0303', 1, 1, 'Attack', 'none' } }, -- Vanilla
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T3 Aeon kal0301',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Aeon = { { 'kal0301', 1, 1, 'Attack', 'none' } }, -- #Marlos
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T3 Aeon wal0305',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Aeon = { { 'wal0305', 1, 1, 'Attack', 'none' } }, -- BattlePack
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T3 Aeon eal0301',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Aeon = { { 'eal0301', 1, 1, 'Attack', 'none' } }, -- BlackOps-EXUnits
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T3 Aeon bal0310',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Aeon = { { 'bal0310', 1, 1, 'Attack', 'none' } }, -- BlackOps-Unleashed
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T3 Aeon brot3aa',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Aeon = { { 'brot3aa', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T3 Aeon brot3hm',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Aeon = { { 'brot3hm', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T3 Aeon brot3exm1',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Aeon = { { 'brot3exm1', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T3 Cybran url0303',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'url0303', 1, 1, 'Attack', 'none' } }, -- Vanilla
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T3 Cybran krl0301',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'krl0301', 1, 1, 'Attack', 'none' } }, -- #Marlos
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T3 Cybran krl0302',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'krl0302', 1, 1, 'Attack', 'none' } }, -- #Marlos
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T3 Cybran url0302',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'url0302', 1, 1, 'Attack', 'none' } }, -- Antares
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T3 Cybran wrl0301',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'wrl0301', 1, 1, 'Attack', 'none' } }, -- BattlePack
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T3 Cybran wrl0305',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'wrl0305', 1, 1, 'Attack', 'none' } }, -- BattlePack
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T3 Cybran brmt3advbtbot',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'brmt3advbtbot', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T3 Cybran brmt3bt',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'brmt3bt', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T3 Cybran brmt3garg',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'brmt3garg', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T3 Seraphim xsl0305',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Seraphim = { { 'xsl0305', 1, 1, 'Attack', 'none' } }, -- Vanilla
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T3 Seraphim ksl0301',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Seraphim = { { 'ksl0301', 1, 1, 'Attack', 'none' } }, -- #Marlos
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T3 Seraphim wsl0405',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Seraphim = { { 'wsl0405', 1, 1, 'Attack', 'none' } }, -- Antares
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T3 Seraphim wsl0302',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Seraphim = { { 'wsl0302', 1, 1, 'Attack', 'none' } }, -- BattlePack
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T3 Seraphim wsl0308',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Seraphim = { { 'wsl0308', 1, 1, 'Attack', 'none' } }, -- BattlePack
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T3 Seraphim bsl0310',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Seraphim = { { 'bsl0310', 1, 1, 'Attack', 'none' } }, -- BlackOps-Unleashed
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T3 Seraphim brpt3bt',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Seraphim = { { 'brpt3bt', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}

-- Tank T1
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T1 UEF uel0201',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'uel0201', 1, 1, 'Attack', 'none' } }, -- Vanilla
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T1 UEF brnt1ht',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'brnt1ht', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T1 UEF brnt1htt2',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'brnt1htt2', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T1 UEF brnt1htt3',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'brnt1htt3', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T1 UEF brnt1mt',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'brnt1mt', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T1 UEF brnt1mtt2',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'brnt1mtt2', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T1 UEF brnt1mtt3',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'brnt1mtt3', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T1 Aeon ual0201',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Aeon = { { 'ual0201', 1, 1, 'Attack', 'none' } }, -- Vanilla
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T1 Aeon brot1exm2',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Aeon = { { 'brot1exm2', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T1 Aeon brot1extank',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Aeon = { { 'brot1extank', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T1 Aeon brot1lt',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Aeon = { { 'brot1lt', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T1 Aeon brot1mt',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Aeon = { { 'brot1mt', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T1 Aeon brot1mtt2',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Aeon = { { 'brot1mtt2', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T1 Aeon brot1mtt3',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Aeon = { { 'brot1mtt3', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T1 Cybran brmt1bt',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'brmt1bt', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T1 Cybran brmt1btt2',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'brmt1btt2', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T1 Cybran brmt1btt3',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'brmt1btt3', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T1 Cybran brmt1extank',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'brmt1extank', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T1 Cybran brmt1bm',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'brmt1bm', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T1 Cybran brmt1bm2',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'brmt1bm2', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T1 Cybran brmt1ht',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'brmt1ht', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T1 Cybran brmt1mt',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'brmt1mt', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T1 Seraphim xsl0201',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Seraphim = { { 'xsl0201', 1, 1, 'Attack', 'none' } }, -- Vanilla
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T1 Seraphim brpt1extank2',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Seraphim = { { 'brpt1extank2', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T1 Seraphim brpt1ht',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Seraphim = { { 'brpt1ht', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}

-- Tank T2
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T2 UEF uel0202',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'uel0202', 1, 1, 'Attack', 'none' } }, -- Vanilla
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T2 UEF brnt2bt',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'brnt2bt', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T2 UEF brnt2ht',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'brnt2ht', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T2 UEF brnt2htt3',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'brnt2htt3', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T2 Aeon xal0203',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Aeon = { { 'xal0203', 1, 1, 'Attack', 'none' } }, -- Vanilla
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T2 Aeon lta3002',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Aeon = { { 'lta3002', 1, 1, 'Attack', 'none' } }, -- Antares
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T2 Aeon bal0206',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Aeon = { { 'bal0206', 1, 1, 'Attack', 'none' } }, -- BlackOps-Unleashed
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T2 Aeon brot2ht',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Aeon = { { 'brot2ht', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T2 Aeon brot2mt',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Aeon = { { 'brot2mt', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T2 Cybran url0202',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'url0202', 1, 1, 'Attack', 'none' } }, -- Vanilla
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T2 Cybran wrl0302',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'wrl0302', 1, 1, 'Attack', 'none' } }, -- BattlePack
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T2 Cybran brl0205',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'brl0205', 1, 1, 'Attack', 'none' } }, -- BlackOps-Unleashed
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T2 Cybran brmt2st',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'brmt2st', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T2 Cybran brmt2wildcat',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'brmt2wildcat', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T2 Cybran brmt2abt',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'brmt2abt', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T2 Cybran brmt2abtt3',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'brmt2abtt3', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T2 Cybran brmt2ht',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'brmt2ht', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T2 Cybran brmt2htt3',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'brmt2htt3', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T2 Cybran brmt2medm',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'brmt2medm', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T2 Seraphim xsl0203',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Seraphim = { { 'xsl0203', 1, 1, 'Attack', 'none' } }, -- Vanilla
    }
}

-- Tank T3
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T3 UEF wel0304',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'wel0304', 1, 1, 'Attack', 'none' } }, -- BattlePack
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T3 UEF brnt3bt',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'brnt3bt', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T3 UEF brnt3ht',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'brnt3ht', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T3 Cybran erl0301',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'erl0301', 1, 1, 'Attack', 'none' } }, -- BlackOps-EXUnits
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T3 Cybran brmt3bm2mk2',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'brmt3bm2mk2', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T3 Cybran brmt3ht',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'brmt3ht', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T3 Cybran brmt3lzt',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'brmt3lzt', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T3 Cybran brmt3rap',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'brmt3rap', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T3 Seraphim xsl0303',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Seraphim = { { 'xsl0303', 1, 1, 'Attack', 'none' } }, -- Vanilla
    }
}

-- Artillery T1
PlatoonTemplate {
    Name = 'OWPlus Outpost Artillery T1 UEF uel0103',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'uel0103', 1, 1, 'Attack', 'none' } }, -- Vanilla
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Artillery T1 Aeon ual0103',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Aeon = { { 'ual0103', 1, 1, 'Attack', 'none' } }, -- Vanilla
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Artillery T1 Aeon brot1exmobart',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Aeon = { { 'brot1exmobart', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Artillery T1 Cybran url0103',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'url0103', 1, 1, 'Attack', 'none' } }, -- Vanilla
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Artillery T1 Seraphim xsl0103',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Seraphim = { { 'xsl0103', 1, 1, 'Attack', 'none' } }, -- Vanilla
    }
}

-- Artillery T2
PlatoonTemplate {
    Name = 'OWPlus Outpost Artillery T2 UEF uel0111',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'uel0111', 1, 1, 'Attack', 'none' } }, -- Vanilla
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Artillery T2 UEF brnt2exm2',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'brnt2exm2', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Artillery T2 UEF brnt2potshot',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'brnt2potshot', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Artillery T2 Aeon ual0111',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Aeon = { { 'ual0111', 1, 1, 'Attack', 'none' } }, -- Vanilla
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Artillery T2 Cybran url0111',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'url0111', 1, 1, 'Attack', 'none' } }, -- Vanilla
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Artillery T2 Cybran umr_l0201',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'umr_l0201', 1, 1, 'Attack', 'none' } }, -- Antares
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Artillery T2 Cybran brmt2beetle',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'brmt2beetle', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Artillery T2 Seraphim xsl0111',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Seraphim = { { 'xsl0111', 1, 1, 'Attack', 'none' } }, -- Vanilla
    }
}

-- Artillery T3
PlatoonTemplate {
    Name = 'OWPlus Outpost Artillery T3 UEF uel0304',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'uel0304', 1, 1, 'Attack', 'none' } }, -- Vanilla
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Artillery T3 UEF kel0304',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'kel0304', 1, 1, 'Attack', 'none' } }, -- #Marlos
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Artillery T3 UEF kel0308',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'kel0308', 1, 1, 'Attack', 'none' } }, -- #Marlos
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Artillery T3 UEF wel03041',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'wel03041', 1, 1, 'Attack', 'none' } }, -- BattlePack
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Artillery T3 UEF brnt3ml',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'brnt3ml', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Artillery T3 Aeon ual0304',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Aeon = { { 'ual0304', 1, 1, 'Attack', 'none' } }, -- Vanilla
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Artillery T3 Aeon kal0304',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Aeon = { { 'kal0304', 1, 1, 'Attack', 'none' } }, -- #Marlos
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Artillery T3 Cybran url0304',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'url0304', 1, 1, 'Attack', 'none' } }, -- Vanilla
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Artillery T3 Cybran krl0304',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'krl0304', 1, 1, 'Attack', 'none' } }, -- #Marlos
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Artillery T3 Cybran wrl1211',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'wrl1211', 1, 1, 'Attack', 'none' } }, -- BattlePack
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Artillery T3 Cybran brl0307',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'brl0307', 1, 1, 'Attack', 'none' } }, -- BlackOps-Unleashed
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Artillery T3 Cybran brmt3ml',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Cybran = { { 'brmt3ml', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Artillery T3 Seraphim xsl0304',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Seraphim = { { 'xsl0304', 1, 1, 'Attack', 'none' } }, -- Vanilla
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Artillery T3 Seraphim brpt3ml',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        Seraphim = { { 'brpt3ml', 1, 1, 'Attack', 'none' } }, -- TotalMayhem
    }
}

