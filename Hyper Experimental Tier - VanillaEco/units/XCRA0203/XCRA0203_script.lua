#****************************************************************************
#**
#**  File     :  /cdimage/units/URA0203/URA0203_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Cybran Gunship Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CAirUnit = import('/lua/cybranunits.lua').CAirUnit
local CybranWeaponsFile = import('/lua/cybranweapons.lua')
local CDFHeavyMicrowaveLaserGeneratorCom = CybranWeaponsFile.CDFHeavyMicrowaveLaserGeneratorCom

XCRA0203 = Class(CAirUnit) {
    Weapons = {
        Gun1 = Class(CDFHeavyMicrowaveLaserGeneratorCom) {},
		Gun2 = Class(CDFHeavyMicrowaveLaserGeneratorCom) {},
        Gun3 = Class(CDFHeavyMicrowaveLaserGeneratorCom) {},
        Gun4 = Class(CDFHeavyMicrowaveLaserGeneratorCom) {},
		},

	    OnKilled = function(self, instigator, type, overkillRatio)
        self.detector = CreateCollisionDetector(self)
        self.Trash:Add(self.detector)
        self.detector:WatchBone('XCRA0203')
        self.detector:WatchBone('B01')
        self.detector:WatchBone('Exhaust_Left')
        self.detector:WatchBone('Exhaust_Right')
        self.detector:WatchBone('Right_Projectile')
        self.detector:WatchBone('Left_Projectile')
        self.detector:WatchBone('Right_Projectile.001')
        self.detector:WatchBone('Left_Projectile.001')

        self.detector:EnableTerrainCheck(true)
        self.detector:Enable()
    end,
	    OnKilled = function(self, instigator, type, overkillRatio)
        AAirUnit.OnKilled(self, instigator, type, overkillRatio)
        local wep = self:GetWeaponByLabel('RightGun','LeftGun')
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

    OnAnimTerrainCollision = function(self, bone,x,y,z)
        DamageArea(self, {x,y,z}, 5, 1000, 'Default', true, false)
        explosion.CreateDefaultHitExplosionAtBone(self, bone, 5.0)
        explosion.CreateDebrisProjectiles(self, explosion.GetAverageBoundingXYZRadius(self), {self:GetUnitSizes()})
    end,


OnMotionVertEventChange = function(self, new, old)
        CAirUnit.OnMotionVertEventChange(self, new, old)

        # We want to keep the ambient sound of the rotor
        # playing during the landing sequence
        if (new == 'Down') then
            # Keep the ambient hover sound going
            self:PlayUnitAmbientSound('AmbientMove')
        end

        if new == 'Bottom' then
            #KillThread( self.TakingOffThread )
            #self:SetImmobile(false)

            #if(self.Rotator) then
            #    self.Rotator:SetSpinDown(true):SetTargetSpeed(0):SetAccel(180)
            #end
            # Turn off the ambient hover sound
            self:StopUnitAmbientSound( 'AmbientMove' )
        end

        #if old == 'Bottom' then
        #    self.TakingOffThread = ForkThread(self.TakingOff, self)
        #end
    end,

    #TakingOff = function(self)
    #    self:SetImmobile(true)
    #    self.Rotator:SetSpinDown(false):SetTargetSpeed(1000):SetAccel(500)
    #    WaitFor(self.Rotator)
    #    self:SetImmobile(false)
    #end,
}

TypeClass = XCRA0203
