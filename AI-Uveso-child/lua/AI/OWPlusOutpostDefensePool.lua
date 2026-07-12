-- OWPlusOutpostDefensePool.lua
-- Fase C (B16 - Avamposti autonomi): pool di unita' difensive T1 per avamposto,
-- vanilla + TotalMayhem (unica mod verificata con difese T1 aggiuntive reali —
-- Antares/BattlePack/BlackOps/ExpShield non hanno nulla di nuovo a T1, verificato
-- durante il brainstorming B16 in AI_Mod_Spec.md).
--
-- Unita' TotalMayhem confermate (ricerca dedicata, Categories verificate nei file
-- .bp: STRUCTURE+DEFENSE+TECH1+DIRECTFIRE/ANTIAIR, no EXPERIMENTAL/TECH2/3):
--   Cybran:   BRMT1PD, BRMT1EXPD (ground)
--   UEF:      BRNT1HPD (ground), BRNT1EXPD (ground+AA ibrida), BRNBAAFAC (AA)
--   Aeon:     BROT1HPD, BROT1EXPD (solo ground, nessuna AA T1 extra da TotalMayhem)
--   Seraphim: BRPT1PD, BRPT1EXPD (solo ground, nessuna AA T1 extra da TotalMayhem)
--
-- T2/T3 riusano le stringhe generiche vanilla (nessun pool/randomizzazione a quei
-- tier, per design B16) — catalogo mod esteso per T2/T3/Experimental rimandato
-- esplicitamente (vedi AI_Mod_Spec.md, nota "dopo" nella tabella fasi B16).
-- LIMITE NOTO: 'T3GroundDefense' esiste come nome generico in BuildingTemplates.lua
-- (vanilla) per UNA sola fazione (verificato) — le altre 3 non hanno un point-
-- defense T3 generico mappato. L'upgrade difese TERRA si ferma quindi a T2 per
-- tutte le fazioni (limite dei dati vanilla, non una scelta nostra). L'AA invece
-- ha 'T3AADefense' per tutte e 4 le fazioni — upgrade completo T1->T2->T3.

local GroundDefensePoolT1 = {
    UEF      = { 'T1GroundDefense', 'BRNT1HPD', 'BRNT1EXPD' },
    Aeon     = { 'T1GroundDefense', 'BROT1HPD', 'BROT1EXPD' },
    Cybran   = { 'T1GroundDefense', 'BRMT1PD', 'BRMT1EXPD' },
    Seraphim = { 'T1GroundDefense', 'BRPT1PD', 'BRPT1EXPD' },
}

local AADefensePoolT1 = {
    UEF      = { 'T1AADefense', 'BRNT1EXPD', 'BRNBAAFAC' },
    Aeon     = { 'T1AADefense' },
    Cybran   = { 'T1AADefense' },
    Seraphim = { 'T1AADefense' },
}

-- Ordine confermato in /lua/factions.lua vanilla ("the order here will determine
-- the faction index, it's the automatically assigned array index"): UEF=1, Aeon=2,
-- Cybran=3, Seraphim=4.
local FactionNames = { 'UEF', 'Aeon', 'Cybran', 'Seraphim' }

local function GetFactionName(aiBrain)
    local idx = aiBrain:GetFactionIndex()
    return FactionNames[idx] or 'UEF'
end

local function PickListFromPool(aiBrain, pool, count)
    local faction = GetFactionName(aiBrain)
    local options = pool[faction] or pool['UEF']
    local list = {}
    for i = 1, count do
        table.insert(list, options[Random(1, table.getn(options))])
    end
    return list
end

-- Fase C: lista iniziale difese T1 per un nuovo avamposto — 3-7 point-defense
-- terra + 4-9 AA, pescati a caso (con ripetizione) dal pool vanilla+TotalMayhem
-- della fazione dell'aiBrain.
function OWPlusPickInitialOutpostDefenses(aiBrain)
    local groundCount = Random(3, 7)
    local aaCount = Random(4, 9)
    return {
        ground = PickListFromPool(aiBrain, GroundDefensePoolT1, groundCount),
        aa = PickListFromPool(aiBrain, AADefensePoolT1, aaCount),
    }
end

-- Fase C: stringa generica per un upgrade difesa a un tier >1 (dopo reclaim).
-- Vedi nota in testa al file sul limite T3 lato terra.
function OWPlusPickUpgradeDefense(aiBrain, tier, isAA)
    if isAA then
        if tier >= 3 then
            return 'T3AADefense'
        elseif tier == 2 then
            return 'T2AADefense'
        end
        return 'T1AADefense'
    end
    if tier >= 2 then
        return 'T2GroundDefense'
    end
    return 'T1GroundDefense'
end
