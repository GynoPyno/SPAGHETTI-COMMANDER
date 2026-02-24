TableCat = import('/lua/utilities.lua').TableCat
EmtBpPath = '/mods/Antares Unit Pack/effects/Emitters/'
OldEmtBpPath = '/effects/emitters/'


#------------------------------------------------------------------------
#  SERAPHIM AIRE-AU AUTOCANNON
#------------------------------------------------------------------------
MultiGunWeaponPolytrails01 = {
    EmtBpPath .. 'seraphim_multigun_autocannon_polytrail_01_emit.bp', 
}

MultiGunWeaponMuzzleFlash = {
    EmtBpPath .. 'seraphim_multigun_autocannon_muzzle_flash_01_emit.bp',
    EmtBpPath .. 'seraphim_multigun_autocannon_muzzle_flash_02_emit.bp',
    EmtBpPath .. 'seraphim_multigun_autocannon_muzzle_flash_03_emit.bp',
}

MultiGunWeaponHit01 = {
    EmtBpPath .. 'seraphim_multigun_autocannon_hit_01_emit.bp',
    EmtBpPath .. 'seraphim_multigun_autocannon_hit_02_emit.bp',
    EmtBpPath .. 'seraphim_multigun_autocannon_hit_03_emit.bp',
    EmtBpPath .. 'seraphim_multigun_autocannon_hit_04_emit.bp',
    EmtBpPath .. 'seraphim_multigun_autocannon_hit_05_emit.bp',
}

MultiGunWeaponHit02 = {
    EmtBpPath .. 'seraphim_multigun_autocannon_hitunit_04_emit.bp',
    EmtBpPath .. 'seraphim_multigun_autocannon_hitunit_05_emit.bp',
}

UnitHitShrapnel01 = { OldEmtBpPath .. 'destruction_unit_hit_shrapnel_01_emit.bp',}
MultigunWeaponHitUnit = TableCat( MultiGunWeaponHit01, MultiGunWeaponHit02, UnitHitShrapnel01)