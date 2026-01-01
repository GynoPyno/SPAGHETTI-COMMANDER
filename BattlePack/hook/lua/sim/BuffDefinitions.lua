#****************************************************************************
#**
#**  File     :  /lua/sim/buffdefinition.lua
#**
#**  Copyright © 2008 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

import('/lua/sim/AdjacencyBuffs.lua')
import('/lua/sim/CheatBuffs.lua') # Buffs for AI Cheating

##################################################################
## VETERANCY BUFFS - UNIT DAMAGE
##################################################################

BuffBlueprint {
    Name = 'VeterancyDamage1',
    DisplayName = 'VeterancyDamage1',
    BuffType = 'VETERANCYDAMAGE',
    Stacks = 'REPLACE',
    Duration = -1,
    Affects = {
        Damage = {
            Add = 0,
            Mult = 1.1,
        },
    },
}

BuffBlueprint {
    Name = 'VeterancyDamage2',
    DisplayName = 'VeterancyDamage2',
    BuffType = 'VETERANCYDAMAGE',
    Stacks = 'REPLACE',
    Duration = -1,
    Affects = {
        Damage = {
            Add = 0,
            Mult = 1.25,
        },
    },
}

BuffBlueprint {
    Name = 'VeterancyDamage3',
    DisplayName = 'VeterancyDamage3',
    BuffType = 'VETERANCYDAMAGE',
    Stacks = 'REPLACE',
    Duration = -1,
    Affects = {
        Damage = {
            Add = 0,
            Mult = 1.5,
        },
    },
}

BuffBlueprint {
    Name = 'VeterancyDamage4',
    DisplayName = 'VeterancyDamage4',
    BuffType = 'VETERANCYDAMAGE',
    Stacks = 'REPLACE',
    Duration = -1,
    Affects = {
        Damage = {
            Add = 0,
            Mult = 1.75,
        },
    },
}

BuffBlueprint {
    Name = 'VeterancyDamage5',
    DisplayName = 'VeterancyDamage5',
    BuffType = 'VETERANCYDAMAGE',
    Stacks = 'REPLACE',
    Duration = -1,
    Affects = {
        Damage = {
            Add = 0,
            Mult = 2,
        },
    },
}

##################################################################
## VETERANCY BUFFS - UNIT ROF
##################################################################

BuffBlueprint {
    Name = 'VeterancyRof1',
    DisplayName = 'VeterancyRof1',
    BuffType = 'VETERANCYROF',
    Stacks = 'REPLACE',
    Duration = -1,
    Affects = {
        RateOfFire = {
            Add = 0,
            Mult = 1.25,
        },
    },
}

BuffBlueprint {
    Name = 'VeterancyRof2',
    DisplayName = 'VeterancyRof2',
    BuffType = 'VETERANCYROF',
    Stacks = 'REPLACE',
    Duration = -1,
    Affects = {
        RateOfFire = {
            Add = 0,
            Mult = 1.5,
        },
    },
}

BuffBlueprint {
    Name = 'VeterancyRof3',
    DisplayName = 'VeterancyRof3',
    BuffType = 'VETERANCYROF',
    Stacks = 'REPLACE',
    Duration = -1,
    Affects = {
        RateOfFire = {
            Add = 0,
            Mult = 1.75,
        },
    },
}

BuffBlueprint {
    Name = 'VeterancyRof4',
    DisplayName = 'VeterancyRof4',
    BuffType = 'VETERANCYROF',
    Stacks = 'REPLACE',
    Duration = -1,
    Affects = {
        RateOfFire = {
            Add = 0,
            Mult = 2,
        },
    },
}

BuffBlueprint {
    Name = 'VeterancyRof5',
    DisplayName = 'VeterancyRof5',
    BuffType = 'VETERANCYROF',
    Stacks = 'REPLACE',
    Duration = -1,
    Affects = {
        RateOfFire = {
            Add = 0,
            Mult = 2.5,
        },
    },
}


__moduleinfo.auto_reload = true