local CStructureUnit = import('/lua/cybranunits.lua').CStructureUnit
local CDFLaserHeavyWeapon = import('/lua/cybranweapons.lua').CDFLaserHeavyWeapon

url0404 = Class(CStructureUnit) {

    Weapons = {
        MainGun = Class(CDFLaserHeavyWeapon) {}
    },

-- File pathing and special paramiters called 

    -- Setsup parent call backs between drone and parent
    Parent = nil,

    SetParent = function(self, parent, turretName)
        self.Parent = parent
        self.Turret = turretName
    end,

-----------------------------------------------------------------------------

    OnStopBeingBuilt = function(self,builder,layer)
        CStructureUnit.OnStopBeingBuilt(self)
        -- Global variable setup
        self.TurretWeapon = self:GetWeaponByLabel('MainGun')
    end,

    OnDamage = function(self, instigator, amount, vector, damagetype)
        -- Makes the secondary turret 100% damage immune
        amount = math.ceil(amount*0)
        CStructureUnit.OnDamage(self, instigator, amount, vector, damagetype)
    end,

    NotifyOfTurretStopped = function(self)
        -- Sets the secondary turret accuracy back to default values
        if not self:IsDead() then
            self.TurretWeapon:SetFiringRandomness(0.5)
        end
    end,

    NotifyOfTurretMoving = function(self)
        -- Sets the secondary turret accuracy lower as the Vulcanizer is moving
        if not self:IsDead() then
            self.TurretWeapon:SetFiringRandomness(2.0)
        end
    end,

    DestroySecondaryTurret = function(self)
        -- Receives the kill command from the Vulcanizer to remove the secondary turret
        if not self:IsDead() then
            self:Destroy()
        end
    end,

    OnKilled = function(self, instigator, type, overkillRatio)
        -- Disables primary weapon
        self:SetWeaponEnabledByLabel('MainGun', false)

        -- Clears the current turret commands if any 
        IssueClearCommands(self)

        -- Clears the offending turret from the parents table
        self.Parent = nil
        table.removeByValue(self.Parent.TurretTable, self)

        -- Final command to finish off the turret death event
        CStructureUnit.OnKilled(self, instigator, type, overkillRatio)
    end,

}
TypeClass = url0404