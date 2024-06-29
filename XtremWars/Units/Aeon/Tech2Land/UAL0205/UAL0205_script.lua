#****************************************************************************
#**
#**  File     :  /cdimage/units/UAL0205/UAL0205_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix, Gordon Duclos
#**
#**  Summary  :  Aeon Mobile Flak Artillery Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local ALandUnit = import('/lua/aeonunits.lua').ALandUnit
local AAATemporalFizzWeapon = import('/lua/aeonweapons.lua').AAATemporalFizzWeapon
local ADFGravitonProjectorWeapon = import('/lua/aeonweapons.lua').ADFGravitonProjectorWeapon

UAL0205 = Class( ALandUnit ) {
    KickupBones = {},
    
    Weapons = {
        AAGun = Class(AAATemporalFizzWeapon) {
            ChargeEffectMuzzles = {'Muzzle_R01', 'Muzzle_L01'},
            
            PlayFxRackSalvoChargeSequence = function(self)
                AAATemporalFizzWeapon.PlayFxRackSalvoChargeSequence(self)
                CreateAttachedEmitter( self.unit, 'Muzzle_R01', self.unit:GetArmy(), '/effects/emitters/temporal_fizz_muzzle_charge_02_emit.bp')
                CreateAttachedEmitter( self.unit, 'Muzzle_L01', self.unit:GetArmy(), '/effects/emitters/temporal_fizz_muzzle_charge_03_emit.bp')
            end,
        },
		###UPGRADE02
		AAGun01 = Class(AAATemporalFizzWeapon) {
            ChargeEffectMuzzles = {'Muzzle_R02', 'Muzzle_L02'},
            
            PlayFxRackSalvoChargeSequence = function(self)
                AAATemporalFizzWeapon.PlayFxRackSalvoChargeSequence(self)
                CreateAttachedEmitter( self.unit, 'Muzzle_R03', self.unit:GetArmy(), '/effects/emitters/temporal_fizz_muzzle_charge_02_emit.bp')
                CreateAttachedEmitter( self.unit, 'Muzzle_L03', self.unit:GetArmy(), '/effects/emitters/temporal_fizz_muzzle_charge_03_emit.bp')
            end,
        },
		####IUPGRADe04
		ALGun = Class(ADFGravitonProjectorWeapon) {},
    },
 

    OnCreate = function(self)
		ALandUnit.OnCreate(self)

    end,

	
}

TypeClass = UAL0205
