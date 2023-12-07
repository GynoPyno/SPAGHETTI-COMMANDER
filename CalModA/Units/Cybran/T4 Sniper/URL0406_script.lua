--****************************************************************************
--**
--**  File     :  /cdimage/units/URL0106/URL0106_script.lua
--**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
--**
--**  Summary  :  Cybran Light Infantry Script
--**
--**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
--****************************************************************************

local CWalkingLandUnit = import("/lua/cybranunits.lua").CWalkingLandUnit
local WeaponsFile = import('/lua/cybranweapons.lua')
local CDFLaserDisintegratorWeapon = import('/lua/cybranweapons.lua').CDFLaserDisintegratorWeapon01

---@class URL0106 : CWalkingLandUnit
URL0106 = ClassUnit(CWalkingLandUnit) {

  IntelEffects = {
        Cloak = {
            {
                Bones = {
                    'URL0106',
                },
                Scale = 3.0,
                Type = 'Cloak01',
            },
        },
    },

    Weapons = {
        MainGun = ClassWeapon(CDFLaserDisintegratorWeapon) {},
    },

    OnStopBeingBuilt = function(self,builder,layer)
        CWalkingLandUnit.OnStopBeingBuilt(self,builder,layer)
        self:SetMaintenanceConsumptionActive()
        self:ForkThread(self.HideUnit, self)
        self.DelayedCloakThread = self:ForkThread(self.CloakDelayed)
    end,

    --- Adds the cloaking mesh to the unit to hide it
    HideUnit = function(self)
        WaitTicks(1)
        self:SetMesh(self:GetBlueprint().Display.CloakMeshBlueprint, true)
    end,

    CloakDelayed = function(self)
        if not self.Dead then
            WaitSeconds(2)
            self.IntelDisables['RadarStealth']['ToggleBit5'] = true
            self.IntelDisables['Cloak']['ToggleBit8'] = true -- not needed after cloakfied fixed
            self:EnableUnitIntel('ToggleBit5', 'RadarStealth')
            self:EnableUnitIntel('ToggleBit8', 'Cloak') -- not needed after cloakfied fixed
        end
        KillThread(self.DelayedCloakThread)
        self.DelayedCloakThread = nil
    end,

}

TypeClass = URL0106