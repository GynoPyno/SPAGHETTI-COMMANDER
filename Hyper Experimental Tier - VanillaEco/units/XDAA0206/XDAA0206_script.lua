#****************************************************************************
#**
#**  File     :  /cdimage/units/DAA0206/DAA0206_script.lua
#**  Author(s):  Cmd Draven
#**
#**  Summary  :  Aeon Guided Torpedo Script
#**
#****************************************************************************
local ASeaUnit = import('/lua/aeonunits.lua').ASeaUnit
local CMobileKamikazeBombWeapon = import('/lua/cybranweapons.lua').CMobileKamikazeBombWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtils = import('/lua/effectutilities.lua')

local Weapon = import('/lua/sim/Weapon.lua').Weapon

--- A unique death weapon for the Fire Beetle
local DeathWeaponKamikaze = Class(Weapon) {

    FxDeath = EffectTemplate.CMobileKamikazeBombExplosion,

    OnFire = function(self)

        -- get information
        local blueprint = self:GetBlueprint()
        local position = self.unit:GetPosition()

        -- do emitters
        local army = self.unit.Army
        for k, v in self.FxDeath do
            CreateEmitterAtBone(self.unit, -2, army, v)
        end

        -- do regular death weapon of unit if we didn't already
        if not self.unit.Dead then
            self.unit:DoDeathWeapon()
        end

        -- do damage
        DamageArea(self.unit, position, blueprint.DamageRadius, blueprint.Damage, blueprint.DamageType or 'Normal', blueprint.DamageFriendly or false)
        self.unit:PlayUnitSound('Destroyed')
        self.unit:Destroy()
    end,
}


XDAA0206 = Class(ASeaUnit) {
    Weapons = {
        Suicide = Class(DeathWeaponKamikaze) {},
    },

	    -- This is the Denotate button - triggers the weapon but without an instigator so that it doesn't get called twice.
    OnProductionPaused = function(self)
        self:GetWeaponByLabel('Suicide'):FireWeapon()
    end,

 --- Called when the unit dies - if it dies to some instigator then the suicide weapon is activated.
    OnKilled = function(self, instigator, type, overkillRatio)
        ASeaUnit.OnKilled(self, instigator, type, overkillRatio)
        if instigator then
            self:GetWeaponByLabel('Suicide'):FireWeapon()
        end
    end,

    --- Called when the unit dies by Unit.OnKilled.
    DoDeathWeapon = function(self)

        if self:IsBeingBuilt() then return end

        -- handle regular death weapon procedures
        ASeaUnit.DoDeathWeapon(self)
    end,
}
TypeClass = XDAA0206
