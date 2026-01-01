
--[[local OLDSetupSession = SetupSession
function SetupSession()
    OLDSetupSession()
    import('/mods/AI Wave Survival/lua/AI/AIBuilders/E Land Experimental Formers.lua')
end]]--

local parentBeginSession = BeginSession

function BeginSession()

        import("/lua/sim/navutils.lua").Generate() -- <-- needs to be called before everything else that may rely on it

	ScenarioInfo.Options.Victory = "domination" 
	  -- dun break anything!
     parentBeginSession();
	 
	
	 LOG("Trying to init survival")

	--local aiBrain = GetArmyBrain("Army_9")
	local behaviors = import('/mods/AI Wave Survival/hook/lua/ai/AIBehaviors.lua')	

     --behaviors.STRfour()
	 --LOG(" behaviors.STRfour called")
	
	 ForkThread(behaviors.InitSurvival)
	  LOG(" behaviors.InitSurvival called")
	   -- run our own bit of the sim!
  
	 LOG("init survival")
	
end

--[[function SetAIWavePlayerSettings()

	ScenarioInfo.AIWavePlayer = {
		-- If the AIWavePlayer army has been selected
		Initilized = false,
		-- If the setup failed
		FailedToInitilized = false,
		-- The players actual name
		PlayerName = "",
		-- The Army slot name. ie ARMY_7
		ArmyName = "",
		-- The slot# of the AIWavePlayer army
		ArmySlot = ScenarioInfo.Options.AIWavePlayerArmy,
		-- The Army index. This is set when the AIWavePlayer player is found. Is not related to slot#
		ArmyIndex = 0

	}

	LOG("    ::AIWavePlayers:: ArmySlot: " .. ScenarioInfo.AIWavePlayer.ArmySlot)

end


function FindAIWavePlayerArmy()

	LOG("::AIWavePlayers:: Finding AIWavePlayer Army");
	for aindex, abrain in ArmyBrains do
		if 
			abrain.Name == "ARMY_" .. ScenarioInfo.AIWavePlayer.ArmySlot
		then
			ScenarioInfo.AIWavePlayer.ArmyName = abrain.Name
			ScenarioInfo.AIWavePlayer.PlayerName = ArmyBrains[abrain:GetArmyIndex()].Nickname
			ScenarioInfo.AIWavePlayer.ArmyIndex = abrain:GetArmyIndex();
			ScenarioInfo.AIWavePlayer.Initilized = abrain:GetArmyIndex();

			--ScenarioInfo.AIWavePlayersInitilized = true; -- Used by scripts that start before siminit

			LOG("::AIWavePlayers:: AIWavePlayer army found and set:");
			LOG("    ::AIWavePlayers:: Army Index: " .. ScenarioInfo.AIWavePlayer.ArmyName);
			LOG("    ::AIWavePlayers:: Army Name: " .. ScenarioInfo.AIWavePlayer.ArmyIndex);
			LOG("    ::AIWavePlayers:: Player Name: " .. ScenarioInfo.AIWavePlayer.PlayerName);

			return
		end
	end
	if ScenarioInfo.AIWavePlayer.Initilized then 
		return 
	end


	WARN("::AIWavePlayers:: Could not find a suitable army to assign HQ to.")
end]]--
