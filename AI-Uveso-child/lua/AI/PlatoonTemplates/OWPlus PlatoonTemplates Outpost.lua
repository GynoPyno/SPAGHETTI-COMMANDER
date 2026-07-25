-- OWPlus PlatoonTemplates Outpost.lua
-- Fase D1 (B24): template di produzione per gli avamposti — un'unita' alla
-- volta (min=1,max=1, convenzione FactoryBuilder).
--
-- Fix (sess.90): la prima versione di questo file usava GlobalSquads (per
-- categoria) — sembrava corretto seguendo Conoscenze_AI_4 sez.6.6, ma quella
-- nota era sbagliata: GetFactoryTemplate (motore, FactoryBuilderManager.lua)
-- legge SOLO FactionSquads per un FactoryBuilder, mai GlobalSquads. Nota
-- corretta nelle Conoscenze nella stessa sessione. Qui sotto: ID letterali
-- per fazione, verificati uno per uno sui blueprint reali (non a memoria).
--
-- 3 categorie mono ("tipo" avamposto, B24 punto 1): bot, carri, artiglieria.
-- Un template per tier (T1/T2/T3) per categoria = 9 totali.
--
-- IMPORTANTE — il roster vanilla NON e' simmetrico tra fazioni: alcune
-- combinazioni tipo/tier non esistono per alcune fazioni (nessun bot T2 per
-- UEF/Aeon/Cybran, nessun carro T1 per Cybran, nessun carro T3 per
-- UEF/Aeon/Cybran, nessun bot T1 "puro" per Seraphim — l'unica unita' T1
-- DIRECTFIRE di Seraphim e' uno SCOUT, escluso). In questi casi la fazione
-- mancante NON compare in FactionSquads — il Builder corrispondente in
-- 'OWPlus Outpost Production.lua' ha una condizione FactionIndex dedicata
-- che esclude quella fazione, cosi' il template non viene mai interrogato
-- per una chiave assente.
--
-- Scelte tra piu' candidati (dove esisteva un'unita' "iconica" con tag
-- SHIELD, esclusa per coerenza con le squad di supporto separate — vedi
-- B24 punto 8): Bot T3 UEF usa xel0305 (gemella FA di uel0303, stesse
-- categorie ma senza SHIELD); Carro T2 Aeon usa xal0203 (gemella FA di
-- ual0202, stesso motivo).

PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T1',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'uel0106', 1, 1, 'Attack', 'none' } },
        Aeon = { { 'ual0106', 1, 1, 'Attack', 'none' } },
        Cybran = { { 'url0106', 1, 1, 'Attack', 'none' } },
        -- Seraphim: nessun bot T1 puro nel roster (l'unica unita' T1
        -- DIRECTFIRE, XSL0101, e' uno SCOUT) — vedi FactionIndex nel Builder.
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T2',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        -- Solo Seraphim ha un bot T2 dedicato (xsl0202) — UEF/Aeon/Cybran
        -- coprono quel ruolo solo con carri a questo tier, vedi FactionIndex.
        Seraphim = { { 'xsl0202', 1, 1, 'Attack', 'none' } },
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Bot T3',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'xel0305', 1, 1, 'Attack', 'none' } },
        Aeon = { { 'ual0303', 1, 1, 'Attack', 'none' } },
        Cybran = { { 'url0303', 1, 1, 'Attack', 'none' } },
        Seraphim = { { 'xsl0305', 1, 1, 'Attack', 'none' } },
    }
}

PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T1',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'uel0201', 1, 1, 'Attack', 'none' } },
        Aeon = { { 'ual0201', 1, 1, 'Attack', 'none' } },
        -- Cybran: nessun carro T1 nel roster (solo bot a questo tier),
        -- vedi FactionIndex nel Builder.
        Seraphim = { { 'xsl0201', 1, 1, 'Attack', 'none' } },
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T2',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'uel0202', 1, 1, 'Attack', 'none' } },
        Aeon = { { 'xal0203', 1, 1, 'Attack', 'none' } },
        Cybran = { { 'url0202', 1, 1, 'Attack', 'none' } },
        Seraphim = { { 'xsl0203', 1, 1, 'Attack', 'none' } },
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Tank T3',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        -- Solo Seraphim ha un vero carro T3 (xsl0303) — le altre 3 fazioni
        -- a questo tier hanno solo il bot pesante (gia' coperto da Bot T3),
        -- vedi FactionIndex nel Builder.
        Seraphim = { { 'xsl0303', 1, 1, 'Attack', 'none' } },
    }
}

PlatoonTemplate {
    Name = 'OWPlus Outpost Artillery T1',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'uel0103', 1, 1, 'Attack', 'none' } },
        Aeon = { { 'ual0103', 1, 1, 'Attack', 'none' } },
        Cybran = { { 'url0103', 1, 1, 'Attack', 'none' } },
        Seraphim = { { 'xsl0103', 1, 1, 'Attack', 'none' } },
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Artillery T2',
    Plan = 'HeroFightPlatoon',
    -- Nota: a T2 sono lanciamissili mobili (tag SILO), non cannoni
    -- balistici come T1/T3 — soddisfano comunque INDIRECTFIRE.
    FactionSquads = {
        UEF = { { 'uel0111', 1, 1, 'Attack', 'none' } },
        Aeon = { { 'ual0111', 1, 1, 'Attack', 'none' } },
        Cybran = { { 'url0111', 1, 1, 'Attack', 'none' } },
        Seraphim = { { 'xsl0111', 1, 1, 'Attack', 'none' } },
    }
}
PlatoonTemplate {
    Name = 'OWPlus Outpost Artillery T3',
    Plan = 'HeroFightPlatoon',
    FactionSquads = {
        UEF = { { 'uel0304', 1, 1, 'Attack', 'none' } },
        Aeon = { { 'ual0304', 1, 1, 'Attack', 'none' } },
        Cybran = { { 'url0304', 1, 1, 'Attack', 'none' } },
        Seraphim = { { 'xsl0304', 1, 1, 'Attack', 'none' } },
    }
}
