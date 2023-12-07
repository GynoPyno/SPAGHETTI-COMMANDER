#****************************************************************************
#**
#**  File     :  /cdimage/units/UAL0201/UAL0201_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Aeon Light Tank Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local SWalkingLandUnit = import('/lua/seraphimunits.lua').SWalkingLandUnit
local utilities = import('/lua/utilities.lua')
local WeaponsFile = import ('/lua/seraphimweapons.lua')
local TMWeaponsFile = import('/mods/Annihilation New SupCom/lua/TMAeonWeapons.lua')
local SDFExperimentalPhasonProj = WeaponsFile.SDFExperimentalPhasonProj
local SDFUltraChromaticBeamGenerator = WeaponsFile.SDFUltraChromaticBeamGenerator02
local AQuantumBeamGenerator = import('/lua/aeonweapons.lua').AQuantumBeamGenerator
local SDFSinnuntheWeapon = WeaponsFile.SDFSinnuntheWeapon
local TMEffectTemplate = import('/mods/Annihilation New SupCom/lua/TMEffectTemplates.lua')

local TMCSpiderLaserweapon = TMWeaponsFile.TMCSpiderLaserweapon
local SDFUnstablePhasonBeam = import('/lua/seraphimweapons.lua').SDFUnstablePhasonBeam
local EffectTemplate = import('/lua/EffectTemplates.lua')
local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua');
local Armies = ListArmies();
local OmegaIteration = 0
local damage = -4500  --1.st Raw Omega spawn gets this much dmg per second to it  

LED0024 = Class(SWalkingLandUnit) {
    Weapons = {
		TorsoWeapon = Class(SDFExperimentalPhasonProj) {},
        BackTurret1 = Class(TMCSpiderLaserweapon) {
            FxMuzzleFlashScale = 1.4,
        },
        BackTurret2 = Class(TMCSpiderLaserweapon) {
            FxMuzzleFlashScale = 1.4,
        },
        topgun1 = Class(SDFSinnuntheWeapon){},
--        topgun2 = Class(SDFSinnuntheWeapon){},
        LaserL = Class(AQuantumBeamGenerator){                                                    -- CZAR beam
            FxMuzzleFlash = EffectTemplate.SDFExperimentalPhasonProjChargeMuzzleFlash,
                            FxMuzzleFlashScale = 1.8,
        },
        LPhasonBeam = Class(SDFUnstablePhasonBeam) {},
    },       


    OnCreate = function(self)
        SWalkingLandUnit.OnCreate(self)
--        for k, v in EffectTemplate.OthuyAmbientEmanation do
            ------XSL0403
--            CreateAttachedEmitter(self,'TorsoMain', self:GetArmy(), v):ScaleEmitter(2.4)
--        end
        for i, j in EffectTemplate['GenericTeleportCharge01'] do
                self.Trash:Add(CreateAttachedEmitter(self, 'TorsoMain', self:GetArmy(), j):ScaleEmitter(5.5))  
        end
    end,

    OnKilled = function(self, instigator, damagetype, overkillRatio)
        SWalkingLandUnit.OnKilled(self, instigator, damagetype, overkillRatio)
        self:CreatTheEffectsDeath()
    end,

    CreatTheEffectsDeath = function(self)
        local army =  self:GetArmy()
        for k, v in TMEffectTemplate['SerT3SHBMDeath'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'TorsoMain', army, v):ScaleEmitter(2.8))
        end
    end,

    OnDestroy = function(self)
        SWalkingLandUnit.OnDestroy(self)
        -- Don't make the energy being if not built
        if self:GetFractionComplete() ~= 1 then return end
        
        -- Spawn the Energy Being
        local position = self:GetPosition()
        local spiritUnit = CreateUnitHPR('XSL0402', self:GetArmy(), position[1], position[2], position[3], 0, 0, 0)
        local spiritUnit = CreateUnitHPR('XSL0402', self:GetArmy(), position[1], position[2], position[3], 0, 0, 0)
        local spiritUnit = CreateUnitHPR('XSL0402', self:GetArmy(), position[1], position[2], position[3], 0, 0, 0)
        local spiritUnit = CreateUnitHPR('XSL0402', self:GetArmy(), position[1], position[2], position[3], 0, 0, 0)
        local spiritUnit = CreateUnitHPR('XSL0402', self:GetArmy(), position[1], position[2], position[3], 0, 0, 0)

    end,
}
TypeClass = LED0024

