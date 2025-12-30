
local util = import('MKUtillities.lua')
local Entity = import('Entity.lua').Entity
local EffectTemplates = import('MKEffectTemplates.lua')

function PlayReclaimEffects( reclaimer, reclaimed, BuildEffectBones, EffectsBag )

	--create reclaim effect at target with a vector towards the reclaimer.
    local unitpos = table.copy(reclaimer:GetPosition())
    unitpos[2] = unitpos[2]+3
    local dir = VDiff(unitpos,reclaimed:GetPosition())
    local dist = util.GetVectorLength(dir)
    dir = util.NormalizeVector(dir)

    local unitbp = __blueprints[reclaimed.AssociatedBP] or reclaimed:GetBlueprint()
    local SizeY = unitbp.SizeY or 1
    local SizeX = unitbp.SizeX or 1
    local SizeZ = unitbp.SizeZ or 1
    local unitwidth = (SizeX + SizeZ) / 2
    local unitVol = (SizeX + SizeZ + SizeY) / 3
    local army = reclaimer:GetArmy()
	
    --LOG (repr(dist))
    --LOG (repr(SizeY))
    --LOG (repr(unitwidth))

	-- Create blank emitter tables, depending on the positions of the reclaimer and reclaimed
	-- we will do different effects.
	local fxReclaimMuzzle = {}
	local fxReclaimBeams = {}
	local fxReclaimObjectAOE = {}
	local fxReclaimDustDebris = {}
	local fxReclaimPlasma = {}

	local army = reclaimer:GetArmy()
    local pos = reclaimed:GetPosition()
    pos[2] = GetSurfaceHeight(pos[1], pos[3])
	local layerType = 'Surface'

    local beamEnd = Entity()
	EffectsBag:Add( beamEnd )
	Warp( beamEnd, reclaimed:GetPosition() )

	for kBone, vBone in BuildEffectBones do
		-- Effect at muzzle bone on reclaimer
		for kEmit, vEmit in EffectTemplates.ReclaimMuzzle01 do
			EffectsBag:Add( CreateAttachedEmitter( reclaimer, vBone, army, vEmit ) )
		end
		-- Reclaim beams
		for kEmit, vEmit in EffectTemplates.ReclaimBeams do
			EffectsBag:Add( AttachBeamEntityToEntity( reclaimer, vBone, beamEnd, -1, army, vEmit ) )
		end
	end

	-- End of reclaim effect
	for k, v in EffectTemplates.ReclaimObjectAOE do
		EffectsBag:Add( CreateEmitterOnEntity( reclaimed, army, v ):ScaleEmitter(unitwidth) )
	end

	-- -- Dust and Debris
	-- for k, v in EffectTemplates.ReclaimEffects01 do
		-- emit = CreateEmitterOnEntity( reclaimed, army, v )
		-- -- emit:SetEmitterCurveParam('EMITRATE_CURVE', unitVol*3.5, 0.0)
		-- -- emit:SetEmitterCurveParam('LIFETIME_CURVE', dist, dist*0.8)
		-- -- emit:SetEmitterCurveParam('XDIR_CURVE', pos[1], 0.3)
		-- -- emit:SetEmitterCurveParam('YDIR_CURVE', pos[2], 0.0)
		-- -- emit:SetEmitterCurveParam('ZDIR_CURVE', pos[3], 0.3)
		-- -- emit:SetEmitterCurveParam('X_POSITION_CURVE', 0.0, unitwidth)
		-- -- emit:SetEmitterCurveParam('Y_POSITION_CURVE', SizeY*0.4, SizeY)
		-- -- emit:SetEmitterCurveParam('Z_POSITION_CURVE', 0.0, unitwidth)
		-- EffectsBag:Add(emit)
	-- end

	-- -- Plasma energy
	-- for k, v in EffectTemplates.ReclaimEffects02 do
		-- emit = CreateEmitterOnEntity( reclaimed, army, v )
		-- -- emit:SetEmitterCurveParam('EMITRATE_CURVE', unitVol*0.5, 0.0)
		-- -- emit:SetEmitterCurveParam('LIFETIME_CURVE', dist, dist*1.2)
		-- -- emit:SetEmitterCurveParam('XDIR_CURVE', pos[1], 0.3)
		-- -- emit:SetEmitterCurveParam('YDIR_CURVE', pos[2], 0.0)
		-- -- emit:SetEmitterCurveParam('ZDIR_CURVE', pos[3], 0.3)
		-- -- emit:SetEmitterCurveParam('X_POSITION_CURVE', 0.0, unitwidth)
		-- -- emit:SetEmitterCurveParam('Y_POSITION_CURVE', SizeY*0.4, SizeY)
		-- -- emit:SetEmitterCurveParam('Z_POSITION_CURVE', 0.0, unitwidth)
		-- EffectsBag:Add(emit)
	-- end
end


function PlayReclaimEndEffects( reclaimer, reclaimed )
    local army = -1
    if reclaimer then
        army = reclaimer:GetArmy()
    end

	local pos = reclaimed:GetPosition()
	local layerType = 'Surface'

	for k, v in EffectTemplates.ReclaimObjectEnd do
	    CreateEmitterAtEntity( reclaimed, army, v )
	end
end

-----------------------------------------------------------------
-- TableCat - Concatenates multiple tables into one single table
-----------------------------------------------------------------
function TableCat( ... )
    local ret = {}
    for index = 1, table.getn(arg) do
        if arg[index] != nil then
            for k, v in arg[index] do
                table.insert( ret, v )
            end
        end
    end
    return ret
end

PadZeros = function( num, numDesiredChars )
    local padString = tostring( num )
    
    while string.len(padString) < numDesiredChars do
        padString = "0" .. padString
    end
    return padString
end