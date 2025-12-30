-- Builder
PlatoonTemplate {
    Name = 'T2 Tech1 Mayhem Tank',
    FactionSquads = {
        UEF = {
            { 'uel0108', 1, 1, 'Attack', 'none' } -- Predator MK3 (Heavy Tank) 
        },
        Aeon = {
            { 'ual03072', 1, 1, 'attack', 'none' } -- Lintea MK3 (Medium Tank) 
        },
        Cybran = {
            { 'orl0111', 1, 1, 'attack', 'none' } -- Reaper MK3 (Battle Tank) 
        },
        Seraphim = {
            { 'xsl0110', 1, 1, 'attack', 'none' } -- Hethaam MK3 (Battle Tank)
        },
    },
}
-- Former
PlatoonTemplate {
    Name = 'TM1 HEAVYASSAULT LAND', 
    Plan = 'AttackForceAI',
    GlobalSquads = {
        { categories.MOBILE * categories.LAND * categories.TECH1 * categories.HEAVYASSAULT, 1, 10, 'Attack', 'none' },
    }
}

