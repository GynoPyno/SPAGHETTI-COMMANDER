
--[[do

    local oldModBlueprints = ModBlueprints

    function ModBlueprints(all_bps)
        oldModBlueprints(all_bps)

        local buildRangeScale = 3.0
		local buildPowerScale = 3.0
		local econScale = 2.0
		local storScale = 10.0
		
		
        --loop through the blueprints and adjust as desired.
        for id,bp in all_bps.Unit do
            if bp.Economy.MaxBuildDistance then
                bp.Economy.MaxBuildDistance = bp.Economy.MaxBuildDistance * buildRangeScale
            end
			if bp.Economy.BuildRate then
                if bp.Economy.MaxBuildDistance == nil then
					bp.Economy.MaxBuildDistance = 10
				end
				bp.Economy.MaxBuildDistance = bp.Economy.MaxBuildDistance * buildRangeScale
				bp.Economy.BuildRate = bp.Economy.BuildRate * buildPowerScale
			end
			if bp.Enhancements then
                for k,v in bp.Enhancements do
                    if bp.Enhancements[k].NewBuildRate then
                        bp.Enhancements[k].NewBuildRate = bp.Enhancements[k].NewBuildRate * buildPowerScale
                    end
                end
            end
			if bp.Economy.ProductionPerSecondMass then
               bp.Economy.ProductionPerSecondMass = bp.Economy.ProductionPerSecondMass * econScale
            end
            if bp.Economy.ProductionPerSecondEnergy then
               bp.Economy.ProductionPerSecondEnergy = bp.Economy.ProductionPerSecondEnergy * econScale
            end
			if bp.Economy.StorageMass then
               bp.Economy.StorageMass = bp.Economy.StorageMass * storScale
            end
            if bp.Economy.StorageEnergy then
               bp.Economy.StorageEnergy = bp.Economy.StorageEnergy * storScale
            end  
        end -- end loop
		
	end -- end function ModBlueprints(all_bps)
	
end -- end do ]]--


do
    local oldModBlueprints = ModBlueprints

    function ModBlueprints(all_bps)
        oldModBlueprints(all_bps)
	
        --loop through the blueprints and adjust as desired.
        for id,bp in all_bps.Unit do
		
			  if bp.Enhancements and bp.Enhancements.Teleporter then
			  bp.Enhancements.Teleporter = nil
			  end
			  if bp.Enhancements and bp.Enhancements.PersonalTeleporter then
			  bp.Enhancements.PersonalTeleporter = nil
			  end
			  if bp.Enhancements and bp.Enhancements.AntiAirSubsystem then
			  bp.Enhancements.AntiAirSubsystem = nil
			  end
        end -- end loop
		
	end -- end function ModBlueprints(all_bps)
	
end -- end do



--[[do
	local oldModBP = ModBlueprints
	function ModBlueprints(all_bps)
		oldModBP(all_bps)

		--> Credit for this part goes to Tichondrius, his mod is called "Performance tweak addon" <--
		for index,emitter in all_bps.Emitter do
			for i, effect in emitter.EmitRateCurve.Keys do
				effect.y = effect.y * 0.25;
				#end
			end
		end		
		
		
		
		for index,unit in all_bps.Unit do
			if unit.Categories then
			
				if table.find(unit.Categories,'MOBILE') then --Engineers have only one building beam
					if table.find(unit.Categories,'ENGINEER')
					and table.find(unit.Categories,'LAND')
					and not table.find(unit.Categories,'COMMAND')
					and not table.find(unit.Categories,'SUBCOMMANDER') then
						if unit.General.BuildBones.BuildEffectBones then
							if table.find(unit.Categories,'CYBRAN') then
								if table.find(unit.General.BuildBones.BuildEffectBones,'Buildpoint_Center') then
									unit.General.BuildBones.BuildEffectBones = {'Buildpoint_Center'}
								elseif table.find(unit.General.BuildBones.BuildEffectBones,'Buildpoint_Left') then
									unit.General.BuildBones.BuildEffectBones = {'Buildpoint_Left'}
								end
							elseif table.find(unit.Categories,'UEF') then
								if table.find(unit.General.BuildBones.BuildEffectBones,'Turret_Muzzle02') then
									unit.General.BuildBones.BuildEffectBones = {'Turret_Muzzle02'}
								elseif table.find(unit.General.BuildBones.BuildEffectBones,'Turret_Muzzle_02') then
									unit.General.BuildBones.BuildEffectBones = {'Turret_Muzzle_02'}
								end
							elseif table.find(unit.Categories,'SERAPHIM') then
								if table.find(unit.General.BuildBones.BuildEffectBones,'Turret_Muzzle1') then
									unit.General.BuildBones.BuildEffectBones = {'Turret_Muzzle1'}
								end
							end
						end
					end
				end
				
				if unit.Display.MovementEffects.Air then unit.Display.MovementEffects.Air = nil end
				if unit.Display.Tarmacs then unit.Display.Tarmacs = nil end
				if unit.Display.BlinkingLights then unit.Display.BlinkingLights = nil end
				if unit.Display.BlinkingLightsFx then unit.Display.BlinkingLightsFx = nil end
				if unit.Audio.ActiveLoop then unit.Audio.ActiveLoop = nil end
				if unit.Audio.ConstructLoop then unit.Audio.ConstructLoop = nil end
				if unit.Audio.EnhanceLoop then unit.Audio.EnhanceLoop = nil end
				if unit.Audio.ReclaimLoop then unit.Audio.ReclaimLoop = nil end
				if table.find(unit.Categories,'MASSEXTRACTION')
				or table.find(unit.Categories,'MASSFABRICATION') then
					if unit.Display.AnimationOpen then unit.Display.AnimationOpen = nil end --Do not apply this to hives, they will duplicate on upgrade
				end
				if unit.Display.MovementEffects then unit.Display.MovementEffects = nil end
				if unit.Display.LayerChangeEffects then unit.Display.LayerChangeEffects = nil end
				if unit.Display.IdleEffects then unit.Display.IdleEffects = nil end
				
				-->Credit for this part goes to Tichondrius, his mod is called "Performance tweak addon" <--
				if unit.Weapon then
					for index,wep in unit.Weapon do
						if wep.TargetCheckInterval <= 0.3
						and wep.TargetCheckInterval > 0.0 then
							wep.TargetCheckInterval = 0.3
						end
					end
				end
				
				if table.find(unit.Categories,'STRUCTURE') then --Hives have only one building beam
					if table.find(unit.Categories,'ENGINEERSTATION') then
						if table.find(unit.Categories,'PODSTAGINGPLATFORM') then
							unit.AI.InitialAutoMode = false
							unit.Display.AnimationOpen = nil
						elseif table.find(unit.Categories,'CYBRAN') then
							if unit.General.UpgradesFrom 
							and not unit.General.UpgradesTo then
								if unit.General.BuildBones.BuildEffectBones then
									unit.General.BuildBones.BuildEffectBones = {'Attachpoint03'}
								end
							elseif unit.General.UpgradesTo
							and unit.General.UpgradesFrom then
								if unit.General.BuildBones.BuildEffectBones then
									unit.General.BuildBones.BuildEffectBones = {'Attachpoint02'}
								end
							end
						end
						
					end
				end
			end
		end
		
	end
end]]--



--[[ do
	local oldModBP = ModBlueprints
	function ModBlueprints(all_bps)
		oldModBP(all_bps)

		local landTurn  = 2.0 --Land units turn speed
		local landAccel = 3.0 --Land units acceleration

		for index,unit in all_bps.Unit do
			if unit.Categories then
				if table.find(unit.Categories,'MOBILE') then
-------------------------------------[Drones have x2 build rate, this is because we removed the ability to upgrade stations]--------
					if table.find(unit.Categories,'STATIONASSISTPOD') then
						if unit.Economy.BuildRate then unit.Economy.BuildRate = unit.Economy.BuildRate * 2.0 end
					end
-------------------------------------[Engineers are always first in the build list]-------------------------------------------------
					if table.find(unit.Categories,'ENGINEER')
					and not table.find(unit.Categories,'SUBCOMMANDER')
					and not table.find(unit.Categories,'COMMAND') then
						unit.BuildIconSortPriority = 0
					end
-------------------------------------[Drones and engineers can be selected by dragging a box over them]-----------------------------
					if table.find(unit.Categories,'STATIONASSISTPOD') then
						unit.General.SelectionPriority = 3
					end
------------------------------------------------------------------------------------------------------------------------------------
					if unit.Physics.FuelRechargeRate then unit.Physics.FuelRechargeRate = nil end
					if unit.Physics.FuelUseTime then unit.Physics.FuelUseTime = nil end
					if unit.Physics.TurnRate then unit.Physics.TurnRate = unit.Physics.TurnRate * landTurn end
					if unit.Physics.MaxAcceleration then unit.Physics.MaxAcceleration  = unit.Physics.MaxSpeed * landAccel end
				end
				
				if unit.Wreckage
				and not table.find(unit.Categories,'EXPERIMENTAL') then
					unit.Wreckage = nil
				end
-------------------------------------[Shows the unit ID in the abilities tooltip, great for modders]--------------------------------
				if unit.Description then
					if not unit.Display.Abilities then unit.Display.Abilities = {} end
					table.insert(unit.Display.Abilities,'ID: ' .. string.sub(unit.Description,6,12))
				end
				
				if unit.Weapon then
					for index,wep in unit.Weapon do
-------------------------------------[Air units do 0 damage when they crash (experimentals remain unchanged)]-----------------------
						if wep.Label == 'DeathImpact' and not table.find(unit.Categories,'EXPERIMENTAL') then 
							if wep.Damage then wep.Damage = 0.0001 end
-------------------------------------[ACUs can fire at air units (but not SCUs)]----------------------------------------------------
						elseif index == 1 and table.find(unit.Categories,'COMMAND') then
							if wep.FireTargetLayerCapsTable and wep.WeaponCategory and unit.Display.Abilities then
								wep.FireTargetLayerCapsTable.Land = 'Air|' .. wep.FireTargetLayerCapsTable.Land
								wep.WeaponCategory = 'Direct Fire & Anti Air'
								table.insert(unit.Display.Abilities,'<LOC ability_aa>Anti-Air')
							end
						end
					end
				end
				
				if table.find(unit.Categories,'STRUCTURE') then
-------------------------------------[Taller walls]---------------------------------------------------------------------------------
					if table.find(unit.Categories,'WALL') then
						if unit.SizeY then unit.SizeY = unit.SizeY * 5 end
					end
-------------------------------------[Engineering stations do not upgrade, but they build things faster (and cost more)]------------
					if table.find(unit.Categories,'ENGINEERSTATION') then
						unit.Economy.BuildableCategory = nil
						unit.Economy.BuildCostEnergy = unit.Economy.BuildCostEnergy * 1.7
						unit.Economy.BuildCostMass = unit.Economy.BuildCostMass * 1.7
						if unit.General.UpgradesTo then
							if not table.find(unit.Categories,'PODSTAGINGPLATFORM') then
								unit.Categories = {}
							end
							unit.General.UpgradesTo = nil
						elseif unit.General.UpgradesFrom then
							if not table.find(unit.Categories,'PODSTAGINGPLATFORM') then
								unit.Economy.BuildTime = unit.Economy.BuildTime * 1.7
								table.insert(unit.Categories,'BUILTBYCOMMANDER')
								table.insert(unit.Categories,'BUILTBYTIER3ENGINEER')
								table.insert(unit.Categories,'BUILTBYTIER3COMMANDER')
								table.insert(unit.Categories,'BUILTBYTIER2ENGINEER')
								table.insert(unit.Categories,'BUILTBYTIER2COMMANDER')
							end
							unit.General.UpgradesFrom = nil
						end
					end
-------------------------------------[Ensures all structures can be drag-built (makes it easier to build mexes]---------------------
					if not table.find(unit.Categories,'DRAGBUILD') then
						table.insert(unit.Categories,'DRAGBUILD')
					end
-------------------------------------[Hives and engineers can be selected by dragging a box over them]------------------------------
					if table.find(unit.Categories,'ENGINEERSTATION') 
					and not table.find(unit.Categories,'PODSTAGINGPLATFORM') then
						unit.General.SelectionPriority = 3
					end
-------------------------------------[Build on steeper terrain (credit goes to Stephen Evans (aka Goom)]----------------------------
					unit.Physics.MaxGroundVariation = 5.0
					--unit.Physics.FlattenSkirt = false --Not a good idea
				end
------------------------------------------------------------------------------------------------------------------------------------
			end
		end
	end
end ]]--




-- this code from Speed++ mod.
local oldModBP = ModBlueprints
function ModBlueprints(all_bps)
    oldModBP(all_bps)



	for id,bp in all_bps.Unit do			
			 if id == "brnt3perses" then
		  bp.Intel.VisionRadius = bp.Intel.VisionRadius * 0.5
		  for i, numWeapons in bp.Weapon do
			  if bp.Weapon[i].RateOfFire then
				bp.Weapon[i].RateOfFire = bp.Weapon[i].RateOfFire * 0.75
			  end
			  if bp.Weapon[i].FiringRandomness then bp.Weapon[i].FiringRandomness = bp.Weapon[i].FiringRandomness * 1.15 end
			  if bp.Weapon[i].MaxRadius and bp.Weapon[i].MaxRadius > 90 then bp.Weapon[i].MaxRadius = bp.Weapon[i].MaxRadius - 10 end
			  if bp.Weapon[i].TurretYawSpeed and bp.Weapon[i].TurretYawSpeed > 0 then bp.Weapon[i].TurretYawSpeed = bp.Weapon[i].TurretYawSpeed * 0.85 end
		  end
		  if bp.General.OrderOverrides then bp.General.OrderOverrides = nil end
		  if bp.General.ToggleCaps then bp.General.ToggleCaps = nil end
		  if bp.Defense.Shield then bp.Defense.Shield = nil end
		  if bp.Defense.RegenRate then bp.Defense.RegenRate = bp.Defense.RegenRate + 100 end
		  if bp.Display.Abilities then bp.Display.Abilities = nil end
		  if not bp.Display.Abilities then bp.Display.Abilities = {} end
		 end
	end
	
	
    for _,unit in all_bps.Unit do
        if unit.Categories then
             
            -- this is a high impact change, both in simspeed and in game performance. Should be turned into a config option for MAXIMUM SIMSPEED
            if unit.Weapon then
                for _,wep in unit.Weapon do
                    if wep.TargetCheckInterval <= 0.5 and wep.TargetCheckInterval > 0.0 then
                        wep.TargetCheckInterval = 0.5
                    end
                end
            end

            if unit.Display then
                unit.Display.Tarmacs = nil
                unit.Display.BlinkingLights = nil
                unit.Display.BlinkingLightsFx = nil
                --unit.Display.MovementEffects = nil
                unit.Display.LayerChangeEffects = nil
                unit.Display.IdleEffects = nil
                if table.find(unit.Categories,'MASSEXTRACTION') or table.find(unit.Categories,'MASSFABRICATION') then
                    unit.Display.AnimationOpen = nil
                end
            end

            if unit.Audio then
                unit.Audio.ActiveLoop = nil
            end
            
            
            --[[if table.find(unit.Categories,'STRUCTURE') then
                if table.find(unit.Categories,'ENGINEERSTATION') then
                    if table.find(unit.Categories,'PODSTAGINGPLATFORM') then
                        unit.AI.InitialAutoMode = false
                        unit.Display.AnimationOpen = nil
                    end
                end
            end]]--
        end
    end
    
    --when phantom is off, special buildings are off
    --[[if not exists('/modules/reveal_ui.lua') then
--        LOG(repr(all_bps.Unit))
        all_bps.Unit['aeb0304'] = nil
        all_bps.Unit['arb0404'] = nil
        all_bps.Unit['xea3304'] = nil
    end]]--
	
	
	
	
--#make all particle systems spawn fewer particles (alot of the particles in supcom are a bit overkill to be honest)
--	for id,bp in all_bps.Emitter do

--		for i, erc in bp.EmitRateCurve.Keys do

--			erc.y = erc.y * 0.1;

--			#end

--		end

--	end
	


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
