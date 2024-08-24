-----------------------------------------------------------------
-- File     :  /cdimage/units/UAL0401/UAL0401_script.lua
-- Author(s):  John Comes, Gordon Duclos
-- Summary  :  Aeon Galactic Colossus Script
-- Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
-----------------------------------------------------------------

local AWalkingLandUnit = import('/lua/aeonunits.lua').AWalkingLandUnit
local MobileUnit = import('/lua/defaultunits.lua').MobileUnit
local Weapon = import('/lua/sim/Weapon.lua').Weapon
local CybranWeaponsFile = import('/lua/cybranweapons.lua')
local utilities = import('/lua/utilities.lua')
local explosion = import('/lua/defaultexplosions.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')
local CDFHeavyMicrowaveLaserGeneratorCom = CybranWeaponsFile.CDFHeavyMicrowaveLaserGeneratorCom
local CDFElectronBolterWeapon = CybranWeaponsFile.CDFElectronBolterWeapon

MK69 = Class(AWalkingLandUnit) {

    Weapons = {
        MainGun = Class(CDFHeavyMicrowaveLaserGeneratorCom) {},
        LaserTurret = Class(CDFElectronBolterWeapon) {},
        RightLaserTurret = ClassWeapon(CDFElectronBolterWeapon) {},
        LeftLaserTurret = ClassWeapon(CDFElectronBolterWeapon) {},
    },

    OnKilled = function(self, instigator, type, overkillRatio)
        AWalkingLandUnit.OnKilled(self, instigator, type, overkillRatio)

        local wep = self:GetWeaponByLabel('MainGun')
        local bp = wep:GetBlueprint()
        if bp.Audio.BeamStop then
            wep:PlaySound(bp.Audio.BeamStop)
        end

        if bp.Audio.BeamLoop and wep.Beams[1].Beam then
            wep.Beams[1].Beam:SetAmbientSound(nil, nil)
        end

        for k, v in wep.Beams do
            v.Beam:Disable()
        end
    end,

    DeathThread = function(self, overkillRatio , instigator)
        self:PlayUnitSound('Destroyed')
        explosion.CreateDefaultHitExplosionAtBone(self, 'Turret_02', 4.0)
        explosion.CreateDebrisProjectiles(self, explosion.GetAverageBoundingXYZRadius(self), {self:GetUnitSizes()})
        WaitSeconds(2)
        explosion.CreateDefaultHitExplosionAtBone(self, 'Leg_03_03', 1.0)
        WaitSeconds(0.1)
        explosion.CreateDefaultHitExplosionAtBone(self, 'Leg_02_02', 1.0)
        WaitSeconds(0.1)
        explosion.CreateDefaultHitExplosionAtBone(self, 'Leg_04_02', 1.0)
        WaitSeconds(0.3)
        explosion.CreateDefaultHitExplosionAtBone(self, 'Leg_02_02', 1.0)
        explosion.CreateDefaultHitExplosionAtBone(self, 'Leg_03_03', 1.0)

        WaitSeconds(3.5)
        explosion.CreateDefaultHitExplosionAtBone(self, 'Turret_02', 5.0)

        if self.DeathAnimManip then
            WaitFor(self.DeathAnimManip)
        end

        local bp = self:GetBlueprint()
        local position = self:GetPosition()
        local qx, qy, qz, qw = unpack(self:GetOrientation())
        local a = math.atan2(2.0 * (qx * qz + qw * qy), qw * qw + qx * qx - qz * qz - qy * qy)
        for i, numWeapons in bp.Weapon do
            if bp.Weapon[i].Label == 'CollossusDeath' then
                position[3] = position[3]+5*math.cos(a)
                position[1] = position[1]+5*math.sin(a)
                DamageArea(self, position, bp.Weapon[i].DamageRadius, bp.Weapon[i].Damage, bp.Weapon[i].DamageType, bp.Weapon[i].DamageFriendly)
                break
            end
        end

        self:DestroyAllDamageEffects()
        self:CreateWreckage(overkillRatio)

        -- CURRENTLY DISABLED UNTIL DESTRUCTION
        -- Create destruction debris out of the mesh, currently these projectiles look like crap,
        -- since projectile rotation and terrain collision doesn't work that great. These are left in
        -- hopes that this will look better in the future.. =)
        if self.ShowUnitDestructionDebris and overkillRatio then
            if overkillRatio <= 1 then
                self.CreateUnitDestructionDebris(self, true, true, false)
            elseif overkillRatio <= 2 then
                self.CreateUnitDestructionDebris(self, true, true, false)
            elseif overkillRatio <= 3 then
                self.CreateUnitDestructionDebris(self, true, true, true)
                self.CreateUnitDestructionDebris(self, true, true, true)
            else -- Vaporized
                self.CreateUnitDestructionDebris(self, true, true, true)
            end
        end

        self:Destroy()
    end,
}

TypeClass = MK69
