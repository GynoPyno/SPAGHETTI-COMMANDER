--[[#######################################################################
#  File     :  /hook/lua/modweapons.lua
#  Author(s):  John Comes, David Tomandl, Gordon Duclos
#  Summary  :  Mod specific weapon definitions
#  -----------------------------
#  Modif.by :  Asdrubaelvect
#  Rev.Date :  jj mmmmmm 2009
#  -----------------------------
#  -----------------------------
#  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#######################################################################]]--

local WeaponFile = import('/lua/sim/DefaultWeapons.lua')
local BareBonesWeapon = WeaponFile.BareBonesWeapon
local DefaultProjectileWeapon = WeaponFile.DefaultProjectileWeapon
local DefaultBeamWeapon = WeaponFile.DefaultBeamWeapon

local CollisionBeamFile = import( '/lua/defaultcollisionbeams.lua' )

local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')

TIFCommanderDeathWeapon = Class(BareBonesWeapon) {
    FiringMuzzleBones = {0}, # just fire from the base bone of the unit

    OnCreate = function(self)
        BareBonesWeapon.OnCreate(self)
        local myBlueprint = self:GetBlueprint()
        # The "or x" is supplying default values in case the blueprint doesn't have an overriding value
        self.Data = {
            NukeOuterRingDamage = myBlueprint.NukeOuterRingDamage or 10,
            NukeOuterRingRadius = myBlueprint.NukeOuterRingRadius or 40,
            NukeOuterRingTicks = myBlueprint.NukeOuterRingTicks or 20,
            NukeOuterRingTotalTime = myBlueprint.NukeOuterRingTotalTime or 10,

            NukeInnerRingDamage = myBlueprint.NukeInnerRingDamage or 2000,
            NukeInnerRingRadius = myBlueprint.NukeInnerRingRadius or 30,
            NukeInnerRingTicks = myBlueprint.NukeInnerRingTicks or 24,
            NukeInnerRingTotalTime = myBlueprint.NukeInnerRingTotalTime or 24,
        }
        self:SetWeaponEnabled(false)
    end,

    OnFire = function(self)

    end,

    Fire = function(self)
        local myBlueprint = self:GetBlueprint()
        local myProjectile = self.unit:CreateProjectile( myBlueprint.ProjectileId, 0, 0, 0, nil, nil, nil):SetCollision(false)
        myProjectile:PassDamageData(self:GetDamageTable())
        if self.Data then
            myProjectile:PassData(self.Data)
        end
    end,

}

TSAMLauncher = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.TAAMissileLaunch,
}