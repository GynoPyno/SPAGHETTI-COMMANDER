local Prop = import('/lua/sim/Prop.lua').Prop
Wait = tonumber(ScenarioInfo.Options.WreckDespawn)
Reclaim = tonumber(ScenarioInfo.Options.WreckReclaim)

oldWreckage = Wreckage
Wreckage = Class(oldWreckage) {

    OnCreate = function(self)
		oldWreckage.OnCreate(self)        
		--LOG("sa: m OnCreate working")
		--local bp = self:GetBlueprint()
		
		local TimeToDie = ForkThread( self.LifetimeToDie, self ) 
		self.Trash:Add(TimeToDie)
    end,
	LifetimeToDie = function(self)	
	 WaitSeconds(Wait + Random(1, 4))	-- random will prevent sim.. probs =) in teory ofc, when 500+ units would be destroyed at one tick ~
	 self:DoPropCallbacks('OnKilled')            
     self:Destroy()
	end,
}
--TheOldGetThreatOfUnits = GetThreatOfUnits
--function GetThreatOfUnits(platoon)
TheOldCreateWreckage = CreateWreckage
function CreateWreckage(bp, position, orientation, mass, energy, time)
	time = time / Reclaim
	--LOG (" wreck time now: "..time)
	return TheOldCreateWreckage(bp, position, orientation, mass, energy, time)
--[[
    local bpWreck = bp.Wreckage.Blueprint

    local prop = CreateProp(position, bpWreck)
    prop:SetOrientation(orientation, true)

    prop:SetScale(bp.Display.UniformScale)
    prop:SetPropCollision('Box', bp.CollisionOffsetX, bp.CollisionOffsetY, bp.CollisionOffsetZ, bp.SizeX * 0.5, bp.SizeY * 0.5, bp.SizeZ * 0.5)

    prop:SetMaxHealth(bp.Defense.Health)
    prop:SetHealth(nil, bp.Defense.Health * (bp.Wreckage.HealthMult or 1))
    prop:SetMaxReclaimValues(time, mass, energy)

    --FIXME: SetVizToNeurals('Intel') is correct here, so you can't see enemy wreckage appearing
    -- under the fog. However the engine has a bug with prop intel that makes the wreckage
    -- never appear at all, even when you drive up to it, so this is disabled for now.
    --prop:SetVizToNeutrals('Intel')
    if not bp.Wreckage.UseCustomMesh then
        prop:SetMesh(bp.Display.MeshBlueprintWrecked)
    end

    -- This field cannot be renamed or the magical native code that detects rebuild bonuses breaks.
    prop.AssociatedBP = bp.Wreckage.IdHook or bp.BlueprintId

    return prop]]
end    


