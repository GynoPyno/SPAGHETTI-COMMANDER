UCannon02 = Class(import('/Mods/#Marlos mods compilation/lua/MKDefaultProjectiles.lua').SinglePolyTrailProjectileMK) {
	FxImpactTrajectoryAligned =true,


        FxTrails = {
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_p_01_firecloud_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_p_02_brightglow_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_p_06_glow_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_p_08_shockwave_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_p_09_smoketrail_emit.bp',
        },

        FxImpactUnit = {
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_01_flashflat_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_02_glow_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_03_glowhalf_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_04_sparks_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_05_halfring_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_06_ring_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_07_firecloud_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_08_fwdsparks_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_09_leftoverglows_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_10_leftoverwisps_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_11_darkring_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_12_fwdsmoke_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_13_debris_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_14_lines_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_15_fastdirt_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_16_distortring_emit.bp',
        },
        FxImpactLand = {
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_01_flashflat_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_02_glow_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_03_glowhalf_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_04_sparks_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_05_halfring_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_06_ring_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_07_firecloud_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_08_fwdsparks_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_09_leftoverglows_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_10_leftoverwisps_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_11_darkring_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_12_fwdsmoke_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_13_debris_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_14_lines_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_15_fastdirt_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_16_distortring_emit.bp',
        },
        FxImpactWater = {
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_01_flashflat_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_02_glow_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_03_glowhalf_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_04_sparks_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_05_halfring_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_06_ring_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_07_firecloud_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_08_fwdsparks_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_09_leftoverglows_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_10_leftoverwisps_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_11_darkring_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_12_fwdsmoke_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_13_debris_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_14_lines_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_15_fastdirt_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_16_distortring_emit.bp',
        },
        FxImpactProp = {
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_01_flashflat_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_02_glow_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_03_glowhalf_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_04_sparks_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_05_halfring_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_06_ring_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_07_firecloud_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_08_fwdsparks_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_09_leftoverglows_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_10_leftoverwisps_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_11_darkring_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_12_fwdsmoke_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_13_debris_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_14_lines_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_15_fastdirt_emit.bp',
			'/Mods/#Marlos mods compilation/effects/emitters/w_u_hcn01_i_u_16_distortring_emit.bp',
        },
		
		FxTrailScale = 0.5,
		FxLandHitScale = 0.4,
		FxWaterHitScale = 0.4,
		FxPropHitScale = 0.4,
		FxUnitHitScale = 0.4,
		FxImpactUnderWater = {},
		FxSplatScale = 1,
}
TypeClass = UCannon02