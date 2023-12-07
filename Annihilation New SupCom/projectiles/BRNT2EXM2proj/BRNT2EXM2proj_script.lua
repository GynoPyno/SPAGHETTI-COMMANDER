#****************************************************************************
#**
#**  File     : 
#**  Author(s):
#**
#**  Summary  :
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local UefBRNT2EXM2proj = import('/mods/Annihilation New SupCom/lua/TMprojectiles.lua').UefBRNT2EXM2proj
BRNT2EXM2proj = Class(UefBRNT2EXM2proj) {
    OnCreate = function(self)
        UefBRNT2EXM2proj.OnCreate(self)
        self:SetCollisionShape('Sphere', 0, 0, 0, 2)
    end,
}

TypeClass = BRNT2EXM2proj
