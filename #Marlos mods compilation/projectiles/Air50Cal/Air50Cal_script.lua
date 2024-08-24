# Air Fired 50 Caliber Machine Gun
#
#

local TMachineGunProjectile = import('/lua/terranprojectiles.lua').TMachineGunProjectile
local SinglePolyTrailProjectile = import('/lua/sim/defaultprojectiles.lua').SinglePolyTrailProjectile
local EffectTemplate = import('/lua/EffectTemplates.lua')
EmtBpPath = '/effects/emitters/'

Air50Cal = Class(SinglePolyTrailProjectile) {

    OnCreate = function(self, inWater)
        SinglePolyTrailProjectile.OnCreate(self, inWater)
        if not inWater then
            self:SetDestroyOnWater(true)
        else
            self:ForkThread(self.DestroyOnWaterThread)
        end
    end,
    
    DestroyOnWaterThread = function(self)
        WaitSeconds(0.2)
        self:SetDestroyOnWater(true)
    end,
	
	FxImpactUnit = {
		'/effects/emitters/gauss_cannon_muzzle_flash_01_emit.bp',
		'/effects/emitters/flash_05_emit.bp',
	},
	FxImpactAirUnit = {
		'/effects/emitters/gauss_cannon_muzzle_flash_01_emit.bp',
		'/effects/emitters/flash_05_emit.bp',
	},
    FxImpactProp = {
		'/effects/emitters/gauss_cannon_muzzle_flash_01_emit.bp',
		'/effects/emitters/flash_05_emit.bp',
    },
    FxImpactLand = {
		#EmtBpPath .. 'dirtchunks_01_emit.bp',
		#EmtBpPath .. 'dust_cloud_05_emit.bp',
	
		'/effects/emitters/gauss_cannon_muzzle_flash_01_emit.bp',
		'/effects/emitters/flash_05_flat_emit.bp',
    },
	#RandomPolyTrails = 1,
	#PolyTrailOffset = EffectTemplate.TPlasmaGatlingCannonPolyTrailsOffsets,
	PolyTrail = '/mods/#Marlos mods compilation/effects/emitters/Air50Cal_polytrail_01_emit.bp',
    FxSplatScale = 0.5,
}

TypeClass = Air50Cal

