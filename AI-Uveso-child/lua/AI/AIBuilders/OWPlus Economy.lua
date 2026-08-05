-- OWPlus Economy.lua
-- Override economici per la personalità OverwhelmPlus.
-- Problema: con i moltiplicatori ×2/×3 di Overwhelm, l'energia è sempre spesa per costruzioni
-- e il serbatoio non raggiunge mai 100% (reclaim T1 pgen) né 90% (mass storage).
-- Soluzione: soglia ridotta al 50% per entrambe le operazioni.

local categories = categories
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local MABC = '/lua/editor/MarkerBuildConditions.lua'
-- Sess.94: log diagnostico per Energy Storage Adjacency + Hydrocarbon Push
local OWPlusLogCond = '/mods/AI-Uveso-child/lua/AI/OWPlusLogConditions.lua'

local MaxCapMass = 0.10  -- 10% del cap unità per estrattori+storage (mirror di Base Mass.lua)
local MaxCapStructure = 0.12  -- 12% del cap unità per strutture generiche (mirror di Base Energy.lua, riusato da Hydrocarbon Push)

-- ============================================================== --
-- ==  Reclaim T1 Pgens — soglia energia 50% (originale: 100%)  == --
-- ============================================================== --
BuilderGroup {
    BuilderGroupName = 'OWPlus Economy T1 Reclaim',
    BuildersType = 'EngineerBuilder',

    Builder {
        BuilderName = 'OWPlus Reclaim T1 Pgens',
        PlatoonTemplate = 'EngineerBuilder',
        PlatoonAIPlan = 'ReclaimStructuresAI',
        Priority = 790,
        InstanceCount = 2,
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.NeedEnergyTech1 then
                return 0    -- ancora in tech 1 energia: non demolire
            else
                return 790
            end
        end,
        BuilderConditions = {
            { EBC,  'GreaterThanEconStorageRatio',      { 0.00, 0.50 } },   -- energia > 50% (non 100%)
            { UCBC, 'UnitsGreaterAtLocation',           { 'LocationType', 0, categories.STRUCTURE * categories.TECH1 * categories.ENERGYPRODUCTION - categories.HYDROCARBON }},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.ENERGYPRODUCTION * (categories.TECH2 + categories.TECH3) }},
        },
        BuilderData = {
            Location = 'LocationType',
            Reclaim = { categories.STRUCTURE * categories.TECH1 * categories.ENERGYPRODUCTION - categories.HYDROCARBON },
        },
        BuilderType = 'Any',
    },

    Builder {
        BuilderName = 'OWPlus Reclaim T1 Pgens T2',
        PlatoonTemplate = 'T2EngineerBuilder',
        PlatoonAIPlan = 'ReclaimStructuresAI',
        Priority = 790,
        InstanceCount = 2,
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.NeedEnergyTech1 then
                return 0
            else
                return 790
            end
        end,
        BuilderConditions = {
            { EBC,  'GreaterThanEconStorageRatio',      { 0.00, 0.50 } },   -- energia > 50% (non 100%)
            { UCBC, 'UnitsGreaterAtLocation',           { 'LocationType', 0, categories.STRUCTURE * categories.TECH1 * categories.ENERGYPRODUCTION - categories.HYDROCARBON }},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.ENERGYPRODUCTION * (categories.TECH2 + categories.TECH3) }},
        },
        BuilderData = {
            Location = 'LocationType',
            Reclaim = { categories.STRUCTURE * categories.TECH1 * categories.ENERGYPRODUCTION - categories.HYDROCARBON },
        },
        BuilderType = 'Any',
    },
}

-- ============================================================== --
-- ==  Energia T2/T3 — priorità alta per bypassare loop T1     == --
-- ============================================================== --
-- Problema: U123 Energy Builders ha T2 a priority 17000 e T1 a 17900.
-- Gli ingegneri T2 scelgono sempre T1 (più alto) finché NeedEnergyTech1=true,
-- ma NeedEnergyTech1 rimane true finché non ci sono 2 T2 pgens → loop infinito.
-- Soluzione: builder OWPlus a priority 18100/18200, bypassano il gate Uveso.
BuilderGroup {
    BuilderGroupName = 'OWPlus Energy T2T3',
    BuildersType = 'EngineerBuilder',

    Builder {
        BuilderName = 'OWPlus T2 Power Push',
        PlatoonTemplate = 'T2EngineerBuilder',
        Priority = 18100,
        InstanceCount = 2,
        BuilderConditions = {
            { UCBC, 'GreaterThanGameTimeSeconds',           { 60 * 5 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory',     { 0, categories.STRUCTURE * categories.FACTORY * categories.TECH2 } },
            { UCBC, 'HaveLessThanUnitsWithCategory',        { 5, categories.ENERGYPRODUCTION * (categories.TECH2 + categories.TECH3) } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE * categories.ENERGYPRODUCTION * (categories.TECH2 + categories.TECH3) } },
        },
        BuilderData = {
            Construction = {
                AdjacencyCategory = (categories.STRUCTURE * categories.SHIELD) + (categories.FACTORY * (categories.TECH2 + categories.TECH1)),
                AdjacencyDistance = 50,
                BuildClose = false,
                LocationType = 'LocationType',
                BuildStructures = { 'T2EnergyProduction' },
            }
        },
        BuilderType = 'Any',
    },

    Builder {
        BuilderName = 'OWPlus T3 Power Push',
        PlatoonTemplate = 'T3EngineerBuilder',
        Priority = 18200,
        InstanceCount = 3,
        BuilderConditions = {
            { UCBC, 'GreaterThanGameTimeSeconds',           { 60 * 10 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory',     { 0, categories.STRUCTURE * categories.FACTORY * categories.TECH3 } },
            { UCBC, 'HaveLessThanUnitsWithCategory',        { 8, categories.ENERGYPRODUCTION * categories.TECH3 } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, categories.STRUCTURE * categories.ENERGYPRODUCTION * categories.TECH3 } },
        },
        BuilderData = {
            Construction = {
                AdjacencyCategory = (categories.STRUCTURE * categories.SHIELD) + (categories.FACTORY * (categories.TECH3 + categories.TECH2)),
                AdjacencyDistance = 50,
                BuildClose = false,
                LocationType = 'LocationType',
                BuildStructures = { 'T3EnergyProduction' },
            }
        },
        BuilderType = 'Any',
    },
}

-- ============================================================== --
-- ==  Mass Storage Adjacency — soglia energia 50% (orig: 90%)  == --
-- ============================================================== --
BuilderGroup {
    BuilderGroupName = 'OWPlus Mass Storage Adjacency',
    BuildersType = 'EngineerBuilder',

    Builder {
        BuilderName = 'OWPlus Mass Storage T1 Eng',
        PlatoonTemplate = 'EngineerBuilder',
        Priority = 17879,
        DelayEqualBuildPlattons = { 'MASSSTORAGE', 5 },
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.HasParagon then
                return 0
            else
                return 17879
            end
        end,
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay',           { 'MASSSTORAGE' }},
            { EBC,  'GreaterThanEconStorageRatio',      { 0.1, 0.50 } },    -- energia > 50% (non 90%)
            -- Sess.95 (bis): tetto fisso 1 (thread singolo) -> proporzionale 20% degli
            -- estrattori T2+/T3 (vedi funzione per il perche') -- HaveLessThanUnitsInCategoryBeingBuilt rimossa
            { OWPlusLogCond, 'OWPlusMassStorageBuildThrottle', { 'Mass Storage T1' } },
            -- Sess.94: tetto assoluto (era 16) rimosso su richiesta esplicita utente
            { UCBC, 'HaveUnitRatioVersusCap',           { MaxCapMass, '<', categories.STRUCTURE * (categories.MASSEXTRACTION + categories.MASSFABRICATION + categories.MASSSTORAGE) }},
            { UCBC, 'AdjacencyCheck',                   { 'LocationType', categories.STRUCTURE * categories.MASSEXTRACTION * (categories.TECH2 + categories.TECH3), 60, 'ueb1106' }},
            -- Sess.95 (ter): sostituisce il gate di fase (rimosso, legava i magazzini
            -- all'80% di copertura sugli estrattori -- irraggiungibile con estrattori
            -- sparsi) con un pavimento leggero e indipendente: basta che la Fase 1
            -- (T1->T2) sia iniziata sul serio, non un singolo T2 isolato per caso.
            { OWPlusLogCond, 'OWPlusMassStorageEligible', { 'Mass Storage T1 Build' } },
        },
        BuilderData = {
            Construction = {
                AdjacencyCategory = categories.STRUCTURE * categories.MASSEXTRACTION * (categories.TECH2 + categories.TECH3),
                AdjacencyDistance = 60,
                BuildClose = false,
                BuildStructures = { 'MassStorage' },
            }
        },
        BuilderType = 'Any',
    },

    Builder {
        BuilderName = 'OWPlus Mass Storage T2 Eng',
        PlatoonTemplate = 'T2EngineerBuilder',
        Priority = 17878,
        DelayEqualBuildPlattons = { 'MASSSTORAGE', 5 },
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.HasParagon then
                return 0
            else
                return 17878
            end
        end,
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay',           { 'MASSSTORAGE' }},
            { EBC,  'GreaterThanEconStorageRatio',      { 0.1, 0.50 } },    -- energia > 50% (non 90%)
            -- Sess.95 (bis): stesso tetto proporzionale del builder T1 Eng sopra --
            -- condiviso tra le due varianti (stessa MASSSTORAGE category), coerente
            -- con l'originale (anche il tetto fisso 1 era condiviso tra T1 e T2 Eng).
            { OWPlusLogCond, 'OWPlusMassStorageBuildThrottle', { 'Mass Storage T2' } },
            { UCBC, 'AdjacencyCheck',                   { 'LocationType', categories.MASSEXTRACTION * categories.TECH3, 60, 'ueb1106' }},
            -- Sess.94: tetto assoluto (era 32) rimosso su richiesta esplicita utente
            { UCBC, 'HaveUnitRatioVersusCap',           { MaxCapMass, '<', categories.STRUCTURE * (categories.MASSEXTRACTION + categories.MASSFABRICATION + categories.MASSSTORAGE) }},
            -- Sess.95 (ter): stesso pavimento leggero del builder T1 Eng sopra
            { OWPlusLogCond, 'OWPlusMassStorageEligible', { 'Mass Storage T2 Build' } },
        },
        BuilderData = {
            Construction = {
                AdjacencyCategory = 'MASSEXTRACTION TECH3',
                AdjacencyDistance = 60,
                BuildClose = false,
                BuildStructures = { 'MassStorage' },
            }
        },
        BuilderType = 'Any',
    },
}

-- ============================================================== --
-- ==  Energy Storage Adjacency (nuovo, sess.94) — gemello       == --
-- ==  di Mass Storage Adjacency, tetto tripliato (48/96)        == --
-- ============================================================== --
-- Prima di sess.94 non esisteva alcun builder che circondasse i generatori
-- di energia con magazzini energia — richiesta esplicita utente, stesso
-- pattern gia' validato per la massa (AdjacencyCategory/AdjacencyCheck sui
-- generatori T2/T3 invece che sugli estrattori). Tetto 48/96 (triplo dei
-- valori massa originali 16/32, appena rimossi sopra) su richiesta esplicita
-- utente -- qui il limite resta, a differenza della massa.
BuilderGroup {
    BuilderGroupName = 'OWPlus Energy Storage Adjacency',
    BuildersType = 'EngineerBuilder',

    Builder {
        BuilderName = 'OWPlus Energy Storage T1 Eng',
        PlatoonTemplate = 'EngineerBuilder',
        Priority = 17877,
        DelayEqualBuildPlattons = { 'ENERGYSTORAGE', 5 },
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.HasParagon then
                return 0
            else
                return 17877
            end
        end,
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay',           { 'ENERGYSTORAGE' }},
            { OWPlusLogCond, 'OWPlusDebugEconStorageRatio', { 0.1, 0.50, 'Energy Storage T1' } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE * categories.ENERGYSTORAGE }},
            { UCBC, 'HaveLessThanUnitsWithCategory',    { 48, categories.STRUCTURE * categories.ENERGYSTORAGE }},
            { UCBC, 'AdjacencyCheck',                   { 'LocationType', categories.STRUCTURE * categories.ENERGYPRODUCTION * (categories.TECH2 + categories.TECH3), 60, 'ueb1105' }},
        },
        BuilderData = {
            Construction = {
                AdjacencyCategory = categories.STRUCTURE * categories.ENERGYPRODUCTION * (categories.TECH2 + categories.TECH3),
                AdjacencyDistance = 60,
                BuildClose = false,
                BuildStructures = { 'EnergyStorage' },
            }
        },
        BuilderType = 'Any',
    },

    Builder {
        BuilderName = 'OWPlus Energy Storage T2 Eng',
        PlatoonTemplate = 'T2EngineerBuilder',
        Priority = 17876,
        DelayEqualBuildPlattons = { 'ENERGYSTORAGE', 5 },
        PriorityFunction = function(self, aiBrain)
            if aiBrain.PriorityManager.HasParagon then
                return 0
            else
                return 17876
            end
        end,
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay',           { 'ENERGYSTORAGE' }},
            { OWPlusLogCond, 'OWPlusDebugEconStorageRatio', { 0.1, 0.50, 'Energy Storage T2' } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE * categories.ENERGYSTORAGE }},
            { UCBC, 'AdjacencyCheck',                   { 'LocationType', categories.ENERGYPRODUCTION * categories.TECH3, 60, 'ueb1105' }},
            { UCBC, 'HaveLessThanUnitsWithCategory',    { 96, categories.STRUCTURE * categories.ENERGYSTORAGE }},
        },
        BuilderData = {
            Construction = {
                AdjacencyCategory = 'ENERGYPRODUCTION TECH3',
                AdjacencyDistance = 60,
                BuildClose = false,
                BuildStructures = { 'EnergyStorage' },
            }
        },
        BuilderType = 'Any',
    },
}

-- ============================================================== --
-- ==  Hydrocarbon Push (nuovo, sess.94) — bypassa lo stesso     == --
-- ==  crollo priorita' gia' risolto per l'energia standard      == --
-- ============================================================== --
-- Causa: il builder nativo 'U1 Power Hydrocarbon' (Base Energy.lua) ha
-- Priority=0 non appena PriorityManager.NeedEnergyTech1 diventa false (2+
-- centrali T2) -- con questa mod succede in pochi minuti (OWPlus Energy
-- T2T3 spinge T2 aggressivamente). Risultato osservato dall'utente in
-- partita reale: l'AI costruisce il primo marker hydro poi ignora tutti
-- gli altri per il resto della partita. Stesso identico bug del "loop
-- T1/T2" gia' risolto sopra per l'energia standard (OWPlus Energy T2T3) --
-- stesso rimedio: priorita' FISSA, indipendente da NeedEnergyTech1.
-- Condizioni/dati di costruzione copiati fedelmente dal nativo (nessuna
-- modifica alle soglie, solo alla priorita', come richiesto dall'utente).
BuilderGroup {
    BuilderGroupName = 'OWPlus Hydrocarbon Push',
    BuildersType = 'EngineerBuilder',

    Builder {
        BuilderName = 'OWPlus Hydrocarbon Push Eng',
        PlatoonTemplate = 'EngineerBuilder',
        Priority = 17950,
        DelayEqualBuildPlattons = { 'Energy', 1 },
        -- Sess.98 (richiesta esplicita utente): InstanceCount 1->3. Causa trovata
        -- via diagnostica dedicata (OWPlusDebugHydrocarbonDiag, test reale 16 min):
        -- CanBuildOnHydro e CheckBuildPlattonDelay risultavano SEMPRE veri per
        -- minuti mentre il conteggio idrocarburi restava fermo a 1 e i generatori
        -- T1 standard salivano a 22+ -- non un cap sul totale (che infatti cresce
        -- regolarmente nel tempo, 1->11+ in 30 min), ma un collo di bottiglia di
        -- CONCORRENZA: questo builder e' l'UNICO che punta a 'T1HydroCarbon' (con
        -- InstanceCount=1, fedele al nativo 'U1 Power Hydrocarbon'), mentre il
        -- generatore T1 standard ha 6 builder nativi diversi che puntano alla
        -- stessa struttura, ciascuno con la propria InstanceCount -- effettivamente
        -- 6-8 ingegneri possono costruire T1 pgens in parallelo contro 1 solo per
        -- gli idrocarburi, indipendentemente da quanti marker liberi esistano.
        InstanceCount = 3,
        BuilderConditions = {
            -- Sess.98: diagnostica NEUTRA (LOG+true, non blocca mai) messa PER PRIMA
            -- cosi' viene sempre valutata ad ogni ciclo indipendentemente da quale
            -- altra condizione blocchi la catena sotto -- verifica l'ipotesi "il
            -- generatore T1 standard (senza vincoli di marker/cooldown) prende il
            -- sopravvento quando CanBuildOnHydro non trova un marker libero entro 90".
            { OWPlusLogCond, 'OWPlusDebugHydrocarbonDiag', { 'LocationType', 'Hydrocarbon Push' } },
            { UCBC, 'CheckBuildPlattonDelay', { 'Energy' }},
            -- Sess.95 (quinquies): soglia mass income 0.9->0 -- richiesta esplicita
            -- utente dopo test in game: la soglia 0.9 (ereditata fedelmente dal nativo
            -- 'U1 Power Hydrocarbon') creava un circolo vizioso nei primi minuti --
            -- richiede un mass income che l'AI puo' avere solo DOPO aver gia' costruito
            -- altri estrattori, quindi finiva sempre per costruirli prima invece
            -- dell'hydrocarbon (piu' economico e utile prima). Soglia energy (2.0)
            -- invariata, resta l'unico vincolo economico.
            { OWPlusLogCond, 'OWPlusDebugEconIncome', { 0, 2.0, 'Hydrocarbon Push' } },
            { MABC, 'CanBuildOnHydro', { 'LocationType', 90, -1000, 100, 1, 'AntiSurface', 1 }},
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapStructure, '<', categories.STRUCTURE - categories.MASSEXTRACTION - categories.DEFENSE - categories.FACTORY } },
            -- Sess.94: diagnostica temporanea (LOG+true) — quanti hydrocarbon T1 costruiti nel tempo
            { OWPlusLogCond, 'OWPlusDebugUpgradeProgress', { categories.STRUCTURE * categories.HYDROCARBON, categories.STRUCTURE * categories.HYDROCARBON, 'Hydrocarbon Count' } },
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T1HydroCarbon',
                }
            }
        }
    },
}
