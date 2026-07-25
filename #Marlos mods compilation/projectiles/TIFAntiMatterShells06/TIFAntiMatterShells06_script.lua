#
# UEF Anti-Matter Shells
#
local TArtilleryAntiMatterProjectile = import('/Mods/#Marlos mods compilation/lua/MKProjectiles.lua').TArtilleryAntiMatterProjectile06

TIFAntiMatterShells06 = Class(TArtilleryAntiMatterProjectile) {

    FxAirUnitHitScale = 1.4,
    FxLandHitScale = 1.4,
    FxNoneHitScale = 1.4,
    FxPropHitScale = 1.4,
    FxProjectileHitScale = 1.4,
    FxProjectileUnderWaterHitScale = 1.4,
    FxShieldHitScale = 1.4,
    FxUnderWaterHitScale = 1.4,
    FxUnitHitScale = 1.4,
    FxWaterHitScale = 0.25,
    FxOnKilledScale = 1.4,
	
}

TypeClass = TIFAntiMatterShells06