--[[#######################################################################
#  File     :  /hook/lua/seraphweapons.lua
#  Author(s):  Greg Kohne, Gordon Duclos, Matt Vainio, Aaron Lundquist,
#                          Dru Staltman, Jessica St. Croix
#  Summary  :  Definitions of Seraphim Weapons for the Mod Exp Wars
#  -----------------------------
#  Modif.by :  AsdrubaelVect
#  Rev.Date :  5 septembre 2009
#  -----------------------------
#  Revis.by :  Manimal -> Restructuration
#  Rev.Date :  07 avril 2010
#  -----------------------------
#  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#######################################################################]]--

local Weapons = import( '/lua/sim/DefaultWeapons.lua' )
local DefaultBeamWeapon = Weapons.DefaultBeamWeapon
local DefaultProjectileWeapon = Weapons.DefaultProjectileWeapon
local CollisionBeams = import( '/lua/defaultcollisionbeams.lua' )
local EffectTemplate = import( '/lua/EffectTemplates.lua' )

SDFHeavyQuarnon01Cannon = Class( DefaultProjectileWeapon ) {
	FxMuzzleFlash = EffectTemplate.SHeavyQuarnonCannonMuzzleFlash,
}

SDFUltraChromaticBeamGenerator = Class( DefaultBeamWeapon ) {
    BeamType = CollisionBeams.UnstablePhasonLaserCollisionBeam,
	FxBeamTypeScale = 0.1,
    FxMuzzleFlash = {},
	FxMuzzleFlashScale = 0.1,
    FxChargeMuzzleFlash = {},
	FxChargeMuzzleFlashScale = 0.1,
    FxUpackingChargeEffects = EffectTemplate.SChargeUltraChromaticBeamGenerator,
    FxUpackingChargeEffectScale = 0.1,
    FxChargeMuzzleFlashScale = 0.1,
	ChargeEffectMuzzlesScale = 0.1,

    PlayFxWeaponUnpackSequence = function( self )
        if not self.ContBeamOn then
            local army = self.unit:GetArmy()
            local bp = self:GetBlueprint()
            for k, v in self.FxUpackingChargeEffects do
                for ek, ev in bp.RackBones[self.CurrentRackSalvoNumber].MuzzleBones do
                    CreateAttachedEmitter( self.unit, ev, army, v ):ScaleEmitter( self.FxUpackingChargeEffectScale )
                end
            end
            DefaultBeamWeapon.PlayFxWeaponUnpackSequence( self )
        end
    end,
}
