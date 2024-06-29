#****************************************************************************
#**
#**  File     :  /cdimage/units/URL0402/URL0402_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix, Gordon Duclos
#**
#**  Summary  :  Cybran Spider Bot Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local CWalkingLandUnit = import( '/lua/cybranunits.lua').CWalkingLandUnit
local CybranWeaponsFile = import( '/lua/cybranweapons.lua')
local CybranWeaponsFile2 = import('/lua/cybranweapons.lua')
local CDFHeavyMicrowaveLaserGeneratorDefense = CybranWeaponsFile.CDFHeavyMicrowaveLaserGeneratorDefense
local CDFHvyProtonCannonWeapon = CybranWeaponsFile2.CDFHvyProtonCannonWeapon
local CDFElectronBolterWeapon = CybranWeaponsFile2.CDFElectronBolterWeapon
local CAAMissileNaniteWeapon = CybranWeaponsFile2.CAAMissileNaniteWeapon

URL0403 = Class(CWalkingLandUnit) {

 Weapons = {
        MainGun = Class(CDFHeavyMicrowaveLaserGeneratorDefense) {},
        ParticleGun = Class(CDFHvyProtonCannonWeapon) {},
        LaserTurretI = Class(CDFElectronBolterWeapon) {},
        LaserTurretII = Class(CDFElectronBolterWeapon) {},
        ParticleGunG = Class(CDFHvyProtonCannonWeapon) {},
        ParticleGunD = Class(CDFHvyProtonCannonWeapon) {},
        LaserTurretIII = Class(CDFElectronBolterWeapon) {},
        LaserTurretIV = Class(CDFElectronBolterWeapon) {},
        LaserTurretV = Class(CDFElectronBolterWeapon) {},
        LaserTurretVI = Class(CDFElectronBolterWeapon) {},
        LaserTurretVII = Class(CDFElectronBolterWeapon) {},
        LaserTurretVIII = Class(CDFElectronBolterWeapon) {},
        AntiAirMissileI = Class(CAAMissileNaniteWeapon) {},
        AntiAirMissileII = Class(CAAMissileNaniteWeapon) {},
        AntiAirMissileIII = Class(CAAMissileNaniteWeapon) {},
        AntiAirMissileIV = Class(CAAMissileNaniteWeapon) {},
    },
    

    OnStartBeingBuilt = function(self, builder, layer)
        CWalkingLandUnit.OnStartBeingBuilt(self, builder, layer)
        if not self.AnimationManipulator then
            self.AnimationManipulator = CreateAnimator(self)
            self.Trash:Add(self.AnimationManipulator)
        end
        self.AnimationManipulator:PlayAnim(self:GetBlueprint().Display.AnimationActivate, false):SetRate(0)
    end,
     
    OnStopBeingBuilt = function(self,builder,layer)
        CWalkingLandUnit.OnStopBeingBuilt(self,builder,layer)
        if self.AnimationManipulator then
            self:SetUnSelectable(true)
            self.AnimationManipulator:SetRate(0.7)
            self:ForkThread(function()
                WaitSeconds(self.AnimationManipulator:GetAnimationDuration()*self.AnimationManipulator:GetRate())
                self:SetUnSelectable(false)
                self.AnimationManipulator:Destroy()
            end)
        end        
        self:SetMaintenanceConsumptionActive()
        local layer = self:GetCurrentLayer()
        self.WeaponsEnabled = true
    end,    
    
    
}

TypeClass = URL0403
