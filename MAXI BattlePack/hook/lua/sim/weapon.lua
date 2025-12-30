local prevClass = Weapon
Weapon = Class(prevClass) {
    OnCreate = function(self)
        prevClass.OnCreate(self)
        self.BuffDamage = 0
    end,

    ChangeDamage = function(self, amt)
        local addDamage = (amt - self:GetBlueprint().Damage) - self.BuffDamage
        self.BuffDamage = self.BuffDamage + addDamage
        self:AddDamageMod(addDamage)
        prevClass.ChangeDamage(self, amt)
    end,
}