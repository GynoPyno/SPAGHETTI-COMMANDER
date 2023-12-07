TableCat = import('/lua/utilities.lua').TableCat
EmtBpPath = '/mods/Annihilation New SupCom/effects/Emitters/'
OldEmtBpPath = '/effects/emitters/'


#------------------------------------------------------------------------
#  SERAPHIM AIRE-AU AUTOCANNON
#------------------------------------------------------------------------
MultiGunWeaponPolytrails01 = {
    EmtBpPath .. 'ZCannon_polytrail_01_emit.bp',
}

MultiGunWeaponMuzzleFlash = {
    EmtBpPath .. 'seraphim_lightning_hit_01_emit.bp',
    EmtBpPath .. 'seraphim_lightning_hit_02_emit.bp',
    EmtBpPath .. 'seraphim_lightning_hit_03_emit.bp',
}

MultiGunWeaponHit01 = {
    EmtBpPath .. 'seraphim_experimental_phasonproj_hit_01_emit.bp',
    EmtBpPath .. 'seraphim_experimental_phasonproj_hit_02_emit.bp',
    EmtBpPath .. 'seraphim_experimental_phasonproj_hit_03_emit.bp',
    EmtBpPath .. 'seraphim_experimental_phasonproj_hit_04_emit.bp',
    EmtBpPath .. 'seraphim_experimental_phasonproj_hit_05_emit.bp',
}

MultiGunWeaponHit02 = {
    EmtBpPath .. 'seraphim_experimental_phasonproj_hit_04_emit.bp',
    EmtBpPath .. 'seraphim_experimental_phasonproj_hit_05_emit.bp',
}

UnitHitShrapnel01 = { OldEmtBpPath .. 'destruction_unit_hit_shrapnel_01_emit.bp',}
MultigunWeaponHitUnit = TableCat( MultiGunWeaponHit01, MultiGunWeaponHit02, UnitHitShrapnel01)