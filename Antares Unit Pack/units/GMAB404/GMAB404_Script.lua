local AStructureUnit = import('/lua/aeonunits.lua').AStructureUnit

local WeaponsFile = import ('/lua/aeonweapons.lua')

local ADFCannonOblivionWeapon = WeaponsFile.ADFCannonOblivionWeapon02
local AAATemporalFizzWeapon = WeaponsFile.AAATemporalFizzWeapon
local AIFCommanderDeathWeapon = WeaponsFile.AIFCommanderDeathWeapon

local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtils = import('/lua/effectutilities.lua')

GMAB404 = Class(AStructureUnit) {
    Weapons = {
        DeathWeapon = Class(AIFCommanderDeathWeapon) {},
        EyeWeapon = Class(ADFCannonOblivionWeapon) {},
	EyeWeapon01 = Class(ADFCannonOblivionWeapon) {},
	EyeWeapon02 = Class(ADFCannonOblivionWeapon) {},
	EyeWeapon03 = Class(ADFCannonOblivionWeapon) {},
        AAGun = Class(AAATemporalFizzWeapon) {
            ChargeEffectMuzzles = {'Muzzle_Right', 'Muzzle_Right01', 'Muzzle_Right02', 'Muzzle_Right03'},
            
            PlayFxRackSalvoChargeSequence = function(self)
                AAATemporalFizzWeapon.PlayFxRackSalvoChargeSequence(self)
                CreateAttachedEmitter( self.unit, 'Muzzle_Right', self.unit:GetArmy(), '/effects/emitters/temporal_fizz_muzzle_charge_02_emit.bp')
                CreateAttachedEmitter( self.unit, 'Muzzle_Right', self.unit:GetArmy(), '/effects/emitters/temporal_fizz_muzzle_charge_03_emit.bp')
                CreateAttachedEmitter( self.unit, 'Muzzle_Right01', self.unit:GetArmy(), '/effects/emitters/temporal_fizz_muzzle_charge_02_emit.bp')
                CreateAttachedEmitter( self.unit, 'Muzzle_Right01', self.unit:GetArmy(), '/effects/emitters/temporal_fizz_muzzle_charge_03_emit.bp')
                CreateAttachedEmitter( self.unit, 'Muzzle_Right02', self.unit:GetArmy(), '/effects/emitters/temporal_fizz_muzzle_charge_02_emit.bp')
                CreateAttachedEmitter( self.unit, 'Muzzle_Right02', self.unit:GetArmy(), '/effects/emitters/temporal_fizz_muzzle_charge_03_emit.bp')
                CreateAttachedEmitter( self.unit, 'Muzzle_Right03', self.unit:GetArmy(), '/effects/emitters/temporal_fizz_muzzle_charge_02_emit.bp')
                CreateAttachedEmitter( self.unit, 'Muzzle_Right03', self.unit:GetArmy(), '/effects/emitters/temporal_fizz_muzzle_charge_03_emit.bp')
       		end,
        },
    },

}

TypeClass = GMAB404