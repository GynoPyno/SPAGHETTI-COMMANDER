#****************************************************************************
#**
#**  File     :  /lua/terranweapons.lua
#**  Author(s):  John Comes, David Tomandl, Gordon Duclos
#**
#**  Summary  :  Terran-specific weapon definitions
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

TDFAntiShipGaussCannonWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = EffectTemplate.TShipGaussCannonFlash,
}

TIFCarpetBombNextWarsWeapon = Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = {'/effects/emitters/antiair_muzzle_fire_02_emit.bp',},

}

TATMachineGunWeapon= Class(DefaultProjectileWeapon) {
    FxMuzzleFlash = {
        '/effects/emitters/machinegun_muzzle_fire_01_emit.bp',
        '/effects/emitters/machinegun_muzzle_fire_02_emit.bp',
    },
}
