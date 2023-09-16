#****************************************************************************
#**
#**  File     :  /cdimage/units/XRL0305/XRL0305_script.lua
#**  Author(s):  Drew Staltman, Jessica St. Croix, Gordon Duclos
#**
#**  Summary  :  Cybran Siege Assault Bot Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local CWalkingLandUnit = import( '/lua/cybranunits.lua').CWalkingLandUnit

local CWeapons = import('/lua/cybranweapons.lua')
local CDFHeavyDisintegratorWeapon = CWeapons.CDFHeavyDisintegratorWeapon
local CANNaniteTorpedoWeapon = import('/lua/cybranweapons.lua').CANNaniteTorpedoWeapon
local CIFSmartCharge = import('/lua/cybranweapons.lua').CIFSmartCharge
local CDFElectronBolterWeapon = CWeapons.CDFElectronBolterWeapon


XRL0305 = Class(CWalkingLandUnit)
{
    Weapons = {
        Disintigrator = Class(CDFHeavyDisintegratorWeapon) {},
        Torpedo = Class(CANNaniteTorpedoWeapon) {},
        AntiTorpedo = Class(CIFSmartCharge) {},
		###UPGRADE02
		DisintigratorG = Class(CDFHeavyDisintegratorWeapon) {},
		DisintigratorD = Class(CDFHeavyDisintegratorWeapon) {},
		###UPGRADE03
		HeavyBolterI = Class(CDFElectronBolterWeapon) {
			OnCreate = function(self)
                CDFElectronBolterWeapon.OnCreate(self)
                #Disable buff 
                self:DisableBuff('STUN')
            end,
		},
		HeavyBolterII = Class(CDFElectronBolterWeapon) {
			OnCreate = function(self)
                CDFElectronBolterWeapon.OnCreate(self)
                #Disable buff 
                self:DisableBuff('STUN')
            end,
		},
    },
	
	OnCreate = function(self)
        CWalkingLandUnit.OnCreate(self)

    end,	

	
    OnKilled = function(self, instigator, type, overkillRatio)
        local emp = self:GetWeaponByLabel('EMP')
        local bp
        for k, v in self:GetBlueprint().Buffs do
            if v.Add.OnDeath then
                bp = v
            end
        end
        #if we could find a blueprint with v.Add.OnDeath, then add the buff 
        if bp != nil then 
            #Apply Buff
			self:AddBuff(bp)
        end
        #otherwise, we should finish killing the unit
           
		if self.UnitComplete then
            # Play EMP Effect
            CreateLightParticle( self, -1, -1, 24, 62, 'flare_lens_add_02', 'ramp_red_10' )
            # Fire EMP weapon
            emp:SetWeaponEnabled(true)
            emp:OnFire()
        end
        CWalkingLandUnit.OnKilled(self, instigator, type, overkillRatio)
    end,	
	
	
}
TypeClass = XRL0305