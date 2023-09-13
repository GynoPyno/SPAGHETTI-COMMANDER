function CreateCybranBuildBeams( builder, unitBeingBuilt, BuildEffectBones, BuildEffectsBag )
    local army = builder:GetArmy()
    local BeamBuildEmtBp = '/effects/emitters/build_beam_02_emit.bp'
    local ox, oy, oz = unpack(unitBeingBuilt:GetPosition())


    if BuildEffectBones then
        for _, BuildBone in BuildEffectBones do
			local beamEffect = AttachBeamEntityToEntity(builder, BuildBone, unitBeingBuilt, -1, army, BeamBuildEmtBp)
            BuildEffectsBag:Add(beamEffect)
        end
    end
end

function SpawnBuildBots( builder, unitBeingBuilt, numBots,  BuildEffectsBag )
end
