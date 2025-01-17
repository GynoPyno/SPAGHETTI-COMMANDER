#****************************************************************************
#**
#**  File     :  /cdimage/units/URS0303/URS0303_script.lua
#**  Author(s):  David Tomandl, Andres Mendez
#**
#**  Summary  :  Cybran Aircraft Carrier Script
#**
#**  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local AHoverLandUnit = import('/lua/aeonunits.lua').AHoverLandUnit
local ADFQuantumAutogunWeapon = import('/lua/aeonweapons.lua').ADFQuantumAutogunWeapon
local AeonWeapons = import('/lua/aeonweapons.lua')
local AANDepthChargeBombWeapon = AeonWeapons.AANDepthChargeBombWeapon
local AANChronoTorpedoWeapon = AeonWeapons.AANChronoTorpedoWeapon
local AIFQuasarAntiTorpedoWeapon = AeonWeapons.AIFQuasarAntiTorpedoWeapon
local AAMWillOWisp = import('/lua/aeonweapons.lua').AAMWillOWisp
local ADFDisruptorCannonWeapon = import('/lua/aeonweapons.lua').ADFDisruptorWeapon


--Custom files
local NavalCannonOblivionWeapon = import('/lua/aeonweapons.lua').ADFCannonOblivionNaval

URS0303 = Class(AHoverLandUnit) {

    FxDamageScale = 2.5,
	
    Weapons = {
	
        AntiMissile = Class(AAMWillOWisp) {},
        AntiMissile2 = Class(AAMWillOWisp) {},
        Torpedo = Class(AANChronoTorpedoWeapon) {},
        RightRiotgun = Class(ADFQuantumAutogunWeapon) {},
        LeftRiotgun = Class(ADFQuantumAutogunWeapon) {},

        MainGun_01 = Class(ADFDisruptorCannonWeapon) {
            CreateProjectileAtMuzzle = function(self, muzzle)
                local proj = ADFDisruptorCannonWeapon.CreateProjectileAtMuzzle(self, muzzle)
                local data = self:GetBlueprint().DamageToShields
                if proj and not proj:BeenDestroyed() then
                    proj:PassData(data)
                end
            end,
          },
        MainGun_02 = Class(ADFDisruptorCannonWeapon) {
            CreateProjectileAtMuzzle = function(self, muzzle)
                local proj = ADFDisruptorCannonWeapon.CreateProjectileAtMuzzle(self, muzzle)
                local data = self:GetBlueprint().DamageToShields
                if proj and not proj:BeenDestroyed() then
                    proj:PassData(data)
                end
            end,
          },

        RightTurret01 = Class(NavalCannonOblivionWeapon) {},
        RightTurret02 = Class(NavalCannonOblivionWeapon) {},
        LeftTurret01 = Class(NavalCannonOblivionWeapon) {},
        LeftTurret02 = Class(NavalCannonOblivionWeapon) {},
		
    },

}

TypeClass = URS0303

