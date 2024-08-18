#****************************************************************************
#**
#**  File     :  /cdimage/units/OEL0402/OEL0402_script.lua
#**  Author(s):  John Comes, David Tomandl, Gordon Duclos
#**
#**  Summary  :  UEF Mobile Factory Script
#**
#**  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

# This unit needs to not be allowed to build while underwater
# Additionally, if it goes underwater while building it needs to cancel the
#   current order

local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local TDFHeavyPlasmaCannonWeapon = WeaponsFile.TDFHeavyPlasmaCannonWeapon
local TDFHiroPlasmaCannon = WeaponsFile.TDFHiroPlasmaCannon
local TIFArtilleryWeapon = import('/lua/terranweapons.lua').TIFArtilleryWeapon
local TIFCruiseMissileLauncher = WeaponsFile.TIFCruiseMissileLauncher
local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')
local CreateUEFBuildSliceBeams = EffectUtil.CreateUEFBuildSliceBeams

OEL0402 = Class(TLandUnit) {
    Weapons = {
        MainTurret = Class(TDFGaussCannonWeapon) {},
        RightPlasma01 = Class(TDFHeavyPlasmaCannonWeapon) {},
        RightPlasma02 = Class(TDFHeavyPlasmaCannonWeapon) {},
        RightPlasma03 = Class(TDFHeavyPlasmaCannonWeapon) {},
        RightPlasma04 = Class(TDFHeavyPlasmaCannonWeapon) {},
        RightPlasma05 = Class(TDFHeavyPlasmaCannonWeapon) {},
        LeftPlasma01 = Class(TDFHeavyPlasmaCannonWeapon) {},
        LeftPlasma02 = Class(TDFHeavyPlasmaCannonWeapon) {},
        LeftPlasma03 = Class(TDFHeavyPlasmaCannonWeapon) {},
        LeftPlasma04 = Class(TDFHeavyPlasmaCannonWeapon) {},
        LeftPlasma05 = Class(TDFHeavyPlasmaCannonWeapon) {},
        LeftEnergyLance01 = Class(TDFHiroPlasmaCannon) {},
        LeftEnergyLance02 = Class(TDFHiroPlasmaCannon) {},
        LeftEnergyLance03 = Class(TDFHiroPlasmaCannon) {},
        RightEnergyLance01 = Class(TDFHiroPlasmaCannon) {},
        RightEnergyLance02 = Class(TDFHiroPlasmaCannon) {},
        RightEnergyLance03 = Class(TDFHiroPlasmaCannon) {},
        ArtyGun1 = Class(TIFArtilleryWeapon) {},
        ArtyGun2 = Class(TIFArtilleryWeapon) {},
        ArtyGun3 = Class(TIFArtilleryWeapon) {},
        ArtyGun4 = Class(TIFArtilleryWeapon) {},
        ArtyGun5 = Class(TIFArtilleryWeapon) {},
        ArtyGun6 = Class(TIFArtilleryWeapon) {},
        MissileWeapon1 = Class(TIFCruiseMissileLauncher) {},
        MissileWeapon2 = Class(TIFCruiseMissileLauncher) {},
    },
    
    OnCreate = function(self)
        TLandUnit.OnCreate(self)
        self:SetWeaponEnabledByLabel('MissileWeapon2', false)
    end,
    
    OnScriptBitSet = function(self, bit)
        TLandUnit.OnScriptBitSet(self, bit)
        if bit == 1 then 
            self:SetWeaponEnabledByLabel('MissileWeapon2', true)
            self:SetWeaponEnabledByLabel('MissileWeapon1', false)
        end
    end,

    OnScriptBitClear = function(self, bit)
        TLandUnit.OnScriptBitClear(self, bit)
        if bit == 1 then 
            self:SetWeaponEnabledByLabel('MissileWeapon2', false)
            self:SetWeaponEnabledByLabel('MissileWeapon1', true)
        end
    end,



}

TypeClass = OEL0402