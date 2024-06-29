----------------------------------------------------------------------------
--
--  File     :  /data/units/XRL0302/XRL0302_script.lua
--  Author(s):  Jessica St. Croix, Gordon Duclos
--
--  Summary  :  Cybran Mobile Bomb Script
--
--  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
----------------------------------------------------------------------------
local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit
local CMobileKamikazeBombWeapon = import('/lua/cybranweapons.lua').CMobileKamikazeBombWeapon

XRL0303 = Class(CWalkingLandUnit) {
    Weapons = {
        DeathWeapon = Class(CMobileKamikazeBombWeapon) {},
        Suicide = Class(CMobileKamikazeBombWeapon) {        
            OnFire = function(self)         
                -- disable death weapon
                self.unit:SetDeathWeaponEnabled(false)
                CMobileKamikazeBombWeapon.OnFire(self)
            end,
        },
    },
    OnCreate = function(self)
        CWalkingLandUnit.OnCreate(self)
        self:SetMaintenanceConsumptionActive()
        self:SetScriptBit('RULEUTC_StealthToggle', false)
        self:RequestRefreshUI()
        if self:GetBlueprint().General.BuildBones then
            self:SetupBuildBones()
        end
    end,
    
    OnStopBeingBuilt = function(self,builder,layer)
        CWalkingLandUnit.OnStopBeingBuilt(self,builder,layer)
        self.DelayedCloakThread = self:ForkThread(self.CloakDelayed)
    end,
	
    CloakDelayed = function(self)
        if not self.Dead then
            WaitSeconds(2)
            self.IntelDisables['RadarStealth']['ToggleBit5'] = true
            self.IntelDisables['Cloak']['ToggleBit8'] = true
            self:EnableUnitIntel('ToggleBit5', 'RadarStealth')
            self:EnableUnitIntel('ToggleBit8', 'Cloak')
        end
        KillThread(self.DelayedCloakThread)
        self.DelayedCloakThread = nil
    end,

}
TypeClass = XRL0303