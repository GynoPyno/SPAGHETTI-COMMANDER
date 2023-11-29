
local parent = import('/lua/ui/game/borders.lua').GetMapGroup()
local UIUtil = import('/lua/ui/uiutil.lua')
local GameMain = import('/lua/ui/game/gamemain.lua')
--local timerUtility = import('/lua/ui/game/timer.lua')
local timerUtility = import('/mods/AI Wave Survival/modules/timer.lua');


local parent = false;
interface = { };

function CreateModUI(isReplay, _parent)

	parent = _parent
	ScenarioInfo = SessionGetScenarioInfo()
	BreakTime = tonumber(ScenarioInfo.Options.GameBreak)
	WavesStartTimeAI = (tonumber(ScenarioInfo.Options.WavesStartTimeAI) * 60)
 	HoldTimeAI =  (tonumber(ScenarioInfo.Options.HoldTimeAI) * 60) + (tonumber(ScenarioInfo.Options.WavesStartTimeAI) * 60) + (BreakTime * 60)
	ArtySpawn = 0
	ArtyOn = tostring(ScenarioInfo.Options.ArtyOn)
	if ArtyOn ~= "Off" then
		ArtySpawn = (tonumber(ScenarioInfo.Options.ArtySpawnTime) * 60) + (tonumber(ScenarioInfo.Options.HoldTimeAI) * 60) + (tonumber(ScenarioInfo.Options.WavesStartTimeAI) * 60) + (BreakTime * 60)
	end
	EndGameHoldTime = tostring(ScenarioInfo.Options.EndGameHoldTime)
	if EndGameHoldTime ~= "Off --" then
		EndGameHoldTime = (tonumber(ScenarioInfo.Options.EndGameHoldTime) * 60)
	else
		EndGameHoldTime = 0
	end	
	if EndGameHoldTime > 0 then
		ArtySpawn = EndGameHoldTime + (tonumber(ScenarioInfo.Options.HoldTimeAI) * 60) + (tonumber(ScenarioInfo.Options.WavesStartTimeAI) * 60) + (BreakTime * 60)
	end
	timerUtility.CreateTimerDialog(parent)
repeat
coroutine.yield(10)
	timerUtility.SetTimer(math.floor(WavesStartTimeAI-GetGameTimeSeconds()) )
until math.floor(WavesStartTimeAI-GetGameTimeSeconds())<0	
repeat 
coroutine.yield(10)
	timerUtility.SetTimer(math.floor(HoldTimeAI-GetGameTimeSeconds()) )
until math.floor(HoldTimeAI-GetGameTimeSeconds())<0
repeat 
coroutine.yield(10)
	timerUtility.SetTimer(math.floor(ArtySpawn-GetGameTimeSeconds()) )
until math.floor(ArtySpawn-GetGameTimeSeconds())<0
end	