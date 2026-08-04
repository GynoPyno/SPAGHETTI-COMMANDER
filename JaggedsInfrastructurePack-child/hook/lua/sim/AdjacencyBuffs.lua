-- Il magazzino ibrido T4 (bab1106/beb1106/brb1106/bsb1106) referenzia
-- 'Adjacency = T3MassEnergyStorageAdjacencyBuffs' nel proprio blueprint
-- (invariato, nessuna modifica al .bp) -- ma quella variabile globale, nella
-- mod originale, riusa alla lettera i buff nominali del T3 (nessuna crescita
-- reale al salto T3->T4, a differenza di T1->T2->T3 dove il bonus sale ogni
-- tier). Qui definiamo un vero set T4 e RIASSEGNIAMO quella stessa variabile
-- globale (questo file /lua/sim/AdjacencyBuffs.lua carica dopo l'originale
-- della mod-genitore grazie a 'after' in mod_info.lua, quindi l'assegnazione
-- qui sotto vince).
--
-- Valori: stesso rapporto di crescita T3/T2 gia' presente nella mod
-- originale (costante per ogni taglia) riapplicato per ottenere T4=T3*rapporto:
-- - Massa: rapporto esatto 10/7 (sia su Add sia su Mult-1, per coerenza)
-- - Energia: il rapporto storico (24/7) applicato una seconda volta
--   comporterebbe fino a +257% assoluto (richiesta utente: troppo) --
--   sostituito con un incremento LINEARE (T4 = T3 + stesso incremento
--   assoluto gia' visto da T2 a T3), che cresce in modo piu' contenuto.
--   Mult per l'energia resta 1.0 (il T3 originale l'aveva gia' azzerato per
--   tutte le taglie, il bonus energia e' interamente nella componente Add).
local AdjBuffFuncs = import('/lua/sim/AdjacencyBuffFunctions.lua')

-- T4 Mass Storage Mass Production Bonus

BuffBlueprint {
    Name = 'T4MassStorageMassProductionBonusSize4',
    DisplayName = 'T4MassStorageMassProductionBonus',
    BuffType = 'MASSBUILDBONUS',
    Stacks = 'ALWAYS',
    Duration = -1,
    EntityCategory = 'STRUCTURE SIZE4',
    BuffCheckFunction = AdjBuffFuncs.MassProductionBuffCheck,
    OnBuffAffect = AdjBuffFuncs.MassProductionBuffAffect,
    OnBuffRemove = AdjBuffFuncs.MassProductionBuffRemove,
    Affects = {
        MassProduction = {
            Add = 0.446429,
            Mult = 1.243,
        },
    },
}

BuffBlueprint {
    Name = 'T4MassStorageMassProductionBonusSize8',
    DisplayName = 'T4MassStorageMassProductionBonus',
    BuffType = 'MASSBUILDBONUS',
    Stacks = 'ALWAYS',
    Duration = -1,
    EntityCategory = 'STRUCTURE SIZE8',
    BuffCheckFunction = AdjBuffFuncs.MassProductionBuffCheck,
    OnBuffAffect = AdjBuffFuncs.MassProductionBuffAffect,
    OnBuffRemove = AdjBuffFuncs.MassProductionBuffRemove,
    Affects = {
        MassProduction = {
            Add = 0.223214,
            Mult = 1.143,
        },
    },
}

BuffBlueprint {
    Name = 'T4MassStorageMassProductionBonusSize12',
    DisplayName = 'T4MassStorageMassProductionBonus',
    BuffType = 'MASSBUILDBONUS',
    Stacks = 'ALWAYS',
    Duration = -1,
    EntityCategory = 'STRUCTURE SIZE12',
    BuffCheckFunction = AdjBuffFuncs.MassProductionBuffCheck,
    OnBuffAffect = AdjBuffFuncs.MassProductionBuffAffect,
    OnBuffRemove = AdjBuffFuncs.MassProductionBuffRemove,
    Affects = {
        MassProduction = {
            Add = 0.148810,
            Mult = 1.129,
        },
    },
}

BuffBlueprint {
    Name = 'T4MassStorageMassProductionBonusSize16',
    DisplayName = 'T4MassStorageMassProductionBonus',
    BuffType = 'MASSBUILDBONUS',
    Stacks = 'ALWAYS',
    Duration = -1,
    EntityCategory = 'STRUCTURE SIZE16',
    BuffCheckFunction = AdjBuffFuncs.MassProductionBuffCheck,
    OnBuffAffect = AdjBuffFuncs.MassProductionBuffAffect,
    OnBuffRemove = AdjBuffFuncs.MassProductionBuffRemove,
    Affects = {
        MassProduction = {
            Add = 0.111614,
            Mult = 1.100,
        },
    },
}

BuffBlueprint {
    Name = 'T4MassStorageMassProductionBonusSize20',
    DisplayName = 'T4MassStorageMassProductionBonus',
    BuffType = 'MASSBUILDBONUS',
    Stacks = 'ALWAYS',
    Duration = -1,
    EntityCategory = 'STRUCTURE SIZE20',
    BuffCheckFunction = AdjBuffFuncs.MassProductionBuffCheck,
    OnBuffAffect = AdjBuffFuncs.MassProductionBuffAffect,
    OnBuffRemove = AdjBuffFuncs.MassProductionBuffRemove,
    Affects = {
        MassProduction = {
            Add = 0.089286,
            Mult = 1.071,
        },
    },
}

-- T4 Energy Storage Energy Production Bonus

BuffBlueprint {
    Name = 'T4EnergyStorageEnergyProductionBonusSize4',
    DisplayName = 'T4EnergyStorageEnergyProductionBonus',
    BuffType = 'MASSBUILDBONUS',
    Stacks = 'ALWAYS',
    Duration = -1,
    EntityCategory = 'STRUCTURE SIZE4',
    BuffCheckFunction = AdjBuffFuncs.EnergyProductionBuffCheck,
    OnBuffAffect = AdjBuffFuncs.EnergyProductionBuffAffect,
    OnBuffRemove = AdjBuffFuncs.EnergyProductionBuffRemove,
    Affects = {
        EnergyProduction = {
            Add = 1.28125,
            Mult = 1.0,
        },
    },
}

BuffBlueprint {
    Name = 'T4EnergyStorageEnergyProductionBonusSize8',
    DisplayName = 'T4EnergyStorageEnergyProductionBonus',
    BuffType = 'MASSBUILDBONUS',
    Stacks = 'ALWAYS',
    Duration = -1,
    EntityCategory = 'STRUCTURE SIZE8',
    BuffCheckFunction = AdjBuffFuncs.EnergyProductionBuffCheck,
    OnBuffAffect = AdjBuffFuncs.EnergyProductionBuffAffect,
    OnBuffRemove = AdjBuffFuncs.EnergyProductionBuffRemove,
    Affects = {
        EnergyProduction = {
            Add = 0.640625,
            Mult = 1.0,
        },
    },
}

BuffBlueprint {
    Name = 'T4EnergyStorageEnergyProductionBonusSize12',
    DisplayName = 'T4EnergyStorageEnergyProductionBonus',
    BuffType = 'MASSBUILDBONUS',
    Stacks = 'ALWAYS',
    Duration = -1,
    EntityCategory = 'STRUCTURE SIZE12',
    BuffCheckFunction = AdjBuffFuncs.EnergyProductionBuffCheck,
    OnBuffAffect = AdjBuffFuncs.EnergyProductionBuffAffect,
    OnBuffRemove = AdjBuffFuncs.EnergyProductionBuffRemove,
    Affects = {
        EnergyProduction = {
            Add = 0.427083,
            Mult = 1.0,
        },
    },
}

BuffBlueprint {
    Name = 'T4EnergyStorageEnergyProductionBonusSize16',
    DisplayName = 'T4EnergyStorageEnergyProductionBonus',
    BuffType = 'MASSBUILDBONUS',
    Stacks = 'ALWAYS',
    Duration = -1,
    EntityCategory = 'STRUCTURE SIZE16',
    BuffCheckFunction = AdjBuffFuncs.EnergyProductionBuffCheck,
    OnBuffAffect = AdjBuffFuncs.EnergyProductionBuffAffect,
    OnBuffRemove = AdjBuffFuncs.EnergyProductionBuffRemove,
    Affects = {
        EnergyProduction = {
            Add = 0.320311,
            Mult = 1.0,
        },
    },
}

BuffBlueprint {
    Name = 'T4EnergyStorageEnergyProductionBonusSize20',
    DisplayName = 'T4EnergyStorageEnergyProductionBonus',
    BuffType = 'MASSBUILDBONUS',
    Stacks = 'ALWAYS',
    Duration = -1,
    EntityCategory = 'STRUCTURE SIZE20',
    BuffCheckFunction = AdjBuffFuncs.EnergyProductionBuffCheck,
    OnBuffAffect = AdjBuffFuncs.EnergyProductionBuffAffect,
    OnBuffRemove = AdjBuffFuncs.EnergyProductionBuffRemove,
    Affects = {
        EnergyProduction = {
            Add = 0.25625,
            Mult = 1.0,
        },
    },
}

-- Riassegnazione: il blueprint T4 (bab1106 & co.) punta gia' a questo nome,
-- da qui in poi risolve ai 10 buff nuovi sopra invece che ai buff T3 riciclati.
T3MassEnergyStorageAdjacencyBuffs = {
    'T4EnergyStorageEnergyProductionBonusSize4',
    'T4EnergyStorageEnergyProductionBonusSize8',
    'T4EnergyStorageEnergyProductionBonusSize12',
    'T4EnergyStorageEnergyProductionBonusSize16',
    'T4EnergyStorageEnergyProductionBonusSize20',
    'T4MassStorageMassProductionBonusSize4',
    'T4MassStorageMassProductionBonusSize8',
    'T4MassStorageMassProductionBonusSize12',
    'T4MassStorageMassProductionBonusSize16',
    'T4MassStorageMassProductionBonusSize20',
}
