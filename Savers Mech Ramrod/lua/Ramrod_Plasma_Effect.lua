#****************************************************************************
#**
#**  File     :  /data/lua/EffectTemplates.lua
#**  Author(s):  Gordon Duclos, Greg Kohne, Matt Vainio, Aaron Lundquist
#**
#**  Summary  :  Generic templates for commonly used effects
#**
#**  Copyright © 2006 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
TableCat = import('utilities.lua').TableCat
EmtBpPath = '/mods/Savers Mech Ramrod/effects/emitters/'
EmitterTempEmtBpPath = '/effects/emitters/temp/'


# For gatling gun cooldown
WeaponSteam01 = {
    EmtBpPath .. 'weapon_mist_01_emit.bp',
}


#---------------------------------------------------------------
# Concussion Ring Effects
#---------------------------------------------------------------
ConcussionRingSml01 = { EmtBpPath .. 'destruction_explosion_concussion_ring_02_emit.bp',}
ConcussionRingMed01 = { EmtBpPath .. 'destruction_explosion_concussion_ring_01_emit.bp',}
ConcussionRingLrg01 = { EmtBpPath .. 'destruction_explosion_concussion_ring_01_emit.bp',}


#---------------------------------------------------------------
# Fire Cloud Effects
#---------------------------------------------------------------
FireCloudSml01 = {
    EmtBpPath .. 'fire_cloud_05_emit.bp',
    EmtBpPath .. 'fire_cloud_04_emit.bp',
}

FireCloudMed01 = {
    EmtBpPath .. 'fire_cloud_06_emit.bp',
    EmtBpPath .. 'explosion_fire_sparks_01_emit.bp',
}


#---------------------------------------------------------------
# FireShadow Faked Flat Particle Effects
#---------------------------------------------------------------
FireShadowSml01 = { EmtBpPath .. 'destruction_explosion_fire_shadow_02_emit.bp',}
FireShadowMed01 = { EmtBpPath .. 'destruction_explosion_fire_shadow_01_emit.bp',}
FireShadowLrg01 = { EmtBpPath .. 'destruction_explosion_fire_shadow_01_emit.bp',}


#---------------------------------------------------------------
# Flash Effects
#---------------------------------------------------------------
FlashSml01 = { EmtBpPath .. 'flash_01_emit.bp',}


#---------------------------------------------------------------
# Flare Effects
#---------------------------------------------------------------
FlareSml01 = { EmtBpPath .. 'flare_01_emit.bp',}


#---------------------------------------------------------------
# Smoke Effects
#---------------------------------------------------------------
SmokeSml01 = { EmtBpPath .. 'destruction_explosion_smoke_02_emit.bp',}
SmokeMed01 = { EmtBpPath .. 'destruction_explosion_smoke_04_emit.bp',}
SmokeLrg01 = { 
    EmtBpPath .. 'destruction_explosion_smoke_03_emit.bp',
    EmtBpPath .. 'destruction_explosion_smoke_07_emit.bp',
}

SmokePlumeLightDensityMed01 = { EmtBpPath .. 'destruction_explosion_smoke_08_emit.bp',}
SmokePlumeMedDensitySml01 = { EmtBpPath .. 'destruction_explosion_smoke_06_emit.bp',}
SmokePlumeMedDensitySml02 = { EmtBpPath .. 'destruction_explosion_smoke_05_emit.bp',}
SmokePlumeMedDensitySml03 = { EmtBpPath .. 'destruction_explosion_smoke_11_emit.bp',}


#---------------------------------------------------------------
# Wreckage Smoke Effects
#---------------------------------------------------------------
DefaultWreckageEffectsSml01 = TableCat( SmokePlumeLightDensityMed01, SmokePlumeMedDensitySml01, SmokePlumeMedDensitySml02, SmokePlumeMedDensitySml03 ) 
DefaultWreckageEffectsMed01 = TableCat( SmokePlumeLightDensityMed01, SmokePlumeMedDensitySml01, SmokePlumeMedDensitySml02, SmokePlumeMedDensitySml03 )
DefaultWreckageEffectsLrg01 = TableCat( SmokePlumeLightDensityMed01, SmokePlumeMedDensitySml01, SmokePlumeMedDensitySml02, SmokePlumeMedDensitySml01, SmokePlumeMedDensitySml02, SmokePlumeMedDensitySml01, SmokePlumeMedDensitySml02, SmokePlumeMedDensitySml03 )


#---------------------------------------------------------------
# Explosion Debris Effects
#--------------------------------------------------------------- 
ExplosionDebrisSml01 = {
    EmtBpPath .. 'destruction_explosion_debris_07_emit.bp',
    EmtBpPath .. 'destruction_explosion_debris_08_emit.bp',
    EmtBpPath .. 'destruction_explosion_debris_09_emit.bp',
}
ExplosionDebrisMed01 = {
    EmtBpPath .. 'destruction_explosion_debris_10_emit.bp',
    EmtBpPath .. 'destruction_explosion_debris_11_emit.bp',
    EmtBpPath .. 'destruction_explosion_debris_12_emit.bp',
}
ExplosionDebrisLrg01 = {
    EmtBpPath .. 'destruction_explosion_debris_01_emit.bp',
    EmtBpPath .. 'destruction_explosion_debris_02_emit.bp',
    EmtBpPath .. 'destruction_explosion_debris_03_emit.bp',
}


#---------------------------------------------------------------
# Explosion Effects
#---------------------------------------------------------------
ExplosionEffectsSml01 = TableCat( FireShadowSml01, FlareSml01, FireCloudSml01, ExplosionDebrisSml01 )
ExplosionEffectsMed01 = TableCat( FireShadowMed01, SmokeMed01, FireCloudMed01, ExplosionDebrisMed01 )
ExplosionEffectsLrg01 = TableCat( FireShadowLrg01, SmokeLrg01, ExplosionDebrisLrg01 )
ExplosionEffectsDefault01 = ExplosionEffectsMed01

DefaultHitExplosion01 = TableCat( FireCloudMed01, FlashSml01, FlareSml01, SmokeSml01 )
DefaultHitExplosion02 = TableCat( FireCloudSml01, FlashSml01, FlareSml01, SmokeSml01 )

ExplosionEffectsLrg02 = {
	EmtBpPath .. 'destruction_explosion_flash_04_emit.bp',
	EmtBpPath .. 'destruction_explosion_flash_05_emit.bp',
}


#---------------------------------------------------------------
# Ambient and Weather Effects
#---------------------------------------------------------------
WeatherTwister = {
    EmtBpPath .. 'weather_twister_01_emit.bp',
    EmtBpPath .. 'weather_twister_02_emit.bp',
    EmtBpPath .. 'weather_twister_03_emit.bp',
    EmtBpPath .. 'weather_twister_04_emit.bp',
}

#---------------------------------------------------------------
# Operation Effects
#---------------------------------------------------------------
op_cratersmoke_01 = {
    EmtBpPath .. 'op_cratersmoke_01_emit.bp',
}

op_waterbubbles_01 = {
    EmtBpPath .. 'quarry_water_bubbles_emit.bp',
}

op_fire_01 = {
    EmtBpPath .. 'op_ambient_fire_01_emit.bp',
    EmtBpPath .. 'op_ambient_fire_02_emit.bp',
    EmtBpPath .. 'op_ambient_fire_03_emit.bp',
    EmtBpPath .. 'op_ambient_fire_04_emit.bp',
    EmtBpPath .. 'op_ambient_fire_05_emit.bp',
}

#---------------------------------------------------------------
# Default Projectile Impact Effects
#---------------------------------------------------------------
DefaultMissileHit01 = TableCat( FireCloudSml01, FlashSml01, FlareSml01 )
DefaultProjectileAirUnitImpact = {
    EmtBpPath .. 'destruction_unit_hit_flash_01_emit.bp',
    EmtBpPath .. 'destruction_unit_hit_shrapnel_01_emit.bp',
}
DefaultProjectileLandImpact = {
    EmtBpPath .. 'projectile_dirt_impact_small_01_emit.bp',
    EmtBpPath .. 'projectile_dirt_impact_small_02_emit.bp',
    EmtBpPath .. 'projectile_dirt_impact_small_03_emit.bp',
    EmtBpPath .. 'projectile_dirt_impact_small_04_emit.bp',
}
DefaultProjectileLandUnitImpact = {
    EmtBpPath .. 'destruction_unit_hit_flash_01_emit.bp',
    EmtBpPath .. 'destruction_unit_hit_shrapnel_01_emit.bp',
}
DefaultProjectileWaterImpact = {
    EmtBpPath .. 'destruction_water_splash_ripples_01_emit.bp',
    EmtBpPath .. 'destruction_water_splash_wash_01_emit.bp',
    EmtBpPath .. 'destruction_water_splash_plume_01_emit.bp',
}
DefaultProjectileUnderWaterImpact = {
    EmtBpPath .. 'destruction_underwater_explosion_flash_01_emit.bp',
    EmtBpPath .. 'destruction_underwater_explosion_flash_02_emit.bp',
    EmtBpPath .. 'destruction_underwater_explosion_splash_01_emit.bp',
}
DustDebrisLand01 = {
    EmtBpPath .. 'dust_cloud_02_emit.bp',
    EmtBpPath .. 'dust_cloud_04_emit.bp',
    EmtBpPath .. 'destruction_explosion_debris_04_emit.bp',
    EmtBpPath .. 'destruction_explosion_debris_05_emit.bp',
}
GenericDebrisLandImpact01 = {
    EmtBpPath .. 'dirtchunks_01_emit.bp',
    EmtBpPath .. 'dust_cloud_05_emit.bp',
}
GenericDebrisTrails01 = { EmtBpPath .. 'destruction_explosion_debris_trail_01_emit.bp',}
UnitHitShrapnel01 = { EmtBpPath .. 'destruction_unit_hit_shrapnel_01_emit.bp',}
WaterSplash01 = { 
    EmtBpPath .. 'water_splash_ripples_ring_01_emit.bp',
    EmtBpPath .. 'water_splash_plume_01_emit.bp',
}


#---------------------------------------------------------------
# Default Unit Damage Effects
#---------------------------------------------------------------
DamageSmoke01 = { EmtBpPath .. 'destruction_damaged_smoke_01_emit.bp',}
DamageSparks01 = { EmtBpPath .. 'destruction_damaged_sparks_01_emit.bp',}
DamageFire01 = {
	EmtBpPath .. 'destruction_damaged_fire_01_emit.bp',
	EmtBpPath .. 'destruction_damaged_fire_distort_01_emit.bp',
}
DamageFireSmoke01 = TableCat( DamageSmoke01, DamageFire01 )

DamageStructureSmoke01 = { EmtBpPath .. 'destruction_damaged_smoke_02_emit.bp',}
DamageStructureFire01 = {
	EmtBpPath .. 'destruction_damaged_fire_02_emit.bp',
	EmtBpPath .. 'destruction_damaged_fire_03_emit.bp',
	EmtBpPath .. 'destruction_damaged_fire_distort_02_emit.bp',
}
DamageStructureSparks01 = { EmtBpPath .. 'destruction_damaged_sparks_01_emit.bp',}
DamageStructureFireSmoke01 = TableCat( DamageStructureSmoke01, DamageStructureFire01 )

#---------------------------------------------------------------
# Ambient effects
#---------------------------------------------------------------
TreeBurning01 = TableCat( DamageFire01 ,{EmtBpPath .. 'forest_fire_smoke_01_emit.bp'} )


#---------------------------------------------------------------
# Shield Impact effects
#---------------------------------------------------------------
AeonShieldHit01 = {
	EmtBpPath .. '_test_shield_impact_emit.bp',
}
CybranShieldHit01 = {
	EmtBpPath .. '_test_shield_impact_emit.bp',
}    
UEFShieldHit01 = {
	#EmtBpPath .. 'shield_impact_terran_01_emit.bp',
	#EmtBpPath .. 'shield_impact_terran_02_emit.bp',
	#EmtBpPath .. 'shield_impact_terran_03_emit.bp',
	EmtBpPath .. '_test_shield_impact_emit.bp',
}
UEFAntiArtilleryShieldHit01 = {
	EmtBpPath .. 'shield_impact_large_01_emit.bp',
}
SeraphimShieldHit01 = {
	EmtBpPath .. '_test_shield_impact_emit.bp',
}

SeraphimSubCommanderGateway01 = {
	EmtBpPath .. 'seraphim_gate_01_emit.bp',
    #EmtBpPath .. 'seraphim_gate_02_emit.bp',
    #EmtBpPath .. 'seraphim_gate_03_emit.bp',
}

SeraphimSubCommanderGateway02 = {
	EmtBpPath .. 'seraphim_gate_04_emit.bp',
    EmtBpPath .. 'seraphim_gate_05_emit.bp',
}

SeraphimSubCommanderGateway03 = {
    EmtBpPath .. 'seraphim_gate_06_emit.bp',
}

SeraphimAirStagePlat01 = {
    EmtBpPath .. 'seraphim_airstageplat_01_emit.bp',
}

SeraphimAirStagePlat02 = {
    EmtBpPath .. 'seraphim_airstageplat_02_emit.bp',
}

#------------------------------------------------------------------------
#  TERRAN HEAVY PLASMA CANNON EMITTERS
#------------------------------------------------------------------------
TPlasmaCannonHeavyMuzzleFlash = {
    '/effects/emitters/plasma_cannon_muzzle_flash_01_emit.bp',
    '/effects/emitters/plasma_cannon_muzzle_flash_02_emit.bp',
    '/effects/emitters/cannon_muzzle_flash_01_emit.bp',
    '/effects/emitters/heavy_plasma_cannon_hitunit_05_emit.bp',
}
TPlasmaCannonHeavyHit02 = {
    EmtBpPath .. 'uef_t2_artillery_hit_01_emit.bp',
    EmtBpPath .. 'uef_t2_artillery_hit_02_emit.bp',
	EmtBpPath .. 'uef_t2_artillery_hit_03_emit.bp',
    EmtBpPath .. 'uef_t2_artillery_hit_04_emit.bp',
    EmtBpPath .. 'uef_t2_artillery_hit_05_emit.bp',
    EmtBpPath .. 'uef_t2_artillery_hit_06_emit.bp',
    EmtBpPath .. 'uef_t2_artillery_hit_07_emit.bp',	
}
TPlasmaCannonHeavyHit03 = {
    EmtBpPath .. 'heavy_plasma_cannon_hit_05_emit.bp',
}
TPlasmaCannonHeavyHit04 = {
    EmtBpPath .. 'heavy_plasma_cannon_hitunit_05_emit.bp',
}
TPlasmaCannonHeavyHit01 = TableCat( TPlasmaCannonHeavyHit02, TPlasmaCannonHeavyHit03 )
TPlasmaCannonHeavyHitUnit01 = TableCat( TPlasmaCannonHeavyHit02, TPlasmaCannonHeavyHit04, UnitHitShrapnel01 )

TPlasmaCannonHeavyMunition = {
    EmtBpPath .. 'plasma_cannon_trail_02_emit.bp',
}
TPlasmaCannonHeavyMunition02 = {
    EmtBpPath .. 'plasma_cannon_trail_03_emit.bp',
}
TPlasmaCannonHeavyPolyTrails = {
    EmtBpPath .. 'plasma_cannon_polytrail_02_emit.bp',
}





