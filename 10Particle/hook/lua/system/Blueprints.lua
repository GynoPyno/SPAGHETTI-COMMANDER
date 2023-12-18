local oldModBP = ModBlueprints

#    RegisterGroup(blueprints.Mesh, RegisterMeshBlueprint)
#    RegisterGroup(blueprints.Unit, RegisterUnitBlueprint)
#    RegisterGroup(blueprints.Prop, RegisterPropBlueprint)
#    RegisterGroup(blueprints.Projectile, RegisterProjectileBlueprint)
#    RegisterGroup(blueprints.TrailEmitter, RegisterTrailEmitterBlueprint)
#    RegisterGroup(blueprints.Emitter, RegisterEmitterBlueprint)
#    RegisterGroup(blueprints.Beam, RegisterBeamBlueprint)

function ModBlueprints(all_bps)

	oldModBP(all_bps)

#make all particle systems spawn fewer particles (alot of the particles in supcom are a bit overkill to be honest)
	for id,bp in all_bps.Emitter do

		for i, erc in bp.EmitRateCurve.Keys do

			erc.y = erc.y * 0.1;

			#end

		end

	end

#increase target check interval, may reduce cpu usage (no known side effects so far)
	for id,bp in all_bps.Unit do

		if bp.Weapon then

			for i, wep in bp.Weapon do

				#wep.RenderFireClock = true;

				if wep.TargetCheckInterval then

					wep.TargetCheckInterval = wep.TargetCheckInterval * 2.0;

				end

			end

		end

	end

end