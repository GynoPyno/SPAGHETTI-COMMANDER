local LabelRes = 75

local function sumReclaim(r1, r2)
	local massSum = r1.mass + r2.mass
	local r = {
		mass = massSum,
		count = r1.count + 1
	}
	r.position = Vector((r1.mass * r1.position[1] + r2.mass * r2.position[1]) / massSum, r1.position[2],
		(r1.mass * r1.position[3] + r2.mass * r2.position[3]) / massSum)
	return r
end
local project

function UpdateLabels()
	local view = import('/lua/ui/game/worldview.lua').viewLeft
    local reclaimMatrix = {}
	if not project then
		project = view.Project
	end
    local labelIndex = 1
	local atLow = GetCamera(view._cameraName):GetTargetZoom() < 200
	
	local screenWidth = view.Width()
	local screenHeight = view.Height()
    for _, r in Reclaim do
		if r.mass < MinAmount then
		else
			local proj = project(view, Vector(r.position[1],r.position[2],r.position[3]))
			if not (proj.x < 0 or proj.y < 0 or proj.x > screenWidth or proj.y > screenHeight) then
				if labelIndex > MaxLabels then
					break
				end
				
				if not atLow then
					local rx = math.floor(proj.x / LabelRes)
					local ry = math.floor(proj.y / LabelRes)
					if reclaimMatrix[ry] then
						if reclaimMatrix[ry][rx] then
							reclaimMatrix[ry][rx] = sumReclaim(reclaimMatrix[ry][rx], r)
						else
							reclaimMatrix[ry][rx] = {
								mass = r.mass,
								position = r.position,
								count = 1,
							}
						end
					else
						reclaimMatrix[ry] = {}
						reclaimMatrix[ry][rx] = {
							mass = r.mass,
							position = r.position,
							count = 1,
						}
					end
				else
					local label = LabelPool[labelIndex]
					if label and IsDestroyed(label) then
						label = nil
					end
					if not label then
						label = CreateReclaimLabel(view.ReclaimGroup, r)
						LabelPool[labelIndex] = label
					end

					label:DisplayReclaim(r)
				end
				labelIndex = labelIndex + 1
			end
        end
    end
	
	if not atLow then
		labelIndex = 1
		for _, line in reclaimMatrix do
			for _, recl in line do
				local label = LabelPool[labelIndex]
				if label and IsDestroyed(label) then
					label = nil
				end
				if not label then
					label = CreateReclaimLabel(view.ReclaimGroup, recl)
					LabelPool[labelIndex] = label
				end

				label:DisplayReclaim(recl)
				labelIndex = labelIndex + 1
			end
		end
	end
	
    for index = labelIndex, MaxLabels do
        local label = LabelPool[index]
        if label then
            if IsDestroyed(label) then
                LabelPool[index] = nil
            elseif not label:IsHidden() then
                label:Hide()
            end
        end
    end
end