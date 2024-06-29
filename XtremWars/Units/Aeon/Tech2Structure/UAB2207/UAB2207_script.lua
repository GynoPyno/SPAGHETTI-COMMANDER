--[[#######################################################################
#  File     :  /units/Usines/UAB2207/UAB2207_script.lua
#  Author(s):  John Comes, David Tomandl, Jessica St. Croix, Gordon Duclos
#  Summary  :  Aeon Flak Cannon
#  -----------------------------
#  Modif.by :  Asdrubaelvect
#  Rev.Date :  jj mmmmm aaaa
#  -----------------------------
#  Revis.by :  Manimal
#  Rev.Date :  18 mars 2010
#  -----------------------------
#  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#######################################################################]]--

local AAirUnit = import( '/lua/aeonunits.lua' ).AAirUnit

local AAATemporalFizzWeapon = import('/lua/aeonweapons.lua').AAATemporalFizzWeapon


UAB2207 = Class( AAirUnit ) {
    Weapons = {
        AAFizz = Class( AAATemporalFizzWeapon ) {
            ChargeEffectMuzzles = {'Turret_Right_Muzzle', 'Turret_Left_Muzzle'},
            
            PlayFxRackSalvoChargeSequence = function(self)
                AAATemporalFizzWeapon.PlayFxRackSalvoChargeSequence(self)
                CreateAttachedEmitter( self.unit, 'Turret_Right_Muzzle', self.unit:GetArmy(), '/effects/emitters/temporal_fizz_muzzle_charge_02_emit.bp')
                CreateAttachedEmitter( self.unit, 'Turret_Left_Muzzle', self.unit:GetArmy(), '/effects/emitters/temporal_fizz_muzzle_charge_03_emit.bp')
            end,
        },
    },
}

TypeClass = UAB2207
