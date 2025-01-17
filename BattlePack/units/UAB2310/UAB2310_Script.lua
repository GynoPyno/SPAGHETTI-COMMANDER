#****************************************************************************
#**
#**  File     :  /cdimage/units/UAB2302/UAB2302_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Aeon Long Range Artillery Script
#**
#**  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local WeaponsFile = import ('/lua/aeonweapons.lua')
local AStructureUnit = import('/lua/aeonunits.lua').AStructureUnit
local ADFCannonOblivionWeapon = WeaponsFile.ADFCannonOblivionWeapon02
local AAATemporalFizzWeapon = import('/lua/aeonweapons.lua').AAATemporalFizzWeapon

UAB2302 = Class(AStructureUnit) {
    Weapons = {
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

TypeClass = UAB2302