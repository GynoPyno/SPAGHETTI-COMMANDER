local SRadarUnit = import('/lua/seraphimunits.lua').SRadarUnit
local SStructureUnit = import('/lua/seraphimunits.lua').SStructureUnit
local AWeapons = import('/lua/aeonweapons.lua')
local SWeapons = import('/lua/seraphimweapons.lua')
local WeaponFile = import('/lua/sim/defaultweapons.lua')
local AIFCommanderDeathWeapon = AWeapons.AIFCommanderDeathWeapon
local EffectUtil = import('/lua/EffectUtilities.lua')

GMSB409 = Class(SRadarUnit) {
    Weapons = {
        DeathWeapon = Class(AIFCommanderDeathWeapon) {},
    },
    
    OnIntelDisabled = function(self)
        SRadarUnit.OnIntelDisabled(self)
    end,

    OnIntelEnabled = function(self)
        SRadarUnit.OnIntelEnabled(self)

        if(not self.Rotator1) then
            self.Rotator1 = CreateRotator(self, 'Array03', 'y')
            self.Trash:Add(self.Rotator1)
        end
        self.Rotator1:SetTargetSpeed(30)
        self.Rotator1:SetAccel(20)
        
        if(not self.Rotator2) then
            self.Rotator2 = CreateRotator(self, 'Array02', 'y')
            self.Trash:Add(self.Rotator2)
        end
        self.Rotator2:SetTargetSpeed(-20)
        self.Rotator2:SetAccel(20)
        
        if(not self.Rotator3) then
            self.Rotator3 = CreateRotator(self, 'Array01', 'y')
            self.Trash:Add(self.Rotator3)
        end
        self.Rotator3:SetTargetSpeed(10)
        self.Rotator3:SetAccel(20)
    end,
}

TypeClass = GMSB409