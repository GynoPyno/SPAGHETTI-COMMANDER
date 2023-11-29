-- This is AKarmy01 Code (Swarm Survival Mod), you can edit/copy from it, enjoy!

local victory = import('/lua/victory.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')
local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local NavUtils = import("/lua/sim/navutils.lua")
--local ScenarioPlatoonAI = import('/lua/ai/ScenarioPlatoonAI.lua')
local landUnitsL = { Tech4 = {} }
local landUnitsM = { Tech4 = {} }
local landUnitsH = { Tech4 = {} }
local landUnitsE = { Tech4 = {} }
local LAirUnits = { Tech4 = {} }
local MAirUnits = { Tech4 = {} }
local HAirUnits = { Tech4 = {} }
local EAirUnits = { Tech4 = {} }
local LNavyUnits = { Tech4 = {} }
local MNavyUnits = { Tech4 = {} }
local HNavyUnits = { Tech4 = {} }
local ENavyUnits = { Tech4 = {} }
local TransUnitsL = { Tech4 = {} }
local TransUnitsM = { Tech4 = {} }
local TransUnitsH = { Tech4 = {} }
local LNavyUnitsHeavy = { Tech4 = {} }
local MNavyUnitsHeavy = { Tech4 = {} }
local HNavyUnitsHeavy = { Tech4 = {} }
local HAirUnitsHeavy = { Tech4 = {} }
local MAirUnitsHeavy = { Tech4 = {} }
local LAirUnitsHeavy = { Tech4 = {} }
local landUnitsHHeavy = { Tech4 = {} }
local landUnitsMHeavy = { Tech4 = {} }
local landUnitsLHeavy = { Tech4 = {} }
local landUnitsExtremeHeavy = { Tech4 = {} }
local airUnitsA = { Tech4 = {} }
local humanBrains = { HBrains = {} }
local allyBrainsHQ = { ABrainsHQ = {} }
local HQandAllyBrains = { HQallyBrains = {} }
local closestEnemyBrains = { CBrains = {} }
local aiSecondaryBuildings = { secondaryBuildings = {} }
local validWaterPositions = { positions = {} }
local validWaterPositions2 = { positions2 = {} }
local validRiftPositions = { positions = {} }
validNotRiftPositions = { positions = {} }
local humanACUs = { HACUs = {} }
local allyHQACU = { AllyACUs = {} }
RiftUnitsL = { Tech4 = {} }
RiftUnitsM = { Tech4 = {} }
RiftUnitsH = { Tech4 = {} }
BigRiftUnitsL = { Tech4 = {} }
BigRiftUnitsM = { Tech4 = {} }
BigRiftUnitsH = { Tech4 = {} }
local AllEnemyUnitsLandDefense = {}
local AllEnemyUnitsLandEconomy = {}
local AllEnemyUnitsAntiNavy = {}
local AllEnemyUnitsSubs = {}
local AllEnemyUnitsBombers = {}
local AllEnemyUnitsAir = {}
local AllEnemyUnitsNaval = {}
local sizeX, sizeZ = GetMapSize()
HQSetFlag = false
hBrains = 0
aBrainsHQ = 0
land4 = 0
air4 = 0
Lland = 0
Mland = 0
Hland = 0
Eland = 0
exHLand = 0
LAir = 0
MAir = 0
HAir = 0
EAir = 0
LNavy = 0
MNavy = 0
HNavy = 0
ENavy = 0
omega = 0
TranLland = 0
TranMland = 0
TranHland = 0
RiftLland = 0
RiftMland = 0
RiftHland = 0
BigRiftLland = 0
BigRiftMland = 0
BigRiftHland = 0
LNavyHeavy = 0
MNavyHeavy = 0
HNavyHeavy = 0
HAirHeavy = 0
MAirHeavy = 0
LAirHeavy = 0
HlandHeavy = 0
MlandHeavy = 0
LlandHeavy = 0
RiftUnits = 4
TotalMayhemWaves = "Not Adjustable - Totally Random!"
TotalMayhemLand = 10
TotalMayhemAir = 10
TotalMayhemNavy = 10
HoldTimeArtyNukes = 1
totalNomanders = 0
totalT3Gunships = 0
totalExpAir = 0
totalT3Fighters = 0
totalT3Bombers = 0
AirPower = 0
AnitAirResponse = 0
totalmass = 0
lastmass = 0
totalIncrease = 0
totalDamageIncrease = 0
HPBonusAI = 4
DmgBonus = 2
DelayUntilNextWaveAI = 150
AIMainBuilding = nil
AISecondBuilding = nil
AlternateHQBuilding = nil
Alternate2ndBuilding = nil
HQAltBuildingDead = false
Alt2ndBuildingDead = false
WavesStartTimeAI = 900
LandPerWave = 20
HivesPerPlayerAI = 200
NukeStrikeEveryAI = 300
NukesPerStrikeAI = 2
MainBuildingHPAI = 10000000
SecSpawnBuildingHP = 1000000
HoldTimeAI = 40 * 60
SpeedBonus = 0.01
SpeedBonusOnce = 0
HQMass = 5000
HQEnergy = 500000
NukesOn = "All On"
PlayerLevel = "Off"
WaveProgression = 1
WaveProgressionData = "Normal"
ArtyOn = "On"
ArtySpawnTime = 60
ArtyType = "UEB2401"
Endless = "Off"
EndWaveMulti = 0
EndWaveAir = 0
AirPerWave = 20
HQAllyEcoBoost = 0
HumanEcoBoost = 0
EndGameEcoBoost = 0
BoostOn = false
HowToPlay = 1
NavyTime = 0
AirTime = 0
NavyPerWave = 0
MinorBossSpawns = "Land+Air"
ExperimentalSpawns = "Land+Air+Navy"
BossWaveEndlessSpawn = "Off"
SecondaryBuildingFlag = "Off"
SupportBaseMulti = 1
SupportBaseNukes = 'SB Nuke Retaliation - On'
SpawnAlliesForceFlag = "On - Land + Air"
GameTime = 60
GameTimeNavy = 60
GameTimeAir = 60
NuclearOverwhelm = 0
NukeIncreasePerStrike = 0
HealthBonus = 0
BossDefBonus = 0
WaveDefBonuse = 0
AllWaves = "Off"
UEFWaves = "UEF On"
CybranWaves = "Cybran On"
AeonWaves = "Aeon On"
SeraphimWaves = "Seraphim On"
NomadWaves = "Off"
JumpTech2 = "Land+Air+Navy"
KillAIBase = "BaseBuilding On"
SpecialWeapons = "T4AA + EmpTacs Enabled"
ArtyNukeEnable = "No Restrictions (Buildable Arty/Nukes/Sat)"
ACUHunterTime = 'Off --'
ACUHunterTimeNumber = 0.75
ACUHunterSize = 1
ASFWaves = "Off"
LandAmphibious = "All On"
ExpMulti = 1
AirExpMulti = 1
NavyExpMulti = 1
YoloTime = 360
WaveStyle = "Dynamic Attack Waves"
humans = 0
EndGameHoldTime = "Off --"
TorpBomberStartTime = 0
ExtraWaveDelay = 0
GameBreak = 0
cyclecount = 0
ParagonLock = 0
totalEnemyExpArty = 0
totalEnemyT3Arty = 0
totalEnemySatelites = 0
totalEnemyExpAirDefences = 0
CrazyModeLand = "Normal Land"
CrazyModeAir = "Normal Air"
CrazyModeNavy = "Normal Navy"
EndEcoBoostTime = 120
NukeTime = 0.85
NukeWarningOne = false
NukeWarningTwo = false
ParagonCycle = "Off"
ParagonNuke = "On"
ArtyYolo = "Yolona+Arty Response On"
EndGameParagon = "Paragon Midgame"
EndGameYolo = "Yolona Midgame"
AIWavePlayer = "Random"
secondaryspawn = "Off"
KillPlayerUnit = 300
KillNavyLandUnit = 450
HQDefenses = "HQ S2-Tier Defenses"
HQDefensesPD = "HQ Guardian PD S-Tier"
SecSpawnDefences = "2nd Spawn S2-Tier Defenses"
SecSpawnPD = "2nd Spawn Universal PD A-Tier"
TMDType = "GTD4201"
SMDType = "ASD4302"
AAType = "GAA2304"
PDType = "GPD2301"
ShieldType = "GAS4301"
SecTMDType = "GTD4201"
SecSMDType = "ASD4302"
SecAAType = "UPD2304"
SecPDType = "UPD2304"
SecShieldType = "GAS4301"
VersesSurvival = 'Versus Survival Off'
KillAllNonHQPlayers = "Assassinate All ACUs Defeat"
KillHQPlayerAllies = "HQ Allies Annihilation Defeat"
VanDef = 0
AlliedForceMultiplier = 1
aiPositionX = 0
aiPositionZ = 0
playerPosX = 0
playerPosZ = 0
PowerStallTime = 120
TransLowerM = 120
TransUpperM = 240
Transx1 = 1
Transx2 = 1
Transx3 = 1
Transx4 = 1
Transx5 = 1
Landx1 = 1
Landx2 = 1
Landx3 = 1
Landx4 = 1
Landx5 = 1
Airx1 = 1
Airx2 = 1
Airx3 = 1
Airx4 = 1
Airx5 = 1
Navyx1 = 1
Navyx2 = 1
Navyx3 = 1
Navyx4 = 1
Navyx5 = 1
Nukex1 = 180
Nukex2 = 300
AmphibiousCheck = 'Enabled'
totalEnemyMass = 0
massDamageBoost = 0
massDamageBoostBoss = 0
DamageBoost = 1
DamageBoostMulti = 1
SecBrain = nil
SalvationBrain = nil
AltHQBrain = nil
Alt2ndBrain = nil
salvationBOOM = 'Dooms Immune'
salvationspawn = "Off"
AltHQSpawn = "Off"
Alt2ndSpawn = "Off"
SalvationCheck = false
AltHQCheck = false
Alt2ndCheck = false
ErrorMessage = false
AltHQHealth = "Invulnerable --"
Alt2ndHealth = "Invulnerable --"
SecondSpawnCheck = false
permanentwaveloss = 0
permanentwavelossair = 0
permanentwavelossnavy = 0
spawnrateland = 0
spawnrateair = 0
spawnratenavy = 0
spawnratelandmulti = 0
spawnrateairmulti = 0
spawnratenavymulti = 0
paragontimebreak = 0
NomanderSpawn = "Off 0"
DoomCount = 1
DoomDamageHQ = 0.2
DoomIncrease = 0
DoomWaveCount = 0
DoomMinimum = 1
DoomMaximum = "Off --"
DoomBoostHP = 1
DoomCrawlers = "Doom Mega + Doom Fatboy"
DoomWalkers = "Doom Colossus + Doom Ythotha"
DoomTable = {}
RamboTransTable = {}
RamboChance = "Off --"
DoomTableCt = 0
TotalDooms = 0
DoomStormMulti = 1
DoomStorm = "Off --"
ExtraASFEnabled = 1
TransportFrequency = "Off"
InitialTransports = 1
TransportMultiplier = "No"
TransportsToStartTime = 0.5
TransportEndTime = "Endless --"
TransportUnits = "Only Bots (Mixed Race)"
TransportExpChance = "Off --"
TranSpawnLocation = "All Sides"
HQAllyRestrict = "HQ Allies No Restrictions"
LandRedirectCycleRunning = false
AirRedirectCycleRunning = false
NavyRedirectCycleRunning = false
RamboRedirectCycleRunning = false
AllRedirectCycleRunning = false
paragontimerflag = false
SecondarySpawnDead = false
EndGameEcoBoostflag = false
EndGameEcoMessage = false
MessageFlag = "On"
HQAlliesACUecoBoostflag = false
SecondaryBuildingsDead = false
damageamplificationflag = false
RetaliationTransport = false
SideObjsDestroyed = 0
ParagonFlag = false
ParaYoloFlag = false
GameBreakFlag = false
SpecWeapFlag01 = false
SpecWeapFlag02 = false
SpecWeapFlag03 = false
EndGameCondition = false
HQAlert = false
local NavyTimeFlag = false
local AirTimeFlag = false
local AlliedForceSpawned = false
local flagLastDifficulty = false
local HoldTimeOver = false
local otherParagonIds = false
local totalAINukeSubs = 0
local currentMainBuildingHP = 0
local firstWarning = false
local lastWarning = false
local won = false
local lost = false
local lockedDifficulty = false
local waveNum = 0
local aiBrain
local isAIBrain = true
local countair = 0
local navalCounter = 0
local totalEnemyExpShields = 0
local totalEnemyParagons = 0
local totalEnemyYolonas = 0
local totalEnemyExpDefences = 0
local totalEnemyT3Defences = 0
local totalEnemyT3AirDefences = 0
local totalEnemyT3LandDefences = 0
local totalExpUnits = 0
local totalEnemySMDs = 0
local totalTthreeRes = 0
local totalEnemyEndgamers = 0
function STRfour()
    ---------------------------------------UEF Waves-------------------------------------------------------------------------------------------------------------
	if UEFWaves == "UEF On" then
		for id, bp in pairs(__blueprints) do
			if (bp.Categories and string.len(id) >= 5) then
				if table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'ENGINEER') and not table.find(bp.Categories, 'SCOUT') and not table.find(bp.Categories, 'SATELLITE') and not table.find(bp.Categories, 'INSIGNIFICANTUNIT') 
				and not table.find(bp.Categories, 'INVULNERABLE') and not table.find(bp.Categories, 'UNTARGETABLE') and not table.find(bp.Categories, 'UNSELECTABLE')
				and not table.find(bp.Categories, 'LIGHTDROPCAPSULE') and not table.find(bp.Categories, 'MEDIUMDROPCAPSULE') and not table.find(bp.Categories, 'HEAVYDROPCAPSULE')
				and not table.find(bp.Categories, 'CANTRANSPORTCOMMANDER') then
					if table.find(bp.Categories, 'LAND') then
						land4 = 1
						if id ~= "sbrnt3batu" and id ~= "bel0402" then
							if LandAmphibious == "All On" then	
								if table.find(bp.Categories, 'UEF') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 30) and id ~= "uec0001" and id ~= "opc2002" then
									Lland = Lland + 1
									table.insert(landUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
							elseif LandAmphibious == "Amphibious" then
								if table.find(bp.Categories, 'UEF') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 30) and id ~= "uec0001" and id ~= "opc2002"
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) then
									Lland = Lland + 1
									table.insert(landUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
							elseif LandAmphibious == "No AntiAir" then
								if table.find(bp.Categories, 'UEF') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 30) and id ~= "uec0001" and id ~= "opc2002"
								and not table.find(bp.Categories, 'ANTIAIR') then
									Lland = Lland + 1
									table.insert(landUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
							elseif LandAmphibious == "Amphibious No AA" then
								if table.find(bp.Categories, 'UEF') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 30) and id ~= "uec0001" and id ~= "opc2002"
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and not table.find(bp.Categories, 'ANTIAIR') then
									Lland = Lland + 1
									table.insert(landUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
							end
							if LandAmphibious == "All On" then
								if table.find(bp.Categories, 'UEF') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 100) then
									Mland = Mland + 1
									table.insert(landUnitsM.Tech4, id) --Tech2
								end
							elseif LandAmphibious == "Amphibious" then
								if table.find(bp.Categories, 'UEF') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 100)
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) then
									Mland = Mland + 1
									table.insert(landUnitsM.Tech4, id) --Tech2
								end
							elseif LandAmphibious == "No AntiAir" then
								if table.find(bp.Categories, 'UEF') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 100)
								and not table.find(bp.Categories, 'ANTIAIR') then
									Mland = Mland + 1
									table.insert(landUnitsM.Tech4, id) --Tech2
								end
							elseif LandAmphibious == "Amphibious No AA" then
								if table.find(bp.Categories, 'UEF') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 100)
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and not table.find(bp.Categories, 'ANTIAIR') then
									Mland = Mland + 1
									table.insert(landUnitsM.Tech4, id) --Tech2
								end
							end	
							if LandAmphibious == "All On" then
								if table.find(bp.Categories, 'UEF') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 200 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and id ~= "sbrot3hadesb") then
									Hland = Hland + 1
									table.insert(landUnitsH.Tech4, id) --Tech3
								end
							elseif LandAmphibious == "Amphibious" then
								if table.find(bp.Categories, 'UEF') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 200 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and id ~= "sbrot3hadesb") then
									Hland = Hland + 1
									table.insert(landUnitsH.Tech4, id) --Tech3
								end
							elseif LandAmphibious == "No AntiAir" then
								if table.find(bp.Categories, 'UEF') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 200 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and id ~= "sbrot3hadesb") and not table.find(bp.Categories, 'ANTIAIR') then
									Hland = Hland + 1
									table.insert(landUnitsH.Tech4, id) --Tech3
								end
							elseif LandAmphibious == "Amphibious No AA" then
								if table.find(bp.Categories, 'UEF') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 200 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and id ~= "sbrot3hadesb") and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and not table.find(bp.Categories, 'ANTIAIR') then
									Hland = Hland + 1
									table.insert(landUnitsH.Tech4, id) --Tech3
								end
							end	
							if table.find(bp.Categories, 'UEF') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 50000 and table.find(bp.Categories, 'EXPERIMENTAL') and table.find(bp.Categories, 'LAND') and table.find(bp.Categories, 'MOBILE') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
							and id ~= "sbrot3hadesb" and id ~= "brmt3cloaker" and id ~= "ssl0403" and id ~= "srl0401") then
								Eland = Eland + 1
								table.insert(landUnitsE.Tech4, id) --Experimentals
							end
								--if MinorBossSpawns == "Land+Air" or MinorBossSpawns == "Land" then
									if table.find(bp.Categories, 'UEF') and bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 50000 and bp.Defense and bp.Defense.MaxHealth > 70000 and id ~= "brmt3ava"
										and id ~= "brot3hades" then
										exHLand = exHLand + 1
										table.insert(landUnitsExtremeHeavy.Tech4, id)  --Total Mayhem Experimentals
									end
							--end
						end
					end
					if table.find(bp.Categories, 'AIR')
					and id ~= "uefsas01" and id ~= "uefsas02" and id ~= "uefsas03" and id ~= "uefsas04" then
						if table.find(bp.Categories, 'UEF') and table.find(bp.Categories, 'AIR') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') then
							if bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 5000 then
								air4 = 1
								table.insert(airUnitsA.Tech4, id)
								countair = countair + 1
							end
						end
						if table.find(bp.Categories, 'UEF') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH1') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
								LAir = LAir + 1
								table.insert(LAirUnits.Tech4, id)
						end
						if ASFWaves == "Off" then
							if table.find(bp.Categories, 'UEF') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
									MAir = MAir + 1
									table.insert(MAirUnits.Tech4, id)
							end
						end
						if ASFWaves == "Torp Bombers" then
							if table.find(bp.Categories, 'UEF') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
									MAir = MAir + 1
									table.insert(MAirUnits.Tech4, id)
							end
						end
						if ASFWaves == "ASF+Torp Bombers" then
							if table.find(bp.Categories, 'UEF') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
									MAir = MAir + 1
									table.insert(MAirUnits.Tech4, id)
							end
						end
						if ASFWaves == "ASF" then
							if table.find(bp.Categories, 'UEF') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
									MAir = MAir + 1
									table.insert(MAirUnits.Tech4, id)
							end
						end
						if ASFWaves == "Off" then	
							if table.find(bp.Categories, 'UEF') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
									HAir = HAir + 1
									table.insert(HAirUnits.Tech4, id)
							end
						end
						if ASFWaves == "Torp Bombers" then	
							if table.find(bp.Categories, 'UEF') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
									HAir = HAir + 1
									table.insert(HAirUnits.Tech4, id)
							end
						end
						if ASFWaves == "ASF" then	
							if table.find(bp.Categories, 'UEF') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
								HAir = HAir + 1
								table.insert(HAirUnits.Tech4, id)
							end
						end	
						if ASFWaves == "ASF+Torp Bombers" then	
							if table.find(bp.Categories, 'UEF') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
								HAir = HAir + 1
								table.insert(HAirUnits.Tech4, id)
							end
						end	
						if ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Air+Navy" or ExperimentalSpawns == "Air" then	
							if table.find(bp.Categories, 'UEF') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'EXPERIMENTAL') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK') 
							or table.find(bp.Categories, 'DIRECTFIRE')) and not table.find(bp.Categories, 'SATELLITE') and bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 65000 then
								EAir = EAir + 1
								table.insert(EAirUnits.Tech4, id)
							end
						end	
					end	
					if table.find(bp.Categories, 'UEF') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'TECH1') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'CQUEMOV') then
							LNavy = LNavy + 1
							table.insert(LNavyUnits.Tech4, id)
					end
					if table.find(bp.Categories, 'UEF') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'TECH2') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'CQUEMOV') then
							MNavy = MNavy + 1
							table.insert(MNavyUnits.Tech4, id)
					end
					if table.find(bp.Categories, 'UEF') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'TECH3') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'CQUEMOV') then
							HNavy = HNavy + 1
							table.insert(HNavyUnits.Tech4, id)
					end
					if ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Air+Navy" or ExperimentalSpawns == "Navy" then
						if table.find(bp.Categories, 'UEF') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'EXPERIMENTAL') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and id ~= "edc0305" then
							ENavy = ENavy + 1
							table.insert(ENavyUnits.Tech4, id)
						end
					end	
				end
			end
		end
	end
	--------------------------------CYBRAN Waves--------------------------------------------------------------------
	if CybranWaves == "Cybran On" then
		for id, bp in pairs(__blueprints) do
			if (bp.Categories and string.len(id) >= 5) then
				if table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'ENGINEER') and not table.find(bp.Categories, 'SCOUT') and not table.find(bp.Categories, 'SATELLITE') and not table.find(bp.Categories, 'INSIGNIFICANTUNIT') and not table.find(bp.Categories, 'TACTICALMISSILEPLATFORM')
				and not table.find(bp.Categories, 'INVULNERABLE') and not table.find(bp.Categories, 'UNTARGETABLE') and not table.find(bp.Categories, 'UNSELECTABLE')
				and not table.find(bp.Categories, 'LIGHTDROPCAPSULE') and not table.find(bp.Categories, 'MEDIUMDROPCAPSULE') and not table.find(bp.Categories, 'HEAVYDROPCAPSULE')
				and not table.find(bp.Categories, 'CANTRANSPORTCOMMANDER') then
					if table.find(bp.Categories, 'LAND') and not table.find(bp.Categories, 'INTELLIGENCE') then
						land4 = 1
						if id ~= "sbrnt3batu" and id ~= "bel0402" then
							if LandAmphibious == "All On" then	
								if table.find(bp.Categories, 'CYBRAN') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 30) and id ~= "uec0001" and id ~= "opc2002" then
									Lland = Lland + 1
									table.insert(landUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
							elseif LandAmphibious == "Amphibious" then
								if table.find(bp.Categories, 'CYBRAN') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 30) and id ~= "uec0001" and id ~= "opc2002"
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) then
									Lland = Lland + 1
									table.insert(landUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
							elseif LandAmphibious == "No AntiAir" then
								if table.find(bp.Categories, 'CYBRAN') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 30) and id ~= "uec0001" and id ~= "opc2002"
								and not table.find(bp.Categories, 'ANTIAIR') then
									Lland = Lland + 1
									table.insert(landUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
							elseif LandAmphibious == "Amphibious No AA" then
								if table.find(bp.Categories, 'CYBRAN') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 30) and id ~= "uec0001" and id ~= "opc2002"
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and not table.find(bp.Categories, 'ANTIAIR') then
									Lland = Lland + 1
									table.insert(landUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
							end
							if LandAmphibious == "All On" then
								if table.find(bp.Categories, 'CYBRAN') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 100) then
									Mland = Mland + 1
									table.insert(landUnitsM.Tech4, id) --Tech2
								end
							elseif LandAmphibious == "Amphibious" then
								if table.find(bp.Categories, 'CYBRAN') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 100)
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) then
									Mland = Mland + 1
									table.insert(landUnitsM.Tech4, id) --Tech2
								end
							elseif LandAmphibious == "No AntiAir" then
								if table.find(bp.Categories, 'CYBRAN') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 100)
								and not table.find(bp.Categories, 'ANTIAIR') then
									Mland = Mland + 1
									table.insert(landUnitsM.Tech4, id) --Tech2
								end
							elseif LandAmphibious == "Amphibious No AA" then
								if table.find(bp.Categories, 'CYBRAN') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 100)
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and not table.find(bp.Categories, 'ANTIAIR') then
									Mland = Mland + 1
									table.insert(landUnitsM.Tech4, id) --Tech2
								end
							end	
							if LandAmphibious == "All On" then
								if table.find(bp.Categories, 'CYBRAN') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 200 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and id ~= "sbrot3hadesb") then
									Hland = Hland + 1
									table.insert(landUnitsH.Tech4, id) --Tech3
								end
							elseif LandAmphibious == "Amphibious" then
								if table.find(bp.Categories, 'CYBRAN') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 200 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and id ~= "sbrot3hadesb") then
									Hland = Hland + 1
									table.insert(landUnitsH.Tech4, id) --Tech3
								end
							elseif LandAmphibious == "No AntiAir" then
								if table.find(bp.Categories, 'CYBRAN') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 200 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and id ~= "sbrot3hadesb") and not table.find(bp.Categories, 'ANTIAIR') then
									Hland = Hland + 1
									table.insert(landUnitsH.Tech4, id) --Tech3
								end
							elseif LandAmphibious == "Amphibious No AA" then
								if table.find(bp.Categories, 'CYBRAN') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 200 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and id ~= "sbrot3hadesb") and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and not table.find(bp.Categories, 'ANTIAIR') then
									Hland = Hland + 1
									table.insert(landUnitsH.Tech4, id) --Tech3
								end
							end	
							if table.find(bp.Categories, 'CYBRAN') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 50000 and table.find(bp.Categories, 'EXPERIMENTAL') and table.find(bp.Categories, 'LAND') and table.find(bp.Categories, 'MOBILE') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
							and id ~= "sbrot3hadesb" and id ~= "brmt3cloaker" and id ~= "ssl0403" and id ~= "srl0401") then
								Eland = Eland + 1
								table.insert(landUnitsE.Tech4, id) --Experimentals
							end
							--if MinorBossSpawns == "Land+Air" or MinorBossSpawns == "Land" then
								if table.find(bp.Categories, 'CYBRAN') and bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 50000 and bp.Defense and bp.Defense.MaxHealth > 70000 and id ~= "brmt3ava"
									and id ~= "brot3hades" then
									exHLand = exHLand + 1
									table.insert(landUnitsExtremeHeavy.Tech4, id)  --Total Mayhem Experimentals
								end
							--end	
						end
					end
					if table.find(bp.Categories, 'AIR')
					and id ~= "urfsas01" and id ~= "urfsas02" and id ~= "urfsas03" then
						if table.find(bp.Categories, 'CYBRAN') and table.find(bp.Categories, 'AIR') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') then
							if bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 5000 then
								air4 = 1
								table.insert(airUnitsA.Tech4, id)
								countair = countair + 1
							end
						end	
						if table.find(bp.Categories, 'CYBRAN') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH1') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
								LAir = LAir + 1
								table.insert(LAirUnits.Tech4, id)
						end
						if ASFWaves == "Off" then
							if table.find(bp.Categories, 'CYBRAN') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
									MAir = MAir + 1
									table.insert(MAirUnits.Tech4, id)
							end
						end
						if ASFWaves == "Torp Bombers" then
							if table.find(bp.Categories, 'CYBRAN') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
									MAir = MAir + 1
									table.insert(MAirUnits.Tech4, id)
							end
						end
						if ASFWaves == "ASF+Torp Bombers" then
							if table.find(bp.Categories, 'CYBRAN') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
									MAir = MAir + 1
									table.insert(MAirUnits.Tech4, id)
							end
						end
						if ASFWaves == "ASF" then
							if table.find(bp.Categories, 'CYBRAN') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
									MAir = MAir + 1
									table.insert(MAirUnits.Tech4, id)
							end
						end
						if ASFWaves == "Off" then	
							if table.find(bp.Categories, 'CYBRAN') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
									HAir = HAir + 1
									table.insert(HAirUnits.Tech4, id)
							end
						end
						if ASFWaves == "Torp Bombers" then	
							if table.find(bp.Categories, 'CYBRAN') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
									HAir = HAir + 1
									table.insert(HAirUnits.Tech4, id)
							end
						end
						if ASFWaves == "ASF" then	
							if table.find(bp.Categories, 'CYBRAN') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
								HAir = HAir + 1
								table.insert(HAirUnits.Tech4, id)
							end
						end	
						if ASFWaves == "ASF+Torp Bombers" then	
							if table.find(bp.Categories, 'CYBRAN') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
								HAir = HAir + 1
								table.insert(HAirUnits.Tech4, id)
							end
						end	
						if ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Air+Navy" or ExperimentalSpawns == "Air" then	
							if table.find(bp.Categories, 'CYBRAN') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'EXPERIMENTAL') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK') 
							or table.find(bp.Categories, 'DIRECTFIRE')) and not table.find(bp.Categories, 'SATELLITE') and bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 65000 then
									EAir = EAir + 1
									table.insert(EAirUnits.Tech4, id)
							end
						end	
					end	
					if table.find(bp.Categories, 'CYBRAN') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'TECH1') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'CQUEMOV') then
							LNavy = LNavy + 1
							table.insert(LNavyUnits.Tech4, id)
					end
					if table.find(bp.Categories, 'CYBRAN') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'TECH2') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'CQUEMOV') then
							MNavy = MNavy + 1
							table.insert(MNavyUnits.Tech4, id)
					end
					if table.find(bp.Categories, 'CYBRAN') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'TECH3') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'CQUEMOV') then
							HNavy = HNavy + 1
							table.insert(HNavyUnits.Tech4, id)
					end
					if ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Air+Navy" or ExperimentalSpawns == "Navy" then
						if table.find(bp.Categories, 'CYBRAN') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'EXPERIMENTAL') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and id ~= "edc0305" then
								ENavy = ENavy + 1
								table.insert(ENavyUnits.Tech4, id)
						end
					end	
				end
			end
		end
	end  
	--------------------------------AEON WAVES------------------------------------------------------------------
	if AeonWaves == "Aeon On" then
		for id, bp in pairs(__blueprints) do
			if (bp.Categories and string.len(id) >= 5) then
				if table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'ENGINEER') and not table.find(bp.Categories, 'SCOUT') and not table.find(bp.Categories, 'SATELLITE') and not table.find(bp.Categories, 'INSIGNIFICANTUNIT') and not table.find(bp.Categories, 'TACTICALMISSILEPLATFORM')
				and not table.find(bp.Categories, 'INVULNERABLE') and not table.find(bp.Categories, 'UNTARGETABLE') and not table.find(bp.Categories, 'UNSELECTABLE')
				and not table.find(bp.Categories, 'LIGHTDROPCAPSULE') and not table.find(bp.Categories, 'MEDIUMDROPCAPSULE') and not table.find(bp.Categories, 'HEAVYDROPCAPSULE')
				and not table.find(bp.Categories, 'CANTRANSPORTCOMMANDER') then
					if table.find(bp.Categories, 'LAND') and not table.find(bp.Categories, 'INTELLIGENCE') then
						land4 = 1
						if id ~= "sbrnt3batu" and id ~= "bel0402" then
							if LandAmphibious == "All On" then	
								if table.find(bp.Categories, 'AEON') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 30) and id ~= "uec0001" and id ~= "opc2002" then
									Lland = Lland + 1
									table.insert(landUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
							elseif LandAmphibious == "Amphibious" then
								if table.find(bp.Categories, 'AEON') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 30) and id ~= "uec0001" and id ~= "opc2002"
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) then
									Lland = Lland + 1
									table.insert(landUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
							elseif LandAmphibious == "No AntiAir" then
								if table.find(bp.Categories, 'AEON') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 30) and id ~= "uec0001" and id ~= "opc2002"
								and not table.find(bp.Categories, 'ANTIAIR') then
									Lland = Lland + 1
									table.insert(landUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
							elseif LandAmphibious == "Amphibious No AA" then
								if table.find(bp.Categories, 'AEON') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 30) and id ~= "uec0001" and id ~= "opc2002"
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and not table.find(bp.Categories, 'ANTIAIR') then
									Lland = Lland + 1
									table.insert(landUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
							end
							if LandAmphibious == "All On" then
								if table.find(bp.Categories, 'AEON') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 100) then
									Mland = Mland + 1
									table.insert(landUnitsM.Tech4, id) --Tech2
								end
							elseif LandAmphibious == "Amphibious" then
								if table.find(bp.Categories, 'AEON') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 100)
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) then
									Mland = Mland + 1
									table.insert(landUnitsM.Tech4, id) --Tech2
								end
							elseif LandAmphibious == "No AntiAir" then
								if table.find(bp.Categories, 'AEON') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 100)
								and not table.find(bp.Categories, 'ANTIAIR') then
									Mland = Mland + 1
									table.insert(landUnitsM.Tech4, id) --Tech2
								end
							elseif LandAmphibious == "Amphibious No AA" then
								if table.find(bp.Categories, 'AEON') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 100)
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and not table.find(bp.Categories, 'ANTIAIR') then
									Mland = Mland + 1
									table.insert(landUnitsM.Tech4, id) --Tech2
								end
							end	
							if LandAmphibious == "All On" then
								if table.find(bp.Categories, 'AEON') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 200 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and id ~= "sbrot3hadesb") then
									Hland = Hland + 1
									table.insert(landUnitsH.Tech4, id) --Tech3
								end
							elseif LandAmphibious == "Amphibious" then
								if table.find(bp.Categories, 'AEON') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 200 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and id ~= "sbrot3hadesb") then
									Hland = Hland + 1
									table.insert(landUnitsH.Tech4, id) --Tech3
								end
							elseif LandAmphibious == "No AntiAir" then
								if table.find(bp.Categories, 'AEON') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 200 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and id ~= "sbrot3hadesb") and not table.find(bp.Categories, 'ANTIAIR') then
									Hland = Hland + 1
									table.insert(landUnitsH.Tech4, id) --Tech3
								end
							elseif LandAmphibious == "Amphibious No AA" then
								if table.find(bp.Categories, 'AEON') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 200 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and id ~= "sbrot3hadesb") and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and not table.find(bp.Categories, 'ANTIAIR') then
									Hland = Hland + 1
									table.insert(landUnitsH.Tech4, id) --Tech3
								end
							end	
							if table.find(bp.Categories, 'AEON') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 50000 and table.find(bp.Categories, 'EXPERIMENTAL') and table.find(bp.Categories, 'LAND') and table.find(bp.Categories, 'MOBILE') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
							and id ~= "sbrot3hadesb" and id ~= "brmt3cloaker" and id ~= "ssl0403" and id ~= "srl0401" and id ~= "bal0401") then
								Eland = Eland + 1
								table.insert(landUnitsE.Tech4, id) --Experimentals
							end
							--if MinorBossSpawns == "Land+Air" or MinorBossSpawns == "Land" then
								if table.find(bp.Categories, 'AEON') and bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 50000 and bp.Defense and bp.Defense.MaxHealth > 70000 and id ~= "brmt3ava"
									and id ~= "brot3hades" then
									exHLand = exHLand + 1
									table.insert(landUnitsExtremeHeavy.Tech4, id)  --Total Mayhem Experimentals
								end
							--end	
						end
					end
					if table.find(bp.Categories, 'AIR')
					and id ~= "uafsas01" and id ~= "uafsas02" and id ~= "uafsas03" then
						if table.find(bp.Categories, 'AEON') and table.find(bp.Categories, 'AIR') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') then
							if bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 5000 then
								air4 = 1
								table.insert(airUnitsA.Tech4, id)
								countair = countair + 1
							end
						end	
						if table.find(bp.Categories, 'AEON') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH1') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
								LAir = LAir + 1
								table.insert(LAirUnits.Tech4, id)
						end
						if ASFWaves == "Off" then
							if table.find(bp.Categories, 'AEON') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
									MAir = MAir + 1
									table.insert(MAirUnits.Tech4, id)
							end
						end
						if ASFWaves == "Torp Bombers" then
							if table.find(bp.Categories, 'AEON') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
									MAir = MAir + 1
									table.insert(MAirUnits.Tech4, id)
							end
						end
						if ASFWaves == "ASF+Torp Bombers" then
							if table.find(bp.Categories, 'AEON') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
									MAir = MAir + 1
									table.insert(MAirUnits.Tech4, id)
							end
						end
						if ASFWaves == "ASF" then
							if table.find(bp.Categories, 'AEON') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
									MAir = MAir + 1
									table.insert(MAirUnits.Tech4, id)
							end
						end
						if ASFWaves == "Off" then	
							if table.find(bp.Categories, 'AEON') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
									HAir = HAir + 1
									table.insert(HAirUnits.Tech4, id)
							end
						end
						if ASFWaves == "Torp Bombers" then	
							if table.find(bp.Categories, 'AEON') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
									HAir = HAir + 1
									table.insert(HAirUnits.Tech4, id)
							end
						end
						if ASFWaves == "ASF" then	
							if table.find(bp.Categories, 'AEON') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
								HAir = HAir + 1
								table.insert(HAirUnits.Tech4, id)
							end
						end	
						if ASFWaves == "ASF+Torp Bombers" then	
							if table.find(bp.Categories, 'AEON') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
								HAir = HAir + 1
								table.insert(HAirUnits.Tech4, id)
							end
						end
						if ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Air+Navy" or ExperimentalSpawns == "Air" then	
							if table.find(bp.Categories, 'AEON') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'EXPERIMENTAL') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK') 
							or table.find(bp.Categories, 'DIRECTFIRE')) and not table.find(bp.Categories, 'SATELLITE') and bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 65000 then
									EAir = EAir + 1
									table.insert(EAirUnits.Tech4, id)
							end
						end	
					end	
					if table.find(bp.Categories, 'AEON') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'TECH1') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'CQUEMOV') then
							LNavy = LNavy + 1
							table.insert(LNavyUnits.Tech4, id)
					end
					if table.find(bp.Categories, 'AEON') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'TECH2') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'CQUEMOV') then
							MNavy = MNavy + 1
							table.insert(MNavyUnits.Tech4, id)
					end
					if table.find(bp.Categories, 'AEON') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'TECH3') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'CQUEMOV') then
							HNavy = HNavy + 1
							table.insert(HNavyUnits.Tech4, id)
					end
					if ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Air+Navy" or ExperimentalSpawns == "Navy" then
						if table.find(bp.Categories, 'AEON') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'EXPERIMENTAL') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and id ~= "edc0305" then
								ENavy = ENavy + 1
								table.insert(ENavyUnits.Tech4, id)
						end
					end	
				end
			end
		end
	end
	----------------------------------Seraphim Waves----------------------------------------------
	if SeraphimWaves == "Seraphim On" then
	  for id, bp in pairs(__blueprints) do
        if (bp.Categories and string.len(id) >= 5) then
            if table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'ENGINEER') and not table.find(bp.Categories, 'SCOUT') and not table.find(bp.Categories, 'SATELLITE') and not table.find(bp.Categories, 'INSIGNIFICANTUNIT') and not table.find(bp.Categories, 'TACTICALMISSILEPLATFORM')
			and not table.find(bp.Categories, 'INVULNERABLE') and not table.find(bp.Categories, 'UNTARGETABLE') and not table.find(bp.Categories, 'UNSELECTABLE')
			and not table.find(bp.Categories, 'LIGHTDROPCAPSULE') and not table.find(bp.Categories, 'MEDIUMDROPCAPSULE') and not table.find(bp.Categories, 'HEAVYDROPCAPSULE')
			and not table.find(bp.Categories, 'CANTRANSPORTCOMMANDER') then
                if table.find(bp.Categories, 'LAND') and not table.find(bp.Categories, 'INTELLIGENCE') then
                    land4 = 1
                    if id ~= "sbrnt3batu" and id ~= "bel0402" then
                        if LandAmphibious == "All On" then	
								if table.find(bp.Categories, 'SERAPHIM') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 30) and id ~= "uec0001" and id ~= "opc2002" then
									Lland = Lland + 1
									table.insert(landUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
							elseif LandAmphibious == "Amphibious" then
								if table.find(bp.Categories, 'SERAPHIM') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 30) and id ~= "uec0001" and id ~= "opc2002"
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) then
									Lland = Lland + 1
									table.insert(landUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
							elseif LandAmphibious == "No AntiAir" then
								if table.find(bp.Categories, 'SERAPHIM') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 30) and id ~= "uec0001" and id ~= "opc2002"
								and not table.find(bp.Categories, 'ANTIAIR') then
									Lland = Lland + 1
									table.insert(landUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
							elseif LandAmphibious == "Amphibious No AA" then
								if table.find(bp.Categories, 'SERAPHIM') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 30) and id ~= "uec0001" and id ~= "opc2002"
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and not table.find(bp.Categories, 'ANTIAIR') then
									Lland = Lland + 1
									table.insert(landUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
							end
							if LandAmphibious == "All On" then
								if table.find(bp.Categories, 'SERAPHIM') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 100) then
									Mland = Mland + 1
									table.insert(landUnitsM.Tech4, id) --Tech2
								end
							elseif LandAmphibious == "Amphibious" then
								if table.find(bp.Categories, 'SERAPHIM') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 100)
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) then
									Mland = Mland + 1
									table.insert(landUnitsM.Tech4, id) --Tech2
								end
							elseif LandAmphibious == "No AntiAir" then
								if table.find(bp.Categories, 'SERAPHIM') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 100)
								and not table.find(bp.Categories, 'ANTIAIR') then
									Mland = Mland + 1
									table.insert(landUnitsM.Tech4, id) --Tech2
								end
							elseif LandAmphibious == "Amphibious No AA" then
								if table.find(bp.Categories, 'SERAPHIM') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 100)
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and not table.find(bp.Categories, 'ANTIAIR') then
									Mland = Mland + 1
									table.insert(landUnitsM.Tech4, id) --Tech2
								end
							end	
							if LandAmphibious == "All On" then
								if table.find(bp.Categories, 'SERAPHIM') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 200 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and id ~= "sbrot3hadesb") then
									Hland = Hland + 1
									table.insert(landUnitsH.Tech4, id) --Tech3
								end
							elseif LandAmphibious == "Amphibious" then
								if table.find(bp.Categories, 'SERAPHIM') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 200 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and id ~= "sbrot3hadesb") then
									Hland = Hland + 1
									table.insert(landUnitsH.Tech4, id) --Tech3
								end
							elseif LandAmphibious == "No AntiAir" then
								if table.find(bp.Categories, 'SERAPHIM') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 200 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and id ~= "sbrot3hadesb") and not table.find(bp.Categories, 'ANTIAIR') then
									Hland = Hland + 1
									table.insert(landUnitsH.Tech4, id) --Tech3
								end
							elseif LandAmphibious == "Amphibious No AA" then
								if table.find(bp.Categories, 'SERAPHIM') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 200 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and id ~= "sbrot3hadesb") and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and not table.find(bp.Categories, 'ANTIAIR') then
									Hland = Hland + 1
									table.insert(landUnitsH.Tech4, id) --Tech3
								end
							end	
							if table.find(bp.Categories, 'SERAPHIM') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 50000 and table.find(bp.Categories, 'EXPERIMENTAL') and table.find(bp.Categories, 'LAND') and table.find(bp.Categories, 'MOBILE') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
							and id ~= "sbrot3hadesb" and id ~= "brmt3cloaker" and id ~= "ssl0403" and id ~= "srl0401") then
								Eland = Eland + 1
								table.insert(landUnitsE.Tech4, id) --Experimentals
							end
						--if MinorBossSpawns == "Land+Air" or MinorBossSpawns == "Land" then
							if table.find(bp.Categories, 'SERAPHIM') and bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 50000 and bp.Defense and bp.Defense.MaxHealth > 70000 and id ~= "brmt3ava"
								and id ~= "brot3hades" then
								exHLand = exHLand + 1
								table.insert(landUnitsExtremeHeavy.Tech4, id)  --Total Mayhem Experimentals
							end
						--end	
                    end
                end
				if table.find(bp.Categories, 'AIR')
				and id ~= "xsfsas01" and id ~= "xsfsas02" and id ~= "xsfsas03" then
					if table.find(bp.Categories, 'SERAPHIM') and table.find(bp.Categories, 'AIR') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') then
						if bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 5000 then
							air4 = 1
							table.insert(airUnitsA.Tech4, id)
							countair = countair + 1
						end
					end
					if table.find(bp.Categories, 'SERAPHIM') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH1') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
							LAir = LAir + 1
							table.insert(LAirUnits.Tech4, id)
					end
					if ASFWaves == "Off" then
						if table.find(bp.Categories, 'SERAPHIM') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
								MAir = MAir + 1
								table.insert(MAirUnits.Tech4, id)
						end
					end
					if ASFWaves == "Torp Bombers" then
						if table.find(bp.Categories, 'SERAPHIM') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
								MAir = MAir + 1
								table.insert(MAirUnits.Tech4, id)
						end
					end
					if ASFWaves == "ASF+Torp Bombers" then
						if table.find(bp.Categories, 'SERAPHIM') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
								MAir = MAir + 1
								table.insert(MAirUnits.Tech4, id)
						end
					end
					if ASFWaves == "ASF" then
						if table.find(bp.Categories, 'SERAPHIM') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
								MAir = MAir + 1
								table.insert(MAirUnits.Tech4, id)
						end
					end
					if ASFWaves == "Off" then	
						if table.find(bp.Categories, 'SERAPHIM') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
								HAir = HAir + 1
								table.insert(HAirUnits.Tech4, id)
						end
					end
					if ASFWaves == "Torp Bombers" then	
						if table.find(bp.Categories, 'SERAPHIM') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
								HAir = HAir + 1
								table.insert(HAirUnits.Tech4, id)
						end
					end
					if ASFWaves == "ASF" then	
						if table.find(bp.Categories, 'SERAPHIM') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
							HAir = HAir + 1
							table.insert(HAirUnits.Tech4, id)
						end
					end	
					if ASFWaves == "ASF+Torp Bombers" then	
						if table.find(bp.Categories, 'SERAPHIM') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
							HAir = HAir + 1
							table.insert(HAirUnits.Tech4, id)
						end
					end
					if ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Air+Navy" or ExperimentalSpawns == "Air" then	
						if table.find(bp.Categories, 'SERAPHIM') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'EXPERIMENTAL') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK') 
						or table.find(bp.Categories, 'DIRECTFIRE')) and not table.find(bp.Categories, 'SATELLITE') and bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 65000 then
								EAir = EAir + 1
								table.insert(EAirUnits.Tech4, id)
						end
					end	
				end	
				if table.find(bp.Categories, 'SERAPHIM') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'TECH1') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'CQUEMOV') then
						LNavy = LNavy + 1
						table.insert(LNavyUnits.Tech4, id)
				end
				if table.find(bp.Categories, 'SERAPHIM') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'TECH2') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'CQUEMOV') then
						MNavy = MNavy + 1
						table.insert(MNavyUnits.Tech4, id)
				end
				if table.find(bp.Categories, 'SERAPHIM') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'TECH3') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'CQUEMOV') then
						HNavy = HNavy + 1
						table.insert(HNavyUnits.Tech4, id)
				end
				if ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Air+Navy" or ExperimentalSpawns == "Navy" then
					if table.find(bp.Categories, 'SERAPHIM') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'EXPERIMENTAL') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and id ~= "edc0305" then
							ENavy = ENavy + 1
							table.insert(ENavyUnits.Tech4, id)
					end
				end	
			end
        end
      end
	end
	-------------------------------------------------Nomad Waves----------------------------------------
	if NomadWaves == "Nomads On" then
		for id, bp in pairs(__blueprints) do
			if (bp.Categories and string.len(id) >= 5) then
				if table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'ENGINEER') and not table.find(bp.Categories, 'SCOUT') and not table.find(bp.Categories, 'SATELLITE') and not table.find(bp.Categories, 'INSIGNIFICANTUNIT') and not table.find(bp.Categories, 'TACTICALMISSILEPLATFORM') then
					if table.find(bp.Categories, 'LAND') and not table.find(bp.Categories, 'INTELLIGENCE') then
						land4 = 1
						if id ~= "sbrnt3batu" and id ~= "bel0402" then
							if LandAmphibious == "All On" then	
								if table.find(bp.Categories, 'NOMADS') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 30) and id ~= "uec0001" and id ~= "opc2002" then
									Lland = Lland + 1
									table.insert(landUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
							elseif LandAmphibious == "Amphibious" then
								if table.find(bp.Categories, 'NOMADS') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 30) and id ~= "uec0001" and id ~= "opc2002"
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) then
									Lland = Lland + 1
									table.insert(landUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
							elseif LandAmphibious == "No AntiAir" then
								if table.find(bp.Categories, 'NOMADS') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 30) and id ~= "uec0001" and id ~= "opc2002"
								and not table.find(bp.Categories, 'ANTIAIR') then
									Lland = Lland + 1
									table.insert(landUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
							elseif LandAmphibious == "Amphibious No AA" then
								if table.find(bp.Categories, 'NOMADS') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 30) and id ~= "uec0001" and id ~= "opc2002"
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and not table.find(bp.Categories, 'ANTIAIR') then
									Lland = Lland + 1
									table.insert(landUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
							end
							if LandAmphibious == "All On" then
								if table.find(bp.Categories, 'NOMADS') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 100) then
									Mland = Mland + 1
									table.insert(landUnitsM.Tech4, id) --Tech2
								end
							elseif LandAmphibious == "Amphibious" then
								if table.find(bp.Categories, 'NOMADS') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 100)
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) then
									Mland = Mland + 1
									table.insert(landUnitsM.Tech4, id) --Tech2
								end
							elseif LandAmphibious == "No AntiAir" then
								if table.find(bp.Categories, 'NOMADS') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 100)
								and not table.find(bp.Categories, 'ANTIAIR') then
									Mland = Mland + 1
									table.insert(landUnitsM.Tech4, id) --Tech2
								end
							elseif LandAmphibious == "Amphibious No AA" then
								if table.find(bp.Categories, 'NOMADS') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 100)
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and not table.find(bp.Categories, 'ANTIAIR') then
									Mland = Mland + 1
									table.insert(landUnitsM.Tech4, id) --Tech2
								end
							end	
							if LandAmphibious == "All On" then
								if table.find(bp.Categories, 'NOMADS') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 200 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and id ~= "sbrot3hadesb") then
									Hland = Hland + 1
									table.insert(landUnitsH.Tech4, id) --Tech3
								end
							elseif LandAmphibious == "Amphibious" then
								if table.find(bp.Categories, 'NOMADS') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 200 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and id ~= "sbrot3hadesb") then
									Hland = Hland + 1
									table.insert(landUnitsH.Tech4, id) --Tech3
								end
							elseif LandAmphibious == "No AntiAir" then
								if table.find(bp.Categories, 'NOMADS') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 200 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and id ~= "sbrot3hadesb") and not table.find(bp.Categories, 'ANTIAIR') then
									Hland = Hland + 1
									table.insert(landUnitsH.Tech4, id) --Tech3
								end
							elseif LandAmphibious == "Amphibious No AA" then
								if table.find(bp.Categories, 'NOMADS') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 200 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and id ~= "sbrot3hadesb") and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and not table.find(bp.Categories, 'ANTIAIR') then
									Hland = Hland + 1
									table.insert(landUnitsH.Tech4, id) --Tech3
								end
							end	
							--if MinorBossSpawns == "Land+Air" or MinorBossSpawns == "Land" then
								if table.find(bp.Categories, 'NOMADS') and bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 50000 and bp.Defense and bp.Defense.MaxHealth > 70000 and id ~= "brmt3ava"
									and id ~= "brot3hades" then
									exHLand = exHLand + 1
									table.insert(landUnitsExtremeHeavy.Tech4, id)  --Total Mayhem Experimentals
								end
							--end	
						end
					end
					--if MinorBossSpawns == "Land+Air" or MinorBossSpawns == "Air" then
						if table.find(bp.Categories, 'NOMADS') and table.find(bp.Categories, 'AIR') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') then
							if bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 5000 then
								air4 = 1
								table.insert(airUnitsA.Tech4, id)
								countair = countair + 1
							end
						end
					--end	
					if table.find(bp.Categories, 'NOMADS') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 50000 and table.find(bp.Categories, 'EXPERIMENTAL') and table.find(bp.Categories, 'LAND') and table.find(bp.Categories, 'MOBILE') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
							and id ~= "sbrot3hadesb" and id ~= "brmt3cloaker" and id ~= "ssl0403" and id ~= "srl0401") then
							Eland = Eland + 1
							table.insert(landUnitsE.Tech4, id) --Experimentals
					end
					--end	
					if table.find(bp.Categories, 'NOMADS') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH1') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
							LAir = LAir + 1
							table.insert(LAirUnits.Tech4, id)
					end
					if ASFWaves == "Off" then
						if table.find(bp.Categories, 'NOMADS') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
								MAir = MAir + 1
								table.insert(MAirUnits.Tech4, id)
						end
					end
					if ASFWaves == "Torp Bombers" then
						if table.find(bp.Categories, 'NOMADS') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
								MAir = MAir + 1
								table.insert(MAirUnits.Tech4, id)
						end
					end
					if ASFWaves == "ASF+Torp Bombers" then
						if table.find(bp.Categories, 'NOMADS') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
								MAir = MAir + 1
								table.insert(MAirUnits.Tech4, id)
						end
					end
					if ASFWaves == "ASF" then
						if table.find(bp.Categories, 'NOMADS') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
								MAir = MAir + 1
								table.insert(MAirUnits.Tech4, id)
						end
					end
					if ASFWaves == "Off" then	
						if table.find(bp.Categories, 'NOMADS') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
								HAir = HAir + 1
								table.insert(HAirUnits.Tech4, id)
						end
					end
					if ASFWaves == "Torp Bombers" then	
						if table.find(bp.Categories, 'NOMADS') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
								HAir = HAir + 1
								table.insert(HAirUnits.Tech4, id)
						end
					end
					if ASFWaves == "ASF" then	
						if table.find(bp.Categories, 'NOMADS') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
							HAir = HAir + 1
							table.insert(HAirUnits.Tech4, id)
						end
					end	
					if ASFWaves == "ASF+Torp Bombers" then	
						if table.find(bp.Categories, 'NOMADS') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
							HAir = HAir + 1
							table.insert(HAirUnits.Tech4, id)
						end
					end
					if ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Air+Navy" or ExperimentalSpawns == "Air" then	
						if table.find(bp.Categories, 'NOMADS') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'EXPERIMENTAL') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK') 
						or table.find(bp.Categories, 'DIRECTFIRE')) and not table.find(bp.Categories, 'SATELLITE') and bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 65000 then
								EAir = EAir + 1
								table.insert(EAirUnits.Tech4, id)
						end
					end	
					if table.find(bp.Categories, 'NOMADS') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'TECH1') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'CQUEMOV') then
							LNavy = LNavy + 1
							table.insert(LNavyUnits.Tech4, id)
					end
					if table.find(bp.Categories, 'NOMADS') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'TECH2') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'CQUEMOV') then
							MNavy = MNavy + 1
							table.insert(MNavyUnits.Tech4, id)
					end
					if table.find(bp.Categories, 'NOMADS') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'TECH3') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'CQUEMOV') then
							HNavy = HNavy + 1
							table.insert(HNavyUnits.Tech4, id)
					end
					if ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Air+Navy" or ExperimentalSpawns == "Navy" then
						if table.find(bp.Categories, 'NOMADS') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'EXPERIMENTAL') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') then
								ENavy = ENavy + 1
								table.insert(ENavyUnits.Tech4, id)
						end
					end	
				end
			end
		end
	end
end
function TablesForTotalMayhemMods()
    ---------------------------------------UEF Waves-------------------------------------------------------------------------------------------------------------
	if UEFWaves == "UEF On" then
		for id, bp in pairs(__blueprints) do
			if (bp.Categories and string.len(id) >= 5) then
				if table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'ENGINEER') and not table.find(bp.Categories, 'SCOUT') and not table.find(bp.Categories, 'SATELLITE') and not table.find(bp.Categories, 'INSIGNIFICANTUNIT') 
				and not table.find(bp.Categories, 'INVULNERABLE') and not table.find(bp.Categories, 'UNTARGETABLE') and not table.find(bp.Categories, 'UNSELECTABLE')
				and not table.find(bp.Categories, 'LIGHTDROPCAPSULE') and not table.find(bp.Categories, 'MEDIUMDROPCAPSULE') and not table.find(bp.Categories, 'HEAVYDROPCAPSULE')
				and not table.find(bp.Categories, 'CANTRANSPORTCOMMANDER') then
					if table.find(bp.Categories, 'LAND') then
						land4 = 1
						if id ~= "sbrnt3batu" and id ~= "bel0402" then
							--Tech 1--
							if LandAmphibious == "All On" then	--Done
								if table.find(bp.Categories, 'UEF') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 30 and bp.Economy.BuildCostMass <= 400) and id ~= "uec0001" and id ~= "opc2002" then
									Lland = Lland + 1
									table.insert(landUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
								if table.find(bp.Categories, 'UEF') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 400) and id ~= "uec0001" and id ~= "opc2002" then
									LlandHeavy = LlandHeavy + 1
									table.insert(landUnitsLHeavy.Tech4, id) --Heavy T1 Units
								end	
							elseif LandAmphibious == "Amphibious" then --Done
								if table.find(bp.Categories, 'UEF') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 30 and bp.Economy.BuildCostMass <= 400) and id ~= "uec0001" and id ~= "opc2002"
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) then
									Lland = Lland + 1
									table.insert(landUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
								if table.find(bp.Categories, 'UEF') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 400) and id ~= "uec0001" and id ~= "opc2002"
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) then
									LlandHeavy = LlandHeavy + 1
									table.insert(landUnitsLHeavy.Tech4, id) --Heavy T1 Units
								end
							elseif LandAmphibious == "No AntiAir" then --Done
								if table.find(bp.Categories, 'UEF') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 30 and bp.Economy.BuildCostMass <= 400) and id ~= "uec0001" and id ~= "opc2002"
								and not table.find(bp.Categories, 'ANTIAIR') then
									Lland = Lland + 1
									table.insert(landUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
								if table.find(bp.Categories, 'UEF') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 400) and id ~= "uec0001" and id ~= "opc2002"
								and not table.find(bp.Categories, 'ANTIAIR') then
									LlandHeavy = LlandHeavy + 1
									table.insert(landUnitsLHeavy.Tech4, id) --Heavy T1 Units
								end
							elseif LandAmphibious == "Amphibious No AA" then --Done
								if table.find(bp.Categories, 'UEF') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 30 and bp.Economy.BuildCostMass <= 400) and id ~= "uec0001" and id ~= "opc2002"
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and not table.find(bp.Categories, 'ANTIAIR') then
									Lland = Lland + 1
									table.insert(landUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
								if table.find(bp.Categories, 'UEF') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 400) and id ~= "uec0001" and id ~= "opc2002"
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and not table.find(bp.Categories, 'ANTIAIR') then
									LlandHeavy = LlandHeavy + 1
									table.insert(landUnitsLHeavy.Tech4, id) --Heavy T1 Units
								end
							end
							--Tech 2--
							if LandAmphibious == "All On" then --Done
								if table.find(bp.Categories, 'UEF') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 100 and bp.Economy.BuildCostMass <= 1000) then
									Mland = Mland + 1
									table.insert(landUnitsM.Tech4, id) --Tech2
								end
								if table.find(bp.Categories, 'UEF') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 1000) then
									MlandHeavy = MlandHeavy + 1
									table.insert(landUnitsMHeavy.Tech4, id) --Tech2 Heavy
								end
							elseif LandAmphibious == "Amphibious" then --Done
								if table.find(bp.Categories, 'UEF') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 100 and bp.Economy.BuildCostMass <= 1000)
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) then
									Mland = Mland + 1
									table.insert(landUnitsM.Tech4, id) --Tech2
								end
								if table.find(bp.Categories, 'UEF') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 1000)
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) then
									MlandHeavy = MlandHeavy + 1
									table.insert(landUnitsMHeavy.Tech4, id) --Tech2 Heavy
								end
							elseif LandAmphibious == "No AntiAir" then --Done
								if table.find(bp.Categories, 'UEF') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 100 and bp.Economy.BuildCostMass <= 1000)
								and not table.find(bp.Categories, 'ANTIAIR') then
									Mland = Mland + 1
									table.insert(landUnitsM.Tech4, id) --Tech2
								end
								if table.find(bp.Categories, 'UEF') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 1000)
								and not table.find(bp.Categories, 'ANTIAIR') then
									MlandHeavy = MlandHeavy + 1
									table.insert(landUnitsMHeavy.Tech4, id) --Tech2 Heavy
								end
							elseif LandAmphibious == "Amphibious No AA" then --Done
								if table.find(bp.Categories, 'UEF') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 100 and bp.Economy.BuildCostMass <= 1000)
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and not table.find(bp.Categories, 'ANTIAIR') then
									Mland = Mland + 1
									table.insert(landUnitsM.Tech4, id) --Tech2
								end
								if table.find(bp.Categories, 'UEF') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 1000)
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and not table.find(bp.Categories, 'ANTIAIR') then
									MlandHeavy = MlandHeavy + 1
									table.insert(landUnitsMHeavy.Tech4, id) --Tech2
								end	
							end	
							--Tech3--
							if LandAmphibious == "All On" then --Done
								if table.find(bp.Categories, 'UEF') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 200 and bp.Economy.BuildCostMass <= 3000 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and id ~= "sbrot3hadesb") then
									Hland = Hland + 1
									table.insert(landUnitsH.Tech4, id) --Tech3
								end
								if table.find(bp.Categories, 'UEF') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 3000 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and id ~= "sbrot3hadesb") then
									HlandHeavy = HlandHeavy + 1
									table.insert(landUnitsHHeavy.Tech4, id) --Tech3 T4
								end
							elseif LandAmphibious == "Amphibious" then --Done
								if table.find(bp.Categories, 'UEF') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 200 and bp.Economy.BuildCostMass <= 3000 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and id ~= "sbrot3hadesb") then
									Hland = Hland + 1
									table.insert(landUnitsH.Tech4, id) --Tech3
								end
								if table.find(bp.Categories, 'UEF') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 3000 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and id ~= "sbrot3hadesb") then
									HlandHeavy = HlandHeavy + 1
									table.insert(landUnitsHHeavy.Tech4, id) --Tech3 T4
								end
							elseif LandAmphibious == "No AntiAir" then --Done
								if table.find(bp.Categories, 'UEF') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 200 and bp.Economy.BuildCostMass <= 3000 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and id ~= "sbrot3hadesb") and not table.find(bp.Categories, 'ANTIAIR') then
									Hland = Hland + 1
									table.insert(landUnitsH.Tech4, id) --Tech3
								end
								if table.find(bp.Categories, 'UEF') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 3000 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and id ~= "sbrot3hadesb") and not table.find(bp.Categories, 'ANTIAIR') then
									HlandHeavy = HlandHeavy + 1
									table.insert(landUnitsHHeavy.Tech4, id) --Tech3 T4
								end
							elseif LandAmphibious == "Amphibious No AA" then --Done
								if table.find(bp.Categories, 'UEF') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 200 and bp.Economy.BuildCostMass <= 3000 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and id ~= "sbrot3hadesb") and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and not table.find(bp.Categories, 'ANTIAIR') then
									Hland = Hland + 1
									table.insert(landUnitsH.Tech4, id) --Tech3
								end
								if table.find(bp.Categories, 'UEF') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 3000 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and id ~= "sbrot3hadesb") and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and not table.find(bp.Categories, 'ANTIAIR') then
									HlandHeavy = HlandHeavy + 1
									table.insert(landUnitsHHeavy.Tech4, id) --Tech3 T4
								end
							end	
							if table.find(bp.Categories, 'UEF') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 50000 and table.find(bp.Categories, 'EXPERIMENTAL') and table.find(bp.Categories, 'LAND') and table.find(bp.Categories, 'MOBILE') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
							and id ~= "sbrot3hadesb" and id ~= "brmt3cloaker" and id ~= "ssl0403" and id ~= "srl0401") then
								Eland = Eland + 1
								table.insert(landUnitsE.Tech4, id) --Experimentals
							end
									if table.find(bp.Categories, 'UEF') and bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 50000 and bp.Defense and bp.Defense.MaxHealth > 70000 and id ~= "brmt3ava"
										and id ~= "brot3hades" then
										exHLand = exHLand + 1
										table.insert(landUnitsExtremeHeavy.Tech4, id)  --Total Mayhem Experimentals
									end
						end
					end
					--Air--
					if table.find(bp.Categories, 'AIR')
					and id ~= "uefsas01" and id ~= "uefsas02" and id ~= "uefsas03" and id ~= "uefsas04" then
						if table.find(bp.Categories, 'UEF') and table.find(bp.Categories, 'AIR') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') then
							if bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 5000 then
								air4 = 1
								table.insert(airUnitsA.Tech4, id)
								countair = countair + 1
							end
						end
						--Tech 1 Air--
						if table.find(bp.Categories, 'UEF') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH1') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 400) then
								LAir = LAir + 1
								table.insert(LAirUnits.Tech4, id)
						end
						if table.find(bp.Categories, 'UEF') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH1') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 400) then
								LAirHeavy = LAirHeavy + 1
								table.insert(LAirUnitsHeavy.Tech4, id)
						end
						--Tech 2 Air--
						if ASFWaves == "Off" then
							if table.find(bp.Categories, 'UEF') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 1000) then
									MAir = MAir + 1
									table.insert(MAirUnits.Tech4, id)
							end
							if table.find(bp.Categories, 'UEF') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 1000) then
									MAirHeavy = MAirHeavy + 1
									table.insert(MAirUnitsHeavy.Tech4, id)
							end
						end
						if ASFWaves == "Torp Bombers" then
							if table.find(bp.Categories, 'UEF') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 1000) then
									MAir = MAir + 1
									table.insert(MAirUnits.Tech4, id)
							end
							if table.find(bp.Categories, 'UEF') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 1000) then
									MAirHeavy = MAirHeavy + 1
									table.insert(MAirUnitsHeavy.Tech4, id)
							end
						end
						if ASFWaves == "ASF+Torp Bombers" then
							if table.find(bp.Categories, 'UEF') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 1000) then
									MAir = MAir + 1
									table.insert(MAirUnits.Tech4, id)
							end
							if table.find(bp.Categories, 'UEF') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 1000) then
									MAirHeavy = MAirHeavy + 1
									table.insert(MAirUnitsHeavy.Tech4, id)
							end
						end
						if ASFWaves == "ASF" then
							if table.find(bp.Categories, 'UEF') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 1000) then
									MAir = MAir + 1
									table.insert(MAirUnits.Tech4, id)
							end
							if table.find(bp.Categories, 'UEF') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 1000) then
									MAirHeavy = MAirHeavy + 1
									table.insert(MAirUnitsHeavy.Tech4, id)
							end
						end
						--Tech 3 Air--
						if ASFWaves == "Off" then	
							if table.find(bp.Categories, 'UEF') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 3000) then
									HAir = HAir + 1
									table.insert(HAirUnits.Tech4, id)
							end
							if table.find(bp.Categories, 'UEF') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 3000) then
									HAirHeavy = HAirHeavy + 1
									table.insert(HAirUnitsHeavy.Tech4, id)
							end
						end
						if ASFWaves == "Torp Bombers" then	
							if table.find(bp.Categories, 'UEF') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 3000) then
									HAir = HAir + 1
									table.insert(HAirUnits.Tech4, id)
							end
							if table.find(bp.Categories, 'UEF') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 3000) then
									HAirHeavy = HAirHeavy + 1
									table.insert(HAirUnitsHeavy.Tech4, id)
							end
						end
						if ASFWaves == "ASF" then	
							if table.find(bp.Categories, 'UEF') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 3000) then
								HAir = HAir + 1
								table.insert(HAirUnits.Tech4, id)
							end
							if table.find(bp.Categories, 'UEF') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 3000) then
								HAirHeavy = HAirHeavy + 1
								table.insert(HAirUnitsHeavy.Tech4, id)
							end
						end	
						if ASFWaves == "ASF+Torp Bombers" then	
							if table.find(bp.Categories, 'UEF') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 3000) then
								HAir = HAir + 1
								table.insert(HAirUnits.Tech4, id)
							end
							if table.find(bp.Categories, 'UEF') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 3000) then
								HAirHeavy = HAirHeavy + 1
								table.insert(HAirUnitsHeavy.Tech4, id)
							end
						end	
						--T4 Air--
						if ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Air+Navy" or ExperimentalSpawns == "Air" then	
							if table.find(bp.Categories, 'UEF') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'EXPERIMENTAL') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK') 
							or table.find(bp.Categories, 'DIRECTFIRE')) and not table.find(bp.Categories, 'SATELLITE') and bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 65000 then
								EAir = EAir + 1
								table.insert(EAirUnits.Tech4, id)
							end
						end	
					end	
					--Navy--
					--T1 Navy--
					if table.find(bp.Categories, 'UEF') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'TECH1') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'CQUEMOV') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 400) then
							LNavy = LNavy + 1
							table.insert(LNavyUnits.Tech4, id)
					end
					if table.find(bp.Categories, 'UEF') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'TECH1') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'CQUEMOV') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 400) then
							LNavyHeavy = LNavyHeavy + 1
							table.insert(LNavyUnitsHeavy.Tech4, id)
					end
					--T2 Navy--
					if table.find(bp.Categories, 'UEF') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'TECH2') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'CQUEMOV') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 3000) then
							MNavy = MNavy + 1
							table.insert(MNavyUnits.Tech4, id)
					end
					if table.find(bp.Categories, 'UEF') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'TECH2') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'CQUEMOV') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 3000) then
							MNavyHeavy = MNavyHeavy + 1
							table.insert(MNavyUnitsHeavy.Tech4, id)
					end
					--T3 Navy--
					if table.find(bp.Categories, 'UEF') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'TECH3') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'CQUEMOV') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass < 14000) then
							HNavy = HNavy + 1
							table.insert(HNavyUnits.Tech4, id)
					end
					if table.find(bp.Categories, 'UEF') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'TECH3') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'CQUEMOV') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass >= 14000) then
							HNavyHeavy = HNavyHeavy + 1
							table.insert(HNavyUnitsHeavy.Tech4, id)
					end
					--T4 Navy--
					if ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Air+Navy" or ExperimentalSpawns == "Navy" then
						if table.find(bp.Categories, 'UEF') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'EXPERIMENTAL') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and id ~= "edc0305" then
							ENavy = ENavy + 1
							table.insert(ENavyUnits.Tech4, id)
						end
					end	
				end
			end
		end
	end
	--------------------------------CYBRAN Waves--------------------------------------------------------------------
	if CybranWaves == "Cybran On" then
		for id, bp in pairs(__blueprints) do
			if (bp.Categories and string.len(id) >= 5) then
				if table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'ENGINEER') and not table.find(bp.Categories, 'SCOUT') and not table.find(bp.Categories, 'SATELLITE') and not table.find(bp.Categories, 'INSIGNIFICANTUNIT') 
				and not table.find(bp.Categories, 'INVULNERABLE') and not table.find(bp.Categories, 'UNTARGETABLE') and not table.find(bp.Categories, 'UNSELECTABLE')
				and not table.find(bp.Categories, 'LIGHTDROPCAPSULE') and not table.find(bp.Categories, 'MEDIUMDROPCAPSULE') and not table.find(bp.Categories, 'HEAVYDROPCAPSULE')
				and not table.find(bp.Categories, 'CANTRANSPORTCOMMANDER') then
					if table.find(bp.Categories, 'LAND') then
						land4 = 1
						if id ~= "sbrnt3batu" and id ~= "bel0402" then
							--Tech 1--
							if LandAmphibious == "All On" then	--Done
								if table.find(bp.Categories, 'CYBRAN') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 30 and bp.Economy.BuildCostMass <= 400) and id ~= "uec0001" and id ~= "opc2002" then
									Lland = Lland + 1
									table.insert(landUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
								if table.find(bp.Categories, 'CYBRAN') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 400) and id ~= "uec0001" and id ~= "opc2002" then
									LlandHeavy = LlandHeavy + 1
									table.insert(landUnitsLHeavy.Tech4, id) --Heavy T1 Units
								end	
							elseif LandAmphibious == "Amphibious" then --Done
								if table.find(bp.Categories, 'CYBRAN') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 30 and bp.Economy.BuildCostMass <= 400) and id ~= "uec0001" and id ~= "opc2002"
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) then
									Lland = Lland + 1
									table.insert(landUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
								if table.find(bp.Categories, 'CYBRAN') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 400) and id ~= "uec0001" and id ~= "opc2002"
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) then
									LlandHeavy = LlandHeavy + 1
									table.insert(landUnitsLHeavy.Tech4, id) --Heavy T1 Units
								end
							elseif LandAmphibious == "No AntiAir" then --Done
								if table.find(bp.Categories, 'CYBRAN') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 30 and bp.Economy.BuildCostMass <= 400) and id ~= "uec0001" and id ~= "opc2002"
								and not table.find(bp.Categories, 'ANTIAIR') then
									Lland = Lland + 1
									table.insert(landUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
								if table.find(bp.Categories, 'CYBRAN') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 400) and id ~= "uec0001" and id ~= "opc2002"
								and not table.find(bp.Categories, 'ANTIAIR') then
									LlandHeavy = LlandHeavy + 1
									table.insert(landUnitsLHeavy.Tech4, id) --Heavy T1 Units
								end
							elseif LandAmphibious == "Amphibious No AA" then --Done
								if table.find(bp.Categories, 'CYBRAN') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 30 and bp.Economy.BuildCostMass <= 400) and id ~= "uec0001" and id ~= "opc2002"
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and not table.find(bp.Categories, 'ANTIAIR') then
									Lland = Lland + 1
									table.insert(landUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
								if table.find(bp.Categories, 'CYBRAN') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 400) and id ~= "uec0001" and id ~= "opc2002"
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and not table.find(bp.Categories, 'ANTIAIR') then
									LlandHeavy = LlandHeavy + 1
									table.insert(landUnitsLHeavy.Tech4, id) --Heavy T1 Units
								end
							end
							--Tech 2--
							if LandAmphibious == "All On" then --Done
								if table.find(bp.Categories, 'CYBRAN') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 100 and bp.Economy.BuildCostMass <= 1000) then
									Mland = Mland + 1
									table.insert(landUnitsM.Tech4, id) --Tech2
								end
								if table.find(bp.Categories, 'CYBRAN') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 1000) then
									MlandHeavy = MlandHeavy + 1
									table.insert(landUnitsMHeavy.Tech4, id) --Tech2 Heavy
								end
							elseif LandAmphibious == "Amphibious" then --Done
								if table.find(bp.Categories, 'CYBRAN') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 100 and bp.Economy.BuildCostMass <= 1000)
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) then
									Mland = Mland + 1
									table.insert(landUnitsM.Tech4, id) --Tech2
								end
								if table.find(bp.Categories, 'CYBRAN') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 1000)
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) then
									MlandHeavy = MlandHeavy + 1
									table.insert(landUnitsMHeavy.Tech4, id) --Tech2 Heavy
								end
							elseif LandAmphibious == "No AntiAir" then --Done
								if table.find(bp.Categories, 'CYBRAN') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 100 and bp.Economy.BuildCostMass <= 1000)
								and not table.find(bp.Categories, 'ANTIAIR') then
									Mland = Mland + 1
									table.insert(landUnitsM.Tech4, id) --Tech2
								end
								if table.find(bp.Categories, 'CYBRAN') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 1000)
								and not table.find(bp.Categories, 'ANTIAIR') then
									MlandHeavy = MlandHeavy + 1
									table.insert(landUnitsMHeavy.Tech4, id) --Tech2 Heavy
								end
							elseif LandAmphibious == "Amphibious No AA" then --Done
								if table.find(bp.Categories, 'CYBRAN') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 100 and bp.Economy.BuildCostMass <= 1000)
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and not table.find(bp.Categories, 'ANTIAIR') then
									Mland = Mland + 1
									table.insert(landUnitsM.Tech4, id) --Tech2
								end
								if table.find(bp.Categories, 'CYBRAN') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 1000)
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and not table.find(bp.Categories, 'ANTIAIR') then
									MlandHeavy = MlandHeavy + 1
									table.insert(landUnitsMHeavy.Tech4, id) --Tech2
								end	
							end	
							--Tech3--
							if LandAmphibious == "All On" then --Done
								if table.find(bp.Categories, 'CYBRAN') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 200 and bp.Economy.BuildCostMass <= 3000 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and id ~= "sbrot3hadesb") then
									Hland = Hland + 1
									table.insert(landUnitsH.Tech4, id) --Tech3
								end
								if table.find(bp.Categories, 'CYBRAN') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 3000 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and id ~= "sbrot3hadesb") then
									HlandHeavy = HlandHeavy + 1
									table.insert(landUnitsHHeavy.Tech4, id) --Tech3 T4
								end
							elseif LandAmphibious == "Amphibious" then --Done
								if table.find(bp.Categories, 'CYBRAN') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 200 and bp.Economy.BuildCostMass <= 3000 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and id ~= "sbrot3hadesb") then
									Hland = Hland + 1
									table.insert(landUnitsH.Tech4, id) --Tech3
								end
								if table.find(bp.Categories, 'CYBRAN') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 3000 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and id ~= "sbrot3hadesb") then
									HlandHeavy = HlandHeavy + 1
									table.insert(landUnitsHHeavy.Tech4, id) --Tech3 T4
								end
							elseif LandAmphibious == "No AntiAir" then --Done
								if table.find(bp.Categories, 'CYBRAN') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 200 and bp.Economy.BuildCostMass <= 3000 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and id ~= "sbrot3hadesb") and not table.find(bp.Categories, 'ANTIAIR') then
									Hland = Hland + 1
									table.insert(landUnitsH.Tech4, id) --Tech3
								end
								if table.find(bp.Categories, 'CYBRAN') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 3000 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and id ~= "sbrot3hadesb") and not table.find(bp.Categories, 'ANTIAIR') then
									HlandHeavy = HlandHeavy + 1
									table.insert(landUnitsHHeavy.Tech4, id) --Tech3 T4
								end
							elseif LandAmphibious == "Amphibious No AA" then --Done
								if table.find(bp.Categories, 'CYBRAN') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 200 and bp.Economy.BuildCostMass <= 3000 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and id ~= "sbrot3hadesb") and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and not table.find(bp.Categories, 'ANTIAIR') then
									Hland = Hland + 1
									table.insert(landUnitsH.Tech4, id) --Tech3
								end
								if table.find(bp.Categories, 'CYBRAN') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 3000 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and id ~= "sbrot3hadesb") and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and not table.find(bp.Categories, 'ANTIAIR') then
									HlandHeavy = HlandHeavy + 1
									table.insert(landUnitsHHeavy.Tech4, id) --Tech3 T4
								end
							end	
							if table.find(bp.Categories, 'CYBRAN') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 50000 and table.find(bp.Categories, 'EXPERIMENTAL') and table.find(bp.Categories, 'LAND') and table.find(bp.Categories, 'MOBILE') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
							and id ~= "sbrot3hadesb" and id ~= "brmt3cloaker" and id ~= "ssl0403" and id ~= "srl0401") then
								Eland = Eland + 1
								table.insert(landUnitsE.Tech4, id) --Experimentals
							end
									if table.find(bp.Categories, 'CYBRAN') and bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 50000 and bp.Defense and bp.Defense.MaxHealth > 70000 and id ~= "brmt3ava"
										and id ~= "brot3hades" then
										exHLand = exHLand + 1
										table.insert(landUnitsExtremeHeavy.Tech4, id)  --Total Mayhem Experimentals
									end
						end
					end
					--Air--
					if table.find(bp.Categories, 'AIR')
					and id ~= "urfsas01" and id ~= "urfsas02" and id ~= "urfsas03" then
						if table.find(bp.Categories, 'CYBRAN') and table.find(bp.Categories, 'AIR') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') then
							if bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 5000 then
								air4 = 1
								table.insert(airUnitsA.Tech4, id)
								countair = countair + 1
							end
						end
						--Tech 1 Air--
						if table.find(bp.Categories, 'CYBRAN') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH1') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 400) then
								LAir = LAir + 1
								table.insert(LAirUnits.Tech4, id)
						end
						if table.find(bp.Categories, 'CYBRAN') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH1') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 400) then
								LAirHeavy = LAirHeavy + 1
								table.insert(LAirUnitsHeavy.Tech4, id)
						end
						--Tech 2 Air--
						if ASFWaves == "Off" then
							if table.find(bp.Categories, 'CYBRAN') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 1000) then
									MAir = MAir + 1
									table.insert(MAirUnits.Tech4, id)
							end
							if table.find(bp.Categories, 'CYBRAN') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 1000) then
									MAirHeavy = MAirHeavy + 1
									table.insert(MAirUnitsHeavy.Tech4, id)
							end
						end
						if ASFWaves == "Torp Bombers" then
							if table.find(bp.Categories, 'CYBRAN') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 1000) then
									MAir = MAir + 1
									table.insert(MAirUnits.Tech4, id)
							end
							if table.find(bp.Categories, 'CYBRAN') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 1000) then
									MAirHeavy = MAirHeavy + 1
									table.insert(MAirUnitsHeavy.Tech4, id)
							end
						end
						if ASFWaves == "ASF+Torp Bombers" then
							if table.find(bp.Categories, 'CYBRAN') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 1000) then
									MAir = MAir + 1
									table.insert(MAirUnits.Tech4, id)
							end
							if table.find(bp.Categories, 'CYBRAN') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 1000) then
									MAirHeavy = MAirHeavy + 1
									table.insert(MAirUnitsHeavy.Tech4, id)
							end
						end
						if ASFWaves == "ASF" then
							if table.find(bp.Categories, 'CYBRAN') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 1000) then
									MAir = MAir + 1
									table.insert(MAirUnits.Tech4, id)
							end
							if table.find(bp.Categories, 'CYBRAN') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 1000) then
									MAirHeavy = MAirHeavy + 1
									table.insert(MAirUnitsHeavy.Tech4, id)
							end
						end
						--Tech 3 Air--
						if ASFWaves == "Off" then	
							if table.find(bp.Categories, 'CYBRAN') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 3000) then
									HAir = HAir + 1
									table.insert(HAirUnits.Tech4, id)
							end
							if table.find(bp.Categories, 'CYBRAN') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 3000) then
									HAirHeavy = HAirHeavy + 1
									table.insert(HAirUnitsHeavy.Tech4, id)
							end
						end
						if ASFWaves == "Torp Bombers" then	
							if table.find(bp.Categories, 'CYBRAN') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 3000) then
									HAir = HAir + 1
									table.insert(HAirUnits.Tech4, id)
							end
							if table.find(bp.Categories, 'CYBRAN') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 3000) then
									HAirHeavy = HAirHeavy + 1
									table.insert(HAirUnitsHeavy.Tech4, id)
							end
						end
						if ASFWaves == "ASF" then	
							if table.find(bp.Categories, 'CYBRAN') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 3000) then
								HAir = HAir + 1
								table.insert(HAirUnits.Tech4, id)
							end
							if table.find(bp.Categories, 'CYBRAN') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 3000) then
								HAirHeavy = HAirHeavy + 1
								table.insert(HAirUnitsHeavy.Tech4, id)
							end
						end	
						if ASFWaves == "ASF+Torp Bombers" then	
							if table.find(bp.Categories, 'CYBRAN') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 3000) then
								HAir = HAir + 1
								table.insert(HAirUnits.Tech4, id)
							end
							if table.find(bp.Categories, 'CYBRAN') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 3000) then
								HAirHeavy = HAirHeavy + 1
								table.insert(HAirUnitsHeavy.Tech4, id)
							end
						end	
						--T4 Air--
						if ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Air+Navy" or ExperimentalSpawns == "Air" then	
							if table.find(bp.Categories, 'CYBRAN') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'EXPERIMENTAL') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK') 
							or table.find(bp.Categories, 'DIRECTFIRE')) and not table.find(bp.Categories, 'SATELLITE') and bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 65000 then
								EAir = EAir + 1
								table.insert(EAirUnits.Tech4, id)
							end
						end	
					end	
					--Navy--
					--T1 Navy--
					if table.find(bp.Categories, 'CYBRAN') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'TECH1') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'CQUEMOV') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 400) then
							LNavy = LNavy + 1
							table.insert(LNavyUnits.Tech4, id)
					end
					if table.find(bp.Categories, 'CYBRAN') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'TECH1') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'CQUEMOV') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 400) then
							LNavyHeavy = LNavyHeavy + 1
							table.insert(LNavyUnitsHeavy.Tech4, id)
					end
					--T2 Navy--
					if table.find(bp.Categories, 'CYBRAN') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'TECH2') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'CQUEMOV') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 3000) then
							MNavy = MNavy + 1
							table.insert(MNavyUnits.Tech4, id)
					end
					if table.find(bp.Categories, 'CYBRAN') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'TECH2') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'CQUEMOV') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 3000) then
							MNavyHeavy = MNavyHeavy + 1
							table.insert(MNavyUnitsHeavy.Tech4, id)
					end
					--T3 Navy--
					if table.find(bp.Categories, 'CYBRAN') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'TECH3') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'CQUEMOV') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass < 14000) then
							HNavy = HNavy + 1
							table.insert(HNavyUnits.Tech4, id)
					end
					if table.find(bp.Categories, 'CYBRAN') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'TECH3') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'CQUEMOV') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass >= 14000) then
							HNavyHeavy = HNavyHeavy + 1
							table.insert(HNavyUnitsHeavy.Tech4, id)
					end
					--T4 Navy--
					if ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Air+Navy" or ExperimentalSpawns == "Navy" then
						if table.find(bp.Categories, 'CYBRAN') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'EXPERIMENTAL') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and id ~= "edc0305" then
							ENavy = ENavy + 1
							table.insert(ENavyUnits.Tech4, id)
						end
					end	
				end
			end
		end
	end  
	--------------------------------AEON WAVES------------------------------------------------------------------
	if AeonWaves == "Aeon On" then
		for id, bp in pairs(__blueprints) do
			if (bp.Categories and string.len(id) >= 5) then
				if table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'ENGINEER') and not table.find(bp.Categories, 'SCOUT') and not table.find(bp.Categories, 'SATELLITE') and not table.find(bp.Categories, 'INSIGNIFICANTUNIT') 
				and not table.find(bp.Categories, 'INVULNERABLE') and not table.find(bp.Categories, 'UNTARGETABLE') and not table.find(bp.Categories, 'UNSELECTABLE')
				and not table.find(bp.Categories, 'LIGHTDROPCAPSULE') and not table.find(bp.Categories, 'MEDIUMDROPCAPSULE') and not table.find(bp.Categories, 'HEAVYDROPCAPSULE')
				and not table.find(bp.Categories, 'CANTRANSPORTCOMMANDER') then
					if table.find(bp.Categories, 'LAND') then
						land4 = 1
						if id ~= "sbrnt3batu" and id ~= "bel0402" then
							--Tech 1--
							if LandAmphibious == "All On" then	--Done
								if table.find(bp.Categories, 'AEON') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 30 and bp.Economy.BuildCostMass <= 400) and id ~= "uec0001" and id ~= "opc2002" then
									Lland = Lland + 1
									table.insert(landUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
								if table.find(bp.Categories, 'AEON') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 400) and id ~= "uec0001" and id ~= "opc2002" then
									LlandHeavy = LlandHeavy + 1
									table.insert(landUnitsLHeavy.Tech4, id) --Heavy T1 Units
								end	
							elseif LandAmphibious == "Amphibious" then --Done
								if table.find(bp.Categories, 'AEON') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 30 and bp.Economy.BuildCostMass <= 400) and id ~= "uec0001" and id ~= "opc2002"
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) then
									Lland = Lland + 1
									table.insert(landUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
								if table.find(bp.Categories, 'AEON') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 400) and id ~= "uec0001" and id ~= "opc2002"
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) then
									LlandHeavy = LlandHeavy + 1
									table.insert(landUnitsLHeavy.Tech4, id) --Heavy T1 Units
								end
							elseif LandAmphibious == "No AntiAir" then --Done
								if table.find(bp.Categories, 'AEON') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 30 and bp.Economy.BuildCostMass <= 400) and id ~= "uec0001" and id ~= "opc2002"
								and not table.find(bp.Categories, 'ANTIAIR') then
									Lland = Lland + 1
									table.insert(landUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
								if table.find(bp.Categories, 'AEON') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 400) and id ~= "uec0001" and id ~= "opc2002"
								and not table.find(bp.Categories, 'ANTIAIR') then
									LlandHeavy = LlandHeavy + 1
									table.insert(landUnitsLHeavy.Tech4, id) --Heavy T1 Units
								end
							elseif LandAmphibious == "Amphibious No AA" then --Done
								if table.find(bp.Categories, 'AEON') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 30 and bp.Economy.BuildCostMass <= 400) and id ~= "uec0001" and id ~= "opc2002"
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and not table.find(bp.Categories, 'ANTIAIR') then
									Lland = Lland + 1
									table.insert(landUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
								if table.find(bp.Categories, 'AEON') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 400) and id ~= "uec0001" and id ~= "opc2002"
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and not table.find(bp.Categories, 'ANTIAIR') then
									LlandHeavy = LlandHeavy + 1
									table.insert(landUnitsLHeavy.Tech4, id) --Heavy T1 Units
								end
							end
							--Tech 2--
							if LandAmphibious == "All On" then --Done
								if table.find(bp.Categories, 'AEON') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 100 and bp.Economy.BuildCostMass <= 1000) then
									Mland = Mland + 1
									table.insert(landUnitsM.Tech4, id) --Tech2
								end
								if table.find(bp.Categories, 'AEON') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 1000) then
									MlandHeavy = MlandHeavy + 1
									table.insert(landUnitsMHeavy.Tech4, id) --Tech2 Heavy
								end
							elseif LandAmphibious == "Amphibious" then --Done
								if table.find(bp.Categories, 'AEON') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 100 and bp.Economy.BuildCostMass <= 1000)
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) then
									Mland = Mland + 1
									table.insert(landUnitsM.Tech4, id) --Tech2
								end
								if table.find(bp.Categories, 'AEON') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 1000)
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) then
									MlandHeavy = MlandHeavy + 1
									table.insert(landUnitsMHeavy.Tech4, id) --Tech2 Heavy
								end
							elseif LandAmphibious == "No AntiAir" then --Done
								if table.find(bp.Categories, 'AEON') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 100 and bp.Economy.BuildCostMass <= 1000)
								and not table.find(bp.Categories, 'ANTIAIR') then
									Mland = Mland + 1
									table.insert(landUnitsM.Tech4, id) --Tech2
								end
								if table.find(bp.Categories, 'AEON') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 1000)
								and not table.find(bp.Categories, 'ANTIAIR') then
									MlandHeavy = MlandHeavy + 1
									table.insert(landUnitsMHeavy.Tech4, id) --Tech2 Heavy
								end
							elseif LandAmphibious == "Amphibious No AA" then --Done
								if table.find(bp.Categories, 'AEON') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 100 and bp.Economy.BuildCostMass <= 1000)
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and not table.find(bp.Categories, 'ANTIAIR') then
									Mland = Mland + 1
									table.insert(landUnitsM.Tech4, id) --Tech2
								end
								if table.find(bp.Categories, 'AEON') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 1000)
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and not table.find(bp.Categories, 'ANTIAIR') then
									MlandHeavy = MlandHeavy + 1
									table.insert(landUnitsMHeavy.Tech4, id) --Tech2
								end	
							end	
							--Tech3--
							if LandAmphibious == "All On" then --Done
								if table.find(bp.Categories, 'AEON') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 200 and bp.Economy.BuildCostMass <= 3000 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and id ~= "sbrot3hadesb") then
									Hland = Hland + 1
									table.insert(landUnitsH.Tech4, id) --Tech3
								end
								if table.find(bp.Categories, 'AEON') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 3000 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and id ~= "sbrot3hadesb") then
									HlandHeavy = HlandHeavy + 1
									table.insert(landUnitsHHeavy.Tech4, id) --Tech3 T4
								end
							elseif LandAmphibious == "Amphibious" then --Done
								if table.find(bp.Categories, 'AEON') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 200 and bp.Economy.BuildCostMass <= 3000 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and id ~= "sbrot3hadesb") then
									Hland = Hland + 1
									table.insert(landUnitsH.Tech4, id) --Tech3
								end
								if table.find(bp.Categories, 'AEON') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 3000 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and id ~= "sbrot3hadesb") then
									HlandHeavy = HlandHeavy + 1
									table.insert(landUnitsHHeavy.Tech4, id) --Tech3 T4
								end
							elseif LandAmphibious == "No AntiAir" then --Done
								if table.find(bp.Categories, 'AEON') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 200 and bp.Economy.BuildCostMass <= 3000 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and id ~= "sbrot3hadesb") and not table.find(bp.Categories, 'ANTIAIR') then
									Hland = Hland + 1
									table.insert(landUnitsH.Tech4, id) --Tech3
								end
								if table.find(bp.Categories, 'AEON') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 3000 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and id ~= "sbrot3hadesb") and not table.find(bp.Categories, 'ANTIAIR') then
									HlandHeavy = HlandHeavy + 1
									table.insert(landUnitsHHeavy.Tech4, id) --Tech3 T4
								end
							elseif LandAmphibious == "Amphibious No AA" then --Done
								if table.find(bp.Categories, 'AEON') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 200 and bp.Economy.BuildCostMass <= 3000 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and id ~= "sbrot3hadesb") and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and not table.find(bp.Categories, 'ANTIAIR') then
									Hland = Hland + 1
									table.insert(landUnitsH.Tech4, id) --Tech3
								end
								if table.find(bp.Categories, 'AEON') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 3000 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and id ~= "sbrot3hadesb") and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and not table.find(bp.Categories, 'ANTIAIR') then
									HlandHeavy = HlandHeavy + 1
									table.insert(landUnitsHHeavy.Tech4, id) --Tech3 T4
								end
							end	
							if table.find(bp.Categories, 'AEON') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 50000 and table.find(bp.Categories, 'EXPERIMENTAL') and table.find(bp.Categories, 'LAND') and table.find(bp.Categories, 'MOBILE') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
							and id ~= "sbrot3hadesb" and id ~= "brmt3cloaker" and id ~= "ssl0403" and id ~= "srl0401") then
								Eland = Eland + 1
								table.insert(landUnitsE.Tech4, id) --Experimentals
							end
									if table.find(bp.Categories, 'AEON') and bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 50000 and bp.Defense and bp.Defense.MaxHealth > 70000 and id ~= "brmt3ava"
										and id ~= "brot3hades" then
										exHLand = exHLand + 1
										table.insert(landUnitsExtremeHeavy.Tech4, id)  --Total Mayhem Experimentals
									end
						end
					end
					--Air--
					if table.find(bp.Categories, 'AIR')
					and id ~= "uafsas01" and id ~= "uafsas02" and id ~= "uafsas03" then
						if table.find(bp.Categories, 'AEON') and table.find(bp.Categories, 'AIR') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') then
							if bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 5000 then
								air4 = 1
								table.insert(airUnitsA.Tech4, id)
								countair = countair + 1
							end
						end
						--Tech 1 Air--
						if table.find(bp.Categories, 'AEON') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH1') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 400) then
								LAir = LAir + 1
								table.insert(LAirUnits.Tech4, id)
						end
						if table.find(bp.Categories, 'AEON') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH1') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 400) then
								LAirHeavy = LAirHeavy + 1
								table.insert(LAirUnitsHeavy.Tech4, id)
						end
						--Tech 2 Air--
						if ASFWaves == "Off" then
							if table.find(bp.Categories, 'AEON') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 1000) then
									MAir = MAir + 1
									table.insert(MAirUnits.Tech4, id)
							end
							if table.find(bp.Categories, 'AEON') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 1000) then
									MAirHeavy = MAirHeavy + 1
									table.insert(MAirUnitsHeavy.Tech4, id)
							end
						end
						if ASFWaves == "Torp Bombers" then
							if table.find(bp.Categories, 'AEON') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 1000) then
									MAir = MAir + 1
									table.insert(MAirUnits.Tech4, id)
							end
							if table.find(bp.Categories, 'AEON') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 1000) then
									MAirHeavy = MAirHeavy + 1
									table.insert(MAirUnitsHeavy.Tech4, id)
							end
						end
						if ASFWaves == "ASF+Torp Bombers" then
							if table.find(bp.Categories, 'AEON') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 1000) then
									MAir = MAir + 1
									table.insert(MAirUnits.Tech4, id)
							end
							if table.find(bp.Categories, 'AEON') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 1000) then
									MAirHeavy = MAirHeavy + 1
									table.insert(MAirUnitsHeavy.Tech4, id)
							end
						end
						if ASFWaves == "ASF" then
							if table.find(bp.Categories, 'AEON') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 1000) then
									MAir = MAir + 1
									table.insert(MAirUnits.Tech4, id)
							end
							if table.find(bp.Categories, 'AEON') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 1000) then
									MAirHeavy = MAirHeavy + 1
									table.insert(MAirUnitsHeavy.Tech4, id)
							end
						end
						--Tech 3 Air--
						if ASFWaves == "Off" then	
							if table.find(bp.Categories, 'AEON') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 3000) then
									HAir = HAir + 1
									table.insert(HAirUnits.Tech4, id)
							end
							if table.find(bp.Categories, 'AEON') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 3000) then
									HAirHeavy = HAirHeavy + 1
									table.insert(HAirUnitsHeavy.Tech4, id)
							end
						end
						if ASFWaves == "Torp Bombers" then	
							if table.find(bp.Categories, 'AEON') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 3000) then
									HAir = HAir + 1
									table.insert(HAirUnits.Tech4, id)
							end
							if table.find(bp.Categories, 'AEON') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 3000) then
									HAirHeavy = HAirHeavy + 1
									table.insert(HAirUnitsHeavy.Tech4, id)
							end
						end
						if ASFWaves == "ASF" then	
							if table.find(bp.Categories, 'AEON') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 3000) then
								HAir = HAir + 1
								table.insert(HAirUnits.Tech4, id)
							end
							if table.find(bp.Categories, 'AEON') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 3000) then
								HAirHeavy = HAirHeavy + 1
								table.insert(HAirUnitsHeavy.Tech4, id)
							end
						end	
						if ASFWaves == "ASF+Torp Bombers" then	
							if table.find(bp.Categories, 'AEON') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 3000) then
								HAir = HAir + 1
								table.insert(HAirUnits.Tech4, id)
							end
							if table.find(bp.Categories, 'AEON') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 3000) then
								HAirHeavy = HAirHeavy + 1
								table.insert(HAirUnitsHeavy.Tech4, id)
							end
						end	
						--T4 Air--
						if ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Air+Navy" or ExperimentalSpawns == "Air" then	
							if table.find(bp.Categories, 'AEON') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'EXPERIMENTAL') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK') 
							or table.find(bp.Categories, 'DIRECTFIRE')) and not table.find(bp.Categories, 'SATELLITE') and bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 65000 then
								EAir = EAir + 1
								table.insert(EAirUnits.Tech4, id)
							end
						end	
					end	
					--Navy--
					--T1 Navy--
					if table.find(bp.Categories, 'AEON') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'TECH1') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'CQUEMOV') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 400) then
							LNavy = LNavy + 1
							table.insert(LNavyUnits.Tech4, id)
					end
					if table.find(bp.Categories, 'AEON') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'TECH1') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'CQUEMOV') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 400) then
							LNavyHeavy = LNavyHeavy + 1
							table.insert(LNavyUnitsHeavy.Tech4, id)
					end
					--T2 Navy--
					if table.find(bp.Categories, 'AEON') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'TECH2') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'CQUEMOV') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 3000) then
							MNavy = MNavy + 1
							table.insert(MNavyUnits.Tech4, id)
					end
					if table.find(bp.Categories, 'AEON') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'TECH2') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'CQUEMOV') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 3000) then
							MNavyHeavy = MNavyHeavy + 1
							table.insert(MNavyUnitsHeavy.Tech4, id)
					end
					--T3 Navy--
					if table.find(bp.Categories, 'AEON') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'TECH3') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'CQUEMOV') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass < 14000) then
							HNavy = HNavy + 1
							table.insert(HNavyUnits.Tech4, id)
					end
					if table.find(bp.Categories, 'AEON') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'TECH3') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'CQUEMOV') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass >= 14000) then
							HNavyHeavy = HNavyHeavy + 1
							table.insert(HNavyUnitsHeavy.Tech4, id)
					end
					--T4 Navy--
					if ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Air+Navy" or ExperimentalSpawns == "Navy" then
						if table.find(bp.Categories, 'AEON') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'EXPERIMENTAL') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and id ~= "edc0305" then
							ENavy = ENavy + 1
							table.insert(ENavyUnits.Tech4, id)
						end
					end	
				end
			end
		end
	end
	----------------------------------Seraphim Waves----------------------------------------------
	if SeraphimWaves == "Seraphim On" then
	  for id, bp in pairs(__blueprints) do
			if (bp.Categories and string.len(id) >= 5) then
				if table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'ENGINEER') and not table.find(bp.Categories, 'SCOUT') and not table.find(bp.Categories, 'SATELLITE') and not table.find(bp.Categories, 'INSIGNIFICANTUNIT') 
				and not table.find(bp.Categories, 'INVULNERABLE') and not table.find(bp.Categories, 'UNTARGETABLE') and not table.find(bp.Categories, 'UNSELECTABLE')
				and not table.find(bp.Categories, 'LIGHTDROPCAPSULE') and not table.find(bp.Categories, 'MEDIUMDROPCAPSULE') and not table.find(bp.Categories, 'HEAVYDROPCAPSULE')
				and not table.find(bp.Categories, 'CANTRANSPORTCOMMANDER') then
					if table.find(bp.Categories, 'LAND') then
						land4 = 1
						if id ~= "sbrnt3batu" and id ~= "bel0402" then
							--Tech 1--
							if LandAmphibious == "All On" then	--Done
								if table.find(bp.Categories, 'SERAPHIM') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 30 and bp.Economy.BuildCostMass <= 400) and id ~= "uec0001" and id ~= "opc2002" then
									Lland = Lland + 1
									table.insert(landUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
								if table.find(bp.Categories, 'SERAPHIM') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 400) and id ~= "uec0001" and id ~= "opc2002" then
									LlandHeavy = LlandHeavy + 1
									table.insert(landUnitsLHeavy.Tech4, id) --Heavy T1 Units
								end	
							elseif LandAmphibious == "Amphibious" then --Done
								if table.find(bp.Categories, 'SERAPHIM') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 30 and bp.Economy.BuildCostMass <= 400) and id ~= "uec0001" and id ~= "opc2002"
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) then
									Lland = Lland + 1
									table.insert(landUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
								if table.find(bp.Categories, 'SERAPHIM') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 400) and id ~= "uec0001" and id ~= "opc2002"
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) then
									LlandHeavy = LlandHeavy + 1
									table.insert(landUnitsLHeavy.Tech4, id) --Heavy T1 Units
								end
							elseif LandAmphibious == "No AntiAir" then --Done
								if table.find(bp.Categories, 'SERAPHIM') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 30 and bp.Economy.BuildCostMass <= 400) and id ~= "uec0001" and id ~= "opc2002"
								and not table.find(bp.Categories, 'ANTIAIR') then
									Lland = Lland + 1
									table.insert(landUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
								if table.find(bp.Categories, 'SERAPHIM') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 400) and id ~= "uec0001" and id ~= "opc2002"
								and not table.find(bp.Categories, 'ANTIAIR') then
									LlandHeavy = LlandHeavy + 1
									table.insert(landUnitsLHeavy.Tech4, id) --Heavy T1 Units
								end
							elseif LandAmphibious == "Amphibious No AA" then --Done
								if table.find(bp.Categories, 'SERAPHIM') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 30 and bp.Economy.BuildCostMass <= 400) and id ~= "uec0001" and id ~= "opc2002"
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and not table.find(bp.Categories, 'ANTIAIR') then
									Lland = Lland + 1
									table.insert(landUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
								if table.find(bp.Categories, 'SERAPHIM') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 400) and id ~= "uec0001" and id ~= "opc2002"
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and not table.find(bp.Categories, 'ANTIAIR') then
									LlandHeavy = LlandHeavy + 1
									table.insert(landUnitsLHeavy.Tech4, id) --Heavy T1 Units
								end
							end
							--Tech 2--
							if LandAmphibious == "All On" then --Done
								if table.find(bp.Categories, 'SERAPHIM') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 100 and bp.Economy.BuildCostMass <= 1000) then
									Mland = Mland + 1
									table.insert(landUnitsM.Tech4, id) --Tech2
								end
								if table.find(bp.Categories, 'SERAPHIM') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 1000) then
									MlandHeavy = MlandHeavy + 1
									table.insert(landUnitsMHeavy.Tech4, id) --Tech2 Heavy
								end
							elseif LandAmphibious == "Amphibious" then --Done
								if table.find(bp.Categories, 'SERAPHIM') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 100 and bp.Economy.BuildCostMass <= 1000)
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) then
									Mland = Mland + 1
									table.insert(landUnitsM.Tech4, id) --Tech2
								end
								if table.find(bp.Categories, 'SERAPHIM') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 1000)
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) then
									MlandHeavy = MlandHeavy + 1
									table.insert(landUnitsMHeavy.Tech4, id) --Tech2 Heavy
								end
							elseif LandAmphibious == "No AntiAir" then --Done
								if table.find(bp.Categories, 'SERAPHIM') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 100 and bp.Economy.BuildCostMass <= 1000)
								and not table.find(bp.Categories, 'ANTIAIR') then
									Mland = Mland + 1
									table.insert(landUnitsM.Tech4, id) --Tech2
								end
								if table.find(bp.Categories, 'SERAPHIM') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 1000)
								and not table.find(bp.Categories, 'ANTIAIR') then
									MlandHeavy = MlandHeavy + 1
									table.insert(landUnitsMHeavy.Tech4, id) --Tech2 Heavy
								end
							elseif LandAmphibious == "Amphibious No AA" then --Done
								if table.find(bp.Categories, 'SERAPHIM') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 100 and bp.Economy.BuildCostMass <= 1000)
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and not table.find(bp.Categories, 'ANTIAIR') then
									Mland = Mland + 1
									table.insert(landUnitsM.Tech4, id) --Tech2
								end
								if table.find(bp.Categories, 'SERAPHIM') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 1000)
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and not table.find(bp.Categories, 'ANTIAIR') then
									MlandHeavy = MlandHeavy + 1
									table.insert(landUnitsMHeavy.Tech4, id) --Tech2
								end	
							end	
							--Tech3--
							if LandAmphibious == "All On" then --Done
								if table.find(bp.Categories, 'SERAPHIM') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 200 and bp.Economy.BuildCostMass <= 3000 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and id ~= "sbrot3hadesb") then
									Hland = Hland + 1
									table.insert(landUnitsH.Tech4, id) --Tech3
								end
								if table.find(bp.Categories, 'SERAPHIM') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 3000 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and id ~= "sbrot3hadesb") then
									HlandHeavy = HlandHeavy + 1
									table.insert(landUnitsHHeavy.Tech4, id) --Tech3 T4
								end
							elseif LandAmphibious == "Amphibious" then --Done
								if table.find(bp.Categories, 'SERAPHIM') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 200 and bp.Economy.BuildCostMass <= 3000 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and id ~= "sbrot3hadesb") then
									Hland = Hland + 1
									table.insert(landUnitsH.Tech4, id) --Tech3
								end
								if table.find(bp.Categories, 'SERAPHIM') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 3000 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and id ~= "sbrot3hadesb") then
									HlandHeavy = HlandHeavy + 1
									table.insert(landUnitsHHeavy.Tech4, id) --Tech3 T4
								end
							elseif LandAmphibious == "No AntiAir" then --Done
								if table.find(bp.Categories, 'SERAPHIM') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 200 and bp.Economy.BuildCostMass <= 3000 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and id ~= "sbrot3hadesb") and not table.find(bp.Categories, 'ANTIAIR') then
									Hland = Hland + 1
									table.insert(landUnitsH.Tech4, id) --Tech3
								end
								if table.find(bp.Categories, 'SERAPHIM') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 3000 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and id ~= "sbrot3hadesb") and not table.find(bp.Categories, 'ANTIAIR') then
									HlandHeavy = HlandHeavy + 1
									table.insert(landUnitsHHeavy.Tech4, id) --Tech3 T4
								end
							elseif LandAmphibious == "Amphibious No AA" then --Done
								if table.find(bp.Categories, 'SERAPHIM') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 200 and bp.Economy.BuildCostMass <= 3000 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and id ~= "sbrot3hadesb") and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and not table.find(bp.Categories, 'ANTIAIR') then
									Hland = Hland + 1
									table.insert(landUnitsH.Tech4, id) --Tech3
								end
								if table.find(bp.Categories, 'SERAPHIM') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 3000 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and id ~= "sbrot3hadesb") and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and not table.find(bp.Categories, 'ANTIAIR') then
									HlandHeavy = HlandHeavy + 1
									table.insert(landUnitsHHeavy.Tech4, id) --Tech3 T4
								end
							end	
							if table.find(bp.Categories, 'SERAPHIM') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 50000 and table.find(bp.Categories, 'EXPERIMENTAL') and table.find(bp.Categories, 'LAND') and table.find(bp.Categories, 'MOBILE') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
							and id ~= "sbrot3hadesb" and id ~= "brmt3cloaker" and id ~= "ssl0403" and id ~= "srl0401") then
								Eland = Eland + 1
								table.insert(landUnitsE.Tech4, id) --Experimentals
							end
									if table.find(bp.Categories, 'SERAPHIM') and bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 50000 and bp.Defense and bp.Defense.MaxHealth > 70000 and id ~= "brmt3ava"
										and id ~= "brot3hades" then
										exHLand = exHLand + 1
										table.insert(landUnitsExtremeHeavy.Tech4, id)  --Total Mayhem Experimentals
									end
						end
					end
					--Air--
					if table.find(bp.Categories, 'AIR')
					and id ~= "uafsas01" and id ~= "uafsas02" and id ~= "uafsas03" then
						if table.find(bp.Categories, 'SERAPHIM') and table.find(bp.Categories, 'AIR') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') then
							if bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 5000 then
								air4 = 1
								table.insert(airUnitsA.Tech4, id)
								countair = countair + 1
							end
						end
						--Tech 1 Air--
						if table.find(bp.Categories, 'SERAPHIM') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH1') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 400) then
								LAir = LAir + 1
								table.insert(LAirUnits.Tech4, id)
						end
						if table.find(bp.Categories, 'SERAPHIM') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH1') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 400) then
								LAirHeavy = LAirHeavy + 1
								table.insert(LAirUnitsHeavy.Tech4, id)
						end
						--Tech 2 Air--
						if ASFWaves == "Off" then
							if table.find(bp.Categories, 'SERAPHIM') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 1000) then
									MAir = MAir + 1
									table.insert(MAirUnits.Tech4, id)
							end
							if table.find(bp.Categories, 'SERAPHIM') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 1000) then
									MAirHeavy = MAirHeavy + 1
									table.insert(MAirUnitsHeavy.Tech4, id)
							end
						end
						if ASFWaves == "Torp Bombers" then
							if table.find(bp.Categories, 'SERAPHIM') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 1000) then
									MAir = MAir + 1
									table.insert(MAirUnits.Tech4, id)
							end
							if table.find(bp.Categories, 'SERAPHIM') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 1000) then
									MAirHeavy = MAirHeavy + 1
									table.insert(MAirUnitsHeavy.Tech4, id)
							end
						end
						if ASFWaves == "ASF+Torp Bombers" then
							if table.find(bp.Categories, 'SERAPHIM') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 1000) then
									MAir = MAir + 1
									table.insert(MAirUnits.Tech4, id)
							end
							if table.find(bp.Categories, 'SERAPHIM') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 1000) then
									MAirHeavy = MAirHeavy + 1
									table.insert(MAirUnitsHeavy.Tech4, id)
							end
						end
						if ASFWaves == "ASF" then
							if table.find(bp.Categories, 'SERAPHIM') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 1000) then
									MAir = MAir + 1
									table.insert(MAirUnits.Tech4, id)
							end
							if table.find(bp.Categories, 'SERAPHIM') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 1000) then
									MAirHeavy = MAirHeavy + 1
									table.insert(MAirUnitsHeavy.Tech4, id)
							end
						end
						--Tech 3 Air--
						if ASFWaves == "Off" then	
							if table.find(bp.Categories, 'SERAPHIM') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 3000) then
									HAir = HAir + 1
									table.insert(HAirUnits.Tech4, id)
							end
							if table.find(bp.Categories, 'SERAPHIM') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 3000) then
									HAirHeavy = HAirHeavy + 1
									table.insert(HAirUnitsHeavy.Tech4, id)
							end
						end
						if ASFWaves == "Torp Bombers" then	
							if table.find(bp.Categories, 'SERAPHIM') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 3000) then
									HAir = HAir + 1
									table.insert(HAirUnits.Tech4, id)
							end
							if table.find(bp.Categories, 'SERAPHIM') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 3000) then
									HAirHeavy = HAirHeavy + 1
									table.insert(HAirUnitsHeavy.Tech4, id)
							end
						end
						if ASFWaves == "ASF" then	
							if table.find(bp.Categories, 'SERAPHIM') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 3000) then
								HAir = HAir + 1
								table.insert(HAirUnits.Tech4, id)
							end
							if table.find(bp.Categories, 'SERAPHIM') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 3000) then
								HAirHeavy = HAirHeavy + 1
								table.insert(HAirUnitsHeavy.Tech4, id)
							end
						end	
						if ASFWaves == "ASF+Torp Bombers" then	
							if table.find(bp.Categories, 'SERAPHIM') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 3000) then
								HAir = HAir + 1
								table.insert(HAirUnits.Tech4, id)
							end
							if table.find(bp.Categories, 'SERAPHIM') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 3000) then
								HAirHeavy = HAirHeavy + 1
								table.insert(HAirUnitsHeavy.Tech4, id)
							end
						end	
						--T4 Air--
						if ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Air+Navy" or ExperimentalSpawns == "Air" then	
							if table.find(bp.Categories, 'SERAPHIM') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'EXPERIMENTAL') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK') 
							or table.find(bp.Categories, 'DIRECTFIRE')) and not table.find(bp.Categories, 'SATELLITE') and bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 65000 then
								EAir = EAir + 1
								table.insert(EAirUnits.Tech4, id)
							end
						end	
					end	
					--Navy--
					--T1 Navy--
					if table.find(bp.Categories, 'SERAPHIM') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'TECH1') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'CQUEMOV') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 400) then
							LNavy = LNavy + 1
							table.insert(LNavyUnits.Tech4, id)
					end
					if table.find(bp.Categories, 'SERAPHIM') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'TECH1') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'CQUEMOV') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 400) then
							LNavyHeavy = LNavyHeavy + 1
							table.insert(LNavyUnitsHeavy.Tech4, id)
					end
					--T2 Navy--
					if table.find(bp.Categories, 'SERAPHIM') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'TECH2') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'CQUEMOV') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 3000) then
							MNavy = MNavy + 1
							table.insert(MNavyUnits.Tech4, id)
					end
					if table.find(bp.Categories, 'SERAPHIM') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'TECH2') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'CQUEMOV') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 3000) then
							MNavyHeavy = MNavyHeavy + 1
							table.insert(MNavyUnitsHeavy.Tech4, id)
					end
					--T3 Navy--
					if table.find(bp.Categories, 'SERAPHIM') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'TECH3') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'CQUEMOV') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass < 14000) then
							HNavy = HNavy + 1
							table.insert(HNavyUnits.Tech4, id)
					end
					if table.find(bp.Categories, 'SERAPHIM') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'TECH3') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'CQUEMOV') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass >= 14000) then
							HNavyHeavy = HNavyHeavy + 1
							table.insert(HNavyUnitsHeavy.Tech4, id)
					end
					--T4 Navy--
					if ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Air+Navy" or ExperimentalSpawns == "Navy" then
						if table.find(bp.Categories, 'SERAPHIM') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'EXPERIMENTAL') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and id ~= "edc0305" then
							ENavy = ENavy + 1
							table.insert(ENavyUnits.Tech4, id)
						end
					end	
				end
			end
		end
	end
	-------------------------------------------------Nomad Waves----------------------------------------
	if NomadWaves == "Nomads On" then
		for id, bp in pairs(__blueprints) do
			if (bp.Categories and string.len(id) >= 5) then
				if table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'ENGINEER') and not table.find(bp.Categories, 'SCOUT') and not table.find(bp.Categories, 'SATELLITE') and not table.find(bp.Categories, 'INSIGNIFICANTUNIT') and not table.find(bp.Categories, 'TACTICALMISSILEPLATFORM') then
					if table.find(bp.Categories, 'LAND') and not table.find(bp.Categories, 'INTELLIGENCE') then
						land4 = 1
						if id ~= "sbrnt3batu" and id ~= "bel0402" then
							if LandAmphibious == "All On" then	
								if table.find(bp.Categories, 'NOMADS') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 30) and id ~= "uec0001" and id ~= "opc2002" then
									Lland = Lland + 1
									table.insert(landUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
							elseif LandAmphibious == "Amphibious" then
								if table.find(bp.Categories, 'NOMADS') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 30) and id ~= "uec0001" and id ~= "opc2002"
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) then
									Lland = Lland + 1
									table.insert(landUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
							elseif LandAmphibious == "No AntiAir" then
								if table.find(bp.Categories, 'NOMADS') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 30) and id ~= "uec0001" and id ~= "opc2002"
								and not table.find(bp.Categories, 'ANTIAIR') then
									Lland = Lland + 1
									table.insert(landUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
							elseif LandAmphibious == "Amphibious No AA" then
								if table.find(bp.Categories, 'NOMADS') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH1') and bp.Economy.BuildCostMass > 30) and id ~= "uec0001" and id ~= "opc2002"
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and not table.find(bp.Categories, 'ANTIAIR') then
									Lland = Lland + 1
									table.insert(landUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
							end
							if LandAmphibious == "All On" then
								if table.find(bp.Categories, 'NOMADS') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 100) then
									Mland = Mland + 1
									table.insert(landUnitsM.Tech4, id) --Tech2
								end
							elseif LandAmphibious == "Amphibious" then
								if table.find(bp.Categories, 'NOMADS') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 100)
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) then
									Mland = Mland + 1
									table.insert(landUnitsM.Tech4, id) --Tech2
								end
							elseif LandAmphibious == "No AntiAir" then
								if table.find(bp.Categories, 'NOMADS') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 100)
								and not table.find(bp.Categories, 'ANTIAIR') then
									Mland = Mland + 1
									table.insert(landUnitsM.Tech4, id) --Tech2
								end
							elseif LandAmphibious == "Amphibious No AA" then
								if table.find(bp.Categories, 'NOMADS') and (bp.Economy.BuildCostMass and table.find(bp.Categories, 'TECH2') and bp.Economy.BuildCostMass > 100)
								and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and not table.find(bp.Categories, 'ANTIAIR') then
									Mland = Mland + 1
									table.insert(landUnitsM.Tech4, id) --Tech2
								end
							end	
							if LandAmphibious == "All On" then
								if table.find(bp.Categories, 'NOMADS') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 200 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and id ~= "sbrot3hadesb") then
									Hland = Hland + 1
									table.insert(landUnitsH.Tech4, id) --Tech3
								end
							elseif LandAmphibious == "Amphibious" then
								if table.find(bp.Categories, 'NOMADS') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 200 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and id ~= "sbrot3hadesb") then
									Hland = Hland + 1
									table.insert(landUnitsH.Tech4, id) --Tech3
								end
							elseif LandAmphibious == "No AntiAir" then
								if table.find(bp.Categories, 'NOMADS') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 200 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and id ~= "sbrot3hadesb") and not table.find(bp.Categories, 'ANTIAIR') then
									Hland = Hland + 1
									table.insert(landUnitsH.Tech4, id) --Tech3
								end
							elseif LandAmphibious == "Amphibious No AA" then
								if table.find(bp.Categories, 'NOMADS') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 200 and table.find(bp.Categories, 'TECH3') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
									and id ~= "sbrot3hadesb") and (table.find(bp.Categories, 'HOVER') or table.find(bp.Categories, 'AMPHIBIOUS')) and not table.find(bp.Categories, 'ANTIAIR') then
									Hland = Hland + 1
									table.insert(landUnitsH.Tech4, id) --Tech3
								end
							end	
							--if MinorBossSpawns == "Land+Air" or MinorBossSpawns == "Land" then
								if table.find(bp.Categories, 'NOMADS') and bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 50000 and bp.Defense and bp.Defense.MaxHealth > 70000 and id ~= "brmt3ava"
									and id ~= "brot3hades" then
									exHLand = exHLand + 1
									table.insert(landUnitsExtremeHeavy.Tech4, id)  --Total Mayhem Experimentals
								end
							--end	
						end
					end
					--if MinorBossSpawns == "Land+Air" or MinorBossSpawns == "Air" then
						if table.find(bp.Categories, 'NOMADS') and table.find(bp.Categories, 'AIR') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') then
							if bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 5000 then
								air4 = 1
								table.insert(airUnitsA.Tech4, id)
								countair = countair + 1
							end
						end
					--end	
					if table.find(bp.Categories, 'NOMADS') and (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 50000 and table.find(bp.Categories, 'EXPERIMENTAL') and table.find(bp.Categories, 'LAND') and table.find(bp.Categories, 'MOBILE') and id ~= "sbrmt3avab" and id ~= "brmt3ava" and id ~= "brot3hades"
							and id ~= "sbrot3hadesb" and id ~= "brmt3cloaker" and id ~= "ssl0403" and id ~= "srl0401") then
							Eland = Eland + 1
							table.insert(landUnitsE.Tech4, id) --Experimentals
					end
					--end	
					if table.find(bp.Categories, 'NOMADS') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH1') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
							LAir = LAir + 1
							table.insert(LAirUnits.Tech4, id)
					end
					if ASFWaves == "Off" then
						if table.find(bp.Categories, 'NOMADS') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
								MAir = MAir + 1
								table.insert(MAirUnits.Tech4, id)
						end
					end
					if ASFWaves == "Torp Bombers" then
						if table.find(bp.Categories, 'NOMADS') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
								MAir = MAir + 1
								table.insert(MAirUnits.Tech4, id)
						end
					end
					if ASFWaves == "ASF+Torp Bombers" then
						if table.find(bp.Categories, 'NOMADS') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
								MAir = MAir + 1
								table.insert(MAirUnits.Tech4, id)
						end
					end
					if ASFWaves == "ASF" then
						if table.find(bp.Categories, 'NOMADS') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH2') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
								MAir = MAir + 1
								table.insert(MAirUnits.Tech4, id)
						end
					end
					if ASFWaves == "Off" then	
						if table.find(bp.Categories, 'NOMADS') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
								HAir = HAir + 1
								table.insert(HAirUnits.Tech4, id)
						end
					end
					if ASFWaves == "Torp Bombers" then	
						if table.find(bp.Categories, 'NOMADS') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
								HAir = HAir + 1
								table.insert(HAirUnits.Tech4, id)
						end
					end
					if ASFWaves == "ASF" then	
						if table.find(bp.Categories, 'NOMADS') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'ANTINAVY') and (table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
							HAir = HAir + 1
							table.insert(HAirUnits.Tech4, id)
						end
					end	
					if ASFWaves == "ASF+Torp Bombers" then	
						if table.find(bp.Categories, 'NOMADS') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'TECH3') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'ANTINAVY') or table.find(bp.Categories, 'ANTIAIR') or table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK')) then
							HAir = HAir + 1
							table.insert(HAirUnits.Tech4, id)
						end
					end
					if ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Air+Navy" or ExperimentalSpawns == "Air" then	
						if table.find(bp.Categories, 'NOMADS') and table.find(bp.Categories, 'AIR') and table.find(bp.Categories, 'EXPERIMENTAL') and not table.find(bp.Categories, 'INTELLIGENCE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and (table.find(bp.Categories, 'BOMBER') or table.find(bp.Categories, 'GROUNDATTACK') 
						or table.find(bp.Categories, 'DIRECTFIRE')) and not table.find(bp.Categories, 'SATELLITE') and bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 65000 then
								EAir = EAir + 1
								table.insert(EAirUnits.Tech4, id)
						end
					end	
					if table.find(bp.Categories, 'NOMADS') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'TECH1') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'CQUEMOV') then
							LNavy = LNavy + 1
							table.insert(LNavyUnits.Tech4, id)
					end
					if table.find(bp.Categories, 'NOMADS') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'TECH2') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'CQUEMOV') then
							MNavy = MNavy + 1
							table.insert(MNavyUnits.Tech4, id)
					end
					if table.find(bp.Categories, 'NOMADS') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'TECH3') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') and not table.find(bp.Categories, 'CQUEMOV') then
							HNavy = HNavy + 1
							table.insert(HNavyUnits.Tech4, id)
					end
					if ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Air+Navy" or ExperimentalSpawns == "Navy" then
						if table.find(bp.Categories, 'NOMADS') and table.find(bp.Categories, 'NAVAL') and table.find(bp.Categories, 'EXPERIMENTAL') and table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'TRANSPORTFOCUS') then
								ENavy = ENavy + 1
								table.insert(ENavyUnits.Tech4, id)
						end
					end	
				end
			end
		end
	end
end
function CreateTransportTables()
	for id, bp in pairs(__blueprints) do
		if (bp.Categories and string.len(id) >= 5) then
			if table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'ENGINEER') and not table.find(bp.Categories, 'SCOUT') and not table.find(bp.Categories, 'SATELLITE') 
			and not table.find(bp.Categories, 'INSIGNIFICANTUNIT') and not table.find(bp.Categories, 'ANTIAIR') and not table.find(bp.Categories, 'SHIELD')
			and not table.find(bp.Categories, 'INVULNERABLE') and not table.find(bp.Categories, 'UNTARGETABLE') and not table.find(bp.Categories, 'UNSELECTABLE')
			and not table.find(bp.Categories, 'LIGHTDROPCAPSULE') and not table.find(bp.Categories, 'MEDIUMDROPCAPSULE') and not table.find(bp.Categories, 'HEAVYDROPCAPSULE')
			and not table.find(bp.Categories, 'CANTRANSPORTCOMMANDER') then
				if TotalMayhemWaves == "Adjustable T1/T2/T3 Experimentals" then
					if table.find(bp.Categories, 'LAND') then
						--Tech1
						if (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 400) then
							if TransportUnits == "Only Bots (Mixed Race)" then	
								if (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass >= 30) and table.find(bp.Categories, 'TECH1') 
								and table.find(bp.Categories, 'BOT') and id ~= "uec0001" and id ~= "opc2002" then
									TranLland = TranLland + 1
									table.insert(TransUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
							elseif TransportUnits == "Only Tanks (Mixed Race)" then
								if (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass >= 30) and table.find(bp.Categories, 'TECH1') 
								and table.find(bp.Categories, 'TANK') and id ~= "uec0001" and id ~= "opc2002" then
									TranLland = TranLland + 1
									table.insert(TransUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
							elseif TransportUnits == "Amphibious/Hover (Mixed Race)" then
								if (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass >= 30) and table.find(bp.Categories, 'TECH1') 
								and (table.find(bp.Categories, 'AMPHIBIOUS') or table.find(bp.Categories, 'HOVER')) and id ~= "uec0001" and id ~= "opc2002" then
									TranLland = TranLland + 1
									table.insert(TransUnitsL.Tech4, id) --Tech1 Units + Garbage
								end	
							elseif TransportUnits == "Bots+Tanks (Mixed Race)" then
								if (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass >= 30) and table.find(bp.Categories, 'TECH1') 
								and (table.find(bp.Categories, 'TANK') or table.find(bp.Categories, 'BOT')) and id ~= "uec0001" and id ~= "opc2002" then
									TranLland = TranLland + 1
									table.insert(TransUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
							end
						end	
						--Tech2
						if (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 1000) then
							if TransportUnits == "Only Bots (Mixed Race)" then	
								if (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass >= 30) and table.find(bp.Categories, 'TECH2') 
								and table.find(bp.Categories, 'BOT') and id ~= "uec0001" and id ~= "opc2002" then
									TranMland = TranMland + 1
									table.insert(TransUnitsM.Tech4, id) --TECH2 Units + Garbage
								end
							elseif TransportUnits == "Only Tanks (Mixed Race)" then
								if (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass >= 30) and table.find(bp.Categories, 'TECH2') 
								and table.find(bp.Categories, 'TANK') and id ~= "uec0001" and id ~= "opc2002" then
									TranMland = TranMland + 1
									table.insert(TransUnitsM.Tech4, id) --TECH2 Units + Garbage
								end
							elseif TransportUnits == "Amphibious/Hover (Mixed Race)" then
								if (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass >= 30) and table.find(bp.Categories, 'TECH2') 
								and (table.find(bp.Categories, 'AMPHIBIOUS') or table.find(bp.Categories, 'HOVER')) and id ~= "uec0001" and id ~= "opc2002" then
									TranMland = TranMland + 1
									table.insert(TransUnitsM.Tech4, id) --TECH2 Units + Garbage
								end	
							elseif TransportUnits == "Bots+Tanks (Mixed Race)" then
								if (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass >= 30) and table.find(bp.Categories, 'TECH2') 
								and (table.find(bp.Categories, 'TANK') or table.find(bp.Categories, 'BOT')) and id ~= "uec0001" and id ~= "opc2002" then
									TranMland = TranMland + 1
									table.insert(TransUnitsM.Tech4, id) --TECH2 Units + Garbage
								end	
							end	
						end
						--Tech3
						if (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 3000) then
							if TransportUnits == "Only Bots (Mixed Race)" then	
								if (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass >= 30) and table.find(bp.Categories, 'TECH3') 
								and table.find(bp.Categories, 'BOT') and id ~= "uec0001" and id ~= "opc2002" then
									TranHland = TranHland + 1
									table.insert(TransUnitsH.Tech4, id) --TECH2 Units + Garbage
								end
							elseif TransportUnits == "Only Tanks (Mixed Race)" then
								if (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass >= 30) and table.find(bp.Categories, 'TECH3') 
								and table.find(bp.Categories, 'TANK') and id ~= "uec0001" and id ~= "opc2002" then
									TranHland = TranHland + 1
									table.insert(TransUnitsH.Tech4, id) --TECH2 Units + Garbage
								end
							elseif TransportUnits == "Amphibious/Hover (Mixed Race)" then
								if (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass >= 30) and table.find(bp.Categories, 'TECH3') 
								and (table.find(bp.Categories, 'AMPHIBIOUS') or table.find(bp.Categories, 'HOVER')) and id ~= "uec0001" and id ~= "opc2002" then
									TranHland = TranHland + 1
									table.insert(TransUnitsH.Tech4, id) --TECH2 Units + Garbage
								end	
							elseif TransportUnits == "Bots+Tanks (Mixed Race)" then
								if (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass >= 30) and table.find(bp.Categories, 'TECH3') 
								and (table.find(bp.Categories, 'TANK') or table.find(bp.Categories, 'BOT')) and id ~= "uec0001" and id ~= "opc2002" then
									TranHland = TranHland + 1
									table.insert(TransUnitsH.Tech4, id) --TECH2 Units + Garbage
								end	
							end	
						end	
					end
				else
					if table.find(bp.Categories, 'LAND') then
						--Tech1
							if TransportUnits == "Only Bots (Mixed Race)" then	
								if (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass >= 30) and table.find(bp.Categories, 'TECH1') 
								and table.find(bp.Categories, 'BOT') and id ~= "uec0001" and id ~= "opc2002" then
									TranLland = TranLland + 1
									table.insert(TransUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
							elseif TransportUnits == "Only Tanks (Mixed Race)" then
								if (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass >= 30) and table.find(bp.Categories, 'TECH1') 
								and table.find(bp.Categories, 'TANK') and id ~= "uec0001" and id ~= "opc2002" then
									TranLland = TranLland + 1
									table.insert(TransUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
							elseif TransportUnits == "Amphibious/Hover (Mixed Race)" then
								if (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass >= 30) and table.find(bp.Categories, 'TECH1') 
								and (table.find(bp.Categories, 'AMPHIBIOUS') or table.find(bp.Categories, 'HOVER')) and id ~= "uec0001" and id ~= "opc2002" then
									TranLland = TranLland + 1
									table.insert(TransUnitsL.Tech4, id) --Tech1 Units + Garbage
								end	
							elseif TransportUnits == "Bots+Tanks (Mixed Race)" then
								if (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass >= 30) and table.find(bp.Categories, 'TECH1') 
								and (table.find(bp.Categories, 'TANK') or table.find(bp.Categories, 'BOT')) and id ~= "uec0001" and id ~= "opc2002" then
									TranLland = TranLland + 1
									table.insert(TransUnitsL.Tech4, id) --Tech1 Units + Garbage
								end
							end
						--Tech2
						if TransportUnits == "Only Bots (Mixed Race)" then	
							if (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass >= 30) and table.find(bp.Categories, 'TECH2') 
							and table.find(bp.Categories, 'BOT') and id ~= "uec0001" and id ~= "opc2002" then
								TranMland = TranMland + 1
								table.insert(TransUnitsM.Tech4, id) --TECH2 Units + Garbage
							end
						elseif TransportUnits == "Only Tanks (Mixed Race)" then
							if (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass >= 30) and table.find(bp.Categories, 'TECH2') 
							and table.find(bp.Categories, 'TANK') and id ~= "uec0001" and id ~= "opc2002" then
								TranMland = TranMland + 1
								table.insert(TransUnitsM.Tech4, id) --TECH2 Units + Garbage
							end
						elseif TransportUnits == "Amphibious/Hover (Mixed Race)" then
							if (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass >= 30) and table.find(bp.Categories, 'TECH2') 
							and (table.find(bp.Categories, 'AMPHIBIOUS') or table.find(bp.Categories, 'HOVER')) and id ~= "uec0001" and id ~= "opc2002" then
								TranMland = TranMland + 1
								table.insert(TransUnitsM.Tech4, id) --TECH2 Units + Garbage
							end	
						elseif TransportUnits == "Bots+Tanks (Mixed Race)" then
							if (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass >= 30) and table.find(bp.Categories, 'TECH2') 
							and (table.find(bp.Categories, 'TANK') or table.find(bp.Categories, 'BOT')) and id ~= "uec0001" and id ~= "opc2002" then
								TranMland = TranMland + 1
								table.insert(TransUnitsM.Tech4, id) --TECH2 Units + Garbage
							end	
						end	
						--Tech3
						if TransportUnits == "Only Bots (Mixed Race)" then	
							if (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass >= 30) and table.find(bp.Categories, 'TECH3') 
							and table.find(bp.Categories, 'BOT') and id ~= "uec0001" and id ~= "opc2002" then
								TranHland = TranHland + 1
								table.insert(TransUnitsH.Tech4, id) --TECH2 Units + Garbage
							end
						elseif TransportUnits == "Only Tanks (Mixed Race)" then
							if (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass >= 30) and table.find(bp.Categories, 'TECH3') 
							and table.find(bp.Categories, 'TANK') and id ~= "uec0001" and id ~= "opc2002" then
								TranHland = TranHland + 1
								table.insert(TransUnitsH.Tech4, id) --TECH2 Units + Garbage
							end
						elseif TransportUnits == "Amphibious/Hover (Mixed Race)" then
							if (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass >= 30) and table.find(bp.Categories, 'TECH3') 
							and (table.find(bp.Categories, 'AMPHIBIOUS') or table.find(bp.Categories, 'HOVER')) and id ~= "uec0001" and id ~= "opc2002" then
								TranHland = TranHland + 1
								table.insert(TransUnitsH.Tech4, id) --TECH2 Units + Garbage
							end	
						elseif TransportUnits == "Bots+Tanks (Mixed Race)" then
							if (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass >= 30) and table.find(bp.Categories, 'TECH3') 
							and (table.find(bp.Categories, 'TANK') or table.find(bp.Categories, 'BOT')) and id ~= "uec0001" and id ~= "opc2002" then
								TranHland = TranHland + 1
								table.insert(TransUnitsH.Tech4, id) --TECH2 Units + Garbage
							end	
						end	
					end
				end	
			end
		end
	end					
end
GetRandomizedUnitID = function(self)
    local rspawn = nil
	--local x = nil
	--GameTime = math.floor(GetGameTimeSeconds() - WavesStartTimeAI) / HoldTimeAI

		if Lland > 0 and GameTime < (0.1 * WaveProgression) then
			rspawn = (landUnitsL.Tech4)[Random(1, Lland)]
				if Mland > 0 and (JumpTech2 == "Land+Air+Navy" or JumpTech2 == "Land+Air" or JumpTech2 == "Land+Navy" or JumpTech2 == "Land") then
					rspawn = (landUnitsM.Tech4)[Random(1, Mland)]
				end	
			elseif Mland > 0 and GameTime >= (0.1 * WaveProgression) and GameTime < (0.25 * WaveProgression) then
				rspawn = (landUnitsM.Tech4)[Random(1, Mland)]
				if Lland > 0 and Random(1, 3) == 1 and GameTime < (0.15 * WaveProgression) and not (JumpTech2 == "Land+Air+Navy" or JumpTech2 == "Land+Air" or JumpTech2 == "Land+Navy" or JumpTech2 == "Land") then
					rspawn = (landUnitsL.Tech4)[Random(1, Lland)]
				end	
			elseif Hland > 0 and GameTime >= (0.25 * WaveProgression) and GameTime < (0.35 * WaveProgression) then
				rspawn = (landUnitsH.Tech4)[Random(1, Hland)]
				if Mland > 0 and Random(1, 3) == 1 and GameTime < (0.3 * WaveProgression) then
					rspawn = (landUnitsM.Tech4)[Random(1, Mland)]
				end	
			elseif Hland > 0 and GameTime >= (0.35 * WaveProgression) and GameTime < (0.45 * WaveProgression) then
				rspawn = (landUnitsH.Tech4)[Random(1, Hland)]
				if Eland > 0 and Random(0, 250) <= 10 * ExpMulti --1% 4.4% 8.3% 1.5x
				and (ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Land") then
					rspawn = (landUnitsE.Tech4)[Random(1, Eland)]
				end
			elseif Hland > 0 and GameTime >= (0.45 * WaveProgression) and GameTime < (0.55 * WaveProgression) then --15.75 to 22.75
				rspawn = (landUnitsH.Tech4)[Random(1, Hland)]
				--x = math.floor(7 * WaveProgression + 0.5)
				if Eland > 0 and Random(0, 180) <= 10 * ExpMulti --2% 6% 11.6% 1.8x
				and (ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Land") then
					rspawn = (landUnitsE.Tech4)[Random(1, Eland)]
				end
			elseif Hland > 0 and GameTime >= (0.55 * WaveProgression) and GameTime < (0.65 * WaveProgression) then --15.75 to 22.75
				rspawn = (landUnitsH.Tech4)[Random(1, Hland)]
				--x = math.floor(7 * WaveProgression + 0.5)
				if Eland > 0 and Random(0, 130) <= 10 * ExpMulti --2.8% 15.4% 29.6% 1.8x
				and (ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Land") then
					rspawn = (landUnitsE.Tech4)[Random(1, Eland)]
				end	
			elseif Hland > 0 and GameTime >= (0.65 * WaveProgression) and GameTime < (0.77 * WaveProgression) then --22.75 to 29.75
				rspawn = (landUnitsH.Tech4)[Random(1, Hland)]
				--x = math.floor(3 * WaveProgression + 0.5)
				if Eland > 0 and Random(0, 70) <= 10 * ExpMulti --5% 24% 52% 1.8x
				and (ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Land") then
					rspawn = (landUnitsE.Tech4)[Random(1, Eland)]
				end
			elseif Hland > 0 and GameTime >= (0.77 * WaveProgression) and GameTime < (0.9 * WaveProgression) then --22.75 to 29.75
				rspawn = (landUnitsH.Tech4)[Random(1, Hland)]
				--x = math.floor(3 * WaveProgression + 0.5)
				if Eland > 0 and Random(0, 60) <= 10 * ExpMulti --6.5% 34% 65% 2x
				and (ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Land") then
					rspawn = (landUnitsE.Tech4)[Random(1, Eland)]
				end
				if (MinorBossSpawns == "Land+Air" or MinorBossSpawns == "Land" or MinorBossSpawns == "ExtraLand" or MinorBossSpawns == "ExtraLand+ExtraAir" or MinorBossSpawns == "Land+ExtraAir")
				and Random(0, 200) <= 10 * ExpMulti then --1.1% 6.1% 11.6% +20
					CreateACombinedLandBossUnitAroundMainBuildingForAI()
				end
			elseif Hland > 0 and GameTime >= (0.90 * WaveProgression) and GameTime < (1.05 * WaveProgression) then --29.75
				rspawn = (landUnitsH.Tech4)[Random(1, Hland)]
				--x = math.floor(4 * WaveProgression + 0.5)
				if Eland > 0 and Random(0, 40) <= 10 * ExpMulti --9.1% 50% 95% 2x
				and (ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Land") then
					rspawn = (landUnitsE.Tech4)[Random(1, Eland)]
				end
				--x = math.floor(4 * WaveProgression + 0.5)
				if (MinorBossSpawns == "Land+Air" or MinorBossSpawns == "Land" or MinorBossSpawns == "ExtraLand" or MinorBossSpawns == "ExtraLand+ExtraAir" or MinorBossSpawns == "Land+ExtraAir")
				and Random(0, 120) <= 10 * ExpMulti then --2% 10.9% 20.8% +20
					CreateACombinedLandBossUnitAroundMainBuildingForAI()
				end
			elseif Hland > 0 and GameTime >= (1.05 * WaveProgression) and GameTime < (1.2 * WaveProgression) then --29.75
				rspawn = (landUnitsH.Tech4)[Random(1, Hland)]
				--x = math.floor(4 * WaveProgression + 0.5)
				if Eland > 0 and Random(0, 36) <= 10 * ExpMulti --10% 55% 100% 1.89x
				and (ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Land") then
					rspawn = (landUnitsE.Tech4)[Random(1, Eland)]
				end
				--x = math.floor(4 * WaveProgression + 0.5)
				if (MinorBossSpawns == "Land+Air" or MinorBossSpawns == "Land" or MinorBossSpawns == "ExtraLand" or MinorBossSpawns == "ExtraLand+ExtraAir" or MinorBossSpawns == "Land+ExtraAir")
				and Random(0, 95) <= 10 * ExpMulti then --2.3% 12.8% 24.4% +10
					CreateACombinedLandBossUnitAroundMainBuildingForAI()
				end
			elseif Hland > 0 and GameTime >= (1.2 * WaveProgression) and GameTime < (1.35 * WaveProgression) then --29.75
				rspawn = (landUnitsH.Tech4)[Random(1, Hland)]
				--x = math.floor(4 * WaveProgression + 0.5)
				if Eland > 0 and Random(0, 25) <= 10 * ExpMulti --11.1% 61% 100% 1.47x
				and (ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Land") then
					rspawn = (landUnitsE.Tech4)[Random(1, Eland)]
				end
				--x = math.floor(4 * WaveProgression + 0.5)
				if (MinorBossSpawns == "Land+Air" or MinorBossSpawns == "Land" or MinorBossSpawns == "ExtraLand" or MinorBossSpawns == "ExtraLand+ExtraAir" or MinorBossSpawns == "Land+ExtraAir")
				and Random(0, 80) <= 10 * ExpMulti then --2.8% 15.5% 29.6% +10
					CreateACombinedLandBossUnitAroundMainBuildingForAI()
				end
			elseif Hland > 0 and GameTime >= (1.35 * WaveProgression) then --29.75
				rspawn = (landUnitsH.Tech4)[Random(1, Hland)]
				--x = math.floor(4 * WaveProgression + 0.5)
				if Eland > 0 and Random(0, 20) <= 10 * ExpMulti --12.5% 68.8% 100% 1.3x
				and (ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Land") then
					rspawn = (landUnitsE.Tech4)[Random(1, Eland)]
				end
				--x = math.floor(4 * WaveProgression + 0.5)
				if (MinorBossSpawns == "Land+Air" or MinorBossSpawns == "Land" or MinorBossSpawns == "ExtraLand" or MinorBossSpawns == "ExtraLand+ExtraAir" or MinorBossSpawns == "Land+ExtraAir")
				and Random(0, 60) <= 10 * ExpMulti then --3.6% 19.6% 37.5% +5
					CreateACombinedLandBossUnitAroundMainBuildingForAI()
				end
		end
    return rspawn
end
GetRandomizedTotMayLandID = function(self)
    local rspawn = nil
	--local x = nil
	--GameTime = math.floor(GetGameTimeSeconds() - WavesStartTimeAI) / HoldTimeAI

		if Lland > 0 and GameTime < (0.1 * WaveProgression) then
			if LlandHeavy > 0 and  Random(1, 40) <= TotalMayhemLand then
				rspawn = (landUnitsLHeavy.Tech4)[Random(1, LlandHeavy)]
			else
				rspawn = (landUnitsL.Tech4)[Random(1, Lland)]
			end	
				if Mland > 0 and (JumpTech2 == "Land+Air+Navy" or JumpTech2 == "Land+Air" or JumpTech2 == "Land+Navy" or JumpTech2 == "Land") then
					if MlandHeavy > 0 and  Random(1, 40) <= TotalMayhemLand then
						rspawn = (landUnitsMHeavy.Tech4)[Random(1, MlandHeavy)]
					else
						rspawn = (landUnitsM.Tech4)[Random(1, Mland)]
					end	
				end	
			elseif Mland > 0 and GameTime >= (0.1 * WaveProgression) and GameTime < (0.25 * WaveProgression) then
				if MlandHeavy > 0 and  Random(1, 40) <= TotalMayhemLand then
					rspawn = (landUnitsMHeavy.Tech4)[Random(1, MlandHeavy)]
				else
					rspawn = (landUnitsM.Tech4)[Random(1, Mland)]
				end	
				if Lland > 0 and Random(1, 3) == 1 and GameTime < (0.15 * WaveProgression) and not (JumpTech2 == "Land+Air+Navy" or JumpTech2 == "Land+Air" or JumpTech2 == "Land+Navy" or JumpTech2 == "Land") then
					if LlandHeavy > 0 and  Random(1, 30) <= TotalMayhemLand then
						rspawn = (landUnitsLHeavy.Tech4)[Random(1, LlandHeavy)]
					else
						rspawn = (landUnitsL.Tech4)[Random(1, Lland)]
					end	
				end	
			elseif Hland > 0 and GameTime >= (0.25 * WaveProgression) and GameTime < (0.35 * WaveProgression) then
				if HlandHeavy > 0 and  Random(1, 40) <= TotalMayhemLand then
					rspawn = (landUnitsHHeavy.Tech4)[Random(1, HlandHeavy)]
				else
					rspawn = (landUnitsH.Tech4)[Random(1, Hland)]
				end
				rspawn = (landUnitsH.Tech4)[Random(1, Hland)]
				if Mland > 0 and Random(1, 3) == 1 and GameTime < (0.3 * WaveProgression) then
					if MlandHeavy > 0 and  Random(1, 30) <= TotalMayhemLand then
						rspawn = (landUnitsMHeavy.Tech4)[Random(1, MlandHeavy)]
					else
						rspawn = (landUnitsM.Tech4)[Random(1, Mland)]
					end	
				end	
			elseif Hland > 0 and GameTime >= (0.35 * WaveProgression) and GameTime < (0.45 * WaveProgression) then
				if HlandHeavy > 0 and  Random(1, 39) <= TotalMayhemLand then
					rspawn = (landUnitsHHeavy.Tech4)[Random(1, HlandHeavy)]
				else
					rspawn = (landUnitsH.Tech4)[Random(1, Hland)]
				end
				if Eland > 0 and Random(0, 250) <= 10 * ExpMulti --1% 4.4% 8.3% 1.5x
				and (ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Land") then
					rspawn = (landUnitsE.Tech4)[Random(1, Eland)]
				end
			elseif Hland > 0 and GameTime >= (0.45 * WaveProgression) and GameTime < (0.55 * WaveProgression) then --15.75 to 22.75
				if HlandHeavy > 0 and  Random(1, 38) <= TotalMayhemLand then
					rspawn = (landUnitsHHeavy.Tech4)[Random(1, HlandHeavy)]
				else
					rspawn = (landUnitsH.Tech4)[Random(1, Hland)]
				end
				--x = math.floor(7 * WaveProgression + 0.5)
				if Eland > 0 and Random(0, 180) <= 10 * ExpMulti --2% 6% 11.6% 1.8x
				and (ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Land") then
					rspawn = (landUnitsE.Tech4)[Random(1, Eland)]
				end
			elseif Hland > 0 and GameTime >= (0.55 * WaveProgression) and GameTime < (0.65 * WaveProgression) then --15.75 to 22.75
				if HlandHeavy > 0 and  Random(1, 37) <= TotalMayhemLand then
					rspawn = (landUnitsHHeavy.Tech4)[Random(1, HlandHeavy)]
				else
					rspawn = (landUnitsH.Tech4)[Random(1, Hland)]
				end
				--x = math.floor(7 * WaveProgression + 0.5)
				if Eland > 0 and Random(0, 130) <= 10 * ExpMulti --2.8% 15.4% 29.6% 1.8x
				and (ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Land") then
					rspawn = (landUnitsE.Tech4)[Random(1, Eland)]
				end	
			elseif Hland > 0 and GameTime >= (0.65 * WaveProgression) and GameTime < (0.77 * WaveProgression) then --22.75 to 29.75
				if HlandHeavy > 0 and  Random(1, 36) <= TotalMayhemLand then
					rspawn = (landUnitsHHeavy.Tech4)[Random(1, HlandHeavy)]
				else
					rspawn = (landUnitsH.Tech4)[Random(1, Hland)]
				end
				--x = math.floor(3 * WaveProgression + 0.5)
				if Eland > 0 and Random(0, 70) <= 10 * ExpMulti --5% 24% 52% 1.8x
				and (ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Land") then
					rspawn = (landUnitsE.Tech4)[Random(1, Eland)]
				end
			elseif Hland > 0 and GameTime >= (0.77 * WaveProgression) and GameTime < (0.9 * WaveProgression) then --22.75 to 29.75
				if HlandHeavy > 0 and  Random(1, 35) <= TotalMayhemLand then
					rspawn = (landUnitsHHeavy.Tech4)[Random(1, HlandHeavy)]
				else
					rspawn = (landUnitsH.Tech4)[Random(1, Hland)]
				end
				--x = math.floor(3 * WaveProgression + 0.5)
				if Eland > 0 and Random(0, 60) <= 10 * ExpMulti --6.5% 34% 65% 2x
				and (ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Land") then
					rspawn = (landUnitsE.Tech4)[Random(1, Eland)]
				end
				if (MinorBossSpawns == "Land+Air" or MinorBossSpawns == "Land" or MinorBossSpawns == "ExtraLand" or MinorBossSpawns == "ExtraLand+ExtraAir" or MinorBossSpawns == "Land+ExtraAir")
				and Random(0, 200) <= 10 * ExpMulti then --1.1% 6.1% 11.6% +20
					CreateACombinedLandBossUnitAroundMainBuildingForAI()
				end
			elseif Hland > 0 and GameTime >= (0.90 * WaveProgression) and GameTime < (1.05 * WaveProgression) then --29.75
				if HlandHeavy > 0 and  Random(1, 34) <= TotalMayhemLand then
					rspawn = (landUnitsHHeavy.Tech4)[Random(1, HlandHeavy)]
				else
					rspawn = (landUnitsH.Tech4)[Random(1, Hland)]
				end
				--x = math.floor(4 * WaveProgression + 0.5)
				if Eland > 0 and Random(0, 40) <= 10 * ExpMulti --9.1% 50% 95% 2x
				and (ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Land") then
					rspawn = (landUnitsE.Tech4)[Random(1, Eland)]
				end
				--x = math.floor(4 * WaveProgression + 0.5)
				if (MinorBossSpawns == "Land+Air" or MinorBossSpawns == "Land" or MinorBossSpawns == "ExtraLand" or MinorBossSpawns == "ExtraLand+ExtraAir" or MinorBossSpawns == "Land+ExtraAir")
				and Random(0, 120) <= 10 * ExpMulti then --2% 10.9% 20.8% +20
					CreateACombinedLandBossUnitAroundMainBuildingForAI()
				end
			elseif Hland > 0 and GameTime >= (1.05 * WaveProgression) and GameTime < (1.2 * WaveProgression) then --29.75
				if HlandHeavy > 0 and  Random(1, 33) <= TotalMayhemLand then
					rspawn = (landUnitsHHeavy.Tech4)[Random(1, HlandHeavy)]
				else
					rspawn = (landUnitsH.Tech4)[Random(1, Hland)]
				end
				--x = math.floor(4 * WaveProgression + 0.5)
				if Eland > 0 and Random(0, 36) <= 10 * ExpMulti --10% 55% 100% 1.89x
				and (ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Land") then
					rspawn = (landUnitsE.Tech4)[Random(1, Eland)]
				end
				--x = math.floor(4 * WaveProgression + 0.5)
				if (MinorBossSpawns == "Land+Air" or MinorBossSpawns == "Land" or MinorBossSpawns == "ExtraLand" or MinorBossSpawns == "ExtraLand+ExtraAir" or MinorBossSpawns == "Land+ExtraAir")
				and Random(0, 95) <= 10 * ExpMulti then --2.3% 12.8% 24.4% +10
					CreateACombinedLandBossUnitAroundMainBuildingForAI()
				end
			elseif Hland > 0 and GameTime >= (1.2 * WaveProgression) and GameTime < (1.35 * WaveProgression) then --29.75
				if HlandHeavy > 0 and  Random(1, 32) <= TotalMayhemLand then
					rspawn = (landUnitsHHeavy.Tech4)[Random(1, HlandHeavy)]
				else
					rspawn = (landUnitsH.Tech4)[Random(1, Hland)]
				end
				--x = math.floor(4 * WaveProgression + 0.5)
				if Eland > 0 and Random(0, 25) <= 10 * ExpMulti --11.1% 61% 100% 1.47x
				and (ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Land") then
					rspawn = (landUnitsE.Tech4)[Random(1, Eland)]
				end
				--x = math.floor(4 * WaveProgression + 0.5)
				if (MinorBossSpawns == "Land+Air" or MinorBossSpawns == "Land" or MinorBossSpawns == "ExtraLand" or MinorBossSpawns == "ExtraLand+ExtraAir" or MinorBossSpawns == "Land+ExtraAir")
				and Random(0, 80) <= 10 * ExpMulti then --2.8% 15.5% 29.6% +10
					CreateACombinedLandBossUnitAroundMainBuildingForAI()
				end
			elseif Hland > 0 and GameTime >= (1.35 * WaveProgression) then --29.75
				if HlandHeavy > 0 and  Random(1, 31) <= TotalMayhemLand then
					rspawn = (landUnitsHHeavy.Tech4)[Random(1, HlandHeavy)]
				else
					rspawn = (landUnitsH.Tech4)[Random(1, Hland)]
				end
				--x = math.floor(4 * WaveProgression + 0.5)
				if Eland > 0 and Random(0, 20) <= 10 * ExpMulti --12.5% 68.8% 100% 1.3x
				and (ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Land") then
					rspawn = (landUnitsE.Tech4)[Random(1, Eland)]
				end
				--x = math.floor(4 * WaveProgression + 0.5)
				if (MinorBossSpawns == "Land+Air" or MinorBossSpawns == "Land" or MinorBossSpawns == "ExtraLand" or MinorBossSpawns == "ExtraLand+ExtraAir" or MinorBossSpawns == "Land+ExtraAir")
				and Random(0, 60) <= 10 * ExpMulti then --3.6% 19.6% 37.5% +5
					CreateACombinedLandBossUnitAroundMainBuildingForAI()
				end
		end
    return rspawn
end
GetRandomizedAirID = function(self)
    local rspawn = nil
	--local x = nil
	--GameTime = math.floor(GetGameTimeSeconds() - WavesStartTimeAI) / HoldTimeAI

		if LAir > 0 and GameTimeAir < (0.1 * WaveProgression) then
			rspawn = (LAirUnits.Tech4)[Random(1, LAir)]
			if MAir > 0 and (JumpTech2 == "Land+Air+Navy" or JumpTech2 == "Land+Air" or JumpTech2 == "Air+Navy" or JumpTech2 == "Air") then
					rspawn = (MAirUnits.Tech4)[Random(1, MAir)]
				end	
			elseif MAir > 0 and GameTimeAir >= (0.1 * WaveProgression) and GameTimeAir < (0.25 * WaveProgression) then
				rspawn = (MAirUnits.Tech4)[Random(1, MAir)]
			elseif MAir > 0 and GameTimeAir >= (0.25 * WaveProgression) and GameTimeAir < (0.35 * WaveProgression) then
				rspawn = (MAirUnits.Tech4)[Random(1, MAir)]	
				if HAir > 0 and Random(0, 50) <= 17 then
					rspawn = (HAirUnits.Tech4)[Random(1, HAir)]
				end	
			elseif HAir > 0 and GameTimeAir >= (0.35 * WaveProgression) and GameTimeAir < (0.45 * WaveProgression) then
				rspawn = (HAirUnits.Tech4)[Random(1, HAir)]
				if EAir > 0 and Random(0, 540) <= 10 * AirExpMulti then -- 0.5% 3% 5.8% x1.5
					if 1 >= Random(0, 10) and AirPower > 0 then
						rspawn = "AAR0310"
					else
						rspawn = (EAirUnits.Tech4)[Random(1, EAir)]
					end	
				end
			elseif HAir > 0 and GameTimeAir >= (0.45 * WaveProgression) and GameTimeAir < (0.55 * WaveProgression) then
				rspawn = (HAirUnits.Tech4)[Random(1, HAir)]
				if EAir > 0 and Random(0, 396) <= 10 * AirExpMulti then -- 0.9% 4.9% 9.5% x1.8
					if 1 >= Random(0, 10) and AirPower > 0 then
						rspawn = "AAR0310"
					else
						rspawn = (EAirUnits.Tech4)[Random(1, EAir)]
					end	
				end
			elseif HAir > 0 and GameTimeAir >= (0.55 * WaveProgression) and GameTimeAir < (0.65 * WaveProgression) then
				rspawn = (HAirUnits.Tech4)[Random(1, HAir)]
				if EAir > 0 and Random(0, 306) <= 10 * AirExpMulti then -- 1.2% 6.4% 12.2% x1.8
					if 1 >= Random(0, 10) and AirPower > 0 then
						rspawn = "AAR0310"
					else
						rspawn = (EAirUnits.Tech4)[Random(1, EAir)]
					end	
				end	
			elseif HAir > 0 and GameTimeAir >= (0.65 * WaveProgression) and GameTimeAir < (0.77 * WaveProgression) then
				rspawn = (HAirUnits.Tech4)[Random(1, HAir)]
				--x = math.floor(12 * WaveProgression + 0.5)
				if EAir > 0 and Random(0, 240) <= 10 * AirExpMulti then -- 1.6% 9% 17.5% x2
					if 1 >= Random(0, 10) and AirPower > 0 then
						rspawn = "AAR0310"
					else
						rspawn = (EAirUnits.Tech4)[Random(1, EAir)]
					end	
				end
				--[[if countair > 0 and Random(0, 360) <= 10 * AirExpMulti and (MinorBossSpawns == "Land+Air" or MinorBossSpawns == "Air" or MinorBossSpawns == "ExtraLand+ExtraAir" or MinorBossSpawns == "ExtraAir") then
					SpawnAIAirUnit()
				end]]--
			elseif HAir > 0 and GameTimeAir >= (0.77 * WaveProgression) and GameTimeAir < (0.9 * WaveProgression) then
				rspawn = (HAirUnits.Tech4)[Random(1, HAir)]
				--x = math.floor(12 * WaveProgression + 0.5)
				if EAir > 0 and Random(0, 180) <= 10 * AirExpMulti then -- 2.2% 12% 23% x2
					if 1 >= Random(0, 10) and AirPower > 0 then
						rspawn = "AAR0310"
					else
						rspawn = (EAirUnits.Tech4)[Random(1, EAir)]
					end	
				end
				if countair > 0 and Random(0, 360) <= 10 * AirExpMulti and (MinorBossSpawns == "Land+Air" or MinorBossSpawns == "Air" or MinorBossSpawns == "ExtraLand+ExtraAir" or MinorBossSpawns == "ExtraAir" or MinorBossSpawns == "Air+ExtraLand") then
					SpawnAIAirUnit() --0.8% 4.5% 8.7% x1.5
				end
			elseif HAir > 0 and GameTimeAir >= (0.9 * WaveProgression) and GameTimeAir < (1.05 * WaveProgression) then
				rspawn = (HAirUnits.Tech4)[Random(1, HAir)]
				--math.floor(5 * WaveProgression + 0.5)
				if EAir > 0 and Random(0, 120) <= 10 * AirExpMulti then -- 3.2% 18% 34% x2
					if 1 >= Random(0, 10) and AirPower > 0 then
						rspawn = "AAR0310"
					else
						rspawn = (EAirUnits.Tech4)[Random(1, EAir)]
					end	
				end
				--math.floor(20 * WaveProgression + 0.5)
				if countair > 0 and Random(0, 240) <= 10 * AirExpMulti and (MinorBossSpawns == "Land+Air" or MinorBossSpawns == "Air" or MinorBossSpawns == "ExtraLand+ExtraAir" or MinorBossSpawns == "ExtraAir" or MinorBossSpawns == "Air+ExtraLand") then
					SpawnAIAirUnit() --1.2% 6.8% 13% x1.5
				--elseif countair > 0 and (MinorBossSpawns == "Land+Air" or MinorBossSpawns == "Air" or MinorBossSpawns == "ExtraLand+ExtraAir" or MinorBossSpawns == "ExtraAir") and Random(0, 240) <= 10 * AirExpMulti then -- 0.8% 4.5% 8.7%
					--CreateACombinedAirBossUnitAroundMainBuildingForAI()
				end
			elseif HAir > 0 and GameTimeAir >= (1.05 * WaveProgression) and GameTimeAir < (1.2 * WaveProgression) then
				rspawn = (HAirUnits.Tech4)[Random(1, HAir)]
				if EAir > 0 and Random(0, 100) <= 10 * AirExpMulti then -- 4.3% 24% 45.6% x2
					if 1 >= Random(0, 10) and AirPower > 0 then
						rspawn = "AAR0310"
					else
						rspawn = (EAirUnits.Tech4)[Random(1, EAir)]
					end	
				end
				if countair > 0 and Random(0, 210) <= 10 * AirExpMulti and (MinorBossSpawns == "Land+Air" or MinorBossSpawns == "Air" or MinorBossSpawns == "ExtraLand+ExtraAir" or MinorBossSpawns == "ExtraAir" or MinorBossSpawns == "Air+ExtraLand") then
					SpawnAIAirUnit() --1.6% 9% 17.5% x1.5
				end
			elseif HAir > 0 and GameTimeAir >= (1.2 * WaveProgression) and GameTimeAir < (1.35 * WaveProgression) then
				rspawn = (HAirUnits.Tech4)[Random(1, HAir)]
				if EAir > 0 and Random(0, 80) <= 10 * AirExpMulti then -- 5.6% 30.6% 58.3% x2
					if 1 >= Random(0, 10) and AirPower > 0 then
						rspawn = "AAR0310"
					else
						rspawn = (EAirUnits.Tech4)[Random(1, EAir)]
					end	
				end
				if countair > 0 and Random(0, 180) <= 10 * AirExpMulti and (MinorBossSpawns == "Land+Air" or MinorBossSpawns == "Air" or MinorBossSpawns == "ExtraLand+ExtraAir" or MinorBossSpawns == "ExtraAir" or MinorBossSpawns == "Air+ExtraLand") then
					SpawnAIAirUnit() --2.1% 12.1% 23.1% x1.5
				end
			elseif HAir > 0 and GameTimeAir >= (1.35 * WaveProgression) then
				rspawn = (HAirUnits.Tech4)[Random(1, HAir)]
				if EAir > 0 and Random(0, 45) <= 10 * AirExpMulti then -- 6.7% 36.7% 70% x1.5
					if 1 >= Random(0, 10) and AirPower > 0 then
						rspawn = "AAR0310"
					else
						rspawn = (EAirUnits.Tech4)[Random(1, EAir)]
					end	
				end
				if countair > 0 and Random(0, 100) <= 10 * AirExpMulti and (MinorBossSpawns == "Land+Air" or MinorBossSpawns == "Air" or MinorBossSpawns == "ExtraLand+ExtraAir" or MinorBossSpawns == "ExtraAir" or MinorBossSpawns == "Air+ExtraLand") then
					SpawnAIAirUnit() --2.8% 12.1% 23.1%
				end
		end
    return rspawn
end
GetRandomizedTotMayAirID = function(self)
    local rspawn = nil
	--local x = nil
	--GameTime = math.floor(GetGameTimeSeconds() - WavesStartTimeAI) / HoldTimeAI

		if LAir > 0 and GameTimeAir < (0.1 * WaveProgression) then
			if LAirHeavy > 0 and Random(1, 40) <= TotalMayhemAir then
				rspawn = (LAirUnitsHeavy.Tech4)[Random(1, LAirHeavy)]
			else
				rspawn = (LAirUnits.Tech4)[Random(1, LAir)]
			end	
			if MAir > 0 and (JumpTech2 == "Land+Air+Navy" or JumpTech2 == "Land+Air" or JumpTech2 == "Air+Navy" or JumpTech2 == "Air") then
					if MAirHeavy > 0 and Random(1, 40) <= TotalMayhemAir then
						rspawn = (MAirUnitsHeavy.Tech4)[Random(1, MAirHeavy)]
					else
						rspawn = (MAirUnits.Tech4)[Random(1, MAir)]
					end	
				end	
			elseif MAir > 0 and GameTimeAir >= (0.1 * WaveProgression) and GameTimeAir < (0.25 * WaveProgression) then
				if MAirHeavy > 0 and Random(1, 40) <= TotalMayhemAir then
					rspawn = (MAirUnitsHeavy.Tech4)[Random(1, MAirHeavy)]
				else
					rspawn = (MAirUnits.Tech4)[Random(1, MAir)]
				end	
			elseif MAir > 0 and GameTimeAir >= (0.25 * WaveProgression) and GameTimeAir < (0.35 * WaveProgression) then
				if MAirHeavy > 0 and Random(1, 30) <= TotalMayhemAir then
					rspawn = (MAirUnitsHeavy.Tech4)[Random(1, MAirHeavy)]
				else
					rspawn = (MAirUnits.Tech4)[Random(1, MAir)]
				end		
				if HAir > 0 and Random(0, 50) <= 17 then
					if HAirHeavy > 0 and Random(1, 40) <= TotalMayhemAir then
						rspawn = (HAirUnitsHeavy.Tech4)[Random(1, HAirHeavy)]
					else
						rspawn = (HAirUnits.Tech4)[Random(1, HAir)]
					end	
				end	
			elseif HAir > 0 and GameTimeAir >= (0.35 * WaveProgression) and GameTimeAir < (0.45 * WaveProgression) then
				if HAirHeavy > 0 and Random(1, 40) <= TotalMayhemAir then
					rspawn = (HAirUnitsHeavy.Tech4)[Random(1, HAirHeavy)]
				else
					rspawn = (HAirUnits.Tech4)[Random(1, HAir)]
				end	
				if EAir > 0 and Random(0, 540) <= 10 * AirExpMulti then -- 0.5% 3% 5.8% x1.5
					if 1 >= Random(0, 10) and AirPower > 0 then
						rspawn = "AAR0310"
					else
						rspawn = (EAirUnits.Tech4)[Random(1, EAir)]
					end	
				end
			elseif HAir > 0 and GameTimeAir >= (0.45 * WaveProgression) and GameTimeAir < (0.55 * WaveProgression) then
				if HAirHeavy > 0 and Random(1, 39) <= TotalMayhemAir then
					rspawn = (HAirUnitsHeavy.Tech4)[Random(1, HAirHeavy)]
				else
					rspawn = (HAirUnits.Tech4)[Random(1, HAir)]
				end	
				if EAir > 0 and Random(0, 396) <= 10 * AirExpMulti then -- 0.9% 4.9% 9.5% x1.8
					if 1 >= Random(0, 10) and AirPower > 0 then
						rspawn = "AAR0310"
					else
						rspawn = (EAirUnits.Tech4)[Random(1, EAir)]
					end	
				end
			elseif HAir > 0 and GameTimeAir >= (0.55 * WaveProgression) and GameTimeAir < (0.65 * WaveProgression) then
				if HAirHeavy > 0 and Random(1, 38) <= TotalMayhemAir then
					rspawn = (HAirUnitsHeavy.Tech4)[Random(1, HAirHeavy)]
				else
					rspawn = (HAirUnits.Tech4)[Random(1, HAir)]
				end	
				if EAir > 0 and Random(0, 306) <= 10 * AirExpMulti then -- 1.2% 6.4% 12.2% x1.8
					if 1 >= Random(0, 10) and AirPower > 0 then
						rspawn = "AAR0310"
					else
						rspawn = (EAirUnits.Tech4)[Random(1, EAir)]
					end	
				end	
			elseif HAir > 0 and GameTimeAir >= (0.65 * WaveProgression) and GameTimeAir < (0.77 * WaveProgression) then
				if HAirHeavy > 0 and Random(1, 37) <= TotalMayhemAir then
					rspawn = (HAirUnitsHeavy.Tech4)[Random(1, HAirHeavy)]
				else
					rspawn = (HAirUnits.Tech4)[Random(1, HAir)]
				end	
				--x = math.floor(12 * WaveProgression + 0.5)
				if EAir > 0 and Random(0, 240) <= 10 * AirExpMulti then -- 1.6% 9% 17.5% x2
					if 1 >= Random(0, 10) and AirPower > 0 then
						rspawn = "AAR0310"
					else
						rspawn = (EAirUnits.Tech4)[Random(1, EAir)]
					end	
				end
				--[[if countair > 0 and Random(0, 360) <= 10 * AirExpMulti and (MinorBossSpawns == "Land+Air" or MinorBossSpawns == "Air" or MinorBossSpawns == "ExtraLand+ExtraAir" or MinorBossSpawns == "ExtraAir") then
					SpawnAIAirUnit()
				end]]--
			elseif HAir > 0 and GameTimeAir >= (0.77 * WaveProgression) and GameTimeAir < (0.9 * WaveProgression) then
				if HAirHeavy > 0 and Random(1, 36) <= TotalMayhemAir then
					rspawn = (HAirUnitsHeavy.Tech4)[Random(1, HAirHeavy)]
				else
					rspawn = (HAirUnits.Tech4)[Random(1, HAir)]
				end	
				--x = math.floor(12 * WaveProgression + 0.5)
				if EAir > 0 and Random(0, 180) <= 10 * AirExpMulti then -- 2.2% 12% 23% x2
					if 1 >= Random(0, 10) and AirPower > 0 then
						rspawn = "AAR0310"
					else
						rspawn = (EAirUnits.Tech4)[Random(1, EAir)]
					end	
				end
				if countair > 0 and Random(0, 360) <= 10 * AirExpMulti and (MinorBossSpawns == "Land+Air" or MinorBossSpawns == "Air" or MinorBossSpawns == "ExtraLand+ExtraAir" or MinorBossSpawns == "ExtraAir" or MinorBossSpawns == "Air+ExtraLand") then
					SpawnAIAirUnit() --0.8% 4.5% 8.7% x1.5
				end
			elseif HAir > 0 and GameTimeAir >= (0.9 * WaveProgression) and GameTimeAir < (1.05 * WaveProgression) then
				if HAirHeavy > 0 and Random(1, 35) <= TotalMayhemAir then
					rspawn = (HAirUnitsHeavy.Tech4)[Random(1, HAirHeavy)]
				else
					rspawn = (HAirUnits.Tech4)[Random(1, HAir)]
				end	
				--math.floor(5 * WaveProgression + 0.5)
				if EAir > 0 and Random(0, 120) <= 10 * AirExpMulti then -- 3.2% 18% 34% x2
					if 1 >= Random(0, 10) and AirPower > 0 then
						rspawn = "AAR0310"
					else
						rspawn = (EAirUnits.Tech4)[Random(1, EAir)]
					end	
				end
				--math.floor(20 * WaveProgression + 0.5)
				if countair > 0 and Random(0, 240) <= 10 * AirExpMulti and (MinorBossSpawns == "Land+Air" or MinorBossSpawns == "Air" or MinorBossSpawns == "ExtraLand+ExtraAir" or MinorBossSpawns == "ExtraAir" or MinorBossSpawns == "Air+ExtraLand") then
					SpawnAIAirUnit() --1.2% 6.8% 13% x1.5
				--elseif countair > 0 and (MinorBossSpawns == "Land+Air" or MinorBossSpawns == "Air" or MinorBossSpawns == "ExtraLand+ExtraAir" or MinorBossSpawns == "ExtraAir") and Random(0, 240) <= 10 * AirExpMulti then -- 0.8% 4.5% 8.7%
					--CreateACombinedAirBossUnitAroundMainBuildingForAI()
				end
			elseif HAir > 0 and GameTimeAir >= (1.05 * WaveProgression) and GameTimeAir < (1.2 * WaveProgression) then
				if HAirHeavy > 0 and Random(1, 34) <= TotalMayhemAir then
					rspawn = (HAirUnitsHeavy.Tech4)[Random(1, HAirHeavy)]
				else
					rspawn = (HAirUnits.Tech4)[Random(1, HAir)]
				end	
				if EAir > 0 and Random(0, 100) <= 10 * AirExpMulti then -- 4.3% 24% 45.6% x2
					if 1 >= Random(0, 10) and AirPower > 0 then
						rspawn = "AAR0310"
					else
						rspawn = (EAirUnits.Tech4)[Random(1, EAir)]
					end	
				end
				if countair > 0 and Random(0, 210) <= 10 * AirExpMulti and (MinorBossSpawns == "Land+Air" or MinorBossSpawns == "Air" or MinorBossSpawns == "ExtraLand+ExtraAir" or MinorBossSpawns == "ExtraAir" or MinorBossSpawns == "Air+ExtraLand") then
					SpawnAIAirUnit() --1.6% 9% 17.5% x1.5
				end
			elseif HAir > 0 and GameTimeAir >= (1.2 * WaveProgression) and GameTimeAir < (1.35 * WaveProgression) then
				if HAirHeavy > 0 and Random(1, 33) <= TotalMayhemAir then
					rspawn = (HAirUnitsHeavy.Tech4)[Random(1, HAirHeavy)]
				else
					rspawn = (HAirUnits.Tech4)[Random(1, HAir)]
				end	
				if EAir > 0 and Random(0, 80) <= 10 * AirExpMulti then -- 5.6% 30.6% 58.3% x2
					if 1 >= Random(0, 10) and AirPower > 0 then
						rspawn = "AAR0310"
					else
						rspawn = (EAirUnits.Tech4)[Random(1, EAir)]
					end	
				end
				if countair > 0 and Random(0, 180) <= 10 * AirExpMulti and (MinorBossSpawns == "Land+Air" or MinorBossSpawns == "Air" or MinorBossSpawns == "ExtraLand+ExtraAir" or MinorBossSpawns == "ExtraAir" or MinorBossSpawns == "Air+ExtraLand") then
					SpawnAIAirUnit() --2.1% 12.1% 23.1% x1.5
				end
			elseif HAir > 0 and GameTimeAir >= (1.35 * WaveProgression) then
				if HAirHeavy > 0 and Random(1, 32) <= TotalMayhemAir then
					rspawn = (HAirUnitsHeavy.Tech4)[Random(1, HAirHeavy)]
				else
					rspawn = (HAirUnits.Tech4)[Random(1, HAir)]
				end	
				if EAir > 0 and Random(0, 45) <= 10 * AirExpMulti then -- 6.7% 36.7% 70% x1.5
					if 1 >= Random(0, 10) and AirPower > 0 then
						rspawn = "AAR0310"
					else
						rspawn = (EAirUnits.Tech4)[Random(1, EAir)]
					end	
				end
				if countair > 0 and Random(0, 100) <= 10 * AirExpMulti and (MinorBossSpawns == "Land+Air" or MinorBossSpawns == "Air" or MinorBossSpawns == "ExtraLand+ExtraAir" or MinorBossSpawns == "ExtraAir" or MinorBossSpawns == "Air+ExtraLand") then
					SpawnAIAirUnit() --2.8% 12.1% 23.1%
				end
		end
    return rspawn
end
GetRandomizedNavyID = function(self)
    local rspawn = nil
	--local x = nil
	--GameTimeNavy = math.floor(GetGameTimeSeconds() - WavesStartTimeAI - NavyTime) / HoldTimeAI

		if LNavy > 0 and GameTimeNavy < (0.12 * WaveProgression) then
			rspawn = (LNavyUnits.Tech4)[Random(1, LNavy)]
				if MNavy > 0 and (JumpTech2 == "Land+Air+Navy" or JumpTech2 == "Land+Navy" or JumpTech2 == "Air+Navy" or JumpTech2 == "Navy") then
					rspawn = (MNavyUnits.Tech4)[Random(1, MNavy)]
				end	
			elseif MNavy > 0 and GameTimeNavy >= (0.12 * WaveProgression) and GameTimeNavy < (0.27 * WaveProgression) then
				rspawn = (MNavyUnits.Tech4)[Random(1, MNavy)]
				if LNavy > 0 and Random(1, 3) == 1 and GameTimeNavy < (0.18 * WaveProgression) and not (JumpTech2 == "Land+Air+Navy" or JumpTech2 == "Land+Navy" or JumpTech2 == "Air+Navy" or JumpTech2 == "Navy") then
					rspawn = (LNavyUnits.Tech4)[Random(1, LNavy)]
				end	
			elseif MNavy > 0 and GameTimeNavy >= (0.27 * WaveProgression) and GameTimeNavy < (0.36 * WaveProgression) then
				rspawn = (MNavyUnits.Tech4)[Random(1, MNavy)]
				if HNavy > 0 and Random(1, 5) == 1 then
					rspawn = (HNavyUnits.Tech4)[Random(1, HNavy)]
				end
			elseif MNavy > 0 and GameTimeNavy >= (0.36 * WaveProgression) and GameTimeNavy < (0.45 * WaveProgression) then
				rspawn = (MNavyUnits.Tech4)[Random(1, MNavy)]
				if HNavy > 0 and Random(1, 3) == 1 then
					rspawn = (HNavyUnits.Tech4)[Random(1, HNavy)]
				end
			elseif HNavy > 0 and GameTimeNavy >= (0.45 * WaveProgression) and GameTimeNavy < (0.55 * WaveProgression) then
				rspawn = (HNavyUnits.Tech4)[Random(1, HNavy)]
				if MNavy > 0 and Random(1, 2) == 1 then
					rspawn = (MNavyUnits.Tech4)[Random(1, MNavy)]
				end
				if ENavy > 0 and Random(0, 320) <= 10 * NavyExpMulti then --1.2% 6.8% 13% x2
					rspawn = (ENavyUnits.Tech4)[Random(1, ENavy)]
				end
			elseif HNavy > 0 and GameTimeNavy >= (0.55 * WaveProgression) and GameTimeNavy < (0.65 * WaveProgression) then
				rspawn = (HNavyUnits.Tech4)[Random(1, HNavy)]
				if MNavy > 0 and Random(1, 3) == 1 then
					rspawn = (MNavyUnits.Tech4)[Random(1, MNavy)]
				end
				if ENavy > 0 and Random(0, 200) <= 10 * NavyExpMulti then --1.9% 10.8% 20.7% x2
					rspawn = (ENavyUnits.Tech4)[Random(1, ENavy)]
				end
			elseif HNavy > 0 and GameTimeNavy >= (0.65 * WaveProgression) and GameTimeNavy < (0.77 * WaveProgression) then
				rspawn = (HNavyUnits.Tech4)[Random(1, HNavy)]
				if MNavy > 0 and Random(1, 5) == 1 then
					rspawn = (MNavyUnits.Tech4)[Random(1, MNavy)]
				end
				if ENavy > 0 and Random(0, 140) <= 10 * NavyExpMulti then --2.8% 15.5% 29.6% x2
					rspawn = (ENavyUnits.Tech4)[Random(1, ENavy)]
				end		
			elseif HNavy > 0 and GameTimeNavy >= (0.77 * WaveProgression) and GameTimeNavy < (0.9 * WaveProgression) then
				rspawn = (HNavyUnits.Tech4)[Random(1, HNavy)]
				if MNavy > 0 and Random(1, 8) == 1 then
					rspawn = (MNavyUnits.Tech4)[Random(1, MNavy)]
				end
				--x = math.floor(8 * WaveProgression + 0.5)
				if ENavy > 0 and Random(0, 100) <= 10 * NavyExpMulti then --3.9% 21.6% 41.2% x2
					rspawn = (ENavyUnits.Tech4)[Random(1, ENavy)]
				end
			elseif HNavy > 0 and GameTimeNavy >= (0.9 * WaveProgression) and GameTimeNavy < (1.05 * WaveProgression) then
				rspawn = (HNavyUnits.Tech4)[Random(1, HNavy)]
				--x = math.floor(4 * WaveProgression + 0.5)
				if ENavy > 0 and Random(0, 60) <= 10 * NavyExpMulti then --6.5% 35.5% 67.7% x2
					rspawn = (ENavyUnits.Tech4)[Random(1, ENavy)]
				end
			elseif HNavy > 0 and GameTimeNavy >= (1.05 * WaveProgression) and GameTimeNavy < (1.2 * WaveProgression) then
				rspawn = (HNavyUnits.Tech4)[Random(1, HNavy)]
				--x = math.floor(4 * WaveProgression + 0.5)
				if ENavy > 0 and Random(0, 52) <= 10 * NavyExpMulti then --7.7% 42.3% 80.1% x2
					rspawn = (ENavyUnits.Tech4)[Random(1, ENavy)]
				end
			elseif HNavy > 0 and GameTimeNavy >= (1.2 * WaveProgression) and GameTimeNavy < (1.35 * WaveProgression) then
				rspawn = (HNavyUnits.Tech4)[Random(1, HNavy)]
				--x = math.floor(4 * WaveProgression + 0.5)
				if ENavy > 0 and Random(0, 46) <= 10 * NavyExpMulti then --8.6% 47.8% 91.3% x2
					rspawn = (ENavyUnits.Tech4)[Random(1, ENavy)]
				end
			elseif HNavy > 0 and GameTimeNavy >= (1.35 * WaveProgression) then
				rspawn = (HNavyUnits.Tech4)[Random(1, HNavy)]
				--x = math.floor(4 * WaveProgression + 0.5)
				if ENavy > 0 and Random(0, 40) <= 10 * NavyExpMulti then --10% 55% 100% x2
					rspawn = (ENavyUnits.Tech4)[Random(1, ENavy)]
				end
		end
    return rspawn
end
GetRandomizedTotMayNavyID = function(self)
    local rspawn = nil
	--local x = nil
	--GameTimeNavy = math.floor(GetGameTimeSeconds() - WavesStartTimeAI - NavyTime) / HoldTimeAI

		if LNavy > 0 and GameTimeNavy < (0.12 * WaveProgression) then
			if LNavyHeavy > 0 and Random(1, 40) <= TotalMayhemNavy then
				rspawn = (LNavyUnitsHeavy.Tech4)[Random(1, LNavyHeavy)]
			else
				rspawn = (LNavyUnits.Tech4)[Random(1, LNavy)]
			end	
				if MNavy > 0 and (JumpTech2 == "Land+Air+Navy" or JumpTech2 == "Land+Navy" or JumpTech2 == "Air+Navy" or JumpTech2 == "Navy") then
					if MNavyHeavy > 0 and Random(1, 40) <= TotalMayhemNavy then
						rspawn = (MNavyUnitsHeavy.Tech4)[Random(1, MNavyHeavy)]
					else
						rspawn = (MNavyUnits.Tech4)[Random(1, MNavy)]
					end	
				end	
			elseif MNavy > 0 and GameTimeNavy >= (0.12 * WaveProgression) and GameTimeNavy < (0.27 * WaveProgression) then
				if MNavyHeavy > 0 and Random(1, 40) <= TotalMayhemNavy then
					rspawn = (MNavyUnitsHeavy.Tech4)[Random(1, MNavyHeavy)]
				else
					rspawn = (MNavyUnits.Tech4)[Random(1, MNavy)]
				end	
				if LNavy > 0 and Random(1, 3) == 1 and GameTimeNavy < (0.18 * WaveProgression) and not (JumpTech2 == "Land+Air+Navy" or JumpTech2 == "Land+Navy" or JumpTech2 == "Air+Navy" or JumpTech2 == "Navy") then
					if LNavyHeavy > 0 and Random(1, 30) <= TotalMayhemNavy then
						rspawn = (LNavyUnitsHeavy.Tech4)[Random(1, LNavyHeavy)]
					else
						rspawn = (LNavyUnits.Tech4)[Random(1, LNavy)]
					end
				end	
			elseif MNavy > 0 and GameTimeNavy >= (0.27 * WaveProgression) and GameTimeNavy < (0.36 * WaveProgression) then
				if MNavyHeavy > 0 and Random(1, 38) <= TotalMayhemNavy then
					rspawn = (MNavyUnitsHeavy.Tech4)[Random(1, MNavyHeavy)]
				else
					rspawn = (MNavyUnits.Tech4)[Random(1, MNavy)]
				end	
				if HNavy > 0 and Random(1, 5) == 1 then
					if HNavyHeavy > 0 and Random(1, 40) <= TotalMayhemNavy then
						rspawn = (HNavyUnitsHeavy.Tech4)[Random(1, HNavyHeavy)]
					else
						rspawn = (HNavyUnits.Tech4)[Random(1, HNavy)]
					end	
				end
			elseif MNavy > 0 and GameTimeNavy >= (0.36 * WaveProgression) and GameTimeNavy < (0.45 * WaveProgression) then
				if MNavyHeavy > 0 and Random(1, 36) <= TotalMayhemNavy then
					rspawn = (MNavyUnitsHeavy.Tech4)[Random(1, MNavyHeavy)]
				else
					rspawn = (MNavyUnits.Tech4)[Random(1, MNavy)]
				end	
				if HNavy > 0 and Random(1, 3) == 1 then
					if HNavyHeavy > 0 and Random(1, 39) <= TotalMayhemNavy then
						rspawn = (HNavyUnitsHeavy.Tech4)[Random(1, HNavyHeavy)]
					else
						rspawn = (HNavyUnits.Tech4)[Random(1, HNavy)]
					end	
				end
			elseif HNavy > 0 and GameTimeNavy >= (0.45 * WaveProgression) and GameTimeNavy < (0.55 * WaveProgression) then
					if HNavyHeavy > 0 and Random(1, 38) <= TotalMayhemNavy then
						rspawn = (HNavyUnitsHeavy.Tech4)[Random(1, HNavyHeavy)]
					else
						rspawn = (HNavyUnits.Tech4)[Random(1, HNavy)]
					end	
				if MNavy > 0 and Random(1, 2) == 1 then
					if MNavyHeavy > 0 and Random(1, 34) <= TotalMayhemNavy then
					rspawn = (MNavyUnitsHeavy.Tech4)[Random(1, MNavyHeavy)]
					else
					rspawn = (MNavyUnits.Tech4)[Random(1, MNavy)]
					end	
				end
				if ENavy > 0 and Random(0, 320) <= 10 * NavyExpMulti then --1.2% 6.8% 13% x2
					rspawn = (ENavyUnits.Tech4)[Random(1, ENavy)]
				end
			elseif HNavy > 0 and GameTimeNavy >= (0.55 * WaveProgression) and GameTimeNavy < (0.65 * WaveProgression) then
					if HNavyHeavy > 0 and Random(1, 37) <= TotalMayhemNavy then
						rspawn = (HNavyUnitsHeavy.Tech4)[Random(1, HNavyHeavy)]
					else
						rspawn = (HNavyUnits.Tech4)[Random(1, HNavy)]
					end	
				if MNavy > 0 and Random(1, 3) == 1 then
					if MNavyHeavy > 0 and Random(1, 32) <= TotalMayhemNavy then
						rspawn = (MNavyUnitsHeavy.Tech4)[Random(1, MNavyHeavy)]
					else
						rspawn = (MNavyUnits.Tech4)[Random(1, MNavy)]
					end	
				end
				if ENavy > 0 and Random(0, 200) <= 10 * NavyExpMulti then --1.9% 10.8% 20.7% x2
					rspawn = (ENavyUnits.Tech4)[Random(1, ENavy)]
				end
			elseif HNavy > 0 and GameTimeNavy >= (0.65 * WaveProgression) and GameTimeNavy < (0.77 * WaveProgression) then
					if HNavyHeavy > 0 and Random(1, 36) <= TotalMayhemNavy then
						rspawn = (HNavyUnitsHeavy.Tech4)[Random(1, HNavyHeavy)]
					else
						rspawn = (HNavyUnits.Tech4)[Random(1, HNavy)]
					end	
				if MNavy > 0 and Random(1, 5) == 1 then
					if MNavyHeavy > 0 and Random(1, 30) <= TotalMayhemNavy then
						rspawn = (MNavyUnitsHeavy.Tech4)[Random(1, MNavyHeavy)]
					else
						rspawn = (MNavyUnits.Tech4)[Random(1, MNavy)]
					end	
				end
				if ENavy > 0 and Random(0, 140) <= 10 * NavyExpMulti then --2.8% 15.5% 29.6% x2
					rspawn = (ENavyUnits.Tech4)[Random(1, ENavy)]
				end		
			elseif HNavy > 0 and GameTimeNavy >= (0.77 * WaveProgression) and GameTimeNavy < (0.9 * WaveProgression) then
					if HNavyHeavy > 0 and Random(1, 35) <= TotalMayhemNavy then
						rspawn = (HNavyUnitsHeavy.Tech4)[Random(1, HNavyHeavy)]
					else
						rspawn = (HNavyUnits.Tech4)[Random(1, HNavy)]
					end	
				if MNavy > 0 and Random(1, 8) == 1 then
					if MNavyHeavy > 0 and Random(1, 28) <= TotalMayhemNavy then
						rspawn = (MNavyUnitsHeavy.Tech4)[Random(1, MNavyHeavy)]
					else
						rspawn = (MNavyUnits.Tech4)[Random(1, MNavy)]
					end	
				end
				--x = math.floor(8 * WaveProgression + 0.5)
				if ENavy > 0 and Random(0, 100) <= 10 * NavyExpMulti then --3.9% 21.6% 41.2% x2
					rspawn = (ENavyUnits.Tech4)[Random(1, ENavy)]
				end
			elseif HNavy > 0 and GameTimeNavy >= (0.9 * WaveProgression) and GameTimeNavy < (1.05 * WaveProgression) then
					if HNavyHeavy > 0 and Random(1, 34) <= TotalMayhemNavy then
						rspawn = (HNavyUnitsHeavy.Tech4)[Random(1, HNavyHeavy)]
					else
						rspawn = (HNavyUnits.Tech4)[Random(1, HNavy)]
					end	
				--x = math.floor(4 * WaveProgression + 0.5)
				if ENavy > 0 and Random(0, 60) <= 10 * NavyExpMulti then --6.5% 35.5% 67.7% x2
					rspawn = (ENavyUnits.Tech4)[Random(1, ENavy)]
				end
			elseif HNavy > 0 and GameTimeNavy >= (1.05 * WaveProgression) and GameTimeNavy < (1.2 * WaveProgression) then
					if HNavyHeavy > 0 and Random(1, 33) <= TotalMayhemNavy then
						rspawn = (HNavyUnitsHeavy.Tech4)[Random(1, HNavyHeavy)]
					else
						rspawn = (HNavyUnits.Tech4)[Random(1, HNavy)]
					end	
				--x = math.floor(4 * WaveProgression + 0.5)
				if ENavy > 0 and Random(0, 52) <= 10 * NavyExpMulti then --7.7% 42.3% 80.1% x2
					rspawn = (ENavyUnits.Tech4)[Random(1, ENavy)]
				end
			elseif HNavy > 0 and GameTimeNavy >= (1.2 * WaveProgression) and GameTimeNavy < (1.35 * WaveProgression) then
					if HNavyHeavy > 0 and Random(1, 32) <= TotalMayhemNavy then
						rspawn = (HNavyUnitsHeavy.Tech4)[Random(1, HNavyHeavy)]
					else
						rspawn = (HNavyUnits.Tech4)[Random(1, HNavy)]
					end	
				--x = math.floor(4 * WaveProgression + 0.5)
				if ENavy > 0 and Random(0, 46) <= 10 * NavyExpMulti then --8.6% 47.8% 91.3% x2
					rspawn = (ENavyUnits.Tech4)[Random(1, ENavy)]
				end
			elseif HNavy > 0 and GameTimeNavy >= (1.35 * WaveProgression) then
					if HNavyHeavy > 0 and Random(1, 31) <= TotalMayhemNavy then
						rspawn = (HNavyUnitsHeavy.Tech4)[Random(1, HNavyHeavy)]
					else
						rspawn = (HNavyUnits.Tech4)[Random(1, HNavy)]
					end	
				--x = math.floor(4 * WaveProgression + 0.5)
				if ENavy > 0 and Random(0, 40) <= 10 * NavyExpMulti then --10% 55% 100% x2
					rspawn = (ENavyUnits.Tech4)[Random(1, ENavy)]
				end
		end
    return rspawn
end
GetRandomizedIDforLand = function(self)
    local rspawn = nil
	if TotalMayhemWaves == "Adjustable T1/T2/T3 Experimentals" then
		rspawn = GetRandomizedTotMayLandID()
	else
		rspawn = GetRandomizedUnitID()
	end
	return rspawn
end
GetRandomizedIDforAir = function(self)
    local rspawn = nil
	if TotalMayhemWaves == "Adjustable T1/T2/T3 Experimentals" then
		rspawn = GetRandomizedTotMayAirID()
	else
		rspawn = GetRandomizedAirID()
	end
	return rspawn
end	
GetRandomizedIDforNavy = function(self)
    local rspawn = nil
	if TotalMayhemWaves == "Adjustable T1/T2/T3 Experimentals" then
		rspawn = GetRandomizedTotMayNavyID()
	else
		rspawn = GetRandomizedNavyID()
	end
	return rspawn
end	
function TFl4() -- Land Spawn
    local circle = ForkThread(function(self)
        local unit
        --local goforest = 0
        local rspawn = nil
		local posX = nil
		local posZ = nil
        --local MapCheck = false
		local Chance
		--local count = 0
        if land4 == 1 then
            WaitTicks(Random(1, 6))
            if secondaryspawn ~= "Off" and spawnrateland > 0 and SecondarySpawnDead == false then
					if Alt2ndSpawn ~= "Off" and Alt2ndBuildingDead == false and Random(1, 2) == 1 then
						posX, posZ = Alt2ndBrain:GetArmyStartPos()
					else
						posX, posZ = SecBrain:GetArmyStartPos()
					end	
				if Random(1, 100) > spawnrateland then
					if AltHQSpawn ~= "Off" and HQAltBuildingDead == false and Random(1, 2) == 1 then
						posX, posZ = AltHQBrain:GetArmyStartPos()
					else
						posX, posZ = aiBrain:GetArmyStartPos()
					end	
				end	
			else
				if AltHQSpawn ~= "Off" and HQAltBuildingDead == false and Random(1, 2) == 1 then
					posX, posZ = AltHQBrain:GetArmyStartPos()
				else
					posX, posZ = aiBrain:GetArmyStartPos()
				end	
			end	
			if secondaryspawn ~= "Off" and SecondarySpawnDead == true and spawnrateland > 0 then
				if spawnratelandmulti ~= 0 and (spawnratelandmulti + 2) >= Random(1, 100) then
					if AltHQSpawn ~= "Off" and HQAltBuildingDead == false and Random(1, 2) == 1 then
						posX, posZ = AltHQBrain:GetArmyStartPos()
					else
						posX, posZ = aiBrain:GetArmyStartPos()
					end
				else
					return
				end	
			end	
            if GetGameTimeSeconds() > WavesStartTimeAI then
                if CrazyModeLand == "Normal Land" then
					rspawn = GetRandomizedIDforLand()
				elseif CrazyModeLand == "Tech 1 Land Only" then
					rspawn = (landUnitsL.Tech4)[Random(1, Lland)]
				elseif CrazyModeLand == "Tech 2 Land Only" then
					rspawn = (landUnitsM.Tech4)[Random(1, Mland)]
				elseif CrazyModeLand == "Tech 3 Land Only" then
					rspawn = (landUnitsH.Tech4)[Random(1, Hland)]
				elseif CrazyModeLand == "Experimental Land Only" then
					rspawn = (landUnitsE.Tech4)[Random(1, Eland)]
				elseif CrazyModeLand == "Minor Land Boss Only" then
					CreateACombinedLandBossUnitAroundMainBuildingForAI()
					KillThread(self)
				elseif CrazyModeLand == "EndGame Land Boss Only" then
					CreateHugeBossUnitAroundMainBuildingForAI()
					KillThread(self)
				end
                --[[if enemyParagonsCount > 15 then
                    enemyParagonsCount = 24
                    lockedDifficulty = true
                end]]--
                if rspawn ~= nil then
                    local oldposX = posX
                    local oldposZ = posZ
						Chance = Random(1, 8)
						if Chance == 1 then
							posX = posX + Random(1, 55)
							posZ = posZ + Random(1, 55)
						elseif Chance == 2 then
							posX = posX - Random(1, 55)
							posZ = posZ + Random(1, 55)
						elseif Chance == 3 then
							posX = posX + Random(1, 55)
							posZ = posZ - Random(1, 55)
						elseif Chance == 4 then
							posX = posX - Random(1, 55)
							posZ = posZ - Random(1, 55)
						elseif Chance == 5 then
							posZ = posZ + Random(1, 55)
							posX = posX + Random(1, 55)
						elseif Chance == 6 then
							posZ = posZ - Random(1, 55)
							posX = posX + Random(1, 55)
						elseif Chance == 7 then
							posZ = posZ + Random(1, 55)
							posX = posX - Random(1, 55)
						else
							posZ = posZ - Random(1, 55)
							posX = posX - Random(1, 55)
						end

						if posX < 5 then
							posX = Random(5, 55)
						end
						if posX > (sizeX - 5) then
							posX = sizeX - Random(5, 55)
						end
						if posZ < 5 then
							posZ = Random(5, 55)
						end
						if posZ > (sizeZ - 5) then
							posZ = sizeZ - Random(5, 55)
						end
                    unit = aiBrain:CreateUnitNearSpot(rspawn, posX, posZ)
                    if unit == nil then
                        local posX = oldposX
                        local posZ = oldposZ
							Chance = Random(1, 8)
							if Chance == 1 then
								posX = posX + Random(1, 55)
								posZ = posZ + Random(1, 55)
							elseif Chance == 2 then
								posX = posX - Random(1, 55)
								posZ = posZ + Random(1, 55)
							elseif Chance == 3 then
								posX = posX + Random(1, 55)
								posZ = posZ - Random(1, 55)
							elseif Chance == 4 then
								posX = posX - Random(1, 55)
								posZ = posZ - Random(1, 55)
							elseif Chance == 5 then
								posZ = posZ + Random(1, 55)
								posX = posX + Random(1, 55)
							elseif Chance == 6 then
								posZ = posZ - Random(1, 55)
								posX = posX + Random(1, 55)
							elseif Chance == 7 then
								posZ = posZ + Random(1, 55)
								posX = posX - Random(1, 55)
							else
								posZ = posZ - Random(1, 55)
								posX = posX - Random(1, 55)
							end

							if posX < 5 then
								posX = Random(5, 55)
							end
							if posX > (sizeX - 5) then
								posX = sizeX - Random(5, 55)
							end
							if posZ < 5 then
								posZ = Random(5, 55)
							end
							if posZ > (sizeZ - 5) then
								posZ = sizeZ - Random(5, 55)
							end
                        local terrainAltitude = GetTerrainHeight(posX, posZ)
                        unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
          
						if unit and unit ~= nil and not unit.Dead then
							LOG("sa: Land (unit) = " .. rspawn)
						end
					end
                    if unit and unit ~= nil and not unit.Dead and (HPBonusAI > 0 or ParagonCycle ~= "Off") then
                        if GameTime < 0.33 then
							totalIncrease = HealthBonus * 0.5
							maxhp = unit:GetMaxHealth()
							unit:SetMaxHealth(maxhp + totalIncrease)
						elseif GameTime >= 0.33 and GameTime < 0.66 then
							totalIncrease = HealthBonus
							maxhp = unit:GetMaxHealth()
							unit:SetMaxHealth(maxhp + totalIncrease)
						elseif GameTime >= 0.66 and GameTime < 1 then
							totalIncrease = HealthBonus * 1.5 + Random(1400, 1800) * totalEnemyEndgamers
							maxhp = unit:GetMaxHealth()
							unit:SetMaxHealth(maxhp + totalIncrease)
						elseif GameTime >= 1 then
							totalIncrease = HealthBonus * 2 + Random(1800, 2800) * totalEnemyEndgamers
							maxhp = unit:GetMaxHealth()
							unit:SetMaxHealth(maxhp + totalIncrease)
						end
						hp = unit:GetMaxHealth()
                        unit:SetHealth(self, hp)
                        unit:SetReclaimable(false)
                    end
                    if unit and not unit.Dead then
						if DamageBoost ~= 'Off - 0' then
							ModifyWeaponDamageBuffAndRange(unit)
						end	
						unit:SetSpeedMult(1 + waveNum * SpeedBonus + SpeedBonusOnce)
						if WaveStyle == "Even Attack Waves" then	
							RedirectUnit(unit)
						elseif WaveStyle == "Dynamic Attack Waves" or WaveStyle == "Human with AI Assist" then
							RedirectUnitLand(unit)	
						end	
                    end
					if KillPlayerUnit > 0 then
						SuicideLandNavyUnit(unit)
					end
                end
            end
        end
        KillThread(self)
    end)
end
function TFl4AIR() -- Air Spawn
      local circle = ForkThread(function(self)
        local unit
        --local goforest = 0
        local rspawn = nil
        --local enemyParagonsCount = totalEnemyParagons
        --local isAirUnit = false
		--local MapCheck = false
		local Chance
		--local count = 0
		local posX
		local posZ
        if land4 == 1 then
            WaitTicks(Random(1, 6))
            if secondaryspawn ~= "Off" and spawnrateair > 0 and SecondarySpawnDead == false then
					if Alt2ndSpawn ~= "Off" and Alt2ndBuildingDead == false and Random(1, 2) == 1 then
						posX, posZ = Alt2ndBrain:GetArmyStartPos()
					else
						posX, posZ = SecBrain:GetArmyStartPos()
					end	
				if Random(1, 100) > spawnrateair then
					if AltHQSpawn ~= "Off" and HQAltBuildingDead == false and Random(1, 2) == 1 then
						posX, posZ = AltHQBrain:GetArmyStartPos()
					else
						posX, posZ = aiBrain:GetArmyStartPos()
					end	
				end	
			else
				if AltHQSpawn ~= "Off" and HQAltBuildingDead == false and Random(1, 2) == 1 then
					posX, posZ = AltHQBrain:GetArmyStartPos()
				else
					posX, posZ = aiBrain:GetArmyStartPos()
				end		
			end
			if secondaryspawn ~= "Off" and SecondarySpawnDead == true and spawnrateair > 0 then
				if spawnrateairmulti ~= 0 and (spawnrateairmulti + 2) >= Random(1, 100) then
					if AltHQSpawn ~= "Off" and HQAltBuildingDead == false and Random(1, 2) == 1 then
						posX, posZ = AltHQBrain:GetArmyStartPos()
					else
						posX, posZ = aiBrain:GetArmyStartPos()
					end	
				else
					return
				end	
			end	
            if GetGameTimeSeconds() > WavesStartTimeAI then
                if CrazyModeAir == "Normal Air" then
					rspawn = GetRandomizedIDforAir()
				elseif CrazyModeAir == "Tech 1 Air Only" then
					rspawn = (LAirUnits.Tech4)[Random(1, LAir)]
				elseif CrazyModeAir == "Tech 2 Air Only" then
					rspawn = (MAirUnits.Tech4)[Random(1, MAir)]
				elseif CrazyModeAir == "Tech 3 Air Only" then
					rspawn = (HAirUnits.Tech4)[Random(1, HAir)]
				elseif CrazyModeAir == "Experimental Air Only" then
					rspawn = (EAirUnits.Tech4)[Random(1, EAir)]
				elseif CrazyModeAir == "Minor Air Boss Only" then
					SpawnAIAirUnit()
					KillThread(self)
				elseif CrazyModeAir == "EndGame Air Boss Only" then
					CreateACombinedAirBossUnitAroundMainBuildingForAI()
					KillThread(self)
				end
                if rspawn ~= nil then
                    local oldposX = posX
                    local oldposZ = posZ
                    --repeat
						--count = count + 1
						Chance = Random(1, 8)
						if Chance == 1 then
							posX = posX + Random(1, 80)
							posZ = posZ + Random(1, 80)
						elseif Chance == 2 then
							posX = posX - Random(1, 80)
							posZ = posZ + Random(1, 80)
						elseif Chance == 3 then
							posX = posX + Random(1, 80)
							posZ = posZ - Random(1, 80)
						elseif Chance == 4 then
							posX = posX - Random(1, 80)
							posZ = posZ - Random(1, 80)
						elseif Chance == 5 then
							posZ = posZ + Random(1, 80)
							posX = posX + Random(1, 80)
						elseif Chance == 6 then
							posZ = posZ - Random(1, 80)
							posX = posX + Random(1, 80)
						elseif Chance == 7 then
							posZ = posZ + Random(1, 80)
							posX = posX - Random(1, 80)
						else
							posZ = posZ - Random(1, 80)
							posX = posX - Random(1, 80)
						end

						--[[if posX > 0 and posX < sizeX and posZ > 0 and posZ < sizeZ then
							MapCheck = true
						end
						if count == 10 then
							KillThread(self)
						end]]--
					--until MapCheck == true
                    unit = aiBrain:CreateUnitNearSpot(rspawn, posX, posZ)
                    if unit == nil then
                        local posX = oldposX
                        local posZ = oldposZ
						--MapCheck = false
                        --repeat
							--count = count + 1
							Chance = Random(1, 8)
							if Chance == 1 then
								posX = posX + Random(1, 80)
								posZ = posZ + Random(1, 80)
							elseif Chance == 2 then
								posX = posX - Random(1, 80)
								posZ = posZ + Random(1, 80)
							elseif Chance == 3 then
								posX = posX + Random(1, 80)
								posZ = posZ - Random(1, 80)
							elseif Chance == 4 then
								posX = posX - Random(1, 80)
								posZ = posZ - Random(1, 80)
							elseif Chance == 5 then
								posZ = posZ + Random(1, 80)
								posX = posX + Random(1, 80)
							elseif Chance == 6 then
								posZ = posZ - Random(1, 80)
								posX = posX + Random(1, 80)
							elseif Chance == 7 then
								posZ = posZ + Random(1, 80)
								posX = posX - Random(1, 80)
							else
								posZ = posZ - Random(1, 80)
								posX = posX - Random(1, 80)
							end

							--[[if posX > 0 and posX < sizeX and posZ > 0 and posZ < sizeZ then
								MapCheck = true
							end
							if count == 20 then
								KillThread(self)
							end	]]--
						--until MapCheck == true
                        local terrainAltitude = GetTerrainHeight(posX, posZ)
                        unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
                        if unit and unit ~= nil and not unit.Dead then
                            LOG("sa: Air (unit) = " .. rspawn)
                        end
                    end
                    if unit and unit ~= nil and not unit.Dead and (HPBonusAI > 0 or ParagonCycle ~= "Off") then
                        if GameTime < 0.33 then
						totalIncrease = HealthBonus * 0.5
                        maxhp = unit:GetMaxHealth()
                        unit:SetMaxHealth(maxhp + totalIncrease)
						elseif GameTime >= 0.33 and GameTime < 0.66 then
						totalIncrease = HealthBonus
                        maxhp = unit:GetMaxHealth()
                        unit:SetMaxHealth(maxhp + totalIncrease)
						elseif GameTime >= 0.66 and GameTime < 1 then
						totalIncrease = HealthBonus * 1.5 + Random(900, 1400) * totalEnemyEndgamers
                        maxhp = unit:GetMaxHealth()
                        unit:SetMaxHealth(maxhp + totalIncrease)
						elseif GameTime >= 1 then
						totalIncrease = HealthBonus * 2 + Random(1600, 2400) * totalEnemyEndgamers
                        maxhp = unit:GetMaxHealth()
                        unit:SetMaxHealth(maxhp + totalIncrease)
						end
                        hp = unit:GetMaxHealth()
                        unit:SetHealth(self, hp)
                        unit:SetReclaimable(false)
                    end
                    if unit and not unit.Dead then
						if DamageBoost ~= 'Off - 0' then
							ModifyWeaponDamageBuffAndRange(unit)
						end	
						unit:SetSpeedMult(1 + (waveNum * SpeedBonus + SpeedBonusOnce) * 0.3)
                        if WaveStyle == "Even Attack Waves" then	
							RedirectUnit(unit)
						elseif WaveStyle == "Dynamic Attack Waves" or WaveStyle == "Human with AI Assist" then
							RedirectUnitAir(unit)
						end
                    end
					if KillPlayerUnit > 0 then
						SuicideAirUnit(unit)
					end	
                end
            end
        end
        KillThread(self)
    end)
end
function SpawnExtraASF() -- ASF Spawn
      local circle = ForkThread(function(self)
        local unit
        --local goforest = 0
        local rspawn = nil
        --local enemyParagonsCount = totalEnemyParagons
        --local isAirUnit = false
		local Chance
		local posX
		local posZ
        if land4 == 1 then
            WaitTicks(Random(1, 6))
            if secondaryspawn ~= "Off" and spawnrateair > 0 and SecondarySpawnDead == false then
					if Alt2ndSpawn ~= "Off" and Alt2ndBuildingDead == false and Random(1, 2) == 1 then
						posX, posZ = Alt2ndBrain:GetArmyStartPos()
					else
						posX, posZ = SecBrain:GetArmyStartPos()
					end	
				if Random(1, 100) > spawnrateair then
					if AltHQSpawn ~= "Off" and HQAltBuildingDead == false and Random(1, 2) == 1 then
						posX, posZ = AltHQBrain:GetArmyStartPos()
					else
						posX, posZ = aiBrain:GetArmyStartPos()
					end	
				end	
			else
				if AltHQSpawn ~= "Off" and HQAltBuildingDead == false and Random(1, 2) == 1 then
					posX, posZ = AltHQBrain:GetArmyStartPos()
				else
					posX, posZ = aiBrain:GetArmyStartPos()
				end		
			end
			if secondaryspawn ~= "Off" and SecondarySpawnDead == true and spawnrateair > 0 then
				if spawnrateairmulti ~= 0 and (spawnrateairmulti + 2) >= Random(1, 100) then
					if AltHQSpawn ~= "Off" and HQAltBuildingDead == false and Random(1, 2) == 1 then
						posX, posZ = AltHQBrain:GetArmyStartPos()
					else
						posX, posZ = aiBrain:GetArmyStartPos()
					end	
				else
					return
				end	
			end	
            if GetGameTimeSeconds() > WavesStartTimeAI then
					ASFList = {"UEA0303", "URA0303", "UAA0303", "XSA0303"}
					rspawn = (ASFList)[Random(1, 4)]
                if rspawn ~= nil then
                    local oldposX = posX
                    local oldposZ = posZ
						Chance = Random(1, 8)
						if Chance == 1 then
							posX = posX + Random(1, 80)
							posZ = posZ + Random(1, 80)
						elseif Chance == 2 then
							posX = posX - Random(1, 80)
							posZ = posZ + Random(1, 80)
						elseif Chance == 3 then
							posX = posX + Random(1, 80)
							posZ = posZ - Random(1, 80)
						elseif Chance == 4 then
							posX = posX - Random(1, 80)
							posZ = posZ - Random(1, 80)
						elseif Chance == 5 then
							posZ = posZ + Random(1, 80)
							posX = posX + Random(1, 80)
						elseif Chance == 6 then
							posZ = posZ - Random(1, 80)
							posX = posX + Random(1, 80)
						elseif Chance == 7 then
							posZ = posZ + Random(1, 80)
							posX = posX - Random(1, 80)
						else
							posZ = posZ - Random(1, 80)
							posX = posX - Random(1, 80)
						end
                    unit = aiBrain:CreateUnitNearSpot(rspawn, posX, posZ)
                    if unit == nil then
                        local posX = oldposX
                        local posZ = oldposZ
							Chance = Random(1, 8)
							if Chance == 1 then
								posX = posX + Random(1, 80)
								posZ = posZ + Random(1, 80)
							elseif Chance == 2 then
								posX = posX - Random(1, 80)
								posZ = posZ + Random(1, 80)
							elseif Chance == 3 then
								posX = posX + Random(1, 80)
								posZ = posZ - Random(1, 80)
							elseif Chance == 4 then
								posX = posX - Random(1, 80)
								posZ = posZ - Random(1, 80)
							elseif Chance == 5 then
								posZ = posZ + Random(1, 80)
								posX = posX + Random(1, 80)
							elseif Chance == 6 then
								posZ = posZ - Random(1, 80)
								posX = posX + Random(1, 80)
							elseif Chance == 7 then
								posZ = posZ + Random(1, 80)
								posX = posX - Random(1, 80)
							else
								posZ = posZ - Random(1, 80)
								posX = posX - Random(1, 80)
							end
                        local terrainAltitude = GetTerrainHeight(posX, posZ)
                        unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
                        if unit and unit ~= nil and not unit.Dead then
                            LOG("sa: ASF Wave (unit) = " .. rspawn)
                        end
                    end
                    if unit and unit ~= nil and not unit.Dead and (HPBonusAI > 0 or ParagonCycle ~= "Off") then
                        if GameTime < 0.33 then
						totalIncrease = HealthBonus * 0.5
                        maxhp = unit:GetMaxHealth()
                        unit:SetMaxHealth(maxhp + totalIncrease)
						elseif GameTime >= 0.33 and GameTime < 0.66 then
						totalIncrease = HealthBonus
                        maxhp = unit:GetMaxHealth()
                        unit:SetMaxHealth(maxhp + totalIncrease)
						elseif GameTime >= 0.66 and GameTime < 1 then
						totalIncrease = HealthBonus * 1.5 + Random(900, 1400) * totalEnemyEndgamers
                        maxhp = unit:GetMaxHealth()
                        unit:SetMaxHealth(maxhp + totalIncrease)
						elseif GameTime >= 1 then
						totalIncrease = HealthBonus * 2 + Random(1600, 2400) * totalEnemyEndgamers
                        maxhp = unit:GetMaxHealth()
                        unit:SetMaxHealth(maxhp + totalIncrease)
						end
                        hp = unit:GetMaxHealth()
                        unit:SetHealth(self, hp)
                        unit:SetReclaimable(false)
                    end
                    if unit and not unit.Dead then
						if DamageBoost ~= 'Off - 0' then
							ModifyWeaponDamageBuffAndRange(unit)
						end	
						unit:SetSpeedMult(1 + (waveNum * SpeedBonus + SpeedBonusOnce) * 0.3)
                        if WaveStyle == "Even Attack Waves" then	
							RedirectUnit(unit)
						elseif WaveStyle == "Dynamic Attack Waves" or WaveStyle == "Human with AI Assist" then
							RedirectUnitAir(unit)
						end
                    end
					if KillPlayerUnit > 0 then
						SuicideAirUnit(unit)
					end	
                end
            end
        end
        KillThread(self)
    end)
end
function ANTIAIRResponseWave() -- AntiAir Spawn
      local circle = ForkThread(function(self)
        local unit
        --local goforest = 0
        local rspawn = nil
        --local enemyParagonsCount = totalEnemyParagons
        --local isAirUnit = false
		local posX
		local posZ
        if land4 == 1 then
            WaitTicks(Random(1, 6))
            if secondaryspawn ~= "Off" and spawnrateair > 0 and SecondarySpawnDead == false then
					if Alt2ndSpawn ~= "Off" and Alt2ndBuildingDead == false and Random(1, 2) == 1 then
						posX, posZ = Alt2ndBrain:GetArmyStartPos()
					else
						posX, posZ = SecBrain:GetArmyStartPos()
					end	
				if Random(1, 100) > spawnrateair then
					if AltHQSpawn ~= "Off" and HQAltBuildingDead == false and Random(1, 2) == 1 then
						posX, posZ = AltHQBrain:GetArmyStartPos()
					else
						posX, posZ = aiBrain:GetArmyStartPos()
					end	
				end	
			else
				if AltHQSpawn ~= "Off" and HQAltBuildingDead == false and Random(1, 2) == 1 then
					posX, posZ = AltHQBrain:GetArmyStartPos()
				else
					posX, posZ = aiBrain:GetArmyStartPos()
				end		
			end
			if secondaryspawn ~= "Off" and SecondarySpawnDead == true and spawnrateair > 0 then
				if spawnrateairmulti ~= 0 and (spawnrateairmulti + 2) >= Random(1, 100) then
					if AltHQSpawn ~= "Off" and HQAltBuildingDead == false and Random(1, 2) == 1 then
						posX, posZ = AltHQBrain:GetArmyStartPos()
					else
						posX, posZ = aiBrain:GetArmyStartPos()
					end	
				else
					return
				end	
			end	
            if GetGameTimeSeconds() > WavesStartTimeAI then
					rspawn = "AAR0310"
                if rspawn ~= nil then
                    local oldposX = posX
                    local oldposZ = posZ
                    if Random(1, 2) == 2 then
                        posX = posX + Random(20, 35)
                        posZ = posZ + Random(20, 35)
                    else
                        posX = posX - Random(20, 35)
                        posZ = posZ + Random(20, 35)
                    end
                    if Random(1, 2) == 2 then
                        posX = posX + Random(20, 35)
                        posZ = posZ - Random(20, 35)
                    else
                        posX = posX - Random(20, 35)
                        posZ = posZ - Random(20, 35)
                    end
                    if Random(1, 2) == 2 then
                        posZ = posZ + Random(20, 35)
                        posX = posX + Random(20, 35)
                    else
                        posZ = posZ - Random(20, 35)
                        posX = posX + Random(20, 35)
                    end
                    if Random(1, 2) == 2 then
                        posZ = posZ + Random(20, 35)
                        posX = posX - Random(20, 35)
                    else
                        posZ = posZ - Random(20, 35)
                        posX = posX - Random(20, 35)
                    end
                    unit = aiBrain:CreateUnitNearSpot(rspawn, posX, posZ)
                    if unit == nil then
                        local posX = oldposX
                        local posZ = oldposZ
                        if Random(1, 2) == 2 then
                            posX = posX + Random(20, 35)
                            posZ = posZ + Random(20, 35)
                        else
                            posX = posX - Random(20, 35)
                            posZ = posZ + Random(20, 35)
                        end
                        if Random(1, 2) == 2 then
                            posX = posX + Random(20, 35)
                            posZ = posZ - Random(20, 35)
                        else
                            posX = posX - Random(20, 35)
                            posZ = posZ - Random(20, 35)
                        end
                        if Random(1, 2) == 2 then
                            posZ = posZ + Random(20, 35)
                            posX = posX + Random(20, 35)
                        else
                            posZ = posZ - Random(20, 35)
                            posX = posX + Random(20, 35)
                        end
                        if Random(1, 2) == 2 then
                            posZ = posZ + Random(20, 35)
                            posX = posX - Random(20, 35)
                        else
                            posZ = posZ - Random(20, 35)
                            posX = posX - Random(20, 35)
                        end
                        local terrainAltitude = GetTerrainHeight(posX, posZ)
                        unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
                        if unit and unit ~= nil and not unit.Dead then
                            LOG("sa: AntiAir (unit) = " .. rspawn)
                        end
                    end
                    if unit and unit ~= nil and not unit.Dead and (HPBonusAI > 0 or ParagonCycle ~= "Off") then
                        if GameTime < 0.33 then
						totalIncrease = HealthBonus * 0.5
                        maxhp = unit:GetMaxHealth()
                        unit:SetMaxHealth(maxhp + totalIncrease)
						elseif GameTime >= 0.33 and GameTime < 0.66 then
						totalIncrease = HealthBonus
                        maxhp = unit:GetMaxHealth()
                        unit:SetMaxHealth(maxhp + totalIncrease)
						elseif GameTime >= 0.66 and GameTime < 1 then
						totalIncrease = HealthBonus * 1.5 + Random(900, 1400) * totalEnemyEndgamers
                        maxhp = unit:GetMaxHealth()
                        unit:SetMaxHealth(maxhp + totalIncrease)
						elseif GameTime >= 1 then
						totalIncrease = HealthBonus * 2 + Random(1600, 2400) * totalEnemyEndgamers
                        maxhp = unit:GetMaxHealth()
                        unit:SetMaxHealth(maxhp + totalIncrease)
						end
                        hp = unit:GetMaxHealth()
                        unit:SetHealth(self, hp)
                        unit:SetReclaimable(false)
                    end
                    if unit and not unit.Dead then
						if DamageBoost ~= 'Off - 0' then
							ModifyWeaponDamageBuffAndRange(unit)
						end	
						unit:SetSpeedMult(1 + (waveNum * SpeedBonus + SpeedBonusOnce) * 0.3)
                        if WaveStyle == "Even Attack Waves" then	
							RedirectUnitAntiAir(unit)
						elseif WaveStyle == "Dynamic Attack Waves" or WaveStyle == "Human with AI Assist" then
							RedirectUnitAntiAir(unit)
						end
                    end
					if KillPlayerUnit > 0 then
						SuicideAirUnit(unit)
					end	
                end
            end
        end
        KillThread(self)
    end)
end
function SpawnAIAirUnit() --Minor Air Boss Spawn
    local circle = ForkThread(function(self)
        local unit
        --local goforest = 0
        local rspawn = nil
        local enemyParagonsCount = totalEnemyParagons
        --local isAirUnit = false
        if land4 == 1 then
            WaitTicks(Random(1, 5))
            if secondaryspawn ~= "Off" and spawnrateair > 0 and SecondarySpawnDead == false then
					if Alt2ndSpawn ~= "Off" and Alt2ndBuildingDead == false and Random(1, 2) == 1 then
						posX, posZ = Alt2ndBrain:GetArmyStartPos()
					else
						posX, posZ = SecBrain:GetArmyStartPos()
					end	
				if Random(1, 100) > spawnrateair then
					if AltHQSpawn ~= "Off" and HQAltBuildingDead == false and Random(1, 2) == 1 then
						posX, posZ = AltHQBrain:GetArmyStartPos()
					else
						posX, posZ = aiBrain:GetArmyStartPos()
					end	
				end	
			else
				if AltHQSpawn ~= "Off" and HQAltBuildingDead == false and Random(1, 2) == 1 then
					posX, posZ = AltHQBrain:GetArmyStartPos()
				else
					posX, posZ = aiBrain:GetArmyStartPos()
				end		
			end
            if GetGameTimeSeconds() > WavesStartTimeAI then
                if countair > 0 then
                    rspawn = (airUnitsA.Tech4)[Random(1, countair)]
                    --[[isAirUnit = true
                    if Random(0, 1) == 0 then
                        rspawn = "ura0401" 
                    end]]--
                end
                if rspawn ~= nil then
                    local oldposX = posX
                    local oldposZ = posZ
                    if Random(1, 2) == 2 then
                        posX = posX + Random(20, 35)
                        posZ = posZ + Random(20, 35)
                    else
                        posX = posX - Random(20, 35)
                        posZ = posZ + Random(20, 35)
                    end
                    if Random(1, 2) == 2 then
                        posX = posX + Random(20, 35)
                        posZ = posZ - Random(20, 35)
                    else
                        posX = posX - Random(20, 35)
                        posZ = posZ - Random(20, 35)
                    end
                    if Random(1, 2) == 2 then
                        posZ = posZ + Random(20, 35)
                        posX = posX + Random(20, 35)
                    else
                        posZ = posZ - Random(20, 35)
                        posX = posX + Random(20, 35)
                    end
                    if Random(1, 2) == 2 then
                        posZ = posZ + Random(20, 35)
                        posX = posX - Random(20, 35)
                    else
                        posZ = posZ - Random(20, 35)
                        posX = posX - Random(20, 35)
                    end
                    unit = aiBrain:CreateUnitNearSpot(rspawn, posX, posZ)
                    if unit == nil then
                        local posX = oldposX
                        local posZ = oldposZ
                        if Random(1, 2) == 2 then
                            posX = posX + Random(20, 35)
                            posZ = posZ + Random(20, 35)
                        else
                            posX = posX - Random(20, 35)
                            posZ = posZ + Random(20, 35)
                        end
                        if Random(1, 2) == 2 then
                            posX = posX + Random(20, 35)
                            posZ = posZ - Random(20, 35)
                        else
                            posX = posX - Random(20, 35)
                            posZ = posZ - Random(20, 35)
                        end
                        if Random(1, 2) == 2 then
                            posZ = posZ + Random(20, 35)
                            posX = posX + Random(20, 35)
                        else
                            posZ = posZ - Random(20, 35)
                            posX = posX + Random(20, 35)
                        end
                        if Random(1, 2) == 2 then
                            posZ = posZ + Random(20, 35)
                            posX = posX - Random(20, 35)
                        else
                            posZ = posZ - Random(20, 35)
                            posX = posX - Random(20, 35)
                        end
                        local terrainAltitude = GetTerrainHeight(posX, posZ)
                        unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
                        if unit and unit ~= nil and not unit.Dead then
                            LOG("sa: MinorAirBoss (unit) = " .. rspawn)
                        end
                    end
                    if unit and unit ~= nil and not unit.Dead then
						totalIncrease = 6 * (GetGameTimeSeconds() - WavesStartTimeAI) + Random(100, 200) * totalEnemyT3AirDefences + Random(250, 350) * totalEnemyExpAirDefences + Random(10000, 15000) * totalEnemyEndgamers + HealthBonus
						maxhp = unit:GetMaxHealth()
						unit:SetMaxHealth(maxhp + totalIncrease)
                        hp = unit:GetMaxHealth()
                        unit:SetHealth(self, hp)
                        unit:SetReclaimable(false)
                    end
                    if unit and not unit.Dead then
                        unit:SetSpeedMult(1 + (waveNum * SpeedBonus + SpeedBonusOnce) * 0.3)
						unit:SetCustomName("Boss")
						if WaveStyle == "Even Attack Waves" then	
							RedirectUnitMinorBoss(unit)
						elseif WaveStyle == "Dynamic Attack Waves" or WaveStyle == "Human with AI Assist" then
							RedirectUnitMinorBoss(unit)
						end
                    end
					if KillPlayerUnit > 0 then
						SuicideBoss(unit)
					end	
                end
            end
        end
        KillThread(self)
    end)
end
function tablelength(T)
    local count = 0
    for _ in pairs(T) do
        count = count + 1
    end
    return count
end
function RedirectUnitAir(aaUnitAir)
    local circle = ForkThread(function(self)
		local aUnit = aaUnitAir
        if aUnit and not aUnit:BeenDestroyed() and EntityCategoryContains(categories.ANTINAVY, aUnit) == true then
			local pUnit = nil
				pUnit = RandomEnemyUnitsSubsList(self)
            if pUnit and not pUnit:BeenDestroyed() then
                IssueClearCommands({ aUnit })
                local VECTOR3
                local pUnitPos = pUnit:GetPosition()
				if Random(1, 7) <= 4 then
					IssueMove({ aUnit }, pUnitPos)
					WaitSeconds(Random(3, 4))
					IssueClearCommands({ aUnit })
					IssueAggressiveMove({ aUnit }, pUnitPos)
					repeat
						WaitSeconds(12)
						if aUnit:BeenDestroyed() or pUnit:BeenDestroyed() then
							break
						end
						if Random(1, 12) == 6 then
							break
						end
					until pUnit:BeenDestroyed() or pUnit == nil
					WaitTicks(20)
					if aUnit ~= nil and not aUnit:BeenDestroyed() then 
						IssueClearCommands({ aUnit })
					end		
				else
					IssueAggressiveMove({ aUnit }, pUnitPos)
					repeat
						WaitSeconds(12)
						if aUnit:BeenDestroyed() or pUnit:BeenDestroyed() then
							break
						end
						if Random(1, 12) == 6 then
							break
						end
					until pUnit:BeenDestroyed() or pUnit == nil
					WaitTicks(20)
					if aUnit ~= nil and not aUnit:BeenDestroyed() then 
						IssueClearCommands({ aUnit })
					end	
				end
            end
		elseif aUnit and not aUnit:BeenDestroyed() and ((EntityCategoryContains(categories.TECH3, aUnit) == true or EntityCategoryContains(categories.TECH2, aUnit) == true or EntityCategoryContains(categories.TECH1, aUnit) == true) 
		and EntityCategoryContains(categories.ANTIAIR, aUnit) == true and EntityCategoryContains(categories.BOMBER, aUnit) == false and EntityCategoryContains(categories.GROUNDATTACK, aUnit) == false) then
			local pUnit = nil
			pUnit = RandomEnemyUnitsAirList(self)
			--[[if Random(1, 3) == 1 then
				pUnit = GetClosestEnemyUnitAir(self, aUnit)
			else
				pUnit = GetRandomEnemyAirUnit(self)
			end	]]--
            if pUnit and not pUnit:BeenDestroyed() then
                IssueClearCommands({ aUnit })
                local VECTOR3
                local pUnitPos = pUnit:GetPosition()
				IssueMove({ aUnit }, pUnitPos)
				WaitSeconds(Random(2, 3))
				IssueClearCommands({ aUnit })
				IssueAggressiveMove({ aUnit }, pUnitPos)
				repeat
					WaitSeconds(12)
					if aUnit:BeenDestroyed() or pUnit:BeenDestroyed() then
						break
					end
					if Random(1, 12) == 6 then
						break
					end
				until pUnit:BeenDestroyed() or pUnit == nil
				WaitTicks(20)
				if aUnit ~= nil and not aUnit:BeenDestroyed() then 
					IssueClearCommands({ aUnit })
				end	
            end
		elseif aUnit and not aUnit:BeenDestroyed() then
            local pUnit = nil
            if Random(1, 3) <= 2 then
				if Random(1, 2) == 1 then
					pUnit = RandomEnemyUnitsBombersList(self)
				else	
					pUnit = RandomEnemyUnitsLandEconomyList(self)
				end
			else	
				if Random(1, 3) == 1 then
					pUnit = GetClosestEnemyNearUnitAir(self, aUnit)
				else
					pUnit = GetRandomEnemy4BomberUnit(self)
				end	
			end	
            if pUnit then
                local VECTOR3
                local pUnitPos = pUnit:GetPosition()
				if Random(1, 10) <= 7 then
					IssueMove({ aUnit }, pUnitPos)
					WaitSeconds(Random(8, 14))
					IssueClearCommands({ aUnit })
					IssueAggressiveMove({ aUnit }, pUnitPos)
					repeat
						WaitSeconds(12)
						if aUnit:BeenDestroyed() or pUnit:BeenDestroyed() then
							break
						end
						if Random(1, 12) == 6 then
							break
						end
					until pUnit:BeenDestroyed() or pUnit == nil
					WaitTicks(20)
					if aUnit ~= nil and not aUnit:BeenDestroyed() then 
						IssueClearCommands({ aUnit })
					end	
				else
					IssueMove({ aUnit }, pUnitPos)
					WaitSeconds(Random(14, 20))
					IssueClearCommands({ aUnit })
					IssueAggressiveMove({ aUnit }, pUnitPos)
					repeat
						WaitSeconds(12)
						if aUnit:BeenDestroyed() or pUnit:BeenDestroyed() then
							break
						end
						if Random(1, 12) == 6 then
							break
						end
					until pUnit:BeenDestroyed() or pUnit == nil
					WaitTicks(20)
					if aUnit ~= nil and not aUnit:BeenDestroyed() then 
						IssueClearCommands({ aUnit })
					end	
				end
            end
        end
        KillThread(self)
    end)
end
function RedirectUnitAntiAir(aaUnit)
    local circle = ForkThread(function(self)
		aUnit = aaUnit
		if aUnit and not aUnit:BeenDestroyed() then
			local pUnit = nil
			pUnit = GetAllEnemyUnitsAir4Nomander(self)
            if pUnit and not pUnit:BeenDestroyed() then
                IssueClearCommands({ aUnit })
                local VECTOR3
                local pUnitPos = pUnit:GetPosition()
				IssueAggressiveMove({ aUnit }, pUnitPos)
				--IssueMove({ aUnit }, pUnitPos)
				--WaitSeconds(Random(2, 3))
				--IssueClearCommands({ aUnit })
				--IssueAggressiveMove({ aUnit }, pUnitPos)
            end
        end
        KillThread(self)
    end)
end
function RedirectUnitNavy(aaUnitNavy)
    local circle = ForkThread(function(self)
		local aUnit = aaUnitNavy
		if aUnit and not aUnit:BeenDestroyed() and EntityCategoryContains(categories.SUBMERSIBLE, aUnit) == true then
			--PrintText("Sub Attack", 30, 'ffCBFFFF', 4, 'center')
			local pUnit = nil	
				pUnit = RandomEnemyUnitsSubsList(self)
				--PrintText("Sub Target Found", 30, 'ffCBFFFF', 4, 'center')
            if pUnit and not pUnit:BeenDestroyed() then
                IssueClearCommands({ aUnit })
                local VECTOR3
                local pUnitPos = pUnit:GetPosition()
				IssueMove({ aUnit }, pUnitPos)
				WaitSeconds(Random(90, 120))
				IssueClearCommands({ aUnit })
				IssueAggressiveMove({ aUnit }, pUnitPos)
				WaitSeconds(Random(48, 78))
				if EntityCategoryContains(categories.EXPERIMENTAL, aUnit) == true then
					WaitSeconds(60)
				end	
				repeat
					WaitSeconds(12)
					if aUnit:BeenDestroyed() or pUnit:BeenDestroyed() then
						break
					end
					if Random(1, 12) == 6 then
						break
					end
				until pUnit:BeenDestroyed() or pUnit == nil
				WaitTicks(20)
				if aUnit ~= nil and not aUnit:BeenDestroyed() then 
					IssueClearCommands({ aUnit })
				end	
            end
        elseif aUnit and not aUnit:BeenDestroyed() then
			--PrintText("Navy Attack", 30, 'ffCBFFFF', 4, 'center')
            local pUnit = nil
            --pUnit = GetClosestEnemyUnit(self, aUnit)
			if Random(1, 3) <= 2 then	
				pUnit = RandomEnemyUnitsNavalList(self)
			else	
				if Random(1, 3) == 2 then
					pUnit = GetClosestEnemyNearNavy(self, aUnit)
				else
					pUnit = GetRandomEnemyNavalUnit(self)
				end	
			end	
            if pUnit then
                local VECTOR3
                local pUnitPos = pUnit:GetPosition()
				if Random(1, 7) <= 4 then
					IssueMove({ aUnit }, pUnitPos)
				else
					IssueMove({ aUnit }, pUnitPos)
					WaitSeconds(Random(90, 120))
					IssueClearCommands({ aUnit })
					IssueAggressiveMove({ aUnit }, pUnitPos)
					WaitSeconds(Random(48, 78))
					if EntityCategoryContains(categories.TECH3, aUnit) == true or EntityCategoryContains(categories.EXPERIMENTAL, aUnit) == true then
						WaitSeconds(60)
					end	
					repeat
						WaitSeconds(12)
						if aUnit:BeenDestroyed() or pUnit:BeenDestroyed() then
							break
						end
						if Random(1, 12) == 6 then
							break
						end
					until pUnit:BeenDestroyed() or pUnit == nil
					WaitTicks(20)
					if aUnit ~= nil and not aUnit:BeenDestroyed() then 
						IssueClearCommands({ aUnit })
					end	
				end
            end
        end
        KillThread(self)
    end)
end
function RedirectUnitLand(aaUnitLand)
    local circle = ForkThread(function(self)
		local aUnit = aaUnitLand
		if aUnit and not aUnit:BeenDestroyed() and ((EntityCategoryContains(categories.ANTINAVY, aUnit) == true and EntityCategoryContains(categories.EXPERIMENTAL, aUnit) == false) or (EntityCategoryContains(categories.ANTINAVY, aUnit) == true and EntityCategoryContains(categories.EXPERIMENTAL, aUnit) == true and Random(1, 8) == 4)) then
			local pUnit = nil
				if Random(1, 3) <= 2 then
					if Random(1, 2) == 1 then
						pUnit = RandomEnemyUnitsLandDefenseList(self)
					else	
						pUnit = RandomEnemyUnitsLandEconomyList(self)
					end
				else
					if Random(1, 3) == 1 then
						pUnit = GetClosestEnemyNearAntiNavy(self, aUnit)
					else	
						pUnit = RandomEnemySubsForAntiNavyList(self)
					end		
				end	
                if pUnit and not pUnit:BeenDestroyed() then
                    IssueClearCommands({ aUnit })
                    local VECTOR3
                    local pUnitPos = pUnit:GetPosition()
					if Random(1, 8) <= 6 then
						IssueMove({ aUnit }, pUnitPos)
					else
						IssueMove({ aUnit }, pUnitPos)
						WaitSeconds(Random(20, 60))
						IssueClearCommands({ aUnit })
						IssueAggressiveMove({ aUnit }, pUnitPos)
						WaitSeconds(Random(48, 78))
						repeat
							WaitSeconds(12)
							if aUnit:BeenDestroyed() or pUnit:BeenDestroyed() then
								break
							end
							if Random(1, 12) == 6 then
								break
							end
						until pUnit:BeenDestroyed() or pUnit == nil
						WaitTicks(20)
						if aUnit ~= nil and not aUnit:BeenDestroyed() then 
							IssueClearCommands({ aUnit })
						end	
					end
                end
		elseif aUnit and not aUnit:BeenDestroyed() and ((EntityCategoryContains(categories.INDIRECTFIRE, aUnit) == true and EntityCategoryContains(categories.EXPERIMENTAL, aUnit) == false) or (EntityCategoryContains(categories.INDIRECTFIRE, aUnit) == true and EntityCategoryContains(categories.EXPERIMENTAL, aUnit) == true and Random(1, 4) == 2)) then
			local pUnit = nil
			if Random(1, 3) <= 2 then
				if Random(1, 2) == 1 then
					pUnit = RandomEnemyUnitsLandDefenseList(self)
				else	
					pUnit = RandomEnemyUnitsLandEconomyList(self)
				end
			else
				if Random(1, 4) == 1 then
					pUnit = GetClosestEnemyNearUnitLand(self, aUnit)
				else
					pUnit = GetRandomEnemyLandUnit(self)
				end	
			end		
            if pUnit and not pUnit:BeenDestroyed() then
                IssueClearCommands({ aUnit })
                local VECTOR3
                local pUnitPos = pUnit:GetPosition()
				IssueMove({ aUnit }, pUnitPos)
				WaitSeconds(Random(45, 90))
				IssueClearCommands({ aUnit })
				IssueAggressiveMove({ aUnit }, pUnitPos)
				WaitSeconds(Random(48, 78))
				repeat
					WaitSeconds(12)
					if aUnit:BeenDestroyed() or pUnit:BeenDestroyed() then
						break
					end
					if Random(1, 12) == 6 then
						break
					end
				until pUnit:BeenDestroyed() or pUnit == nil
				WaitTicks(20)
				if aUnit ~= nil and not aUnit:BeenDestroyed() then 
					IssueClearCommands({ aUnit })
				end	
            end
        elseif aUnit and not aUnit:BeenDestroyed() then
            local pUnit = nil
            if Random(1, 3) <= 2 then
				if Random(1, 2) == 1 then
					pUnit = RandomEnemyUnitsLandDefenseList(self)
				else	
					pUnit = RandomEnemyUnitsLandEconomyList(self)
				end
			else
				if Random(1, 4) == 1 then
					pUnit = GetClosestEnemyNearUnitLand(self, aUnit)
				else
					pUnit = GetRandomEnemyLandUnit(self)
				end	
			end	
            if pUnit then
                local VECTOR3
                local pUnitPos = pUnit:GetPosition()
				if Random(1, 10) <= 8 then
					IssueMove({ aUnit }, pUnitPos)
				else
					IssueMove({ aUnit }, pUnitPos)
					WaitSeconds(Random(10, 20))
					IssueClearCommands({ aUnit })
					IssueAggressiveMove({ aUnit }, pUnitPos)
					WaitSeconds(Random(48, 78))
					repeat
						WaitSeconds(12)
						if aUnit:BeenDestroyed() or pUnit:BeenDestroyed() then
							break
						end
						if Random(1, 12) == 6 then
							break
						end
					until pUnit:BeenDestroyed() or pUnit == nil
					WaitTicks(20)
					if aUnit ~= nil and not aUnit:BeenDestroyed() then 
						IssueClearCommands({ aUnit })
					end	
				end	
            end
        end
        KillThread(self)
    end)
end
function RedirectUnitEndgameBoss(aaUnit)
    local circle = ForkThread(function(self)
		local aUnit = aaUnit
		if aUnit ~= nil then --EntityCategoryContains(categories.LAND, aUnit) == true
			local pUnit = nil
			if Random(1, 2) == 1 then
				pUnit = GetRandomEnemy4EndGameBossUnit(self)
			else
				pUnit = GetAllEnemyUnitsForDooms(self)
			end	
            if pUnit ~= nil then
				IssueClearCommands({ aUnit })
				local VECTOR3
				local pUnitPos = pUnit:GetPosition()
				IssueMove({ aUnit }, pUnitPos)
            end
       WaitSeconds(10)
			repeat	
				if aUnit:BeenDestroyed() then
					break
				elseif pUnit ~= nil and not pUnit:BeenDestroyed() then
					local pUnitPos = pUnit:GetPosition()
					IssueClearCommands({ aUnit })
					IssueMove({ aUnit }, pUnitPos)
					--PrintText("Doom RepeatMove", 30, 'ffCBFFFF', 4, 'center')
				end
				WaitSeconds(10)
			until pUnit:BeenDestroyed() or pUnit == nil
			if aUnit and not aUnit:BeenDestroyed() then
				--PrintText("New Target", 30, 'ffCBFFFF', 4, 'center')
				RedirectUnitEndgameBoss(aUnit)
			end	
        end
        KillThread(self)
    end)
end
function GetTargetforArtillery(aaUnit)
    local circle = ForkThread(function(self)
	local rescanTargets
	local aUnit = aaUnit
		if aUnit ~= nil then
			local pUnit = nil
			pUnit = GetAllEnemyUnitsForArtillery(self)
            if pUnit ~= nil then
				IssueClearCommands({ aUnit })
				local VECTOR3
				local pUnitPos = pUnit:GetPosition()
				IssueAttack({ aUnit }, pUnitPos)
				--PrintText("Artillery: Attacking", 30, 'ffCBFFFF', 4, 'center')
            end
			rescanTargets = GetGameTimeSeconds() + Random(120, 180)
       WaitSeconds(10)
			repeat	
				if aUnit:BeenDestroyed() then
					break
				elseif pUnit ~= nil and not pUnit:BeenDestroyed() then
					local pUnitPos = pUnit:GetPosition()
					IssueClearCommands({ aUnit })
					IssueAttack({ aUnit }, pUnitPos)
					--PrintText("Artillery: Repeat Attack", 30, 'ffCBFFFF', 4, 'center')
				end
				WaitSeconds(10)
				--[[if aUnit and not aUnit:IsUnitState('Busy') and not aUnit:IsUnitState('Attacking') then
					pUnit = GetAllEnemyUnitsLandEconomy(self)
					PrintText("Artillery: Bad Target, Searching", 30, 'ffCBFFFF', 4, 'center')
				end]]--
				if rescanTargets < GetGameTimeSeconds() then
					--PrintText("Artillery: Scanning", 30, 'ffCBFFFF', 4, 'center')
					break
				end	
			until pUnit:BeenDestroyed() or pUnit == nil
			if aUnit and not aUnit:BeenDestroyed() then
				--PrintText("Artillery: Target Destroyed", 30, 'ffCBFFFF', 4, 'center')
				GetTargetforArtillery(aUnit)
			end	
        end
        KillThread(self)
    end)
end
function RedirectDoomCrawler(aaUnit)
    local circle = ForkThread(function(self)
		local count
		local aUnit = aaUnit
		if aUnit ~= nil then
		--PrintText("Doom Attack Script", 30, 'ffCBFFFF', 4, 'center')
			local pUnit = nil
			pUnit = GetAllEnemyUnitsForDooms(self)
			--PrintText("P Unit Found", 28, 'ffCBFFFF', 2, 'center')
            if pUnit ~= nil then
				IssueClearCommands({ aUnit })
				local VECTOR3
				local pUnitPos = pUnit:GetPosition()
				IssueMove({ aUnit }, pUnitPos)
				--PrintText("Doom Move Command", 30, 'ffCBFFFF', 4, 'center')
            end
			WaitSeconds(2)
			repeat	
				if aUnit:BeenDestroyed() then
					break
				elseif pUnit ~= nil and not pUnit:BeenDestroyed() then
					local pUnitPos = pUnit:GetPosition()
					IssueClearCommands({ aUnit })
					IssueMove({ aUnit }, pUnitPos)
					--PrintText("Doom RepeatMove", 30, 'ffCBFFFF', 4, 'center')
					count = Random(35, 45)
					repeat
						WaitSeconds(1)
						if pUnit:BeenDestroyed() then
							break
						end	
						count = count - 1
					until count < 1
				end	
				if aUnit:BeenDestroyed() then
					break
				elseif pUnit ~= nil and not pUnit:BeenDestroyed() then
					local pUnitPos = pUnit:GetPosition()
					IssueClearCommands({ aUnit })
					IssueAggressiveMove({ aUnit }, pUnitPos)
					--PrintText("Doom AggressiveMove", 30, 'ffCBFFFF', 4, 'center')
					count = Random(5, 10)
					repeat
						WaitSeconds(1)
						if pUnit:BeenDestroyed() then
							break
						end	
						count = count - 1
					until count < 1
				end
			until pUnit:BeenDestroyed() or pUnit == nil
			if aUnit and not aUnit:BeenDestroyed() then
				--PrintText("New Target", 30, 'ffCBFFFF', 4, 'center')
				RedirectDoomCrawler(aUnit)
			end	
        end
        KillThread(self)
    end)
end
function RedirectDoomWalker(aaUnit)
    local circle = ForkThread(function(self)
		local aUnit = aaUnit
		local count
		if aUnit ~= nil then
		--PrintText("Doom Attack Script", 30, 'ffCBFFFF', 4, 'center')
			local pUnit = nil
			pUnit = GetAllEnemyUnitsForDooms(self)
			--PrintText("P Unit Found", 28, 'ffCBFFFF', 2, 'center')
            if pUnit ~= nil then
				IssueClearCommands({ aUnit })
				local VECTOR3
				local pUnitPos = pUnit:GetPosition()
				IssueMove({ aUnit }, pUnitPos)
				--PrintText("Doom Move Command", 30, 'ffCBFFFF', 4, 'center')
            end
			WaitSeconds(2)
			repeat	
				if aUnit:BeenDestroyed() then
					break
				elseif pUnit ~= nil and not pUnit:BeenDestroyed() then
					local pUnitPos = pUnit:GetPosition()
					IssueClearCommands({ aUnit })
					IssueMove({ aUnit }, pUnitPos)
					--PrintText("Doom RepeatMove", 30, 'ffCBFFFF', 4, 'center')
					count = 10
					repeat
						WaitSeconds(1)
						if pUnit:BeenDestroyed() then
							break
						end	
						count = count - 1
					until count < 1
				end	
			until pUnit:BeenDestroyed() or pUnit == nil
			if aUnit and not aUnit:BeenDestroyed() then
				--PrintText("New Target", 30, 'ffCBFFFF', 4, 'center')
				RedirectDoomWalker(aUnit)
			end	
        end
        KillThread(self)
    end)
end
function RedirectYoloBoss(aaUnit)
    local circle = ForkThread(function(self)
		local aUnit = aaUnit
		if aUnit ~= nil then
		--PrintText("Doom Attack Script", 30, 'ffCBFFFF', 4, 'center')
			local pUnit = nil
			pUnit = GetAllEnemyUnitsForYoloBoss(self)
			--PrintText("P Unit Found", 28, 'ffCBFFFF', 2, 'center')
            if pUnit ~= nil then
				IssueClearCommands({ aUnit })
				local VECTOR3
				local pUnitPos = pUnit:GetPosition()
				IssueMove({ aUnit }, pUnitPos)
				--PrintText("Doom Move Command", 30, 'ffCBFFFF', 4, 'center')
            end
			WaitSeconds(10)
			repeat	
				if aUnit:BeenDestroyed() then
					break
				elseif pUnit ~= nil and not pUnit:BeenDestroyed() then
					local pUnitPos = pUnit:GetPosition()
					IssueClearCommands({ aUnit })
					IssueMove({ aUnit }, pUnitPos)
					--PrintText("Doom RepeatMove", 30, 'ffCBFFFF', 4, 'center')
					WaitSeconds(Random(10, 20))
				end	
			until pUnit:BeenDestroyed() or pUnit == nil
			if aUnit and not aUnit:BeenDestroyed() then
				--PrintText("New Target", 30, 'ffCBFFFF', 4, 'center')
				RedirectYoloBoss(aUnit)
			end	
        end
        KillThread(self)
    end)
end
function RedirectTransports(aaUnit, platoon)
    local circle = ForkThread(function(self)
		local aUnit = aaUnit
		if aUnit and not aUnit:BeenDestroyed() then
			local pUnit = nil
			if Random(1, 3) <= 2 then
				if Random(1, 5) == 1 then
					pUnit = GetAllEnemyUnitsLandDefense(self)
				else	
					pUnit = GetAllEnemyUnitsLandEconomy(self)
				end
			else
				if TransportUnits == "Amphibious/Hover (Mixed Race)" then
					pUnit = GetAllEnemySubsForAntiNavy(self)
				else	
					pUnit = GetRandomEnemy4LandBossUnit(self)
				end	
			end	
            if pUnit and not pUnit:BeenDestroyed() then
				--PrintText("Target Found", 30, 'ffCBFFFF', 4, 'center')
				EmergencyDrop(aUnit)
				IssueClearCommands({ aUnit })
				local VECTOR3
				local pUnitPos = pUnit:GetPosition()
				IssueMove({ aUnit }, pUnitPos)
				IssueTransportUnload({ aUnit }, pUnitPos)
				PlatoonAttack(pUnit, platoon)
				--PlatoonAttackClosestUnit(platoon)
				WaitSeconds(3)
				IssueTransportUnload({ aUnit }, pUnitPos)
				while not aUnit:BeenDestroyed() and (aUnit:IsUnitState('Moving') or aUnit:IsUnitState('TransportUnloading')) do
					WaitSeconds(1)
				end
				--PrintText("Not Moving", 30, 'ffCBFFFF', 4, 'center')
				if pUnit and not pUnit:BeenDestroyed() then
					PlatoonAttack(pUnit, platoon)
				end	
				if aUnit and not aUnit:BeenDestroyed() then
					local VECTOR3
					pUnitPos = AIMainBuilding:GetPosition()
					IssueClearCommands({ aUnit })
					IssueMove({ aUnit }, pUnitPos)
					WaitSeconds(2)
					while not aUnit:BeenDestroyed() and aUnit:IsUnitState('Moving') do
						WaitSeconds(1)
					end
					if aUnit and not aUnit:BeenDestroyed() then
						IssueDestroySelf(({ aUnit }))
					end	
				end	
            else
				RedirectTransports(aUnit, platoon)
			end	
		end	
		--PrintText("Transport6", 30, 'ffCBFFFF', 4, 'center')
       KillThread(self)
    end)
end
function PlatoonAttack(pUnit, platoon)
    local circle = ForkThread(function(self)
		--local squadT = platoon:GetPlatoonUnits()
		local count = table.getn(platoon:GetPlatoonUnits())
		if count > 0 then
			platoon:AttackTarget(pUnit)
			--PrintText("PlatoonAttack", 30, 'ffCBFFFF', 4, 'center')
		end
	KillThread(self)
    end)
end
function EmergencyDrop(Unit)
    local circle = ForkThread(function(self)
		local aUnit = Unit
		local EmergencyLanding = false
		local Damage = 0.1
		local RanNum = Random(1, 3)
		--PrintText("Emergency Drop", 30, 'ffCBFFFF', 4, 'center')
		if RanNum == 2 then
			Damage = 0.65
		elseif RanNum == 3 then
			Damage = 0.85	
		end	
		repeat
			WaitSeconds(1)
			if aUnit and not aUnit:BeenDestroyed() then
				local shieldRatio = aUnit:GetShieldRatio(aUnit)
				if shieldRatio <= Damage and EmergencyLanding == false then
					--PrintText("Attempting Land", 30, 'ffCBFFFF', 4, 'center')
					local VECTOR3
					local aUnitPos = aUnit:GetPosition()
					IssueClearCommands({ aUnit })
					IssueTransportUnload({ aUnit }, aUnitPos)
					EmergencyLanding = true
				end
			end	
		until aUnit:BeenDestroyed() or aUnit == nil or EmergencyLanding == true
	KillThread(self)
    end)
end
function RedirectUnitMinorBoss(aaUnit)
    local circle = ForkThread(function(self)
		local aUnit = aaUnit
		if aUnit and not aUnit:BeenDestroyed() and EntityCategoryContains(categories.LAND, aUnit) == true then
			local pUnit = nil
			if Random(1, 3) <= 2 then
				if Random(1, 2) == 1 then
					pUnit = GetAllEnemyUnitsLandDefense(self)
				else	
					pUnit = GetAllEnemyUnitsLandEconomy(self)
				end
			else
				if Random(1, 3) == 2 then
					pUnit = GetClosestEnemyNearUnitBoss(self, aUnit)
				else
					pUnit = GetRandomEnemy4LandBossUnit(self)
				end	
			end	
            if pUnit and not pUnit:BeenDestroyed() then
				IssueClearCommands({ aUnit })
				local VECTOR3
				local pUnitPos = pUnit:GetPosition()
				if Random(1, 10) <= 8 then	
					IssueMove({ aUnit }, pUnitPos)
				else
					IssueMove({ aUnit }, pUnitPos)
					WaitSeconds(Random(30, 60))
					IssueClearCommands({ aUnit })
					IssueAggressiveMove({ aUnit }, pUnitPos)
					WaitSeconds(Random(48, 78))
					repeat
						WaitSeconds(12)
						if aUnit:BeenDestroyed() or pUnit:BeenDestroyed() then
							break
						end
						if Random(1, 12) == 6 then
							break
						end
					until pUnit:BeenDestroyed() or pUnit == nil
					WaitTicks(20)
					if aUnit ~= nil and not aUnit:BeenDestroyed() then 
						IssueClearCommands({ aUnit })
					end	
				end
            end
        elseif aUnit and not aUnit:BeenDestroyed() then
            local pUnit = nil
			if Random(1, 3) <= 2 then
				if Random(1, 2) == 1 then
					pUnit = GetAllEnemyUnitsBombers(self)
				else
					pUnit = GetAllEnemyUnitsLandEconomy(self)
				end	
			else	
				pUnit = GetRandomEnemy4AirBossUnit(self)
			end	
            if pUnit and not pUnit:BeenDestroyed() then
                IssueClearCommands({ aUnit })
                local VECTOR3
                local pUnitPos = pUnit:GetPosition()
				if Random(1, 2) == 1 then	
					IssueMove({ aUnit }, pUnitPos)
				else
					IssueMove({ aUnit }, pUnitPos)
					WaitSeconds(Random(15, 30))
					IssueClearCommands({ aUnit })
					IssueAggressiveMove({ aUnit }, pUnitPos)
					repeat
						WaitSeconds(12)
						if aUnit:BeenDestroyed() or pUnit:BeenDestroyed() then
							break
						end
						if Random(1, 12) == 6 then
							break
						end
					until pUnit:BeenDestroyed() or pUnit == nil
					WaitTicks(20)
					if aUnit ~= nil and not aUnit:BeenDestroyed() then 
						IssueClearCommands({ aUnit })
					end	
				end
            end
        end
        KillThread(self)
    end)
end
function RedirectUnit(aaUnit)
    local circle = ForkThread(function(self)
		local aUnit = aaUnit
		if aUnit and not aUnit:BeenDestroyed() and EntityCategoryContains(categories.INDIRECTFIRE, aUnit) == true and EntityCategoryContains(categories.EXPERIMENTAL, aUnit) == false then
			local pUnit = nil
				pUnit = GetRandomEnemyUnit(self)	
            if pUnit and not pUnit:BeenDestroyed() then
                IssueClearCommands({ aUnit })
                local VECTOR3
                local pUnitPos = pUnit:GetPosition()
				IssueMove({ aUnit }, pUnitPos)
				WaitSeconds(Random(45, 90))
				IssueClearCommands({ aUnit })
				IssueAggressiveMove({ aUnit }, pUnitPos)
				WaitSeconds(Random(48, 78))
				repeat
					WaitSeconds(12)
					if aUnit:BeenDestroyed() or pUnit:BeenDestroyed() then
						break
					end
					if Random(1, 12) == 6 then
						break
					end
				until pUnit:BeenDestroyed() or pUnit == nil
				WaitTicks(20)
				if aUnit ~= nil and not aUnit:BeenDestroyed() then 
					IssueClearCommands({ aUnit })
				end	
            end
        elseif aUnit and not aUnit:BeenDestroyed() then
            local pUnit = nil
				pUnit = GetRandomEnemyUnit(self)
            if pUnit then
                local VECTOR3
                local pUnitPos = pUnit:GetPosition()
				if Random(1, 4) <= 3 then
					IssueMove({ aUnit }, pUnitPos)
				else
					IssueMove({ aUnit }, pUnitPos)
					WaitSeconds(Random(10, 30))
					IssueClearCommands({ aUnit })
					IssueAggressiveMove({ aUnit }, pUnitPos)
					WaitSeconds(Random(48, 78))
					repeat
						WaitSeconds(12)
						if aUnit:BeenDestroyed() or pUnit:BeenDestroyed() then
							break
						end
						if Random(1, 12) == 6 then
							break
						end
					until pUnit:BeenDestroyed() or pUnit == nil
					WaitTicks(20)
					if aUnit ~= nil and not aUnit:BeenDestroyed() then 
						IssueClearCommands({ aUnit })
					end	
				end	
            end
        end
        KillThread(self)
    end)
end
function RedirectBomber(aaUnit)
    local circle = ForkThread(function(self)
		local aUnit = aaUnit
        if aUnit ~= nil then
            local pUnit = nil
			pUnit = GetRandomCommandUnitInWater(self)
            if pUnit ~= nil then
                local VECTOR3
                local pUnitPos = pUnit:GetPosition()
				if Random(1, 2) == 1 then
					IssueMove({ aUnit }, pUnitPos)
				else
					IssueMove({ aUnit }, pUnitPos)
					WaitSeconds(Random(10, 30))
					IssueClearCommands({ aUnit })
					IssueAggressiveMove({ aUnit }, pUnitPos)
					repeat
						WaitSeconds(12)
						if aUnit:BeenDestroyed() or pUnit:BeenDestroyed() then
							break
						end
						if Random(1, 12) == 6 then
							break
						end
					until pUnit:BeenDestroyed() or pUnit == nil
					WaitTicks(20)
					if aUnit ~= nil and not aUnit:BeenDestroyed() then 
						IssueClearCommands({ aUnit })
					end	
				end	
            end
			repeat
				WaitSeconds(10)
				if pUnit == nil or pUnit:BeenDestroyed() then
					if aUnit ~= nil and not aUnit:BeenDestroyed() then 
						if not aUnit:BeenDestroyed() and not aUnit:IsUnitState('Busy') and not aUnit:IsUnitState('Immobile') and not aUnit:IsUnitState('Moving') and not aUnit:IsUnitState('Attacking') and not aUnit:IsUnitState('MakingAttackRun') and not aUnit:IsUnitState('Patrolling') then
							RedirectBomber(aUnit)
						end	
					else
						break
					end	
				end
			until GetGameTimeSeconds > 20000
        end
        KillThread(self)
    end)
end
function RedirectACUHunter(aaUnit)
    local circle = ForkThread(function(self)
		local aUnit = aaUnit
        if aUnit ~= nil then
            local pUnit = nil
			pUnit = GetRandomCommandUnit(self)
            if pUnit ~= nil then
                local VECTOR3
                local pUnitPos = pUnit:GetPosition()
				IssueMove({ aUnit }, pUnitPos)
				repeat	
					WaitSeconds(10)
					if aUnit:BeenDestroyed() then
						break
					elseif pUnit ~= nil and not pUnit:BeenDestroyed() then
						local pUnitPos = pUnit:GetPosition()
						IssueClearCommands({ aUnit })
						IssueMove({ aUnit }, pUnitPos)
					end	
				until pUnit:BeenDestroyed() or pUnit == nil
				if aUnit and not aUnit:BeenDestroyed() then	
					RedirectACUHunter(aUnit)
				end	
            end
        end
        KillThread(self)
    end)
end
function RedirectUnits()
	AllRedirectCycleRunning = true
	WaitSeconds(6)
    local circle = ForkThread(function(self)
			local count = 0
			local aUnit
        --if isAIBrain then
            local ai_mobile_units = aiBrain:GetListOfUnits(categories.MOBILE - (categories.BUILTBYTIER3COMMANDER * categories.CYBRAN * categories.EXPERIMENTAL * categories.ARTILLERY * categories.INDIRECTFIRE * categories.SNIPEMODE * categories.LOWSELECTPRIO) - categories.TRANSPORTFOCUS, false)
            local ai_mobile_units2 = aiBrain:GetListOfUnits((categories.MOBILE * categories.LAND * categories.TECH3 * categories.INDIRECTFIRE) + (categories.MOBILE * categories.LAND * categories.TECH2 * categories.INDIRECTFIRE) + (categories.MOBILE * categories.LAND * categories.TECH1 * categories.INDIRECTFIRE) - (categories.BUILTBYTIER3COMMANDER * categories.CYBRAN * categories.EXPERIMENTAL * categories.ARTILLERY * categories.INDIRECTFIRE * categories.SNIPEMODE * categories.LOWSELECTPRIO) - categories.TRANSPORTFOCUS, false)
			--local ai_mobile_units3 = aiBrain:GetListOfUnits((categories.uel0301_rambo) + (categories.url0301_rambo) + (categories.xsl0301_rambo), false) --(categories.ual0301_rambo)
			WaitTicks(20)
            if ai_mobile_units then
                for aindex, aUnit in ai_mobile_units do
					--local circle = ForkThread(function(self)
						if aUnit and EntityCategoryContains(categories.ENGINEER, aUnit) == false
						and EntityCategoryContains(categories.COMMAND, aUnit) == false and not aUnit:BeenDestroyed() and not aUnit:IsUnitState('Busy') and not aUnit:IsUnitState('Immobile')
						and not aUnit:IsUnitState('Moving') and not aUnit:IsUnitState('Attacking') and not aUnit:IsUnitState('MakingAttackRun') and not aUnit:IsUnitState('Patrolling') then
							RedirectUnitEvenWaves(aUnit)
						end
						count = count + 1
						if count == 20 then
							WaitTicks(5)
							count = 0
						end	
					--end)	
                end
            end
			WaitTicks(20)
			if ai_mobile_units2 then --Artillery
                for aindex, aUnit in ai_mobile_units2 do
					--local circle = ForkThread(function(self)
						if aUnit and EntityCategoryContains(categories.ENGINEER, aUnit) == false
						and EntityCategoryContains(categories.COMMAND, aUnit) == false and not aUnit:BeenDestroyed() and not aUnit:IsUnitState('Busy') and not aUnit:IsUnitState('Immobile') 
						and not aUnit:IsUnitState('Moving') and not aUnit:IsUnitState('Attacking') and not aUnit:IsUnitState('Patrolling') then
							RedirectUnitEvenWavesArty(aUnit)
						end
						count = count + 1
						if count == 20 then
							WaitTicks(5)
							count = 0
						end	
					--end)	
                end
            end
		AllRedirectCycleRunning = false
        KillThread(self)
    end)
end
function RedirectUnitEvenWaves(aaUnit)
    local circle = ForkThread(function(self)
		local aUnit = aaUnit
		local pUnit = nil
			pUnit = GetRandomEnemyUnit(self)
		if pUnit and not pUnit:BeenDestroyed() then
			IssueClearCommands({ aUnit })
			local VECTOR3
			local pUnitPos = pUnit:GetPosition()
			if Random(1, 10) <= 8 then	
				IssueMove({ aUnit }, pUnitPos)
			else
				IssueMove({ aUnit }, pUnitPos)
				WaitSeconds(Random(10, 30))
				IssueClearCommands({ aUnit })
				IssueAggressiveMove({ aUnit }, pUnitPos)
				WaitSeconds(Random(48, 78))
				repeat
					WaitSeconds(12)
					if aUnit:BeenDestroyed() or pUnit:BeenDestroyed() then
						break
					end
					if Random(1, 12) == 6 then
						break
					end
				until pUnit:BeenDestroyed() or pUnit == nil
				WaitTicks(20)
				if aUnit ~= nil and not aUnit:BeenDestroyed() then 
					IssueClearCommands({ aUnit })
				end	
			end
		else
			WaitTicks(2)
			RedirectUnitEvenWaves(aUnit)
		end
		KillThread(self)
	end)
end	
function RedirectUnitEvenWavesArty(aaUnit)
    local circle = ForkThread(function(self)
		local aUnit = aaUnit
		local pUnit = nil
			pUnit = GetRandomEnemyUnit(self)	
			if pUnit and not pUnit:BeenDestroyed() then
				IssueClearCommands({ aUnit })
				local VECTOR3
				local pUnitPos = pUnit:GetPosition()
				if Random(1, 2) == 1 then	
					IssueMove({ aUnit }, pUnitPos)
					WaitSeconds(Random(20, 40))
					IssueClearCommands({ aUnit })
					IssueAggressiveMove({ aUnit }, pUnitPos)
					WaitSeconds(Random(48, 78))
					repeat
						WaitSeconds(12)
						if aUnit:BeenDestroyed() or pUnit:BeenDestroyed() then
							break
						end
						if Random(1, 12) == 6 then
							break
						end
					until pUnit:BeenDestroyed() or pUnit == nil
					WaitTicks(20)
					if aUnit ~= nil and not aUnit:BeenDestroyed() then 
						IssueClearCommands({ aUnit })
					end	
				else
					IssueMove({ aUnit }, pUnitPos)
					WaitSeconds(Random(45, 90))
					IssueClearCommands({ aUnit })
					IssueAggressiveMove({ aUnit }, pUnitPos)
					WaitSeconds(Random(48, 78))
					repeat
						WaitSeconds(12)
						if aUnit:BeenDestroyed() or pUnit:BeenDestroyed() then
							break
						end
						if Random(1, 12) == 6 then
							break
						end
					until pUnit:BeenDestroyed() or pUnit == nil
					WaitTicks(20)
					if aUnit ~= nil and not aUnit:BeenDestroyed() then 
						IssueClearCommands({ aUnit })
					end	
				end
			else
				WaitTicks(2)
				RedirectUnitEvenWavesArty(aUnit)
			end		
		KillThread(self)
	end)
end	
function RedirectRAMBOS()
	RamboRedirectCycleRunning = true
	WaitSeconds(2)
	local circle = ForkThread(function(self)
		local aUnit
		local ai_mobile_units3 = aiBrain:GetListOfUnits((categories.uel0301_rambo) + (categories.url0301_rambo) + (categories.xsl0301_rambo), false) --(categories.ual0301_rambo)
		WaitTicks(2)
			if ai_mobile_units3 then --Rambos
                for aindex, aUnit in ai_mobile_units3 do
					--local circle = ForkThread(function(self)
						if aUnit and not aUnit:BeenDestroyed() and not aUnit:IsUnitState('Busy') and not aUnit:IsUnitState('Moving') and not aUnit:IsUnitState('Attacking') and not aUnit:IsUnitState('Immobile') and not aUnit:IsUnitState('Patrolling') then
							RedirectRAMBO(aUnit)
						end
					--end)	
                end
			end
		RamboRedirectCycleRunning = false
		KillThread(self)
    end)
end
function RedirectRAMBO(aaUnit)
	local circle = ForkThread(function(self)
		local aUnit = aaUnit
		local pUnit = nil
		if Random(1, 5) <= 3 then
			if Random(1, 2) == 1 then
				pUnit = RandomEnemyUnitsLandDefenseList(self)
			else	
				pUnit = RandomEnemyUnitsLandEconomyList(self)
			end
		else
			pUnit = GetClosestEnemyNearUnitLand(self, aUnit)	
		end	
		if pUnit and not pUnit:BeenDestroyed() then
			IssueClearCommands({ aUnit })
			local VECTOR3
			local pUnitPos = pUnit:GetPosition()
			if Random(1, 2) == 1 then	
				IssueMove({ aUnit }, pUnitPos)
				WaitSeconds(Random(20, 35))
				IssueClearCommands({ aUnit })
				IssueAggressiveMove({ aUnit }, pUnitPos)
				repeat
					WaitSeconds(12)
					if aUnit:BeenDestroyed() or pUnit:BeenDestroyed() then
						break
					end
					if Random(1, 12) == 6 then
						break
					end
				until pUnit:BeenDestroyed() or pUnit == nil
				WaitTicks(20)
				if aUnit ~= nil and not aUnit:BeenDestroyed() then 
					IssueClearCommands({ aUnit })
				end	
			else
				IssueMove({ aUnit }, pUnitPos)
				WaitSeconds(Random(35, 60))
				IssueClearCommands({ aUnit })
				IssueAggressiveMove({ aUnit }, pUnitPos)
				repeat
					WaitSeconds(12)
					if aUnit:BeenDestroyed() or pUnit:BeenDestroyed() then
						break
					end
					if Random(1, 12) == 6 then
						break
					end
				until pUnit:BeenDestroyed() or pUnit == nil
				WaitTicks(20)
				if aUnit ~= nil and not aUnit:BeenDestroyed() then 
					IssueClearCommands({ aUnit })
				end	
			end
		else
			WaitTicks(2)
			RedirectRAMBO(aUnit)
		end	
	KillThread(self)
    end)
end
function RedirectUnitsLand()
	LandRedirectCycleRunning = true
	WaitSeconds(6)
	GetListsOfLandTargets()
    local circle = ForkThread(function(self)
			local count = 0
			local aUnit
        --if isAIBrain then
            local ai_mobile_units = aiBrain:GetListOfUnits((categories.MOBILE * categories.LAND) - (categories.BUILTBYTIER3COMMANDER * categories.CYBRAN * categories.EXPERIMENTAL * categories.ARTILLERY * categories.INDIRECTFIRE * categories.SNIPEMODE * categories.LOWSELECTPRIO) - (categories.MOBILE * categories.LAND * categories.TECH3 * categories.INDIRECTFIRE) - (categories.MOBILE * categories.LAND * categories.TECH2 * categories.INDIRECTFIRE) - (categories.MOBILE * categories.LAND * categories.TECH1 * categories.INDIRECTFIRE) - (categories.MOBILE * categories.LAND * categories.ANTINAVY), false)
			local ai_mobile_units2 = aiBrain:GetListOfUnits((categories.MOBILE * categories.LAND * categories.TECH3 * categories.INDIRECTFIRE) + (categories.MOBILE * categories.LAND * categories.TECH2 * categories.INDIRECTFIRE) + (categories.MOBILE * categories.LAND * categories.TECH1 * categories.INDIRECTFIRE) - (categories.BUILTBYTIER3COMMANDER * categories.CYBRAN * categories.EXPERIMENTAL * categories.ARTILLERY * categories.INDIRECTFIRE * categories.SNIPEMODE * categories.LOWSELECTPRIO), false)
			local ai_mobile_units3 = aiBrain:GetListOfUnits(categories.MOBILE * categories.LAND * categories.ANTINAVY, false)
            WaitTicks(20)
            if ai_mobile_units then
                for aindex, aUnit in ai_mobile_units do
					--local circle = ForkThread(function(self)
						if aUnit and EntityCategoryContains(categories.ENGINEER, aUnit) == false
						and EntityCategoryContains(categories.COMMAND, aUnit) == false and not aUnit:BeenDestroyed() and not aUnit:IsUnitState('Busy') and not aUnit:IsUnitState('Immobile') and not aUnit:IsUnitState('Moving') and not aUnit:IsUnitState('Attacking') and not aUnit:IsUnitState('Patrolling') then
							RedirectUnitRegularLand(aUnit)	
						end
						count = count + 1
						if count == 20 then
							WaitTicks(5)
							count = 0
						end	
					--end)
                end
            end
			WaitTicks(20)
			if ai_mobile_units2 then --Artillery
                for aindex, aUnit in ai_mobile_units2 do
					--local circle = ForkThread(function(self)
						if aUnit and EntityCategoryContains(categories.ENGINEER, aUnit) == false
						and EntityCategoryContains(categories.COMMAND, aUnit) == false and not aUnit:BeenDestroyed() and not aUnit:IsUnitState('Busy') and not aUnit:IsUnitState('Immobile')
						and not aUnit:IsUnitState('Moving') and not aUnit:IsUnitState('Attacking') and not aUnit:IsUnitState('Patrolling') then
							RedirectUnitLandArtillery(aUnit)
						end
						count = count + 1
						if count == 20 then
							WaitTicks(5)
							count = 0
						end	
					--end)
                end
            end
			WaitTicks(20)
			if ai_mobile_units3 then
                for aindex, aUnit in ai_mobile_units3 do
					--local circle = ForkThread(function(self)
						if aUnit and EntityCategoryContains(categories.ENGINEER, aUnit) == false
						and EntityCategoryContains(categories.COMMAND, aUnit) == false and not aUnit:BeenDestroyed() and not aUnit:IsUnitState('Busy') and not aUnit:IsUnitState('Immobile')
						and not aUnit:IsUnitState('Moving') and not aUnit:IsUnitState('Attacking') and not aUnit:IsUnitState('Patrolling') then
							RedirectUnitLandAntiNavy(aUnit)
						end
						count = count + 1
						if count == 20 then
							WaitTicks(5)
							count = 0
						end	
					--end)
                end
            end	
		LandRedirectCycleRunning = false		
        KillThread(self)
    end)
end
function RedirectUnitRegularLand(aaUnit)
    local circle = ForkThread(function(self)
		local aUnit = aaUnit
		local pUnit = nil
		local count = 0
		if Random(1, 3) <= 2 then
			if Random(1, 2) == 1 then
				pUnit = RandomEnemyUnitsLandDefenseList(self)
			else	
				pUnit = RandomEnemyUnitsLandEconomyList(self)
			end
		else
			if Random(1, 4) == 1 then
				pUnit = GetClosestEnemyNearUnitLand(self, aUnit)
			else
				pUnit = GetRandomEnemyLandUnit(self)
			end	
		end	
		if pUnit and not pUnit:BeenDestroyed() then
			IssueClearCommands({ aUnit })
			local VECTOR3
			local pUnitPos = pUnit:GetPosition()
			if Random(1, 8) <= 6 then
				IssueMove({ aUnit }, pUnitPos)
			else
				IssueMove({ aUnit }, pUnitPos)
				WaitSeconds(Random(20, 60))
				IssueClearCommands({ aUnit })
				IssueAggressiveMove({ aUnit }, pUnitPos)
				WaitSeconds(Random(48, 78))
				repeat
					WaitSeconds(12)
					if aUnit:BeenDestroyed() or pUnit:BeenDestroyed() then
						break
					end
					if Random(1, 12) == 6 then
						break
					end
				until pUnit:BeenDestroyed() or pUnit == nil
				WaitTicks(20)
				if aUnit ~= nil and not aUnit:BeenDestroyed() then 
					IssueClearCommands({ aUnit })
				end	
			end	
		else
			WaitTicks(2)
			RedirectUnitRegularLand(aUnit)
		end	
		KillThread(self)
	end)
end	
function RedirectUnitLandArtillery(aaUnit)
    local circle = ForkThread(function(self)
		local aUnit = aaUnit
		local count = 0
		local pUnit = nil
			if Random(1, 3) <= 2 then
				if Random(1, 2) == 1 then
					pUnit = RandomEnemyUnitsLandDefenseList(self)
				else	
					pUnit = RandomEnemyUnitsLandEconomyList(self)
				end
			else
				if Random(1, 3) == 1 then
					pUnit = GetClosestEnemyNearUnitLand(self, aUnit)
				else
					pUnit = GetRandomEnemyLandUnit(self)
				end	
			end	
			if pUnit and not pUnit:BeenDestroyed() then
				IssueClearCommands({ aUnit })
				local VECTOR3
				local pUnitPos = pUnit:GetPosition()
				if Random(1, 2) == 1 then	
					IssueMove({ aUnit }, pUnitPos)
					WaitSeconds(Random(20, 35))
					IssueClearCommands({ aUnit })
					IssueAggressiveMove({ aUnit }, pUnitPos)
					WaitSeconds(Random(48, 78))
					repeat
						WaitSeconds(12)
						if aUnit:BeenDestroyed() or pUnit:BeenDestroyed() then
							break
						end
						if Random(1, 12) == 6 then
							break
						end
					until pUnit:BeenDestroyed() or pUnit == nil
					WaitTicks(20)
					if aUnit ~= nil and not aUnit:BeenDestroyed() then 
						IssueClearCommands({ aUnit })
					end	
				else
					IssueMove({ aUnit }, pUnitPos)
					WaitSeconds(Random(35, 60))
					IssueClearCommands({ aUnit })
					IssueAggressiveMove({ aUnit }, pUnitPos)
					WaitSeconds(Random(48, 78))
					repeat
						WaitSeconds(12)
						if aUnit:BeenDestroyed() or pUnit:BeenDestroyed() then
							break
						end
						if Random(1, 12) == 6 then
							break
						end
					until pUnit:BeenDestroyed() or pUnit == nil
					WaitTicks(20)
					if aUnit ~= nil and not aUnit:BeenDestroyed() then 
						IssueClearCommands({ aUnit })
					end	
				end
			else
				WaitTicks(2)
				RedirectUnitLandArtillery(aUnit)
			end	
		KillThread(self)
	end)
end	
function RedirectUnitLandAntiNavy(aaUnit)
    local circle = ForkThread(function(self)
		local aUnit = aaUnit
		local pUnit = nil
		local count = 0
			if Random(1, 3) <= 2 then
				if Random(1, 2) == 1 then
					pUnit = RandomEnemyUnitsLandDefenseList(self)
				else	
					pUnit = RandomEnemyUnitsLandEconomyList(self)
				end
			else
				if Random(1, 3) == 1 then
					pUnit = GetClosestEnemyNearAntiNavy(self, aUnit)
				else	
					pUnit = RandomEnemySubsForAntiNavyList(self)
				end		
			end	
			if pUnit and not pUnit:BeenDestroyed() then
				IssueClearCommands({ aUnit })
				local VECTOR3
				local pUnitPos = pUnit:GetPosition()
				if Random(1, 8) <= 6 then
					IssueMove({ aUnit }, pUnitPos)
				else
					IssueMove({ aUnit }, pUnitPos)
					WaitSeconds(Random(20, 60))
					IssueClearCommands({ aUnit })
					IssueAggressiveMove({ aUnit }, pUnitPos)
					WaitSeconds(Random(48, 78))
					repeat
						WaitSeconds(12)
						if aUnit:BeenDestroyed() or pUnit:BeenDestroyed() then
							break
						end
						if Random(1, 12) == 6 then
							break
						end
					until pUnit:BeenDestroyed() or pUnit == nil
					WaitTicks(20)
					if aUnit ~= nil and not aUnit:BeenDestroyed() then 
						IssueClearCommands({ aUnit })
					end	
				end
			else
				WaitTicks(2)
				RedirectUnitLandAntiNavy(aUnit)
			end	
		KillThread(self)
	end)
end	
function RedirectUnitsAir()
	AirRedirectCycleRunning = true
	WaitSeconds(6)
	GetListsOfAirTargets()
    local circle = ForkThread(function(self)
			local aUnit
			local count = 0
        --if isAIBrain then
            local ai_mobile_units = aiBrain:GetListOfUnits((categories.MOBILE * categories.AIR) + (categories.MOBILE * categories.AIR * categories.EXPERIMENTAL) - (categories.MOBILE * categories.AIR * categories.ANTINAVY) - (categories.MOBILE * categories.AIR * categories.TECH3 * categories.ANTIAIR - categories.DIRECTFIRE - categories.BOMBER) - (categories.MOBILE * categories.AIR * categories.AEON * categories.TECH2 * categories.ANTIAIR) - (categories.MOBILE * categories.AIR * categories.TECH1 * categories.ANTIAIR) - categories.TRANSPORTFOCUS, false)
			local ai_mobile_units2 = aiBrain:GetListOfUnits((categories.MOBILE * categories.AIR * categories.ANTINAVY) - (categories.MOBILE * categories.AIR * categories.EXPERIMENTAL) - categories.TRANSPORTFOCUS, false)
			local ai_mobile_units3 = aiBrain:GetListOfUnits((categories.MOBILE * categories.AIR * categories.TECH3 * categories.ANTIAIR - categories.DIRECTFIRE - categories.BOMBER) + (categories.MOBILE * categories.AIR * categories.AEON * categories.TECH2 * categories.ANTIAIR) + (categories.MOBILE * categories.AIR * categories.TECH1 * categories.ANTIAIR) - (categories.MOBILE * categories.AIR * categories.EXPERIMENTAL) - categories.TRANSPORTFOCUS, false)
            WaitTicks(20)
            if ai_mobile_units then
                for aindex, aUnit in ai_mobile_units do
					--local circle = ForkThread(function(self)
						if aUnit and EntityCategoryContains(categories.ENGINEER, aUnit) == false
						and EntityCategoryContains(categories.COMMAND, aUnit) == false and not aUnit:BeenDestroyed() and not aUnit:IsUnitState('Busy') and not aUnit:IsUnitState('Immobile') and not aUnit:IsUnitState('Moving') and not aUnit:IsUnitState('Attacking') and not aUnit:IsUnitState('MakingAttackRun') and not aUnit:IsUnitState('Patrolling') then
							RedirectUnitAirGroundAtk(aUnit)
						end
						count = count + 1
						if count == 20 then
							WaitTicks(5)
							count = 0
						end	
					--end)	
                end
            end
			WaitTicks(20)
			if ai_mobile_units2 then -- Torp Bombers
                for aindex, aUnit in ai_mobile_units2 do
					--local circle = ForkThread(function(self)
						if aUnit and EntityCategoryContains(categories.ENGINEER, aUnit) == false
						and EntityCategoryContains(categories.COMMAND, aUnit) == false and not aUnit:BeenDestroyed() and not aUnit:IsUnitState('Busy') and not aUnit:IsUnitState('Immobile') and not aUnit:IsUnitState('Moving') and not aUnit:IsUnitState('Attacking') and not aUnit:IsUnitState('MakingAttackRun') and not aUnit:IsUnitState('Patrolling') then
							RedirectUnitAirTorps(aUnit)
						end
						count = count + 1
						if count == 20 then
							WaitTicks(5)
							count = 0
						end	
					--end)	
                end
            end
			WaitTicks(20)
			if ai_mobile_units3 then -- ASF + Fighters
                for aindex, aUnit in ai_mobile_units3 do
					--local circle = ForkThread(function(self)
						if aUnit and EntityCategoryContains(categories.ENGINEER, aUnit) == false
						and EntityCategoryContains(categories.COMMAND, aUnit) == false and not aUnit:BeenDestroyed() and not aUnit:IsUnitState('Busy') and not aUnit:IsUnitState('Immobile') and not aUnit:IsUnitState('Moving') and not aUnit:IsUnitState('Attacking') and not aUnit:IsUnitState('MakingAttackRun') and not aUnit:IsUnitState('Patrolling') then
							RedirectUnitAirASF(aUnit)
						end
						count = count + 1
						if count == 20 then
							WaitTicks(5)
							count = 0
						end	
					--end)	
                end
            end
        --end
		AirRedirectCycleRunning = false
        KillThread(self)
    end)
end
function RedirectUnitAirGroundAtk(aaUnit)
    local circle = ForkThread(function(self)
		local aUnit = aaUnit
		local pUnit = nil
		local count = 0
			if Random(1, 3) <= 2 then
				if Random(1, 2) == 1 then
					pUnit = RandomEnemyUnitsBombersList(self)
				else	
					pUnit = RandomEnemyUnitsLandEconomyList(self)
				end
			else	
				if Random(1, 3) == 1 then
					pUnit = GetClosestEnemyNearUnitAir(self, aUnit)
				else
					pUnit = GetRandomEnemy4BomberUnit(self)
				end	
			end	
			if pUnit and not pUnit:BeenDestroyed() then
				IssueClearCommands({ aUnit })
				local VECTOR3
				local pUnitPos = pUnit:GetPosition()
				if Random(1, 4) <= 3 then
					IssueMove({ aUnit }, pUnitPos)
					WaitSeconds(Random(8, 14))
					IssueClearCommands({ aUnit })
					IssueAggressiveMove({ aUnit }, pUnitPos)
					repeat
						WaitSeconds(12)
						if aUnit:BeenDestroyed() or pUnit:BeenDestroyed() then
							break
						end
						if Random(1, 12) == 6 then
							break
						end
					until pUnit:BeenDestroyed() or pUnit == nil
					WaitTicks(20)
					if aUnit ~= nil and not aUnit:BeenDestroyed() then 
						IssueClearCommands({ aUnit })
					end	
				else
					IssueMove({ aUnit }, pUnitPos)
					WaitSeconds(Random(14, 20))
					IssueClearCommands({ aUnit })
					IssueAggressiveMove({ aUnit }, pUnitPos)
					repeat
						WaitSeconds(12)
						if aUnit:BeenDestroyed() or pUnit:BeenDestroyed() then
							break
						end
						if Random(1, 12) == 6 then
							break
						end
					until pUnit:BeenDestroyed() or pUnit == nil
					WaitTicks(20)
					if aUnit ~= nil and not aUnit:BeenDestroyed() then 
						IssueClearCommands({ aUnit })
					end	
				end
			else
				WaitTicks(2)
				RedirectUnitAirGroundAtk(aUnit)
			end		
		KillThread(self)
	end)
end	
function RedirectUnitAirTorps(aaUnit)
    local circle = ForkThread(function(self)
		local aUnit = aaUnit
		local pUnit = nil
		local count = 0
				pUnit = RandomEnemyUnitsSubsList(self)
			if pUnit and not pUnit:BeenDestroyed() then
				IssueClearCommands({ aUnit })
				local VECTOR3
				local pUnitPos = pUnit:GetPosition()
				if Random(1, 7) <= 5 then
					IssueMove({ aUnit }, pUnitPos)
					WaitSeconds(Random(4, 5))
					IssueClearCommands({ aUnit })
					IssueAggressiveMove({ aUnit }, pUnitPos)
					repeat
						WaitSeconds(12)
						if aUnit:BeenDestroyed() or pUnit:BeenDestroyed() then
							break
						end
						if Random(1, 12) == 6 then
							break
						end
					until pUnit:BeenDestroyed() or pUnit == nil
					WaitTicks(20)
					if aUnit ~= nil and not aUnit:BeenDestroyed() then 
						IssueClearCommands({ aUnit })
					end	
				else
					IssueAggressiveMove({ aUnit }, pUnitPos)
					repeat
						WaitSeconds(12)
						if aUnit:BeenDestroyed() or pUnit:BeenDestroyed() then
							break
						end
						if Random(1, 12) == 6 then
							break
						end
					until pUnit:BeenDestroyed() or pUnit == nil
					WaitTicks(20)
					if aUnit ~= nil and not aUnit:BeenDestroyed() then 
						IssueClearCommands({ aUnit })
					end	
				end	
			else
				WaitTicks(2)
				RedirectUnitAirTorps(aUnit)
			end		
		KillThread(self)
	end)
end	
function RedirectUnitAirASF(aaUnit)
    local circle = ForkThread(function(self)
		local aUnit = aaUnit
		local pUnit = nil
		local count = 0
			pUnit = RandomEnemyUnitsAirList(self)
			if pUnit and not pUnit:BeenDestroyed() then
				IssueClearCommands({ aUnit })
				local VECTOR3
				local pUnitPos = pUnit:GetPosition()
				IssueMove({ aUnit }, pUnitPos)
				WaitSeconds(Random(1, 3))
				IssueClearCommands({ aUnit })
				IssueAggressiveMove({ aUnit }, pUnitPos)
				repeat
					WaitSeconds(12)
					if aUnit:BeenDestroyed() or pUnit:BeenDestroyed() then
						break
					end
					if Random(1, 12) == 6 then
						break
					end
				until pUnit:BeenDestroyed() or pUnit == nil
				WaitTicks(20)
				if aUnit ~= nil and not aUnit:BeenDestroyed() then 
					IssueClearCommands({ aUnit })
				end	
			else
				WaitTicks(2)
				RedirectUnitAirASF(aUnit)
			end			
		KillThread(self)
	end)
end	
function RedirectUnitsNavy()
	NavyRedirectCycleRunning = true
	WaitSeconds(6)
	GetListsOfNavyTargets()
	local count = 0
    local circle = ForkThread(function(self)
			local aUnit
        --if isAIBrain then
            local ai_mobile_units = aiBrain:GetListOfUnits((categories.MOBILE * categories.NAVAL) - (categories.MOBILE * categories.NAVAL * categories.SUBMERSIBLE) - (categories.BUILTBYTIER3COMMANDER * categories.CYBRAN * categories.EXPERIMENTAL * categories.ARTILLERY * categories.INDIRECTFIRE * categories.SNIPEMODE * categories.LOWSELECTPRIO), false)
			local ai_mobile_units2 = aiBrain:GetListOfUnits((categories.MOBILE * categories.NAVAL * categories.SUBMERSIBLE) - (categories.BUILTBYTIER3COMMANDER * categories.CYBRAN * categories.EXPERIMENTAL * categories.ARTILLERY * categories.INDIRECTFIRE * categories.SNIPEMODE * categories.LOWSELECTPRIO), false)
            WaitTicks(20)
            if ai_mobile_units then
                for aindex, aUnit in ai_mobile_units do
					--local circle = ForkThread(function(self)
						if aUnit and EntityCategoryContains(categories.ENGINEER, aUnit) == false
						and EntityCategoryContains(categories.COMMAND, aUnit) == false and not aUnit:BeenDestroyed() and not aUnit:IsUnitState('Busy') and not aUnit:IsUnitState('Immobile') 
						and not aUnit:IsUnitState('Moving') and not aUnit:IsUnitState('Attacking') and not aUnit:IsUnitState('Patrolling') then
							RedirectUnitRegularNavy(aUnit)
						end
						count = count + 1
						if count == 20 then
							WaitTicks(5)
							count = 0
						end	
					--end)	
                end
            end
			WaitTicks(20)
			if ai_mobile_units2 then --Subs
                for aindex, aUnit in ai_mobile_units2 do
					--local circle = ForkThread(function(self)
						if aUnit and EntityCategoryContains(categories.ENGINEER, aUnit) == false
						and EntityCategoryContains(categories.COMMAND, aUnit) == false and not aUnit:BeenDestroyed() and not aUnit:IsUnitState('Busy') and not aUnit:IsUnitState('Immobile') 
						and not aUnit:IsUnitState('Moving') and not aUnit:IsUnitState('Attacking') and not aUnit:IsUnitState('Patrolling') then
							RedirectUnitNavySubs(aUnit)
						end
						count = count + 1
						if count == 20 then
							WaitTicks(5)
							count = 0
						end	
					--end)	
                end
            end
        --end
		NavyRedirectCycleRunning = false
        KillThread(self)
    end)
end
function RedirectUnitRegularNavy(aaUnit)
    local circle = ForkThread(function(self)
		local aUnit = aaUnit
		local pUnit = nil
			if Random(1, 3) <= 2 then	
				pUnit = RandomEnemyUnitsNavalList(self)
			else
				if Random(1, 3) == 2 then
					pUnit = GetClosestEnemyNearNavy(self, aUnit)
				else
					pUnit = GetRandomEnemyNavalUnit(self)
				end	
			end	
			if pUnit and not pUnit:BeenDestroyed() then
				IssueClearCommands({ aUnit })
				local VECTOR3
				local pUnitPos = pUnit:GetPosition()
				if Random(1, 7) <= 4 then
					IssueMove({ aUnit }, pUnitPos)
					WaitSeconds(Random(70, 110))
					IssueClearCommands({ aUnit })
					IssueAggressiveMove({ aUnit }, pUnitPos)
					WaitSeconds(Random(50, 80))
					if EntityCategoryContains(categories.TECH3, aUnit) == true or EntityCategoryContains(categories.EXPERIMENTAL, aUnit) == true then
						WaitSeconds(60)
					end	
					repeat
						WaitSeconds(12)
						if aUnit:BeenDestroyed() or pUnit:BeenDestroyed() then
							break
						end
						if Random(1, 12) == 6 then
							break
						end
					until pUnit:BeenDestroyed() or pUnit == nil
					WaitTicks(20)
					if aUnit ~= nil and not aUnit:BeenDestroyed() then 
						IssueClearCommands({ aUnit })
					end	
				else
					IssueMove({ aUnit }, pUnitPos)
				end
			else
				WaitTicks(2)
				RedirectUnitRegularNavy(aUnit)
			end		
		KillThread(self)
	end)
end	
function RedirectUnitNavySubs(aaUnit)
    local circle = ForkThread(function(self)
		local aUnit = aaUnit
		local pUnit = nil
				pUnit = RandomEnemyUnitsSubsList(self)
			if pUnit and not pUnit:BeenDestroyed() then
				IssueClearCommands({ aUnit })
				local VECTOR3
				local pUnitPos = pUnit:GetPosition()
				IssueMove({ aUnit }, pUnitPos)
				WaitSeconds(Random(70, 110))
				IssueClearCommands({ aUnit })
				IssueAggressiveMove({ aUnit }, pUnitPos)
				WaitSeconds(Random(50, 80))
				if EntityCategoryContains(categories.EXPERIMENTAL, aUnit) == true then
					WaitSeconds(60)
				end	
				repeat
					WaitSeconds(12)
					if aUnit:BeenDestroyed() or pUnit:BeenDestroyed() then
						break
					end
					if Random(1, 12) == 6 then
						break
					end
				until pUnit:BeenDestroyed() or pUnit == nil
				WaitTicks(20)
				if aUnit ~= nil and not aUnit:BeenDestroyed() then 
					IssueClearCommands({ aUnit })
				end	
			else
				WaitTicks(2)
				RedirectUnitNavySubs(aUnit)
			end			
		KillThread(self)
	end)
end	

--[[function RedirectUnit(aUnit)
    local circle = ForkThread(function(self)
        if aUnit and not aUnit:BeenDestroyed() and isAIBrain then
            local pUnit = nil
            pUnit = GetClosestEnemyUnit(self, aUnit)
            if pUnit then
                local VECTOR3
                local pUnitPos = pUnit:GetPosition()
                IssueMove({ aUnit }, pUnitPos)
            else
                WaitTicks(51)
                if aUnit and not aUnit:BeenDestroyed() then
                    aUnit:Kill()
                end
            end
        end
        KillThread(self)
    end)
end
function RedirectUnits()
    local circle = ForkThread(function(self)
        if isAIBrain then
            local ai_mobile_units = aiBrain:GetListOfUnits(categories.MOBILE, false)
            WaitTicks(10)
            if ai_mobile_units then
                for aindex, aUnit in ai_mobile_units do
                    if aUnit and EntityCategoryContains(categories.ENGINEER, aUnit) == false
                        and EntityCategoryContains(categories.COMMAND, aUnit) == false and EntityCategoryContains(categories.ARTILLERY, aUnit) == true
						and not aUnit:BeenDestroyed() and not aUnit:IsUnitState('Busy') and not aUnit:IsUnitState('Moving') and not aUnit:IsUnitState('Attacking')
						and GetUnitId(aUnit) ~= "URL0401" then 
                        local pUnit = nil
							pUnit = GetRandomEnemyUnit(self)
                        if pUnit and not pUnit:BeenDestroyed() then
                            IssueClearCommands({ aUnit })
                            local VECTOR3
                            local pUnitPos = pUnit:GetPosition()
							IssueMove({ aUnit }, pUnitPos)
                        else
                            WaitTicks(31)
                            RedirectUnit(aUnit)
                        end
					elseif aUnit and EntityCategoryContains(categories.ENGINEER, aUnit) == false
                        and EntityCategoryContains(categories.COMMAND, aUnit) == false and EntityCategoryContains(categories.ARTILLERY, aUnit) == false
						and not aUnit:BeenDestroyed() and not aUnit:IsUnitState('Busy') and not aUnit:IsUnitState('Moving') and not aUnit:IsUnitState('Attacking') then 
                        local pUnit = nil	
							pUnit = GetRandomEnemyUnit(self)
							if Random(1, 3) <= 2 then	
							pUnit = GetRandomEnemyUnit(self)
							else	
							pUnit = GetRandomEnemyUnitMobile(self)
							end	
                        if pUnit and not pUnit:BeenDestroyed() then
                            IssueClearCommands({ aUnit })
                            local VECTOR3
                            local pUnitPos = pUnit:GetPosition()
							IssueMove({ aUnit }, pUnitPos)
                        else
                            WaitTicks(31)
                            RedirectUnit(aUnit)
                        end
                    end
                end
            end
        end
        KillThread(self)
    end)
end]]--
function GetListsOfLandTargets()
	GetAllEnemyUnitsLandDefenseList()
	GetAllEnemyUnitsLandEconomyList()
	GetAllEnemySubsForAntiNavyList()
end
function GetListsOfAirTargets()
	GetAllEnemyUnitsBombersList()
	GetAllEnemyUnitsAirList()
	GetAllEnemyUnitsLandEconomyList()
	GetAllEnemyUnitsSubsList()
end
function GetListsOfNavyTargets()
	GetAllEnemyUnitsSubsList()
	GetAllEnemyUnitsNavalList()
end
RandomEnemyUnitsLandDefenseList = function(self)
	local EnemyUnit = nil
	if table.getn(AllEnemyUnitsLandDefense) <= 5 then
		EnemyUnit = GetRandomEnemyLandUnit(self)
	else
		EnemyUnit = AllEnemyUnitsLandDefense[Random(1, table.getn(AllEnemyUnitsLandDefense))]
	end	

	return EnemyUnit
end
RandomEnemyUnitsLandEconomyList = function(self)
	local EnemyUnit = nil
	if table.getn(AllEnemyUnitsLandEconomy) <= 5 then
		EnemyUnit = GetRandomEnemyLandUnit(self)
	else
		EnemyUnit = AllEnemyUnitsLandEconomy[Random(1, table.getn(AllEnemyUnitsLandEconomy))]
	end	

	return EnemyUnit
end
RandomEnemySubsForAntiNavyList = function(self)
	local EnemyUnit = nil
	if table.getn(AllEnemyUnitsAntiNavy) <= 5 then
		EnemyUnit = GetRandomEnemyLandUnit(self)
	else
		EnemyUnit = AllEnemyUnitsAntiNavy[Random(1, table.getn(AllEnemyUnitsAntiNavy))]
	end	

	return EnemyUnit
end
RandomEnemyUnitsSubsList = function(self)
	local EnemyUnit = nil
	if table.getn(AllEnemyUnitsSubs) < 1 then
		EnemyUnit = GetRandomCommandUnitInWater(self)
	else
		EnemyUnit = AllEnemyUnitsSubs[Random(1, table.getn(AllEnemyUnitsSubs))]
	end	
	return EnemyUnit
end
RandomEnemyUnitsBombersList = function(self)
	local EnemyUnit = nil
	if table.getn(AllEnemyUnitsBombers) <= 5 then
		EnemyUnit = GetRandomEnemy4BomberUnit(self)
	else
		EnemyUnit = AllEnemyUnitsBombers[Random(1, table.getn(AllEnemyUnitsBombers))]
	end	
	return EnemyUnit
end
RandomEnemyUnitsAirList = function(self)
	local EnemyUnit = nil
	if table.getn(AllEnemyUnitsAir) > 0 then
		EnemyUnit = AllEnemyUnitsAir[Random(1, table.getn(AllEnemyUnitsAir))]
	else	
		if table.getn(AllEnemyUnitsBombers) <= 5 then
			EnemyUnit = GetRandomEnemy4BomberUnit(self)
		else
			EnemyUnit = AllEnemyUnitsBombers[Random(1, table.getn(AllEnemyUnitsBombers))]
		end	
	end
	return EnemyUnit
end
RandomEnemyUnitsNavalList = function(self)
	local EnemyUnit = nil
	if table.getn(AllEnemyUnitsNaval) < 5 then
		EnemyUnit = GetRandomEnemyNavalUnit(self)
	else
		EnemyUnit = AllEnemyUnitsNaval[Random(1, table.getn(AllEnemyUnitsNaval))]
	end
	return EnemyUnit
end
GetAllEnemyUnitsLandDefenseList = function(self)
    AllEnemyUnitsLandDefense = {}
    local enemyUnitList = {}
	local EnemyUnit = nil
    for i, brain in humanBrains.HBrains do
        enemyUnitList = brain:GetListOfUnits((categories.STRUCTURE * categories.DEFENSE * categories.TECH3 * categories.DIRECTFIRE) + (categories.STRUCTURE * categories.DEFENSE * categories.TECH2 * categories.DIRECTFIRE) + 
		(categories.STRUCTURE * categories.DEFENSE * categories.EXPERIMENTAL) + (categories.MOBILE * categories.EXPERIMENTAL * categories.LAND) + (categories.STRUCTURE * categories.STRATEGIC * categories.SILO), false)
		for i = 1, table.getn(enemyUnitList) do
			AllEnemyUnitsLandDefense[table.getn(AllEnemyUnitsLandDefense) + 1] = enemyUnitList[i]
		end
    end
end
GetAllEnemyUnitsLandEconomyList = function(self)
    AllEnemyUnitsLandEconomy = {}
    local enemyUnitList = {}
	local enemyUnitList2 = {}
	local EnemyUnit = nil
    for i, brain in humanBrains.HBrains do
        enemyUnitList = brain:GetListOfUnits((categories.STRUCTURE * categories.MASSFABRICATION * categories.TECH3) + (categories.STRUCTURE * categories.FACTORY * categories.TECH3) + categories.SUBCOMMANDER + categories.COMMAND + (categories.STRUCTURE * categories.MASSFABRICATION * categories.TECH2) + (categories.STRUCTURE * categories.MASSFABRICATION * categories.TECH1)
			+ (categories.SILO * categories.TECH3 * categories.STRUCTURE) + (categories.STRUCTURE * categories.ENGINEERSTATION) + (categories.STRATEGIC * categories.TECH3 * categories.STRUCTURE) + (categories.STRUCTURE * categories.ENERGYPRODUCTION * categories.TECH3) +
			(categories.STRUCTURE * categories.EXPERIMENTAL * categories.STRATEGIC) + (categories.STRUCTURE * categories.EXPERIMENTAL * categories.ECONOMIC) + (categories.STRUCTURE * categories.EXPERIMENTAL) - (categories.STRUCTURE * categories.EXPERIMENTAL * categories.DEFENSE), false)
		enemyUnitList2 = brain:GetListOfUnits(categories.STRUCTURE * categories.MASSEXTRACTION, false)	
		for i = 1, table.getn(enemyUnitList) do
			AllEnemyUnitsLandEconomy[table.getn(AllEnemyUnitsLandEconomy) + 1] = enemyUnitList[i]
		end
		for i = 1, table.getn(enemyUnitList2) do
			local aUnit = enemyUnitList2[i]
			if aUnit ~= nil and aUnit:GetCurrentLayer() == "Land" and aUnit:GetCurrentLayer() ~= "Seabed" then
				AllEnemyUnitsLandEconomy[table.getn(AllEnemyUnitsLandEconomy) + 1] = enemyUnitList2[i]
			end	
		end
    end
end
GetAllEnemySubsForAntiNavyList = function(self)
    AllEnemyUnitsAntiNavy = {}
    local enemyUnitList = {}
	local enemyUnitList2 = {}
	local EnemyUnit = nil
    for i, brain in humanBrains.HBrains do
        enemyUnitList = brain:GetListOfUnits((categories.MOBILE * categories.NAVAL) + (categories.STRUCTURE * categories.ANTINAVY) + (categories.STRUCTURE * categories.NAVAL), false)
		enemyUnitList2 = brain:GetListOfUnits((categories.STRUCTURE * categories.MASSEXTRACTION * categories.MASSPRODUCTION), false)
		for i = 1, table.getn(enemyUnitList) do
			AllEnemyUnitsAntiNavy[table.getn(AllEnemyUnitsAntiNavy) + 1] = enemyUnitList[i]
		end
		for i = 1, table.getn(enemyUnitList2) do
			local aUnit = enemyUnitList2[i]
			if aUnit ~= nil and (aUnit:GetCurrentLayer() == "Sub" or aUnit:GetCurrentLayer() == "Seabed") then
				AllEnemyUnitsAntiNavy[table.getn(AllEnemyUnitsAntiNavy) + 1] = enemyUnitList2[i]
			end	
		end
    end
end
GetAllEnemyUnitsAirList = function(self)
    AllEnemyUnitsAir = {}
    local enemyUnitList = {}
	local EnemyUnit = nil
    for i, brain in humanBrains.HBrains do
        enemyUnitList = brain:GetListOfUnits((categories.MOBILE * categories.AIR * categories.TECH3) + (categories.MOBILE * categories.AIR * categories.EXPERIMENTAL), false)
		if table.getn(enemyUnitList) < 1 then
			enemyUnitList = brain:GetListOfUnits((categories.MOBILE * categories.AIR) - (categories.MOBILE * categories.AIR * categories.SATELLITE), false)
		end
		for i = 1, table.getn(enemyUnitList) do
			AllEnemyUnitsAir[table.getn(AllEnemyUnitsAir) + 1] = enemyUnitList[i]
		end	
    end
end
GetAllEnemyUnitsBombersList = function(self)
    AllEnemyUnitsBombers = {}
    local enemyUnitList = {}
	local enemyUnitList2 = {}
	local EnemyUnit = nil
    for i, brain in humanBrains.HBrains do
        enemyUnitList = brain:GetListOfUnits((categories.STRUCTURE * categories.DEFENSE * categories.TECH3 * categories.DIRECTFIRE) + categories.COMMAND + categories.SUBCOMMANDER + (categories.STRUCTURE * categories.DEFENSE * categories.TECH2 * categories.DIRECTFIRE) +
		(categories.EXPERIMENTAL) + (categories.NAVAL * categories.MOBILE) + (categories.STRUCTURE * categories.MASSFABRICATION * categories.TECH2) + (categories.STRUCTURE * categories.MASSFABRICATION * categories.TECH1) + (categories.STRUCTURE * categories.MASSFABRICATION * categories.TECH3) - (categories.NAVAL * categories.SUBMERSIBLE) - (categories.EXPERIMENTAL * categories.DEFENSE * categories.ANTIAIR * categories.STRUCTURE)
		+ (categories.STRUCTURE * categories.STRATEGIC * categories.SILO), false)
		enemyUnitList2 = brain:GetListOfUnits(categories.STRUCTURE * categories.MASSEXTRACTION, false)
		for i = 1, table.getn(enemyUnitList) do
			AllEnemyUnitsBombers[table.getn(AllEnemyUnitsBombers) + 1] = enemyUnitList[i]
		end
		for i = 1, table.getn(enemyUnitList2) do
			local aUnit = enemyUnitList2[i]
			if aUnit ~= nil and aUnit:GetCurrentLayer() == "Land" and aUnit:GetCurrentLayer() ~= "Seabed" then
				AllEnemyUnitsBombers[table.getn(AllEnemyUnitsBombers) + 1] = enemyUnitList2[i]
			end	
		end
    end
end
GetAllEnemyUnitsSubsList = function(self)
    AllEnemyUnitsSubs = {}
    local enemyUnitList = {}
	local enemyUnitList2 = {}
	local EnemyUnit = nil
    for i, brain in humanBrains.HBrains do
        enemyUnitList = brain:GetListOfUnits((categories.MOBILE * categories.NAVAL) + (categories.STRUCTURE * categories.ANTINAVY) + (categories.STRUCTURE * categories.NAVAL), false)
		enemyUnitList2 = brain:GetListOfUnits((categories.STRUCTURE * categories.MASSEXTRACTION), false)
		for i = 1, table.getn(enemyUnitList) do
			AllEnemyUnitsSubs[table.getn(AllEnemyUnitsSubs) + 1] = enemyUnitList[i]
		end
		for i = 1, table.getn(enemyUnitList2) do
			local aUnit = enemyUnitList2[i]
			if aUnit ~= nil and (aUnit:GetCurrentLayer() == "Sub" or aUnit:GetCurrentLayer() == "Seabed") then
				AllEnemyUnitsSubs[table.getn(AllEnemyUnitsSubs) + 1] = enemyUnitList2[i]
			end	
		end
    end
end
GetAllEnemyUnitsNavalList = function(self)
    AllEnemyUnitsNaval = {}
    local enemyUnitList = {}
	local EnemyUnit = nil
    for i, brain in humanBrains.HBrains do
        enemyUnitList = brain:GetListOfUnits((categories.MOBILE * categories.NAVAL) + (categories.STRUCTURE * categories.ANTINAVY) + (categories.STRUCTURE * categories.NAVAL) + 
		(categories.STRUCTURE * categories.MASSPRODUCTION * categories.MASSEXTRACTION) + (categories.AMPHIBIOUS * categories.MOBILE), false)
		for i = 1, table.getn(enemyUnitList) do
			AllEnemyUnitsNaval[table.getn(AllEnemyUnitsNaval) + 1] = enemyUnitList[i]
		end
    end
end
GetAllEnemyUnitsLandDefense = function(self)
    local AllEnemyUnits = {}
    local enemyUnitList = {}
	local EnemyUnit = nil
    for i, brain in humanBrains.HBrains do
        enemyUnitList = brain:GetListOfUnits((categories.STRUCTURE * categories.DEFENSE * categories.TECH3 * categories.DIRECTFIRE) + (categories.STRUCTURE * categories.DEFENSE * categories.TECH2 * categories.DIRECTFIRE) + 
		(categories.STRUCTURE * categories.DEFENSE * categories.EXPERIMENTAL) + (categories.MOBILE * categories.EXPERIMENTAL * categories.LAND) + (categories.STRUCTURE * categories.STRATEGIC * categories.SILO), false)
		for i = 1, table.getn(enemyUnitList) do
			AllEnemyUnits[table.getn(AllEnemyUnits) + 1] = enemyUnitList[i]
		end
    end
	if table.getn(AllEnemyUnits) <= 5 then
		EnemyUnit = GetRandomEnemyLandUnit(self)
	else
		EnemyUnit = AllEnemyUnits[Random(1, table.getn(AllEnemyUnits))]
	end	
	return EnemyUnit
end
GetAllEnemyUnitsLandEconomy = function(self)
    local AllEnemyUnits = {}
    local enemyUnitList = {}
	local enemyUnitList2 = {}
	local EnemyUnit = nil
    for i, brain in humanBrains.HBrains do
        enemyUnitList = brain:GetListOfUnits((categories.STRUCTURE * categories.MASSFABRICATION * categories.TECH3) + (categories.STRUCTURE * categories.FACTORY * categories.TECH3) + categories.SUBCOMMANDER + categories.COMMAND + (categories.STRUCTURE * categories.MASSFABRICATION * categories.TECH2) + (categories.STRUCTURE * categories.MASSFABRICATION * categories.TECH1)
			+ (categories.SILO * categories.TECH3 * categories.STRUCTURE) + (categories.STRUCTURE * categories.ENGINEERSTATION) + (categories.STRATEGIC * categories.TECH3 * categories.STRUCTURE) + (categories.STRUCTURE * categories.ENERGYPRODUCTION * categories.TECH3) +
			(categories.STRUCTURE * categories.EXPERIMENTAL * categories.STRATEGIC) + (categories.STRUCTURE * categories.EXPERIMENTAL * categories.ECONOMIC) + (categories.STRUCTURE * categories.EXPERIMENTAL) - (categories.STRUCTURE * categories.EXPERIMENTAL * categories.DEFENSE), false)
		enemyUnitList2 = brain:GetListOfUnits(categories.STRUCTURE * categories.MASSEXTRACTION, false)	
		for i = 1, table.getn(enemyUnitList) do
			AllEnemyUnits[table.getn(AllEnemyUnits) + 1] = enemyUnitList[i]
		end
		for i = 1, table.getn(enemyUnitList2) do
			local aUnit = enemyUnitList2[i]
			if aUnit ~= nil and aUnit:GetCurrentLayer() == "Land" and aUnit:GetCurrentLayer() ~= "Seabed" then
				AllEnemyUnits[table.getn(AllEnemyUnits) + 1] = enemyUnitList2[i]
			end	
		end
    end
	if table.getn(AllEnemyUnits) <= 5 then
		EnemyUnit = GetRandomEnemyLandUnit(self)
	else
		EnemyUnit = AllEnemyUnits[Random(1, table.getn(AllEnemyUnits))]
	end	
	return EnemyUnit
end
GetAllEnemyUnitsEconomyArtillery = function(self)
    local AllEnemyUnits = {}
    local enemyUnitList = {}
	local enemyUnitList2 = {}
	local EnemyUnit = nil
    for i, brain in humanBrains.HBrains do
        enemyUnitList = brain:GetListOfUnits((categories.STRUCTURE * categories.MASSFABRICATION * categories.TECH3) + (categories.STRUCTURE * categories.FACTORY * categories.TECH3) +
			(categories.SILO * categories.TECH3 * categories.STRUCTURE) + (categories.STRUCTURE * categories.ENGINEERSTATION) + (categories.STRATEGIC * categories.TECH3 * categories.STRUCTURE) + (categories.STRUCTURE * categories.ENERGYPRODUCTION * categories.TECH3) +
			(categories.STRUCTURE * categories.EXPERIMENTAL * categories.STRATEGIC) + (categories.STRUCTURE * categories.EXPERIMENTAL * categories.ECONOMIC) + (categories.STRUCTURE * categories.EXPERIMENTAL) - (categories.STRUCTURE * categories.EXPERIMENTAL * categories.DEFENSE), false)
		enemyUnitList2 = brain:GetListOfUnits(categories.STRUCTURE * categories.MASSEXTRACTION, false)
		for i = 1, table.getn(enemyUnitList) do
			AllEnemyUnits[table.getn(AllEnemyUnits) + 1] = enemyUnitList[i]
		end
		for i = 1, table.getn(enemyUnitList2) do
			local aUnit = enemyUnitList2[i]
			if aUnit ~= nil and aUnit:GetCurrentLayer() == "Land" and aUnit:GetCurrentLayer() ~= "Seabed" then
				AllEnemyUnits[table.getn(AllEnemyUnits) + 1] = enemyUnitList2[i]
			end	
		end
    end
	if table.getn(AllEnemyUnits) <= 5 and Random(1, 5) <= 4 then
		EnemyUnit = GetRandomEnemyLandUnit(self)
	else
		EnemyUnit = AllEnemyUnits[Random(1, table.getn(AllEnemyUnits))]
	end	
	return EnemyUnit
end
GetAllEnemyUnitsForDooms = function(self)
    local AllEnemyUnits = {}
    local enemyUnitList = {}
	local AllParagon = {}
    local Paragons = {}
	local AllEndGamers = {}
    local EndGamers = {}
	local EnemyUnit = nil
    for i, brain in humanBrains.HBrains do
        enemyUnitList = brain:GetListOfUnits(categories.COMMAND + (categories.SILO * categories.TECH3 * categories.STRUCTURE) + (categories.STRATEGIC * categories.TECH3 * categories.STRUCTURE) + (categories.STRUCTURE * categories.EXPERIMENTAL * categories.DEFENSE) +
			(categories.STRUCTURE * categories.EXPERIMENTAL * categories.STRATEGIC) + (categories.STRUCTURE * categories.EXPERIMENTAL * categories.ECONOMIC) + (categories.STRUCTURE * categories.EXPERIMENTAL) - (categories.STRUCTURE * categories.EXPERIMENTAL * categories.DEFENSE * categories.ANTIAIR), false)
		Paragons = brain:GetListOfUnits(categories.xab1401, false)
		EndGamers = brain:GetListOfUnits(categories.xsb2401 + categories.xab2307 + categories.url0401 + categories.ueb2401, false)		
		for i = 1, table.getn(enemyUnitList) do
			AllEnemyUnits[table.getn(AllEnemyUnits) + 1] = enemyUnitList[i]
		end
		for i = 1, table.getn(Paragons) do
			AllParagon[table.getn(AllParagon) + 1] = Paragons[i]
		end
		for i = 1, table.getn(EndGamers) do
			AllEndGamers[table.getn(AllEndGamers) + 1] = EndGamers[i]
		end
    end
	if table.getn(AllParagon) >= 1 and Random(1, 5) <= 4 then
		EnemyUnit = AllParagon[Random(1, table.getn(AllParagon))]
	elseif table.getn(AllEndGamers) >= 1 then
		EnemyUnit = AllEndGamers[Random(1, table.getn(AllEndGamers))]
	elseif table.getn(AllEnemyUnits) >= 1 then
		EnemyUnit = AllEnemyUnits[Random(1, table.getn(AllEnemyUnits))]
	else
		EnemyUnit = GetAllEnemyUnitsEconomyArtillery(self)
	end
	return EnemyUnit
end
GetAllEnemyUnitsForArtillery = function(self)
    local AllEnemyUnits = {}
    local enemyUnitList = {}
	local AllParagon = {}
    local Paragons = {}
	local AllEndGamers = {}
    local EndGamers = {}
	local AllArtillery = {}
	local Artillery = {}
	local EnemyUnit = nil
    for i, brain in humanBrains.HBrains do
        enemyUnitList = brain:GetListOfUnits((categories.SILO * categories.TECH3 * categories.STRUCTURE) + (categories.STRATEGIC * categories.TECH3 * categories.ARTILLERY) + (categories.STRUCTURE * categories.EXPERIMENTAL * categories.ORBITALSYSTEM) +
			(categories.STRUCTURE * categories.EXPERIMENTAL * categories.STRATEGIC) + (categories.STRUCTURE * categories.EXPERIMENTAL * categories.ECONOMIC), false)
		Paragons = brain:GetListOfUnits(categories.xab1401, false)
		EndGamers = brain:GetListOfUnits(categories.xsb2401 + categories.xab2307 + categories.url0401 + categories.ueb2401, false)
		Artillery = brain:GetListOfUnits(categories.xab2307 + categories.url0401 + categories.ueb2401 + categories.xeb2402 + (categories.STRATEGIC * categories.TECH3 * categories.ARTILLERY * categories.STRUCTURE), false)
		for i = 1, table.getn(enemyUnitList) do
			AllEnemyUnits[table.getn(AllEnemyUnits) + 1] = enemyUnitList[i]
		end
		for i = 1, table.getn(Paragons) do
			AllParagon[table.getn(AllParagon) + 1] = Paragons[i]
		end
		for i = 1, table.getn(EndGamers) do
			AllEndGamers[table.getn(AllEndGamers) + 1] = EndGamers[i]
		end
		for i = 1, table.getn(Artillery) do
			AllArtillery[table.getn(AllArtillery) + 1] = Artillery[i]
		end
    end
	if table.getn(AllParagon) >= 1 and Random(1, 5) <= 4 then
		EnemyUnit = AllParagon[Random(1, table.getn(AllParagon))]
	elseif table.getn(AllEndGamers) >= 1 and Random(1, 4) <= 3 then
		EnemyUnit = AllEndGamers[Random(1, table.getn(AllEndGamers))]
	elseif table.getn(AllArtillery) >= 1 and Random(1, 4) <= 3 then
		EnemyUnit = AllArtillery[Random(1, table.getn(AllArtillery))]
	elseif table.getn(AllEnemyUnits) >= 1 and Random(1, 3) <= 2 then
		EnemyUnit = AllEnemyUnits[Random(1, table.getn(AllEnemyUnits))]
	else
		EnemyUnit = GetAllEnemyUnitsEconomyArtillery(self)
	end
	return EnemyUnit
end
GetAllEnemyUnitsForYoloBoss = function(self)
    local AllEnemyUnits = {}
    local enemyUnitList = {}
	local EnemyUnit = nil
    for i, brain in humanBrains.HBrains do
        enemyUnitList = brain:GetListOfUnits((categories.STRUCTURE * categories.EXPERIMENTAL * categories.STRATEGIC) + (categories.STRUCTURE * categories.EXPERIMENTAL * categories.ECONOMIC), false)
		for i = 1, table.getn(enemyUnitList) do
			AllEnemyUnits[table.getn(AllEnemyUnits) + 1] = enemyUnitList[i]
		end
    end
	if table.getn(AllEnemyUnits) < 1 then
		EnemyUnit = GetAllEnemyUnitsForArtillery(self)
	else
		EnemyUnit = AllEnemyUnits[Random(1, table.getn(AllEnemyUnits))]
	end
	return EnemyUnit
end
GetAllEnemyUnitsForNukes = function(self)
    local AllEnemyUnits = {}
    local enemyUnitList = {}
	local EnemyUnit = nil
    for i, brain in humanBrains.HBrains do
        enemyUnitList = brain:GetListOfUnits((categories.SILO * categories.TECH3 * categories.STRUCTURE) + (categories.STRATEGIC * categories.TECH3 * categories.STRUCTURE) + (categories.STRUCTURE * categories.EXPERIMENTAL * categories.DEFENSE) +
			(categories.STRUCTURE * categories.EXPERIMENTAL * categories.STRATEGIC) + (categories.STRUCTURE * categories.EXPERIMENTAL * categories.ECONOMIC) + (categories.MOBILE * categories.EXPERIMENTAL * categories.ARTILLERY) - (categories.STRUCTURE * categories.EXPERIMENTAL * categories.DEFENSE * categories.ANTIAIR), false)
		for i = 1, table.getn(enemyUnitList) do
			AllEnemyUnits[table.getn(AllEnemyUnits) + 1] = enemyUnitList[i]
		end
    end
	if table.getn(AllEnemyUnits) < 1 or Random(1, 2) == 1 then
		EnemyUnit = GetRandomEnemyDefenseUnitNuke(self)
	else
		EnemyUnit = AllEnemyUnits[Random(1, table.getn(AllEnemyUnits))]
	end
	return EnemyUnit
end
GetAllEnemyUnitsAir = function(self)
    local AllEnemyUnits = {}
    local enemyUnitList = {}
	local EnemyUnit = nil
    for i, brain in humanBrains.HBrains do
        enemyUnitList = brain:GetListOfUnits((categories.MOBILE * categories.AIR * categories.TECH3) + (categories.MOBILE * categories.AIR * categories.EXPERIMENTAL), false)
		if table.getn(enemyUnitList) < 1 then
			enemyUnitList = brain:GetListOfUnits((categories.MOBILE * categories.AIR), false)
		end
		for i = 1, table.getn(enemyUnitList) do
			AllEnemyUnits[table.getn(AllEnemyUnits) + 1] = enemyUnitList[i]
		end	
    end
	if table.getn(AllEnemyUnits) > 0 then
		EnemyUnit = AllEnemyUnits[Random(1, table.getn(AllEnemyUnits))]
	else	
		EnemyUnit = GetAllEnemyUnitsBombers(self)
	end
	return EnemyUnit
end
GetAllEnemyUnitsAir4Nomander = function(self)
    local AllEnemyUnits = {}
    local enemyUnitList = {}
	local EnemyUnit = nil
    for i, brain in humanBrains.HBrains do
        enemyUnitList = brain:GetListOfUnits((categories.MOBILE * categories.AIR * categories.TECH3) + (categories.MOBILE * categories.AIR * categories.EXPERIMENTAL), false)
		if table.getn(enemyUnitList) < 1 then
			enemyUnitList = brain:GetListOfUnits((categories.MOBILE * categories.AIR), false)
		end
		for i = 1, table.getn(enemyUnitList) do
			AllEnemyUnits[table.getn(AllEnemyUnits) + 1] = enemyUnitList[i]
		end	
    end
		EnemyUnit = AllEnemyUnits[Random(1, table.getn(AllEnemyUnits))]
	return EnemyUnit
end
GetAllEnemyUnitsBombers = function(self)
    local AllEnemyUnits = {}
    local enemyUnitList = {}
	local enemyUnitList2 = {}
	local EnemyUnit = nil
    for i, brain in humanBrains.HBrains do
        enemyUnitList = brain:GetListOfUnits((categories.STRUCTURE * categories.DEFENSE * categories.TECH3 * categories.DIRECTFIRE) + categories.COMMAND + categories.SUBCOMMANDER + (categories.STRUCTURE * categories.DEFENSE * categories.TECH2 * categories.DIRECTFIRE) +
		(categories.EXPERIMENTAL) + (categories.NAVAL * categories.MOBILE) + (categories.STRUCTURE * categories.MASSFABRICATION * categories.TECH2) + (categories.STRUCTURE * categories.MASSFABRICATION * categories.TECH1) + (categories.STRUCTURE * categories.MASSFABRICATION * categories.TECH3) - (categories.NAVAL * categories.SUBMERSIBLE) - (categories.EXPERIMENTAL * categories.DEFENSE * categories.ANTIAIR * categories.STRUCTURE)
		+ (categories.STRUCTURE * categories.STRATEGIC * categories.SILO), false)
		enemyUnitList2 = brain:GetListOfUnits(categories.STRUCTURE * categories.MASSEXTRACTION, false)
		for i = 1, table.getn(enemyUnitList) do
			AllEnemyUnits[table.getn(AllEnemyUnits) + 1] = enemyUnitList[i]
		end
		for i = 1, table.getn(enemyUnitList2) do
			local aUnit = enemyUnitList2[i]
			if aUnit ~= nil and aUnit:GetCurrentLayer() == "Land" and aUnit:GetCurrentLayer() ~= "Seabed" then
				AllEnemyUnits[table.getn(AllEnemyUnits) + 1] = enemyUnitList2[i]
			end	
		end
    end
	if table.getn(AllEnemyUnits) <= 5 then
		EnemyUnit = GetRandomEnemy4BomberUnit(self)
	else
		EnemyUnit = AllEnemyUnits[Random(1, table.getn(AllEnemyUnits))]
	end	
	return EnemyUnit
end
GetAllEnemyUnitsSubs = function(self)
    local AllEnemyUnits = {}
    local enemyUnitList = {}
	local enemyUnitList2 = {}
	local EnemyUnit = nil
    for i, brain in humanBrains.HBrains do
        enemyUnitList = brain:GetListOfUnits((categories.MOBILE * categories.NAVAL) + (categories.STRUCTURE * categories.ANTINAVY) + (categories.STRUCTURE * categories.NAVAL), false)
		enemyUnitList2 = brain:GetListOfUnits((categories.STRUCTURE * categories.MASSEXTRACTION), false)
		for i = 1, table.getn(enemyUnitList) do
			AllEnemyUnits[table.getn(AllEnemyUnits) + 1] = enemyUnitList[i]
		end
		for i = 1, table.getn(enemyUnitList2) do
			local aUnit = enemyUnitList2[i]
			if aUnit ~= nil and (aUnit:GetCurrentLayer() == "Sub" or aUnit:GetCurrentLayer() == "Seabed") then
				AllEnemyUnits[table.getn(AllEnemyUnits) + 1] = enemyUnitList2[i]
			end	
		end
    end
	if table.getn(AllEnemyUnits) < 1 then
		EnemyUnit = GetRandomCommandUnitInWater(self)
	else
		EnemyUnit = AllEnemyUnits[Random(1, table.getn(AllEnemyUnits))]
	end	
	return EnemyUnit
end
GetAllEnemySubsForAntiNavy = function(self)
    local AllEnemyUnits = {}
    local enemyUnitList = {}
	local enemyUnitList2 = {}
	local EnemyUnit = nil
    for i, brain in humanBrains.HBrains do
        enemyUnitList = brain:GetListOfUnits((categories.MOBILE * categories.NAVAL) + (categories.STRUCTURE * categories.ANTINAVY) + (categories.STRUCTURE * categories.NAVAL), false)
		enemyUnitList2 = brain:GetListOfUnits((categories.STRUCTURE * categories.MASSEXTRACTION * categories.MASSPRODUCTION), false)
		for i = 1, table.getn(enemyUnitList) do
			AllEnemyUnits[table.getn(AllEnemyUnits) + 1] = enemyUnitList[i]
		end
		for i = 1, table.getn(enemyUnitList2) do
			local aUnit = enemyUnitList2[i]
			if aUnit ~= nil and (aUnit:GetCurrentLayer() == "Sub" or aUnit:GetCurrentLayer() == "Seabed") then
				AllEnemyUnits[table.getn(AllEnemyUnits) + 1] = enemyUnitList2[i]
			end	
		end
    end
	if table.getn(AllEnemyUnits) < 5 then
		if table.getn(AllEnemyUnits) > 1 and Random(1, 2) == 1 then
			EnemyUnit = AllEnemyUnits[Random(1, table.getn(AllEnemyUnits))]
		else
			EnemyUnit = GetAllEnemyUnitsForArtillery(self)
		end	
	else
		EnemyUnit = AllEnemyUnits[Random(1, table.getn(AllEnemyUnits))]
	end	
	return EnemyUnit
end
GetAllEnemyUnitsNaval = function(self)
    local AllEnemyUnits = {}
    local enemyUnitList = {}
	local EnemyUnit = nil
    for i, brain in humanBrains.HBrains do
        enemyUnitList = brain:GetListOfUnits((categories.MOBILE * categories.NAVAL) + (categories.STRUCTURE * categories.ANTINAVY) + (categories.STRUCTURE * categories.NAVAL) + 
		(categories.STRUCTURE * categories.MASSPRODUCTION * categories.MASSEXTRACTION) + (categories.AMPHIBIOUS * categories.MOBILE), false)
		for i = 1, table.getn(enemyUnitList) do
			AllEnemyUnits[table.getn(AllEnemyUnits) + 1] = enemyUnitList[i]
		end
    end
	if table.getn(AllEnemyUnits) < 5 then
		EnemyUnit = GetRandomEnemyNavalUnit(self)
	else
		EnemyUnit = AllEnemyUnits[Random(1, table.getn(AllEnemyUnits))]
	end
	return EnemyUnit
end
GetClosestEnemyNearUnitLand = function(self, unit)
    local AiUnit = unit
	local huUnit = nil
	local closestDistance = 100000000 
	local distance
	local AllEnemyUnits = {}
    local enemyUnitList = {}
	local enemyUnitList2 = {}
	local EnemyUnit = nil
    for i, brain in humanBrains.HBrains do
        enemyUnitList = brain:GetListOfUnits((categories.STRUCTURE - categories.SONAR - categories.ANTINAVY - categories.WALL - categories.MASSEXTRACTION) + categories.COMMAND + categories.SUBCOMMANDER + categories.EXPERIMENTAL + (categories.NAVAL - categories.SUBMERSIBLE) + categories.STRATEGIC, false)
		enemyUnitList2 = brain:GetListOfUnits(categories.STRUCTURE * categories.MASSEXTRACTION, false)
		for i = 1, table.getn(enemyUnitList) do
			AllEnemyUnits[table.getn(AllEnemyUnits) + 1] = enemyUnitList[i]
		end
		for i = 1, table.getn(enemyUnitList2) do
			local aUnit = enemyUnitList2[i]
			if aUnit ~= nil and aUnit:GetCurrentLayer() == "Land" and aUnit:GetCurrentLayer() ~= "Seabed" then
				AllEnemyUnits[table.getn(AllEnemyUnits) + 1] = enemyUnitList2[i]
			end	
		end
    end
	for i = 1, table.getn(AllEnemyUnits) do
		huUnit = AllEnemyUnits[i]
		WaitTicks(1)
            if AiUnit and not AiUnit:BeenDestroyed() then
				if huUnit and not huUnit:BeenDestroyed() then
                    local huPosX, huPosY, huPosZ = huUnit:GetPositionXYZ()
                    local aiPosX, aiPosY, aiPosZ = AiUnit:GetPositionXYZ()
					distance = VDist2Sq(huPosX, huPosZ, aiPosX, aiPosZ)
                    if distance < closestDistance then
                        closestDistance = distance
                        EnemyUnit = huUnit
                    end
                end
            else
                break
            end
	end
	if table.getn(AllEnemyUnits) == 0 then
		EnemyUnit = GetRandomEnemyLandUnit(self)
	end
	return EnemyUnit
end
GetClosestEnemyNearAntiNavy = function(self, unit)
    local AiUnit = unit
	local huUnit = nil
	local closestDistance = 100000000 
	local distance
	local AllEnemyUnits = {}
    local enemyUnitList = {}
	--local enemyUnitList2 = {}
	local EnemyUnit = nil
    for i, brain in humanBrains.HBrains do
        enemyUnitList = brain:GetListOfUnits((categories.STRUCTURE - categories.WALL) + categories.COMMAND + categories.SUBCOMMANDER + categories.EXPERIMENTAL + categories.NAVAL + categories.STRATEGIC, false)
		for i = 1, table.getn(enemyUnitList) do
			AllEnemyUnits[table.getn(AllEnemyUnits) + 1] = enemyUnitList[i]
		end
    end
	for i = 1, table.getn(AllEnemyUnits) do
		huUnit = AllEnemyUnits[i]
		WaitTicks(1)
            if AiUnit and not AiUnit:BeenDestroyed() then
				if huUnit and not huUnit:BeenDestroyed() then
                    local huPosX, huPosY, huPosZ = huUnit:GetPositionXYZ()
                    local aiPosX, aiPosY, aiPosZ = AiUnit:GetPositionXYZ()
					distance = VDist2Sq(huPosX, huPosZ, aiPosX, aiPosZ)
                    if distance < closestDistance then
                        closestDistance = distance
                        EnemyUnit = huUnit
                    end
                end
            else
                break
            end
	end
	if table.getn(AllEnemyUnits) == 0 then
		EnemyUnit = GetRandomEnemyLandUnit(self)
	end
	return EnemyUnit
end
GetClosestEnemyNearNavy = function(self, unit)
    local AiUnit = unit
	local huUnit = nil
	local closestDistance = 100000000 
	local distance
	local AllEnemyUnits = {}
    local enemyUnitList = {}
	--local enemyUnitList2 = {}
	local EnemyUnit = nil
    for i, brain in humanBrains.HBrains do
        enemyUnitList = brain:GetListOfUnits((categories.STRUCTURE - categories.WALL) + categories.COMMAND + categories.SUBCOMMANDER + categories.EXPERIMENTAL + categories.NAVAL, false)
		for i = 1, table.getn(enemyUnitList) do
			AllEnemyUnits[table.getn(AllEnemyUnits) + 1] = enemyUnitList[i]
		end
    end
	for i = 1, table.getn(AllEnemyUnits) do
		huUnit = AllEnemyUnits[i]
		WaitTicks(1)
            if AiUnit and not AiUnit:BeenDestroyed() then
				if huUnit and not huUnit:BeenDestroyed() then
                    local huPosX, huPosY, huPosZ = huUnit:GetPositionXYZ()
                    local aiPosX, aiPosY, aiPosZ = AiUnit:GetPositionXYZ()
					distance = VDist2Sq(huPosX, huPosZ, aiPosX, aiPosZ)
                    if distance < closestDistance then
                        closestDistance = distance
                        EnemyUnit = huUnit
                    end
                end
            else
                break
            end
	end
	if table.getn(AllEnemyUnits) == 0 then
		EnemyUnit = GetAllEnemyUnitsNaval(self)
	end
	return EnemyUnit
end
GetClosestEnemyNearUnitAir = function(self, unit)
    local AiUnit = unit
	local huUnit = nil
	local closestDistance = 100000000 
	local distance
	local AllEnemyUnits = {}
    local enemyUnitList = {}
	local enemyUnitList2 = {}
	local EnemyUnit = nil
    for i, brain in humanBrains.HBrains do
        enemyUnitList = brain:GetListOfUnits((categories.STRUCTURE - categories.SONAR - categories.ANTINAVY - categories.WALL - categories.MASSEXTRACTION) + categories.COMMAND + categories.SUBCOMMANDER + categories.EXPERIMENTAL + (categories.NAVAL - categories.SUBMERSIBLE) + categories.STRATEGIC, false)
		enemyUnitList2 = brain:GetListOfUnits(categories.STRUCTURE * categories.MASSEXTRACTION, false)
		for i = 1, table.getn(enemyUnitList) do
			AllEnemyUnits[table.getn(AllEnemyUnits) + 1] = enemyUnitList[i]
		end
		for i = 1, table.getn(enemyUnitList2) do
			local aUnit = enemyUnitList2[i]
			if aUnit ~= nil and aUnit:GetCurrentLayer() == "Land" and aUnit:GetCurrentLayer() ~= "Seabed" then
				AllEnemyUnits[table.getn(AllEnemyUnits) + 1] = enemyUnitList2[i]
			end	
		end
    end
	for i = 1, table.getn(AllEnemyUnits) do
		huUnit = AllEnemyUnits[i]
		WaitTicks(1)
            if AiUnit and not AiUnit:BeenDestroyed() then
				if huUnit and not huUnit:BeenDestroyed() then
                    local huPosX, huPosY, huPosZ = huUnit:GetPositionXYZ()
                    local aiPosX, aiPosY, aiPosZ = AiUnit:GetPositionXYZ()
					distance = VDist2Sq(huPosX, huPosZ, aiPosX, aiPosZ)
                    if distance < closestDistance then
                        closestDistance = distance
                        EnemyUnit = huUnit
                    end
                end
            else
                break
            end
	end
	if table.getn(AllEnemyUnits) == 0 then
		EnemyUnit = GetRandomEnemy4BomberUnit(self)
	end
	return EnemyUnit
end
GetClosestEnemyNearUnitBoss = function(self, unit)
    local AiUnit = unit
	local huUnit = nil
	local closestDistance = 100000000 
	local distance
	local AllEnemyUnits = {}
    local enemyUnitList = {}
	local enemyUnitList2 = {}
	local EnemyUnit = nil
    for i, brain in humanBrains.HBrains do
        enemyUnitList = brain:GetListOfUnits((categories.STRUCTURE - categories.SONAR - categories.ANTINAVY - categories.WALL - categories.MASSEXTRACTION) + categories.COMMAND + categories.SUBCOMMANDER + categories.EXPERIMENTAL + (categories.NAVAL - categories.SUBMERSIBLE) + categories.STRATEGIC, false)
		enemyUnitList2 = brain:GetListOfUnits(categories.STRUCTURE * categories.MASSEXTRACTION, false)
		for i = 1, table.getn(enemyUnitList) do
			AllEnemyUnits[table.getn(AllEnemyUnits) + 1] = enemyUnitList[i]
		end
		for i = 1, table.getn(enemyUnitList2) do
			local aUnit = enemyUnitList2[i]
			if aUnit ~= nil and aUnit:GetCurrentLayer() == "Land" and aUnit:GetCurrentLayer() ~= "Seabed" then
				AllEnemyUnits[table.getn(AllEnemyUnits) + 1] = enemyUnitList2[i]
			end	
		end
    end
	for i = 1, table.getn(AllEnemyUnits) do
		huUnit = AllEnemyUnits[i]
		WaitTicks(1)
            if AiUnit and not AiUnit:BeenDestroyed() then
				if huUnit and not huUnit:BeenDestroyed() then
                    local huPosX, huPosY, huPosZ = huUnit:GetPositionXYZ()
                    local aiPosX, aiPosY, aiPosZ = AiUnit:GetPositionXYZ()
					distance = VDist2Sq(huPosX, huPosZ, aiPosX, aiPosZ)
                    if distance < closestDistance then
                        closestDistance = distance
                        EnemyUnit = huUnit
                    end
                end
            else
                break
            end
	end
	if table.getn(AllEnemyUnits) == 0 then
		EnemyUnit = GetRandomEnemy4LandBossUnit(self)
	end
	return EnemyUnit
end
GetClosestEnemyUnit = function(self, AiUnit)
	local AiUnit
    local huBrain = nil
    local closestEnemyUnit = nil
    local closestDistance = 100000000 
    huBrain = GetRandomCloseAliveEnemyBrain(self)
    if huBrain and not huBrain:IsDefeated() then
        local huUnitsList = huBrain:GetListOfUnits((categories.STRUCTURE - categories.SONAR - categories.ANTINAVY - categories.WALL) + categories.COMMAND + categories.SUBCOMMANDER + categories.EXPERIMENTAL + (categories.NAVAL - categories.SUBMERSIBLE) + categories.STRATEGIC, false)
        for i, huUnit in huUnitsList do
            WaitTicks(1)
            if AiUnit and not AiUnit:BeenDestroyed() then
                if huUnit and not huUnit:BeenDestroyed() then
                    local huPosX, huPosY, huPosZ = huUnit:GetPositionXYZ()
                    local aiPosX, aiPosY, aiPosZ = AiUnit:GetPositionXYZ()
                    if VDist2Sq(huPosX, huPosZ, aiPosX, aiPosZ) < closestDistance then
                        closestDistance = VDist2Sq(huPosX, huPosZ, aiPosX, aiPosZ)
                        closestEnemyUnit = huUnit
                    end
                end
            else
                break
            end
        end
    else
    end
    return closestEnemyUnit
end
GetClosestEnemyUnitLand = function(self, AiUnit)
	local AiUnit
    local huBrain = nil
    local closestEnemyUnit = nil
    local closestDistance = 100000000 
    huBrain = GetRandomCloseAliveEnemyBrain(self)
    if huBrain and not huBrain:IsDefeated() then
        local huUnitsList = huBrain:GetListOfUnits((categories.STRUCTURE - categories.SONAR - categories.ANTINAVY - categories.WALL) + (categories.MOBILE + categories.LAND), false)
        for i, huUnit in huUnitsList do
            WaitTicks(1)
            if AiUnit and not AiUnit:BeenDestroyed() then
                if huUnit and not huUnit:BeenDestroyed() then
                    local huPosX, huPosY, huPosZ = huUnit:GetPositionXYZ()
                    local aiPosX, aiPosY, aiPosZ = AiUnit:GetPositionXYZ()
                    if VDist2Sq(huPosX, huPosZ, aiPosX, aiPosZ) < closestDistance then
                        closestDistance = VDist2Sq(huPosX, huPosZ, aiPosX, aiPosZ)
                        closestEnemyUnit = huUnit
                    end
                end
            else
                break
            end
        end
    else
    end
    return closestEnemyUnit
end
GetClosestEnemyUnitAir = function(self, AiUnit)
	local AiUnit
    local huBrain = nil
    local closestEnemyUnit = nil
    local closestDistance = 100000000 
    huBrain = GetClosestEnemyBrainAir(self, AiUnit)
    if huBrain and not huBrain:IsDefeated() then
        local huUnitsList = huBrain:GetListOfUnits((categories.MOBILE + categories.AIR), false)
        for i, huUnit in huUnitsList do
            WaitTicks(1)
            if AiUnit and not AiUnit:BeenDestroyed() then
                if huUnit and not huUnit:BeenDestroyed() then
                    local huPosX, huPosY, huPosZ = huUnit:GetPositionXYZ()
                    local aiPosX, aiPosY, aiPosZ = AiUnit:GetPositionXYZ()
                    if VDist2Sq(huPosX, huPosZ, aiPosX, aiPosZ) < closestDistance then
                        closestDistance = VDist2Sq(huPosX, huPosZ, aiPosX, aiPosZ)
                        closestEnemyUnit = huUnit
                    end
                end
            else
                break
            end
        end
    else
    end
	if closestEnemyUnit == nil then
		GetRandomEnemyAirUnit(self)
	else
		return closestEnemyUnit
	end	
end
GetClosestEnemyUnitNaval = function(self, AiUnit)
	local AiUnit
    local huBrain = nil
    local closestEnemyUnit = nil
    local closestDistance = 100000000 
    huBrain = GetRandomCloseAliveEnemyBrain(self)
    if huBrain and not huBrain:IsDefeated() then
        local huUnitsList = huBrain:GetListOfUnits((categories.MOBILE * categories.NAVAL) + (categories.STRUCTURE * categories.NAVAL) + (categories.STRUCTURE * categories.ANTINAVY), false)
        for i, huUnit in huUnitsList do
            WaitTicks(1)
            if AiUnit and not AiUnit:BeenDestroyed() then
                if huUnit and not huUnit:BeenDestroyed() then
                    local huPosX, huPosY, huPosZ = huUnit:GetPositionXYZ()
                    local aiPosX, aiPosY, aiPosZ = AiUnit:GetPositionXYZ()
                    if VDist2Sq(huPosX, huPosZ, aiPosX, aiPosZ) < closestDistance then
                        closestDistance = VDist2Sq(huPosX, huPosZ, aiPosX, aiPosZ)
                        closestEnemyUnit = huUnit
                    end
                end
            else
                break
            end
        end
    else
    end
    return closestEnemyUnit
end
GetRandomEnemyUnit = function(self) --
    local huBrain = nil
    local closestEnemyUnit = nil
    huBrain = GetRandomCloseAliveEnemyBrain(self)
    if huBrain and not huBrain:IsDefeated() then
        local huUnitsList = huBrain:GetListOfUnits((categories.STRUCTURE * categories.DEFENSE * categories.TECH3 * categories.DIRECTFIRE) + categories.COMMAND + categories.SUBCOMMANDER + 
		(categories.EXPERIMENTAL) + (categories.NAVAL * categories.MOBILE) - (categories.NAVAL * categories.MOBILE * categories.SUBMERSIBLE) - (categories.EXPERIMENTAL * categories.DEFENSE * categories.ANTIAIR * categories.STRUCTURE), false)
        closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		if table.getn(huUnitsList) < 1 or Random(1, 3) <= 2 then
			huUnitsList = huBrain:GetListOfUnits((categories.STRUCTURE * categories.DEFENSE * categories.TECH2 * categories.DIRECTFIRE) + (categories.STRUCTURE * categories.MASSPRODUCTION) + (categories.STRUCTURE * categories.FACTORY) +
			(categories.SILO * categories.TECH3) + (categories.STRATEGIC * categories.TECH2) + (categories.STRATEGIC * categories.TECH3) + (categories.STRUCTURE * categories.ENERGYPRODUCTION), false)
			closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		end
		if table.getn(huUnitsList) < 1 then
			huUnitsList = huBrain:GetListOfUnits((categories.MOBILE * categories.LAND) + (categories.STRUCTURE * categories.DEFENSE), false)
			closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		end
		if table.getn(huUnitsList) < 1 then
			huUnitsList = huBrain:GetListOfUnits(categories.ALLUNITS, false)
			closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		end	
    end
    return closestEnemyUnit
end
GetRandomEnemyLandUnit = function(self) --
    local huBrain = nil
    local closestEnemyUnit = nil
	local enemyUnitList2 = {}
    huBrain = GetRandomCloseAliveEnemyBrain(self)
    if huBrain and not huBrain:IsDefeated() then
        local huUnitsList = huBrain:GetListOfUnits((categories.STRUCTURE * categories.DEFENSE * categories.TECH3 * categories.DIRECTFIRE) + categories.COMMAND + categories.SUBCOMMANDER + categories.EXPERIMENTAL - 
		(categories.EXPERIMENTAL * categories.AIR) - (categories.EXPERIMENTAL * categories.NAVAL) - (categories.EXPERIMENTAL * categories.DEFENSE * categories.ANTIAIR * categories.STRUCTURE), false)
        closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		if table.getn(huUnitsList) < 1 or Random(1, 3) == 1 then
			huUnitsList = huBrain:GetListOfUnits((categories.STRUCTURE * categories.DEFENSE * categories.TECH2 * categories.DIRECTFIRE) + (categories.STRUCTURE * categories.MASSFABRICATION) + (categories.STRUCTURE * categories.FACTORY) +
			(categories.SILO * categories.TECH3) + (categories.STRATEGIC * categories.TECH2) + (categories.STRATEGIC * categories.TECH3) + (categories.STRUCTURE * categories.ENERGYPRODUCTION), false)
			enemyUnitList2 = huBrain:GetListOfUnits(categories.STRUCTURE * categories.MASSEXTRACTION, false)
			for i = 1, table.getn(enemyUnitList2) do
				local aUnit = enemyUnitList2[i]
				if aUnit ~= nil and aUnit:GetCurrentLayer() == "Land" and aUnit:GetCurrentLayer() ~= "Seabed" then
					huUnitsList[table.getn(huUnitsList) + 1] = enemyUnitList2[i]
				end	
			end
			closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		end
		if table.getn(huUnitsList) < 1 then
			huUnitsList = huBrain:GetListOfUnits(categories.MOBILE * categories.LAND, false)
			closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		end
		if table.getn(huUnitsList) < 1 then
			huUnitsList = huBrain:GetListOfUnits(categories.ALLUNITS, false)
			closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		end	
    end
    return closestEnemyUnit
end
GetClosestEnemyLandDefense = function(self, AiUnit) --
    local huBrain = nil
    local closestEnemyUnit = nil
	local enemyUnitList2 = {}
    huBrain = GetClosestEnemyBrainLandDefense(self, AiUnit)
    if huBrain and not huBrain:IsDefeated() then
        local huUnitsList = huBrain:GetListOfUnits((categories.STRUCTURE * categories.DEFENSE * categories.TECH3 * categories.DIRECTFIRE) + (categories.STRUCTURE * categories.DEFENSE * categories.TECH2 * categories.DIRECTFIRE) + 
		(categories.STRUCTURE * categories.DEFENSE * categories.EXPERIMENTAL) + (categories.MOBILE * categories.EXPERIMENTAL * categories.LAND), false)
        closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		if table.getn(huUnitsList) < 1 or Random(1, 3) == 1 then
			huUnitsList = huBrain:GetListOfUnits((categories.STRUCTURE * categories.MASSFABRICATION) + (categories.STRUCTURE * categories.FACTORY) +
			(categories.SILO * categories.TECH3) + (categories.STRATEGIC * categories.TECH2) + (categories.STRATEGIC * categories.TECH3) + (categories.STRUCTURE * categories.ENERGYPRODUCTION), false)
			enemyUnitList2 = huBrain:GetListOfUnits(categories.STRUCTURE * categories.MASSEXTRACTION, false)
			for i = 1, table.getn(enemyUnitList2) do
				local aUnit = enemyUnitList2[i]
				if aUnit ~= nil and aUnit:GetCurrentLayer() == "Land" and aUnit:GetCurrentLayer() ~= "Seabed" then
					huUnitsList[table.getn(huUnitsList) + 1] = enemyUnitList2[i]
				end	
			end
			closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		end
		if table.getn(huUnitsList) < 1 then
			huUnitsList = huBrain:GetListOfUnits(categories.MOBILE * categories.LAND, false)
			closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		end
		if table.getn(huUnitsList) < 1 then
			huUnitsList = huBrain:GetListOfUnits(categories.ALLUNITS, false)
			closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		end	
    end
	if closestEnemyUnit == nil then
		GetRandomEnemyLandUnit(self)
	else	
		return closestEnemyUnit
	end	
end
GetRandomEnemy4LandBossUnit = function(self) --
    local huBrain = nil
    local closestEnemyUnit = nil
    huBrain = GetRandomCloseAliveEnemyBrain(self)
    if huBrain and not huBrain:IsDefeated() then
        local huUnitsList = huBrain:GetListOfUnits((categories.STRUCTURE * categories.DEFENSE * categories.TECH3 * categories.DIRECTFIRE) + categories.COMMAND + categories.SUBCOMMANDER + (categories.SILO * categories.TECH3 * categories.STRUCTURE) + 
		(categories.STRATEGIC * categories.TECH3 * categories.STRUCTURE) + categories.EXPERIMENTAL - (categories.EXPERIMENTAL * categories.AIR) - (categories.EXPERIMENTAL * categories.NAVAL) - (categories.EXPERIMENTAL * categories.DEFENSE * categories.ANTIAIR * categories.STRUCTURE), false)
        closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		if table.getn(huUnitsList) < 1 or Random(1, 3) == 1 then
			huUnitsList = huBrain:GetListOfUnits((categories.STRUCTURE * categories.DEFENSE) + (categories.STRUCTURE * categories.MASSPRODUCTION) + (categories.STRUCTURE * categories.FACTORY) +
			(categories.STRUCTURE * categories.ENERGYPRODUCTION), false)
			closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		end
		if table.getn(huUnitsList) < 1 then
			huUnitsList = huBrain:GetListOfUnits(categories.MOBILE * categories.LAND, false)
			closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		end
		if table.getn(huUnitsList) < 1 then
			huUnitsList = huBrain:GetListOfUnits(categories.ALLUNITS, false)
			closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		end	
    end
    return closestEnemyUnit
end
GetRandomEnemy4AirBossUnit = function(self) --
    local huBrain = nil
    local closestEnemyUnit = nil
    huBrain = GetRandomCloseAliveEnemyBrain(self)
    if huBrain and not huBrain:IsDefeated() then
        local huUnitsList = huBrain:GetListOfUnits((categories.STRUCTURE * categories.DEFENSE * categories.TECH3 * categories.DIRECTFIRE) + categories.COMMAND + categories.SUBCOMMANDER + (categories.SILO * categories.TECH3 * categories.STRUCTURE) + 
		(categories.STRATEGIC * categories.TECH3 * categories.STRUCTURE) + categories.EXPERIMENTAL - (categories.EXPERIMENTAL * categories.DEFENSE * categories.ANTIAIR * categories.STRUCTURE), false)
        closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		if table.getn(huUnitsList) < 1 or Random(1, 3) == 1 then
			huUnitsList = huBrain:GetListOfUnits((categories.STRUCTURE * categories.DEFENSE) + (categories.STRUCTURE * categories.MASSPRODUCTION) + (categories.STRUCTURE * categories.FACTORY) +
			(categories.STRUCTURE * categories.ENERGYPRODUCTION) + categories.NAVAL - (categories.NAVAL * categories.SUBMERSIBLE), false)
			closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		end
		if table.getn(huUnitsList) < 1 then
			huUnitsList = huBrain:GetListOfUnits(categories.MOBILE * categories.LAND, false)
			closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		end
		if table.getn(huUnitsList) < 1 then
			huUnitsList = huBrain:GetListOfUnits(categories.ALLUNITS, false)
			closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		end	
    end
    return closestEnemyUnit
end
GetRandomEnemy4EndGameBossUnit = function(self) --
    local huBrain = nil
    local closestEnemyUnit = nil
	local enemyUnitList2 = {}
    huBrain = GetRandomCloseAliveEnemyBrain(self)
    if huBrain and not huBrain:IsDefeated() then
        local huUnitsList = huBrain:GetListOfUnits((categories.MOBILE * categories.EXPERIMENTAL * categories.STRATEGIC) + (categories.SILO * categories.TECH3  * categories.STRUCTURE) + 
		(categories.STRATEGIC * categories.TECH3 * categories.STRUCTURE) + (categories.EXPERIMENTAL + categories.STRUCTURE + categories.STRATEGIC) + (categories.EXPERIMENTAL + categories.STRUCTURE + categories.ECONOMIC), false)
        closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		if table.getn(huUnitsList) < 1 then
			huUnitsList = huBrain:GetListOfUnits(categories.COMMAND + categories.SUBCOMMANDER + (categories.STRUCTURE * categories.MASSPRODUCTION) + (categories.STRUCTURE * categories.FACTORY) +
			(categories.STRUCTURE * categories.ENERGYPRODUCTION), false)
			enemyUnitList2 = huBrain:GetListOfUnits(categories.STRUCTURE * categories.MASSEXTRACTION, false)
			for i = 1, table.getn(enemyUnitList2) do
				local aUnit = enemyUnitList2[i]
				if aUnit ~= nil and aUnit:GetCurrentLayer() == "Land" and aUnit:GetCurrentLayer() ~= "Seabed" then
					huUnitsList[table.getn(huUnitsList) + 1] = enemyUnitList2[i]
				end	
			end
			closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		end
		if table.getn(huUnitsList) < 1 then
			huUnitsList = huBrain:GetListOfUnits((categories.MOBILE * categories.LAND) + (categories.STRUCTURE * categories.DEFENSE), false)
			closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		end
		if table.getn(huUnitsList) < 1 then
			huUnitsList = huBrain:GetListOfUnits(categories.ALLUNITS, false)
			closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		end	
    end
    return closestEnemyUnit
end
GetRandomEnemy4BomberUnit = function(self) --
    local huBrain = nil
    local closestEnemyUnit = nil
	local enemyUnitList2 = {}
    huBrain = GetRandomCloseAliveEnemyBrain(self)
    if huBrain and not huBrain:IsDefeated() then
        local huUnitsList = huBrain:GetListOfUnits((categories.STRUCTURE * categories.DEFENSE * categories.TECH3 * categories.DIRECTFIRE) + categories.COMMAND + categories.SUBCOMMANDER + 
		(categories.EXPERIMENTAL) + (categories.NAVAL * categories.MOBILE) - (categories.NAVAL * categories.SUBMERSIBLE) - (categories.EXPERIMENTAL * categories.DEFENSE * categories.ANTIAIR * categories.STRUCTURE), false)
        closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		if table.getn(huUnitsList) < 1 or Random(1, 3) == 1 then
			huUnitsList = huBrain:GetListOfUnits((categories.STRUCTURE * categories.DEFENSE * categories.TECH2 * categories.DIRECTFIRE) + (categories.STRUCTURE * categories.MASSFABRICATION) + (categories.STRUCTURE * categories.FACTORY) +
			(categories.SILO * categories.TECH3) + (categories.STRATEGIC * categories.TECH2) + (categories.STRATEGIC * categories.TECH3) + (categories.STRUCTURE * categories.ENERGYPRODUCTION), false)
			enemyUnitList2 = huBrain:GetListOfUnits(categories.STRUCTURE * categories.MASSEXTRACTION, false)
			for i = 1, table.getn(enemyUnitList2) do
				local aUnit = enemyUnitList2[i]
				if aUnit ~= nil and aUnit:GetCurrentLayer() == "Land" and aUnit:GetCurrentLayer() ~= "Seabed" then
					huUnitsList[table.getn(huUnitsList) + 1] = enemyUnitList2[i]
				end	
			end
			closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		end
		if table.getn(huUnitsList) < 1 then
			huUnitsList = huBrain:GetListOfUnits(categories.MOBILE * categories.LAND, false)
			closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		end
		if table.getn(huUnitsList) < 1 then
			huUnitsList = huBrain:GetListOfUnits(categories.ALLUNITS, false)
			closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		end	
    end
    return closestEnemyUnit
end
GetRandomEnemyNavalUnit = function(self) --
    local huBrain = nil
    local closestEnemyUnit = nil
    huBrain = GetRandomCloseAliveEnemyBrain(self)
    if huBrain and not huBrain:IsDefeated() then
        local huUnitsList = huBrain:GetListOfUnits(categories.NAVAL + (categories.STRUCTURE * categories.ANTINAVY), false)
        closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		if table.getn(huUnitsList) < 1 or Random(1, 3) == 1 then
			huUnitsList = huBrain:GetListOfUnits(categories.COMMAND + categories.SUBCOMMANDER + categories.AMPHIBIOUS + categories.HOVER + (categories.STRUCTURE * categories.FACTORY) + (categories.STRUCTURE * categories.MASSPRODUCTION * categories.MASSEXTRACTION) +
			(categories.SILO * categories.TECH3) + (categories.STRATEGIC * categories.TECH2) + (categories.STRATEGIC * categories.TECH3) + (categories.STRUCTURE * categories.ENERGYPRODUCTION), false)
			closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		end
		if table.getn(huUnitsList) < 1 then
			huUnitsList = huBrain:GetListOfUnits(categories.MOBILE * categories.LAND, false)
			closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		end
		if table.getn(huUnitsList) < 1 then
			huUnitsList = huBrain:GetListOfUnits(categories.ALLUNITS, false)
			closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		end	
    end
    return closestEnemyUnit
end
GetActualEnemyNavalUnit = function(self, AiUnit) --
    local huBrain = nil
    local closestEnemyUnit = nil
    huBrain = GetClosestEnemyBrainNaval(self, AiUnit)
    if huBrain and not huBrain:IsDefeated() then
        local huUnitsList = huBrain:GetListOfUnits(categories.NAVAL + (categories.STRUCTURE * categories.ANTINAVY), false)
        closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		if table.getn(huUnitsList) < 1 or Random(1, 3) == 1 then
			huUnitsList = huBrain:GetListOfUnits(categories.COMMAND + categories.SUBCOMMANDER + categories.AMPHIBIOUS + categories.HOVER + (categories.STRUCTURE * categories.FACTORY) + (categories.STRUCTURE * categories.MASSPRODUCTION * categories.MASSEXTRACTION) +
			(categories.SILO * categories.TECH3) + (categories.STRATEGIC * categories.TECH2) + (categories.STRATEGIC * categories.TECH3) + (categories.STRUCTURE * categories.ENERGYPRODUCTION), false)
			closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		end
		if table.getn(huUnitsList) < 1 then
			huUnitsList = huBrain:GetListOfUnits(categories.MOBILE * categories.LAND, false)
			closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		end
		if table.getn(huUnitsList) < 1 then
			huUnitsList = huBrain:GetListOfUnits(categories.ALLUNITS, false)
			closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		end	
    end
    if closestEnemyUnit == nil then
		GetRandomEnemyNavalUnit(self)
	else
		return closestEnemyUnit
	end	
end
GetRandomEnemySubUnit = function(self, AiUnit) --
    local huBrain = nil
    local closestEnemyUnit = nil
    huBrain = GetClosestEnemyBrainNaval(self, AiUnit)
    if huBrain and not huBrain:IsDefeated() then
        local huUnitsList = huBrain:GetListOfUnits((categories.NAVAL * categories.SUBMERSIBLE * categories.MOBILE) + (categories.ANTINAVY * categories.STRUCTURE) + (categories.MASSEXTRACTION * categories.STRUCTURE * categories.MASSPRODUCTION), false)
        closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		if table.getn(huUnitsList) < 1 or Random(1, 3) <= 2 then
			huUnitsList = huBrain:GetListOfUnits(categories.NAVAL + (categories.AMPHIBIOUS * categories.ANTINAVY), false)
			closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		end
		if table.getn(huUnitsList) < 1 then
			huUnitsList = huBrain:GetListOfUnits(categories.MOBILE * categories.LAND, false)
			closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		end
		if table.getn(huUnitsList) < 1 then
			huUnitsList = huBrain:GetListOfUnits(categories.ALLUNITS, false)
			closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		end	
    end
	if closestEnemyUnit == nil then
		GetRandomEnemyNavalUnit(self)
	else
		return closestEnemyUnit
	end	
end
GetRandomEnemyAirUnit = function(self) --
    local huBrain = nil
    local closestEnemyUnit = nil
    huBrain = GetRandomCloseAliveEnemyBrain(self)
    if huBrain and not huBrain:IsDefeated() then
        local huUnitsList = huBrain:GetListOfUnits((categories.AIR * categories.MOBILE), false)
        closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		if table.getn(huUnitsList) < 1 then
			huUnitsList = huBrain:GetListOfUnits(categories.MOBILE, false)
			closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		end
    end
    return closestEnemyUnit
end
GetRandomEnemyAmphibiousUnit = function(self)
    local huBrain = nil
    local closestEnemyUnit = nil
    huBrain = GetRandomCloseAliveEnemyBrain(self)
    if huBrain and not huBrain:IsDefeated() then
        local huUnitsList = huBrain:GetListOfUnits(categories.NAVAL + categories.AMPHIBIOUS, false)
        closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
    end
    return closestEnemyUnit
end
GetRandomCommandUnit = function(self)
	local AllEnemyUnits = {}
    local enemyUnitList = {}
	local EnemyUnit = nil
    for i, brain in humanBrains.HBrains do
        enemyUnitList = brain:GetListOfUnits(categories.COMMAND + categories.SUBCOMMANDER, false)
		for i = 1, table.getn(enemyUnitList) do
			AllEnemyUnits[table.getn(AllEnemyUnits) + 1] = enemyUnitList[i]
		end
    end
	EnemyUnit = AllEnemyUnits[Random(1, table.getn(AllEnemyUnits))]
	return EnemyUnit	
end
GetRandomCommandUnitInWater = function(self)
	local AllEnemyUnits = {}
    local enemyUnitList = {}
	local EnemyUnit = nil
	local aUnit = nil
    for i, brain in humanBrains.HBrains do
        enemyUnitList = brain:GetListOfUnits(categories.COMMAND + categories.SUBCOMMANDER, false)
		for i = 1, table.getn(enemyUnitList) do
			aUnit = enemyUnitList[i]
			if aUnit ~= nil and (aUnit:GetCurrentLayer() == "Sub" or aUnit:GetCurrentLayer() == "Seabed") then
				AllEnemyUnits[table.getn(AllEnemyUnits) + 1] = enemyUnitList[i]
			end	
		end
    end
	if table.getn(AllEnemyUnits) > 0 then
		EnemyUnit = AllEnemyUnits[Random(1, table.getn(AllEnemyUnits))]
	else
		EnemyUnit = GetRandomCommandUnit()
	end	
	return EnemyUnit
end
GetRandomEnemyUnitMobile = function(self)
    local huBrain = nil
    local closestEnemyUnit = nil
    huBrain = GetRandomCloseAliveEnemyBrain(self)
    if huBrain and not huBrain:IsDefeated() then
        local huUnitsList = huBrain:GetListOfUnits(categories.MOBILE + categories.ECONOMIC, false)
        closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
    end
    return closestEnemyUnit
end
GetRandomEnemyEconomy = function(self)
    local huBrain = nil
    local closestEnemyUnit = nil
    huBrain = GetRandomCloseAliveEnemyBrain(self)
    if huBrain and not huBrain:IsDefeated() then
        local huUnitsList = huBrain:GetListOfUnits(categories.ECONOMIC * categories.MASSPRODUCTION * categories.STRUCTURE, false)
        closestEnemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
    end
    return closestEnemyUnit
end
GetClosestEnemyUnitToAnotherEnemyUnitLand = function(self, otherUnit, otherBrain)
    local closestEnemyUnit = nil
    local closestDistance = 100000000 
    for i, brain in humanBrains.HBrains do
        local huBrain = GetClosestEnemyBrainLand(self, otherUnit)
        if huBrain and not huBrain:IsDefeated() and huBrain ~= otherBrain then
            brain = huBrain
        end
        WaitTicks(5)
        if brain and not brain:IsDefeated() then
            local huUnitsList = brain:GetListOfUnits((categories.STRUCTURE - categories.NAVAL - categories.SONAR - categories.ANTINAVY - categories.WALL) + categories.COMMAND + categories.SUBCOMMANDER, false)
            for i, huUnit in huUnitsList do
                if otherUnit and not otherUnit:BeenDestroyed() then
                    if huUnit and not huUnit:BeenDestroyed() then
                        local huPosX, huPosY, huPosZ = huUnit:GetPositionXYZ()
                        local aiPosX, aiPosY, aiPosZ = otherUnit:GetPositionXYZ()
                        if VDist2Sq(huPosX, huPosZ, aiPosX, aiPosZ) < closestDistance then
                            closestDistance = VDist2Sq(huPosX, huPosZ, aiPosX, aiPosZ)
                            closestEnemyUnit = huUnit
                        end
                    end
                else
                    break
                end
            end
            break
        end
    end
    return closestEnemyUnit
end
GetClosestEnemyUnitToAnotherEnemyUnitAir = function(self, otherUnit, otherBrain)
    local closestEnemyUnit = nil
    local closestDistance = 100000000 
    for i, brain in humanBrains.HBrains do
        local huBrain = GetClosestEnemyBrainAir(self, otherUnit)
        if huBrain and not huBrain:IsDefeated() and huBrain ~= otherBrain then
            brain = huBrain
        end
        WaitTicks(5)
        if brain and not brain:IsDefeated() then
            local huUnitsList = brain:GetListOfUnits((categories.MOBILE * categories.AIR), false)
            for i, huUnit in huUnitsList do
                if otherUnit and not otherUnit:BeenDestroyed() then
                    if huUnit and not huUnit:BeenDestroyed() then
                        local huPosX, huPosY, huPosZ = huUnit:GetPositionXYZ()
                        local aiPosX, aiPosY, aiPosZ = otherUnit:GetPositionXYZ()
                        if VDist2Sq(huPosX, huPosZ, aiPosX, aiPosZ) < closestDistance then
                            closestDistance = VDist2Sq(huPosX, huPosZ, aiPosX, aiPosZ)
                            closestEnemyUnit = huUnit
                        end
                    end
                else
                    break
                end
            end
            break
        end
    end
    return closestEnemyUnit
end
GetClosestEnemyUnitToAnotherEnemyUnitNaval = function(self, otherUnit, otherBrain)
    local closestEnemyUnit = nil
    local closestDistance = 100000000 
    for i, brain in humanBrains.HBrains do
        local huBrain = GetClosestEnemyBrainNaval(self, otherUnit)
        if huBrain and not huBrain:IsDefeated() and huBrain ~= otherBrain then
            brain = huBrain
        end
        WaitTicks(5)
        if brain and not brain:IsDefeated() then
            local huUnitsList = brain:GetListOfUnits((categories.MOBILE * categories.NAVAL) + (categories.STRUCTURE * categories.AMPHIBIOUS) + (categories.STRUCTURE * categories.NAVAL), false)
            for i, huUnit in huUnitsList do
                if otherUnit and not otherUnit:BeenDestroyed() then
                    if huUnit and not huUnit:BeenDestroyed() then
                        local huPosX, huPosY, huPosZ = huUnit:GetPositionXYZ()
                        local aiPosX, aiPosY, aiPosZ = otherUnit:GetPositionXYZ()
                        if VDist2Sq(huPosX, huPosZ, aiPosX, aiPosZ) < closestDistance then
                            closestDistance = VDist2Sq(huPosX, huPosZ, aiPosX, aiPosZ)
                            closestEnemyUnit = huUnit
                        end
                    end
                else
                    break
                end
            end
            break
        end
    end
    return closestEnemyUnit
end
GetClosestEnemyUnitOfWeakestEnemyBrain = function(self, AiUnit)
    local closestEnemyUnit = nil
    local closestDistance = 100000000 
    for i, brain in humanBrains.HBrains do
        local huBrain = GetWeakestEnemyBrain(self, AiUnit)
        if huBrain and not huBrain:IsDefeated() then
            brain = huBrain
        end
        WaitTicks(5)
        if brain and not brain:IsDefeated() then
            local huUnitsList = brain:GetListOfUnits((categories.STRUCTURE - categories.NAVAL - categories.SONAR - categories.ANTINAVY - categories.WALL) + categories.COMMAND, false)
            for i, huUnit in huUnitsList do
                if AiUnit and not AiUnit:BeenDestroyed() then
                    if huUnit and not huUnit:BeenDestroyed() then
                        local huPosX, huPosY, huPosZ = huUnit:GetPositionXYZ()
                        local aiPosX, aiPosY, aiPosZ = AiUnit:GetPositionXYZ()
                        if VDist2Sq(huPosX, huPosZ, aiPosX, aiPosZ) < closestDistance then
                            closestDistance = VDist2Sq(huPosX, huPosZ, aiPosX, aiPosZ)
                            closestEnemyUnit = huUnit
                        end
                    end
                else
                    break
                end
            end
            break
        end
    end
    return closestEnemyUnit
end
GetClosestEnemyBrainLand = function(self, AiUnit)
	local AiUnit
    local ClosestEnemyBrain = nil
    local closestDistance = 100000000 
    for i, brain in humanBrains.HBrains do
        local enemyUnitList = brain:GetListOfUnits(categories.STRUCTURE + (categories.MOBILE * categories.LAND), false)
        WaitTicks(5)
        if AiUnit and not AiUnit:BeenDestroyed() then
            if brain and not brain:IsDefeated() and table.getn(enemyUnitList) > 0 then
                local huPosX, huPosZ = brain:GetArmyStartPos()
                local aiPosX, aiPosY, aiPosZ = AiUnit:GetPositionXYZ()
                if VDist2Sq(huPosX, huPosZ, aiPosX, aiPosZ) < closestDistance then
                    closestDistance = VDist2Sq(huPosX, huPosZ, aiPosX, aiPosZ)
                    ClosestEnemyBrain = brain
                end
            end
        else
            break
        end
    end
    return ClosestEnemyBrain
end
GetClosestEnemyBrainLandDefense = function(self, AiUnit)
    local ClosestEnemyBrain = nil
    local closestDistance = 100000000 
    for i, brain in humanBrains.HBrains do
        local enemyUnitList = brain:GetListOfUnits((categories.STRUCTURE * categories.DEFENSE * categories.TECH3 * categories.DIRECTFIRE) + (categories.STRUCTURE * categories.DEFENSE * categories.TECH2 * categories.DIRECTFIRE) + 
		(categories.STRUCTURE * categories.DEFENSE * categories.EXPERIMENTAL) + (categories.MOBILE * categories.EXPERIMENTAL * categories.LAND), false)
        WaitTicks(5)
        if AiUnit and not AiUnit:BeenDestroyed() then
            if brain and not brain:IsDefeated() and table.getn(enemyUnitList) > 0 then
                local huPosX, huPosZ = brain:GetArmyStartPos()
                local aiPosX, aiPosY, aiPosZ = AiUnit:GetPositionXYZ()
                if VDist2Sq(huPosX, huPosZ, aiPosX, aiPosZ) < closestDistance then
                    closestDistance = VDist2Sq(huPosX, huPosZ, aiPosX, aiPosZ)
                    ClosestEnemyBrain = brain
                end
            end
        else
            break
        end
    end
    return ClosestEnemyBrain
end
GetClosestEnemyBrainAir = function(self, AiUnit)
    local ClosestEnemyBrain = nil
    local closestDistance = 100000000 
    for i, brain in humanBrains.HBrains do
        local enemyUnitList = brain:GetListOfUnits((categories.MOBILE * categories.AIR), false)
        WaitTicks(5)
        if AiUnit and not AiUnit:BeenDestroyed() then
            if brain and not brain:IsDefeated() and table.getn(enemyUnitList) > 0 then
                local huPosX, huPosZ = brain:GetArmyStartPos()
                local aiPosX, aiPosY, aiPosZ = AiUnit:GetPositionXYZ()
                if VDist2Sq(huPosX, huPosZ, aiPosX, aiPosZ) < closestDistance then
                    closestDistance = VDist2Sq(huPosX, huPosZ, aiPosX, aiPosZ)
                    ClosestEnemyBrain = brain
                end
            end
        else
            break
        end
    end
    return ClosestEnemyBrain
end
GetClosestEnemyBrainNaval = function(self, AiUnit)
    local ClosestEnemyBrain = nil
    local closestDistance = 100000000 
    for i, brain in humanBrains.HBrains do
        local enemyUnitList = brain:GetListOfUnits((categories.MOBILE * categories.NAVAL) + (categories.STRUCTURE * categories.ANTINAVY) + (categories.STRUCTURE * categories.NAVAL), false)
        WaitTicks(5)
        if AiUnit and not AiUnit:BeenDestroyed() then
            if brain and not brain:IsDefeated() and table.getn(enemyUnitList) > 0 then
                local huPosX, huPosZ = brain:GetArmyStartPos()
                local aiPosX, aiPosY, aiPosZ = AiUnit:GetPositionXYZ()
                if VDist2Sq(huPosX, huPosZ, aiPosX, aiPosZ) < closestDistance then
                    closestDistance = VDist2Sq(huPosX, huPosZ, aiPosX, aiPosZ)
                    ClosestEnemyBrain = brain
                end
            end
        else
            break
        end
    end
    return ClosestEnemyBrain
end
GetRandomCloseAliveEnemyBrain = function(self)
    local ClosestEnemyBrain = nil
    local randomEnemyBrains = { RBrains = {} }
    for i, brain in closestEnemyBrains.CBrains do
        if brain and not brain:IsDefeated() then
            ClosestEnemyBrain = brain
            table.insert(randomEnemyBrains.RBrains, brain)
			--TBrains = TBrains + 1
        end
    end
    local aliveBrainsCount = table.getn(randomEnemyBrains.RBrains)
    if aliveBrainsCount > 0 then
        ClosestEnemyBrain = (randomEnemyBrains.RBrains)[Random(1, aliveBrainsCount)]
        --[[if aliveBrainsCount >= 2 and Random(1, 3) == 1 then
            ClosestEnemyBrain = (randomEnemyBrains.RBrains)[2]
        end
        if aliveBrainsCount >= 3 and Random(1, 3) == 1 then
            ClosestEnemyBrain = (randomEnemyBrains.RBrains)[3]
        end
        if aliveBrainsCount >= 4 and Random(1, 2) == 1 then
            ClosestEnemyBrain = (randomEnemyBrains.RBrains)[4]
        end
        if aliveBrainsCount >= 5 and Random(1, 2) == 1 then
            ClosestEnemyBrain = (randomEnemyBrains.RBrains)[5]
        end]]--
    end
    return ClosestEnemyBrain
end
GetClosestAlliedBrain = function(self, allyBrain)
    local ClosestAlliedBrain = nil
    local closestDistance = 100000000 
    for i, brain in humanBrains.HBrains do
        if allyBrain ~= nil and allyBrain ~= brain then
            if brain and not brain:IsDefeated() then
                local huPosX, huPosZ = brain:GetArmyStartPos()
                local aiPosX, aiPosZ = allyBrain:GetArmyStartPos()
                if VDist2Sq(huPosX, huPosZ, aiPosX, aiPosZ) < closestDistance then
                    closestDistance = VDist2Sq(huPosX, huPosZ, aiPosX, aiPosZ)
                    ClosestAlliedBrain = brain
                end
            end
        else
            break
        end
    end
    return ClosestAlliedBrain
end
GetWeakestEnemyBrain = function(self, AiUnit)
    local WeakestEnemyBrain = nil
    local WeakestEnemyUnitsNum = 100000000 
    for i, brain in humanBrains.HBrains do
        local enemyUnitList = brain:GetListOfUnits((categories.STRUCTURE * categories.DEFENSE) + (categories.MOBILE * categories.LAND), false)
        WaitTicks(5)
        if AiUnit and not AiUnit:BeenDestroyed() then
            if brain and not brain:IsDefeated() and table.getn(enemyUnitList) < WeakestEnemyUnitsNum then
                WeakestEnemyUnitsNum = table.getn(enemyUnitList)
                WeakestEnemyBrain = brain
            end
        else
            break
        end
    end
    return WeakestEnemyBrain
end
function MonitoringTeamElimination()
    local circle = ForkThread(function(self)
		WaitSeconds(10)
		PrintText("==Versus Survival is ON. Requires 3+ Teams or 3+ FFA.==", 28, 'ffCC0000', 6, 'center')
        repeat
			WaitSeconds(10)
			local HQEnemies = 0
			for i, brain in humanBrains.HBrains do
				if brain and not brain:IsDefeated() then
					currentBrain = brain
					for i, brain in humanBrains.HBrains do
						if not IsAlly(brain:GetArmyIndex(), currentBrain:GetArmyIndex()) and brain ~= currentBrain and not brain:IsDefeated() then
							HQEnemies = HQEnemies + 1
						end
					end	
				end
			end
			if GetGameTimeSeconds() < WavesStartTimeAI and HQEnemies == 0 then
				PrintText("==ERROR: Versus Survival requires a minimum of 3 Teams or 3 FFA==", 28, 'ffCC0000', 180, 'center')
				PrintText("In Versus Survival, HQ Team suicides when only one other Team is left standing.", 28, 'ffCC0000', 180, 'center')
				PrintText("Turn Off Versus Survival under WIN/LOSE/VERSUS or set 3 or more Teams.", 28, 'ffCC0000', 180, 'center')
				PrintText("NOTE: Multi-Team Survival can be played with Versus Survival Off.", 26, 'ffff9393', 180, 'center')
				PrintText("Requires last Team standing to Kill HQ to win.", 26, 'ffff9393', 180, 'center')
			end	
			--PrintText("Enemy in Game " .. HQEnemies .. " Total", 28, 'ffCBFFFF', 2, 'center')
			if HQEnemies == 0 then
				ClearAIAllUnits()
			end
        until GetGameTimeSeconds() > 20000
    end)
end
function MonitoringPlayerUnits()
    local circle = ForkThread(function(self)
        repeat
            WaitTicks(30)
            for i, brain in humanBrains.HBrains do
                WaitTicks(10)
                if brain and not brain:IsDefeated() and (humanACUs.HACUs[i] == nil or (humanACUs.HACUs[i] and humanACUs.HACUs[i]:BeenDestroyed()))
                    and table.getn(brain:GetListOfUnits((categories.STRUCTURE * categories.FACTORY) + (categories.MOBILE * categories.ENGINEER), false)) == 0 then
                    local playerUnitList = brain:GetListOfUnits(categories.ALLUNITS, false)
                    for i, pUnit in playerUnitList do
                        if pUnit and not pUnit:BeenDestroyed() then
                            pUnit:Kill()
                        end
                    end
                end
            end
        until GetGameTimeSeconds() > 20000
    end)
end
function MonitoringHQAlliesSupremecy()
    local circle = ForkThread(function(self)
        repeat
            WaitTicks(30)
            for i, brain in allyBrainsHQ.ABrainsHQ do
                WaitTicks(10)
                if brain and not brain:IsDefeated() and (allyHQACU.AllyACUs[i] == nil or (allyHQACU.AllyACUs[i] and allyHQACU.AllyACUs[i]:BeenDestroyed()))
                    and table.getn(brain:GetListOfUnits((categories.STRUCTURE * categories.FACTORY) + (categories.MOBILE * categories.ENGINEER), false)) == 0 then
                    local playerUnitList = brain:GetListOfUnits(categories.ALLUNITS, false)
                    for i, pUnit in playerUnitList do
                        if pUnit and not pUnit:BeenDestroyed() then
                            pUnit:Kill()
                        end
                    end
                end
            end
        until GetGameTimeSeconds() > 20000
    end)
end
function MonitoringPlayerUnitsAssassinate()
    local circle = ForkThread(function(self)
        repeat
            WaitTicks(30)
            for i, brain in humanBrains.HBrains do
                WaitTicks(10)
                if brain and not brain:IsDefeated() and (humanACUs.HACUs[i] == nil or (humanACUs.HACUs[i] and humanACUs.HACUs[i]:BeenDestroyed())) then
                    local playerUnitList = brain:GetListOfUnits(categories.ALLUNITS, false)
                    for i, pUnit in playerUnitList do
                        if pUnit and not pUnit:BeenDestroyed() then
                            pUnit:Kill()
                        end
                    end
                end
            end
        until GetGameTimeSeconds() > 20000
    end)
end
function MonitoringHQAlliesAssassinate()
    local circle = ForkThread(function(self)
        repeat
            WaitTicks(30)
            for i, brain in allyBrainsHQ.ABrainsHQ do
                WaitTicks(10)
                if brain and not brain:IsDefeated() and (allyHQACU.AllyACUs[i] == nil or (allyHQACU.AllyACUs[i] and allyHQACU.AllyACUs[i]:BeenDestroyed())) then
                    local playerUnitList = brain:GetListOfUnits(categories.ALLUNITS, false)
                    for i, pUnit in playerUnitList do
                        if pUnit and not pUnit:BeenDestroyed() then
                            pUnit:Kill()
                        end
                    end
                end
            end
        until GetGameTimeSeconds() > 20000
    end)
end
function MonitoringHQAlliesAllACUsAssassin() -- Kills all HQ Allies if all their ACU's dead
    --local circle = ForkThread(function(self)
		--local humanACUalive = { aHACUs = {} }
		--local ACUcount = 0
		--if GetGameTimeSeconds() > WavesStartTimeAI then
				local AllEnemyUnits2 = {}
				local enemyUnitList2 = {}
				for i, brain in allyBrainsHQ.ABrainsHQ do
					if brain and not brain:IsDefeated() then
						enemyUnitList2 = brain:GetListOfUnits(categories.COMMAND, false)
						for i = 1, table.getn(enemyUnitList2) do
							AllEnemyUnits2[table.getn(AllEnemyUnits2) + 1] = enemyUnitList2[i]
						end
					end
				end
				--[[for i, brain in humanBrains.HBrains do
					WaitTicks(5)
					if brain and not brain:IsDefeated() then
						table.insert(humanACUalive.aHACUs, brain:GetListOfUnits(categories.COMMAND, false)[1])
					end	
				end]]--
				--ACUcount = table.getn(humanACUalive.HACUs)
				--PrintText("HQ ACU AlliesCount " .. table.getn(AllEnemyUnits2) .. " Total", 28, 'ffCBFFFF', 2, 'center')
				if table.getn(AllEnemyUnits2) == 0 then
					lost = true
					ClearAllHQTeamUnits()
				end
		--end	
    --end)
end
function MonitoringAllHQEnemyACUs() -- Kills All non HQ Players if all ACUS dead
    --local circle = ForkThread(function(self)
		--local humanACUalive = { aHACUs = {} }
		--local ACUcount = 0
		--if GetGameTimeSeconds() > WavesStartTimeAI then
				local AllEnemyUnits3 = {}
				local enemyUnitList3 = {}
				for i, brain in humanBrains.HBrains do
					if brain and not brain:IsDefeated() then
						enemyUnitList3 = brain:GetListOfUnits(categories.COMMAND, false)
						for i = 1, table.getn(enemyUnitList3) do
							AllEnemyUnits3[table.getn(AllEnemyUnits3) + 1] = enemyUnitList3[i]
						end
					end
				end
				--[[for i, brain in humanBrains.HBrains do
					WaitTicks(5)
					if brain and not brain:IsDefeated() then
						table.insert(humanACUalive.aHACUs, brain:GetListOfUnits(categories.COMMAND, false)[1])
					end	
				end]]--
				--ACUcount = table.getn(humanACUalive.HACUs)
				--PrintText("ACU Count " .. table.getn(AllEnemyUnits3) .. " Total", 28, 'ffCBFFFF', 2, 'center')
				if table.getn(AllEnemyUnits3) == 0 then
					lost = true
					ClearAllNonHQTeamUnits()
				end
		--end	
    --end)
end
function HQAlliesACUecoBoost()
    --local circle = ForkThread(function(self)
		local HQTeamsACUs = {}
		local HQPlayerACUs = {}
		--if HumanEcoBoost > 0 then
			--repeat
				WaitTicks(20)
				--[[for i, brain in humanBrains.HBrains do
					table.insert(humanACUeco, brain:GetListOfUnits(categories.COMMAND, false)[1])
					WaitTicks(10)
					local acuUnit = humanACUeco[i]
					LOG("checking human acu")
					acuUnit:SetProductionPerSecondEnergy(HumanEcoBoost * 100)
					acuUnit:SetProductionPerSecondMass(HumanEcoBoost)
				end]]--
				for i, brain in allyBrainsHQ.ABrainsHQ do
					HQPlayerACUs = brain:GetListOfUnits(categories.COMMAND, false)
					for i = 1, table.getn(HQPlayerACUs) do
						HQTeamsACUs[table.getn(HQTeamsACUs) + 1] = HQPlayerACUs[i]
						local acuUnit = HQPlayerACUs[i]
						acuUnit:SetProductionPerSecondEnergy(HQAllyEcoBoost * 75)
						acuUnit:SetProductionPerSecondMass(HQAllyEcoBoost)
					end
				end
				--HQAlliesACUecoBoostflag = true
				--PrintText("ACU Eco Count " .. table.getn(HQTeamsACUs) .. " Total", 28, 'ffCBFFFF', 2, 'center')
				
				--[[if EndGameEcoBoost > 0 and GetGameTimeSeconds() > (WavesStartTimeAI + HoldTimeAI - EndEcoBoostTime) then
					break
				end	]]--
			--until GetGameTimeSeconds() > 20000
		--end	
    --end)
end	
function MonitoringPlayersACU()
    --local circle = ForkThread(function(self)
		local AllTeamsACUs = {}
		local PlayerACUs = {}
		--if HumanEcoBoost > 0 then
			--repeat
				WaitTicks(20)
				--[[for i, brain in humanBrains.HBrains do
					table.insert(humanACUeco, brain:GetListOfUnits(categories.COMMAND, false)[1])
					WaitTicks(10)
					local acuUnit = humanACUeco[i]
					LOG("checking human acu")
					acuUnit:SetProductionPerSecondEnergy(HumanEcoBoost * 100)
					acuUnit:SetProductionPerSecondMass(HumanEcoBoost)
				end]]--
				for i, brain in humanBrains.HBrains do
					if brain and not brain:IsDefeated() then
						PlayerACUs = brain:GetListOfUnits(categories.COMMAND, false)
						for i = 1, table.getn(PlayerACUs) do
							AllTeamsACUs[table.getn(AllTeamsACUs) + 1] = PlayerACUs[i]
							local acuUnit = PlayerACUs[i]
							acuUnit:SetProductionPerSecondEnergy(HumanEcoBoost * 75)
							acuUnit:SetProductionPerSecondMass(HumanEcoBoost)
						end
					end	
				end
				--PrintText("ACU Eco Count " .. table.getn(AllTeamsACUs) .. " Total", 28, 'ffCBFFFF', 2, 'center')
				
				--[[if EndGameEcoBoost > 0 and GetGameTimeSeconds() > (WavesStartTimeAI + HoldTimeAI - EndEcoBoostTime) then
					break
				end	]]--
			--until GetGameTimeSeconds() > 20000
		--end	
    --end)
end
function PlayersACUEndGameEcoBoost()
    --local circle = ForkThread(function(self)
		local AllTeamsACUs2 = {}
		local PlayerACUs2 = {}
			--repeat
				WaitTicks(20)
				--if GetGameTimeSeconds() > (WavesStartTimeAI + HoldTimeAI - EndEcoBoostTime) then
				for i, brain in humanBrains.HBrains do
					if brain and not brain:IsDefeated() then
						PlayerACUs2 = brain:GetListOfUnits(categories.COMMAND, false)
						for i = 1, table.getn(PlayerACUs2) do
							AllTeamsACUs2[table.getn(AllTeamsACUs2) + 1] = PlayerACUs2[i]
							local acuUnit = PlayerACUs2[i]
							acuUnit:SetProductionPerSecondEnergy(EndGameEcoBoost * 75)
							acuUnit:SetProductionPerSecondMass(EndGameEcoBoost)
						end
					end	
				end
				--end	
			--until GetGameTimeSeconds() > 20000
    --end)
end
function ACUTorpHunters() -- Deploys Killer Torp Bombers if Hold To Win is On
    local circle = ForkThread(function(self)
		repeat
		if GetGameTimeSeconds() >= (WavesStartTimeAI + HoldTimeAI + EndGameHoldTime - TorpBomberStartTime) then
			local AllTeamsACUs = {}
			local PlayerACUs = {}
			local AllTeamsSACUs = {}
			local PlayerSACUs = {}
			local acuUnit = nil
			local sacuUnit = nil
			local acuWaterCount = 0
			local sacuWaterCount = 0
			local TotalInWater = 0
					WaitTicks(20)
					for i, brain in humanBrains.HBrains do
						if brain and not brain:IsDefeated() then
							PlayerACUs = brain:GetListOfUnits(categories.COMMAND, false)
							PlayerSACUs = brain:GetListOfUnits(categories.SUBCOMMANDER, false)
							for i = 1, table.getn(PlayerACUs) do
								AllTeamsACUs[table.getn(AllTeamsACUs) + 1] = PlayerACUs[i]
							end
							for i = 1, table.getn(PlayerSACUs) do
								AllTeamsSACUs[table.getn(AllTeamsSACUs) + 1] = PlayerSACUs[i]
							end
						end
					end
					for i = 1, table.getn(AllTeamsACUs) do
						acuUnit = AllTeamsACUs[i]
						if acuUnit ~= nil and (acuUnit:GetCurrentLayer() == "Sub" or acuUnit:GetCurrentLayer() == "Seabed") then
							acuWaterCount = acuWaterCount + 1
						end
					end	
					for i = 1, table.getn(AllTeamsSACUs) do
						sacuUnit = AllTeamsSACUs[i]
						if sacuUnit ~= nil and (sacuUnit:GetCurrentLayer() == "Sub" or sacuUnit:GetCurrentLayer() == "Seabed") then
							sacuWaterCount = sacuWaterCount + 1
						end
					end	
					
					TotalInWater = acuWaterCount * 2 + math.floor(sacuWaterCount * 0.5 + 0.55)
					if TotalInWater > 0 then
					PrintText("Commander Hunter/Killer Torp Bombers Active!", 30, 'ffCBFFFF', 4, 'center')
					PrintText("==Get Commanders and SACUs out of Water!==", 24, 'ffC71C1C', 4, 'center')
						repeat
							CreateABomberAroundMainBuildingForAI("ETB0306")
							TotalInWater = TotalInWater - 1
						until TotalInWater < 1
					end	
					--PrintText("ACUs in Water " .. TotalInWater .. " Total", 28, 'ffCBFFFF', 2, 'center')
		end	
		WaitSeconds(120)
		until GetGameTimeSeconds() > 20000 or won == true
    end)
end
function ACUHunterSpawn()
    local circle = ForkThread(function(self)
        repeat
            WaitSeconds(10)
			if ((GetGameTimeSeconds() - WavesStartTimeAI) / HoldTimeAI) >= ACUHunterTimeNumber then
				local totalSACUs = CalculateTotalSACUs()
				local ACUHunterCount = math.floor(humans * 1.5 + 0.5) + math.floor(math.floor(totalSACUs * 0.2 + 0.5) * ACUHunterSize + 0.5)
				if (GetGameTimeSeconds() - WavesStartTimeAI) >= HoldTimeAI then
					local AliveACUs = CalculateTotalACUs()
					ACUHunterCount = math.floor(humans * 1.5 + 0.5) + math.floor((math.floor(totalSACUs * 0.25 + 0.5) + AliveACUs) * ACUHunterSize + 0.5)
				end	
				repeat
					CreatACUHunterUnit("CHU0305")
					ACUHunterCount = ACUHunterCount - 1
					WaitTicks(5)
				until ACUHunterCount < 1
				WaitSeconds(DelayUntilNextWaveAI - 10)
			end	
        until GetGameTimeSeconds() > 20000 or won == true
    end)
end
function MonitoringPlayersAcuUnderWater() --disabled
    local circle = ForkThread(function(self)
        repeat
            WaitTicks(30)
            if GetGameTimeSeconds() > (WavesStartTimeAI + HoldTimeAI + EndGameHoldTime - 240) then 
                for i, brain in humanBrains.HBrains do
                    WaitTicks(10)
                    local acuUnit = humanACUs.HACUs[i]
					local playerUnitList = brain:GetListOfUnits(categories.SUBCOMMANDER + categories.COMMAND, false)
					local aUnit = playerUnitList[Random(1, table.getn(playerUnitList))]
                    if brain and not brain:IsDefeated() then
                        if acuUnit:GetCurrentLayer() == "Sub" or acuUnit:GetCurrentLayer() == "Seabed" then
						--or aUnit:GetCurrentLayer() == "Sub" or aUnit:GetCurrentLayer() == "Seabed" then
                            local torpsAmount = humans * 2
							PrintText("Commander Hunter/Killer Torp Bombers Active!", 30, 'c71c1c', 4, 'center')
                            --[[AIMessageTo('ACU Hunter/Killer Torp Bombers Active!', brain)]]--
							repeat
                                CreateABomberAroundMainBuildingForAI("ETB0306")
                                torpsAmount = torpsAmount - 1
                            until torpsAmount < 1
							WaitSeconds(60)
                        end
                    end
				 --break	
                end
            end
        until GetGameTimeSeconds() > 20000
    end)
end
CalculateEnemyMass = function(self)
    lastmass = totalmass
	totalmass = 0
	local currentmassproduction = 0
	local paragonmass = 0
    for i, brain in humanBrains.HBrains do
        if brain and not brain:IsDefeated() then
			paragonmass = CalculateTotalEnemyParagons()
			totalmass = totalmass + brain:GetArmyStat("Economy_TotalProduced_Mass", 0.0).Value
			if paragonmass == 1 and paragontimerflag == false then
				paragontimebreak = GetGameTimeSeconds() + 320
				paragontimerflag = true
			end
			if GetGameTimeSeconds() < paragontimebreak and paragonmass == 1 then
				if (totalmass - lastmass) < 0 then
					currentmassproduction = ((lastmass - totalmass) / 60)
				else
					currentmassproduction = ((totalmass - lastmass) / 60)
				end
			elseif paragonmass > 1 then
				if (totalmass - lastmass) < 0 then
					currentmassproduction = ((lastmass - totalmass) / 60) + (paragonmass * 10000)
				else
					currentmassproduction = ((totalmass - lastmass) / 60)  + (paragonmass * 10000)
				end
			else
				if (totalmass - lastmass) < 0 then
					currentmassproduction = ((lastmass - totalmass) / 60) + (paragonmass * 10000)
				else
					currentmassproduction = ((totalmass - lastmass) / 60)  + (paragonmass * 10000)
				end
			end	
			--totalmass = totalmass + brain:GetEconomyIncome('MASS')
            --totalmass = totalmass + brain:GetArmyStat("Economy_TotalProduced_Mass", 0.0).Value 
			--CAiBrain:GetEconomyIncome(MASS)
        end
    end
    return currentmassproduction
end
function MonitoringFunctionTwo()
	local Army
	local circle = ForkThread(function(self)
		repeat
			WaitSeconds(60)
			--CalculateEnemyLevel()
			--totalAINukeSubs = CalculateTotalAINukeSubs()
			if GetGameTimeSeconds() > (WavesStartTimeAI - 20 + HoldTimeAI * 0.7) and ParagonFlag == false then
				for i, Army in ListArmies() do
					if EndGameParagon == "Paragon Midgame" then
						RemoveBuildRestriction(Army, categories.xab1401)	--para
					end
					if EndGameYolo == "Yolona Midgame" then
						RemoveBuildRestriction(Army, categories.xsb2401)    --yolona
					end
				end
				if EndGameYolo == "Yolona Midgame" and EndGameParagon == "Paragon Midgame" then
					PrintText("Paragon and Yolona Available", 30, 'ffCBFFFF', 4, 'center')
					elseif EndGameYolo == "Yolona Midgame" then
					PrintText("Yolona Available", 30, 'ffCBFFFF', 4, 'center')
					elseif EndGameParagon == "Paragon Midgame" then
					PrintText("Paragon Available", 30, 'ffCBFFFF', 4, 'center')
				end
				WaitSeconds(1)
				if EndGameYolo == "Yolona Midgame" or EndGameParagon == "Paragon Midgame" then
					PrintText("Warning! Building WILL Trigger Attacks and Strengthen Bosses!", 26, 'ffCBFFFF', 4, 'center')
				end
				ParagonFlag = true
			end
			if GetGameTimeSeconds() > (WavesStartTimeAI - 20 + HoldTimeAI * 0.5) and SpecWeapFlag01 == false and
			(SpecialWeapons == "T4 AA Enabled" or SpecialWeapons == "T4AA + EmpTacs Enabled") then
				for i, brain in humanBrains.HBrains do
					Army = brain:GetArmyIndex()
					RemoveBuildRestriction(Army, categories.raa2304)	--AA
				end
				PrintText("Experimental AA Available", 30, 'ffCBFFFF', 4, 'center')
				SpecWeapFlag01 = true
			end
			if GetGameTimeSeconds() > (WavesStartTimeAI - 20 + HoldTimeAI * 0.6) and SpecWeapFlag02 == false and 
			(SpecialWeapons == "EmpTacs Enabled" or SpecialWeapons == "T4AA + EmpTacs Enabled") then
				for i, brain in humanBrains.HBrains do
					Army = brain:GetArmyIndex()
					RemoveBuildRestriction(Army, categories.ram2108)    --Tac
				end
				PrintText("Experimental EMP Tacticle Missiles Available", 30, 'ffCBFFFF', 4, 'center')
				SpecWeapFlag02 = true
			end
			if ArtyNukeEnable ~= "Buildable Arty/Nukes/Sat Disabled" then
				if ArtyNukeEnable ~= "No Restrictions (Buildable Arty/Nukes/Sat)" then
					if SpecWeapFlag03 == false and GetGameTimeSeconds() >= (WavesStartTimeAI - 20 + HoldTimeAI * HoldTimeArtyNukes) then
						EnableArtilleryNukes()
						EnableNomadsArtyNuke()
						PrintText("Artillery, Nukes, Sat, and Strategic Subs Available", 30, 'ffCBFFFF', 4, 'center')
						SpecWeapFlag03 = true
					end	
				end
			end
		until GetGameTimeSeconds() > 20000
	  end)
end		
function MonitoringFunctionThree()
	local circle = ForkThread(function(self)
		repeat
			WaitSeconds(60)
			totalEnemyYolonas = CalculateTotalEnemyYolos() 
			totalEnemyExpDefences = CalculateTotalExpDefences() 
			totalEnemySMDs = CalculateTotalEnemySMDs() 
			totalTthreeRes = CalculateTotalEnemyUnitsOfCategory(self, categories.STRUCTURE * categories.TECH3 * categories.ECONOMIC) 
			totalExpUnits = CalculateTotalEnemyUnitsOfCategory(self, categories.MOBILE * categories.EXPERIMENTAL) 
			totalEnemyT3Defences = CalculateTotalT3Defences() 
			totalEnemyT3AirDefences = CalculateTotalT3AirDefences()
			totalEnemyExpAirDefences = CalculateTotalExpAirDefences()
			totalEnemyT3LandDefences = CalculateTotalT3LandDefences()
			totalEnemyExpShields = CalculateTotalEnemyUnitsOfCategory(self, categories.STRUCTURE * categories.SHIELD * categories.EXPERIMENTAL)
			totalEnemyExpArty = CalculateTotalEnemyUnitsOfCategory(self, categories.STRUCTURE * categories.ARTILLERY * categories.EXPERIMENTAL)
			totalEnemyT3Arty = CalculateTotalEnemyUnitsOfCategory(self, categories.STRUCTURE * categories.ARTILLERY * categories.TECH3)
			totalEnemySatelites = CalculateTotalEnemyUnitsOfCategory(self, categories.STRUCTURE * categories.EXPERIMENTAL * categories.ORBITALSYSTEM)
			--PrintText("Yolos are " .. totalEnemyYolonas .. " !", 28, 'ffCBFFFF', 4, 'center') 
			--PrintText("Tech3 Arty " .. totalEnemyT3Arty .. " !", 28, 'ffCBFFFF', 4, 'center') 
		until GetGameTimeSeconds() > 20000 or won == true
	  end)
end
function MonitoringFunctionFour()
	local circle = ForkThread(function(self)
	local ParagonDetected = false
		repeat
			if ParagonCycle == "Off" then
				break
			end
			WaitSeconds(tonumber(ParagonCycle) * 60)
			totalEnemyParagons = CalculateTotalEnemyParagons()
			if totalEnemyParagons > 0 then
				cyclecount = cyclecount + 1
				if ParagonDetected == false then
					PrintText("Paragon Detected! Hurry, you fools!", 28, 'ffCBFFFF', 4, 'center') 
					ParagonDetected = true
				end	
			end	
			totalEnemyParagons = cyclecount
			if lockedDifficulty == true or totalEnemyParagons > 12 then
				lockedDifficulty = true
				totalEnemyParagons = 12
			end
			--PrintText("Paragon Total " .. totalEnemyParagons .. " !", 28, 'ffCBFFFF', 4, 'center') 
		until GetGameTimeSeconds() > 20000 or won == true
	  end)
end
function MonitoringFunctionFive() -- Damage Bonus
	local circle = ForkThread(function(self)
		repeat
			WaitSeconds(60)
			--PrintText("Total Mass is  " .. totalEnemyMass .. " !", 28, 'ffCBFFFF', 4, 'center') 
			local totalEnemyMass = CalculateEnemyMass()
			if totalEnemyMass > (250 * humans) then
				if damageamplificationflag == false then
					PrintText("Damage Amplification x" .. DamageBoostMulti .. "! Bringing the Pain!", 28, 'ffCBFFFF', 4, 'center') 
					damageamplificationflag = true
				end	
				massDamageBoost = math.floor(totalEnemyMass * 0.0125 * DamageBoostMulti + 0.5)
				massDamageBoostBoss = math.floor(totalEnemyMass * 0.0125 * DamageBoostMulti + 0.5) * 4
			else
				massDamageBoost = 0
				massDamageBoostBoss = 0
			end
			--PrintText("Damage Boost is  " .. massDamageBoost .. " !", 28, 'ffCBFFFF', 4, 'center') 
		until GetGameTimeSeconds() > 20000 or won == true
	  end)
end
function MonitoringFunctionSix() --Air Counter
	local circle = ForkThread(function(self)
		repeat
			WaitSeconds(60)
			totalT3Gunships = CalculateTotalEnemyUnitsOfCategory(self, categories.MOBILE * categories.TECH3 * categories.AIR * categories.GROUNDATTACK) 
			totalExpAir = CalculateTotalEnemyUnitsOfCategory(self, categories.MOBILE * categories.EXPERIMENTAL * categories.AIR) 
			if totalExpAir >= 1 then
				totalExpAir = totalExpAir - 1
			end	
			totalT3Fighters = CalculateTotalEnemyUnitsOfCategory(self, categories.MOBILE * categories.TECH3 * categories.AIR * categories.ANTIAIR * categories.ASF)
			totalT3Bombers = CalculateTotalEnemyUnitsOfCategory(self, categories.MOBILE * categories.TECH3 * categories.AIR * categories.BOMBER)
				--totalAirPower = CalculateTotalEnemyUnitsOfCategory(self, categories.MOBILE * categories.AIR)
			AirPower = math.floor((totalExpAir * 34) + (totalT3Gunships * 2) + (totalT3Fighters * 0.34) + (totalT3Bombers * 1.75) + 0.5)
			totalNomanders = CalculateTotalFriendlyNomanders()
				--PrintText("Total Nomanders are " .. totalNomanders .. " !", 28, 'ffCBFFFF', 4, 'center') 	
		until GetGameTimeSeconds() > 20000 or won == true
	  end)
end
function DeployAntiAir() --Spawns NOMANDERS Counter
	local circle = ForkThread(function(self)
		repeat
			WaitSeconds(60)
			if GetGameTimeSeconds() > (WavesStartTimeAI + (HoldTimeAI * 0.6)) then
				if (AirPower > (46 + (humans * 4)) and totalNomanders < (math.floor(humans * 0.25 + 0.25) + 3)) or (AirPower > (46 + (humans * 4)) and Random(1, 20) == 10) then
					PrintText("ALERT! AntiAir Detected!", 28, 'ffCBFFFF', 4, 'center') 
					AnitAirResponse =  math.floor(math.floor(AirPower * 0.035 + 0.5) * tonumber(ScenarioInfo.Options.NomanderSpawn) + 0.5)
					repeat
						ANTIAIRResponseWave()
						AnitAirResponse = AnitAirResponse - 1
					until AnitAirResponse < 1
				end
				if GetGameTimeSeconds() < (WavesStartTimeAI + HoldTimeAI) then
					WaitSeconds(Random(160, 270))
				else
					WaitSeconds(Random(160, 240))
				end
			end
		until GetGameTimeSeconds() > 20000 or won == true
	end)
end
function CreateRiftTables()
	for id, bp in pairs(__blueprints) do
		if (bp.Categories and string.len(id) >= 5) then
			if table.find(bp.Categories, 'MOBILE') and not table.find(bp.Categories, 'ENGINEER') and not table.find(bp.Categories, 'SCOUT') and not table.find(bp.Categories, 'SATELLITE')
			and not table.find(bp.Categories, 'INSIGNIFICANTUNIT') and not table.find(bp.Categories, 'ANTIAIR') and not table.find(bp.Categories, 'SHIELD')
			and not table.find(bp.Categories, 'INVULNERABLE') and not table.find(bp.Categories, 'UNTARGETABLE') and not table.find(bp.Categories, 'UNSELECTABLE')
			and not table.find(bp.Categories, 'LIGHTDROPCAPSULE') and not table.find(bp.Categories, 'MEDIUMDROPCAPSULE') and not table.find(bp.Categories, 'HEAVYDROPCAPSULE')
			and not table.find(bp.Categories, 'CANTRANSPORTCOMMANDER') then
				if TotalMayhemWaves == "Adjustable T1/T2/T3 Experimentals" then
					if table.find(bp.Categories, 'LAND') then
						--Tech1
						if (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 400) then
							if (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass >= 30) and table.find(bp.Categories, 'TECH1') 
							and (table.find(bp.Categories, 'AMPHIBIOUS') or table.find(bp.Categories, 'HOVER')) and id ~= "uec0001" and id ~= "opc2002" then
								RiftLland = RiftLland + 1
								table.insert(RiftUnitsL.Tech4, id) --Tech1 Units + Garbage
							end	
						end	
						if (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 400) then
							if table.find(bp.Categories, 'TECH1') and (table.find(bp.Categories, 'AMPHIBIOUS') or table.find(bp.Categories, 'HOVER')) and id ~= "uec0001" and id ~= "opc2002" then
								BigRiftLland = BigRiftLland + 1
								table.insert(BigRiftUnitsL.Tech4, id) --Tech1 Units + Garbage
							end	
						end	
						--Tech2
						if (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 1000) then
							if (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass >= 30) and table.find(bp.Categories, 'TECH2') 
							and (table.find(bp.Categories, 'AMPHIBIOUS') or table.find(bp.Categories, 'HOVER')) and id ~= "uec0001" and id ~= "opc2002" then
								RiftMland = RiftMland + 1
								table.insert(RiftUnitsM.Tech4, id) --TECH2 Units + Garbage
							end	
						end
						if (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 1000) then
							if (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass >= 30) and table.find(bp.Categories, 'TECH2') 
							and (table.find(bp.Categories, 'AMPHIBIOUS') or table.find(bp.Categories, 'HOVER')) and id ~= "uec0001" and id ~= "opc2002" then
								BigRiftMland = BigRiftMland + 1
								table.insert(BigRiftUnitsM.Tech4, id) --TECH2 Units + Garbage
							end	
						end
						--Tech3
						if (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass <= 3000) then
							if (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass >= 30) and table.find(bp.Categories, 'TECH3') 
							and (table.find(bp.Categories, 'AMPHIBIOUS') or table.find(bp.Categories, 'HOVER')) and id ~= "uec0001" and id ~= "opc2002" then
								RiftHland = RiftHland + 1
								table.insert(RiftUnitsH.Tech4, id) --TECH3 Units + Garbage
							end
						end
						if (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass > 3000) then
							if (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass >= 30) and table.find(bp.Categories, 'TECH3') 
							and (table.find(bp.Categories, 'AMPHIBIOUS') or table.find(bp.Categories, 'HOVER')) and id ~= "uec0001" and id ~= "opc2002" then
								BigRiftHland = BigRiftHland + 1
								table.insert(BigRiftUnitsH.Tech4, id) --TECH3 Units + Garbage
							end
						end	
					end
				else
					if table.find(bp.Categories, 'LAND') then
					--Tech1
						if (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass >= 30) and table.find(bp.Categories, 'TECH1') 
						and (table.find(bp.Categories, 'AMPHIBIOUS') or table.find(bp.Categories, 'HOVER')) and id ~= "uec0001" and id ~= "opc2002" then
							RiftLland = RiftLland + 1
							table.insert(RiftUnitsL.Tech4, id) --Tech1 Units + Garbage
						end	
					--Tech2
						if (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass >= 30) and table.find(bp.Categories, 'TECH2') 
						and (table.find(bp.Categories, 'AMPHIBIOUS') or table.find(bp.Categories, 'HOVER')) and id ~= "uec0001" and id ~= "opc2002" then
							RiftMland = RiftMland + 1
							table.insert(RiftUnitsM.Tech4, id) --TECH2 Units + Garbage
						end	
					--Tech3
						if (bp.Economy.BuildCostMass and bp.Economy.BuildCostMass >= 30) and table.find(bp.Categories, 'TECH3') 
						and (table.find(bp.Categories, 'AMPHIBIOUS') or table.find(bp.Categories, 'HOVER')) and id ~= "uec0001" and id ~= "opc2002" then
							RiftHland = RiftHland + 1
							table.insert(RiftUnitsH.Tech4, id) --TECH3 Units + Garbage
						end	
					end
				end	
			end
		end
	end					
end
GetRandomizedRiftUnitID = function(self)
    local rspawn = nil
	--local x = nil
	--GameTime = math.floor(GetGameTimeSeconds() - WavesStartTimeAI) / HoldTimeAI

		if RiftLland > 0 and GameTime < (0.1 * WaveProgression) then
			rspawn = (RiftUnitsL.Tech4)[Random(1, RiftLland)]
				if RiftMland > 0 and (JumpTech2 == "Land+Air+Navy" or JumpTech2 == "Land+Air" or JumpTech2 == "Land+Navy" or JumpTech2 == "Land") then
					rspawn = (RiftUnitsM.Tech4)[Random(1, RiftMland)]
				end	
			elseif RiftMland > 0 and GameTime >= (0.1 * WaveProgression) and GameTime < (0.25 * WaveProgression) then
				rspawn = (RiftUnitsM.Tech4)[Random(1, RiftMland)]
				if RiftLland > 0 and Random(1, 3) == 1 and GameTime < (0.15 * WaveProgression) and not (JumpTech2 == "Land+Air+Navy" or JumpTech2 == "Land+Air" or JumpTech2 == "Land+Navy" or JumpTech2 == "Land") then
					rspawn = (RiftUnitsL.Tech4)[Random(1, RiftLland)]
				end	
			elseif RiftHland > 0 and GameTime >= (0.25 * WaveProgression) and GameTime < (0.35 * WaveProgression) then
				rspawn = (RiftUnitsH.Tech4)[Random(1, RiftHland)]
				if RiftMland > 0 and Random(1, 3) == 1 and GameTime < (0.3 * WaveProgression) then
					rspawn = (RiftUnitsM.Tech4)[Random(1, RiftMland)]
				end	
			elseif RiftHland > 0 and GameTime >= (0.35 * WaveProgression) and GameTime < (0.45 * WaveProgression) then
				rspawn = (RiftUnitsH.Tech4)[Random(1, RiftHland)]
				if Eland > 0 and Random(0, 250) <= 10 * ExpMulti --1% 4.4% 8.3% 1.5x
				and (ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Land") then
					rspawn = (landUnitsE.Tech4)[Random(1, Eland)]
				end
			elseif RiftHland > 0 and GameTime >= (0.45 * WaveProgression) and GameTime < (0.55 * WaveProgression) then --15.75 to 22.75
				rspawn = (RiftUnitsH.Tech4)[Random(1, RiftHland)]
				--x = math.floor(7 * WaveProgression + 0.5)
				if Eland > 0 and Random(0, 180) <= 10 * ExpMulti --2% 6% 11.6% 1.8x
				and (ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Land") then
					rspawn = (landUnitsE.Tech4)[Random(1, Eland)]
				end
			elseif RiftHland > 0 and GameTime >= (0.55 * WaveProgression) and GameTime < (0.65 * WaveProgression) then --15.75 to 22.75
				rspawn = (RiftUnitsH.Tech4)[Random(1, RiftHland)]
				--x = math.floor(7 * WaveProgression + 0.5)
				if Eland > 0 and Random(0, 130) <= 10 * ExpMulti --2.8% 15.4% 29.6% 1.8x
				and (ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Land") then
					rspawn = (landUnitsE.Tech4)[Random(1, Eland)]
				end	
			elseif RiftHland > 0 and GameTime >= (0.65 * WaveProgression) and GameTime < (0.77 * WaveProgression) then --22.75 to 29.75
				rspawn = (RiftUnitsH.Tech4)[Random(1, RiftHland)]
				--x = math.floor(3 * WaveProgression + 0.5)
				if Eland > 0 and Random(0, 70) <= 10 * ExpMulti --5% 24% 52% 1.8x
				and (ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Land") then
					rspawn = (landUnitsE.Tech4)[Random(1, Eland)]
				end
			elseif RiftHland > 0 and GameTime >= (0.77 * WaveProgression) and GameTime < (0.9 * WaveProgression) then --22.75 to 29.75
				rspawn = (RiftUnitsH.Tech4)[Random(1, RiftHland)]
				--x = math.floor(3 * WaveProgression + 0.5)
				if Eland > 0 and Random(0, 60) <= 10 * ExpMulti --6.5% 34% 65% 2x
				and (ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Land") then
					rspawn = (landUnitsE.Tech4)[Random(1, Eland)]
				end
				if (MinorBossSpawns == "Land+Air" or MinorBossSpawns == "Land" or MinorBossSpawns == "ExtraLand" or MinorBossSpawns == "ExtraLand+ExtraAir" or MinorBossSpawns == "Land+ExtraAir")
				and Random(0, 200) <= 10 * ExpMulti then --1.1% 6.1% 11.6% +20
					CreateACombinedLandBossUnitAroundMainBuildingForAI()
				end
			elseif RiftHland > 0 and GameTime >= (0.90 * WaveProgression) and GameTime < (1.05 * WaveProgression) then --29.75
				rspawn = (RiftUnitsH.Tech4)[Random(1, RiftHland)]
				--x = math.floor(4 * WaveProgression + 0.5)
				if Eland > 0 and Random(0, 40) <= 10 * ExpMulti --9.1% 50% 95% 2x
				and (ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Land") then
					rspawn = (landUnitsE.Tech4)[Random(1, Eland)]
				end
				--x = math.floor(4 * WaveProgression + 0.5)
				if (MinorBossSpawns == "Land+Air" or MinorBossSpawns == "Land" or MinorBossSpawns == "ExtraLand" or MinorBossSpawns == "ExtraLand+ExtraAir" or MinorBossSpawns == "Land+ExtraAir")
				and Random(0, 120) <= 10 * ExpMulti then --2% 10.9% 20.8% +20
					CreateACombinedLandBossUnitAroundMainBuildingForAI()
				end
			elseif RiftHland > 0 and GameTime >= (1.05 * WaveProgression) and GameTime < (1.2 * WaveProgression) then --29.75
				rspawn = (RiftUnitsH.Tech4)[Random(1, RiftHland)]
				--x = math.floor(4 * WaveProgression + 0.5)
				if Eland > 0 and Random(0, 36) <= 10 * ExpMulti --10% 55% 100% 1.89x
				and (ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Land") then
					rspawn = (landUnitsE.Tech4)[Random(1, Eland)]
				end
				--x = math.floor(4 * WaveProgression + 0.5)
				if (MinorBossSpawns == "Land+Air" or MinorBossSpawns == "Land" or MinorBossSpawns == "ExtraLand" or MinorBossSpawns == "ExtraLand+ExtraAir" or MinorBossSpawns == "Land+ExtraAir")
				and Random(0, 95) <= 10 * ExpMulti then --2.3% 12.8% 24.4% +10
					CreateACombinedLandBossUnitAroundMainBuildingForAI()
				end
			elseif RiftHland > 0 and GameTime >= (1.2 * WaveProgression) and GameTime < (1.35 * WaveProgression) then --29.75
				rspawn = (RiftUnitsH.Tech4)[Random(1, RiftHland)]
				--x = math.floor(4 * WaveProgression + 0.5)
				if Eland > 0 and Random(0, 25) <= 10 * ExpMulti --11.1% 61% 100% 1.47x
				and (ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Land") then
					rspawn = (landUnitsE.Tech4)[Random(1, Eland)]
				end
				--x = math.floor(4 * WaveProgression + 0.5)
				if (MinorBossSpawns == "Land+Air" or MinorBossSpawns == "Land" or MinorBossSpawns == "ExtraLand" or MinorBossSpawns == "ExtraLand+ExtraAir" or MinorBossSpawns == "Land+ExtraAir")
				and Random(0, 80) <= 10 * ExpMulti then --2.8% 15.5% 29.6% +10
					CreateACombinedLandBossUnitAroundMainBuildingForAI()
				end
			elseif RiftHland > 0 and GameTime >= (1.35 * WaveProgression) then --29.75
				rspawn = (RiftUnitsH.Tech4)[Random(1, RiftHland)]
				--x = math.floor(4 * WaveProgression + 0.5)
				if Eland > 0 and Random(0, 20) <= 10 * ExpMulti --12.5% 68.8% 100% 1.3x
				and (ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Land") then
					rspawn = (landUnitsE.Tech4)[Random(1, Eland)]
				end
				--x = math.floor(4 * WaveProgression + 0.5)
				if (MinorBossSpawns == "Land+Air" or MinorBossSpawns == "Land" or MinorBossSpawns == "ExtraLand" or MinorBossSpawns == "ExtraLand+ExtraAir" or MinorBossSpawns == "Land+ExtraAir")
				and Random(0, 60) <= 10 * ExpMulti then --3.6% 19.6% 37.5% +5
					CreateACombinedLandBossUnitAroundMainBuildingForAI()
				end
		end
    return rspawn
end
GetRandomizedTotMayRiftID = function(self)
    local rspawn = nil
	--local x = nil
	--GameTime = math.floor(GetGameTimeSeconds() - WavesStartTimeAI) / HoldTimeAI

		if RiftLland > 0 and GameTime < (0.1 * WaveProgression) then
			if BigRiftLland > 0 and  Random(1, 40) <= TotalMayhemLand then
				rspawn = (BigRiftUnitsL.Tech4)[Random(1, BigRiftLland)]
			else
				rspawn = (RiftUnitsL.Tech4)[Random(1, RiftLland)]
			end	
				if RiftMland > 0 and (JumpTech2 == "Land+Air+Navy" or JumpTech2 == "Land+Air" or JumpTech2 == "Land+Navy" or JumpTech2 == "Land") then
					if BigRiftMland > 0 and  Random(1, 40) <= TotalMayhemLand then
						rspawn = (BigRiftUnitsM.Tech4)[Random(1, BigRiftMland)]
					else
						rspawn = (RiftUnitsM.Tech4)[Random(1, RiftMland)]
					end	
				end	
			elseif RiftMland > 0 and GameTime >= (0.1 * WaveProgression) and GameTime < (0.25 * WaveProgression) then
				if BigRiftMland > 0 and  Random(1, 40) <= TotalMayhemLand then
					rspawn = (BigRiftUnitsM.Tech4)[Random(1, BigRiftMland)]
				else
					rspawn = (RiftUnitsM.Tech4)[Random(1, RiftMland)]
				end	
				if RiftLland > 0 and Random(1, 3) == 1 and GameTime < (0.15 * WaveProgression) and not (JumpTech2 == "Land+Air+Navy" or JumpTech2 == "Land+Air" or JumpTech2 == "Land+Navy" or JumpTech2 == "Land") then
					if BigRiftLland > 0 and  Random(1, 30) <= TotalMayhemLand then
						rspawn = (BigRiftUnitsL.Tech4)[Random(1, BigRiftLland)]
					else
						rspawn = (RiftUnitsL.Tech4)[Random(1, RiftLland)]
					end	
				end	
			elseif RiftHland > 0 and GameTime >= (0.25 * WaveProgression) and GameTime < (0.35 * WaveProgression) then
				if BigRiftHland > 0 and  Random(1, 40) <= TotalMayhemLand then
					rspawn = (BigRiftUnitsH.Tech4)[Random(1, BigRiftHland)]
				else
					rspawn = (RiftUnitsH.Tech4)[Random(1, RiftHland)]
				end
				rspawn = (RiftUnitsH.Tech4)[Random(1, RiftHland)]
				if RiftMland > 0 and Random(1, 3) == 1 and GameTime < (0.3 * WaveProgression) then
					if BigRiftMland > 0 and  Random(1, 30) <= TotalMayhemLand then
						rspawn = (BigRiftUnitsM.Tech4)[Random(1, BigRiftMland)]
					else
						rspawn = (RiftUnitsM.Tech4)[Random(1, RiftMland)]
					end	
				end	
			elseif RiftHland > 0 and GameTime >= (0.35 * WaveProgression) and GameTime < (0.45 * WaveProgression) then
				if BigRiftHland > 0 and  Random(1, 39) <= TotalMayhemLand then
					rspawn = (BigRiftUnitsH.Tech4)[Random(1, BigRiftHland)]
				else
					rspawn = (RiftUnitsH.Tech4)[Random(1, RiftHland)]
				end
				if Eland > 0 and Random(0, 250) <= 10 * ExpMulti --1% 4.4% 8.3% 1.5x
				and (ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Land") then
					rspawn = (landUnitsE.Tech4)[Random(1, Eland)]
				end
			elseif RiftHland > 0 and GameTime >= (0.45 * WaveProgression) and GameTime < (0.55 * WaveProgression) then --15.75 to 22.75
				if BigRiftHland > 0 and  Random(1, 38) <= TotalMayhemLand then
					rspawn = (BigRiftUnitsH.Tech4)[Random(1, BigRiftHland)]
				else
					rspawn = (RiftUnitsH.Tech4)[Random(1, RiftHland)]
				end
				--x = math.floor(7 * WaveProgression + 0.5)
				if Eland > 0 and Random(0, 180) <= 10 * ExpMulti --2% 6% 11.6% 1.8x
				and (ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Land") then
					rspawn = (landUnitsE.Tech4)[Random(1, Eland)]
				end
			elseif RiftHland > 0 and GameTime >= (0.55 * WaveProgression) and GameTime < (0.65 * WaveProgression) then --15.75 to 22.75
				if BigRiftHland > 0 and  Random(1, 37) <= TotalMayhemLand then
					rspawn = (BigRiftUnitsH.Tech4)[Random(1, BigRiftHland)]
				else
					rspawn = (RiftUnitsH.Tech4)[Random(1, RiftHland)]
				end
				--x = math.floor(7 * WaveProgression + 0.5)
				if Eland > 0 and Random(0, 130) <= 10 * ExpMulti --2.8% 15.4% 29.6% 1.8x
				and (ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Land") then
					rspawn = (landUnitsE.Tech4)[Random(1, Eland)]
				end	
			elseif RiftHland > 0 and GameTime >= (0.65 * WaveProgression) and GameTime < (0.77 * WaveProgression) then --22.75 to 29.75
				if BigRiftHland > 0 and  Random(1, 36) <= TotalMayhemLand then
					rspawn = (BigRiftUnitsH.Tech4)[Random(1, BigRiftHland)]
				else
					rspawn = (RiftUnitsH.Tech4)[Random(1, RiftHland)]
				end
				--x = math.floor(3 * WaveProgression + 0.5)
				if Eland > 0 and Random(0, 70) <= 10 * ExpMulti --5% 24% 52% 1.8x
				and (ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Land") then
					rspawn = (landUnitsE.Tech4)[Random(1, Eland)]
				end
			elseif RiftHland > 0 and GameTime >= (0.77 * WaveProgression) and GameTime < (0.9 * WaveProgression) then --22.75 to 29.75
				if BigRiftHland > 0 and  Random(1, 35) <= TotalMayhemLand then
					rspawn = (BigRiftUnitsH.Tech4)[Random(1, BigRiftHland)]
				else
					rspawn = (RiftUnitsH.Tech4)[Random(1, RiftHland)]
				end
				--x = math.floor(3 * WaveProgression + 0.5)
				if Eland > 0 and Random(0, 60) <= 10 * ExpMulti --6.5% 34% 65% 2x
				and (ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Land") then
					rspawn = (landUnitsE.Tech4)[Random(1, Eland)]
				end
				if (MinorBossSpawns == "Land+Air" or MinorBossSpawns == "Land" or MinorBossSpawns == "ExtraLand" or MinorBossSpawns == "ExtraLand+ExtraAir" or MinorBossSpawns == "Land+ExtraAir")
				and Random(0, 200) <= 10 * ExpMulti then --1.1% 6.1% 11.6% +20
					CreateACombinedLandBossUnitAroundMainBuildingForAI()
				end
			elseif RiftHland > 0 and GameTime >= (0.90 * WaveProgression) and GameTime < (1.05 * WaveProgression) then --29.75
				if BigRiftHland > 0 and  Random(1, 34) <= TotalMayhemLand then
					rspawn = (BigRiftUnitsH.Tech4)[Random(1, BigRiftHland)]
				else
					rspawn = (RiftUnitsH.Tech4)[Random(1, RiftHland)]
				end
				--x = math.floor(4 * WaveProgression + 0.5)
				if Eland > 0 and Random(0, 40) <= 10 * ExpMulti --9.1% 50% 95% 2x
				and (ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Land") then
					rspawn = (landUnitsE.Tech4)[Random(1, Eland)]
				end
				--x = math.floor(4 * WaveProgression + 0.5)
				if (MinorBossSpawns == "Land+Air" or MinorBossSpawns == "Land" or MinorBossSpawns == "ExtraLand" or MinorBossSpawns == "ExtraLand+ExtraAir" or MinorBossSpawns == "Land+ExtraAir")
				and Random(0, 120) <= 10 * ExpMulti then --2% 10.9% 20.8% +20
					CreateACombinedLandBossUnitAroundMainBuildingForAI()
				end
			elseif RiftHland > 0 and GameTime >= (1.05 * WaveProgression) and GameTime < (1.2 * WaveProgression) then --29.75
				if BigRiftHland > 0 and  Random(1, 33) <= TotalMayhemLand then
					rspawn = (BigRiftUnitsH.Tech4)[Random(1, BigRiftHland)]
				else
					rspawn = (RiftUnitsH.Tech4)[Random(1, RiftHland)]
				end
				--x = math.floor(4 * WaveProgression + 0.5)
				if Eland > 0 and Random(0, 36) <= 10 * ExpMulti --10% 55% 100% 1.89x
				and (ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Land") then
					rspawn = (landUnitsE.Tech4)[Random(1, Eland)]
				end
				--x = math.floor(4 * WaveProgression + 0.5)
				if (MinorBossSpawns == "Land+Air" or MinorBossSpawns == "Land" or MinorBossSpawns == "ExtraLand" or MinorBossSpawns == "ExtraLand+ExtraAir" or MinorBossSpawns == "Land+ExtraAir")
				and Random(0, 95) <= 10 * ExpMulti then --2.3% 12.8% 24.4% +10
					CreateACombinedLandBossUnitAroundMainBuildingForAI()
				end
			elseif RiftHland > 0 and GameTime >= (1.2 * WaveProgression) and GameTime < (1.35 * WaveProgression) then --29.75
				if BigRiftHland > 0 and  Random(1, 32) <= TotalMayhemLand then
					rspawn = (BigRiftUnitsH.Tech4)[Random(1, BigRiftHland)]
				else
					rspawn = (RiftUnitsH.Tech4)[Random(1, RiftHland)]
				end
				--x = math.floor(4 * WaveProgression + 0.5)
				if Eland > 0 and Random(0, 25) <= 10 * ExpMulti --11.1% 61% 100% 1.47x
				and (ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Land") then
					rspawn = (landUnitsE.Tech4)[Random(1, Eland)]
				end
				--x = math.floor(4 * WaveProgression + 0.5)
				if (MinorBossSpawns == "Land+Air" or MinorBossSpawns == "Land" or MinorBossSpawns == "ExtraLand" or MinorBossSpawns == "ExtraLand+ExtraAir" or MinorBossSpawns == "Land+ExtraAir")
				and Random(0, 80) <= 10 * ExpMulti then --2.8% 15.5% 29.6% +10
					CreateACombinedLandBossUnitAroundMainBuildingForAI()
				end
			elseif RiftHland > 0 and GameTime >= (1.35 * WaveProgression) then --29.75
				if BigRiftHland > 0 and  Random(1, 31) <= TotalMayhemLand then
					rspawn = (BigRiftUnitsH.Tech4)[Random(1, BigRiftHland)]
				else
					rspawn = (RiftUnitsH.Tech4)[Random(1, RiftHland)]
				end
				--x = math.floor(4 * WaveProgression + 0.5)
				if Eland > 0 and Random(0, 20) <= 10 * ExpMulti --12.5% 68.8% 100% 1.3x
				and (ExperimentalSpawns == "Land+Air+Navy" or ExperimentalSpawns == "Land+Air" or ExperimentalSpawns == "Land+Navy" or ExperimentalSpawns == "Land") then
					rspawn = (landUnitsE.Tech4)[Random(1, Eland)]
				end
				--x = math.floor(4 * WaveProgression + 0.5)
				if (MinorBossSpawns == "Land+Air" or MinorBossSpawns == "Land" or MinorBossSpawns == "ExtraLand" or MinorBossSpawns == "ExtraLand+ExtraAir" or MinorBossSpawns == "Land+ExtraAir")
				and Random(0, 60) <= 10 * ExpMulti then --3.6% 19.6% 37.5% +5
					CreateACombinedLandBossUnitAroundMainBuildingForAI()
				end
		end
    return rspawn
end
function CheckIfLandCanPass()
    local circle = ForkThread(function(self)
		if LandAmphibious == 'All On' and LandPerWave > 0 then
			local brain
			local LandCanPath = 0
			local LandCantPath = 0
			local braincount = 0
			local AmphibiousPath = 0
			local posX
			local posZ
			local terrainAttitude
			local surfaceAttitude
			local height
			local unit
			local pos2X
			local pos2Z
			local terrainAttitude2
			local targetPos
			local startPos
			posX, posZ = aiBrain:GetArmyStartPos()
			terrainAttitude = GetTerrainHeight(posX, posZ)
			--surfaceAttitude = GetSurfaceHeight(posX, posZ)
			--height = surfaceAttitude - terrainAttitude
			startPos = {posX, terrainAttitude, posZ}
			local iStartLabel = NavUtils.GetLabel('Land', startPos)
			local StartAmphibious = NavUtils.GetLabel('Amphibious', startPos)
			--unit = aiBrain:CreateUnitNearSpot("UEC0001", posX, posZ)
			--unit = CreateUnitHPR("UEC0001", aiBrain:GetArmyIndex(), posX, terrainAttitude, posZ, 0, 0, 0)
			for i, brain in humanBrains.HBrains do
				if brain and not brain:IsDefeated() then
					braincount = braincount + 1
					pos2X, pos2Z = brain:GetArmyStartPos()
					terrainAttitude2 = GetTerrainHeight(pos2X, pos2Z)
					targetPos = {pos2X, terrainAttitude2, pos2Z}
					--[[unit = nil
					unit = aiBrain:CreateUnitNearSpot("UEC0001", posX, posZ)
					if unit == nil then
						unit = CreateUnitHPR("UEC0001", aiBrain:GetArmyIndex(), posX, terrainAttitude, posZ, 0, 0, 0)
						--URL0101
						--UEC0001
					end]]--
					local iEndLabel = NavUtils.GetLabel('Land', targetPos)
					local EndAmphibious = NavUtils.GetLabel('Amphibious', targetPos)
					if iStartLabel == iEndLabel then
						--you can path from start to end by land
						LandCanPath = LandCanPath + 1
					else
						LandCantPath = LandCantPath + 1
					end
					if StartAmphibious == EndAmphibious then
						--you can path from start to end by land
						AmphibiousPath = AmphibiousPath + 1
					end
					--[[if unit and unit ~= nil and not unit.Dead then
						if unit:CanPathTo(targetPos) then
							CanPath = CanPath + 1
						else
							CantPath = CantPath + 1
						end				
					end
					unit:Destroy()]]--
				end
			end
			--PrintText("braincount =  " .. braincount .. " Total", 28, 'ffCBFFFF', 6, 'center')
			--PrintText("LandCanPath =  " .. LandCanPath .. " Total", 28, 'ffCBFFFF', 6, 'center')
			--PrintText("LandCantPath =  " .. LandCantPath .. " Total", 28, 'ffCBFFFF', 6, 'center')
			--PrintText("AmphibiousPath =  " .. AmphibiousPath .. " Total", 28, 'ffCBFFFF', 6, 'center')
			--PrintText("Height =  " .. height .. " Total", 28, 'ffCBFFFF', 6, 'center')
			if AmphibiousPath > 0 then
				if LandCantPath == braincount then
					PrintText("==NOTICE: Land unable to Path to ANY Enemies. Land Waves set to Amphibious/Hover Units.==", 28, 'ffff9595', 20, 'center')
					PrintText("--This Override can be Disabled in Map Options, under setting 6c.--", 28, 'ffff9595', 20, 'center')
					LandAmphibious = 'Amphibious'
				elseif LandCantPath > LandCanPath then
					PrintText("==NOTICE: Land unable to Path to majority of Enemies. Land Waves set to Amphibious/Hover Units.==", 28, 'ffff9595', 20, 'center')
					PrintText("--This Override can be Disabled in Map Options, under setting 6c.--", 28, 'ffff9595', 20, 'center')
					LandAmphibious = 'Amphibious'
				end	
			else 
				PrintText("==NOTICE: Land unable to Path to Enemies. All Players on Plateaus.==", 28, 'ffff9595', 20, 'center')
			end	
		end
		KillThread(self)
	end)
end
function CreateRiftSpawnPoints()
    local circle = ForkThread(function(self)
		local mapX, mapZ = GetMapSize()
		local sizeX = mapX
		local sizeZ = mapZ
		if sizeX > 1024 or sizeZ > 1024 then
			sizeX = 1024
			sizeZ = 1024
		end
		local huBrain
		local posX
		local posZ
		local randX
        local randZ
		local startPos
		local armyPos
		local terrainAttitude
		local terrainAttitude2
		local unit
		local newPos
		local sizeEdgeX = sizeX - 10
		local sizeEdgeZ = sizeZ - 10
		local validPosCount
		--local NotvalidPosCount
		WaitSeconds(30)
		repeat
			unit = nil
			huBrain = nil
			huBrain = GetRandomCloseAliveEnemyBrain(self)
			LOG("sa: Running CreateRiftSpawnPoints")
			if huBrain and not huBrain:IsDefeated() then
				posX, posZ = huBrain:GetArmyStartPos()
				terrainAttitude2 = GetTerrainHeight(posX, posZ)
				startPos = {posX, terrainAttitude2, posZ}
				--local StartAmphibious = NavUtils.GetLabel('Amphibious', startPos)
				if posX <= (mapX * 0.25) then
					if mapX > sizeX then
						randX = Random((posX - sizeX * 0.26), (posX + sizeX * 0.26))
						if randX < 10 then
							randX = Random(10, (posX + sizeX * 0.33))
						end	
					else
						randX = Random(10, (posX + sizeX * 0.33))
					end
				elseif posX <= (mapX * 0.5) then
					randX = Random((posX - sizeX * 0.26), (posX + sizeX * 0.26))
					if randX < 10 then
						randX = 10
					end
				elseif posX >= (mapX * 0.75) then
					if mapX > sizeX then
						randX = Random((posX - sizeX * 0.26), (posX + sizeX * 0.26))
						if randX > (mapX - 10) then
							randX = Random((posX - sizeX * 0.33), (mapX - 10))
						end	
					else
						randX = Random((posX - sizeX * 0.33), sizeEdgeX)
					end	
				else
					if mapX > sizeX then
						randX = Random((posX - sizeX * 0.26), (posX + sizeX * 0.26))
					else
						randX = Random((posX - sizeX * 0.26), (posX + sizeX * 0.26))
						if randX > (sizeX - 10) then
							randX = sizeX - 10
						end
					end	
				end
				if posZ <= (mapZ * 0.25) then
					if mapZ > sizeZ then
						randZ = Random((posZ - sizeZ * 0.26), (posZ + sizeZ * 0.26))
						if randZ < 10 then
							randZ = Random(10, (posZ + sizeZ * 0.33))
						end	
					else
						randZ = Random(10, (posZ + sizeZ * 0.33))
					end
				elseif posZ <= (mapZ * 0.5) then
					randZ = Random((posZ - sizeZ * 0.26), (posZ + sizeZ * 0.26))
					if randZ < 10 then
						randZ = 10
					end
				elseif posZ >= (mapZ * 0.75) then
					if mapZ > sizeZ then
						randZ = Random((posZ - sizeZ * 0.26), (posZ + sizeZ * 0.26))
						if randZ > (mapZ - 10) then
							randZ = Random((posZ - sizeZ * 0.33), (mapZ - 10))
						end	
					else
						randZ = Random((posZ - sizeZ * 0.33), sizeEdgeZ)
					end	
				else
					if mapZ > sizeZ then
						randZ = Random((posZ - sizeZ * 0.26), (posZ + sizeZ * 0.26))
					else
						randZ = Random((posZ - sizeZ * 0.26), (posZ + sizeZ * 0.26))
						if randZ > (sizeZ - 10) then
							randZ = sizeZ - 10
						end
					end	
				end
				terrainAttitude = GetTerrainHeight(randX, randZ)
				--local EndAmphibious = NavUtils.GetLabel('Amphibious', {randX, terrainAttitude, randZ})
				--if StartAmphibious == EndAmphibious then
					local AccurateTest = NavUtils.CanPathTo('Amphibious', startPos, {randX, terrainAttitude, randZ})
					if AccurateTest == true then
						newPos = { randX, terrainAttitude, randZ, type = "VECTOR3" }
						table.insert(validRiftPositions.positions, newPos)
					--[[else
						newPos = { randX, terrainAttitude, randZ, type = "VECTOR3" }
						table.insert(validNotRiftPositions.positions, newPos)]]--
					end
					LOG("sa: RiftSpawnPoint Found")
				--else
					--newPos = { randX, terrainAttitude, randZ, type = "VECTOR3" }
					--table.insert(validNotRiftPositions.positions, newPos)
				--end
				--unit = CreateUnitHPR("RIFTPT", aiBrain:GetArmyIndex(), randX, terrainAttitude, randZ, 0, 0, 0)
				--terrainAttitude = GetTerrainHeight(randX, randZ)
				--locPos = {randX, terrainAttitude, randZ}
				--RIFTPT URL0203
				--PrintText("Rift Spawns 2", 28, 'ffCBFFFF', 6, 'center')
				--unit:CanPathTo(startPos)
				--PrintText("Rift Spawns 3", 28, 'ffCBFFFF', 6, 'center')
				--[[WaitTicks(2)
				if unit and unit ~= nil and not unit.Dead then
					unit:SetImmobile(true)
					if unit:CanPathTo(startPos) then
						terrainAttitude = GetTerrainHeight(randX, randZ)
						newPos = { randX, terrainAttitude, randZ, type = "VECTOR3" }
						table.insert(validRiftPositions.positions, newPos)
						unit:Destroy()
					else
						terrainAttitude = GetTerrainHeight(randX, randZ)
						newPos = { randX, terrainAttitude, randZ, type = "VECTOR3" }
						table.insert(validNotRiftPositions.positions, newPos)
						unit:Destroy()
					end
				end]]--
				validPosCount = table.getn(validRiftPositions.positions)
				--NotvalidPosCount = table.getn(validNotRiftPositions.positions)
				--PrintText("Rift Spawns " .. validPosCount .. " Total", 28, 'ffCBFFFF', 6, 'center')
				--PrintText("Non-Spawns " .. NotvalidPosCount .. " Total", 28, 'ffCBFFFF', 6, 'center')
				if mapX >= 1024 or mapZ >= 1024 then
					if validPosCount > 300 then
						break
					end
				else
					if validPosCount > 150 then
						break
					end
				end
			end	
			WaitSeconds(1)
		until GetGameTimeSeconds() > 20000 or won == true
		KillThread(self)
	end)
end
function MonitorRiftBuildingCount()
    local circle = ForkThread(function(self)
		local riftBuildingList
		local SupportBaseList
		local SupportBase
		local riftBuildingCount
		local SupportBaseCount
		local count
		WaitSeconds(WavesStartTimeAI + 5)
		repeat
			--LOG("sa: Running MonitorRiftBuildingCount")
			riftBuildingList = {}
			SupportBaseList = {}
			SupportBase = nil
			riftBuildingList = aiBrain:GetListOfUnits(categories.riftorb2, false)
			riftBuildingCount = table.getn(riftBuildingList)
			SupportBaseList = aiBrain:GetListOfUnits(categories.b_obj1301, false)
			SupportBaseCount = table.getn(SupportBaseList)
			--PrintText("Support Buildings " .. SupportBaseCount .. " Total", 28, 'ffCBFFFF', 6, 'center')
			if GetGameTimeSeconds() < (WavesStartTimeAI + HoldTimeAI) then
				if riftBuildingCount < SupportBaseCount then
					SupportBase = SupportBaseList[Random(1, SupportBaseCount)]
					CreateARiftNuke(SupportBase)
				end
			else
				if riftBuildingCount < SupportBaseCount then
					count = SupportBaseCount - riftBuildingCount
					repeat	
						SupportBase = SupportBaseList[Random(1, SupportBaseCount)]
						CreateARiftNuke(SupportBase)
						count = count - 1
					until count < 1
				end
			end
			WaitSeconds(120)
			if GetGameTimeSeconds() <= ((WavesStartTimeAI + HoldTimeAI) * 0.5) then
				WaitSeconds(120)
			end
		until GetGameTimeSeconds() > 20000 or won == true
	end)
end
function CreateARiftNuke(SupportBase)
    local circle = ForkThread(function(self)
		--LOG("sa: Running CreateARiftNuke")
        if SupportBase and not SupportBase:BeenDestroyed() then
			local unit = nil
			--local MapCheck = false
			local Chance
			--local count = 0
			local posX, posY, posZ = SupportBase:GetPositionXYZ()
			local rspawn = "RIFTNUKE"
			if rspawn ~= nil then
				local oldposX = posX
				local oldposZ = posZ
					Chance = Random(1, 8)
					if Chance == 1 then
						posX = posX + Random(5, 15)
						posZ = posZ + Random(5, 15)
					elseif Chance == 2 then
						posX = posX - Random(5, 15)
						posZ = posZ + Random(5, 15)
					elseif Chance == 3 then
						posX = posX + Random(5, 15)
						posZ = posZ - Random(5, 15)
					elseif Chance == 4 then
						posX = posX - Random(5, 15)
						posZ = posZ - Random(5, 15)
					elseif Chance == 5 then
						posZ = posZ + Random(5, 15)
						posX = posX + Random(5, 15)
					elseif Chance == 6 then
						posZ = posZ - Random(5, 15)
						posX = posX + Random(5, 15)
					elseif Chance == 7 then
						posZ = posZ + Random(5, 15)
						posX = posX - Random(5, 15)
					else
						posZ = posZ - Random(5, 15)
						posX = posX - Random(5, 15)
					end

					if posX <= 0 then
						posX = Random(1, 15)
					end
					if posX >= sizeX then
						posX = sizeX - Random(1, 15)
					end
					if posZ <= 0 then
						posZ = Random(1, 15)
					end
					if posZ >= sizeZ then
						posZ = sizeZ - Random(1, 15)
					end
				unit = aiBrain:CreateUnitNearSpot(rspawn, posX, posZ)
				if unit == nil then
					local posX = oldposX
					local posZ = oldposZ
						Chance = Random(1, 8)
						if Chance == 1 then
							posX = posX + Random(5, 15)
							posZ = posZ + Random(5, 15)
						elseif Chance == 2 then
							posX = posX - Random(5, 15)
							posZ = posZ + Random(5, 15)
						elseif Chance == 3 then
							posX = posX + Random(5, 15)
							posZ = posZ - Random(5, 15)
						elseif Chance == 4 then
							posX = posX - Random(5, 15)
							posZ = posZ - Random(5, 15)
						elseif Chance == 5 then
							posZ = posZ + Random(5, 15)
							posX = posX + Random(5, 15)
						elseif Chance == 6 then
							posZ = posZ - Random(5, 15)
							posX = posX + Random(5, 15)
						elseif Chance == 7 then
							posZ = posZ + Random(5, 15)
							posX = posX - Random(5, 15)
						else
							posZ = posZ - Random(5, 15)
							posX = posX - Random(5, 15)
						end

						if posX <= 0 then
							posX = Random(1, 15)
						end
						if posX >= sizeX then
							posX = sizeX - Random(1, 15)
						end
						if posZ <= 0 then
							posZ = Random(1, 15)
						end
						if posZ >= sizeZ then
							posZ = sizeZ - Random(1, 15)
						end
					local terrainAltitude = GetTerrainHeight(posX, posZ)
					unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
				end
				if unit ~= nil then
					local Position = Random(1, table.getn(validRiftPositions.positions))
					local nukePos = (validRiftPositions.positions)[Position]
					WaitTicks(20)
					if nukePos then
						IssueNuke({ unit }, nukePos)
					end
					WaitTicks(750)
					if unit ~= nil and not unit:BeenDestroyed() then
						unit:Destroy()
					end
				end	
			end
        end
        KillThread(self)
    end)
end
function DetectAndSpawnOrbRiftWaves()
    local circle = ForkThread(function(self)
	local orb
	local wavesize
	local totalEnemyMass
	local UnitsFromMass
	local riftBuildingList2
		WaitSeconds(WavesStartTimeAI + 60)
		repeat
			--LOG("sa: Running DetectAndSpawnOrbRiftWaves")
			riftBuildingList2 = {}
			riftBuildingList2 = aiBrain:GetListOfUnits(categories.riftorb2, false)
			totalEnemyMass = CalculateEnemyMass()
			UnitsFromMass = math.floor((totalEnemyMass * 0.00134) + 0.5)
			wavesize = RiftUnits + totalEnemyParagons + totalEnemyYolonas + UnitsFromMass
			if wavesize > 50 then
				wavesize = 50
			end
			for i, orb in riftBuildingList2 do
				if orb and not orb:BeenDestroyed() then
					CreateWavesForOrbRift(orb, wavesize)
				end
			end	
			WaitSeconds(120)	
		until GetGameTimeSeconds() > 20000 or won == true
	end)
end
function CreateWavesForOrbRift(orb, wavesize)
	local circle = ForkThread(function(self)
		--LOG("sa: Running CreateWavesForOrbRift Size " .. wavesize)
		local riftorb = orb
		local posX, posY, posZ = riftorb:GetPositionXYZ()
		local unitcount = wavesize
		repeat
			SpawnLandUnitsForOrb(posX, posZ)
			unitcount = unitcount - 1
			WaitTicks(3)
		until unitcount < 1 or won == true
		KillThread(self)
	end)
end
function SpawnLandUnitsForOrb(RposX, RposZ)
	local circle = ForkThread(function(self)
		local unit = nil
		local rspawn = nil
		local posX = RposX
		local posZ = RposZ
		--if GetGameTimeSeconds() > WavesStartTimeAI then
			if TotalMayhemWaves == "Adjustable T1/T2/T3 Experimentals" then
				rspawn = GetRandomizedTotMayRiftID()
			else	
				rspawn = GetRandomizedRiftUnitID()
			end	
			if rspawn ~= nil then
				unit = aiBrain:CreateUnitNearSpot(rspawn, posX, posZ)
				if unit == nil then
					local terrainAltitude = GetTerrainHeight(posX, posZ)
					unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
				end
				if unit and unit ~= nil and not unit.Dead and (HPBonusAI > 0 or ParagonCycle ~= "Off") then
					if GameTime < 0.33 then
						totalIncrease = HealthBonus * 0.5
						maxhp = unit:GetMaxHealth()
						unit:SetMaxHealth(maxhp + totalIncrease)
					elseif GameTime >= 0.33 and GameTime < 0.66 then
						totalIncrease = HealthBonus
						maxhp = unit:GetMaxHealth()
						unit:SetMaxHealth(maxhp + totalIncrease)
					elseif GameTime >= 0.66 and GameTime < 1 then
						totalIncrease = HealthBonus * 1.5 + Random(1400, 1800) * totalEnemyEndgamers
						maxhp = unit:GetMaxHealth()
						unit:SetMaxHealth(maxhp + totalIncrease)
					elseif GameTime >= 1 then
						totalIncrease = HealthBonus * 2 + Random(1800, 2800) * totalEnemyEndgamers
						maxhp = unit:GetMaxHealth()
						unit:SetMaxHealth(maxhp + totalIncrease)
					end
					hp = unit:GetMaxHealth()
					unit:SetHealth(self, hp)
					unit:SetReclaimable(false)
				end
				if unit and not unit.Dead then
					if DamageBoost ~= 'Off - 0' then
						ModifyWeaponDamageBuffAndRange(unit)
					end	
					unit:SetSpeedMult(1 + waveNum * SpeedBonus + SpeedBonusOnce)
					if WaveStyle == "Even Attack Waves" then	
						RedirectUnit(unit)
					elseif WaveStyle == "Dynamic Attack Waves" or WaveStyle == "Human with AI Assist" then
						RedirectUnitLand(unit)	
					end	
				end
				if KillPlayerUnit > 0 then
					SuicideLandNavyUnit(unit)
				end	
			end
			KillThread(self)
		--end
	end)
end
function MonitoringFunction()
    local circle = ForkThread(function(self)
        repeat
            WaitTicks(20)
			if HQAllyEcoBoost > 0 then
				HQAlliesACUecoBoost()
			end	
			WaitTicks(20)
			if WaveStyle == "Even Attack Waves" then	
				if AllRedirectCycleRunning == false then
					RedirectUnits()
				end	
				if RamboRedirectCycleRunning == false then
					RedirectRAMBOS()
				end	
			elseif WaveStyle == "Dynamic Attack Waves" then	
				if LandRedirectCycleRunning == false then
					RedirectUnitsLand()
				end	
				if AirRedirectCycleRunning == false then
					RedirectUnitsAir()
				end	
				if NavyRedirectCycleRunning == false then
					RedirectUnitsNavy()
				end	
				if RamboRedirectCycleRunning == false then
					RedirectRAMBOS()
				end	
			end
			WaitTicks(2)
            CheckFinalEndgame()
			if KillAllNonHQPlayers == "Assassinate All ACUs Defeat" then	
				MonitoringAllHQEnemyACUs()
			end
			WaitTicks(2)
			if KillHQPlayerAllies == "HQ Allies Kill All ACUs Defeat" then	
				MonitoringHQAlliesAllACUsAssassin()
			end	
            if GetGameTimeSeconds() > WavesStartTimeAI and lastWarning == false then
                lastWarning = true
                LastWarning()
            end
            --[[if ((GetGameTimeSeconds() - WavesStartTimeAI) / HoldTimeAI) > 0.6 and currentEnemyLevel > 3 and Random(1, 2) == 1 then
                ClearAITrashUnits()
            end]]--
            --[[local circle = ForkThread(function(self)
				WaitSeconds(60)
				CalculateEnemyLevel()
				totalAINukeSubs = CalculateTotalAINukeSubs()
			end)]]--
            --[[if totalEnemyParagons > 0 and ((GetGameTimeSeconds() - WavesStartTimeAI) / HoldTimeAI) < 0.45 then
                WarningAboutEarlyParagons()
            else
                AIMainBuildingMinotoring()
            end]]--
        until GetGameTimeSeconds() > 20000 or won == true
    end)
end
function MonitoringFunctionHQEnemyEcoBoosts()
	local circle = ForkThread(function(self)
	local EcoBoostFlag = false
		repeat
			WaitTicks(20)
			if HumanEcoBoost > 0 and EndGameEcoBoostflag == false then
				MonitoringPlayersACU()
				if EcoBoostFlag == false then	
					PrintText("EcoBoost Active!", 28, 'ffCBFFFF', 4, 'center')
					EcoBoostFlag = true
				end	
			end	
			if EndGameEcoBoost > 0 and GetGameTimeSeconds() > (WavesStartTimeAI + HoldTimeAI - EndEcoBoostTime) then
				if EndGameEcoMessage == false then	
					PrintText("EndGame EcoBoost Active!", 28, 'ffCBFFFF', 4, 'center')
					EndGameEcoMessage = true
				end	
				PlayersACUEndGameEcoBoost()
				EndGameEcoBoostflag = true
			end	
		until GetGameTimeSeconds() > 20000
	  end)
end	
function HoldTimeForArtyNuke()
	local circle = ForkThread(function(self)
		local HoldTimeValueX = {}
		local n = 0
		
		for v in ArtyNukeEnable:gmatch("%S+") do
			n = n + 1
			HoldTimeValueX[n] = v
		end
		HoldTimeArtyNukes = tonumber(HoldTimeValueX[3]) * 0.01
	end)
end
function WaveSizeMultiForLand()
	local circle = ForkThread(function(self)
		local LandValueX = {}
		local n = 0
		
		for v in WaveSizeMultiLand:gmatch("%S+") do
			n = n + 1
			LandValueX[n] = v
		end
		Landx1 = tonumber(LandValueX[1])
		Landx2 = tonumber(LandValueX[3])
		Landx3 = tonumber(LandValueX[5])
		Landx4 = tonumber(LandValueX[7])
		Landx5 = tonumber(LandValueX[9])
	end)
end
function WaveSizeMultiForAir()
	local circle = ForkThread(function(self)
		local AirValueX = {}
		local n = 0
		
		for v in WaveSizeMultiAir:gmatch("%S+") do
			n = n + 1
			AirValueX[n] = v
		end
		Airx1 = tonumber(AirValueX[1])
		Airx2 = tonumber(AirValueX[3])
		Airx3 = tonumber(AirValueX[5])
		Airx4 = tonumber(AirValueX[7])
		Airx5 = tonumber(AirValueX[9])
	end)
end
function WaveSizeMultiForNaval()
	local circle = ForkThread(function(self)
		local NavyValueX = {}
		local n = 0
		
		for v in WaveSizeMultiNaval:gmatch("%S+") do
			n = n + 1
			NavyValueX[n] = v
		end
		Navyx1 = tonumber(NavyValueX[1])
		Navyx2 = tonumber(NavyValueX[3])
		Navyx3 = tonumber(NavyValueX[5])
		Navyx4 = tonumber(NavyValueX[7])
		Navyx5 = tonumber(NavyValueX[9])
	end)
end
function WaveProgressionRate()
	local circle = ForkThread(function(self)
		local WaveProgressionX = {}
		local n = 0
		
		for v in WaveProgressionData:gmatch("%S+") do
			n = n + 1
			WaveProgressionX[n] = v
		end
		local WaveProgressMulti = tonumber(WaveProgressionX[1]) * 0.01
		local WaveFastOrSlow = tostring(WaveProgressionX[3])
		if WaveFastOrSlow == "Faster" then
			WaveProgression = 1 - WaveProgressMulti
		elseif WaveFastOrSlow == "Slower" then
			WaveProgression = 1 + WaveProgressMulti
		end	
		--PrintText("Wave Progression is " .. WaveProgression .. " !", 28, 'ffCBFFFF', 6, 'center')
	end)
end
function NuclearStrikeFrequency()
	local circle = ForkThread(function(self)
		local NukeStrikeX = {}
		local n = 0
		
		for v in NukeStrikeEveryAI:gmatch("%S+") do
			n = n + 1
			NukeStrikeX[n] = v
		end
		Nukex1 = tonumber(NukeStrikeX[1]) * 60
		Nukex2 = tonumber(NukeStrikeX[3]) * 60
	end)
end
function CheckFinalEndgame()
    if (GetGameTimeSeconds() - WavesStartTimeAI) > HoldTimeAI and HoldTimeOver == false then
		HoldTimeOver = true
		HQMass = 10000
		HQEnergy = 1000000
		AIMainBuilding:SetProductionPerSecondEnergy(HQEnergy)
        AIMainBuilding:SetProductionPerSecondMass(HQMass)
		EndgameArtyEvents() --Calls Endgame Arty Function
		
		--Endgame Boss Wave
		local Fcount = EndWaveMulti
		local Acount = EndWaveAir
		if Fcount > 0 or Acount > 0 then --Boss Warning Message
			LastDifficulty()
		end
		if EndGameHoldTime > 0 then --Hold Time Warning, if On
			EndGameTime = EndGameHoldTime / 60
			PrintText("Survive for " .. EndGameTime .. " Minutes to Win!", 28, 'ffCBFFFF', 6, 'center')
		end
		if Fcount > 0 then
			repeat
				CreateHugeBossUnitAroundMainBuildingForAI()
				Fcount = Fcount - 1
			until Fcount < 1
		end
		if Acount > 0 then
			repeat
				CreateACombinedAirBossUnitAroundMainBuildingForAI()
				Acount = Acount - 1
			until Acount < 1
		end
		EndlessBossWaves() --Starts Endless Boss Waves if On
		
		--Spawns Allies if Not Spawned Yet
		if AlliedForceSpawned == false and SpawnAlliesForceFlag ~= 'Off' then
			local circle = ForkThread(function(self)	
				WaitSeconds(5)
				AlliedForce = 2 + (humans * AlliedForceMultiplier)
				repeat
					SpawnAlliedForce()
					AlliedForce = AlliedForce - 1
				until AlliedForce < 1
				AlliedForcesSpawnWarning()
				AlliedForceSpawned = true
			end)
		end
		--Doom Wave
		if DoomCount ~= 'Off --' then
			WaitSeconds(10)
			DeployDooms()
		end
    end
end
function CheckMainGoal()
	local circle = ForkThread(function(self)
		--PrintText("CHECK MAIN GOAL!", 30, 'c71c1c', 4, 'center')
		repeat
			WaitSeconds(2)
			local unitlist = aiBrain:GetListOfUnits(categories.mai2201, false)
			if (GetGameTimeSeconds() > 60 and (table.getn(unitlist) == 0 or (AIMainBuilding ~= nil and AIMainBuilding:BeenDestroyed()))) or
			(EndGameCondition == true and GetGameTimeSeconds() > (WavesStartTimeAI + HoldTimeAI + EndGameHoldTime)) then
				won = true
				if aiSecondaryBuildings and aiSecondaryBuildings.secondaryBuildings then
					for aindex, sBuilding in aiSecondaryBuildings.secondaryBuildings do
						if sBuilding and not sBuilding:BeenDestroyed() then
							sBuilding:Kill()
						end
					end
				end
				if aiBrain and aiBrain:GetListOfUnits(categories.COMMAND, false)[1] then
					aiBrain:GetListOfUnits(categories.COMMAND, false)[1]:Kill()
				end
				ClearAIAllUnits()
			end
		until GetGameTimeSeconds() > 20000	
	end)
end	
function EndgameArtyEvents()
	local circle = ForkThread(function(self)
		local ArtyCount
		MavCount = Random(2, 3) + math.floor(totalEnemyEndgamers * 0.5 + 0.5) + math.floor(humans * 0.5 + 0.5)
		if MavCount > 12 then
			MavCount = 12
		end
		SMDCount = math.floor(MavCount * 0.5 + 0.5) + (VanDef * 2)
		DefCount = math.floor(MavCount * 0.5 + 0.5) + 2 + (VanDef * 4)
		AACount = math.floor(MavCount * 0.5 + 0.5) + 2 + (math.floor(MavCount * 0.5 + 0.5) * VanDef)
		if HQDefenses ~= "HQ Defenses Off" then
			repeat
				WaitTicks(2)
				CreateShieldDefenceForAI(ShieldType)
				DefCount = DefCount - 1
			until DefCount < 1
			repeat
				WaitTicks(2)
				CreateAndLoadSMDForAI(SMDType)
				SMDCount = SMDCount - 1
			until SMDCount < 1
		end
		if HQDefensesPD ~= "HQ Point Defenses Off" then
			repeat
				WaitTicks(2)
				CreateAntiAirDefenceForAI(AAType)
				AACount = AACount - 1
			until AACount < 1
		end	
		if ArtyOn == "On" or ArtyOn == "On, Repeats Spawn" then
			if ArtyType == "UEB2302" or ArtyType == "UAB2302" or ArtyType == "URB2302" or ArtyType == "XSB2302" or ArtyType == "ARU2401" then
				ArtyCount = MavCount + 2
			else
				ArtyCount = MavCount
			end	
			GameOver()
			WaitSeconds(ArtySpawnTime)
			repeat
				WaitTicks(2)
				CreateArtilleryAroundMainBuilding(ArtyType)
				ArtyCount = ArtyCount - 1
			until ArtyCount < 1
			PrintText("EndGame Artillery Deployed!", 30, 'c71c1c', 4, 'center')
			if ArtyOn == "On, Repeats Spawn" then
				RepeatEndgameArtillery()
			end	
		end
	end)
end
function RepeatEndgameArtillery()
	local circle = ForkThread(function(self)
		local ArtyCount
		repeat
			WaitSeconds(30)
			if ArtyType == "UEB2302" or ArtyType == "UAB2302" or ArtyType == "URB2302" or ArtyType == "XSB2302" or ArtyType == "ARU2401" then
				ArtyCount = Random(2, 3) + math.floor(totalEnemyEndgamers * 0.5 + 0.5) + math.floor(humans * 0.5 + 0.5)
			end
			GameOver()
			WaitSeconds(ArtySpawnTime)
			repeat
				WaitTicks(2)
				CreateArtilleryAroundMainBuilding(ArtyType)
				ArtyCount = ArtyCount - 1
			until ArtyCount < 1
			PrintText("EndGame Artillery Deployed!", 30, 'c71c1c', 4, 'center')
		until GetGameTimeSeconds() > 20000 or won == true
	end)
end
function EndlessBossWaves()
	local circle = ForkThread(function(self)
		repeat
			if BossWaveEndlessSpawn == "Off" then
				break
			end	
			WaitTicks(20)
				--EndlessBossOn()
				WaitSeconds(tonumber(BossWaveEndlessSpawn) * 60)
				local Fcount = EndWaveMulti
				local Acount = EndWaveAir
				if Fcount > 0 then	
					repeat
						WaitTicks(2)
						CreateHugeBossUnitAroundMainBuildingForAI()
						Fcount = Fcount - 1
					until Fcount < 1
				end
				if Acount > 0 then	
					repeat
						WaitTicks(2)
						CreateACombinedAirBossUnitAroundMainBuildingForAI()
						Acount = Acount - 1
					until Acount < 1
				end
		until GetGameTimeSeconds() > 20000 or won == true
	end)
end

function MonitoringAiNukeFunction() -- Offensive
    local circle = ForkThread(function()
		local StrikeCount = 0
        repeat
            WaitTicks(50)
            local gameEndersCount = totalEnemyParagons + totalEnemyYolonas
			if NukeWarningOne == false and (GetGameTimeSeconds() - WavesStartTimeAI) > ((HoldTimeAI * NukeTime) - 600) and (NukesOn == "All On" or NukesOn == "Offensive") then
				PrintText("==Nukes in 10 Minutes==", 24, 'ffFF1100', 4, 'center')
				NukeWarningOne = true
			end
			if NukeWarningTwo == false and (GetGameTimeSeconds() - WavesStartTimeAI) > ((HoldTimeAI * NukeTime) - 300) and (NukesOn == "All On" or NukesOn == "Offensive") then
				PrintText("==Nukes in 5 Minutes==", 24, 'ffFF1100', 4, 'center')
				NukeWarningTwo = true
			end
            if (((GetGameTimeSeconds() - WavesStartTimeAI) / HoldTimeAI) > NukeTime and (NukesOn == "All On" or NukesOn == "Offensive")) or (totalEnemyParagons > Random(1, 2) and (NukesOn == "All On" or NukesOn == "Offensive") and ParagonNuke == "On") or (((GetGameTimeSeconds() - WavesStartTimeAI) / HoldTimeAI) > NukeTime and NuclearOverwhelm > 0) then
                local numOfNukeHits = Random(1, 2 + NukesPerStrikeAI * humans) + gameEndersCount * Random(1, 2) + (((GetGameTimeSeconds() - WavesStartTimeAI) * NuclearOverwhelm) / 120) * math.floor(humans * 0.5 + 0.5) + math.floor(CalculateTotalEnemySMDs() * 0.2 + 0.5) + (NukeIncreasePerStrike * StrikeCount)
                if numOfNukeHits > 0 then
					PrintText("Nukes Inbound!", 30, 'c71c1c', 4, 'center')
                    StrikeCount = StrikeCount + 1
                    repeat
                        WaitTicks(2)
                        CreateAndLaunchNukeAtEnemy()
                        numOfNukeHits = numOfNukeHits - 1
                    until numOfNukeHits < 1
                end
                WaitSeconds(Random(Nukex1, Nukex2))
            end
        until GetGameTimeSeconds() > 20000 or won == true
    end)
end	
function YolonaResponse()
	local circle = ForkThread(function()
		repeat
			WaitTicks(50)
			if totalEnemyYolonas > 0 and GetGameTimeSeconds() > WavesStartTimeAI then					
				--[[if Random(1, 2) == 1 then
                    AIMessageTo('Yolona have a good time? ', nil)
                elseif Random(1, 2) == 1 then
                    AIMessageTo('Yolon Energy is a privately held energy broker and consulting firm specializing in electricity and natural gas procurement ', nil)
                else
                    AIMessageTo('Is this too much? ', nil)
                end]]--
				PrintText("Yolona have a good time?", 30, 'c71c1c', 4, 'center')
				WaitTicks(10)
				local YoloCount = totalEnemyYolonas
				local LBoss = math.floor(YoloCount * 1.5 + 0.5)
				local ABoss = YoloCount
				repeat
					WaitTicks(2)
					CreateArtilleryAroundMainBuilding("ARU2401")
					--CreateAndLoadSMDForAI()
					if Random(1, 4) == 1 then	
						CreateAndLoadSMDForAI("ASD4302")
						PrintText("Guardian SMD Active", 30, 'c71c1c', 4, 'center')
					end	
					YoloCount = YoloCount - 1
				until YoloCount < 1
				WaitSeconds(60)
				if LandPerWave > 0 or NavyPerWave > 0 then
					repeat	
						WaitTicks(2)
						CreateHugeBossForYolonas()
						LBoss = LBoss - 1
					until LBoss < 1
				end
				WaitSeconds(60)
				if AirPerWave > 0 then
					repeat
						WaitTicks(5)
						CreateAirBossUnitForYolonas()
						ABoss = ABoss - 1
					until ABoss < 1
				end
				WaitSeconds(390)
			end	
		until GetGameTimeSeconds() > 20000 or won == true
	end)
end	
function ArtilleryResponse()
	local circle = ForkThread(function()
	local c
	local InitialResponse = false
	ArtyResponseTime = 0
		repeat
		WaitTicks(100)
			if (totalEnemyExpArty >= 1 and ShieldType ~= "GAS4301") or totalEnemyExpArty >= 2 or (totalEnemyT3Arty > 3 and ShieldType ~= "GAS4301")
			or totalEnemyT3Arty > Random(5, 6) or (totalEnemyT3Arty + totalEnemyExpArty) > Random(4, 5) or ((totalEnemyT3Arty >= 1 or totalEnemyExpArty >= 1) and Random(1, 99) == 45) or (totalEnemySatelites >= 4 and Random(1, 50) <= totalEnemySatelites) then
				if InitialResponse == false then
					PrintText("Artillery response inbound. ETA 6 Minutes.", 30, 'c71c1c', 4, 'center')
					InitialResponse = true
					WaitSeconds(360)
				else
					PrintText("Artillery response inbound. ETA 4 Minutes.", 30, 'c71c1c', 4, 'center')
					WaitSeconds(240)
				end	
				c = 1
				if totalEnemyExpArty > 0 then
					c = 0
				end	
				local x = totalEnemyExpArty + math.floor(totalEnemyT3Arty * 0.5 + 0.5) + math.floor(totalEnemySatelites * 0.25 + 0.25) - (1 * c)
				if x < 1 then
					x = 1
				end	
				repeat
					CreateArtilleryAroundMainBuilding("ARU2401")
					x = x - 1
				until x < 1	
				CreateShieldDefenceForAI("GAS4302")
				if secondaryspawn ~= "Off" then
					CreateDefenceFor2ndSpawn("GAS4302")
				end	
				if Random(1, 5) <= 3 then
					CreateShieldDefenceForAI("GAS4302")
					if secondaryspawn ~= "Off" then
						CreateDefenceFor2ndSpawn("GAS4302")
					end	
				end	
				WaitSeconds(295 - (30 * ArtyResponseTime))
				ArtyResponseTime = ArtyResponseTime + 1
				if ArtyResponseTime > 4 then
					ArtyResponseTime = 4
				end	
			end
		until GetGameTimeSeconds() > 20000 or won == true
	end)
end	
function MonitoringAiNukeSubmarinesFunction() --disabled
    local circle = ForkThread(function()
        repeat
            WaitTicks(10)
            local gameEndersCount = totalEnemyParagons + totalEnemyYolonas
            if (((GetGameTimeSeconds() - WavesStartTimeAI) / HoldTimeAI) > 0.60 or (gameEndersCount > 2)) and NukesOn == "On" then
                if gameEndersCount > 27 then
                    gameEndersCount = 27
                end
                if Random(1, 28 - gameEndersCount) < 8 then
                    LaunchNukeAtEnemyFromNukeSubs()
                end
            end
            WaitTicks(100)
            if AIMainBuilding ~= nil and not AIMainBuilding:BeenDestroyed() and totalEnemyYolonas > 0 or (totalEnemyYolonas > 1 and totalEnemyYolonas <= 4 and Random(1, 12) < 3) then
                CreateArtilleryAroundMainBuilding(ArtyType)
				WaitTicks(200)
                if Random(1, 2) == 1 then
                    AIMessageTo('I love shifting between being super cute and aggressive. Its funny ', nil)
                elseif Random(1, 2) == 1 then
                    AIMessageTo('I am not an aggressive person at all. But I know how to fight back! ', nil)
                else
                    AIMessageTo('I wont let you win this by spamming Yolos! ', nil)
                end
                for i, yolona in enemyYolonas.Yols do
                    if yolona ~= nil and not yolona:BeenDestroyed() and Random(1, 2) == 1 and NukesOn == "On" then
                        LaunchNukeAtEnemyFromNukeSubs(yolona)
                        if totalEnemySMDs < 8 then
                            totalEnemySMDs = 8
                        end
                        local rand = Random(totalEnemySMDs * 0.125, totalEnemySMDs * 0.5)
                        repeat
                            CreateAndLaunchNukeAtEnemyUnit(yolona)
                            rand = rand - 1
                        until rand < 0
                        WaitTicks(100)
                    end
                 break
				end
            end
            WaitSeconds(Random(Nukex1, Nukex2))
        until GetGameTimeSeconds() > 20000
    end)
end
function MonitoringNearbyEnemyUnitsFunction() -- Defensive
    local circle = ForkThread(function()
        repeat
            WaitSeconds(Random(Nukex1, Nukex2))
            if AIMainBuilding ~= nil and not AIMainBuilding:BeenDestroyed() then
                local nearbyUnit = GetClosestEnemyUnitToHQ(AIMainBuilding, 20000)
                if nearbyUnit ~= nil and (NukesOn == "All On" or NukesOn == "Defensive") then
                    local x = Random(1, 2)
                    repeat
                        CreateAndLaunchNukeAtEnemyUnit(nearbyUnit)
                        x = x - 1
                    until x < 0
                end
            end
        until GetGameTimeSeconds() > 20000 or won == true
    end)
end
function MonitoringNearbyEnemyUnitsFunctionTwo()  -- Defensive
    local circle = ForkThread(function()
        repeat
            WaitSeconds(Random(Nukex1, Nukex2))
            if AIMainBuilding ~= nil and not AIMainBuilding:BeenDestroyed() then
                local nearbyUnit = GetClosestEnemyUnitToHQ(AIMainBuilding, 35000)
                if nearbyUnit ~= nil and (NukesOn == "All On" or NukesOn == "Defensive") then
                    local x = Random(1, 2)
                    repeat
                        CreateAndLaunchNukeAtEnemyUnit(nearbyUnit)
                        x = x - 1
                    until x < 0
                end
            end
        until GetGameTimeSeconds() > 20000 or won == true
    end)
end
function MonitoringEnemyExpAirFunction() -- Disabled
    local circle = ForkThread(function()
        repeat
            WaitSeconds(Random(Nukex1, Nukex2))
            for i, brain in humanBrains.HBrains do
                WaitTicks(20)
                if not IsAlly(aiBrain:GetArmyIndex(), brain:GetArmyIndex()) then
                    local enemyExpAir = brain:GetListOfUnits(categories.MOBILE * categories.EXPERIMENTAL * categories.AIR, false)
                    if table.getn(enemyExpAir) > Random(4, 5) and NukesOn == "On" then
                        if Random(1, 2) == 1 then
                            AIMessageTo('How dare you attack me with many experimental air units!, I will make them a nuclear dust! ', brain)
                        else
                            AIMessageTo('Whenever you are aggressive, you are at the edge of mistakes... ', brain)
                        end
                        for _, unit in enemyExpAir do
                            if unit and not unit:BeenDestroyed() and Random(0, 6) <= math.floor(NukesPerStrikeAI * 0.33 + 0.5) then
                                CreateAndLaunchNukeAtEnemyUnit(unit)
                            end
                        end
                    end
                end
			 break	
            end
        until GetGameTimeSeconds() > 20000
    end)
end
function MonitoringEnemyT3DefencesFunction() -- Disabled
    local circle = ForkThread(function()
        repeat
            WaitSeconds(Random(Nukex1, Nukex2))
            for i, brain in humanBrains.HBrains do
                WaitTicks(20)
                if not IsAlly(aiBrain:GetArmyIndex(), brain:GetArmyIndex()) then
                    local t3Defences = brain:GetListOfUnits(categories.STRUCTURE * categories.TECH3 * categories.DEFENSE * categories.DIRECTFIRE, false)
                    if table.getn(t3Defences) > Random(35, 50) and NukesOn == "On" then
                        if Random(1, 2) == 1 then
                            AIMessageTo('Spamming T3 defences wont stop my forces! ', brain)
                        else
                            AIMessageTo('Too much firepower.. ', brain)
                        end
                        for _, unit in t3Defences do
                            if unit and not unit:BeenDestroyed() and Random(0, 30) <= NukesPerStrikeAI then
								CreateAndLaunchNukeAtEnemyUnit(unit)
                            end
                        end
                    end
                end
			 break	
            end
        until GetGameTimeSeconds() > 20000
    end)
end
function MonitoringEnemyExpNavalFunction() -- Disabled
    local circle = ForkThread(function()
        repeat
            WaitSeconds(Random(Nukex1, Nukex2))
            for i, brain in humanBrains.HBrains do
                WaitTicks(20)
                if not IsAlly(aiBrain:GetArmyIndex(), brain:GetArmyIndex()) then
                    local enemyExpNaval = brain:GetListOfUnits(categories.MOBILE * categories.EXPERIMENTAL * categories.NAVAL, false)
                    if table.getn(enemyExpNaval) > Random(4, 5) and NukesOn == "On" then
                        if Random(1, 2) == 1 then
                            AIMessageTo('Nice naval force you have, I am wondering what it needs to be more shiny.. ', brain)
                        else
                            AIMessageTo('My opinions are aggressive, I admit that. But not my personality. I am sociable. ', brain)
                        end
                        for _, unit in enemyExpNaval do
                            if unit and not unit:BeenDestroyed() and Random(0, 6) <= math.floor(NukesPerStrikeAI * 0.33 + 0.5) then
                                CreateAndLaunchNukeAtEnemyUnit(unit)
                            end
                        end
                    end
                end
			 break
            end	
        until GetGameTimeSeconds() > 20000
    end)
end
function MonitoringEnemyExpArtyFunction() -- Disabled
    local circle = ForkThread(function()
        repeat
            WaitSeconds(Random(Nukex1, Nukex2))
            for i, brain in humanBrains.HBrains do
                WaitTicks(20)
                if not IsAlly(aiBrain:GetArmyIndex(), brain:GetArmyIndex()) then
                    local enemyExpArty = brain:GetListOfUnits(categories.EXPERIMENTAL * categories.ARTILLERY * categories.STRATEGIC - categories.FACTORY - categories.DEFENSE - categories.MOBILE, false)
                    if table.getn(enemyExpArty) > Random(1, 2) and NukesOn == "On" then
                        if Random(1, 2) == 1 then
                            AIMessageTo('You are hitting me hard, but I will hit you harder ', brain)
                        else
                            AIMessageTo('Your experimental arty wont stop me! ', brain)
                        end
                        for _, unit in enemyExpArty do
                            if unit and not unit:BeenDestroyed() and Random(0, 4) <= math.floor(NukesPerStrikeAI * 0.5 + 0.5) then
                                CreateAndLaunchNukeAtEnemyUnit(unit)
                            end
                        end
                    end
                end
			 break
            end
        until GetGameTimeSeconds() > 20000
    end)
end
function MonitoringAIExpArtyFunction()
    local circle = ForkThread(function()
        repeat
            WaitTicks(600)
            if totalEnemyExpShields > table.getn(humanBrains.HBrains) * 0.5 then
                local aiExpArty = aiBrain:GetListOfUnits(categories.EXPERIMENTAL * categories.STRATEGIC * categories.ARTILLERY, false)
                for _, unit in aiExpArty do
                    if unit and not unit:BeenDestroyed() then
                        ModifyUnitWeaponsFireRate(unit, (GetGameTimeSeconds() - WavesStartTimeAI) / (HoldTimeAI + 600))
                    end
                end
            end
        until GetGameTimeSeconds() > 20000
    end)
end
function MonitoringEnemyExpDefencesFunction() -- Disabled
    local circle = ForkThread(function()
        repeat
            WaitSeconds(Random(Nukex1, Nukex2))
            for i, brain in humanBrains.HBrains do
                WaitTicks(20)
                if not IsAlly(aiBrain:GetArmyIndex(), brain:GetArmyIndex()) then
                    local enemyExpDefences = brain:GetListOfUnits(categories.EXPERIMENTAL * categories.STRUCTURE * categories.DEFENSE * categories.DIRECTFIRE, false)
                    if table.getn(enemyExpDefences) > Random(8, 12) and NukesOn == "On" then
                        if Random(1, 2) == 1 then
                            AIMessageTo('Nice defences you have, can I touch them? ', brain)
                        else
                            AIMessageTo('Spamming experimantal defences wont stop my forces! ', brain)
                        end
                        for _, unit in enemyExpDefences do
                            if unit and not unit:BeenDestroyed() and Random(0, 8) <= math.floor(NukesPerStrikeAI * 0.5 + 0.5) then
                                CreateAndLaunchNukeAtEnemyUnit(unit)
                            end
                        end
                    end
                end
			 break
            end	
        until GetGameTimeSeconds() > 20000
    end)
end
function GetClosestEnemyUnitToHQ(HQUnit, maxDistance)
    local closestEnemyUnit = nil
    local sizeX, sizeZ = GetMapSize()
    local closestDistance = maxDistance 
    for i, brain in humanBrains.HBrains do
        WaitTicks(10)
        if brain and not brain:IsDefeated() then
            local huUnitsList = brain:GetListOfUnits(categories.MOBILE - categories.SATELLITE - categories.AIR, false)
            for i, huUnit in huUnitsList do
                WaitTicks(2)
                if HQUnit and not HQUnit:BeenDestroyed() then
                    if huUnit and not huUnit:BeenDestroyed() then
                        local aiPosX, aiPosY, aiPosZ = HQUnit:GetPositionXYZ()
                        local huPosX, huPosY, huPosZ = huUnit:GetPositionXYZ()
                        local distance = VDist2Sq(huPosX, huPosZ, aiPosX, aiPosZ)
                        if distance < closestDistance then
                            --[[if Random(1, 2) == 1 then
                                AIMessageTo('You have the courage to reach my base!, I will deal with it! ', brain)
                            else
                                AIMessageTo('You are annoying me ', brain)
                            end]]--
							PrintText("Enemy Detected Near HQ!", 30, 'c71c1c', 4, 'center')
                            closestEnemyUnit = huUnit
                            return closestEnemyUnit
                        end
                    end
                else
                    break
                end
            end
        end
    end
    return closestEnemyUnit
end
function NavalUnitsSpawnWaves()  -- Enabled Spawns Navy Waves
    local circle = ForkThread(function()
        LOG("sa: Running  NavalUnitsSpawnMonitoring")
        --repeat
            WaitTicks(Random(1, 6))
            local validPosCount = table.getn(validWaterPositions.positions)
            --local navalUnitsCount = table.getn(navalUnitsHeavy.Tech3)
            --local aiNavalUnitsNum = table.getn(aiBrain:GetListOfUnits(categories.MOBILE * categories.NAVAL, false))
            if validPosCount > 0 then
				local Position = Random(1, validPosCount)
                local validPosX = (validWaterPositions.positions)[Position][1]
                local validPosZ = (validWaterPositions.positions)[Position][3] --Random(1, validPosCount)
				if CrazyModeNavy == "Normal Navy" then
					randNavalUnit = GetRandomizedIDforNavy()
				elseif CrazyModeNavy == "Tech 1 Navy Only" then
					randNavalUnit = (LNavyUnits.Tech4)[Random(1, LNavy)]
				elseif CrazyModeNavy == "Tech 2 Navy Only" then
					randNavalUnit = (MNavyUnits.Tech4)[Random(1, MNavy)]
				elseif CrazyModeNavy == "Tech 3 Navy Only" then
					randNavalUnit = (HNavyUnits.Tech4)[Random(1, HNavy)]
				elseif CrazyModeNavy == "Experimental Navy Only" then
					randNavalUnit = (ENavyUnits.Tech4)[Random(1, ENavy)]
				end
                SpawnEnemyUnitAtPosition(randNavalUnit, validPosX, validPosZ, 0, 0)
            end
        --until GetGameTimeSeconds() > 20000
    end)
end
function NavalUnitsSpawnWaves2ndSpawn()  -- Enabled Spawns Navy Waves at 2ndSpawn
    local circle = ForkThread(function()
        LOG("sa: Running  NavalUnitsSpawnMonitoring")
        --repeat
            WaitTicks(Random(1, 6))
            local validPosCount = table.getn(validWaterPositions.positions)
            --local navalUnitsCount = table.getn(navalUnitsHeavy.Tech3)
            --local aiNavalUnitsNum = table.getn(aiBrain:GetListOfUnits(categories.MOBILE * categories.NAVAL, false))
            if validPosCount > 0 then
				local Position = Random(1, validPosCount)
                local validPosX = (validWaterPositions2.positions2)[Position][1]
                local validPosZ = (validWaterPositions2.positions2)[Position][3] --Random(1, validPosCount)
				if CrazyModeNavy == "Normal Navy" then
					randNavalUnit = GetRandomizedIDforNavy()
				elseif CrazyModeNavy == "Tech 1 Navy Only" then
					randNavalUnit = (LNavyUnits.Tech4)[Random(1, LNavy)]
				elseif CrazyModeNavy == "Tech 2 Navy Only" then
					randNavalUnit = (MNavyUnits.Tech4)[Random(1, MNavy)]
				elseif CrazyModeNavy == "Tech 3 Navy Only" then
					randNavalUnit = (HNavyUnits.Tech4)[Random(1, HNavy)]
				elseif CrazyModeNavy == "Experimental Navy Only" then
					randNavalUnit = (ENavyUnits.Tech4)[Random(1, ENavy)]
				end
                SpawnEnemyUnitAtPosition(randNavalUnit, validPosX, validPosZ, 0, 0)
            end
        --until GetGameTimeSeconds() > 20000
    end)
end
function ValidWaterPositionsMonitoring()
    local circle = ForkThread(function()
        LOG("sa: Running  ValidWaterPositionsMonitoring")
        local sizeX, sizeZ = GetMapSize()
        local terrainAttitude
        local surfaceAttitude
        local randX
        local randZ
		local MapDistanceX
		local AdjustAIx
		local MapDistanceZ
		local AdjustAIz
		local DifferenceX
		local DifferenceZ
		local maxDistance = 0
		local midPoint = GetRandomMidPointBetweenAIPosAndEnemyPos()
		local aiPos = aiBrain:GetListOfUnits(categories.OPERATION * categories.SPECIALHIGHPRI * categories.STRUCTURE * categories.CIVILIAN * categories.TECH3 * categories.OMNI, false)[1]:GetPosition()
		local maxDistance = VDist2Sq(aiPos[1], aiPos[3], midPoint[1], midPoint[3])
        local currentDistance
		if maxDistance < 40000 then
			maxDistance = 40000
		end
		if sizeX >= 1024 or sizeZ >= 1024 then
			MapDistanceX = math.floor(sizeX * 0.68)
			MapDistanceZ = math.floor(sizeZ * 0.68)
			maxDistance = maxDistance + 16000
		elseif sizeX == 512 or sizeZ == 512 then
			MapDistanceX = math.floor(sizeX * 0.68)
			MapDistanceZ = math.floor(sizeZ * 0.68)
			maxDistance = maxDistance + 10000
		else
			MapDistanceX = math.floor(sizeX * 0.68)
			MapDistanceZ = math.floor(sizeZ * 0.68)
		end
		AdjustAIx = math.floor(MapDistanceX * 0.5)
		AdjustAIz = math.floor(MapDistanceZ * 0.5)
        repeat
			WaitTicks(30)
            randX = aiPos[1] - AdjustAIx + Random(0, MapDistanceX)
			if randX <= 0 then
				DifferenceX = AdjustAIx + aiPos[1]
				randX = Random(1, DifferenceX)
			end	
			if randX > sizeX then
				DifferenceX = sizeX - aiPos[1] - AdjustAIx
				randX = Random(DifferenceX, sizeX)
			end	
            randZ = aiPos[3] - AdjustAIz + Random(0, MapDistanceZ)
			if randZ <= 0 then
				DifferenceZ = AdjustAIz + aiPos[3]
				randZ = Random(1, DifferenceZ)
			end	
			if randZ > sizeZ then
				DifferenceZ = sizeZ - aiPos[3] - AdjustAIz
				randZ = Random(DifferenceZ, sizeZ)
			end	
            --distance = VDist2Sq(randX, randZ, aiPos[1], aiPos[3])
            terrainAttitude = GetTerrainHeight(randX, randZ)
            surfaceAttitude = GetSurfaceHeight(randX, randZ)
            currentDistance = VDist2Sq(aiPos[1], aiPos[3], randX, randZ)
            if surfaceAttitude - terrainAttitude > 2 and currentDistance < maxDistance then
                local newPos = { randX, terrainAttitude, randZ, type = "VECTOR3" }
                table.insert(validWaterPositions.positions, newPos)
                if table.getn(validWaterPositions.positions) > 30 then
                    break
                end
            end
        until GetGameTimeSeconds() > 900 or won == true
		
    end)
end
function ValidWaterPositionsMonitoring2ndSpawn()
    local circle = ForkThread(function()
        LOG("sa: Running  ValidWaterPositionsMonitoring")
        local sizeX, sizeZ = GetMapSize()
        local terrainAttitude
        local surfaceAttitude
        local randX
        local randZ
		local MapDistanceX
		local AdjustAIx
		local MapDistanceZ
		local AdjustAIz
		local DifferenceX
		local DifferenceZ
		local maxDistance = 0
		local midPoint = GetRandomMidPointBetween2ndSpawnPosAndEnemyPos()
		local aiPos = AISecondBuilding:GetPosition()
		local maxDistance = VDist2Sq(aiPos[1], aiPos[3], midPoint[1], midPoint[3])
        local currentDistance
		if maxDistance < 40000 then
			maxDistance = 40000
		end
		if sizeX >= 1024 or sizeZ >= 1024 then
			MapDistanceX = math.floor(sizeX * 0.68)
			MapDistanceZ = math.floor(sizeZ * 0.68)
			maxDistance = maxDistance + 16000
		elseif sizeX == 512 or sizeZ == 512 then
			MapDistanceX = math.floor(sizeX * 0.68)
			MapDistanceZ = math.floor(sizeZ * 0.68)
			maxDistance = maxDistance + 10000
		else
			MapDistanceX = math.floor(sizeX * 0.68)
			MapDistanceZ = math.floor(sizeZ * 0.68)
		end
		AdjustAIx = math.floor(MapDistanceX * 0.5)
		AdjustAIz = math.floor(MapDistanceZ * 0.5)
        repeat
			WaitTicks(30)
            randX = aiPos[1] - AdjustAIx + Random(0, MapDistanceX)
			if randX <= 0 then
				DifferenceX = AdjustAIx + aiPos[1]
				randX = Random(1, DifferenceX)
			end	
			if randX > sizeX then
				DifferenceX = sizeX - aiPos[1] - AdjustAIx
				randX = Random(DifferenceX, sizeX)
			end	
            randZ = aiPos[3] - AdjustAIz + Random(0, MapDistanceZ)
			if randZ <= 0 then
				DifferenceZ = AdjustAIz + aiPos[3]
				randZ = Random(1, DifferenceZ)
			end	
			if randZ > sizeZ then
				DifferenceZ = sizeZ - aiPos[3] - AdjustAIz
				randZ = Random(DifferenceZ, sizeZ)
			end	
            --distance = VDist2Sq(randX, randZ, aiPos[1], aiPos[3])
            terrainAttitude = GetTerrainHeight(randX, randZ)
            surfaceAttitude = GetSurfaceHeight(randX, randZ)
            currentDistance = VDist2Sq(aiPos[1], aiPos[3], randX, randZ)
            if surfaceAttitude - terrainAttitude > 2 and currentDistance < maxDistance then
                local newPos = { randX, terrainAttitude, randZ, type = "VECTOR3" }
                table.insert(validWaterPositions2.positions2, newPos)
                if table.getn(validWaterPositions2.positions2) > 30 then
                    break
                end
            end
        until GetGameTimeSeconds() > 900 or won == true
		
    end)
end
function SpawnEnemyUnitAtPosition(unitId, posX, posZ, minOffset, maxOffset) --Navy Spawn
    local circle = ForkThread(function(self)
		--local MapCheck = false
		local Chance
		--local count = 0
        local unit = nil
        if GetGameTimeSeconds() > WavesStartTimeAI then
            rspawn = unitId
            if rspawn ~= nil then
                local oldposX = posX
				local oldposZ = posZ
					Chance = Random(1, 8)
					if Chance == 1 then
						posX = posX + Random(1, 5)
						posZ = posZ + Random(1, 5)
					elseif Chance == 2 then
						posX = posX - Random(1, 5)
						posZ = posZ + Random(1, 5)
					elseif Chance == 3 then
						posX = posX + Random(1, 5)
						posZ = posZ - Random(1, 5)
					elseif Chance == 4 then
						posX = posX - Random(1, 5)
						posZ = posZ - Random(1, 5)
					elseif Chance == 5 then
						posZ = posZ + Random(1, 5)
						posX = posX + Random(1, 5)
					elseif Chance == 6 then
						posZ = posZ - Random(1, 5)
						posX = posX + Random(1, 5)
					elseif Chance == 7 then
						posZ = posZ + Random(1, 5)
						posX = posX - Random(1, 5)
					else
						posZ = posZ - Random(1, 5)
						posX = posX - Random(1, 5)
					end

					if posX <= 0 then
						posX = Random(1, 5)
					end
					if posX >= sizeX then
						posX = sizeX - Random(1, 5)
					end
					if posZ <= 0 then
						posZ = Random(1, 5)
					end
					if posZ >= sizeZ then
						posZ = sizeZ - Random(1, 5)
					end
				unit = aiBrain:CreateUnitNearSpot(rspawn, posX, posZ)
				if unit == nil then
					local posX = oldposX
					local posZ = oldposZ
						Chance = Random(1, 8)
						if Chance == 1 then
							posX = posX + Random(1, 5)
							posZ = posZ + Random(1, 5)
						elseif Chance == 2 then
							posX = posX - Random(1, 5)
							posZ = posZ + Random(1, 5)
						elseif Chance == 3 then
							posX = posX + Random(1, 5)
							posZ = posZ - Random(1, 5)
						elseif Chance == 4 then
							posX = posX - Random(1, 5)
							posZ = posZ - Random(1, 5)
						elseif Chance == 5 then
							posZ = posZ + Random(1, 5)
							posX = posX + Random(1, 5)
						elseif Chance == 6 then
							posZ = posZ - Random(1, 5)
							posX = posX + Random(1, 5)
						elseif Chance == 7 then
							posZ = posZ + Random(1, 5)
							posX = posX - Random(1, 5)
						else
							posZ = posZ - Random(1, 5)
							posX = posX - Random(1, 5)
						end

						if posX <= 0 then
						posX = Random(1, 5)
						end
						if posX >= sizeX then
							posX = sizeX - Random(1, 5)
						end
						if posZ <= 0 then
							posZ = Random(1, 5)
						end
						if posZ >= sizeZ then
							posZ = sizeZ - Random(1, 5)
						end
					local terrainAltitude = GetTerrainHeight(posX, posZ)
					unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
                end
            end
        end
        if unit and unit ~= nil and not unit.Dead and (HPBonusAI > 0 or ParagonCycle ~= "Off") then
                    if GameTime < 0.33 then
						totalIncrease = HealthBonus
                        maxhp = unit:GetMaxHealth()
                        unit:SetMaxHealth(maxhp + totalIncrease)
					elseif GameTime >= 0.33 and GameTime < 0.66 then
						totalIncrease = HealthBonus * 1.5
                        maxhp = unit:GetMaxHealth()
                        unit:SetMaxHealth(maxhp + totalIncrease)
					elseif GameTime >= 0.66 and GameTime < 1 then
						totalIncrease = HealthBonus * 2 + Random(2000, 2500) * totalEnemyEndgamers
                        maxhp = unit:GetMaxHealth()
                        unit:SetMaxHealth(maxhp + totalIncrease)
					elseif GameTime >= 1 then
						totalIncrease = HealthBonus * 2.5 + Random(2500, 4500) * totalEnemyEndgamers
                        maxhp = unit:GetMaxHealth()
                        unit:SetMaxHealth(maxhp + totalIncrease)
					end
            hp = unit:GetMaxHealth()
            unit:SetHealth(self, hp)
            unit:SetReclaimable(false)
        end
		unit:SetSpeedMult(1 + (waveNum * SpeedBonus + SpeedBonusOnce) * 0.5)
		if DamageBoost ~= 'Off - 0' then
			ModifyWeaponDamageBuffAndRange(unit)
		end	
		if WaveStyle == "Even Attack Waves" then	
			RedirectUnit(unit)
		elseif WaveStyle == "Dynamic Attack Waves" or WaveStyle == "Human with AI Assist" then
			RedirectUnitNavy(unit)
		end
		if KillPlayerUnit > 0 then
			SuicideLandNavyUnit(unit)
		end	
        KillThread(self)
    end)
end
function DoomElectronStormsSpawner()
    local circle = ForkThread(function()
		local sizeX, sizeZ = GetMapSize()
		local StormCount = 3
		local validPosX
		local validPosZ
		local Storms
		if sizeX >= 1024 or sizeZ >= 1024 then
				StormCount = 27
		elseif sizeX == 512 or sizeZ == 512 then
				StormCount = 9
		end
		--repeat
			PrintText("== WARNING! Electron Storms Forming! ==", 28, 'ffCBFFFF', 10, 'center')
			WaitSeconds(10)
			Storms = math.floor(StormCount * DoomStormMulti + 0.5)
			if Storms < 1 then
				Storms = 1
			end
			repeat
				validPosX = Random(10, sizeX - 10)
				validPosZ = Random(10, sizeZ - 10)
				SpawnElectronStormAt('SPIRIT0402', validPosX, validPosZ, 1, 1)
				Storms = Storms - 1
				WaitTicks(1)
			until Storms < 1
		--until GetGameTimeSeconds() > 20000
		--KillThread(self)
    end)
end
function SpawnElectronStormAt(unitId, posX, posZ, minOffset, maxOffset) --Electron Storm Spawn
    local circle = ForkThread(function(self)
        local unit = nil
		--local MapCheck = false
		local Chance
		--local count = 0
        if GetGameTimeSeconds() > WavesStartTimeAI then
            rspawn = unitId
            if rspawn ~= nil then
                local oldposX = posX
                local oldposZ = posZ
                unit = aiBrain:CreateUnitNearSpot(rspawn, posX, posZ)
                if unit == nil then
                    local posX = oldposX
                    local posZ = oldposZ
						Chance = Random(1, 8)
						if Chance == 1 then
							posX = posX + Random(1, 5)
							posZ = posZ + Random(1, 5)
						elseif Chance == 2 then
							posX = posX - Random(1, 5)
							posZ = posZ + Random(1, 5)
						elseif Chance == 3 then
							posX = posX + Random(1, 5)
							posZ = posZ - Random(1, 5)
						elseif Chance == 4 then
							posX = posX - Random(1, 5)
							posZ = posZ - Random(1, 5)
						elseif Chance == 5 then
							posZ = posZ + Random(1, 5)
							posX = posX + Random(1, 5)
						elseif Chance == 6 then
							posZ = posZ - Random(1, 5)
							posX = posX + Random(1, 5)
						elseif Chance == 7 then
							posZ = posZ + Random(1, 5)
							posX = posX - Random(1, 5)
						else
							posZ = posZ - Random(1, 5)
							posX = posX - Random(1, 5)
						end

						if posX <= 0 then
						posX = Random(1, 5)
						end
						if posX >= sizeX then
							posX = sizeX - Random(1, 5)
						end
						if posZ <= 0 then
							posZ = Random(1, 5)
						end
						if posZ >= sizeZ then
							posZ = sizeZ - Random(1, 5)
						end
                    local terrainAltitude = GetTerrainHeight(posX, posZ)
                    unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
                end
            end
        end
        KillThread(self)
    end)
end
CalculateTotalAINukeSubs = function()
    local totalNukeSubs = 0
    nukeSubmarines.subs = aiBrain:GetListOfUnits(categories.MOBILE * categories.NAVAL * categories.TECH3 * categories.SILO, false)
    totalNukeSubs = table.getn(nukeSubmarines.subs)
    return totalNukeSubs
end
function LaunchNukeAtEnemyFromNukeSubs()
    local targetedUnit = GetRandomEnemyDefenseUnitNuke()
    if not targetedUnit or targetedUnit:BeenDestroyed() or nukeSubmarines == nil or nukeSubmarines.subs == nil then
        return
    end
    for _, unit in nukeSubmarines.subs do
        if not unit:BeenDestroyed() then
            unit:GiveNukeSiloAmmo(1)
            IssueClearCommands({ unit })
            IssueNuke({ unit }, targetedUnit:GetPosition())
        end
    end
end
function LaunchNukeAtEnemyFromNukeSubs(targetedUnit)
    if not targetedUnit or targetedUnit:BeenDestroyed() or nukeSubmarines == nil or nukeSubmarines.subs == nil then
        return
    end
    for _, unit in nukeSubmarines.subs do
        if not unit:BeenDestroyed() then
            unit:GiveNukeSiloAmmo(1)
            IssueClearCommands({ unit })
            IssueNuke({ unit }, targetedUnit:GetPosition())
        end
    end
end
CalculateEnemyLevel = function(self)
    local level = enemyLevel.F
	--totalEnemyYolonas = CalculateTotalEnemyYolonas() 
    --totalEnemyParagons = CalculateTotalEnemyParagons() 
	totalEnemyExpDefences = CalculateTotalExpDefences() 
    totalEnemySMDs = CalculateTotalEnemySMDs() 
    totalTthreeRes = CalculateTotalEnemyUnitsOfCategory(self, categories.STRUCTURE * categories.TECH3 * categories.ECONOMIC) 
    totalExpUnits = CalculateTotalEnemyUnitsOfCategory(self, categories.MOBILE * categories.EXPERIMENTAL) 
    totalEnemyT3Defences = CalculateTotalT3Defences() 
	totalEnemyT3AirDefences = CalculateTotalT3AirDefences()
	totalEnemyT3LandDefences = CalculateTotalT3LandDefences()
    totalEnemyExpShields = CalculateTotalEnemyUnitsOfCategory(self, categories.STRUCTURE * categories.SHIELD * categories.EXPERIMENTAL) 
    --[[if PlayerLevel == "On" then
		local humans = table.getn(humanBrains.HBrains)
		local levelFactor = 0
		if humans <= 1 then
			levelFactor = ((totalEnemyYolonas * 100) + (totalEnemyParagons * 100) +
				(totalEnemyExpDefences * 8) + (totalEnemyT3Defences * 3) + (totalTthreeRes * 4) + (totalExpUnits * 5) + (totalEnemyExpShields * 20)) * 2
		else
			levelFactor = ((totalEnemyYolonas * 100) + (totalEnemyParagons * 100) +
				(totalEnemyExpDefences * 8) + (totalEnemyT3Defences * 3) + (totalTthreeRes * 4) + (totalExpUnits * 5) + (totalEnemyExpShields * 20)) / (1 / humans)
		end
		if totalEnemyYolonas > 0 or totalEnemyParagons > 0 then
			if levelFactor <= 2000 then
				level = enemyLevel.D
			elseif levelFactor > 2000 and levelFactor < 4000 then
				level = enemyLevel.C
			elseif levelFactor > 4000 and levelFactor < 7000 then
				level = enemyLevel.B
			elseif levelFactor > 7000 and levelFactor < 12000 then
				level = enemyLevel.A
			elseif levelFactor > 12000 then
				level = enemyLevel.S
			end
			if ((GetGameTimeSeconds() - WavesStartTimeAI) / HoldTimeAI) > 0.75 and levelFactor > 1500 and levelFactor <= 5000 and (totalEnemyYolonas > 1 or totalEnemyParagons > 1) then
				level = enemyLevel.A
			end
		else
			if levelFactor <= 1000 then
				level = enemyLevel.D
			elseif levelFactor > 1500 and levelFactor < 2500 then
				level = enemyLevel.C
			elseif levelFactor > 2500 and levelFactor < 4000 then
				level = enemyLevel.B
			elseif levelFactor > 4000 and levelFactor < 6000 then
				level = enemyLevel.A
			elseif levelFactor > 6000 then
				level = enemyLevel.S
			end
		end
    end]]--
	--return level
end
CalculateTotalEnemyYolonas = function(self) --disabled
    local totalYolonas = 0
    for i, brain in humanBrains.HBrains do
        if not IsAlly(aiBrain:GetArmyIndex(), brain:GetArmyIndex()) then
            local enemyYols = 0
			enemyYols = brain:GetListOfUnits(categories.STRUCTURE * categories.EXPERIMENTAL * categories.SILO, false) --categories.TACTICALMISSILEPLATFORM
            totalYolonas = table.getn(enemyYols)
            --[[for _, unit in enemyYols do
                local entityId = unit:GetEntityId()
                if not enemyYolonas.Yols[entityId] then
                    enemyYolonas.Yols[entityId] = unit
                end
            end]]--
        end
    end
    return totalYolonas
end
CalculateTotalEnemyYolos = function(self)
    local totalYolos = 0
    for i, brain in humanBrains.HBrains do
        if not IsAlly(aiBrain:GetArmyIndex(), brain:GetArmyIndex()) then
            local Yolos = brain:GetListOfUnits((categories.STRUCTURE * categories.EXPERIMENTAL * categories.SILO) - categories.TACTICALMISSILEPLATFORM, false)
            totalYolos = totalYolos + table.getn(Yolos)
        end
    end
    return totalYolos
end
CalculateTotalSACUs = function(self)
    local totalSACUs = 0
    for i, brain in humanBrains.HBrains do
        if not IsAlly(aiBrain:GetArmyIndex(), brain:GetArmyIndex()) then
            local SACUs = brain:GetListOfUnits(categories.SUBCOMMANDER, false)
            totalSACUs = totalSACUs + table.getn(SACUs)
        end
    end
    return totalSACUs
end
CalculateTotalACUs = function(self)
    local totalACUs = 0
    for i, brain in humanBrains.HBrains do
        if not IsAlly(aiBrain:GetArmyIndex(), brain:GetArmyIndex()) then
            local ACUs = brain:GetListOfUnits(categories.COMMAND, false)
            totalACUs = totalACUs + table.getn(ACUs)
        end
    end
    return totalACUs
end
function CheckForOtherParagonsIds()
    for id, bp in pairs(__blueprints) do
        if (bp.Categories and string.len(id) >= 5) then
            if id == "inb1404" or id == "uab1404" or id == "ueb1404" or id == "urb1404"
                or id == "xsb1404" then
                otherParagonIds = true
                break
            end
        end
    end
end
CalculateTotalEnemyParagons = function(self)
    local totalParagons = 0
    for i, brain in humanBrains.HBrains do
        if not IsAlly(aiBrain:GetArmyIndex(), brain:GetArmyIndex()) then
            local paragons = 0
            if otherParagonIds then
                paragons = brain:GetListOfUnits((categories.xab1401) + (categories.inb1404) + (categories.uab1404)
                    + (categories.ueb1404) + (categories.urb1404) + (categories.xsb1404), false)
            else
                paragons = brain:GetListOfUnits(categories.xab1401, false)
            end
            totalParagons = totalParagons + table.getn(paragons)
        end
    end
    return totalParagons
end
CalculateTotalEnemySMDs = function(self)
    local totalSMDs = 0
    for i, brain in humanBrains.HBrains do
        if not IsAlly(aiBrain:GetArmyIndex(), brain:GetArmyIndex()) then
            local SMDs = brain:GetListOfUnits(categories.STRUCTURE * categories.TECH3 * categories.DEFENSE * categories.ANTIMISSILE, false)
            totalSMDs = totalSMDs + table.getn(SMDs)
        end
    end
    return totalSMDs
end
CalculateTotalExpDefences = function(self)
    local totalDefences = 0
    for i, brain in humanBrains.HBrains do
        if not IsAlly(aiBrain:GetArmyIndex(), brain:GetArmyIndex()) then
            local defencesList = brain:GetListOfUnits(categories.STRUCTURE * categories.EXPERIMENTAL * categories.DEFENSE, false)
            totalDefences = totalDefences + table.getn(defencesList)
        end
    end
    return totalDefences
end
CalculateTotalEnemyUnitsOfCategory = function(self, Category)
    local totalUnits = 0
    for i, brain in humanBrains.HBrains do
        if not IsAlly(aiBrain:GetArmyIndex(), brain:GetArmyIndex()) then
            local unitList = brain:GetListOfUnits(Category, false)
            totalUnits = totalUnits + table.getn(unitList)
        end
    end
    return totalUnits
end
CalculateTotalFriendlyNomanders = function(self)
    local totalUnits = 0
    for i, brain in ArmyBrains do
        if not IsEnemy(aiBrain:GetArmyIndex(), brain:GetArmyIndex()) then
            local unitList = brain:GetListOfUnits(categories.aar0310, false)
            totalUnits = totalUnits + table.getn(unitList)
        end
    end
    return totalUnits
end
CalculateTotalT3Defences = function(self)
    local totalDefences = 0
    for i, brain in humanBrains.HBrains do
        if not IsAlly(aiBrain:GetArmyIndex(), brain:GetArmyIndex()) then
            local defencesList = brain:GetListOfUnits(categories.STRUCTURE * categories.TECH3 * categories.DEFENSE, false)
            totalDefences = totalDefences + table.getn(defencesList)
        end
    end
    return totalDefences
end
CalculateTotalT3AirDefences = function(self)
    local totalDefences = 0
    for i, brain in humanBrains.HBrains do
        if not IsAlly(aiBrain:GetArmyIndex(), brain:GetArmyIndex()) then
            local defencesList = brain:GetListOfUnits(categories.STRUCTURE * categories.TECH3 * categories.DEFENSE * categories.ANTIAIR, false)
            totalDefences = totalDefences + table.getn(defencesList)
        end
    end
    return totalDefences
end
CalculateTotalExpAirDefences = function(self)
    local totalDefences = 0
    for i, brain in humanBrains.HBrains do
        if not IsAlly(aiBrain:GetArmyIndex(), brain:GetArmyIndex()) then
            local defencesList = brain:GetListOfUnits(categories.STRUCTURE * categories.EXPERIMENTAL * categories.DEFENSE * categories.ANTIAIR, false)
            totalDefences = totalDefences + table.getn(defencesList)
        end
    end
    return totalDefences
end
CalculateTotalT3LandDefences = function(self)
    local totalDefences = 0
    for i, brain in humanBrains.HBrains do
        if not IsAlly(aiBrain:GetArmyIndex(), brain:GetArmyIndex()) then
            local defencesList = brain:GetListOfUnits(categories.STRUCTURE * categories.TECH3 * categories.DEFENSE * categories.DIRECTFIRE, false)
            totalDefences = totalDefences + table.getn(defencesList)
        end
    end
    return totalDefences
end
CalculateAITotalAirUnits = function(self)
    local totalAir = -1
    if aiBrain and not aiBrain:IsDefeated() then
        local airList = aiBrain:GetListOfUnits(categories.MOBILE * categories.EXPERIMENTAL * categories.AIR, false)
        totalAir = table.getn(airList)
    end
    return totalAir
end
function MonitoringStationAssistPodsCount()
    local circle = ForkThread(function(self)
        repeat
            WaitTicks(50)
            if humanBrains and humanBrains.HBrains then
                for aindex, hbrain in humanBrains.HBrains do
                    if hbrain then
                        WaitTicks(10)
                        local hivesList = hbrain:GetListOfUnits(categories.ENGINEERSTATION, false)
                        local hives = table.getn(hivesList)
                        if hives > HivesPerPlayerAI then
                            AddBuildRestriction(hbrain:GetArmyIndex(), categories.ENGINEERSTATION)
                        else
                            RemoveBuildRestriction(hbrain:GetArmyIndex(), categories.ENGINEERSTATION)
                        end
                    end
                end
            end
        until GetGameTimeSeconds() > 20000
    end)
end
function MonitoringSalvationPlayer()
    local circle = ForkThread(function(self)
	local SalvationACU
	local SuicideList
	local ACUcount = 0
	local HalfOfHumans = math.floor(humans * 0.5 + 0.5)
	local aiUnit
        repeat
            WaitSeconds(20)
			if salvationspawn ~= "Half of Team" then
				SalvationACU = SalvationBrain:GetListOfUnits(categories.COMMAND, false)
				ACUcount = table.getn(SalvationACU)
			else
				local AllTeamsACUs = {}
				local PlayerACUs = {}
				for i, brain in humanBrains.HBrains do
					if brain and not brain:IsDefeated() then
						PlayerACUs = brain:GetListOfUnits(categories.COMMAND, false)
						for i = 1, table.getn(PlayerACUs) do
							AllTeamsACUs[table.getn(AllTeamsACUs) + 1] = PlayerACUs[i]
						end
					end	
				end
				ACUcount = table.getn(AllTeamsACUs)
				if humans >= 3 and ACUcount <= HalfOfHumans then
					ACUcount = 0
				elseif humans == 2 and ACUcount < 2 then
					ACUcount = 0
				end	
			end			
			if ACUcount == 0 and salvationBOOM == 'Entire Wave Destroyed' then
				SuicideList = aiBrain:GetListOfUnits(categories.MOBILE - categories.ENGINEER - categories.COMMAND, false)
				PrintText("== SALVATION! Wave Destroyed! ==", 28, 'ffCBFFFF', 10, 'center')
				local killcount = 0
				for i, aiUnit in SuicideList do
					if aiUnit and not aiUnit:BeenDestroyed() then
						aiUnit:Kill()
					end
					killcount = killcount + 1
					if killcount == 20 then
						WaitTicks(2)
						killcount = 0
					end	
				end
				break
			elseif ACUcount == 0 and salvationBOOM == 'Dooms Immune' then
				SuicideList = aiBrain:GetListOfUnits(categories.MOBILE - categories.ENGINEER - categories.COMMAND - (categories.OPERATION * categories.MOBILE * categories.MASSIVE * categories.STRATEGIC * categories.BOT), false)
				PrintText("== SALVATION! Wave Destroyed! ==", 28, 'ffCBFFFF', 10, 'center')
				local killcount = 0
				for i, aiUnit in SuicideList do
					WaitTicks(1)
					if aiUnit and not aiUnit:BeenDestroyed() then
						aiUnit:Kill()
					end
					killcount = killcount + 1
					if killcount == 20 then
						WaitTicks(2)
						killcount = 0
					end	
				end
				break
			elseif ACUcount == 0 and salvationBOOM == 'Dooms and T4 Immune' then
				SuicideList = aiBrain:GetListOfUnits(categories.MOBILE - categories.ENGINEER - categories.COMMAND - (categories.OPERATION * categories.MOBILE * categories.MASSIVE * categories.STRATEGIC * categories.BOT) - categories.EXPERIMENTAL, false)
				PrintText("== SALVATION! Wave Destroyed! ==", 28, 'ffCBFFFF', 10, 'center')
				local killcount = 0
				for i, aiUnit in SuicideList do
					WaitTicks(1)
					if aiUnit and not aiUnit:BeenDestroyed() then
						aiUnit:Kill()
					end
					killcount = killcount + 1
					if killcount == 20 then
						WaitTicks(2)
						killcount = 0
					end	
				end
				break
			end			
        until GetGameTimeSeconds() > 20000 or won == true
    end)
end
function MonitoringAISecondaryBuildings() --Monitors Support Bases Count
	if SecondaryBuildingFlag ~= "Off" then
		local circle = ForkThread(function(self)
			local TotalCountSupportBases = math.floor((1 + math.floor(humans * 0.5 + 0.5)) * SupportBaseMulti + 0.5)
			if TotalCountSupportBases < 3 then
				TotalCountSupportBases = 3
			elseif TotalCountSupportBases > 16 then
				TotalCountSupportBases = 16
			end	
			WaitSeconds(60)
			repeat
				WaitTicks(40)
				if won == true then
					break
				end
				local BuildingCount = 0
				if aiSecondaryBuildings and aiSecondaryBuildings.secondaryBuildings then
					for aindex, sBuilding in aiSecondaryBuildings.secondaryBuildings do
						if sBuilding and not sBuilding:BeenDestroyed() then
							BuildingCount = BuildingCount + 1
						end
					end
				end
				if BuildingCount < TotalCountSupportBases and BuildingCount ~= 0 then
					SideObjsDestroyed = SideObjsDestroyed + 1
					RandomEffectBuildingDestroyed()
					TotalCountSupportBases = TotalCountSupportBases - 1
				end	
				WaitTicks(10)
				if won == true then
					break
				end
				--PrintText("Remaining Buildings " .. BuildingCount .. " Total", 28, 'ffCBFFFF', 6, 'center')
				--PrintText("Total Count Buildings After " .. TotalCountSupportBases .. " Total", 28, 'ffCBFFFF', 6, 'center')
				if BuildingCount == 0 and SecondaryBuildingsDead == false and GetGameTimeSeconds() > 60 then
					SideObjsDestroyed = SideObjsDestroyed + 1
					SecondaryBuildingsDead = true
					StunHQUnitsFinal()
					FinalDamageHQEffect(0.1)
					GrantResources()
					MainAIPowerCrash()
					ElectronStormsSpawner()
					if AlliedForceSpawned == false and SpawnAlliesForceFlag ~= 'Off' then
						AlliedForce = 2 + (humans * AlliedForceMultiplier)
						repeat
							SpawnAlliedForce()
							AlliedForce = AlliedForce - 1
						until AlliedForce < 1
						AlliedForcesSpawnWarning()
						AlliedForceSpawned = true
					end
					WaitSeconds(30)
					DestroyRandomBuildings()
				end
				if SecondaryBuildingsDead == true then
					break
				end	
			until GetGameTimeSeconds() > 20000 or won == true
			KillThread(self)
		end)
	end
end
function MonitoringAISecondaryBuildingsDefenses()
	if SecondaryBuildingFlag ~= "Off" then
		local circle = ForkThread(function(self)
			repeat
				WaitTicks(100)
				if aiSecondaryBuildings and aiSecondaryBuildings.secondaryBuildings then
					for aindex, sBuilding in aiSecondaryBuildings.secondaryBuildings do
						if sBuilding and not sBuilding:BeenDestroyed() and SecondaryBuildingsDead == false then
							local randCount = Random(2, 3)
							if GetGameTimeSeconds() > (WavesStartTimeAI	* 0.5) then
								repeat
									WaitTicks(2)
									CreateAUnitAroundSecondaryBuildingsForAI("")
									randCount = randCount - 1
								until randCount < 1
								WaitSeconds(285)
							end	
						end
					end
				end
				if SecondaryBuildingsDead == true then
					break
				end	
			until GetGameTimeSeconds() > 20000 or won == true
			KillThread(self)
		end)
	end
end
function MainAIPowerCrash()
	local circle = ForkThread(function(self)
		if SecondaryBuildingsDead == true then
			HQPowerStallMessage()
			local stalltime = GetGameTimeSeconds() + PowerStallTime
			repeat
				AIMainBuilding:SetProductionPerSecondEnergy(0)
				AIMainBuilding:SetConsumptionPerSecondEnergy(1000000)
				WaitTicks(10)
			until GetGameTimeSeconds() > stalltime
			--WaitSeconds(PowerStallTime)
			AIMainBuilding:SetProductionPerSecondEnergy(HQEnergy)
			AIMainBuilding:SetConsumptionPerSecondEnergy(0)
		end
		KillThread(self)
	end)
end	
function ElectronStormsSpawner()
    local circle = ForkThread(function()
		local sizeX, sizeZ = GetMapSize()
		local StormCount = 3
		local validPosX
		local validPosZ
		local Storms
		if sizeX >= 1024 or sizeZ >= 1024 then
				StormCount = 27
		elseif sizeX == 512 or sizeZ == 512 then
				StormCount = 9
		end
		--repeat
			PrintText("== WARNING! Electron Storms Forming! ==", 28, 'ffCBFFFF', 10, 'center')
			WaitSeconds(10)
			Storms = StormCount
			if Storms < 1 then
				Storms = 1
			end
			repeat
				validPosX = Random(10, sizeX - 10)
				validPosZ = Random(10, sizeZ - 10)
				SpawnElectronStormAt('SPIRIT0402', validPosX, validPosZ, 1, 1)
				Storms = Storms - 1
				WaitTicks(1)
			until Storms < 1
		--until GetGameTimeSeconds() > 20000
		--KillThread(self)
    end)
end
function RandomEffectBuildingDestroyed()
	local circle = ForkThread(function(self)
	local count = 1 + SideObjsDestroyed
	local count2 = 2 + math.floor(SideObjsDestroyed * 1.5 + 0.5)
	local gurantee = math.floor((1 + math.floor(humans * 0.5 + 0.5)) * SupportBaseMulti + 0.5) * 0.5
		if gurantee < 1 then
			gurantee = 1
		elseif gurantee > 8 then
			gurantee = 8
		end		
	local chance
			if Random(1, 10) <= 8 then
				StunHQUnits()
				if Random(1, 3) == 2 then
					ReinforcementsForTeam(count)
				end
				DamageHQEffect()
				GrantResources()
			else	
				PrintText("Coms Jammed Failed!", 28, 'ffDD1313', 6, 'center')
				DamageHQEffect()
				if Random(1, 3) <= 2 then
					ReinforcementsForTeam(count)
				end
				GrantResources()
			end
			if Random(1, 10) <= 6 or SideObjsDestroyed > gurantee then
				if SupportBaseNukes == 'SB Nuke Retaliation - On' then
					chance = Random(1, 6)
					if chance == 1 or chance == 3 then
						BossRetaliation(count)
					elseif chance == 2 or chance == 4 then
						if SideObjsDestroyed > 1 then
							NukeRetaliation(count)
						else
							if Random(1, 2) == 1 then
								BossRetaliation(count)
							else
								ArtilleryRetaliation(count)
							end
						end	
					else
						ArtilleryRetaliation(count)
					end	
				else
					if Random(1, 2) == 1 then
							BossRetaliation(count)
						else
							ArtilleryRetaliation(count)
					end
				end	
			end
			repeat
				TransportRetaliation()
				count2 = count2 - 1
				WaitSeconds(3)
			until count2 < 1
		KillThread(self)
	end)
end
function ResourcesOverTime() --Unused
	local circle = ForkThread(function(self)
	local count = 8 + (SideObjsDestroyed * 2)
		PrintText("Resupply Underway.", 28, 'ff0914E8', 6, 'center')
		repeat
			WaitSeconds(1)
			GrantResources()
			--count = count - 1
		until GetGameTimeSeconds() > 20000  --count < 1
		KillThread(self)
	end)
end	
function GrantResources()
	local circle = ForkThread(function(self)
		local count = 10 + (SideObjsDestroyed * 4)
		local brain
		PrintText("Resupply Underway.", 28, 'ff0914E8', 6, 'center')
			repeat
				for i, brain in humanBrains.HBrains do
					WaitSeconds(1)
					if brain and not brain:IsDefeated() then
						local army = brain
						army:GiveResource('MASS', 500)
						army:GiveResource('ENERGY', 37500)
					end
				end
				WaitTicks(1)
				count = count - 1
			until count < 1
		KillThread(self)
	end)
end	
function RandomEffectAltSpawnDestroyed()
	local circle = ForkThread(function(self)
	local count = 1 + math.floor(humans * 0.5 + 0.5)
	local count2 = 1 + math.floor(count * 1.5 + 0.5)
	local chance = Random(1, 6)
			StunHQUnitsFinal()	
			FinalDamageHQEffect(0.15)
			GrantResources()
			WaitSeconds(10)
			if Random(1, 2) == 1 then
				ReinforcementsForTeam(count)
			end
			if chance == 1 or chance == 3 then
				BossRetaliation(count)
			elseif chance == 2 or chance == 4 then
				NukeRetaliation(count)
			else
				ArtilleryRetaliation(count)
			end	
			repeat
				TransportRetaliation()
				count2 = count2 - 1
				WaitSeconds(5)
			until count2 < 1
		KillThread(self)
	end)
end	
function StunHQUnits()
	local circle = ForkThread(function(self)
			PrintText("Success! Enemy Coms Jammed!", 28, 'ff0914E8', 6, 'center')
			local unitList = aiBrain:GetListOfUnits(categories.MOBILE - categories.OPERATION - categories.SUBCOMMANDER - categories.COMMAND - categories.AIR, false)
			local aiUnit
			local stuncycle = 0
			for i, aiUnit in unitList do
				if aiUnit and not aiUnit:BeenDestroyed() then
					aiUnit:SetStunned(Random(5, 10))
				end
				stuncycle = stuncycle + 1
				if stuncycle == 20 then
					WaitTicks(2)
					stuncycle = 0
				end	
			end
		KillThread(self)
	end)
end	
function StunHQUnitsFinal()
	local circle = ForkThread(function(self)
			PrintText("Extended Enemy Coms Jammed!", 28, 'ff0914E8', 6, 'center')
			local unitList = aiBrain:GetListOfUnits(categories.MOBILE - categories.OPERATION - categories.SUBCOMMANDER - categories.COMMAND - categories.AIR, false)
			local aiUnit
			local stuncycle = 0
			for i, aiUnit in unitList do
				if aiUnit and not aiUnit:BeenDestroyed() then
					aiUnit:SetStunned(Random(30, 45))
				end
				stuncycle = stuncycle + 1
				if stuncycle == 20 then
					WaitTicks(2)
					stuncycle = 0
				end	
			end
		KillThread(self)
	end)
end
function DestroyRandomBuildings()
	local circle = ForkThread(function(self)
		local aiUnit
		PrintText("Defensive Structures have become unstable!", 28, 'ff0914E8', 6, 'center')
		repeat	
			local unitList = aiBrain:GetListOfUnits(categories.STRUCTURE - categories.OPERATION, false)
			local TableSize = table.getn(unitList)
			local aiUnit = (unitList)[Random(1, TableSize)]
				if aiUnit and not aiUnit:BeenDestroyed() then
					aiUnit:Kill()
				end
			if TableSize > 10 then
				WaitSeconds(Random(30, 40))
			else
				WaitSeconds(Random(40, 50))
			end
		until GetGameTimeSeconds() > 20000 or won == true
		KillThread(self)
	end)
end	
function ReinforcementsForTeam(num)
	local circle = ForkThread(function(self)
	local count = num - 1
		repeat
			SpawnInReinforcements()
			count = count - 1
			WaitTicks(2)
		until count < 1
		PrintText("Excellent Work! Reinforcements Deployed!", 28, 'ff0914E8', 6, 'center')
	KillThread(self)
	end)
end	
function DamageHQEffect()
	local circle = ForkThread(function(self)
	local HQMaxHP
	local HQCurrentHP
	local HQDamage
	local HQhp
	local Damage = 0.05
		if AIMainBuilding ~= nil and not AIMainBuilding:BeenDestroyed() then
			if Random(1, 3) == 2 then
				Damage = 0.07
			end	
			HQMaxHP = AIMainBuilding:GetMaxHealth()
			HQCurrentHP = AIMainBuilding:GetHealth()
			HQDamage = MainBuildingHPAI * Damage
			HQhp = HQCurrentHP - HQDamage
			if HQhp > 0 then
				AIMainBuilding:SetHealth(self, HQhp)
				PrintText("HQ Damaged! " .. HQhp .. " Health!", 28, 'ff0914E8', 6, 'center')
			else
				AIMainBuilding:Kill()
			end	
		end	
	KillThread(self)
	end)
end
function FinalDamageHQEffect(harm)
	local circle = ForkThread(function(self)
	local HQMaxHP
	local HQCurrentHP
	local HQDamage
	local HQhp
	local Damage = harm
		if AIMainBuilding ~= nil and not AIMainBuilding:BeenDestroyed() then
			HQMaxHP = AIMainBuilding:GetMaxHealth()
			HQCurrentHP = AIMainBuilding:GetHealth()
			HQDamage = MainBuildingHPAI * Damage
			HQhp = HQCurrentHP - HQDamage
			if HQhp > 0 then
				AIMainBuilding:SetHealth(self, HQhp)
				PrintText("Heavy HQ Damage! " .. HQhp .. " Health!", 28, 'ff0914E8', 6, 'center')
			else
				AIMainBuilding:Kill()
			end	
		end	
	KillThread(self)
	end)
end	
function BossRetaliation(num)
	local circle = ForkThread(function(self)
	local count = num - 1
		if count == 0 then
			count = 1
		end	
		repeat
			CreateHugeBossForYolonas()
			count = count - 1
			WaitTicks(2)
		until count < 1
		PrintText("WARNING! Powerful Units Detected!", 28, 'ffDD1313', 6, 'center')
	KillThread(self)
	end)
end	
function NukeRetaliation(num)
	local circle = ForkThread(function(self)
	local count = num
		PrintText("WARNING! Nuclear Strike Imminent!", 28, 'ffDD1313', 6, 'center')
		WaitSeconds(10)
		repeat
			CreateAndLaunchNukeAtEnemy()
			count = count - 1
		until count < 1
	KillThread(self)
	end)
end	
function TransportRetaliation()
	local circle = ForkThread(function(self)
		RetaliationTransport = true
		if Random(1, 8) <= 6 then
			TransportTechAttack()
		else	
			TransportExperimentalAttack()
		end	
	KillThread(self)
	end)
end	
function ArtilleryRetaliation(num)
	local circle = ForkThread(function(self)
	local count = 1 + num
		if SideObjsDestroyed > 1 then
			count = SideObjsDestroyed
		end
		PrintText("WARNING! Artillery Barrage Inbound!", 28, 'ffDD1313', 6, 'center')
		repeat
			SpawnArtilleryForRetaliation()
			count = count - 1
			WaitTicks(2)
		until count < 1
	KillThread(self)
	end)
end	
function SpawnArtilleryForRetaliation()
    local circle = ForkThread(function(self)
        local unit = nil
		--local MapCheck = false
		local Chance
		--local count = 0
        local posX, posZ = aiBrain:GetArmyStartPos()
        if GetGameTimeSeconds() > 60 then
            rspawn = "ARU2401"
            if rspawn ~= nil then
                local oldposX = posX
				local oldposZ = posZ
					Chance = Random(1, 8)
					if Chance == 1 then
						posX = posX + Random(1, 60)
						posZ = posZ + Random(1, 60)
					elseif Chance == 2 then
						posX = posX - Random(1, 60)
						posZ = posZ + Random(1, 60)
					elseif Chance == 3 then
						posX = posX + Random(1, 60)
						posZ = posZ - Random(1, 60)
					elseif Chance == 4 then
						posX = posX - Random(1, 60)
						posZ = posZ - Random(1, 60)
					elseif Chance == 5 then
						posZ = posZ + Random(1, 60)
						posX = posX + Random(1, 60)
					elseif Chance == 6 then
						posZ = posZ - Random(1, 60)
						posX = posX + Random(1, 60)
					elseif Chance == 7 then
						posZ = posZ + Random(1, 60)
						posX = posX - Random(1, 60)
					else
						posZ = posZ - Random(1, 60)
						posX = posX - Random(1, 60)
					end

					if posX < 5 then
						posX = Random(5, 60)
					end
					if posX > (sizeX - 5) then
						posX = sizeX - Random(5, 60)
					end
					if posZ < 5 then
						posZ = Random(5, 60)
					end
					if posZ > (sizeZ - 5) then
						posZ = sizeZ - Random(5, 60)
					end
				unit = aiBrain:CreateUnitNearSpot(rspawn, posX, posZ)
				if unit == nil then
					local posX = oldposX
					local posZ = oldposZ
						Chance = Random(1, 8)
						if Chance == 1 then
							posX = posX + Random(1, 60)
							posZ = posZ + Random(1, 60)
						elseif Chance == 2 then
							posX = posX - Random(1, 60)
							posZ = posZ + Random(1, 60)
						elseif Chance == 3 then
							posX = posX + Random(1, 60)
							posZ = posZ - Random(1, 60)
						elseif Chance == 4 then
							posX = posX - Random(1, 60)
							posZ = posZ - Random(1, 60)
						elseif Chance == 5 then
							posZ = posZ + Random(1, 60)
							posX = posX + Random(1, 60)
						elseif Chance == 6 then
							posZ = posZ - Random(1, 60)
							posX = posX + Random(1, 60)
						elseif Chance == 7 then
							posZ = posZ + Random(1, 60)
							posX = posX - Random(1, 60)
						else
							posZ = posZ - Random(1, 60)
							posX = posX - Random(1, 60)
						end

						if posX < 5 then
							posX = Random(5, 60)
						end
						if posX > (sizeX - 5) then
							posX = sizeX - Random(5, 60)
						end
						if posZ < 5 then
							posZ = Random(5, 60)
						end
						if posZ > (sizeZ - 5) then
							posZ = sizeZ - Random(5, 60)
						end
					local terrainAltitude = GetTerrainHeight(posX, posZ)
					unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
                end
            end
        end
        if unit ~= nil then
            maxhp = unit:GetMaxHealth()
            unit:SetMaxHealth(maxhp + 5000 + 10000 * totalEnemyEndgamers)
            hp = unit:GetMaxHealth()
            unit:SetHealth(self, hp)
        end
		GetTargetforArtillery(unit)
		if unit and not unit:BeenDestroyed() then
			SuicideArtillery(unit)
		end	
        KillThread(self)
    end)
end
function SuicideArtillery(unitId)
    local circle = ForkThread(function(self)
	local unit = unitId
	WaitTicks(Random(1, 10))
	WaitSeconds(240)
		if unit and not unit.Dead then
			unit:Kill()
		end
	KillThread(self)
    end)
end
function SpawnInReinforcements()
    local circle = ForkThread(function(self)
        local unit
        --local goforest = 0
        local rspawn = nil
        local enemyParagonsCount = totalEnemyParagons
        local isAirUnit = false
        local aliveBrain = GetRandomCloseAliveEnemyBrain(self)
		local posX, posZ = aliveBrain:GetArmyStartPos()
		--local MapCheck = false
		local Chance
		--local count = 0
        if aliveBrain then
            WaitTicks(1)
					rspawn = (landUnitsE.Tech4)[Random(1, Eland)]
					if exHLand > 0 and Random(1, 5) == 1 then
						rspawn = (landUnitsExtremeHeavy.Tech4)[Random(1, exHLand)]
					end	
            if rspawn ~= nil then
                local oldposX = posX
				local oldposZ = posZ
					Chance = Random(1, 8)
					if Chance == 1 then
						posX = posX + Random(1, 40)
						posZ = posZ + Random(1, 40)
					elseif Chance == 2 then
						posX = posX - Random(1, 40)
						posZ = posZ + Random(1, 40)
					elseif Chance == 3 then
						posX = posX + Random(1, 40)
						posZ = posZ - Random(1, 40)
					elseif Chance == 4 then
						posX = posX - Random(1, 40)
						posZ = posZ - Random(1, 40)
					elseif Chance == 5 then
						posZ = posZ + Random(1, 40)
						posX = posX + Random(1, 40)
					elseif Chance == 6 then
						posZ = posZ - Random(1, 40)
						posX = posX + Random(1, 40)
					elseif Chance == 7 then
						posZ = posZ + Random(1, 40)
						posX = posX - Random(1, 40)
					else
						posZ = posZ - Random(1, 40)
						posX = posX - Random(1, 40)
					end

					if posX < 5 then
						posX = Random(5, 40)
					end
					if posX > (sizeX - 5) then
						posX = sizeX - Random(5, 40)
					end
					if posZ < 5 then
						posZ = Random(5, 40)
					end
					if posZ > (sizeZ - 5) then
						posZ = sizeZ - Random(5, 40)
					end
				unit = aliveBrain:CreateUnitNearSpot(rspawn, posX, posZ)
				if unit == nil then
					local posX = oldposX
					local posZ = oldposZ
						Chance = Random(1, 8)
						if Chance == 1 then
							posX = posX + Random(1, 40)
							posZ = posZ + Random(1, 40)
						elseif Chance == 2 then
							posX = posX - Random(1, 40)
							posZ = posZ + Random(1, 40)
						elseif Chance == 3 then
							posX = posX + Random(1, 40)
							posZ = posZ - Random(1, 40)
						elseif Chance == 4 then
							posX = posX - Random(1, 40)
							posZ = posZ - Random(1, 40)
						elseif Chance == 5 then
							posZ = posZ + Random(1, 40)
							posX = posX + Random(1, 40)
						elseif Chance == 6 then
							posZ = posZ - Random(1, 40)
							posX = posX + Random(1, 40)
						elseif Chance == 7 then
							posZ = posZ + Random(1, 40)
							posX = posX - Random(1, 40)
						else
							posZ = posZ - Random(1, 40)
							posX = posX - Random(1, 40)
						end

						if posX < 5 then
							posX = Random(5, 40)
						end
						if posX > (sizeX - 5) then
							posX = sizeX - Random(5, 40)
						end
						if posZ < 5 then
							posZ = Random(5, 40)
						end
						if posZ > (sizeZ - 5) then
							posZ = sizeZ - Random(5, 40)
						end
					local terrainAltitude = GetTerrainHeight(posX, posZ)
					unit = CreateUnitHPR(rspawn, aliveBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
                    if unit and unit ~= nil and not unit.Dead then
                        LOG("sa: AllyForcesSPKill (unit) = " .. rspawn)
                    end
                end
                if unit and unit ~= nil and not unit.Dead and HPBonusAI > 0 then
                   if GameTime < 0.33 then
						totalIncrease = HealthBonus
                        maxhp = unit:GetMaxHealth()
                        unit:SetMaxHealth(maxhp + totalIncrease)
					elseif GameTime >= 0.33 and GameTime < 0.66 then
						totalIncrease = HealthBonus * 1.5
                        maxhp = unit:GetMaxHealth()
                        unit:SetMaxHealth(maxhp + totalIncrease)
					elseif GameTime >= 0.66 and GameTime < 1 then
						totalIncrease = HealthBonus * 2
                        maxhp = unit:GetMaxHealth()
                        unit:SetMaxHealth(maxhp + totalIncrease)
					elseif GameTime >= 1 then
						totalIncrease = HealthBonus * 2.5
                        maxhp = unit:GetMaxHealth()
                        unit:SetMaxHealth(maxhp + totalIncrease)
					end
                    hp = unit:GetMaxHealth()
                    unit:SetHealth(self, hp)
                    unit:SetReclaimable(false)
                end
                unit:SetSpeedMult(1 + (waveNum * SpeedBonus + SpeedBonusOnce) * 0.5)
            end
        end
        KillThread(self)
    end)
end
function SpawnAlliedForce()
    local circle = ForkThread(function(self)
        local unit
        --local goforest = 0
        local rspawn = nil
        local enemyParagonsCount = totalEnemyParagons
        local isAirUnit = false
        local aliveBrain = GetRandomCloseAliveEnemyBrain(self)
		local posX, posZ = aliveBrain:GetArmyStartPos()
		--local MapCheck = false
		local Chance
		--local count = 0
        if aliveBrain then
            WaitTicks(1)
				if SpawnAlliesForceFlag == 'On - Land + Air' then
					rspawn = (landUnitsE.Tech4)[Random(1, Eland)]
					if exHLand > 0 and Random(1, 5) == 1 then
						rspawn = (landUnitsExtremeHeavy.Tech4)[Random(1, exHLand)]
					end
					if Random(1, 4) == 1 then
						rspawn = (airUnitsA.Tech4)[Random(1, countair)]
					end
				elseif SpawnAlliesForceFlag == 'On - Land Only' then
					rspawn = (landUnitsE.Tech4)[Random(1, Eland)]
					if exHLand > 0 and Random(1, 5) == 1 then
						rspawn = (landUnitsExtremeHeavy.Tech4)[Random(1, exHLand)]
					end
				elseif SpawnAlliesForceFlag == 'On - Air Only' then
					rspawn = (airUnitsA.Tech4)[Random(1, countair)]
				end	
            if rspawn ~= nil then
                local oldposX = posX
				local oldposZ = posZ
					Chance = Random(1, 8)
					if Chance == 1 then
						posX = posX + Random(1, 40)
						posZ = posZ + Random(1, 40)
					elseif Chance == 2 then
						posX = posX - Random(1, 40)
						posZ = posZ + Random(1, 40)
					elseif Chance == 3 then
						posX = posX + Random(1, 40)
						posZ = posZ - Random(1, 40)
					elseif Chance == 4 then
						posX = posX - Random(1, 40)
						posZ = posZ - Random(1, 40)
					elseif Chance == 5 then
						posZ = posZ + Random(1, 40)
						posX = posX + Random(1, 40)
					elseif Chance == 6 then
						posZ = posZ - Random(1, 40)
						posX = posX + Random(1, 40)
					elseif Chance == 7 then
						posZ = posZ + Random(1, 40)
						posX = posX - Random(1, 40)
					else
						posZ = posZ - Random(1, 40)
						posX = posX - Random(1, 40)
					end

					if posX < 5 then
						posX = Random(5, 40)
					end
					if posX > (sizeX - 5) then
						posX = sizeX - Random(5, 40)
					end
					if posZ < 5 then
						posZ = Random(5, 40)
					end
					if posZ > (sizeZ - 5) then
						posZ = sizeZ - Random(5, 40)
					end
				unit = aliveBrain:CreateUnitNearSpot(rspawn, posX, posZ)
				if unit == nil then
					local posX = oldposX
					local posZ = oldposZ
						Chance = Random(1, 8)
						if Chance == 1 then
							posX = posX + Random(1, 40)
							posZ = posZ + Random(1, 40)
						elseif Chance == 2 then
							posX = posX - Random(1, 40)
							posZ = posZ + Random(1, 40)
						elseif Chance == 3 then
							posX = posX + Random(1, 40)
							posZ = posZ - Random(1, 40)
						elseif Chance == 4 then
							posX = posX - Random(1, 40)
							posZ = posZ - Random(1, 40)
						elseif Chance == 5 then
							posZ = posZ + Random(1, 40)
							posX = posX + Random(1, 40)
						elseif Chance == 6 then
							posZ = posZ - Random(1, 40)
							posX = posX + Random(1, 40)
						elseif Chance == 7 then
							posZ = posZ + Random(1, 40)
							posX = posX - Random(1, 40)
						else
							posZ = posZ - Random(1, 40)
							posX = posX - Random(1, 40)
						end

						if posX < 5 then
							posX = Random(5, 40)
						end
						if posX > (sizeX - 5) then
							posX = sizeX - Random(5, 40)
						end
						if posZ < 5 then
							posZ = Random(5, 40)
						end
						if posZ > (sizeZ - 5) then
							posZ = sizeZ - Random(5, 40)
						end
					local terrainAltitude = GetTerrainHeight(posX, posZ)
					unit = CreateUnitHPR(rspawn, aliveBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
                    if unit and unit ~= nil and not unit.Dead then
                        LOG("sa: AllyForcesEndgame (unit) = " .. rspawn)
                    end
                end
                if unit and unit ~= nil and not unit.Dead and HPBonusAI > 0 then
                   if GameTime < 0.33 then
						totalIncrease = HealthBonus
                        maxhp = unit:GetMaxHealth()
                        unit:SetMaxHealth(maxhp + totalIncrease)
					elseif GameTime >= 0.33 and GameTime < 0.66 then
						totalIncrease = HealthBonus * 1.5
                        maxhp = unit:GetMaxHealth()
                        unit:SetMaxHealth(maxhp + totalIncrease)
					elseif GameTime >= 0.66 and GameTime < 1 then
						totalIncrease = HealthBonus * 2
                        maxhp = unit:GetMaxHealth()
                        unit:SetMaxHealth(maxhp + totalIncrease)
					elseif GameTime >= 1 then
						totalIncrease = HealthBonus * 2.5
                        maxhp = unit:GetMaxHealth()
                        unit:SetMaxHealth(maxhp + totalIncrease)
					end
                    hp = unit:GetMaxHealth()
                    unit:SetHealth(self, hp)
                    unit:SetReclaimable(false)
                end
                unit:SetSpeedMult(1 + (waveNum * SpeedBonus + SpeedBonusOnce) * 0.5)
            end
        end
        KillThread(self)
    end)
end
function CreateAndLoadSMDForAI(unitId)
    local circle = ForkThread(function(self)
        local unit = nil
        local posX, posZ = aiBrain:GetArmyStartPos()
		--local MapCheck = false
		local Chance
		--local count = 0
        if GetGameTimeSeconds() > 0 then
            rspawn = unitId
            if rspawn ~= nil then
                local oldposX = posX
				local oldposZ = posZ
					Chance = Random(1, 8)
					if Chance == 1 then
						posX = posX + Random(1, 30)
						posZ = posZ + Random(1, 30)
					elseif Chance == 2 then
						posX = posX - Random(1, 30)
						posZ = posZ + Random(1, 30)
					elseif Chance == 3 then
						posX = posX + Random(1, 30)
						posZ = posZ - Random(1, 30)
					elseif Chance == 4 then
						posX = posX - Random(1, 30)
						posZ = posZ - Random(1, 30)
					elseif Chance == 5 then
						posZ = posZ + Random(1, 30)
						posX = posX + Random(1, 30)
					elseif Chance == 6 then
						posZ = posZ - Random(1, 30)
						posX = posX + Random(1, 30)
					elseif Chance == 7 then
						posZ = posZ + Random(1, 30)
						posX = posX - Random(1, 30)
					else
						posZ = posZ - Random(1, 30)
						posX = posX - Random(1, 30)
					end

					if posX < 5 then
						posX = Random(5, 30)
					end
					if posX > (sizeX - 5) then
						posX = sizeX - Random(5, 30)
					end
					if posZ < 5 then
						posZ = Random(5, 30)
					end
					if posZ > (sizeZ - 5) then
						posZ = sizeZ - Random(5, 30)
					end
				unit = aiBrain:CreateUnitNearSpot(rspawn, posX, posZ)
				if unit == nil then
					local posX = oldposX
					local posZ = oldposZ
						Chance = Random(1, 8)
						if Chance == 1 then
							posX = posX + Random(1, 30)
							posZ = posZ + Random(1, 30)
						elseif Chance == 2 then
							posX = posX - Random(1, 30)
							posZ = posZ + Random(1, 30)
						elseif Chance == 3 then
							posX = posX + Random(1, 30)
							posZ = posZ - Random(1, 30)
						elseif Chance == 4 then
							posX = posX - Random(1, 30)
							posZ = posZ - Random(1, 30)
						elseif Chance == 5 then
							posZ = posZ + Random(1, 30)
							posX = posX + Random(1, 30)
						elseif Chance == 6 then
							posZ = posZ - Random(1, 30)
							posX = posX + Random(1, 30)
						elseif Chance == 7 then
							posZ = posZ + Random(1, 30)
							posX = posX - Random(1, 30)
						else
							posZ = posZ - Random(1, 30)
							posX = posX - Random(1, 30)
						end

						if posX < 5 then
							posX = Random(5, 30)
						end
						if posX > (sizeX - 5) then
							posX = sizeX - Random(5, 30)
						end
						if posZ < 5 then
							posZ = Random(5, 30)
						end
						if posZ > (sizeZ - 5) then
							posZ = sizeZ - Random(5, 30)
						end
					local terrainAltitude = GetTerrainHeight(posX, posZ)
					unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
                end
            end
        end
        if unit ~= nil then
            maxhp = unit:GetMaxHealth()
            unit:SetMaxHealth(maxhp + 5000 * totalEnemyEndgamers)
			--unit:SetProductionPerSecondEnergy(6000)
			--unit:SetProductionPerSecondMass(60)
            hp = unit:GetMaxHealth()
            unit:SetHealth(self, hp)
            --unit:SetBuildRate(4320)
        end
        KillThread(self)
    end)
end
function CreateAndLoadSMDFor2ndSpawn(unitId)
    local circle = ForkThread(function(self)
        local unit = nil
        local posX, posZ = SecBrain:GetArmyStartPos()
		--local MapCheck = false
		local Chance
		--local count = 0
        if GetGameTimeSeconds() > 0 then
            rspawn = unitId
            if rspawn ~= nil then
                local oldposX = posX
				local oldposZ = posZ
					Chance = Random(1, 8)
					if Chance == 1 then
						posX = posX + Random(1, 30)
						posZ = posZ + Random(1, 30)
					elseif Chance == 2 then
						posX = posX - Random(1, 30)
						posZ = posZ + Random(1, 30)
					elseif Chance == 3 then
						posX = posX + Random(1, 30)
						posZ = posZ - Random(1, 30)
					elseif Chance == 4 then
						posX = posX - Random(1, 30)
						posZ = posZ - Random(1, 30)
					elseif Chance == 5 then
						posZ = posZ + Random(1, 30)
						posX = posX + Random(1, 30)
					elseif Chance == 6 then
						posZ = posZ - Random(1, 30)
						posX = posX + Random(1, 30)
					elseif Chance == 7 then
						posZ = posZ + Random(1, 30)
						posX = posX - Random(1, 30)
					else
						posZ = posZ - Random(1, 30)
						posX = posX - Random(1, 30)
					end

					if posX < 5 then
						posX = Random(5, 30)
					end
					if posX > (sizeX - 5) then
						posX = sizeX - Random(5, 30)
					end
					if posZ < 5 then
						posZ = Random(5, 30)
					end
					if posZ > (sizeZ - 5) then
						posZ = sizeZ - Random(5, 30)
					end
				unit = aiBrain:CreateUnitNearSpot(rspawn, posX, posZ)
				if unit == nil then
					local posX = oldposX
					local posZ = oldposZ
						Chance = Random(1, 8)
						if Chance == 1 then
							posX = posX + Random(1, 30)
							posZ = posZ + Random(1, 30)
						elseif Chance == 2 then
							posX = posX - Random(1, 30)
							posZ = posZ + Random(1, 30)
						elseif Chance == 3 then
							posX = posX + Random(1, 30)
							posZ = posZ - Random(1, 30)
						elseif Chance == 4 then
							posX = posX - Random(1, 30)
							posZ = posZ - Random(1, 30)
						elseif Chance == 5 then
							posZ = posZ + Random(1, 30)
							posX = posX + Random(1, 30)
						elseif Chance == 6 then
							posZ = posZ - Random(1, 30)
							posX = posX + Random(1, 30)
						elseif Chance == 7 then
							posZ = posZ + Random(1, 30)
							posX = posX - Random(1, 30)
						else
							posZ = posZ - Random(1, 30)
							posX = posX - Random(1, 30)
						end

						if posX < 5 then
							posX = Random(5, 30)
						end
						if posX > (sizeX - 5) then
							posX = sizeX - Random(5, 30)
						end
						if posZ < 5 then
							posZ = Random(5, 30)
						end
						if posZ > (sizeZ - 5) then
							posZ = sizeZ - Random(5, 30)
						end
					local terrainAltitude = GetTerrainHeight(posX, posZ)
					unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
                end
            end
        end
        if unit ~= nil then
            maxhp = unit:GetMaxHealth()
            unit:SetMaxHealth(maxhp + 20000 + (5000 * humans))
			--unit:SetProductionPerSecondEnergy(6000)
			--unit:SetProductionPerSecondMass(60)
            hp = unit:GetMaxHealth()
            unit:SetHealth(self, hp)
            --unit:SetBuildRate(4320)
        end
        KillThread(self)
    end)
end
function CreateAntiAirDefenceForAI(unitId)
    local circle = ForkThread(function(self)
        local unit = nil
        local posX, posZ = aiBrain:GetArmyStartPos()
		--local MapCheck = false
		local Chance
		--local count = 0
        if GetGameTimeSeconds() > 0 then
            rspawn = unitId
            if rspawn ~= nil then
                local oldposX = posX
				local oldposZ = posZ
					Chance = Random(1, 8)
					if Chance == 1 then
						posX = posX + Random(1, 50)
						posZ = posZ + Random(1, 50)
					elseif Chance == 2 then
						posX = posX - Random(1, 50)
						posZ = posZ + Random(1, 50)
					elseif Chance == 3 then
						posX = posX + Random(1, 50)
						posZ = posZ - Random(1, 50)
					elseif Chance == 4 then
						posX = posX - Random(1, 50)
						posZ = posZ - Random(1, 50)
					elseif Chance == 5 then
						posZ = posZ + Random(1, 50)
						posX = posX + Random(1, 50)
					elseif Chance == 6 then
						posZ = posZ - Random(1, 50)
						posX = posX + Random(1, 50)
					elseif Chance == 7 then
						posZ = posZ + Random(1, 50)
						posX = posX - Random(1, 50)
					else
						posZ = posZ - Random(1, 50)
						posX = posX - Random(1, 50)
					end

					if posX < 5 then
						posX = Random(5, 50)
					end
					if posX > (sizeX - 5) then
						posX = sizeX - Random(5, 50)
					end
					if posZ < 5 then
						posZ = Random(5, 50)
					end
					if posZ > (sizeZ - 5) then
						posZ = sizeZ - Random(5, 50)
					end
				unit = aiBrain:CreateUnitNearSpot(rspawn, posX, posZ)
				if unit == nil then
					local posX = oldposX
					local posZ = oldposZ
						Chance = Random(1, 8)
						if Chance == 1 then
							posX = posX + Random(1, 50)
							posZ = posZ + Random(1, 50)
						elseif Chance == 2 then
							posX = posX - Random(1, 50)
							posZ = posZ + Random(1, 50)
						elseif Chance == 3 then
							posX = posX + Random(1, 50)
							posZ = posZ - Random(1, 50)
						elseif Chance == 4 then
							posX = posX - Random(1, 50)
							posZ = posZ - Random(1, 50)
						elseif Chance == 5 then
							posZ = posZ + Random(1, 50)
							posX = posX + Random(1, 50)
						elseif Chance == 6 then
							posZ = posZ - Random(1, 50)
							posX = posX + Random(1, 50)
						elseif Chance == 7 then
							posZ = posZ + Random(1, 50)
							posX = posX - Random(1, 50)
						else
							posZ = posZ - Random(1, 50)
							posX = posX - Random(1, 50)
						end

						if posX < 5 then
							posX = Random(5, 50)
						end
						if posX > (sizeX - 5) then
							posX = sizeX - Random(5, 50)
						end
						if posZ < 5 then
							posZ = Random(5, 50)
						end
						if posZ > (sizeZ - 5) then
							posZ = sizeZ - Random(5, 50)
						end
					local terrainAltitude = GetTerrainHeight(posX, posZ)
					unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
                end
            end
        end
        if unit ~= nil then
            maxhp = unit:GetMaxHealth()
            unit:SetMaxHealth(maxhp + 10000 * totalEnemyEndgamers)
            local hp = unit:GetMaxHealth()
            unit:SetHealth(self, hp)
        end
        KillThread(self)
    end)
end
function CreateAUnitAroundMainBuildingForAI(unitId)
    local circle = ForkThread(function(self)
        local unit = nil
        local posX, posZ = aiBrain:GetArmyStartPos()
		--local MapCheck = false
		local Chance
		--local count = 0
        if GetGameTimeSeconds() > 0 then
            rspawn = unitId
            if rspawn ~= nil then
                local oldposX = posX
				local oldposZ = posZ
					Chance = Random(1, 8)
					if Chance == 1 then
						posX = posX + Random(1, 60)
						posZ = posZ + Random(1, 60)
					elseif Chance == 2 then
						posX = posX - Random(1, 60)
						posZ = posZ + Random(1, 60)
					elseif Chance == 3 then
						posX = posX + Random(1, 60)
						posZ = posZ - Random(1, 60)
					elseif Chance == 4 then
						posX = posX - Random(1, 60)
						posZ = posZ - Random(1, 60)
					elseif Chance == 5 then
						posZ = posZ + Random(1, 60)
						posX = posX + Random(1, 60)
					elseif Chance == 6 then
						posZ = posZ - Random(1, 60)
						posX = posX + Random(1, 60)
					elseif Chance == 7 then
						posZ = posZ + Random(1, 60)
						posX = posX - Random(1, 60)
					else
						posZ = posZ - Random(1, 60)
						posX = posX - Random(1, 60)
					end

					if posX < 5 then
						posX = Random(5, 60)
					end
					if posX > (sizeX - 5) then
						posX = sizeX - Random(5, 60)
					end
					if posZ < 5 then
						posZ = Random(5, 60)
					end
					if posZ > (sizeZ - 5) then
						posZ = sizeZ - Random(5, 60)
					end
				unit = aiBrain:CreateUnitNearSpot(rspawn, posX, posZ)
				if unit == nil then
					local posX = oldposX
					local posZ = oldposZ
						Chance = Random(1, 8)
						if Chance == 1 then
							posX = posX + Random(1, 60)
							posZ = posZ + Random(1, 60)
						elseif Chance == 2 then
							posX = posX - Random(1, 60)
							posZ = posZ + Random(1, 60)
						elseif Chance == 3 then
							posX = posX + Random(1, 60)
							posZ = posZ - Random(1, 60)
						elseif Chance == 4 then
							posX = posX - Random(1, 60)
							posZ = posZ - Random(1, 60)
						elseif Chance == 5 then
							posZ = posZ + Random(1, 60)
							posX = posX + Random(1, 60)
						elseif Chance == 6 then
							posZ = posZ - Random(1, 60)
							posX = posX + Random(1, 60)
						elseif Chance == 7 then
							posZ = posZ + Random(1, 60)
							posX = posX - Random(1, 60)
						else
							posZ = posZ - Random(1, 60)
							posX = posX - Random(1, 60)
						end

						if posX < 5 then
							posX = Random(5, 60)
						end
						if posX > (sizeX - 5) then
							posX = sizeX - Random(5, 60)
						end
						if posZ < 5 then
							posZ = Random(5, 60)
						end
						if posZ > (sizeZ - 5) then
							posZ = sizeZ - Random(5, 60)
						end
					local terrainAltitude = GetTerrainHeight(posX, posZ)
					unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
                end
            end
        end
        if unit ~= nil then
            maxhp = unit:GetMaxHealth()
            unit:SetMaxHealth(maxhp + 5000 + 10000 * totalEnemyEndgamers)
            hp = unit:GetMaxHealth()
            unit:SetHealth(self, hp)
        end
        KillThread(self)
    end)
end
function CreateArtilleryAroundMainBuilding(unitId)
    local circle = ForkThread(function(self)
        local unit = nil
        local posX, posZ = aiBrain:GetArmyStartPos()
		--local MapCheck = false
		local Chance
		--local count = 0
        if GetGameTimeSeconds() > 0 then
            rspawn = unitId
            if rspawn ~= nil then
                local oldposX = posX
				local oldposZ = posZ
					Chance = Random(1, 8)
					if Chance == 1 then
						posX = posX + Random(1, 60)
						posZ = posZ + Random(1, 60)
					elseif Chance == 2 then
						posX = posX - Random(1, 60)
						posZ = posZ + Random(1, 60)
					elseif Chance == 3 then
						posX = posX + Random(1, 60)
						posZ = posZ - Random(1, 60)
					elseif Chance == 4 then
						posX = posX - Random(1, 60)
						posZ = posZ - Random(1, 60)
					elseif Chance == 5 then
						posZ = posZ + Random(1, 60)
						posX = posX + Random(1, 60)
					elseif Chance == 6 then
						posZ = posZ - Random(1, 60)
						posX = posX + Random(1, 60)
					elseif Chance == 7 then
						posZ = posZ + Random(1, 60)
						posX = posX - Random(1, 60)
					else
						posZ = posZ - Random(1, 60)
						posX = posX - Random(1, 60)
					end

					if posX < 5 then
						posX = Random(5, 60)
					end
					if posX > (sizeX - 5) then
						posX = sizeX - Random(5, 60)
					end
					if posZ < 5 then
						posZ = Random(5, 60)
					end
					if posZ > (sizeZ - 5) then
						posZ = sizeZ - Random(5, 60)
					end
				unit = aiBrain:CreateUnitNearSpot(rspawn, posX, posZ)
				if unit == nil then
					local posX = oldposX
					local posZ = oldposZ
						Chance = Random(1, 8)
						if Chance == 1 then
							posX = posX + Random(1, 60)
							posZ = posZ + Random(1, 60)
						elseif Chance == 2 then
							posX = posX - Random(1, 60)
							posZ = posZ + Random(1, 60)
						elseif Chance == 3 then
							posX = posX + Random(1, 60)
							posZ = posZ - Random(1, 60)
						elseif Chance == 4 then
							posX = posX - Random(1, 60)
							posZ = posZ - Random(1, 60)
						elseif Chance == 5 then
							posZ = posZ + Random(1, 60)
							posX = posX + Random(1, 60)
						elseif Chance == 6 then
							posZ = posZ - Random(1, 60)
							posX = posX + Random(1, 60)
						elseif Chance == 7 then
							posZ = posZ + Random(1, 60)
							posX = posX - Random(1, 60)
						else
							posZ = posZ - Random(1, 60)
							posX = posX - Random(1, 60)
						end

						if posX < 5 then
							posX = Random(5, 60)
						end
						if posX > (sizeX - 5) then
							posX = sizeX - Random(5, 60)
						end
						if posZ < 5 then
							posZ = Random(5, 60)
						end
						if posZ > (sizeZ - 5) then
							posZ = sizeZ - Random(5, 60)
						end
					local terrainAltitude = GetTerrainHeight(posX, posZ)
					unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
                end
            end
        end
        if unit ~= nil then
            maxhp = unit:GetMaxHealth()
            unit:SetMaxHealth(maxhp + 5000 + 10000 * totalEnemyEndgamers)
            hp = unit:GetMaxHealth()
            unit:SetHealth(self, hp)
        end
		GetTargetforArtillery(unit)
        KillThread(self)
    end)
end
function CreateABomberAroundMainBuildingForAI(unitId)
    local circle = ForkThread(function(self)
        local unit = nil
        local posX
		local posZ
		if AltHQSpawn ~= "Off" and HQAltBuildingDead == false and Random(1, 2) == 1 then
			posX, posZ = AltHQBrain:GetArmyStartPos()
		else
			posX, posZ = aiBrain:GetArmyStartPos()
		end	
        if GetGameTimeSeconds() > 0 then
            rspawn = unitId
            if rspawn ~= nil then
                local oldposX = posX
                local oldposZ = posZ
                if Random(1, 2) == 2 then
                    posX = posX + Random(15, 30)
                    posZ = posZ + Random(15, 30)
                else
                    posX = posX - Random(15, 30)
                    posZ = posZ + Random(15, 30)
                end
                if Random(1, 2) == 2 then
                    posX = posX + Random(15, 30)
                    posZ = posZ - Random(15, 30)
                else
                    posX = posX - Random(15, 30)
                    posZ = posZ - Random(15, 30)
                end
                if Random(1, 2) == 2 then
                    posZ = posZ + Random(15, 30)
                    posX = posX + Random(15, 30)
                else
                    posZ = posZ - Random(15, 30)
                    posX = posX + Random(15, 30)
                end
                if Random(1, 2) == 2 then
                    posZ = posZ + Random(15, 30)
                    posX = posX - Random(15, 30)
                else
                    posZ = posZ - Random(15, 30)
                    posX = posX - Random(15, 30)
                end
                unit = aiBrain:CreateUnitNearSpot(rspawn, posX, posZ)
                if unit == nil then
                    local posX = oldposX
                    local posZ = oldposZ
                    if Random(1, 2) == 2 then
                        posX = posX + Random(15, 30)
                        posZ = posZ + Random(15, 30)
                    else
                        posX = posX - Random(15, 30)
                        posZ = posZ + Random(15, 30)
                    end
                    if Random(1, 2) == 2 then
                        posX = posX + Random(15, 30)
                        posZ = posZ - Random(15, 30)
                    else
                        posX = posX - Random(15, 30)
                        posZ = posZ - Random(15, 30)
                    end
                    if Random(1, 2) == 2 then
                        posZ = posZ + Random(15, 30)
                        posX = posX + Random(15, 30)
                    else
                        posZ = posZ - Random(15, 30)
                        posX = posX + Random(15, 30)
                    end
                    if Random(1, 2) == 2 then
                        posZ = posZ + Random(15, 30)
                        posX = posX - Random(15, 30)
                    else
                        posZ = posZ - Random(15, 30)
                        posX = posX - Random(15, 30)
                    end
                    local terrainAltitude = GetTerrainHeight(posX, posZ)
                    unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
                end
            end
        end
        if unit ~= nil then
            maxhp = unit:GetMaxHealth()
            unit:SetMaxHealth(maxhp + 10000 * totalEnemyEndgamers)
            hp = unit:GetMaxHealth()
            unit:SetHealth(self, hp)
        end
		if unit and not unit.Dead then
			RedirectBomber(unit)
        end
        KillThread(self)
    end)
end
function CreatACUHunterUnit(unitId)
    local circle = ForkThread(function(self)
        local unit = nil
        local posX
		local posZ
		--local MapCheck = false
		local Chance
		--local count = 0
		if AltHQSpawn ~= "Off" and HQAltBuildingDead == false and Random(1, 2) == 1 then
			posX, posZ = AltHQBrain:GetArmyStartPos()
		else
			posX, posZ = aiBrain:GetArmyStartPos()
		end	
        if GetGameTimeSeconds() > 0 then
            rspawn = unitId
            if rspawn ~= nil then
                local oldposX = posX
				local oldposZ = posZ
					Chance = Random(1, 8)
					if Chance == 1 then
						posX = posX + Random(1, 55)
						posZ = posZ + Random(1, 55)
					elseif Chance == 2 then
						posX = posX - Random(1, 55)
						posZ = posZ + Random(1, 55)
					elseif Chance == 3 then
						posX = posX + Random(1, 55)
						posZ = posZ - Random(1, 55)
					elseif Chance == 4 then
						posX = posX - Random(1, 55)
						posZ = posZ - Random(1, 55)
					elseif Chance == 5 then
						posZ = posZ + Random(1, 55)
						posX = posX + Random(1, 55)
					elseif Chance == 6 then
						posZ = posZ - Random(1, 55)
						posX = posX + Random(1, 55)
					elseif Chance == 7 then
						posZ = posZ + Random(1, 55)
						posX = posX - Random(1, 55)
					else
						posZ = posZ - Random(1, 55)
						posX = posX - Random(1, 55)
					end

					if posX < 5 then
						posX = Random(5, 55)
					end
					if posX > (sizeX - 5) then
						posX = sizeX - Random(5, 55)
					end
					if posZ < 5 then
						posZ = Random(5, 55)
					end
					if posZ > (sizeZ - 5) then
						posZ = sizeZ - Random(5, 55)
					end
				unit = aiBrain:CreateUnitNearSpot(rspawn, posX, posZ)
				if unit == nil then
					local posX = oldposX
					local posZ = oldposZ
						Chance = Random(1, 8)
						if Chance == 1 then
							posX = posX + Random(1, 55)
							posZ = posZ + Random(1, 55)
						elseif Chance == 2 then
							posX = posX - Random(1, 55)
							posZ = posZ + Random(1, 55)
						elseif Chance == 3 then
							posX = posX + Random(1, 55)
							posZ = posZ - Random(1, 55)
						elseif Chance == 4 then
							posX = posX - Random(1, 55)
							posZ = posZ - Random(1, 55)
						elseif Chance == 5 then
							posZ = posZ + Random(1, 55)
							posX = posX + Random(1, 55)
						elseif Chance == 6 then
							posZ = posZ - Random(1, 55)
							posX = posX + Random(1, 55)
						elseif Chance == 7 then
							posZ = posZ + Random(1, 55)
							posX = posX - Random(1, 55)
						else
							posZ = posZ - Random(1, 55)
							posX = posX - Random(1, 55)
						end

						if posX < 5 then
							posX = Random(5, 55)
						end
						if posX > (sizeX - 5) then
							posX = sizeX - Random(5, 55)
						end
						if posZ < 5 then
							posZ = Random(5, 55)
						end
						if posZ > (sizeZ - 5) then
							posZ = sizeZ - Random(5, 55)
						end
					local terrainAltitude = GetTerrainHeight(posX, posZ)
					unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
                end
            end
        end
        if unit and unit ~= nil and not unit.Dead and (HPBonusAI > 0 or ParagonCycle ~= "Off") then
			totalIncrease = HealthBonus
			maxhp = unit:GetMaxHealth()
			unit:SetMaxHealth(maxhp + totalIncrease)
			if GameTime >= 0.85 and GameTime < 1 then
				totalIncrease = HealthBonus * 1.5 + Random(1000, 1500) * totalEnemyEndgamers
				maxhp = unit:GetMaxHealth()
				unit:SetMaxHealth(maxhp + totalIncrease)
			elseif GameTime >= 1 then
				totalIncrease = HealthBonus * 2 + Random(1500, 2000) * totalEnemyEndgamers
				maxhp = unit:GetMaxHealth()
				unit:SetMaxHealth(maxhp + totalIncrease)
			end
			hp = unit:GetMaxHealth()
            unit:SetHealth(self, hp)
            unit:SetReclaimable(false)
        end
        if unit and not unit.Dead then
			if DamageBoost ~= 'Off - 0' then
				ModifyWeaponDamageBuffAndRange(unit)
			end	
			unit:SetSpeedMult(1 + waveNum * SpeedBonus + SpeedBonusOnce)
        end
		if unit and not unit.Dead then
			RedirectACUHunter(unit)
        end
		if KillPlayerUnit > 0 then
			SuicideLandNavyUnit(unit)
		end	
        KillThread(self)
    end)
end
function CreateAUnitAroundMainBuildingForAITwo(unitId)
    local circle = ForkThread(function(self)
        local unit = nil
        local posX, posZ = aiBrain:GetArmyStartPos()
		--local MapCheck = false
		local Chance
		--local count = 0
        if GetGameTimeSeconds() > 0 then
            rspawn = unitId
            if rspawn ~= nil then
                local oldposX = posX
				local oldposZ = posZ
					Chance = Random(1, 8)
					if Chance == 1 then
						posX = posX + Random(1, 50)
						posZ = posZ + Random(1, 50)
					elseif Chance == 2 then
						posX = posX - Random(1, 50)
						posZ = posZ + Random(1, 50)
					elseif Chance == 3 then
						posX = posX + Random(1, 50)
						posZ = posZ - Random(1, 50)
					elseif Chance == 4 then
						posX = posX - Random(1, 50)
						posZ = posZ - Random(1, 50)
					elseif Chance == 5 then
						posZ = posZ + Random(1, 50)
						posX = posX + Random(1, 50)
					elseif Chance == 6 then
						posZ = posZ - Random(1, 50)
						posX = posX + Random(1, 50)
					elseif Chance == 7 then
						posZ = posZ + Random(1, 50)
						posX = posX - Random(1, 50)
					else
						posZ = posZ - Random(1, 50)
						posX = posX - Random(1, 50)
					end

					if posX < 5 then
						posX = Random(5, 50)
					end
					if posX > (sizeX - 5) then
						posX = sizeX - Random(5, 50)
					end
					if posZ < 5 then
						posZ = Random(5, 50)
					end
					if posZ > (sizeZ - 5) then
						posZ = sizeZ - Random(5, 50)
					end
				unit = aiBrain:CreateUnitNearSpot(rspawn, posX, posZ)
				if unit == nil then
					local posX = oldposX
					local posZ = oldposZ
						Chance = Random(1, 8)
						if Chance == 1 then
							posX = posX + Random(1, 50)
							posZ = posZ + Random(1, 50)
						elseif Chance == 2 then
							posX = posX - Random(1, 50)
							posZ = posZ + Random(1, 50)
						elseif Chance == 3 then
							posX = posX + Random(1, 50)
							posZ = posZ - Random(1, 50)
						elseif Chance == 4 then
							posX = posX - Random(1, 50)
							posZ = posZ - Random(1, 50)
						elseif Chance == 5 then
							posZ = posZ + Random(1, 50)
							posX = posX + Random(1, 50)
						elseif Chance == 6 then
							posZ = posZ - Random(1, 50)
							posX = posX + Random(1, 50)
						elseif Chance == 7 then
							posZ = posZ + Random(1, 50)
							posX = posX - Random(1, 50)
						else
							posZ = posZ - Random(1, 50)
							posX = posX - Random(1, 50)
						end

						if posX < 5 then
							posX = Random(5, 50)
						end
						if posX > (sizeX - 5) then
							posX = sizeX - Random(5, 50)
						end
						if posZ < 5 then
							posZ = Random(5, 50)
						end
						if posZ > (sizeZ - 5) then
							posZ = sizeZ - Random(5, 50)
						end
					local terrainAltitude = GetTerrainHeight(posX, posZ)
					unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
                end
            end
        end
        if unit ~= nil then
            maxhp = unit:GetMaxHealth()
            unit:SetMaxHealth(maxhp)
            hp = unit:GetMaxHealth()
            unit:SetHealth(self, hp)
        end
        KillThread(self)
    end)
end
function CreateACombinedLandBossUnitAroundMainBuildingForAI() --Minor Boss Land
    local circle = ForkThread(function(self)
        WaitTicks(100)
        local rspawn
        local unit = nil
		--local MapCheck = false
		local Chance
		--local count = 0
			if secondaryspawn ~= "Off" and spawnrateair > 0 and SecondarySpawnDead == false then
					if Alt2ndSpawn ~= "Off" and Alt2ndBuildingDead == false and Random(1, 2) == 1 then
						posX, posZ = Alt2ndBrain:GetArmyStartPos()
					else
						posX, posZ = SecBrain:GetArmyStartPos()
					end	
				if Random(1, 100) > spawnrateair then
					if AltHQSpawn ~= "Off" and HQAltBuildingDead == false and Random(1, 2) == 1 then
						posX, posZ = AltHQBrain:GetArmyStartPos()
					else
						posX, posZ = aiBrain:GetArmyStartPos()
					end	
				end	
			else
				if AltHQSpawn ~= "Off" and HQAltBuildingDead == false and Random(1, 2) == 1 then
					posX, posZ = AltHQBrain:GetArmyStartPos()
				else
					posX, posZ = aiBrain:GetArmyStartPos()
				end		
			end
        if GetGameTimeSeconds() > WavesStartTimeAI then
            if landUnitsExtremeHeavy and landUnitsExtremeHeavy.Tech4 and exHLand > 0 and Random(1, 16) == 5 then
                rspawn = (landUnitsExtremeHeavy.Tech4)[Random(1, exHLand)]
            elseif landUnitsE and landUnitsE.Tech4 and Eland > 0 then
                rspawn = (landUnitsE.Tech4)[Random(1, Eland)]
            else
                rspawn = (landUnitsH.Tech4)[Random(1, Hland)]
            end
            if rspawn == "brnt3doomsday" or rspawn == "brnt3bat" then
                rspawn = "brmt3snake"
            end
            if rspawn ~= nil then
                local oldposX = posX
				local oldposZ = posZ
					Chance = Random(1, 8)
					if Chance == 1 then
						posX = posX + Random(1, 45)
						posZ = posZ + Random(1, 45)
					elseif Chance == 2 then
						posX = posX - Random(1, 45)
						posZ = posZ + Random(1, 45)
					elseif Chance == 3 then
						posX = posX + Random(1, 45)
						posZ = posZ - Random(1, 45)
					elseif Chance == 4 then
						posX = posX - Random(1, 45)
						posZ = posZ - Random(1, 45)
					elseif Chance == 5 then
						posZ = posZ + Random(1, 45)
						posX = posX + Random(1, 45)
					elseif Chance == 6 then
						posZ = posZ - Random(1, 45)
						posX = posX + Random(1, 45)
					elseif Chance == 7 then
						posZ = posZ + Random(1, 45)
						posX = posX - Random(1, 45)
					else
						posZ = posZ - Random(1, 45)
						posX = posX - Random(1, 45)
					end

					if posX < 5 then
						posX = Random(5, 45)
					end
					if posX > (sizeX - 5) then
						posX = sizeX - Random(5, 45)
					end
					if posZ < 5 then
						posZ = Random(5, 45)
					end
					if posZ > (sizeZ - 5) then
						posZ = sizeZ - Random(5, 45)
					end
				unit = aiBrain:CreateUnitNearSpot(rspawn, posX, posZ)
				if unit == nil then
					local posX = oldposX
					local posZ = oldposZ
						Chance = Random(1, 8)
						if Chance == 1 then
							posX = posX + Random(1, 45)
							posZ = posZ + Random(1, 45)
						elseif Chance == 2 then
							posX = posX - Random(1, 45)
							posZ = posZ + Random(1, 45)
						elseif Chance == 3 then
							posX = posX + Random(1, 45)
							posZ = posZ - Random(1, 45)
						elseif Chance == 4 then
							posX = posX - Random(1, 45)
							posZ = posZ - Random(1, 45)
						elseif Chance == 5 then
							posZ = posZ + Random(1, 45)
							posX = posX + Random(1, 45)
						elseif Chance == 6 then
							posZ = posZ - Random(1, 45)
							posX = posX + Random(1, 45)
						elseif Chance == 7 then
							posZ = posZ + Random(1, 45)
							posX = posX - Random(1, 45)
						else
							posZ = posZ - Random(1, 45)
							posX = posX - Random(1, 45)
						end

						if posX < 5 then
						posX = Random(5, 45)
						end
						if posX > (sizeX - 5) then
							posX = sizeX - Random(5, 45)
						end
						if posZ < 5 then
							posZ = Random(5, 45)
						end
						if posZ > (sizeZ - 5) then
							posZ = sizeZ - Random(5, 45)
						end
					local terrainAltitude = GetTerrainHeight(posX, posZ)
					unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
                end
            end
        end
        if unit ~= nil then
            maxhp = unit:GetMaxHealth()
            if isAIBrain then
                unit:SetMaxHealth(maxhp + 12 * (GetGameTimeSeconds() - WavesStartTimeAI) + Random(200, 300) * totalEnemyT3LandDefences + Random(20000, 30000) * totalEnemyEndgamers + HealthBonus)
            else
                unit:SetMaxHealth(maxhp + (Random(10000, 20000) * totalEnemyEndgamers))
            end
            hp = unit:GetMaxHealth()
            unit:SetHealth(self, hp)
			local Pos1x, Pos1y, Pos1z = unit:GetPositionXYZ()
            local attachedUnitsCount = Random(2, 3) + math.floor(totalEnemyYolonas * 0.33 + 0.5) + math.floor(totalEnemyParagons * 0.5 + 0.5)
            if attachedUnitsCount > 6 then
                attachedUnitsCount = 6
            end
            local bonesCount = unit:GetBoneCount()
            if bonesCount > 1 then
                repeat
                    --[[if landUnitsExtremeHeavy and landUnitsExtremeHeavy.Tech4 and exHLand > 0 and Random(1, 3) == 2 then
                        AttachedLandUnitSpawn(unit, rspawn, (landUnitsExtremeHeavy.Tech4)[Random(1, exHLand)], Random(1, bonesCount - 1))
                    elseif landUnitsE and landUnitsE.Tech4 and Eland > 0 and Random(1, 3) == 2 then
                        AttachedLandUnitSpawn(unit, rspawn, (landUnitsE.Tech4)[Random(1, Hland)], Random(1, bonesCount - 1))]]--
					if Random(0, 4) < 4 then	
						if landUnitsH and landUnitsH.Tech4 and Hland > 0 then
							AttachedLandUnitSpawn(unit, rspawn, (landUnitsH.Tech4)[Random(1, Hland)], Random(1, bonesCount - 1))
						elseif landUnitsM and landUnitsM.Tech4 and Mland > 0 then
							AttachedLandUnitSpawn(unit, rspawn, (landUnitsM.Tech4)[Random(1, Lland)], Random(1, bonesCount - 1))
						elseif landUnitsL and landUnitsL.Tech4 and Lland > 0 then
							AttachedLandUnitSpawn(unit, rspawn, (landUnitsL.Tech4)[Random(1, Lland)], Random(1, bonesCount - 1))
						end
					end	
                    WaitTicks(2)
                    attachedUnitsCount = attachedUnitsCount - 1
                until attachedUnitsCount < 1
            end
            WaitTicks(5)
            unit:SetCustomName("Boss")
			unit:SetSpeedMult(1 + (waveNum * SpeedBonus  + SpeedBonusOnce) * 0.3)
            if WaveStyle == "Even Attack Waves" then	
				RedirectUnitMinorBoss(unit)
			elseif WaveStyle == "Dynamic Attack Waves" or WaveStyle == "Human with AI Assist" then
				RedirectUnitMinorBoss(unit)
			end
			if KillPlayerUnit > 0 then
				SuicideBoss(unit)
			end
			WaitSeconds(20)
			if not unit:BeenDestroyed() then
				local Pos2x, Pos2y, Pos2z = unit:GetPositionXYZ()
				if Pos1x == Pos2x and Pos1z == Pos2z then
					unit:Destroy()
					CreateACombinedLandBossUnitAroundMainBuildingForAI()
				end	
			end
        end
        KillThread(self)
    end)
end
function CreateACombinedAirBossUnitAroundMainBuildingForAI()  --Endgame Boss Air
    local circle = ForkThread(function(self)
        WaitTicks(100)
        local rspawn
        local unit = nil
        local posX
		local posZ
		if AltHQSpawn ~= "Off" and HQAltBuildingDead == false and Random(1, 2) == 1 then
			posX, posZ = AltHQBrain:GetArmyStartPos()
		else
			posX, posZ = aiBrain:GetArmyStartPos()
		end	
        if GetGameTimeSeconds() > WavesStartTimeAI then
            if airUnitsA and airUnitsA.Tech4 and countair > 0 then
                rspawn = (airUnitsA.Tech4)[Random(1, countair)]
            end
            if rspawn ~= nil then
                local oldposX = posX
                local oldposZ = posZ
                if Random(1, 2) == 2 then
                    posX = posX + Random(5, 20)
                    posZ = posZ + Random(5, 20)
                else
                    posX = posX - Random(5, 20)
                    posZ = posZ + Random(5, 20)
                end
                if Random(1, 2) == 2 then
                    posX = posX + Random(5, 20)
                    posZ = posZ - Random(5, 20)
                else
                    posX = posX - Random(5, 20)
                    posZ = posZ - Random(5, 20)
                end
                if Random(1, 2) == 2 then
                    posZ = posZ + Random(5, 20)
                    posX = posX + Random(5, 20)
                else
                    posZ = posZ - Random(5, 20)
                    posX = posX + Random(5, 20)
                end
                if Random(1, 2) == 2 then
                    posZ = posZ + Random(5, 20)
                    posX = posX - Random(5, 20)
                else
                    posZ = posZ - Random(5, 20)
                    posX = posX - Random(5, 20)
                end
                unit = aiBrain:CreateUnitNearSpot(rspawn, posX, posZ)
                if unit == nil then
                    local posX = oldposX
                    local posZ = oldposZ
                    if Random(1, 2) == 2 then
                        posX = posX + Random(5, 20)
                        posZ = posZ + Random(5, 20)
                    else
                        posX = posX - Random(5, 20)
                        posZ = posZ + Random(5, 20)
                    end
                    if Random(1, 2) == 2 then
                        posX = posX + Random(5, 20)
                        posZ = posZ - Random(5, 20)
                    else
                        posX = posX - Random(5, 20)
                        posZ = posZ - Random(5, 20)
                    end
                    if Random(1, 2) == 2 then
                        posZ = posZ + Random(5, 20)
                        posX = posX + Random(5, 20)
                    else
                        posZ = posZ - Random(5, 20)
                        posX = posX + Random(5, 20)
                    end
                    if Random(1, 2) == 2 then
                        posZ = posZ + Random(5, 20)
                        posX = posX - Random(5, 20)
                    else
                        posZ = posZ - Random(5, 20)
                        posX = posX - Random(5, 20)
                    end
                    local terrainAltitude = GetTerrainHeight(posX, posZ)
                    unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
                end
            end
        end
        if unit ~= nil then
            maxhp = unit:GetMaxHealth()
            unit:SetMaxHealth(maxhp + 52000 + 8 * (GetGameTimeSeconds() - WavesStartTimeAI) + Random(150, 200) * totalEnemyT3AirDefences + Random(250, 300) * totalEnemyExpAirDefences + Random(15000, 20000) * totalEnemyEndgamers + HealthBonus)
            hp = unit:GetMaxHealth()
            unit:SetHealth(self, hp)
            local attachedUnitsCount = Random(2, 3) + math.floor(totalEnemyParagons * 0.33 + 0.5)
            if attachedUnitsCount > 5 then
                attachedUnitsCount = 5
            end
            local bonesCount = unit:GetBoneCount()
            if bonesCount > 1 then
                repeat
                    if airUnitsA and airUnitsA.Tech4 and countair > 0 and Random(1, 2) == 1 then
                        AttachedAirUnitSpawn(unit, rspawn, (airUnitsA.Tech4)[Random(1, countair)], Random(1, bonesCount - 1))
                    end
                    WaitTicks(2)
                    attachedUnitsCount = attachedUnitsCount - 1
                until attachedUnitsCount < 1
            end
			if DamageBoost ~= 'Off - 0' then
				ModifyWeaponDamageBuffBoss(unit)
			end	
            WaitTicks(5)
            unit:SetCustomName("Boss")
			if WaveStyle == "Even Attack Waves" then	
				RedirectUnitEndgameBoss(unit)
			elseif WaveStyle == "Dynamic Attack Waves" or WaveStyle == "Human with AI Assist" then
				RedirectUnitEndgameBoss(unit)
			end
			if KillPlayerUnit > 0 then
				SuicideBoss(unit)
			end	
        end
        KillThread(self)
    end)
end
function CreateAirBossUnitForYolonas()  --Endgame Boss for Yolo Script Air
    local circle = ForkThread(function(self)
        WaitTicks(100)
        local rspawn
        local unit = nil
        local posX
		local posZ
		if AltHQSpawn ~= "Off" and HQAltBuildingDead == false and Random(1, 2) == 1 then
			posX, posZ = AltHQBrain:GetArmyStartPos()
		else
			posX, posZ = aiBrain:GetArmyStartPos()
		end
        if GetGameTimeSeconds() > WavesStartTimeAI then
            if airUnitsA and airUnitsA.Tech4 and countair > 0 then
                rspawn = (airUnitsA.Tech4)[Random(1, countair)]
            end
            if rspawn ~= nil then
                local oldposX = posX
                local oldposZ = posZ
                if Random(1, 2) == 2 then
                    posX = posX + Random(5, 20)
                    posZ = posZ + Random(5, 20)
                else
                    posX = posX - Random(5, 20)
                    posZ = posZ + Random(5, 20)
                end
                if Random(1, 2) == 2 then
                    posX = posX + Random(5, 20)
                    posZ = posZ - Random(5, 20)
                else
                    posX = posX - Random(5, 20)
                    posZ = posZ - Random(5, 20)
                end
                if Random(1, 2) == 2 then
                    posZ = posZ + Random(5, 20)
                    posX = posX + Random(5, 20)
                else
                    posZ = posZ - Random(5, 20)
                    posX = posX + Random(5, 20)
                end
                if Random(1, 2) == 2 then
                    posZ = posZ + Random(5, 20)
                    posX = posX - Random(5, 20)
                else
                    posZ = posZ - Random(5, 20)
                    posX = posX - Random(5, 20)
                end
                unit = aiBrain:CreateUnitNearSpot(rspawn, posX, posZ)
                if unit == nil then
                    local posX = oldposX
                    local posZ = oldposZ
                    if Random(1, 2) == 2 then
                        posX = posX + Random(5, 20)
                        posZ = posZ + Random(5, 20)
                    else
                        posX = posX - Random(5, 20)
                        posZ = posZ + Random(5, 20)
                    end
                    if Random(1, 2) == 2 then
                        posX = posX + Random(5, 20)
                        posZ = posZ - Random(5, 20)
                    else
                        posX = posX - Random(5, 20)
                        posZ = posZ - Random(5, 20)
                    end
                    if Random(1, 2) == 2 then
                        posZ = posZ + Random(5, 20)
                        posX = posX + Random(5, 20)
                    else
                        posZ = posZ - Random(5, 20)
                        posX = posX + Random(5, 20)
                    end
                    if Random(1, 2) == 2 then
                        posZ = posZ + Random(5, 20)
                        posX = posX - Random(5, 20)
                    else
                        posZ = posZ - Random(5, 20)
                        posX = posX - Random(5, 20)
                    end
                    local terrainAltitude = GetTerrainHeight(posX, posZ)
                    unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
                end
            end
        end
        if unit ~= nil then
            maxhp = unit:GetMaxHealth()
            unit:SetMaxHealth(maxhp + 100000 + 10 * (GetGameTimeSeconds() - WavesStartTimeAI) + Random(200, 300) * totalEnemyT3AirDefences + Random(250, 350) * totalEnemyExpAirDefences + Random(20000, 30000) * totalEnemyEndgamers + HealthBonus)
            hp = unit:GetMaxHealth()
            unit:SetHealth(self, hp)
            local attachedUnitsCount = Random(2, 3) + math.floor(totalEnemyYolonas * 0.33 + 0.5)
            if attachedUnitsCount > 4 then
                attachedUnitsCount = 4
            end
            local bonesCount = unit:GetBoneCount()
            if bonesCount > 1 then
                repeat
                    if airUnitsA and airUnitsA.Tech4 and countair > 0 and Random(1, 2) == 1 then
                        AttachedAirUnitSpawn(unit, rspawn, (airUnitsA.Tech4)[Random(1, countair)], Random(1, bonesCount - 1))
                    end
                    WaitTicks(2)
                    attachedUnitsCount = attachedUnitsCount - 1
                until attachedUnitsCount < 1
            end
			if DamageBoost ~= 'Off - 0' then
				ModifyWeaponDamageBuffBoss(unit)
			end	
            WaitTicks(5)
            unit:SetCustomName("Yolo Boss")
			if WaveStyle == "Even Attack Waves" then	
				RedirectDoomWalker(unit)
			elseif WaveStyle == "Dynamic Attack Waves" or WaveStyle == "Human with AI Assist" then
				RedirectDoomWalker(unit)
			end
        end
        KillThread(self)
    end)
end
function CreateHugeBossUnitAroundMainBuildingForAI() --EndGame Boss Land
    local circle = ForkThread(function(self)
        WaitTicks(100)
        local rspawn
        local unit = nil
        local posX
		local posZ
		--local MapCheck = false
		local Chance
		--local count = 0
		if AltHQSpawn ~= "Off" and HQAltBuildingDead == false and Random(1, 2) == 1 then
			posX, posZ = AltHQBrain:GetArmyStartPos()
		else
			posX, posZ = aiBrain:GetArmyStartPos()
		end
        if GetGameTimeSeconds() > WavesStartTimeAI then
            if landUnitsExtremeHeavy and landUnitsExtremeHeavy.Tech4 and exHLand > 0 then
                rspawn = (landUnitsExtremeHeavy.Tech4)[Random(1, exHLand)]
            elseif landUnitsE and landUnitsE.Tech4 and Eland > 0 then
                rspawn = (landUnitsE.Tech4)[Random(1, Eland)]
            else
                rspawn = (landUnitsH.Tech4)[Random(1, Hland)]
            end
            if rspawn ~= nil then
                local oldposX = posX
				local oldposZ = posZ
					Chance = Random(1, 8)
					if Chance == 1 then
						posX = posX + Random(1, 45)
						posZ = posZ + Random(1, 45)
					elseif Chance == 2 then
						posX = posX - Random(1, 45)
						posZ = posZ + Random(1, 45)
					elseif Chance == 3 then
						posX = posX + Random(1, 45)
						posZ = posZ - Random(1, 45)
					elseif Chance == 4 then
						posX = posX - Random(1, 45)
						posZ = posZ - Random(1, 45)
					elseif Chance == 5 then
						posZ = posZ + Random(1, 45)
						posX = posX + Random(1, 45)
					elseif Chance == 6 then
						posZ = posZ - Random(1, 45)
						posX = posX + Random(1, 45)
					elseif Chance == 7 then
						posZ = posZ + Random(1, 45)
						posX = posX - Random(1, 45)
					else
						posZ = posZ - Random(1, 45)
						posX = posX - Random(1, 45)
					end

					if posX < 5 then
						posX = Random(5, 45)
					end
					if posX > (sizeX - 5) then
						posX = sizeX - Random(5, 45)
					end
					if posZ < 5 then
						posZ = Random(5, 45)
					end
					if posZ > (sizeZ - 5) then
						posZ = sizeZ - Random(5, 45)
					end
				unit = aiBrain:CreateUnitNearSpot(rspawn, posX, posZ)
				if unit == nil then
					local posX = oldposX
					local posZ = oldposZ
						Chance = Random(1, 8)
						if Chance == 1 then
							posX = posX + Random(1, 45)
							posZ = posZ + Random(1, 45)
						elseif Chance == 2 then
							posX = posX - Random(1, 45)
							posZ = posZ + Random(1, 45)
						elseif Chance == 3 then
							posX = posX + Random(1, 45)
							posZ = posZ - Random(1, 45)
						elseif Chance == 4 then
							posX = posX - Random(1, 45)
							posZ = posZ - Random(1, 45)
						elseif Chance == 5 then
							posZ = posZ + Random(1, 45)
							posX = posX + Random(1, 45)
						elseif Chance == 6 then
							posZ = posZ - Random(1, 45)
							posX = posX + Random(1, 45)
						elseif Chance == 7 then
							posZ = posZ + Random(1, 45)
							posX = posX - Random(1, 45)
						else
							posZ = posZ - Random(1, 45)
							posX = posX - Random(1, 45)
						end

						if posX < 5 then
							posX = Random(5, 45)
						end
						if posX > (sizeX - 5) then
							posX = sizeX - Random(5, 45)
						end
						if posZ < 5 then
							posZ = Random(5, 45)
						end
						if posZ > (sizeZ - 5) then
							posZ = sizeZ - Random(5, 45)
						end
					local terrainAltitude = GetTerrainHeight(posX, posZ)
					unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
                end
            end
        end
        if unit ~= nil then
            maxhp = unit:GetMaxHealth()
            unit:SetMaxHealth(maxhp + 18 * (GetGameTimeSeconds() - WavesStartTimeAI) + Random(250, 500) * totalEnemyT3LandDefences + Random(1000, 2000) * totalEnemyExpDefences + Random(50000, 75000) * totalEnemyEndgamers + HealthBonus + totalExpUnits * Random(2000, 3000))
            hp = unit:GetMaxHealth()
            unit:SetHealth(self, hp)
			local Pos1x, Pos1y, Pos1z = unit:GetPositionXYZ()
            local attachedUnitsCount = Random(3, 5) + math.floor(totalEnemyYolonas * 0.33 + 0.5) + math.floor(totalEnemyParagons * 0.5 + 0.5)
            if attachedUnitsCount > 12 then
                attachedUnitsCount = 12
            end
            local bonesCount = unit:GetBoneCount()
            if bonesCount > 1 then
                repeat
                    --[[if landUnitsExtremeHeavy and landUnitsExtremeHeavy.Tech4 and exHLand > 0 and Random(1, 3) == 2 then
                        AttachedLandUnitSpawn(unit, rspawn, (landUnitsExtremeHeavy.Tech4)[Random(1, exHLand)], Random(1, bonesCount - 1))
                    elseif landUnitsE and landUnitsE.Tech4 and Eland > 0 and Random(1, 3) == 2 then
                        AttachedLandUnitSpawn(unit, rspawn, (landUnitsE.Tech4)[Random(1, Eland)], Random(1, bonesCount - 1))]]--
					if Random(1, 4) < 4 then	
						if landUnitsH and landUnitsH.Tech4 and Hland > 0 then
							AttachedLandUnitSpawn(unit, rspawn, (landUnitsH.Tech4)[Random(1, Hland)], Random(1, bonesCount - 1))
						elseif landUnitsM and landUnitsM.Tech4 and Mland > 0 then
							AttachedLandUnitSpawn(unit, rspawn, (landUnitsM.Tech4)[Random(1, Mland)], Random(1, bonesCount - 1))
						elseif landUnitsL and landUnitsL.Tech4 and Lland > 0 then
							AttachedLandUnitSpawn(unit, rspawn, (landUnitsL.Tech4)[Random(1, Lland)], Random(1, bonesCount - 1))
						end
					end	
                    WaitTicks(2)
                    attachedUnitsCount = attachedUnitsCount - 1
                until attachedUnitsCount < 1
            end
			if DamageBoost ~= 'Off - 0' then
				ModifyWeaponDamageBuffBoss(unit)
			end	
            WaitTicks(5)
            unit:SetCustomName("EndGame Boss")
            unit:SetSpeedMult(0.85 + (waveNum * SpeedBonus + SpeedBonusOnce) * 0.3)
            if WaveStyle == "Even Attack Waves" then	
				RedirectUnitEndgameBoss(unit)
			elseif WaveStyle == "Dynamic Attack Waves" or WaveStyle == "Human with AI Assist" then
				RedirectUnitEndgameBoss(unit)
			end
			if KillPlayerUnit > 0 then
				SuicideBoss(unit)
			end
			WaitSeconds(20)
			if not unit:BeenDestroyed() then
				local Pos2x, Pos2y, Pos2z = unit:GetPositionXYZ()
				if Pos1x == Pos2x and Pos1z == Pos2z then
					unit:Destroy()
					CreateHugeBossUnitAroundMainBuildingForAI()
				end	
			end
        end
        KillThread(self)
    end)
end
function CreateHugeBossForYolonas() -- Endgame Boss for Yolos Land
    local circle = ForkThread(function(self)
        WaitTicks(100)
        local rspawn
        local unit = nil
        local posX
		local posZ
		--local MapCheck = false
		local Chance
		--local count = 0
		if AltHQSpawn ~= "Off" and HQAltBuildingDead == false and Random(1, 2) == 1 then
			posX, posZ = AltHQBrain:GetArmyStartPos()
		else
			posX, posZ = aiBrain:GetArmyStartPos()
		end
        if GetGameTimeSeconds() > 60 then
            if landUnitsExtremeHeavy and landUnitsExtremeHeavy.Tech4 and exHLand > 0 then
                rspawn = (landUnitsExtremeHeavy.Tech4)[Random(1, exHLand)]
            elseif landUnitsE and landUnitsE.Tech4 and Eland > 0 then
                rspawn = (landUnitsE.Tech4)[Random(1, Eland)]
            else
                rspawn = (landUnitsH.Tech4)[Random(1, Hland)]
            end
            if rspawn ~= nil then
                local oldposX = posX
				local oldposZ = posZ
					Chance = Random(1, 8)
					if Chance == 1 then
						posX = posX + Random(1, 45)
						posZ = posZ + Random(1, 45)
					elseif Chance == 2 then
						posX = posX - Random(1, 45)
						posZ = posZ + Random(1, 45)
					elseif Chance == 3 then
						posX = posX + Random(1, 45)
						posZ = posZ - Random(1, 45)
					elseif Chance == 4 then
						posX = posX - Random(1, 45)
						posZ = posZ - Random(1, 45)
					elseif Chance == 5 then
						posZ = posZ + Random(1, 45)
						posX = posX + Random(1, 45)
					elseif Chance == 6 then
						posZ = posZ - Random(1, 45)
						posX = posX + Random(1, 45)
					elseif Chance == 7 then
						posZ = posZ + Random(1, 45)
						posX = posX - Random(1, 45)
					else
						posZ = posZ - Random(1, 45)
						posX = posX - Random(1, 45)
					end

					if posX < 5 then
						posX = Random(5, 45)
					end
					if posX > (sizeX - 5) then
						posX = sizeX - Random(5, 45)
					end
					if posZ < 5 then
						posZ = Random(5, 45)
					end
					if posZ > (sizeZ - 5) then
						posZ = sizeZ - Random(5, 45)
					end
				unit = aiBrain:CreateUnitNearSpot(rspawn, posX, posZ)
				if unit == nil then
					local posX = oldposX
					local posZ = oldposZ
						Chance = Random(1, 8)
						if Chance == 1 then
							posX = posX + Random(1, 45)
							posZ = posZ + Random(1, 45)
						elseif Chance == 2 then
							posX = posX - Random(1, 45)
							posZ = posZ + Random(1, 45)
						elseif Chance == 3 then
							posX = posX + Random(1, 45)
							posZ = posZ - Random(1, 45)
						elseif Chance == 4 then
							posX = posX - Random(1, 45)
							posZ = posZ - Random(1, 45)
						elseif Chance == 5 then
							posZ = posZ + Random(1, 45)
							posX = posX + Random(1, 45)
						elseif Chance == 6 then
							posZ = posZ - Random(1, 45)
							posX = posX + Random(1, 45)
						elseif Chance == 7 then
							posZ = posZ + Random(1, 45)
							posX = posX - Random(1, 45)
						else
							posZ = posZ - Random(1, 45)
							posX = posX - Random(1, 45)
						end

						if posX < 5 then
							posX = Random(5, 45)
						end
						if posX > (sizeX - 5) then
							posX = sizeX - Random(5, 45)
						end
						if posZ < 5 then
							posZ = Random(5, 45)
						end
						if posZ > (sizeZ - 5) then
							posZ = sizeZ - Random(5, 45)
						end
					local terrainAltitude = GetTerrainHeight(posX, posZ)
					unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
                end
            end
        end
        if unit ~= nil then
            maxhp = unit:GetMaxHealth()
            unit:SetMaxHealth(maxhp + 100000 + 20 * (GetGameTimeSeconds() - WavesStartTimeAI) + Random(300, 550) * totalEnemyT3LandDefences + Random(1000, 2000) * totalEnemyExpDefences + Random(50000, 75000) * totalEnemyEndgamers + HealthBonus + totalExpUnits * Random(2000, 3000))
            hp = unit:GetMaxHealth()
            unit:SetHealth(self, hp)
			local Pos1x, Pos1y, Pos1z = unit:GetPositionXYZ()
            local attachedUnitsCount = Random(3, 5) + math.floor(totalEnemyYolonas * 0.33 + 0.5) + math.floor(totalEnemyParagons * 0.5 + 0.5)
            if attachedUnitsCount > 12 then
                attachedUnitsCount = 12
            end
            local bonesCount = unit:GetBoneCount()
            if bonesCount > 1 then
                repeat
                    --[[if landUnitsExtremeHeavy and landUnitsExtremeHeavy.Tech4 and exHLand > 0 and Random(1, 3) == 2 then
                        AttachedLandUnitSpawn(unit, rspawn, (landUnitsExtremeHeavy.Tech4)[Random(1, exHLand)], Random(1, bonesCount - 1))
                    elseif landUnitsE and landUnitsE.Tech4 and Eland > 0 and Random(1, 3) == 2 then
                        AttachedLandUnitSpawn(unit, rspawn, (landUnitsE.Tech4)[Random(1, Eland)], Random(1, bonesCount - 1))]]--
					if Random(1, 4) < 4 then	
						if landUnitsH and landUnitsH.Tech4 and Hland > 0 then
							AttachedLandUnitSpawn(unit, rspawn, (landUnitsH.Tech4)[Random(1, Hland)], Random(1, bonesCount - 1))
						elseif landUnitsM and landUnitsM.Tech4 and Mland > 0 then
							AttachedLandUnitSpawn(unit, rspawn, (landUnitsM.Tech4)[Random(1, Mland)], Random(1, bonesCount - 1))
						elseif landUnitsL and landUnitsL.Tech4 and Lland > 0 then
							AttachedLandUnitSpawn(unit, rspawn, (landUnitsL.Tech4)[Random(1, Lland)], Random(1, bonesCount - 1))
						end
					end	
                    WaitTicks(2)
                    attachedUnitsCount = attachedUnitsCount - 1
                until attachedUnitsCount < 1
            end
			if DamageBoost ~= 'Off - 0' then
				ModifyWeaponDamageBuffBoss(unit)
			end	
            WaitTicks(5)
            unit:SetCustomName("Yolo Boss")
            unit:SetSpeedMult(1 + (waveNum * SpeedBonus + SpeedBonusOnce) * 0.3)
            if WaveStyle == "Even Attack Waves" then	
				RedirectDoomWalker(unit)
			elseif WaveStyle == "Dynamic Attack Waves" or WaveStyle == "Human with AI Assist" then
				RedirectDoomWalker(unit)
			end
			WaitSeconds(20)
			if not unit:BeenDestroyed() then
				local Pos2x, Pos2y, Pos2z = unit:GetPositionXYZ()
				if Pos1x == Pos2x and Pos1z == Pos2z then
					unit:Destroy()
					CreateHugeBossForYolonas()
				end	
			end
        end
        KillThread(self)
    end)
end
function CreateDoomBoss() --Endgame Doom Boss
    local circle = ForkThread(function(self)
        WaitTicks(50)
		local DoomHPBonus
        local rspawn
        local unit = nil
        local posX
		local posZ
		--local MapCheck = false
		local Chance
		--local count = 0
		if AltHQSpawn ~= "Off" and HQAltBuildingDead == false and Random(1, 2) == 1 then
			posX, posZ = AltHQBrain:GetArmyStartPos()
		else
			posX, posZ = aiBrain:GetArmyStartPos()
		end
        if GetGameTimeSeconds() > WavesStartTimeAI then	
			rspawn = (DoomTable)[Random(1, DoomTableCt)]

            if rspawn ~= nil then
                local oldposX = posX
				local oldposZ = posZ
					Chance = Random(1, 8)
					if Chance == 1 then
						posX = posX + Random(1, 45)
						posZ = posZ + Random(1, 45)
					elseif Chance == 2 then
						posX = posX - Random(1, 45)
						posZ = posZ + Random(1, 45)
					elseif Chance == 3 then
						posX = posX + Random(1, 45)
						posZ = posZ - Random(1, 45)
					elseif Chance == 4 then
						posX = posX - Random(1, 45)
						posZ = posZ - Random(1, 45)
					elseif Chance == 5 then
						posZ = posZ + Random(1, 45)
						posX = posX + Random(1, 45)
					elseif Chance == 6 then
						posZ = posZ - Random(1, 45)
						posX = posX + Random(1, 45)
					elseif Chance == 7 then
						posZ = posZ + Random(1, 45)
						posX = posX - Random(1, 45)
					else
						posZ = posZ - Random(1, 45)
						posX = posX - Random(1, 45)
					end

					if posX < 5 then
						posX = Random(5, 45)
					end
					if posX > (sizeX - 5) then
						posX = sizeX - Random(5, 45)
					end
					if posZ < 5 then
						posZ = Random(5, 45)
					end
					if posZ > (sizeZ - 5) then
						posZ = sizeZ - Random(5, 45)
					end
				unit = aiBrain:CreateUnitNearSpot(rspawn, posX, posZ)
				if unit == nil then
					local posX = oldposX
					local posZ = oldposZ
						Chance = Random(1, 8)
						if Chance == 1 then
							posX = posX + Random(1, 45)
							posZ = posZ + Random(1, 45)
						elseif Chance == 2 then
							posX = posX - Random(1, 45)
							posZ = posZ + Random(1, 45)
						elseif Chance == 3 then
							posX = posX + Random(1, 45)
							posZ = posZ - Random(1, 45)
						elseif Chance == 4 then
							posX = posX - Random(1, 45)
							posZ = posZ - Random(1, 45)
						elseif Chance == 5 then
							posZ = posZ + Random(1, 45)
							posX = posX + Random(1, 45)
						elseif Chance == 6 then
							posZ = posZ - Random(1, 45)
							posX = posX + Random(1, 45)
						elseif Chance == 7 then
							posZ = posZ + Random(1, 45)
							posX = posX - Random(1, 45)
						else
							posZ = posZ - Random(1, 45)
							posX = posX - Random(1, 45)
						end

						if posX < 5 then
							posX = Random(5, 45)
						end
						if posX > (sizeX - 5) then
							posX = sizeX - Random(5, 45)
						end
						if posZ < 5 then
							posZ = Random(5, 45)
						end
						if posZ > (sizeZ - 5) then
							posZ = sizeZ - Random(5, 45)
						end
					local terrainAltitude = GetTerrainHeight(posX, posZ)
					unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
                end
            end
        end
        if unit ~= nil then
			--BoostDoomHealth(unit)
            maxhp = unit:GetMaxHealth()
			DoomHPBonus = DoomBoostHP * maxhp
            unit:SetMaxHealth(maxhp + DoomHPBonus + Random(250, 500) * totalEnemyT3LandDefences + Random(1000, 2000) * totalEnemyExpDefences + Random(50000, 75000) * totalEnemyEndgamers + HealthBonus * 17 + totalExpUnits * Random(3000, 5000))
            hp = unit:GetMaxHealth()
            unit:SetHealth(self, hp)
			local Pos1x, Pos1y, Pos1z = unit:GetPositionXYZ()
			--unit:AlterArmor("Nuke", 0.33)
            local attachedUnitsCount = 4 + math.floor(totalEnemyYolonas * 0.33 + 0.5) + math.floor(totalEnemyParagons * 0.5 + 0.5)
            if attachedUnitsCount > 6 then
                attachedUnitsCount = 6
            end
            local bonesCount = unit:GetBoneCount()
            if bonesCount > 1 then
                repeat
                    --[[if landUnitsExtremeHeavy and landUnitsExtremeHeavy.Tech4 and exHLand > 0 and Random(1, 3) == 2 then
                        AttachedLandUnitSpawn(unit, rspawn, (landUnitsExtremeHeavy.Tech4)[Random(1, exHLand)], Random(1, bonesCount - 1))
                    elseif landUnitsE and landUnitsE.Tech4 and Eland > 0 and Random(1, 3) == 2 then
                        AttachedLandUnitSpawn(unit, rspawn, (landUnitsE.Tech4)[Random(1, Eland)], Random(1, bonesCount - 1))]]--
					if Random(1, 4) < 4 then	
						if landUnitsH and landUnitsH.Tech4 and Hland > 0 then
							AttachedLandUnitSpawn(unit, rspawn, (landUnitsH.Tech4)[Random(1, Hland)], Random(1, bonesCount - 1))
						elseif landUnitsM and landUnitsM.Tech4 and Mland > 0 then
							AttachedLandUnitSpawn(unit, rspawn, (landUnitsM.Tech4)[Random(1, Mland)], Random(1, bonesCount - 1))
						elseif landUnitsL and landUnitsL.Tech4 and Lland > 0 then
							AttachedLandUnitSpawn(unit, rspawn, (landUnitsL.Tech4)[Random(1, Lland)], Random(1, bonesCount - 1))
						end
					end	
                    WaitTicks(2)
                    attachedUnitsCount = attachedUnitsCount - 1
                until attachedUnitsCount < 1
            end
			if DamageBoost ~= 'Off - 0' then
				ModifyWeaponDamageBuffDoom(unit)
			end	
            WaitTicks(5)
            --unit:SetCustomName("DOOM")
            unit:SetSpeedMult(1 + (waveNum * SpeedBonus + SpeedBonusOnce) * 0.3)
            if rspawn == "DUE0401" or rspawn == "DCB0403" then	
				RedirectDoomCrawler(unit)
			elseif rspawn == "DAN0401" or rspawn == "DSP0401" then
				RedirectDoomWalker(unit)
			end
			if KillPlayerUnit > 0 then
				SuicideBoss(unit)
			end
			WaitSeconds(20)
			if not unit:BeenDestroyed() then
				local Pos2x, Pos2y, Pos2z = unit:GetPositionXYZ()
				if Pos1x == Pos2x and Pos1z == Pos2z then
					unit:Destroy()
					CreateDoomBoss()
				end	
			end
        end
        KillThread(self)
    end)
end
function FillDoomTable()
	local circle = ForkThread(function(self)
		DoomTable = {}
		
		if DoomCrawlers == "Doom Mega + Doom Fatboy" then
			table.insert(DoomTable, "DUE0401")
			table.insert(DoomTable, "DCB0403")
		elseif DoomCrawlers == "Doom Mega" then
			table.insert(DoomTable, "DCB0403")
		elseif DoomCrawlers == "Doom Fatboy" then
			table.insert(DoomTable, "DUE0401")
		end	
		
		if DoomWalkers == "Doom Colossus + Doom Ythotha" then
			table.insert(DoomTable, "DAN0401")
			table.insert(DoomTable, "DSP0401")
		elseif DoomWalkers == "Doom Colossus" then
			table.insert(DoomTable, "DAN0401")
		elseif DoomWalkers == "Doom Ythotha" then
			table.insert(DoomTable, "DSP0401")
		end	
		
		DoomTableCt = table.getn(DoomTable)
		--PrintText("Table Count " .. DoomTableCt .. " !", 28, 'ffCBFFFF', 6, 'center')
	end)
end
function BoostDoomHealth(aUnit) --Disabled
    local circle = ForkThread(function(self)
		local maxhp
		local hp
		local DoomHPBonus
        if aUnit ~= nil then
            maxhp = aUnit:GetMaxHealth()
			DoomHPBonus = DoomBoostHP * maxhp
            aUnit:SetMaxHealth(maxhp + DoomHPBonus + Random(250, 500) * totalEnemyT3LandDefences + Random(1000, 2000) * totalEnemyExpDefences + Random(50000, 75000) * totalEnemyEndgamers + HealthBonus * 17 + totalExpUnits * Random(2000, 3000))
            hp = aUnit:GetMaxHealth()
            aUnit:SetHealth(self, hp)
			repeat
				WaitSeconds(10)
			until aUnit:BeenDestroyed() or aUnit == nil
        end
        KillThread(self)
    end)
end
function DeployDooms() --Begin Doom Wave
	local circle = ForkThread(function(self)
		local count = DoomCount
		if HQAlert == true then
			local totalEnemyMass = CalculateEnemyMass()
			if totalEnemyMass >= 5000 then
				local ExtraDooms = math.floor(totalEnemyMass * 0.0002 + 0.1)
				count = count + ExtraDooms
			end
		end
		repeat
			CreateDoomBoss()
			count = count - 1
		until count < 1	
		PrintText("===Doom Wave Deployed!===", 28, 'ffCBFFFF', 10, 'center')
		if DoomIncrease ~= 0 then
			DoomWaveCount = DoomWaveCount + 1
			DoomCount = DoomCount + (DoomWaveCount * DoomIncrease)
			if DoomCount < DoomMinimum then
				DoomCount = DoomMinimum
			end
			if DoomMaximum ~= "Off --" and DoomCount > DoomMaximum then
				DoomCount = DoomMaximum
			end
		end	
		WaitSeconds(10)
		if won ~= true then
			MonitorDoomWave()
		end	
	end)
end	
function MonitorDoomWave() --Monitor Dooms
	local circle = ForkThread(function(self)
		local AliveDooms
		--local TotalDooms
		local HQMaxHP
		local HQCurrentHP
		local HQDamage
		local HQhp
		local HQAlmostDead
		repeat
			WaitSeconds(5)
			AliveDooms = aiBrain:GetListOfUnits(categories.OPERATION * categories.MOBILE * categories.MASSIVE * categories.STRATEGIC * categories.BOT - categories.STRUCTURE, false)
			TotalDooms = table.getn(AliveDooms)
			--PrintText("Total Dooms " .. TotalDooms .. " !", 28, 'ffCBFFFF', 6, 'center')
		until TotalDooms == 0	
		--HQ Check/Damage
		if DoomStorm ~= "Off --" and Random(1, 10) <= 6 then --and Random(1, 2) == 2
			DoomElectronStormsSpawner()
		end	
		if AIMainBuilding ~= nil and not AIMainBuilding:BeenDestroyed() then
			HQMaxHP = AIMainBuilding:GetMaxHealth()
			HQCurrentHP = AIMainBuilding:GetHealth()
			HQDamage = MainBuildingHPAI * DoomDamageHQ
			HQAlmostDead = HQCurrentHP - (HQDamage * 2)
			HQhp = HQCurrentHP - HQDamage
			if HQhp > 0 and DoomDamageHQ > 0 then
				AIMainBuilding:SetHealth(self, HQhp)
				PrintText("HQ Damaged! " .. HQhp .. " Health!", 28, 'ffCBFFFF', 6, 'center')
			else
				AIMainBuilding:Kill()
			end	
			if HQAlmostDead <= 0 and DoomDamageHQ > 0 and HQAlert == false then
				PrintText("===HQ near Defeat! Final Doom Wave!===", 28, 'ffEC3F35', 6, 'center')
				HQAlert = true
			end	
		end
		WaitSeconds(50)
		if won ~= true then
			DeployDooms()
		end	
	end)
end	
function CreateAUnitAroundSecondaryBuildingsForAI(unitIda)
    local circle = ForkThread(function(self)
        if aiSecondaryBuildings and aiSecondaryBuildings.secondaryBuildings then
			--local MapCheck = false
			local Chance
			local terrainAltitude
			local surfaceAltitude
			--local count = 0
            local buildingcount = 0
			for aindex, sBuilding in aiSecondaryBuildings.secondaryBuildings do
                if sBuilding and not sBuilding:BeenDestroyed() then
				buildingcount = buildingcount + 1
				local testunit = (aiSecondaryBuildings.secondaryBuildings)[buildingcount]
                    --[[if unitId == nil or unitId == "" then
                        if Random(1, 3) == 1 and AirPerWave > 0 then
                            unitId = "UEB2304"
                        elseif Random(1, 2) == 1 then
                            unitId = "XEB2306"
                        elseif Random(1, 2) == 1 then
                            unitId = "URB4201"
						elseif Random(1, 3) == 1 and (sBuilding:GetCurrentLayer() == "Water" or sBuilding:GetCurrentLayer() == "Seabed") and NavyPerWave > 0 then
							unitId = "XRB2308"
                        end
                    end]]--
					unitIda = nil
                    if unitIda == nil or unitIda == "" then
						if not testunit:BeenDestroyed() and NavyPerWave > 0 and (testunit:GetCurrentLayer() == "Water") and Random(1, 2) == 1 then
							unitIda = "XRB2308"
						elseif Random(1, 3) <= 2 then
                            unitIda = "UPD2304"
						else
							unitIda = "URB4201"
                        end
                    end
                    local unit = nil
                    local posX, posY, posZ = sBuilding:GetPositionXYZ()
                    --if GetGameTimeSeconds() > (WavesStartTimeAI * 0.8) then
                        rspawn = unitIda
                        if rspawn ~= nil then
                            local oldposX = posX
							local oldposZ = posZ
								Chance = Random(1, 8)
								if Chance == 1 then
									posX = posX + Random(5, 15)
									posZ = posZ + Random(5, 15)
								elseif Chance == 2 then
									posX = posX - Random(5, 15)
									posZ = posZ + Random(5, 15)
								elseif Chance == 3 then
									posX = posX + Random(5, 15)
									posZ = posZ - Random(5, 15)
								elseif Chance == 4 then
									posX = posX - Random(5, 15)
									posZ = posZ - Random(5, 15)
								elseif Chance == 5 then
									posZ = posZ + Random(5, 15)
									posX = posX + Random(5, 15)
								elseif Chance == 6 then
									posZ = posZ - Random(5, 15)
									posX = posX + Random(5, 15)
								elseif Chance == 7 then
									posZ = posZ + Random(5, 15)
									posX = posX - Random(5, 15)
								else
									posZ = posZ - Random(5, 15)
									posX = posX - Random(5, 15)
								end

								if posX <= 0 then
									posX = Random(1, 15)
								end
								if posX >= sizeX then
									posX = sizeX - Random(1, 15)
								end
								if posZ <= 0 then
									posZ = Random(1, 15)
								end
								if posZ >= sizeZ then
									posZ = sizeZ - Random(1, 15)
								end
								if rspawn == "XRB2308" then
									terrainAltitude = GetTerrainHeight(posX, posZ)
									surfaceAltitude = GetSurfaceHeight(posX, posZ)
									if surfaceAltitude == terrainAltitude then
										if Random(1, 3) <= 2 then
											rspawn = "UPD2304"
										else
											rspawn = "URB4201"
										end
									end
								end
							unit = aiBrain:CreateUnitNearSpot(rspawn, posX, posZ)
							if unit == nil then
								local posX = oldposX
								local posZ = oldposZ
									Chance = Random(1, 8)
									if Chance == 1 then
										posX = posX + Random(5, 15)
										posZ = posZ + Random(5, 15)
									elseif Chance == 2 then
										posX = posX - Random(5, 15)
										posZ = posZ + Random(5, 15)
									elseif Chance == 3 then
										posX = posX + Random(5, 15)
										posZ = posZ - Random(5, 15)
									elseif Chance == 4 then
										posX = posX - Random(5, 15)
										posZ = posZ - Random(5, 15)
									elseif Chance == 5 then
										posZ = posZ + Random(5, 15)
										posX = posX + Random(5, 15)
									elseif Chance == 6 then
										posZ = posZ - Random(5, 15)
										posX = posX + Random(5, 15)
									elseif Chance == 7 then
										posZ = posZ + Random(5, 15)
										posX = posX - Random(5, 15)
									else
										posZ = posZ - Random(5, 15)
										posX = posX - Random(5, 15)
									end

									if posX <= 0 then
									posX = Random(1, 15)
									end
									if posX >= sizeX then
										posX = sizeX - Random(1, 15)
									end
									if posZ <= 0 then
										posZ = Random(1, 15)
									end
									if posZ >= sizeZ then
										posZ = sizeZ - Random(1, 15)
									end
									if rspawn == "XRB2308" then
									terrainAltitude = GetTerrainHeight(posX, posZ)
									surfaceAltitude = GetSurfaceHeight(posX, posZ)
									if surfaceAltitude == terrainAltitude then
										if Random(1, 3) <= 2 then
											rspawn = "UPD2304"
										else
											rspawn = "URB4201"
										end
									end
								end
								terrainAltitude = GetTerrainHeight(posX, posZ)
								unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
                            end
                        end
                        if unit ~= nil then
                            maxhp = unit:GetMaxHealth()
                            unit:SetMaxHealth(maxhp + 1000 + (500 * humans) + (Random(10000, 15000) * totalEnemyParagons))
                            hp = unit:GetMaxHealth()
                            unit:SetHealth(self, hp)
                        end
                    --end
                end
            end
        end
        KillThread(self)
    end)
end
function CreateAndLaunchNukeAtEnemy()
    local circle = ForkThread(function(self)
        local unit = nil
        local posX 
		local posZ
		--local MapCheck = false
		local Chance
		--local count = 0
		if AltHQSpawn ~= "Off" and HQAltBuildingDead == false and Random(1, 2) == 1 then
			posX, posZ = AltHQBrain:GetArmyStartPos()
		else
			posX, posZ = aiBrain:GetArmyStartPos()
		end	
        if GetGameTimeSeconds() > 60 then
            rspawn = "NML2305"
            if rspawn ~= nil then
                local oldposX = posX
				local oldposZ = posZ
					Chance = Random(1, 8)
					if Chance == 1 then
						posX = posX + Random(1, 50)
						posZ = posZ + Random(1, 50)
					elseif Chance == 2 then
						posX = posX - Random(1, 50)
						posZ = posZ + Random(1, 50)
					elseif Chance == 3 then
						posX = posX + Random(1, 50)
						posZ = posZ - Random(1, 50)
					elseif Chance == 4 then
						posX = posX - Random(1, 50)
						posZ = posZ - Random(1, 50)
					elseif Chance == 5 then
						posZ = posZ + Random(1, 50)
						posX = posX + Random(1, 50)
					elseif Chance == 6 then
						posZ = posZ - Random(1, 50)
						posX = posX + Random(1, 50)
					elseif Chance == 7 then
						posZ = posZ + Random(1, 50)
						posX = posX - Random(1, 50)
					else
						posZ = posZ - Random(1, 50)
						posX = posX - Random(1, 50)
					end

					if posX <= 0 then
						posX = Random(1, 50)
					end
					if posX >= sizeX then
						posX = sizeX - Random(1, 50)
					end
					if posZ <= 0 then
						posZ = Random(1, 50)
					end
					if posZ >= sizeZ then
						posZ = sizeZ - Random(1, 50)
					end
				unit = aiBrain:CreateUnitNearSpot(rspawn, posX, posZ)
				if unit == nil then
					local posX = oldposX
					local posZ = oldposZ
						Chance = Random(1, 8)
						if Chance == 1 then
							posX = posX + Random(1, 50)
							posZ = posZ + Random(1, 50)
						elseif Chance == 2 then
							posX = posX - Random(1, 50)
							posZ = posZ + Random(1, 50)
						elseif Chance == 3 then
							posX = posX + Random(1, 50)
							posZ = posZ - Random(1, 50)
						elseif Chance == 4 then
							posX = posX - Random(1, 50)
							posZ = posZ - Random(1, 50)
						elseif Chance == 5 then
							posZ = posZ + Random(1, 50)
							posX = posX + Random(1, 50)
						elseif Chance == 6 then
							posZ = posZ - Random(1, 50)
							posX = posX + Random(1, 50)
						elseif Chance == 7 then
							posZ = posZ + Random(1, 50)
							posX = posX - Random(1, 50)
						else
							posZ = posZ - Random(1, 50)
							posX = posX - Random(1, 50)
						end

						if posX <= 0 then
							posX = Random(1, 50)
						end
						if posX >= sizeX then
							posX = sizeX - Random(1, 50)
						end
						if posZ <= 0 then
							posZ = Random(1, 50)
						end
						if posZ >= sizeZ then
							posZ = sizeZ - Random(1, 50)
						end
					local terrainAltitude = GetTerrainHeight(posX, posZ)
					unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
                end
            end
        end
        if unit ~= nil then
            maxhp = unit:GetMaxHealth()
            unit:SetMaxHealth(maxhp + 5000000)
            hp = unit:GetMaxHealth()
            unit:SetHealth(self, hp)
            unit:GiveNukeSiloAmmo(1)
            local targetedUnit = GetAllEnemyUnitsForNukes()
            WaitTicks(20)
            if targetedUnit then
                IssueNuke({ unit }, targetedUnit:GetPosition())
            end
            WaitTicks(750)
            if unit ~= nil and not unit:BeenDestroyed() then
				unit:Kill()
            end
        end
        KillThread(self)
    end)
end
function CreateAndLaunchNukeAtEnemyUnit(hUnit)
    local circle = ForkThread(function(self)
        local unit = nil
        local posX, posZ = aiBrain:GetArmyStartPos()
		--local MapCheck = false
		local Chance
		--local count = 0
        if GetGameTimeSeconds() > WavesStartTimeAI and (NukesOn == "All On" or NukesOn == "Defensive" or NukesOn == "Offensive") then
            rspawn = "NML2305"
            if rspawn ~= nil then
                local oldposX = posX
				local oldposZ = posZ
					Chance = Random(1, 8)
					if Chance == 1 then
						posX = posX + Random(1, 50)
						posZ = posZ + Random(1, 50)
					elseif Chance == 2 then
						posX = posX - Random(1, 50)
						posZ = posZ + Random(1, 50)
					elseif Chance == 3 then
						posX = posX + Random(1, 50)
						posZ = posZ - Random(1, 50)
					elseif Chance == 4 then
						posX = posX - Random(1, 50)
						posZ = posZ - Random(1, 50)
					elseif Chance == 5 then
						posZ = posZ + Random(1, 50)
						posX = posX + Random(1, 50)
					elseif Chance == 6 then
						posZ = posZ - Random(1, 50)
						posX = posX + Random(1, 50)
					elseif Chance == 7 then
						posZ = posZ + Random(1, 50)
						posX = posX - Random(1, 50)
					else
						posZ = posZ - Random(1, 50)
						posX = posX - Random(1, 50)
					end

					if posX <= 0 then
						posX = Random(1, 50)
					end
					if posX >= sizeX then
						posX = sizeX - Random(1, 50)
					end
					if posZ <= 0 then
						posZ = Random(1, 50)
					end
					if posZ >= sizeZ then
						posZ = sizeZ - Random(1, 50)
					end
				unit = aiBrain:CreateUnitNearSpot(rspawn, posX, posZ)
				if unit == nil then
					local posX = oldposX
					local posZ = oldposZ
						Chance = Random(1, 8)
						if Chance == 1 then
							posX = posX + Random(1, 50)
							posZ = posZ + Random(1, 50)
						elseif Chance == 2 then
							posX = posX - Random(1, 50)
							posZ = posZ + Random(1, 50)
						elseif Chance == 3 then
							posX = posX + Random(1, 50)
							posZ = posZ - Random(1, 50)
						elseif Chance == 4 then
							posX = posX - Random(1, 50)
							posZ = posZ - Random(1, 50)
						elseif Chance == 5 then
							posZ = posZ + Random(1, 50)
							posX = posX + Random(1, 50)
						elseif Chance == 6 then
							posZ = posZ - Random(1, 50)
							posX = posX + Random(1, 50)
						elseif Chance == 7 then
							posZ = posZ + Random(1, 50)
							posX = posX - Random(1, 50)
						else
							posZ = posZ - Random(1, 50)
							posX = posX - Random(1, 50)
						end

						if posX <= 0 then
							posX = Random(1, 50)
						end
						if posX >= sizeX then
							posX = sizeX - Random(1, 50)
						end
						if posZ <= 0 then
							posZ = Random(1, 50)
						end
						if posZ >= sizeZ then
							posZ = sizeZ - Random(1, 50)
						end
					local terrainAltitude = GetTerrainHeight(posX, posZ)
					unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
                end
            end
        end
        if unit ~= nil then
		local weapon = unit:GetWeapon(1) 
		local oldCreateProjectileAtMuzzle = weapon.CreateProjectileAtMuzzle
		weapon.CreateProjectileAtMuzzle = function(self, muzzle)
			local proj = oldCreateProjectileAtMuzzle(self, muzzle)
			if proj.MovementThread then
					proj.MovementThread = function (self)
						local launcher = self:GetLauncher()
						self.Nuke = true
						self.CreateEffects(self, self.InitialEffects, self.Army, 1)
						self:TrackTarget(false)
						WaitSeconds(2.5) 
						LOG("Speeding Up nuke missile.")
						self:SetAcceleration(3)
						self:SetCollision(true)
						self.CreateEffects(self, self.LaunchEffects, self.Army, 1)
						WaitSeconds(2.5)
						self.CreateEffects(self, self.ThrustEffects, self.Army, 3)
						WaitSeconds(2.5)
						self:TrackTarget(true) 
						self:SetDestroyOnWater(true)
						self:SetTurnRate(45)
						WaitSeconds(2) 
						self:SetTurnRate(0)
						self:SetAcceleration(0.001)
						self.WaitTime = 0.5
						while not self:BeenDestroyed() do
							self:SetTurnRateByDist()
							WaitSeconds(self.WaitTime)
						end
					end
			end
			return proj
		end
            maxhp = unit:GetMaxHealth()
            unit:SetMaxHealth(maxhp + 5000000)
            hp = unit:GetMaxHealth()
            unit:SetHealth(self, hp)
            unit:GiveNukeSiloAmmo(1)
            local targetedUnit = hUnit
            WaitTicks(20)
            if targetedUnit then
                IssueNuke({ unit }, targetedUnit:GetPosition())
            end
            WaitTicks(750)
            if unit ~= nil and not unit:BeenDestroyed() then
                unit:Kill()
            end
        end
        KillThread(self)
    end)
end
function PositioningSpawnedUnit(unit)
    local posX, posZ = aiBrain:GetArmyStartPos()
    local oldposX = posX
    local oldposZ = posZ
    if Random(1, 2) == 2 then
        posX = posX + Random(5, 20)
        posZ = posZ + Random(5, 20)
    else
        posX = posX - Random(5, 20)
        posZ = posZ + Random(5, 20)
    end
    if Random(1, 2) == 2 then
        posX = posX + Random(5, 20)
        posZ = posZ - Random(5, 20)
    else
        posX = posX - Random(5, 20)
        posZ = posZ - Random(5, 20)
    end
    if Random(1, 2) == 2 then
        posZ = posZ + Random(5, 20)
        posX = posX + Random(5, 20)
    else
        posZ = posZ - Random(5, 20)
        posX = posX + Random(5, 20)
    end
    if Random(1, 2) == 2 then
        posZ = posZ + Random(5, 20)
        posX = posX - Random(5, 20)
    else
        posZ = posZ - Random(5, 20)
        posX = posX - Random(5, 20)
    end
    local terrainAltitude = GetTerrainHeight(posX, posZ)
    unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
end
GetRandomEnemyDefenseUnit = function(self)
    local enemyUnit = nil
    for i, brain in humanBrains.HBrains do
        if not IsAlly(aiBrain:GetArmyIndex(), brain:GetArmyIndex()) and not brain:IsDefeated() then
            local enemyDefenceUnits = brain:GetListOfUnits((categories.STRUCTURE * categories.EXPERIMENTAL * categories.DEFENSE)
                + (categories.STRUCTURE * categories.NAVAL * categories.FACTORY) + 
				(categories.STRUCTURE * categories.TECH3) + (categories.STRUCTURE * categories.EXPERIMENTAL), false)
            if enemyDefenceUnits ~= nil then
                enemyUnit = (enemyDefenceUnits)[Random(1, table.getn(enemyDefenceUnits))]
                if enemyUnit then
                    break
                end
            end
        end
    end
    return enemyUnit
end
GetRandomEnemyDefenseUnitNuke = function(self)
    local huBrain = nil
    local enemyUnit = nil
    huBrain = GetRandomCloseAliveEnemyBrain(self)
    if huBrain and not huBrain:IsDefeated() then
        local huUnitsList = huBrain:GetListOfUnits((categories.STRUCTURE * categories.EXPERIMENTAL * categories.ARTILLERY) + (categories.STRUCTURE * categories.EXPERIMENTAL * categories.SILO)
			+ (categories.STRUCTURE * categories.EXPERIMENTAL * categories.ECONOMIC), false)
		enemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		if table.getn(huUnitsList) < 1 then
			huUnitsList = huBrain:GetListOfUnits((categories.STRUCTURE * categories.EXPERIMENTAL) + (categories.STRUCTURE * categories.ARTILLERY * categories.TECH3) 
			+ (categories.STRUCTURE * categories.TECH3 * categories.SILO), false)
			enemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		end
		if table.getn(huUnitsList) < 1 then
			huUnitsList = huBrain:GetListOfUnits((categories.STRUCTURE * categories.EXPERIMENTAL) + (categories.STRUCTURE * categories.EXPERIMENTAL * categories.DEFENSE)
                + (categories.STRUCTURE * categories.TECH3) + (categories.STRUCTURE * categories.NAVAL * categories.FACTORY), false)
			enemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		end
		if table.getn(huUnitsList) < 1 then
			huUnitsList = huBrain:GetListOfUnits((categories.STRUCTURE * categories.TECH2 - categories.SONAR) + categories.COMMAND + categories.SUBCOMMANDER, false)
			enemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		end	
		if table.getn(huUnitsList) < 1 then
			huUnitsList = huBrain:GetListOfUnits((categories.STRUCTURE - categories.WALL - categories.SONAR) + categories.COMMAND + categories.SUBCOMMANDER, false)
			enemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		end
		if table.getn(huUnitsList) < 1 then
			huUnitsList = huBrain:GetListOfUnits(categories.MOBILE, false)
			enemyUnit = huUnitsList[Random(1, table.getn(huUnitsList))]
		end	
    end
    return enemyUnit
end
GetRandomEnemyStructureUnit = function(self)
    local enemyUnit = nil
    for i, brain in humanBrains.HBrains do
        if not IsAlly(aiBrain:GetArmyIndex(), brain:GetArmyIndex()) and not brain:IsDefeated() then
            local enemyDefenceUnits = brain:GetListOfUnits((categories.STRUCTURE)
                + (categories.STRUCTURE * categories.NAVAL) + (categories.SONAR) + (categories.ANTINAVY), false)
            if enemyDefenceUnits ~= nil then
                enemyUnit = (enemyDefenceUnits)[Random(1, table.getn(enemyDefenceUnits))]
                if enemyUnit then
                    break
                end
            end
        end
    end
    return enemyUnit
end
GetRandomAliveEnemyPlayer = function(self)
    local aliveBrain = nil
    for i, brain in humanBrains.HBrains do
        if brain and not brain:IsDefeated() then
            aliveBrain = brain
            break
        end
    end
    return aliveBrain
end
GetRandomMidPointBetweenAIPosAndEnemyPos = function(self)
    local VECTOR3
    midPoint = nil
	local ClosestEnemyBrain = nil
	local closestDistance = 100000000 
    for i, brain in humanBrains.HBrains do
			if brain and not brain:IsDefeated() then
                local huPosX, huPosZ = brain:GetArmyStartPos()
                local aiPosX, aiPosY, aiPosZ = AIMainBuilding:GetPositionXYZ()
                if VDist2Sq(huPosX, huPosZ, aiPosX, aiPosZ) < closestDistance then
                    closestDistance = VDist2Sq(huPosX, huPosZ, aiPosX, aiPosZ)
                    ClosestEnemyBrain = brain
                end
            end
    end
	if ClosestEnemyBrain then
        brain = ClosestEnemyBrain
    end
	if brain and not IsAlly(aiBrain:GetArmyIndex(), brain:GetArmyIndex()) and not brain:IsDefeated() then
        local aiXPos, aiZPos = aiBrain:GetArmyStartPos()
        local eXPos, eZPos = brain:GetArmyStartPos()
		local midPointX = (eXPos + aiXPos) * 0.5
        local midPointZ = (eZPos + aiZPos) * 0.5
        local terrainAltitude = GetTerrainHeight(aiXPos, aiZPos)
        midPoint = { midPointX, terrainAltitude, midPointZ, type = "VECTOR3" }
    end
    return midPoint
end
GetRandomMidPointBetween2ndSpawnPosAndEnemyPos = function(self)
    local VECTOR3
    midPoint = nil
	local ClosestEnemyBrain = nil
	local closestDistance = 100000000 
    for i, brain in humanBrains.HBrains do
			if brain and not brain:IsDefeated() then
                local huPosX, huPosZ = brain:GetArmyStartPos()
                local aiPosX, aiPosY, aiPosZ = AISecondBuilding:GetPositionXYZ()
                if VDist2Sq(huPosX, huPosZ, aiPosX, aiPosZ) < closestDistance then
                    closestDistance = VDist2Sq(huPosX, huPosZ, aiPosX, aiPosZ)
                    ClosestEnemyBrain = brain
                end
            end
    end
	if ClosestEnemyBrain then
        brain = ClosestEnemyBrain
    end
	if brain and not IsAlly(aiBrain:GetArmyIndex(), brain:GetArmyIndex()) and not brain:IsDefeated() then
        local aiXPos, aiZPos = SecBrain:GetArmyStartPos()
        local eXPos, eZPos = brain:GetArmyStartPos()
		local midPointX = (eXPos + aiXPos) * 0.5
        local midPointZ = (eZPos + aiZPos) * 0.5
        local terrainAltitude = GetTerrainHeight(aiXPos, aiZPos)
        midPoint = { midPointX, terrainAltitude, midPointZ, type = "VECTOR3" }
    end
    return midPoint
end
GetRandomOneThirdBetweenAIPosAndEnemyPos = function(self)
    local VECTOR3
    midPoint = nil
    for i, brain in humanBrains.HBrains do
        local randBrain = (humanBrains.HBrains)[Random(1, table.getn(humanBrains.HBrains))]
        if randBrain then
            brain = randBrain
        end
        if brain and not IsAlly(aiBrain:GetArmyIndex(), brain:GetArmyIndex()) and not brain:IsDefeated() then
            local aiXPos, aiZPos = aiBrain:GetArmyStartPos()
            local eXPos, eZPos = brain:GetArmyStartPos()
			local midPointX = (eXPos + aiXPos) * 0.5
			local midPointZ = (eZPos + aiZPos) * 0.5
			aiPositionX = aiXPos
			aiPositionZ = aiZPos
			playerPosX = eXPos
			playerPosZ = eZPos
            local terrainAltitude = GetTerrainHeight(aiXPos, aiZPos)
            midPoint = { midPointX, terrainAltitude, midPointZ, type = "VECTOR3" }
            break
        end
    end
    return midPoint
end
function IncreaseUnitMaxHealth(unit, amount)
    if HPBonusAI <= 0 then
        return
    end
    maxhp = unit:GetMaxHealth()
    unit:SetMaxHealth(maxhp + amount)
    hp = unit:GetMaxHealth()
    unit:SetHealth(self, hp)
    unit:SetReclaimable(false)
    unit:SetCapturable(false)
end
function CalculateWeaponDamageBuff(adjacentUnit, remove) -- Disabled
    if DmgBonus <= 0 then
        return
    end
    if ((GetGameTimeSeconds() - WavesStartTimeAI) / HoldTimeAI) > 0.80 then
        totalDamageIncrease = totalDamageIncrease + (DmgBonus)
    end
    for i = 1, adjacentUnit:GetWeaponCount() do
        local wep = adjacentUnit:GetWeapon(i)
        local wepbp = wep:GetBlueprint()
        local boost = DmgBonus + (totalEnemyT3Defences / 100)
        if ((GetGameTimeSeconds() - WavesStartTimeAI) / HoldTimeAI) > 0.85 and AIMainBuilding and not AIMainBuilding:BeenDestroyed() then
            boost = boost + (AIMainBuilding:GetHealth() / AIMainBuilding:GetMaxHealth())
        end
        if ((GetGameTimeSeconds() - WavesStartTimeAI) / HoldTimeAI) > 0.80 then
            boost = (totalDamageIncrease / 30)
        end
        if wepbp.BeamCollisionDelay then
            if not wep.DamageModifiers then
                wep.DamageModifiers = {}
            end
            if not wep.DamageModifiers.BoostNode then
                wep.DamageModifiers.BoostNode = 1
            end
            if remove then
                wep.DamageModifiers.BoostNode = wep.DamageModifiers.BoostNode - boost
            else
                wep.DamageModifiers.BoostNode = wep.DamageModifiers.BoostNode + boost
            end
        else
            if not wep.DamageMod then
                wep.DamageMod = 0
            end
            if wepbp.Damage then
                if remove then
                    wep.DamageMod = wep.DamageMod - boost
                else
                    wep.DamageMod = wep.DamageMod + boost
                end
            end
        end
    end
end
function ModifyWeaponDamageBuffAndRange(adjacentUnit, remove) -- Eanabled, for Land/Air/Navy
    --[[if ((GetGameTimeSeconds() - WavesStartTimeAI) / HoldTimeAI) > 0.70 then
        totalDamageIncrease = totalDamageIncrease + (DmgBonus)
    end]]--
    for i = 1, adjacentUnit:GetWeaponCount() do
        local wep = adjacentUnit:GetWeapon(i)
        local wepbp = wep:GetBlueprint()
        --DmgBonus
		local boost = massDamageBoost
        --[[if ((GetGameTimeSeconds() - WavesStartTimeAI) / HoldTimeAI) > 0.85 and AIMainBuilding and not AIMainBuilding:BeenDestroyed() then
            boost = boost + (AIMainBuilding:GetHealth() / AIMainBuilding:GetMaxHealth())
        end]]--
        --[[if ((GetGameTimeSeconds() - WavesStartTimeAI) / HoldTimeAI) > 0.80 then
            boost = (totalDamageIncrease / 30)
        end]]--
        --[[if wepbp.MaxRadius then
            wepbp.MaxRadius = 45
        end]]--
		if not wepbp.BeamCollisionDelay then
			if wepbp.Damage then
                if remove then
                    wep.DamageMod = wep.DamageMod - boost
                else
                    wep.DamageMod = wep.DamageMod + boost
                end
            end
		end	
        --[[if wepbp.BeamCollisionDelay then
            if not wep.DamageModifiers then
                wep.DamageModifiers = {}
            end
            if not wep.DamageModifiers.BoostNode then
                wep.DamageModifiers.BoostNode = 1
            end
            if remove then
                wep.DamageModifiers.BoostNode = wep.DamageModifiers.BoostNode - boost
            else
                wep.DamageModifiers.BoostNode = wep.DamageModifiers.BoostNode + boost
            end
        else
            if not wep.DamageMod then
                wep.DamageMod = 0
            end
            if wepbp.Damage then
                if remove then
                    wep.DamageMod = wep.DamageMod - boost
                else
                    wep.DamageMod = wep.DamageMod + boost
                end
            end
        end]]--
    end
end
function ModifyWeaponDamageBuffBoss(adjacentUnit, remove) -- Enabled for Boss Units
    --[[if ((GetGameTimeSeconds() - WavesStartTimeAI) / HoldTimeAI) > 0.70 then
        totalDamageIncrease = totalDamageIncrease + (DmgBonus)
    end]]--
    for i = 1, adjacentUnit:GetWeaponCount() do
        local wep = adjacentUnit:GetWeapon(i)
        local wepbp = wep:GetBlueprint()
        --DmgBonus
		local boost = massDamageBoostBoss
        --[[if ((GetGameTimeSeconds() - WavesStartTimeAI) / HoldTimeAI) > 0.85 and AIMainBuilding and not AIMainBuilding:BeenDestroyed() then
            boost = boost + (AIMainBuilding:GetHealth() / AIMainBuilding:GetMaxHealth())
        end]]--
        --[[if ((GetGameTimeSeconds() - WavesStartTimeAI) / HoldTimeAI) > 0.80 then
            boost = (totalDamageIncrease / 30)
        end]]--
        --[[if wepbp.MaxRadius then
            wepbp.MaxRadius = 45
        end]]--
		if not wepbp.BeamCollisionDelay then
			if wepbp.Damage then
                if remove then
                    wep.DamageMod = wep.DamageMod - boost
                else
                    wep.DamageMod = wep.DamageMod + boost
                end
            end
		end	
        --[[if wepbp.BeamCollisionDelay then
            if not wep.DamageModifiers then
                wep.DamageModifiers = {}
            end
            if not wep.DamageModifiers.BoostNode then
                wep.DamageModifiers.BoostNode = 1
            end
            if remove then
                wep.DamageModifiers.BoostNode = wep.DamageModifiers.BoostNode - boost
            else
                wep.DamageModifiers.BoostNode = wep.DamageModifiers.BoostNode + boost
            end
        else
            if not wep.DamageMod then
                wep.DamageMod = 0
            end
            if wepbp.Damage then
                if remove then
                    wep.DamageMod = wep.DamageMod - boost
                else
                    wep.DamageMod = wep.DamageMod + boost
                end
            end
        end]]--
    end
end
function ModifyWeaponDamageBuffDoom(adjacentUnit, remove) -- Enabled for Boss Units
    --[[if ((GetGameTimeSeconds() - WavesStartTimeAI) / HoldTimeAI) > 0.70 then
        totalDamageIncrease = totalDamageIncrease + (DmgBonus)
    end]]--
    for i = 1, adjacentUnit:GetWeaponCount() do
        local wep = adjacentUnit:GetWeapon(i)
        local wepbp = wep:GetBlueprint()
        --DmgBonus
		local boost = massDamageBoostBoss + (totalExpUnits * 5)
		local beamboost = (massDamageBoostBoss * .01) + totalExpUnits
        --[[if ((GetGameTimeSeconds() - WavesStartTimeAI) / HoldTimeAI) > 0.85 and AIMainBuilding and not AIMainBuilding:BeenDestroyed() then
            boost = boost + (AIMainBuilding:GetHealth() / AIMainBuilding:GetMaxHealth())
        end]]--
        --[[if ((GetGameTimeSeconds() - WavesStartTimeAI) / HoldTimeAI) > 0.80 then
            boost = (totalDamageIncrease / 30)
        end]]--
        --[[if wepbp.MaxRadius then
            wepbp.MaxRadius = 45
        end]]--
		if not wepbp.BeamCollisionDelay then
			if wepbp.Damage then
                if remove then
                    wep.DamageMod = wep.DamageMod - boost
                else
                    wep.DamageMod = wep.DamageMod + boost
                end
            end
		end	
        if wepbp.BeamCollisionDelay then
            if wepbp.Damage then
                if remove then
                    wep.DamageMod = wep.DamageMod - beamboost
                else
                    wep.DamageMod = wep.DamageMod + beamboost
                end
            end
        end
    end
end
function ModifyUnitWeaponsFireRate(adjacentUnit, increasedAmount)
    if increasedAmount == 0 then
        return
    end
    for i = 1, adjacentUnit:GetWeaponCount() do
        local wep = adjacentUnit:GetWeapon(i)
        local wepbp = wep:GetBlueprint()
        if wep and wepbp and wepbp.RateOfFire then
            local buff = wepbp.RateOfFire + increasedAmount
            wep:ChangeRateOfFire(buff)
            wep.AdjRoFMod = increasedAmount
        end
    end
end
function ClearAIWeakUnits()
	local aiUnit
    local unitList = aiBrain:GetListOfUnits(categories.MOBILE - categories.NAVAL, false)
    for i, aiUnit in unitList do
        WaitTicks(1)
        if aiUnit and not aiUnit:BeenDestroyed() then
            aiUnit:Kill()
        end
    end
end
function ClearAITrashUnits()
	local aiUnit
    local circle = ForkThread(function(self)
        local unitList = aiBrain:GetListOfUnits((categories.MOBILE * categories.TECH1 - categories.ENGINEER - categories.COMMAND) + (categories.MOBILE * categories.TECH2 - categories.ENGINEER - categories.COMMAND), false)
        for i, aiUnit in unitList do
            WaitTicks(1)
            if aiUnit and not aiUnit:BeenDestroyed() then
                aiUnit:Kill()
            end
        end
        KillThread(self)
    end)
end
function ClearAIAllUnits()
	local circle = ForkThread(function(self)
		local aiUnit
		local unitList = aiBrain:GetListOfUnits(categories.ALLUNITS, false)
		for i, aiUnit in unitList do
			if aiUnit and not aiUnit:BeenDestroyed() then
				aiUnit:Kill()
			end
		end
		for i, brain in allyBrainsHQ.ABrainsHQ do
			if brain and not brain:IsDefeated() then
				local unitList2 = brain:GetListOfUnits(categories.ALLUNITS, false)
				for i, aiUnit in unitList2 do
					if aiUnit and not aiUnit:BeenDestroyed() then
						aiUnit:Kill()
					end
				end
			end	
		end
	end)	
end
function ClearAllNonHQTeamUnits()
	local aiUnit
	for i, brain in humanBrains.HBrains do
		if brain and not brain:IsDefeated() then
			local unitList2 = brain:GetListOfUnits(categories.ALLUNITS, false)
			for i, aiUnit in unitList2 do
				if aiUnit and not aiUnit:BeenDestroyed() then
					aiUnit:Kill()
				end
			end
		end	
	end
end
function ClearAllHQTeamUnits()
	local aiUnit
	for i, brain in allyBrainsHQ.ABrainsHQ do
		if brain and not brain:IsDefeated() then
			local unitList2 = brain:GetListOfUnits(categories.ALLUNITS, false)
			for i, aiUnit in unitList2 do
				if aiUnit and not aiUnit:BeenDestroyed() then
					aiUnit:Kill()
				end
			end
		end	
	end
end
function CreateObjectiveMarker(target)
    local simObjectives = import('/lua/SimObjectives.lua')
    local w = 20
    local h = 20
    local huPosX, huPosY, huPosZ = target:GetPositionXYZ()
    simObjectives.CreateObjectiveDecal(huPosX, huPosZ, w, h)
    if humanBrains and humanBrains.HBrains and humanBrains.HBrains[1] then
        CreatePingToTarget(target, humanBrains.HBrains[1]:GetArmyIndex())
    end
end
function CreateSecondaryObjectiveMarker(target)
    local simObjectives = import('/lua/SimObjectives.lua')
    local w = 10
    local h = 10
    local huPosX, huPosY, huPosZ = target:GetPositionXYZ()
    simObjectives.CreateObjectiveDecal(huPosX, huPosZ, w, h)
    if humanBrains and humanBrains.HBrains and humanBrains.HBrains[1] then
        CreatePingToTarget(target, humanBrains.HBrains[1]:GetArmyIndex())
    end
end
function CreatePingToTarget(target, army)
    if target and not target:BeenDestroyed() then
        local SimPing = import('/lua/simping.lua')
        local PingTypes = {
            alert = {
                Lifetime = 6,
                Mesh = 'alert_marker',
                Ring = '/game/marker/ring_yellow02-blur.dds',
                ArrowColor = 'yellow',
                Sound = 'UEF_Select_Radar'
            },
            move = {
                Lifetime = 6,
                Mesh = 'move',
                Ring = '/game/marker/ring_blue02-blur.dds',
                ArrowColor = 'blue',
                Sound = 'Cybran_Select_Radar'
            },
            attack = {
                Lifetime = 6,
                Mesh = 'attack_marker',
                Ring = '/game/marker/ring_red02-blur.dds',
                ArrowColor = 'red',
                Sound = 'Aeon_Select_Radar'
            },
            marker = {
                Lifetime = 5,
                Ring = '/game/marker/ring_yellow02-blur.dds',
                ArrowColor = 'yellow',
                Sound = 'UI_Main_IG_Click',
                Marker = true
            },
        }
        local data = {}
        data.Type = 'attack'
        data.Owner = army - 1
        data.Location = target:GetPosition()
        SimPing.SpawnPing(table.merged(data, PingTypes[data.Type]))
    end
end
function ControlDifficultyByAiPersonality() -- Disabled
    aiPersonality = ScenarioInfo.ArmySetup[aiBrain.Name].AIPersonality
    LOG("sa: AI Personality is : " .. aiPersonality)
    if aiPersonality == "easy" then
        difficultyFactor = 1
        HPBonusAI = HPBonusAI * difficultyFactor
        DmgBonus = DmgBonus * difficultyFactor
        MainBuildingHPAI = MainBuildingHPAI * difficultyFactor
        if NukesPerStrikeAI > 0 then
            NukesPerStrikeAI = NukesPerStrikeAI * difficultyFactor
        end
        LOG("Settings set for easy ai.")
    end
    if aiPersonality == "normal" then
        difficultyFactor = 1
        HPBonusAI = HPBonusAI * difficultyFactor
        DmgBonus = DmgBonus * difficultyFactor
        MainBuildingHPAI = MainBuildingHPAI * difficultyFactor
        if NukesPerStrikeAI > 0 then
            NukesPerStrikeAI = NukesPerStrikeAI * difficultyFactor
        end
        LOG("Settings set for normal ai.")
    end
    if aiPersonality == "adaptive" then
        difficultyFactor = 1
        HPBonusAI = HPBonusAI * difficultyFactor
        DmgBonus = DmgBonus * difficultyFactor
        MainBuildingHPAI = MainBuildingHPAI * difficultyFactor
        if NukesPerStrikeAI > 0 then
            NukesPerStrikeAI = NukesPerStrikeAI * difficultyFactor
        end
        LOG("Settings set for adaptive ai.")
    end
    if aiPersonality == "rush" then
        difficultyFactor = 1
        HPBonusAI = HPBonusAI * difficultyFactor
        DmgBonus = DmgBonus * difficultyFactor
        MainBuildingHPAI = MainBuildingHPAI * difficultyFactor
        if NukesPerStrikeAI > 0 then
            NukesPerStrikeAI = NukesPerStrikeAI * difficultyFactor
        end
        LOG("Settings set for rush ai.")
    end
    if aiPersonality == "turtle" then
        difficultyFactor = 1
        HPBonusAI = HPBonusAI * difficultyFactor
        DmgBonus = DmgBonus * difficultyFactor
        MainBuildingHPAI = MainBuildingHPAI * difficultyFactor
        if NukesPerStrikeAI > 0 then
            NukesPerStrikeAI = NukesPerStrikeAI * difficultyFactor
        end
        LOG("Settings set for turtle ai.")
    end
    if aiPersonality == "tech" then
        difficultyFactor = 1
        HPBonusAI = HPBonusAI * difficultyFactor
        DmgBonus = DmgBonus * difficultyFactor
        MainBuildingHPAI = MainBuildingHPAI * difficultyFactor
        if NukesPerStrikeAI > 0 then
            NukesPerStrikeAI = NukesPerStrikeAI * difficultyFactor
        end
        LOG("Settings set for tech ai.")
    end
    if aiPersonality == "random" then
        HPBonusAI = HPBonusAI
        DmgBonus = DmgBonus
        if Random(1, 2) == 1 then
            MainBuildingHPAI = MainBuildingHPAI
        --elseif MainBuildingHPAI > 40000000 then
            --MainBuildingHPAI = MainBuildingHPAI - (Random(10, 15) * 1000000)
        end
        --LandPerWave = Random(30, 80)
        if NukesPerStrikeAI > 0 then
            NukesPerStrikeAI = NukesPerStrikeAI
        end
        LOG("Random Settings set for random ai.")
    end
    LOG("sa: HP Bonus is : " .. HPBonusAI)
    LOG("sa: Dmg Bonus is : " .. DmgBonus)
    LOG("sa: Delay Until Next Wave is : " .. DelayUntilNextWaveAI)
    LOG("sa: Waves Start Time is : " .. WavesStartTimeAI)
    LOG("sa: Main Building HP is : " .. MainBuildingHPAI)
    LOG("sa: Holding Time is : " .. HoldTimeAI)
    LOG("sa: Units Per Wave is : " .. LandPerWave)
    LOG("sa: Hives Per Player is : " .. HivesPerPlayerAI)
    LOG("sa: Nuke Strike Every is : " .. NukeStrikeEveryAI)
    LOG("sa: Nukes Per Strike is : " .. NukesPerStrikeAI)
end
function BroadcastMSG(message, fontsize, RGBColor, duration, location)
    PrintText(message, fontsize, 'ff' .. RGBColor, duration, location);
end
function AIMainBuildingMinotoring()
    WaitTicks(21)
    if AIMainBuilding ~= nil and not AIMainBuilding:BeenDestroyed() then
        local buildingHP = AIMainBuilding:GetHealth()
        local buildingMaxHP = AIMainBuilding:GetMaxHealth()
        local size = 12;
        local fade = 4;
        local alignment = 'centerbottom';
        local color = 'EB984E';
        local message = "HQ HP: " .. buildingHP .. "/" .. buildingMaxHP
        BroadcastMSG(message, size, color, fade, alignment)
    end
end
function AIMainBuildingRespondMinotoring() -- Disabled
    local circle = ForkThread(function(self)
        repeat
            WaitSeconds(Random(Nukex1, Nukex2))
            local spawnCount = Random(1, 2) + math.floor(totalEnemyYolonas * 0.125 + 0.5) + math.floor(totalEnemyExpShields * 0.5 + 0.5)
            if totalEnemyExpShields > table.getn(humanBrains.HBrains) and Random(1, 10) == 1 then
                CreateAUnitAroundMainBuildingForAI(ArtyType)
            end
            if AIMainBuilding ~= nil and not AIMainBuilding:BeenDestroyed() then
                local buildingHP = AIMainBuilding:GetHealth()
                local buildingMaxHP = AIMainBuilding:GetMaxHealth()
                if currentMainBuildingHP > 0 and (currentMainBuildingHP - buildingHP) > 1000000 then
                    LOG("Trying to respond to high damage been taken.")
                    CreateAUnitAroundMainBuildingForAI(ArtyType)
					if NukesOn == "On" then
						LaunchNukeAtEnemyFromNukeSubs()
					end
                    local randomSpawnCount = Random(2, 3) + (totalEnemyYolonas * 0.25)
                    repeat
                        CreateACombinedLandBossUnitAroundMainBuildingForAI()
                        randomSpawnCount = randomSpawnCount - 1
                    until randomSpawnCount < 1
                    repeat
                        WaitTicks(2)
                        CreateAUnitAroundMainBuildingForAI(ArtyType)
                        spawnCount = spawnCount - 1
                    until spawnCount < 1
                    SpawnAeonArtyDueToHighDamageWarning((currentMainBuildingHP - buildingHP))
                end
                if currentMainBuildingHP == 0 or currentMainBuildingHP > buildingHP then
                    currentMainBuildingHP = buildingHP
                end
            end
        until GetGameTimeSeconds() > 20000
        KillThread(self)
    end)
end
function ShootNukeStrikeDueToHighDamage() -- Disabled
    local numOfNukeHits = Random(1, 4) + NukesPerStrikeAI + (((GetGameTimeSeconds() - WavesStartTimeAI) * NuclearOverwhelm) / 120) * humans + math.floor(CalculateTotalEnemySMDs() * 0.1 + 0.5)
    ShootNukeStrikeDueToHighDamageWarning(numOfNukeHits)
    if numOfNukeHits > 0 and NukesOn == "On" then
        repeat
            WaitTicks(2)
            CreateAndLaunchNukeAtEnemy()
            numOfNukeHits = numOfNukeHits - 1
        until numOfNukeHits < 1
    end
end
function ShootNukeStrikeDueToHighDamageWarning(numOfNukeHits)
    local size = 23;
    local fade = 7;
    numOfNukeHits = math.floor(numOfNukeHits)
    local alignment = 'center';
    local color = 'FF0000';
    local message = ("Enemy HQ is Taking Massive Amount of Damage in 15 seconds, They Respond with Nuke Strike of  " .. numOfNukeHits .. " Warhead!")
    BroadcastMSG(message, size, color, fade, alignment)
    WaitTicks(Random(25))
end
function SpawnAeonArtyDueToHighDamageWarning(damageAmount)
    local size = 22;
    local fade = 7;
    damageAmount = math.floor(damageAmount)
    local alignment = 'center';
    local color = 'FF0000';
    local message = ("Enemy HQ is Taking Massive Amount of Damage (" .. damageAmount .. ") in < 15 seconds, They are getting Angry!")
    BroadcastMSG(message, size, color, fade, alignment)
    WaitTicks(Random(25))
end
AttachedLandUnitSpawn = function(self, selfId, attachedUnitId, selfBoneId)
    local platOrient = self:GetOrientation()
    local location = self:GetPosition()
    local StellarCore = CreateUnit(attachedUnitId, self:GetArmy(), location[1], location[2], location[3], platOrient[1], platOrient[2], platOrient[3], platOrient[4], 'Land')
    WaitTicks(2)
    IncreaseHPForAUnit(StellarCore)
	if DamageBoost ~= 'Off - 0' then
		ModifyWeaponDamageBuffAndRange(StellarCore)
	end	
    StellarCore:AttachTo(self, selfBoneId)
    StellarCore:SetCreator(self)
    self.Trash:Add(StellarCore)
end
AttachedAirUnitSpawn = function(self, selfId, attachedUnitId, selfBoneId)
    local platOrient = self:GetOrientation()
    local location = self:GetPosition()
    local StellarCore = CreateUnit(attachedUnitId, self:GetArmy(), location[1], location[2], location[3], platOrient[1], platOrient[2], platOrient[3], platOrient[4], 'Air')
    WaitTicks(2)
    IncreaseHPForAUnit(StellarCore)
	if DamageBoost ~= 'Off - 0' then
		ModifyWeaponDamageBuffAndRange(StellarCore)
	end	
    StellarCore:AttachTo(self, selfBoneId)
    StellarCore:SetCreator(self)
    self.Trash:Add(StellarCore)
end
function UnitSetParent(unit, ParentId)
    local circle = ForkThread(function(self)
        unit:SetParent(self, ParentId)
        KillThread(self)
    end)
end
function IncreaseHPForAUnit(unit)
    local circle = ForkThread(function(self)
        if HPBonusAI <= 0 then
            return
        end
        local maxhp = unit:GetMaxHealth()
        if isAIBrain then
            unit:SetMaxHealth(maxhp + 20000 + (Random(100000, 200000) * totalEnemyParagons))
        else
            unit:SetMaxHealth(maxhp + 20000 + (Random(10000, 20000) * totalEnemyParagons))
        end
        local hp = unit:GetMaxHealth()
        unit:SetHealth(self, hp)
        KillThread(self)
    end)
end
function LastWarning()
    local timeInMin = WavesStartTimeAI / 60
    timeInMin = math.floor(timeInMin)
    local size = 28;
    local fade = 7;
    local alignment = 'center';
    local color = 'FF0000';
    local holdTimeInMins = HoldTimeAI / 60
    local message = ("Enemies Are Coming Now!")
    BroadcastMSG(message, size, color, fade, alignment)
    WaitTicks(Random(25))
end
function LastDifficulty()
    local size = 35;
    local fade = 7;
    local alignment = 'center';
    local color = 'FF0000';
    local message = ("Final Stage: Overwhelming Final Boss Units! - Extermination")
    BroadcastMSG(message, size, color, fade, alignment)
    WaitTicks(Random(25))
end
function HQSpawnedWarning()
    if AIMainBuilding and not AIMainBuilding:BeenDestroyed() then
        local size = 25;
        local fade = 10;
        local alignment = 'center';
        local color = '00FF00';
        WaitTicks(5)
        local buildingHPInMillion = MainBuildingHPAI
        WaitTicks(5)
        local message = ("Mandatory Mission: Enemy HQ Spawned With " .. buildingHPInMillion .. " HP, Destroy it!")
        BroadcastMSG(message, size, color, fade, alignment)
        WaitTicks(Random(25))
    end
end
function SecondarySpawnWarning()
    if AIMainBuilding and not AIMainBuilding:BeenDestroyed() then
        local size = 25;
        local fade = 10;
        local alignment = 'center';
        local color = '00FF00';
        WaitTicks(5)
        local buildingHPInMillion = MainBuildingHPAI / 1000000
        WaitTicks(5)
        local message = ("A Secondary Spawn Point has beed detected!")
        BroadcastMSG(message, size, color, fade, alignment)
        WaitTicks(Random(25))
    end
end
function EarlyParagonsWillSpeedDifficultyInitialWarning()
    --if AIMainBuilding and not AIMainBuilding:BeenDestroyed() then
		local timeInMin = (HoldTimeAI / 60 * 0.7)
		timeInMin = math.floor(timeInMin)
        local size = 25;
        local fade = 10;
        local alignment = 'center';
        local color = 'ffCBFFFF';
		if EndGameYolo == "Yolona Midgame" and EndGameParagon == "Paragon Midgame" then
			local message = ("Paragons and Yolonas available in " .. timeInMin .. " minutes.")
		elseif EndGameYolo == "Yolona Midgame" then
			local message = ("Yolonas available in " .. timeInMin .. " minutes.")
		elseif EndGameParagon == "Paragon Midgame" then
			local message = ("Paragons available in " .. timeInMin .. " minutes.")
		end
        --local message = ("Paragons and Yolonas available in " .. timeInMin .. " minutes.")
        BroadcastMSG(message, size, color, fade, alignment)
        WaitTicks(Random(25))
    --end
end
function NukeWaveWarning()
    --if AIMainBuilding and not AIMainBuilding:BeenDestroyed() then
		local timeInMin = (HoldTimeAI / 60 * NukeTime)
		timeInMin = math.floor(timeInMin)
        local size = 25;
        local fade = 10;
        local alignment = 'center';
        local color = '00FF00';
        local message = ("Nuke Strikes in " .. timeInMin .. " minutes. Paragon will trigger early attack.")
        BroadcastMSG(message, size, color, fade, alignment)
        WaitTicks(Random(25))
    --end
end
function AlliedForcesSpawnWarning()
    local size = 20;
    local fade = 5;
    local alignment = 'center';
    local color = '00FF00';
    local message = ("Allied Force Spawned!")
    BroadcastMSG(message, size, color, fade, alignment)
    WaitTicks(Random(25))
end
function SecondaryBuildingsWarning()
    local size = 20;
    local fade = 10;
    local alignment = 'center';
    local color = 'FFFF00';
    local message = ("Secondary Mission: Destroy Support Bases To Damage HQ and Get Support!")
	local message2 = ("Warning: Support Bases can launch EMP Nukes that deploy Rift Orbs.")
	local message3 = ("Eliminate Support Bases to Reduce # of Rifts that can be Deployed.")
    WaitSeconds(30)
	BroadcastMSG(message, size, color, fade, alignment)
	if RiftUnits ~= "Off --" then
		BroadcastMSG(message2, size, color, fade, alignment)
		BroadcastMSG(message3, size, color, fade, alignment)
	end	
end
function HQPowerStallMessage()
    local size = 25;
    local fade = 5;
    local alignment = 'center';
    local color = 'FFFF00';
    local message = ("HQ Power Stalling! Shields Down!")
    BroadcastMSG(message, size, color, fade, alignment)
    WaitTicks(Random(25))
    WaitTicks(80)
    --EarlyParagonsWillSpeedDifficultyInitialWarning()
end
function Warning()
    local timeInMin = WavesStartTimeAI / 60
    timeInMin = math.floor(timeInMin)
    local size = 30;
    local fade = 7;
    local alignment = 'center';
    local color = '2ECC71';
    local message = ("Waves start after " .. timeInMin .. " minutes.")
    BroadcastMSG(message, size, color, fade, alignment)
    WaitTicks(Random(25))
end
function WarningAboutEarlyParagons()
    local circle = ForkThread(function(self)
        local warningCount = 3
        repeat
            EarlyParagonWarning()
            warningCount = warningCount - 1
            WaitTicks(20)
        until warningCount < 1
        KillThread(self)
    end)
end
function EarlyParagonWarning()
    local size = 18;
    local fade = 1;
    local alignment = 'centerbottom';
    local color = 'FF0000';
    local message = ("Paragons and Yolonas available in " .. timeInMin .. " minutes.")
    BroadcastMSG(message, size, color, fade, alignment)
    WaitTicks(Random(25))
end
function GameOver()
    local timeInMin = ArtySpawnTime / 60
    timeInMin = math.floor(timeInMin)
    local size = 30;
    local fade = 7;
    local alignment = 'center';
    local color = 'FF0000';
    local message = ("ALERT! Enemy Artillery in " .. timeInMin .. " minutes.")
    BroadcastMSG(message, size, color, fade, alignment)
    WaitTicks(Random(25))
end
function EndlessBossOn()
    local timeInMin = ArtySpawnTime / 60
    timeInMin = math.floor(timeInMin)
    local size = 30;
    local fade = 7;
    local alignment = 'center';
    local color = 'FF0000';
    local message = ("==Boss Waves On==")
    BroadcastMSG(message, size, color, fade, alignment)
    WaitTicks(Random(25))
end
function IntervalWarning(message)
    local timeInMin = WavesStartTimeAI / 60
    timeInMin = math.floor(timeInMin)
    local size = 20;
    local fade = 5;
    local alignment = 'center';
    local color = 'FF0000';
    if Random(1, 8) == 2 then
        color = 'CA6F1E';
    end
    if Random(1, 7) == 2 then
        color = 'ECF0F1';
    end
    if Random(1, 6) == 2 then
        color = 'A569BD';
    end
    if Random(1, 5) == 2 then
        color = 'F1C40F';
    end
    if Random(1, 4) == 2 then
        color = 'FBFCFC';
    end
    if Random(1, 6) == 2 then
        color = '922B21';
    end
    if Random(1, 7) == 2 then
        color = '7DCEA0';
    end
    if Random(1, 8) == 2 then
        color = '154360';
    end
    BroadcastMSG(message, size, color, fade, alignment)
    WaitTicks(Random(25))
end
function AIMessageTo(message, brain)
    local tmpMessage = message
    if brain then
        tmpMessage = message .. brain.Nickname
    end
    table.insert(Sync.AIChat, { group = 'all', text = tmpMessage, sender = aiBrain.Nickname })
end
function ScanMapToSpawnAI(numOfBuildings) --Scans Map to Spawn Support Bases
	local circle = ForkThread(function(self)
		local sizeX, sizeZ = GetMapSize()
		local PosX
		local PosZ
		local counter = numOfBuildings
		local SpawnBuilding
		local cycles = 0
		local Distance = 28000
			repeat
				if SecondaryBuildingFlag == "On - Random Map Spawn" then
					PosX = Random(20, (sizeX - 20))
					PosZ = Random(20, (sizeZ - 20))
				elseif SecondaryBuildingFlag == "On - North Half" then
					PosX = Random(20, (sizeX - 20))
					PosZ = Random(20, (sizeZ * 0.55))
				elseif SecondaryBuildingFlag == "On - South Half" then
					PosX = Random(20, (sizeX - 20))
					PosZ = Random((sizeZ * 0.45), (sizeZ - 20))
				elseif SecondaryBuildingFlag == "On - East Half" then
					PosX = Random((sizeX * 0.45), (sizeX - 20))
					PosZ = Random(20, (sizeZ - 20))
				elseif SecondaryBuildingFlag == "On - West Half" then
					PosX = Random(20, (sizeX * 0.55))
					PosZ = Random(20, (sizeZ - 20))
				elseif SecondaryBuildingFlag == "On - NE to SW Diagonal" then
					if Random(1, 2) == 1 then	
						PosX = Random((sizeX * 0.45), (sizeX - 20))
						PosZ = Random(20, (sizeZ * 0.55))
					else
						PosX = Random(20, (sizeX * 0.55))
						PosZ = Random((sizeZ * 0.45), (sizeZ - 20))
					end	
				elseif SecondaryBuildingFlag == "On - NW to SE Diagonal" then
					if Random(1, 2) == 2 then	
						PosX = Random(20, (sizeX * 0.55))
						PosZ = Random(20, (sizeZ * 0.55))
					else
						PosX = Random((sizeX * 0.45), (sizeX - 20))
						PosZ = Random((sizeZ * 0.45), (sizeZ - 20))
					end
				elseif SecondaryBuildingFlag == "On - Center E to W" then
					PosX = Random(20, (sizeX - 20))
					PosZ = Random((sizeZ * 0.33), (sizeZ * 0.67))
				elseif SecondaryBuildingFlag == "On - Center N to S" then
					PosX = Random((sizeX * 0.33), (sizeX * 0.67))
					PosZ = Random(20, (sizeZ - 20))
				end
				SpawnBuilding = CheckForCloseEnemyStart(PosX, PosZ, Distance)
				cycles = cycles + 1
				if SpawnBuilding == "SpawnIt" then
					CreateSecondaryObjectives(PosX, PosZ, numOfBuildings)
					counter = counter - 1
				end
				if cycles == 20 then --Adjust Spawn distances if can't find spawn locations.
					Distance = Distance - 2000
				elseif cycles == 40 then
					Distance = Distance - 2000
				elseif cycles == 70 then
					Distance = Distance - 2000
				elseif cycles == 90 then
					Distance = Distance - 2000
				elseif cycles == 120 then
					Distance = Distance - 2000
				elseif cycles == 150 then
					Distance = Distance - 2000
				elseif cycles >= 180 then
					MessageFlag = "Off"
					PrintText("== Inadequate Locations for Support Bases. Spawning near HQ. ==", 28, 'ffCBFFFF', 10, 'center')
					CreateSecondaryAIBuildings(counter) --Fallback if unable to find locations for Support Bases
					break
				end	
				WaitTicks(2)
			until counter < 1
			WaitTicks(50)
			SecondaryBuildingsWarning()
	KillThread(self)
    end)
end
function CheckForCloseEnemyStart(PosX, PosZ, Distance) --Checks if Support Base spawn too close to Players Spawns
    local closestDistance = Distance 
	local GoodSpawn = true
	local BuildPosX = PosX
	local BuildPosZ = PosZ
	local SpawnCheck
    for aindex, abrain in humanBrains.HBrains do
		if GoodSpawn == true then
            local huPosX, huPosZ = abrain:GetArmyStartPos()
            if VDist2Sq(huPosX, huPosZ, BuildPosX, BuildPosZ) < closestDistance then
                GoodSpawn = false
            end
        end
    end
	for aindex, abrain in allyBrainsHQ.ABrainsHQ do
		if GoodSpawn == true then
            local huPosX, huPosZ = abrain:GetArmyStartPos()
            if VDist2Sq(huPosX, huPosZ, BuildPosX, BuildPosZ) < 5500 then
                GoodSpawn = false
            end
        end
    end
	if GoodSpawn == true then
            local huPosX, huPosZ = aiBrain:GetArmyStartPos()
            if VDist2Sq(huPosX, huPosZ, BuildPosX, BuildPosZ) < 6000 then
                GoodSpawn = false
            end
        end
	if GoodSpawn == true then
		SpawnCheck = "SpawnIt"
	else
		SpawnCheck = "DontSpawnIt"
	end	
    return SpawnCheck
end
function CreateSecondaryObjectives(aPosX, aPosZ, numOfBuildings) --Spawns a Support Base
    local circle = ForkThread(function(self)
        LOG("Creating AI secondary buildings.")
        local rspawn = "B_OBJ1301"
		local nukedef
		local posX = aPosX
		local posZ = aPosZ
		local unit = nil
            LOG("sa: T4 rspawn(XSB1301) = " .. rspawn)
            unit = aiBrain:CreateUnitNearSpot(rspawn, posX, posZ)
            if unit == nil then
                LOG("sa: T4 rspawn CreateUnitNearSpot failed, Trying CreateUnitHPR")
                if Random(1, 2) == 2 then
                    posX = posX + Random(1, 2)
                else
                    posX = posX - Random(1, 2)
                end
                if Random(1, 2) == 2 then
                    posZ = posZ + Random(1, 2)
                else
                    posZ = posZ - Random(1, 2)
                end
                local terrainAltitude = GetTerrainHeight(posX, posZ)
                unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
                LOG("sa: T4 CreateUnitHPR(XSB1301) = " .. rspawn)
            end
			if Random(1, 2) == 2 then
				posX = aPosX
				posZ = aPosZ
				if Random(1, 2) == 2 then
                    posX = posX + Random(1, 2)
                else
                    posX = posX - Random(1, 2)
                end
                if Random(1, 2) == 2 then
                    posZ = posZ + Random(1, 2)
                else
                    posZ = posZ - Random(1, 2)
                end
				local terrainAltitude = GetTerrainHeight(posX, posZ)
				nukedef = CreateUnitHPR("BSD4302", aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
			end
            if unit ~= nil then
                --unit:SetMaxHealth(120000 + MainBuildingHPAI / (numOfBuildings + 10) + (humans * 10000))
				if Random(1, 3) <= 2 then	
					if Random(1, 2) == 1 then
						unit:SetMaxHealth(130000)
					else	
						unit:SetMaxHealth(160000)
					end	
				else
					unit:SetMaxHealth(110000)
				end
                unit:SetCustomName("Control Center # " .. Random(1, 1000))
                local hp = unit:GetMaxHealth()
                unit:SetReclaimable(false)
                unit:SetCapturable(false)
                unit:SetHealth(self, hp)
				unit:SetProductionPerSecondEnergy(500)
				unit:SetProductionPerSecondMass(10)
                WaitTicks(30)
                CreateSecondaryObjectiveMarker(unit)
                table.insert(aiSecondaryBuildings.secondaryBuildings, unit)
            end
        KillThread(self)
    end)
end
function CreateSecondaryAIBuildings(numOfBuildings) --Spawns a Support Base (Fallback)
    local circle = ForkThread(function(self)
        LOG("Creating AI secondary buildings.")
        local rspawn = "B_OBJ1301"
        local counter = numOfBuildings
		local sizeX, sizeZ = GetMapSize()
		local nukedef
        repeat
            local VECTOR3
            midPos = GetRandomOneThirdBetweenAIPosAndEnemyPos()
            local posX = midPos[1]
            local posZ = midPos[3]
            if aiPositionX > playerPosX then
				posX = posX * 1.2
					if posX >= sizeX then
						posX = posX - 30
					end	
			elseif 	aiPositionX < playerPosX then
				posX = posX * 0.8
			end	
			if aiPositionZ > playerPosZ then
				posZ = posZ * 1.2
					if posZ >= sizeZ then
						posZ = posZ - 30
					end	
			elseif aiPositionZ < playerPosZ then
				posZ = posZ * 0.8
			end
            WaitTicks(2)
            local unit = nil
            if Random(1, 2) == 2 then
                posX = posX + Random(1, 5)
            else
                posX = posX - Random(1, 5)
            end
            if Random(1, 2) == 2 then
                posZ = posZ + Random(1, 5)
            else
                posZ = posZ - Random(1, 5)
            end
            LOG("sa: T4 rspawn(XSB1301) = " .. rspawn)
            unit = aiBrain:CreateUnitNearSpot(rspawn, posX, posZ)
            if unit == nil then
                LOG("sa: T4 rspawn CreateUnitNearSpot failed, Trying CreateUnitHPR")
                if Random(1, 2) == 2 then
                    posX = posX + Random(1, 5)
                else
                    posX = posX - Random(1, 5)
                end
                if Random(1, 2) == 2 then
                    posZ = posZ + Random(1, 5)
                else
                    posZ = posZ - Random(1, 5)
                end
                local terrainAltitude = GetTerrainHeight(posX, posZ)
                unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
                LOG("sa: T4 CreateUnitHPR(XSB1301) = " .. rspawn)
            end
			if Random(1, 2) == 2 then
				posX = aPosX
				posZ = aPosZ
				if Random(1, 2) == 2 then
                    posX = posX + Random(1, 5)
                else
                    posX = posX - Random(1, 5)
                end
                if Random(1, 2) == 2 then
                    posZ = posZ + Random(1, 5)
                else
                    posZ = posZ - Random(1, 5)
                end
				local terrainAltitude = GetTerrainHeight(posX, posZ)
				nukedef = CreateUnitHPR("BSD4302", aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
			end
            if unit ~= nil then
                --unit:SetMaxHealth(60000 + MainBuildingHPAI / (numOfBuildings + 10) + (humans * 10000))
				if Random(1, 3) <= 2 then	
					if Random(1, 2) == 1 then
						unit:SetMaxHealth(130000)
					else	
						unit:SetMaxHealth(160000)
					end	
				else
					unit:SetMaxHealth(110000)
				end	
                unit:SetCustomName("Control Center # " .. Random(1, 1000))
                local hp = unit:GetMaxHealth()
                unit:SetReclaimable(false)
                unit:SetCapturable(false)
                unit:SetHealth(self, hp)
				unit:SetProductionPerSecondEnergy(500)
				unit:SetProductionPerSecondMass(10)
                WaitTicks(30)
                CreateSecondaryObjectiveMarker(unit)
                table.insert(aiSecondaryBuildings.secondaryBuildings, unit)
            end
            counter = counter - 1
        until counter < 1
        WaitTicks(50)
		if MessageFlag == "On" then	
			SecondaryBuildingsWarning()
		end	
        KillThread(self)
    end)
end
function CreateMainAIBuilding()
    local circle = ForkThread(function(self)
        LOG("Creating AI main building.")
        local posX, posZ = aiBrain:GetArmyStartPos()
        local rspawn = "MAI2201"
        local unit = nil
        if Random(1, 2) == 2 then
            posX = posX + Random(1, 5)
        else
            posX = posX - Random(1, 5)
        end
        if Random(1, 2) == 2 then
            posZ = posZ + Random(1, 5)
        else
            posZ = posZ - Random(1, 5)
        end
        LOG("sa: T4 rspawn(XRB3301) = " .. rspawn)
        unit = aiBrain:CreateUnitNearSpot(rspawn, posX, posZ)
        if unit == nil then
            LOG("sa: T4 rspawn CreateUnitNearSpot failed, Trying CreateUnitHPR")
            if Random(1, 2) == 2 then
                posX = posX + Random(5, 10)
            else
                posX = posX - Random(5, 10)
            end
            if Random(1, 2) == 2 then
                posZ = posZ + Random(5, 10)
            else
                posZ = posZ - Random(5, 10)
            end
            local terrainAltitude = GetTerrainHeight(posX, posZ)
            unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
            LOG("sa: T4 CreateUnitHPR(XRB3301) = " .. rspawn)
        end
        if unit ~= nil then
            unit:SetMaxHealth(MainBuildingHPAI)
            unit:SetCustomName("Head Quarters")
            local hp = unit:GetMaxHealth()
            unit:SetReclaimable(false)
            unit:SetCapturable(false)
            unit:SetHealth(self, hp)
            unit:SetProductionPerSecondEnergy(HQEnergy)
            unit:SetProductionPerSecondMass(HQMass)
			--unit:SetConsumptionPerSecondEnergy(0)
            AIMainBuilding = unit
            WaitTicks(10)
            HQSpawnedWarning()
            CreateObjectiveMarker(AIMainBuilding)	
        end
		if HQDefenses == "HQ C-Tier Defenses" or HQDefenses == "HQ B-Tier Defenses" then
			VanDef = 1
		end
		if KillAIBase == 'BaseBuilding Off' or KillAIBase == '2nd Spawn Only BaseBuilding' then
			HQEnergy = 200000
			HQMass = 120
			unit:SetProductionPerSecondEnergy(HQEnergy)
            unit:SetProductionPerSecondMass(HQMass)
			BoostAIACUHealth()
			WaitTicks(10)
			if HQDefenses ~= "HQ Defenses Off" then
				local xSMD = 1 + math.floor(humans * 0.25) + (VanDef * 2)
				local xTMD = 4 + math.floor(humans * 1.5) + (VanDef * 4)
				local xShields = 5 + (VanDef * 2)
				repeat --SMD
					CreateAndLoadSMDForAI(SMDType)
					xSMD = xSMD - 1
				until xSMD < 1
				repeat --TMD
					CreateAUnitAroundMainBuildingForAITwo(TMDType)
					xTMD = xTMD - 1
				until xTMD < 1
				repeat --Shields
					CreateShieldDefenceForAI(ShieldType)
					xShields = xShields - 1
				until xShields < 1
			end
			if HQDefensesPD ~= "HQ Point Defenses Off" then
				local xPD = 3 + humans + (VanDef * 4)
				repeat --PD
					CreateAUnitAroundMainBuildingForAI(PDType)
					CreateAntiAirDefenceForAI(AAType)
					xPD = xPD - 1
				until xPD < 1
				if unit:GetCurrentLayer() == "Water" then
					local subdefense = 4 + humans
					repeat
						CreateAUnitAroundMainBuildingForAITwo("XRB2308")
						subdefense = subdefense - 1
					until subdefense < 1
				end	
			end	
		end
		local z = 5 + (VanDef * 3)
		local x = 5 + (VanDef * 2)
		local y = 4 + (VanDef * 2)
		local w = 3 + (VanDef * 2)
		if humans > 5 then
			x = 9 + (VanDef * 4)
			y = 6 + (VanDef * 2)
			z = 6 + (VanDef * 3)
			w = 4 + (VanDef * 2)
		end
		if HQDefensesPD ~= "HQ Point Defenses Off" then
			if unit:GetCurrentLayer() == "Water" then
				local subdefense2 = 6
				repeat
					CreateAUnitAroundMainBuildingForAITwo("XRB2308")
					subdefense2 = subdefense2 - 1
				until subdefense2 < 1
			end	
			
			repeat --PD
				CreateAUnitAroundMainBuildingForAI(PDType)
				y = y - 1
			until y < 1
			repeat --AA
				CreateAntiAirDefenceForAI(AAType)
				x = x - 1
			until x < 1
		end
		if HQDefenses ~= "HQ Defenses Off" then
			if humans > 5 then
				CreateAndLoadSMDForAI(SMDType)
			end	
			CreateAndLoadSMDForAI(SMDType)
			repeat --tmd
				CreateAUnitAroundMainBuildingForAITwo(TMDType)
				z = z - 1
			until z < 1
			repeat --shields
				CreateShieldDefenceForAI(ShieldType)
				w = w - 1
			until w < 1
		end	
        WaitTicks(70)
		local buildingcount = math.floor((1 + math.floor(humans * 0.5 + 0.5)) * SupportBaseMulti + 0.5)
		if buildingcount < 3 then
			buildingcount = 3
		elseif buildingcount > 16 then
			buildingcount = 16
		end	
		if SecondaryBuildingFlag == "On - Spawn Around HQ" then
			CreateSecondaryAIBuildings(buildingcount)
		elseif SecondaryBuildingFlag ~= "On - Spawn Around HQ" and SecondaryBuildingFlag ~= "Off" then
			ScanMapToSpawnAI(buildingcount)
		end
        KillThread(self)
    end)
end
function CreateSecondarySpawnBuilding()
    local circle = ForkThread(function(self)
        LOG("Creating 2nd Spawn building.")
        local posX, posZ = SecBrain:GetArmyStartPos()
        local rspawn = "B_SEC2101"
        local unit = nil
        if Random(1, 2) == 2 then
            posX = posX + Random(1, 5)
        else
            posX = posX - Random(1, 5)
        end
        if Random(1, 2) == 2 then
            posZ = posZ + Random(1, 5)
        else
            posZ = posZ - Random(1, 5)
        end
        LOG("sa: T4 rspawn(XRB3301) = " .. rspawn)
        unit = aiBrain:CreateUnitNearSpot(rspawn, posX, posZ)
        if unit == nil then
            LOG("sa: T4 rspawn CreateUnitNearSpot failed, Trying CreateUnitHPR")
            if Random(1, 2) == 2 then
                posX = posX + Random(5, 10)
            else
                posX = posX - Random(5, 10)
            end
            if Random(1, 2) == 2 then
                posZ = posZ + Random(5, 10)
            else
                posZ = posZ - Random(5, 10)
            end
            local terrainAltitude = GetTerrainHeight(posX, posZ)
            unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
            LOG("sa: T4 CreateUnitHPR(XRB3301) = " .. rspawn)
        end
        if unit ~= nil then
            unit:SetMaxHealth(SecSpawnBuildingHP)
            unit:SetCustomName("Secondary Quarters")
            local hp = unit:GetMaxHealth()
            unit:SetReclaimable(false)
            unit:SetCapturable(false)
            unit:SetHealth(self, hp)
			--unit:SetConsumptionPerSecondEnergy(0)
            AISecondBuilding = unit
            WaitTicks(10)
            --SecondarySpawnWarning()
            CreateObjectiveMarker(AISecondBuilding)	
        end
		
		if KillAIBase == 'BaseBuilding Off' or KillAIBase == 'HQ Only BaseBuilding' then
			Kill2ndSpawnPlayer()
			WaitTicks(10)
			if SecSpawnPD ~= "2nd Spawn Point Defenses Off" then
				x = 8 + (2 * humans)
				repeat --PD
					CreateDefensefor2ndSpawn("")
					x = x - 1
				until x < 1
			end	
			if SecSpawnDefences ~= "2nd Spawn Defenses Off" then
				CreateDefenceFor2ndSpawn(SecTMDType)
				CreateDefenceFor2ndSpawn(SecTMDType)
				CreateAndLoadSMDFor2ndSpawn(SecSMDType)
				CreateDefenceFor2ndSpawn(SecShieldType)
			end	
		end	
		if SecSpawnPD ~= "2nd Spawn Point Defenses Off" then
			local x = 8 + humans
			repeat --PD
				CreateDefensefor2ndSpawn("")
				x = x - 1
			until x < 1
			local z = 3
			repeat --PD
				CreatePDDefenceFor2ndSpawn(SecPDType)
				CreatePDDefenceFor2ndSpawn(SecAAType)
				z = z - 1
			until z < 1
		end	
		if SecSpawnDefences ~= "2nd Spawn Defenses Off" then
			CreateAndLoadSMDFor2ndSpawn(SecSMDType)
			local y = 3
			repeat --Shields
				CreateDefenceFor2ndSpawn(SecShieldType)
				y = y - 1
			until y < 1
			local w = 6 + humans
			repeat --TMD
				CreateDefenceFor2ndSpawn(SecTMDType)
				w = w - 1
			until w < 1
		end
        WaitTicks(70)
		SecondarySpawnBuildingMonitor()
        KillThread(self)
    end)
end
function CreateDefenceFor2ndSpawn(unitId)
    local circle = ForkThread(function(self)
        local unit = nil
        local posX, posZ = SecBrain:GetArmyStartPos()
		--local MapCheck = false
		local Chance
		--local count = 0
        if GetGameTimeSeconds() > 0 then
            rspawn = unitId
            if rspawn ~= nil then
                local oldposX = posX
				local oldposZ = posZ
					Chance = Random(1, 8)
					if Chance == 1 then
						posX = posX + Random(1, 45)
						posZ = posZ + Random(1, 45)
					elseif Chance == 2 then
						posX = posX - Random(1, 45)
						posZ = posZ + Random(1, 45)
					elseif Chance == 3 then
						posX = posX + Random(1, 45)
						posZ = posZ - Random(1, 45)
					elseif Chance == 4 then
						posX = posX - Random(1, 45)
						posZ = posZ - Random(1, 45)
					elseif Chance == 5 then
						posZ = posZ + Random(1, 45)
						posX = posX + Random(1, 45)
					elseif Chance == 6 then
						posZ = posZ - Random(1, 45)
						posX = posX + Random(1, 45)
					elseif Chance == 7 then
						posZ = posZ + Random(1, 45)
						posX = posX - Random(1, 45)
					else
						posZ = posZ - Random(1, 45)
						posX = posX - Random(1, 45)
					end

					if posX <= 0 then
						posX = Random(1, 45)
					end
					if posX >= sizeX then
						posX = sizeX - Random(1, 45)
					end
					if posZ <= 0 then
						posZ = Random(1, 45)
					end
					if posZ >= sizeZ then
						posZ = sizeZ - Random(1, 45)
					end
				unit = aiBrain:CreateUnitNearSpot(rspawn, posX, posZ)
				if unit == nil then
					local posX = oldposX
					local posZ = oldposZ
						Chance = Random(1, 8)
						if Chance == 1 then
							posX = posX + Random(1, 45)
							posZ = posZ + Random(1, 45)
						elseif Chance == 2 then
							posX = posX - Random(1, 45)
							posZ = posZ + Random(1, 45)
						elseif Chance == 3 then
							posX = posX + Random(1, 45)
							posZ = posZ - Random(1, 45)
						elseif Chance == 4 then
							posX = posX - Random(1, 45)
							posZ = posZ - Random(1, 45)
						elseif Chance == 5 then
							posZ = posZ + Random(1, 45)
							posX = posX + Random(1, 45)
						elseif Chance == 6 then
							posZ = posZ - Random(1, 45)
							posX = posX + Random(1, 45)
						elseif Chance == 7 then
							posZ = posZ + Random(1, 45)
							posX = posX - Random(1, 45)
						else
							posZ = posZ - Random(1, 45)
							posX = posX - Random(1, 45)
						end

						if posX <= 0 then
							posX = Random(1, 45)
						end
						if posX >= sizeX then
							posX = sizeX - Random(1, 45)
						end
						if posZ <= 0 then
							posZ = Random(1, 45)
						end
						if posZ >= sizeZ then
							posZ = sizeZ - Random(1, 45)
						end
					local terrainAltitude = GetTerrainHeight(posX, posZ)
					unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
                end
            end
        end
        if unit ~= nil then
            maxhp = unit:GetMaxHealth()
            unit:SetMaxHealth(maxhp + 2000 + 750 * humans)
            hp = unit:GetMaxHealth()
            unit:SetHealth(self, hp)
        end
        KillThread(self)
    end)
end
function CreatePDDefenceFor2ndSpawn(unitId)
    local circle = ForkThread(function(self)
        local unit = nil
        local posX, posZ = SecBrain:GetArmyStartPos()
		--local MapCheck = false
		local Chance
		--local count = 0
        if GetGameTimeSeconds() > 0 then
            rspawn = unitId
            if rspawn ~= nil then
                local oldposX = posX
				local oldposZ = posZ
					Chance = Random(1, 8)
					if Chance == 1 then
						posX = posX + Random(1, 45)
						posZ = posZ + Random(1, 45)
					elseif Chance == 2 then
						posX = posX - Random(1, 45)
						posZ = posZ + Random(1, 45)
					elseif Chance == 3 then
						posX = posX + Random(1, 45)
						posZ = posZ - Random(1, 45)
					elseif Chance == 4 then
						posX = posX - Random(1, 45)
						posZ = posZ - Random(1, 45)
					elseif Chance == 5 then
						posZ = posZ + Random(1, 45)
						posX = posX + Random(1, 45)
					elseif Chance == 6 then
						posZ = posZ - Random(1, 45)
						posX = posX + Random(1, 45)
					elseif Chance == 7 then
						posZ = posZ + Random(1, 45)
						posX = posX - Random(1, 45)
					else
						posZ = posZ - Random(1, 45)
						posX = posX - Random(1, 45)
					end

					if posX <= 0 then
						posX = Random(1, 45)
					end
					if posX >= sizeX then
						posX = sizeX - Random(1, 45)
					end
					if posZ <= 0 then
						posZ = Random(1, 45)
					end
					if posZ >= sizeZ then
						posZ = sizeZ - Random(1, 45)
					end
				unit = aiBrain:CreateUnitNearSpot(rspawn, posX, posZ)
				if unit == nil then
					local posX = oldposX
					local posZ = oldposZ
						Chance = Random(1, 8)
						if Chance == 1 then
							posX = posX + Random(1, 45)
							posZ = posZ + Random(1, 45)
						elseif Chance == 2 then
							posX = posX - Random(1, 45)
							posZ = posZ + Random(1, 45)
						elseif Chance == 3 then
							posX = posX + Random(1, 45)
							posZ = posZ - Random(1, 45)
						elseif Chance == 4 then
							posX = posX - Random(1, 45)
							posZ = posZ - Random(1, 45)
						elseif Chance == 5 then
							posZ = posZ + Random(1, 45)
							posX = posX + Random(1, 45)
						elseif Chance == 6 then
							posZ = posZ - Random(1, 45)
							posX = posX + Random(1, 45)
						elseif Chance == 7 then
							posZ = posZ + Random(1, 45)
							posX = posX - Random(1, 45)
						else
							posZ = posZ - Random(1, 45)
							posX = posX - Random(1, 45)
						end

						if posX <= 0 then
							posX = Random(1, 45)
						end
						if posX >= sizeX then
							posX = sizeX - Random(1, 45)
						end
						if posZ <= 0 then
							posZ = Random(1, 45)
						end
						if posZ >= sizeZ then
							posZ = sizeZ - Random(1, 45)
						end
					local terrainAltitude = GetTerrainHeight(posX, posZ)
					unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
                end
            end
        end
        if unit ~= nil then
            maxhp = unit:GetMaxHealth()
            unit:SetMaxHealth(maxhp + 2000 + (1000 * humans))
            hp = unit:GetMaxHealth()
            unit:SetHealth(self, hp)
        end
        KillThread(self)
    end)
end
function CreateDefensefor2ndSpawn(unitIda) --Spawns defenses for 2nd Spawn
    local circle = ForkThread(function(self)
        --if aiSecondaryBuildings and aiSecondaryBuildings.secondaryBuildings then
            --local buildingcount = 0
			--for aindex, sBuilding in aiSecondaryBuildings.secondaryBuildings do
                --if sBuilding and not sBuilding:BeenDestroyed() then
				--buildingcount = buildingcount + 1
				--local testunit = (aiSecondaryBuildings.secondaryBuildings)[buildingcount]
                    --[[if unitId == nil or unitId == "" then
                        if Random(1, 3) == 1 and AirPerWave > 0 then
                            unitId = "UEB2304"
                        elseif Random(1, 2) == 1 then
                            unitId = "XEB2306"
                        elseif Random(1, 2) == 1 then
                            unitId = "URB4201"
						elseif Random(1, 3) == 1 and (sBuilding:GetCurrentLayer() == "Water" or sBuilding:GetCurrentLayer() == "Seabed") and NavyPerWave > 0 then
							unitId = "XRB2308"
                        end
                    end]]--
					unitIda = nil
					--local MapCheck = false
					local Chance
					--local count = 0
                    if unitIda == nil or unitIda == "" then
						if NavyPerWave > 0 and (AISecondBuilding:GetCurrentLayer() == "Water") and Random(1, 2) == 1 then
							unitIda = "XRB2308"
						elseif Random(1, 3) <= 2 then
                            unitIda = SecPDType
						else
							unitIda = SecAAType
                        end
                    end
                    local unit = nil
                    local posX, posY, posZ = AISecondBuilding:GetPositionXYZ()
                    --if GetGameTimeSeconds() > (WavesStartTimeAI * 0.8) then
                        rspawn = unitIda
                        if rspawn ~= nil then
                            local oldposX = posX
							local oldposZ = posZ
								Chance = Random(1, 8)
								if Chance == 1 then
									posX = posX + Random(1, 30)
									posZ = posZ + Random(1, 30)
								elseif Chance == 2 then
									posX = posX - Random(1, 30)
									posZ = posZ + Random(1, 30)
								elseif Chance == 3 then
									posX = posX + Random(1, 30)
									posZ = posZ - Random(1, 30)
								elseif Chance == 4 then
									posX = posX - Random(1, 30)
									posZ = posZ - Random(1, 30)
								elseif Chance == 5 then
									posZ = posZ + Random(1, 30)
									posX = posX + Random(1, 30)
								elseif Chance == 6 then
									posZ = posZ - Random(1, 30)
									posX = posX + Random(1, 30)
								elseif Chance == 7 then
									posZ = posZ + Random(1, 30)
									posX = posX - Random(1, 30)
								else
									posZ = posZ - Random(1, 30)
									posX = posX - Random(1, 30)
								end

								if posX <= 0 then
									posX = Random(1, 30)
								end
								if posX >= sizeX then
									posX = sizeX - Random(1, 30)
								end
								if posZ <= 0 then
									posZ = Random(1, 30)
								end
								if posZ >= sizeZ then
									posZ = sizeZ - Random(1, 30)
								end
							unit = aiBrain:CreateUnitNearSpot(rspawn, posX, posZ)
							if unit == nil then
								local posX = oldposX
								local posZ = oldposZ
									Chance = Random(1, 8)
									if Chance == 1 then
										posX = posX + Random(1, 30)
										posZ = posZ + Random(1, 30)
									elseif Chance == 2 then
										posX = posX - Random(1, 30)
										posZ = posZ + Random(1, 30)
									elseif Chance == 3 then
										posX = posX + Random(1, 30)
										posZ = posZ - Random(1, 30)
									elseif Chance == 4 then
										posX = posX - Random(1, 30)
										posZ = posZ - Random(1, 30)
									elseif Chance == 5 then
										posZ = posZ + Random(1, 30)
										posX = posX + Random(1, 30)
									elseif Chance == 6 then
										posZ = posZ - Random(1, 30)
										posX = posX + Random(1, 30)
									elseif Chance == 7 then
										posZ = posZ + Random(1, 30)
										posX = posX - Random(1, 30)
									else
										posZ = posZ - Random(1, 30)
										posX = posX - Random(1, 30)
									end

									if posX <= 0 then
										posX = Random(1, 30)
									end
									if posX >= sizeX then
										posX = sizeX - Random(1, 30)
									end
									if posZ <= 0 then
										posZ = Random(1, 30)
									end
									if posZ >= sizeZ then
										posZ = sizeZ - Random(1, 30)
									end
								local terrainAltitude = GetTerrainHeight(posX, posZ)
								unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
                            end
                        end
                        if unit ~= nil then
                            maxhp = unit:GetMaxHealth()
                            unit:SetMaxHealth(maxhp + 2000 + (1000 * humans))
                            hp = unit:GetMaxHealth()
                            unit:SetHealth(self, hp)
                        end
                    --end
                --end
            --end
        --end
        KillThread(self)
    end)
end
function SecondarySpawnBuildingMonitor()
	local circle = ForkThread(function(self)
		repeat
			if AISecondBuilding ~= nil and AISecondBuilding:BeenDestroyed() then
				SecondarySpawnDead = true
				permanentwavemulti = permanentwaveloss * 0.01
				permanentwavemultiair = permanentwavelossair * 0.01
				permanentwavemultinavy = permanentwavelossnavy * 0.01
				-- Calculates % Wave Recovered by HQ if 2ndSpawn Destroyed
				spawnratelandmulti = 100 - spawnrateland + math.floor((spawnrateland *  permanentwavemulti) + 0.5)
				spawnrateairmulti = 100 - spawnrateair + math.floor((spawnrateair * permanentwavemultiair) + 0.5)
				spawnratenavymulti = 100 - spawnratenavy + math.floor((spawnratenavy * permanentwavemultinavy) + 0.5)
			end	
			WaitSeconds(10)
			if SecondarySpawnDead == true then
				PrintText("===2nd Spawn has been ELIMINATED!===", 28, 'ffCBFFFF', 10, 'center')
				break
			end	
		until GetGameTimeSeconds() > 20000 or won == true
	end)
end
function EngiStationsForAI()
	local circle = ForkThread(function(self)
		repeat
			WaitTicks(30)
			if GetGameTimeSeconds() > WavesStartTimeAI then
				WaitSeconds(300)
				local x = math.floor(humans * 0.33 + 0.5)
				if x == 0 then
					x = 1
				end	
				repeat
					WaitTicks(2)
					CreateEngiStationsForAI()
					x = x - 1
				until x < 1	
			end	
		until GetGameTimeSeconds() > 20000 or won == true
	end)
end
function CreateEngiStationsForAI()
    local circle = ForkThread(function(self)
        local unit = nil
        local posX, posZ = aiBrain:GetArmyStartPos()
        if GetGameTimeSeconds() > WavesStartTimeAI then
			rspawn = "xrb0304"
            if rspawn ~= nil then
                local oldposX = posX
                local oldposZ = posZ
                if Random(1, 2) == 2 then
                    posX = posX + Random(5, 20)
                    posZ = posZ + Random(5, 20)
                else
                    posX = posX - Random(5, 20)
                    posZ = posZ + Random(5, 20)
                end
                if Random(1, 2) == 2 then
                    posX = posX + Random(5, 20)
                    posZ = posZ - Random(5, 20)
                else
                    posX = posX - Random(5, 20)
                    posZ = posZ - Random(5, 20)
                end
                if Random(1, 2) == 2 then
                    posZ = posZ + Random(5, 20)
                    posX = posX + Random(5, 20)
                else
                    posZ = posZ - Random(5, 20)
                    posX = posX + Random(5, 20)
                end
                if Random(1, 2) == 2 then
                    posZ = posZ + Random(5, 20)
                    posX = posX - Random(5, 20)
                else
                    posZ = posZ - Random(5, 20)
                    posX = posX - Random(5, 20)
                end
                unit = aiBrain:CreateUnitNearSpot(rspawn, posX, posZ)
                if unit == nil then
                    local posX = oldposX
                    local posZ = oldposZ
                    if Random(1, 2) == 2 then
                        posX = posX + Random(5, 20)
                        posZ = posZ + Random(5, 20)
                    else
                        posX = posX - Random(5, 20)
                        posZ = posZ + Random(5, 20)
                    end
                    if Random(1, 2) == 2 then
                        posX = posX + Random(5, 20)
                        posZ = posZ - Random(5, 20)
                    else
                        posX = posX - Random(5, 20)
                        posZ = posZ - Random(5, 20)
                    end
                    if Random(1, 2) == 2 then
                        posZ = posZ + Random(5, 20)
                        posX = posX + Random(5, 20)
                    else
                        posZ = posZ - Random(5, 20)
                        posX = posX + Random(5, 20)
                    end
                    if Random(1, 2) == 2 then
                        posZ = posZ + Random(5, 20)
                        posX = posX - Random(5, 20)
                    else
                        posZ = posZ - Random(5, 20)
                        posX = posX - Random(5, 20)
                    end
                    local terrainAltitude = GetTerrainHeight(posX, posZ)
                    unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
                end
            end
        end
        if unit ~= nil then
            maxhp = unit:GetMaxHealth()
            unit:SetMaxHealth(maxhp + 2000 + HealthBonus)
            hp = unit:GetMaxHealth()
            unit:SetHealth(self, hp)
        end
        KillThread(self)
    end)
end
function CreateHQAltSpawnBuilding()
    local circle = ForkThread(function(self)
        LOG("Creating 2nd Spawn building.")
        local posX, posZ = AltHQBrain:GetArmyStartPos()
        local rspawn = "B_ALT1901"
        local unit = nil
		local nukedefHQ
		local aPosX = posX
		local aPosZ = posZ
        if Random(1, 2) == 2 then
            posX = posX + Random(1, 5)
        else
            posX = posX - Random(1, 5)
        end
        if Random(1, 2) == 2 then
            posZ = posZ + Random(1, 5)
        else
            posZ = posZ - Random(1, 5)
        end
        LOG("sa: T4 rspawn(XRB3301) = " .. rspawn)
        unit = aiBrain:CreateUnitNearSpot(rspawn, posX, posZ)
        if unit == nil then
            LOG("sa: T4 rspawn CreateUnitNearSpot failed, Trying CreateUnitHPR")
            if Random(1, 2) == 2 then
                posX = posX + Random(1, 5)
            else
                posX = posX - Random(1, 5)
            end
            if Random(1, 2) == 2 then
                posZ = posZ + Random(1, 5)
            else
                posZ = posZ - Random(1, 5)
            end
            local terrainAltitude = GetTerrainHeight(posX, posZ)
            unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
            LOG("sa: T4 CreateUnitHPR(XRB3301) = " .. rspawn)
        end
		if unit ~= nil and AltHQHealth ~= "Invulnerable --" then
			posX = aPosX
			posZ = aPosZ
			if Random(1, 2) == 2 then
                posX = posX + Random(5, 9)
            else
                posX = posX - Random(5, 9)
            end
            if Random(1, 2) == 2 then
				posZ = posZ + Random(5, 9)
            else
                posZ = posZ - Random(5, 9)
            end
			local terrainAltitude = GetTerrainHeight(posX, posZ)
			nukedefHQ = CreateUnitHPR("BSD4302", aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
		end
        if unit ~= nil then
			if AltHQHealth == "Invulnerable --" then
				unit:SetCanTakeDamage(false)
			else	
				unit:SetMaxHealth(AltHQHealth)
			end	
            unit:SetCustomName("Alternate HQ")
            local hp = unit:GetMaxHealth()
            unit:SetReclaimable(false)
            unit:SetCapturable(false)
            unit:SetHealth(self, hp)
			--unit:SetConsumptionPerSecondEnergy(0)
            AlternateHQBuilding = unit
            WaitTicks(10)
            --SecondarySpawnWarning()
            CreateObjectiveMarker(AlternateHQBuilding)	
        end
		
        WaitTicks(70)
		HQAltSpawnBuildingBuildingMonitor()
		if AltHQHealth ~= "Invulnerable --" then
			SpawnInDefenseAltHQ()
		end	
        KillThread(self)
    end)
end
function HQAltSpawnBuildingBuildingMonitor()
	local circle = ForkThread(function(self)
		repeat
			if AlternateHQBuilding ~= nil and AlternateHQBuilding:BeenDestroyed() then
				HQAltBuildingDead = true
			end	
			WaitSeconds(5)
			if HQAltBuildingDead == true then
				PrintText("===HQ Alt Spawn ELIMINATED!===", 28, 'ffCBFFFF', 10, 'center')
				WaitSeconds(2)
				RandomEffectAltSpawnDestroyed()
				break
			end	
		until GetGameTimeSeconds() > 20000 or won == true
	end)
end
function SpawnInDefenseAltHQ()
	local circle = ForkThread(function(self)
	WaitSeconds(10)
		CreateUnitAroundAlternateSpawns(AltHQBrain, AlternateHQBuilding, "GAA2304")
		CreateUnitAroundAlternateSpawns(AltHQBrain, AlternateHQBuilding, "GAA2304")
		CreateUnitAroundAlternateSpawns(AltHQBrain, AlternateHQBuilding, "GTD4201")
		repeat
			if HQAltBuildingDead == false then
				local count = Random(3, 4)
				repeat
					CreateDefenseAroundAlternateSpawns(AltHQBrain, AlternateHQBuilding)
					WaitTicks(2)
					count = count - 1
				until count < 1
			else
				break
			end	
			WaitSeconds(240)
		until GetGameTimeSeconds() > 20000 or won == true
    end)
end
function CreateDefenseAroundAlternateSpawns(army, building)
    local circle = ForkThread(function(self)
	local unitIda
	local rspawn
	local testunit = building
	--local MapCheck = false
	local Chance
	--local count = 0
                if building and not building:BeenDestroyed() then
						if NavyPerWave > 0 and (testunit:GetCurrentLayer() == "Water") and Random(1, 2) == 1 then
							unitIda = "XRB2308"
						elseif Random(1, 20) <= 17 then
                            unitIda = "UPD2304"
						else
							unitIda = "GTD4201"
                        end
                    local unit = nil
                    local posX, posZ = army:GetArmyStartPos()
                    --if GetGameTimeSeconds() > (WavesStartTimeAI * 0.8) then
                        rspawn = unitIda
                        if rspawn ~= nil then
                            local oldposX = posX
							local oldposZ = posZ
								Chance = Random(1, 8)
								if Chance == 1 then
									posX = posX + Random(1, 30)
									posZ = posZ + Random(1, 30)
								elseif Chance == 2 then
									posX = posX - Random(1, 30)
									posZ = posZ + Random(1, 30)
								elseif Chance == 3 then
									posX = posX + Random(1, 30)
									posZ = posZ - Random(1, 30)
								elseif Chance == 4 then
									posX = posX - Random(1, 30)
									posZ = posZ - Random(1, 30)
								elseif Chance == 5 then
									posZ = posZ + Random(1, 30)
									posX = posX + Random(1, 30)
								elseif Chance == 6 then
									posZ = posZ - Random(1, 30)
									posX = posX + Random(1, 30)
								elseif Chance == 7 then
									posZ = posZ + Random(1, 30)
									posX = posX - Random(1, 30)
								else
									posZ = posZ - Random(1, 30)
									posX = posX - Random(1, 30)
								end

								if posX <= 0 then
									posX = Random(1, 30)
								end
								if posX >= sizeX then
									posX = sizeX - Random(1, 30)
								end
								if posZ <= 0 then
									posZ = Random(1, 30)
								end
								if posZ >= sizeZ then
									posZ = sizeZ - Random(1, 30)
								end
							unit = aiBrain:CreateUnitNearSpot(rspawn, posX, posZ)
							if unit == nil then
								local posX = oldposX
								local posZ = oldposZ
									Chance = Random(1, 8)
									if Chance == 1 then
										posX = posX + Random(1, 30)
										posZ = posZ + Random(1, 30)
									elseif Chance == 2 then
										posX = posX - Random(1, 30)
										posZ = posZ + Random(1, 30)
									elseif Chance == 3 then
										posX = posX + Random(1, 30)
										posZ = posZ - Random(1, 30)
									elseif Chance == 4 then
										posX = posX - Random(1, 30)
										posZ = posZ - Random(1, 30)
									elseif Chance == 5 then
										posZ = posZ + Random(1, 30)
										posX = posX + Random(1, 30)
									elseif Chance == 6 then
										posZ = posZ - Random(1, 30)
										posX = posX + Random(1, 30)
									elseif Chance == 7 then
										posZ = posZ + Random(1, 30)
										posX = posX - Random(1, 30)
									else
										posZ = posZ - Random(1, 30)
										posX = posX - Random(1, 30)
									end

									if posX <= 0 then
										posX = Random(1, 30)
									end
									if posX >= sizeX then
										posX = sizeX - Random(1, 30)
									end
									if posZ <= 0 then
										posZ = Random(1, 30)
									end
									if posZ >= sizeZ then
										posZ = sizeZ - Random(1, 30)
									end
								local terrainAltitude = GetTerrainHeight(posX, posZ)
								unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
                            end
                        end
                        if unit ~= nil then
                            maxhp = unit:GetMaxHealth()
                            unit:SetMaxHealth(maxhp + 1000 + (500 * humans) + (Random(5000, 10000) * totalEnemyParagons) + 1000 * totalExpUnits)
                            hp = unit:GetMaxHealth()
                            unit:SetHealth(self, hp)
                        end
                    --end
                end
        KillThread(self)
    end)
end
function CreateUnitAroundAlternateSpawns(army, building, AIunit)
    local circle = ForkThread(function(self)
	local rspawn
	--local MapCheck = false
	local Chance
	--local count = 0
                if building and not building:BeenDestroyed() then
                    local unit = nil
                    local posX, posZ = army:GetArmyStartPos()
                    --if GetGameTimeSeconds() > (WavesStartTimeAI * 0.8) then
                        rspawn = AIunit
                        if rspawn ~= nil then
                            local oldposX = posX
							local oldposZ = posZ
								Chance = Random(1, 8)
								if Chance == 1 then
									posX = posX + Random(1, 30)
									posZ = posZ + Random(1, 30)
								elseif Chance == 2 then
									posX = posX - Random(1, 30)
									posZ = posZ + Random(1, 30)
								elseif Chance == 3 then
									posX = posX + Random(1, 30)
									posZ = posZ - Random(1, 30)
								elseif Chance == 4 then
									posX = posX - Random(1, 30)
									posZ = posZ - Random(1, 30)
								elseif Chance == 5 then
									posZ = posZ + Random(1, 30)
									posX = posX + Random(1, 30)
								elseif Chance == 6 then
									posZ = posZ - Random(1, 30)
									posX = posX + Random(1, 30)
								elseif Chance == 7 then
									posZ = posZ + Random(1, 30)
									posX = posX - Random(1, 30)
								else
									posZ = posZ - Random(1, 30)
									posX = posX - Random(1, 30)
								end

								if posX <= 0 then
									posX = Random(1, 30)
								end
								if posX >= sizeX then
									posX = sizeX - Random(1, 30)
								end
								if posZ <= 0 then
									posZ = Random(1, 30)
								end
								if posZ >= sizeZ then
									posZ = sizeZ - Random(1, 30)
								end
							unit = aiBrain:CreateUnitNearSpot(rspawn, posX, posZ)
							if unit == nil then
								local posX = oldposX
								local posZ = oldposZ
									Chance = Random(1, 8)
									if Chance == 1 then
										posX = posX + Random(1, 30)
										posZ = posZ + Random(1, 30)
									elseif Chance == 2 then
										posX = posX - Random(1, 30)
										posZ = posZ + Random(1, 30)
									elseif Chance == 3 then
										posX = posX + Random(1, 30)
										posZ = posZ - Random(1, 30)
									elseif Chance == 4 then
										posX = posX - Random(1, 30)
										posZ = posZ - Random(1, 30)
									elseif Chance == 5 then
										posZ = posZ + Random(1, 30)
										posX = posX + Random(1, 30)
									elseif Chance == 6 then
										posZ = posZ - Random(1, 30)
										posX = posX + Random(1, 30)
									elseif Chance == 7 then
										posZ = posZ + Random(1, 30)
										posX = posX - Random(1, 30)
									else
										posZ = posZ - Random(1, 30)
										posX = posX - Random(1, 30)
									end

									if posX <= 0 then
										posX = Random(1, 30)
									end
									if posX >= sizeX then
										posX = sizeX - Random(1, 30)
									end
									if posZ <= 0 then
										posZ = Random(1, 30)
									end
									if posZ >= sizeZ then
										posZ = sizeZ - Random(1, 30)
									end
								local terrainAltitude = GetTerrainHeight(posX, posZ)
								unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
                            end
                        end
                        if unit ~= nil then
                            maxhp = unit:GetMaxHealth()
                            unit:SetMaxHealth(maxhp + 1000 + (500 * humans) + (Random(5000, 10000) * totalEnemyParagons) + 1000 * totalExpUnits)
                            hp = unit:GetMaxHealth()
                            unit:SetHealth(self, hp)
                        end
                    --end
                end
        KillThread(self)
    end)
end
function Create2ndAltSpawnBuilding()
    local circle = ForkThread(function(self)
        LOG("Creating 2nd Spawn building.")
        local posX, posZ = Alt2ndBrain:GetArmyStartPos()
        local rspawn = "B_ALT1901"
        local unit = nil
		local nukedef2nd
		local aPosX = posX
		local aPosZ = posZ
        if Random(1, 2) == 2 then
            posX = posX + Random(1, 5)
        else
            posX = posX - Random(1, 5)
        end
        if Random(1, 2) == 2 then
            posZ = posZ + Random(1, 5)
        else
            posZ = posZ - Random(1, 5)
        end
        LOG("sa: T4 rspawn(XRB3301) = " .. rspawn)
        unit = aiBrain:CreateUnitNearSpot(rspawn, posX, posZ)
        if unit == nil then
            LOG("sa: T4 rspawn CreateUnitNearSpot failed, Trying CreateUnitHPR")
            if Random(1, 2) == 2 then
                posX = posX + Random(1, 5)
            else
                posX = posX - Random(1, 5)
            end
            if Random(1, 2) == 2 then
                posZ = posZ + Random(1, 5)
            else
                posZ = posZ - Random(1, 5)
            end
            local terrainAltitude = GetTerrainHeight(posX, posZ)
            unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
            LOG("sa: T4 CreateUnitHPR(XRB3301) = " .. rspawn)
        end
		if unit ~= nil and Alt2ndHealth ~= "Invulnerable --" then
			posX = aPosX
			posZ = aPosZ
			if Random(1, 2) == 2 then
                posX = posX + Random(5, 9)
            else
                posX = posX - Random(5, 9)
            end
            if Random(1, 2) == 2 then
				posZ = posZ + Random(5, 9)
            else
                posZ = posZ - Random(5, 9)
            end
			local terrainAltitude = GetTerrainHeight(posX, posZ)
			nukedef2nd = CreateUnitHPR("BSD4302", aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
		end
        if unit ~= nil then
			if Alt2ndHealth == "Invulnerable --" then
				unit:SetCanTakeDamage(false)
			else	
				unit:SetMaxHealth(Alt2ndHealth)
			end	
            unit:SetCustomName("Alternate 2nd HQ")
            local hp = unit:GetMaxHealth()
            unit:SetReclaimable(false)
            unit:SetCapturable(false)
            unit:SetHealth(self, hp)
			--unit:SetConsumptionPerSecondEnergy(0)
            Alternate2ndBuilding = unit
            WaitTicks(10)
            --SecondarySpawnWarning()
            CreateObjectiveMarker(Alternate2ndBuilding)	
        end
		
        WaitTicks(70)
		Alt2ndSpawnBuildingBuildingMonitor()
		if Alt2ndHealth ~= "Invulnerable --" then
			SpawnInDefense2ndAlt()
		end	
        KillThread(self)
    end)
end
function Alt2ndSpawnBuildingBuildingMonitor()
	local circle = ForkThread(function(self)
		repeat
			if Alternate2ndBuilding ~= nil and Alternate2ndBuilding:BeenDestroyed() then
				Alt2ndBuildingDead = true
			end	
			WaitSeconds(5)
			if Alt2ndBuildingDead == true then
				PrintText("===Alt 2nd Spawn ELIMINATED!===", 28, 'ffCBFFFF', 10, 'center')
				WaitSeconds(2)
				RandomEffectAltSpawnDestroyed()
				break
			end	
		until GetGameTimeSeconds() > 20000 or won == true
	end)
end
function SpawnInDefense2ndAlt()
	local circle = ForkThread(function(self)
	WaitSeconds(10)
		CreateUnitAroundAlternateSpawns(Alt2ndBrain, Alternate2ndBuilding, "GAA2304")
		CreateUnitAroundAlternateSpawns(Alt2ndBrain, Alternate2ndBuilding, "GAA2304")
		CreateUnitAroundAlternateSpawns(Alt2ndBrain, Alternate2ndBuilding, "GTD4201")
		repeat
			if Alt2ndBuildingDead == false and SecondarySpawnDead == false then
				local count = Random(3, 4)
				repeat
					CreateDefenseAroundAlternateSpawns(Alt2ndBrain, Alternate2ndBuilding)
					WaitTicks(2)
					count = count - 1
				until count < 1
			else
				break
			end	
			WaitSeconds(240)
		until GetGameTimeSeconds() > 20000 or won == true
    end)
end
function SelectHQDefenses()
	if HQDefenses ~= "HQ Defenses Off" then
		if HQDefenses == "HQ S2-Tier Defenses" then
			TMDType = "GTD4201"
			SMDType = "ASD4302"
			ShieldType = "GAS4301"
		elseif HQDefenses == "HQ S1-Tier Defenses" then
			TMDType = "GTD4201"
			SMDType = "BSD4302"
			ShieldType = "GAS4301"
		elseif HQDefenses == "HQ AAA-Tier Defenses" then
			TMDType = "URB4201"
			SMDType = "ASD4302"
			ShieldType = "GAS4301"
		elseif HQDefenses == "HQ AA-Tier Defenses" then
			TMDType = "GTD4201"
			SMDType = "ASD4302"
			ShieldType = "GAS4302"
		elseif HQDefenses == "HQ A-Tier Defenses" then
			TMDType = "GTD4201"
			SMDType = "BSD4302"
			ShieldType = "GAS4302"
		elseif HQDefenses == "HQ B-Tier Defenses" then
			TMDType = "URB4201"
			SMDType = "BSD4302"
			ShieldType = "GAS4302"
		elseif HQDefenses == "HQ C-Tier Defenses" then
			TMDType = "URB4201"
			SMDType = "UAB4302"
			ShieldType = "XSB4301"
		end
	end
	if HQDefensesPD ~= "HQ Point Defenses Off" then
		if HQDefensesPD == "HQ Guardian PD S-Tier" then
			AAType = "GAA2304"
			PDType = "GPD2301"
		elseif HQDefensesPD == "HQ Universal PD A-Tier" then
			AAType = "UPD2304"
			PDType = "UPD2304"
		elseif HQDefensesPD == "HQ T3 Vanilla PD B-Tier" then
			AAType = "URB2304"
			PDType = "XEB2306"
		elseif HQDefensesPD == "HQ T2 Vanilla PD C-Tier" then
			AAType = "UEB2204"
			PDType = "XSB2301"		
		end
	end	
end
function Select2ndSpawnDefenses()
	if SecSpawnDefences ~= "2nd Spawn Defenses Off" then
		if SecSpawnDefences == "2nd Spawn S2-Tier Defenses" then
			SecTMDType = "GTD4201"
			SecSMDType = "ASD4302"
			SecShieldType = "GAS4301"
		elseif SecSpawnDefences == "2nd Spawn S1-Tier Defenses" then
			SecTMDType = "GTD4201"
			SecSMDType = "BSD4302"
			SecShieldType = "GAS4301"
		elseif SecSpawnDefences == "2nd Spawn AAA-Tier Defenses" then
			SecTMDType = "URB4201"
			SecSMDType = "ASD4302"
			SecShieldType = "GAS4301"
		elseif SecSpawnDefences == "2nd Spawn AA-Tier Defenses" then
			SecTMDType = "GTD4201"
			SecSMDType = "ASD4302"
			SecShieldType = "GAS4302"
		elseif SecSpawnDefences == "2nd Spawn A-Tier Defenses" then
			SecTMDType = "GTD4201"
			SecSMDType = "BSD4302"
			SecShieldType = "GAS4302"
		elseif SecSpawnDefences == "2nd Spawn B-Tier Defenses" then
			SecTMDType = "URB4201"
			SecSMDType = "BSD4302"
			SecShieldType = "GAS4302"
		elseif SecSpawnDefences == "2nd Spawn C-Tier Defenses" then
			SecTMDType = "URB4201"
			SecSMDType = "UAB4302"
			SecShieldType = "XSB4301"
		end
	end
	if SecSpawnPD ~= "2nd Spawn Point Defenses Off" then
		if SecSpawnPD == "2nd Spawn Guardian PD S-Tier" then
			SecAAType = "GAA2304"
			SecPDType = "GPD2301"
		elseif SecSpawnPD == "2nd Spawn Universal PD A-Tier" then
			SecAAType = "UPD2304"
			SecPDType = "UPD2304"
		elseif SecSpawnPD == "2nd Spawn T3 Vanilla PD B-Tier" then
			SecAAType = "URB2304"
			SecPDType = "XEB2306"
		elseif SecSpawnPD == "2nd Spawn T2 Vanilla PD C-Tier" then
			SecAAType = "UEB2204"
			SecPDType = "XSB2301"		
		end
	end	
end
GetRandomizedTransUnit = function(self)
    local rspawn = nil
	if TransportUnits == "All Units" then
		if GameTime < (0.12 * WaveProgression) then
			rspawn = (landUnitsL.Tech4)[Random(1, Lland)]
				if (JumpTech2 == "Land+Air+Navy" or JumpTech2 == "Land+Air" or JumpTech2 == "Land+Navy" or JumpTech2 == "Land") then
					rspawn = (landUnitsM.Tech4)[Random(1, Mland)]
				end	
			elseif GameTime >= (0.12 * WaveProgression) and GameTime < (0.3 * WaveProgression) then
				rspawn = (landUnitsM.Tech4)[Random(1, Mland)]
				if Random(1, 3) == 1 and GameTime < (0.18 * WaveProgression) and not (JumpTech2 == "Land+Air+Navy" or JumpTech2 == "Land+Air" or JumpTech2 == "Land+Navy" or JumpTech2 == "Land") then
					rspawn = (landUnitsL.Tech4)[Random(1, Lland)]
				end	
			elseif GameTime >= (0.3 * WaveProgression) and GameTime < (0.45 * WaveProgression) then
				rspawn = (landUnitsH.Tech4)[Random(1, Hland)]
				if Random(1, 3) == 1 and GameTime < (0.35 * WaveProgression) then
					rspawn = (landUnitsM.Tech4)[Random(1, Mland)]
				end	
			elseif GameTime >= (0.45 * WaveProgression) then
				rspawn = (landUnitsH.Tech4)[Random(1, Hland)]
		end	
	else	
		if GameTime < (0.12 * WaveProgression) then
			rspawn = (TransUnitsL.Tech4)[Random(1, TranLland)]
				if (JumpTech2 == "Land+Air+Navy" or JumpTech2 == "Land+Air" or JumpTech2 == "Land+Navy" or JumpTech2 == "Land") then
					rspawn = (TransUnitsM.Tech4)[Random(1, TranMland)]
				end	
			elseif GameTime >= (0.12 * WaveProgression) and GameTime < (0.3 * WaveProgression) then
				rspawn = (TransUnitsM.Tech4)[Random(1, TranMland)]
				if Random(1, 3) == 1 and GameTime < (0.18 * WaveProgression) and not (JumpTech2 == "Land+Air+Navy" or JumpTech2 == "Land+Air" or JumpTech2 == "Land+Navy" or JumpTech2 == "Land") then
					rspawn = (TransUnitsL.Tech4)[Random(1, TranLland)]
				end	
			elseif GameTime >= (0.3 * WaveProgression) and GameTime < (0.45 * WaveProgression) then
				rspawn = (TransUnitsH.Tech4)[Random(1, TranHland)]
				if Random(1, 3) == 1 and GameTime < (0.35 * WaveProgression) then
					rspawn = (TransUnitsM.Tech4)[Random(1, TranMland)]
				end	
			elseif GameTime >= (0.45 * WaveProgression) then
				rspawn = (TransUnitsH.Tech4)[Random(1, TranHland)]
		end	
	end
	if RamboChance ~= "Off --" and GameTime >= (0.45 * WaveProgression) then
		if GameTime >= (0.45 * WaveProgression) and GameTime < (0.6 * WaveProgression) then
			if Random(0, 300) <= RamboChance then
				rspawn = RamboTransTable[Random(1, 3)]
			end	
		elseif GameTime >= (0.6 * WaveProgression) and GameTime < (0.75 * WaveProgression) then
			if Random(0, 220) <= RamboChance then
				rspawn = RamboTransTable[Random(1, 3)]
			end
		elseif GameTime >= (0.75 * WaveProgression) and GameTime < (0.9 * WaveProgression) then
			if Random(0, 150) <= RamboChance then
				rspawn = RamboTransTable[Random(1, 3)]
			end
		elseif GameTime >= (0.9 * WaveProgression) and GameTime < (1.05 * WaveProgression) then
			if Random(0, 100) <= RamboChance then
				rspawn = RamboTransTable[Random(1, 3)]
			end
		elseif GameTime >= (1.05 * WaveProgression) and GameTime < (1.2 * WaveProgression) then
			if Random(0, 60) <= RamboChance then
				rspawn = RamboTransTable[Random(1, 3)]
			end	
		elseif GameTime >= (1.2 * WaveProgression) and GameTime < (1.35 * WaveProgression) then
			if Random(0, 30) <= RamboChance then
				rspawn = RamboTransTable[Random(1, 3)]
			end	
		elseif GameTime >= (1.35 * WaveProgression) and GameTime < (1.5 * WaveProgression) then
			if Random(0, 15) <= RamboChance then
				rspawn = RamboTransTable[Random(1, 3)]
			end
		elseif GameTime >= (1.5 * WaveProgression) then
			if Random(0, 8) <= RamboChance then
				rspawn = RamboTransTable[Random(1, 3)]
			end	
		end	
	end	
		
 return rspawn
end
function TransportMonitor() --Starts and Monitors Transport Script
	local circle = ForkThread(function(self)
		repeat
			if ((GetGameTimeSeconds() - WavesStartTimeAI) / HoldTimeAI) >= TransportsToStartTime and ((GetGameTimeSeconds() - WavesStartTimeAI) / HoldTimeAI) <= TransportEndTime then
				TransportControlScript()
				WaitSeconds(Random(TransLowerM, TransUpperM) - 6)
			end	
			WaitSeconds(6)
		until GetGameTimeSeconds() > 20000 or won == true
	end)
end	
function TransportControlScript() --Starts Transports Spawning
	local circle = ForkThread(function(self)
		local Tcount = 0
		
		if TransportMultiplier ~= "No" then
			local TLandCount = 0
			if GameTime <= 0.25 then
				TLandCount = math.floor(InitialTransports * Transx1 + 0.5)
			elseif GameTime > 0.25 and GameTime <= 0.5 then
				TLandCount = math.floor(InitialTransports * Transx2 + 0.5)
			elseif GameTime > 0.5 and GameTime <= 0.75 then
				TLandCount = math.floor(InitialTransports * Transx3 + 0.5)
			elseif GameTime > 0.75 and GameTime <= 1 then
				TLandCount = math.floor(InitialTransports * Transx4 + 0.5)
			elseif GameTime > 1 then
				TLandCount = math.floor(InitialTransports * Transx5 + 0.5)
			end
			if TLandCount < 1 then
				TLandCount = 1
			end
			Tcount = TLandCount
		else	
			Tcount = InitialTransports
		end
		
		if TransportExpChance ~= "Off --" then 
			repeat --Chooses Regular and T4 Units
				ChanceTransportsCarryT4()
				Tcount = Tcount - 1
				WaitSeconds(1)
			until Tcount == 0
		else
			repeat --Chooses Regular Units Only
				TransportTechAttack()
				Tcount = Tcount - 1
				WaitSeconds(1)
			until Tcount == 0
		end
	end)
end
function ChanceTransportsCarryT4()
	local circle = ForkThread(function(self)
		if GameTime < (0.7 * WaveProgression) then
			TransportTechAttack()
		elseif GameTime >= (0.7 * WaveProgression) and GameTime < (0.85 * WaveProgression) then
			if Random(0, 300) <= 10 * TransportExpChance then
				TransportExperimentalAttack()
			else
				TransportTechAttack()
			end
		elseif GameTime >= (0.85 * WaveProgression) and GameTime < (1 * WaveProgression) then
			if Random(0, 250) <= 10 * TransportExpChance then
				TransportExperimentalAttack()
			else
				TransportTechAttack()
			end	
		elseif GameTime >= (1 * WaveProgression) and GameTime < (1.15 * WaveProgression) then
			if Random(0, 210) <= 10 * TransportExpChance then
				TransportExperimentalAttack()
			else
				TransportTechAttack()
			end
		elseif GameTime >= (1.15 * WaveProgression) and GameTime < (1.3 * WaveProgression) then
			if Random(0, 150) <= 10 * TransportExpChance then
				TransportExperimentalAttack()
			else
				TransportTechAttack()
			end
		elseif GameTime >= (1.3 * WaveProgression) and GameTime < (1.45 * WaveProgression) then
			if Random(0, 85) <= 10 * TransportExpChance then
				TransportExperimentalAttack()
			else
				TransportTechAttack()
			end
		else
			if Random(0, 40) <= 10 * TransportExpChance then
				TransportExperimentalAttack()
			else
				TransportTechAttack()
			end
		end
	end)
end	
function randomchar(a, b, c)
    return string.char(math.random(string.byte(a), string.byte(b)))
end
function WaveSizeMultiForTransports()
	local circle = ForkThread(function(self)
		TransValueX = {}
		local n = 0
		
		for v in TransportMultiplier:gmatch("%S+") do
			n = n + 1
			TransValueX[n] = v
		end
		Transx1 = tonumber(TransValueX[1])
		Transx2 = tonumber(TransValueX[3])
		Transx3 = tonumber(TransValueX[5])
		Transx4 = tonumber(TransValueX[7])
		Transx5 = tonumber(TransValueX[9])
	end)
end
function TransportWaveFrequency()
	local circle = ForkThread(function(self)
		TransFreq = {}
		local n = 0
		
		for v in TransportFrequency:gmatch("%S+") do
			n = n + 1
			TransFreq[n] = v
		end
		TransLowerM = tonumber(TransFreq[2]) * 60
		TransUpperM = tonumber(TransFreq[4]) * 60
	end)
end
function TransportTechAttack() --T1/T2/T3 Transports
	local circle = ForkThread(function(self)
		local a = randomchar('0', '9')
		local b = randomchar('A', 'Z')
		local c = randomchar('A', 'Z')
		local x = 1
		local TransportPlatoon = aiBrain:MakePlatoon(a .. b .. c, '')
		if GameTime < (0.12 * WaveProgression) then
			x = 18
		elseif GameTime >= (0.12 * WaveProgression) and GameTime < (0.3 * WaveProgression) then
			x = 12
		else
			x = 6
		end
		repeat --Calls function to Spawn Units for Transport
			SpawnInPlatoon(TransportPlatoon)
			x = x - 1
		until x < 0	
		SpawnInTransports(TransportPlatoon) --Spawns Transport for Above Units
	end)
end	
function TransportExperimentalAttack() --Experimental Transports
		local circle = ForkThread(function(self)
		local a = randomchar('0', '9')
		local b = randomchar('A', 'Z')
		local c = randomchar('A', 'Z')
		local TransportPlatoon = aiBrain:MakePlatoon(a .. b .. c, '')
		SpawnInExperimentalPlatoon(TransportPlatoon) --Calls function to Spawn in T4 Units for Transport
		SpawnInTransports(TransportPlatoon) --Spawns Transport for Above Units
	end)
end	
function SpawnInTransports(TransportPlatoon)
    local circle = ForkThread(function(self)
	local unit = nil
	local transport
	local aplatoon = TransportPlatoon
	local sizeX, sizeZ = GetMapSize()
	local RanNum
	local posX
	local posZ
        if GetGameTimeSeconds() > 0 then
            rspawn = "DROP0306"
            if rspawn ~= nil then
				if TranSpawnLocation == "All Sides" or RetaliationTransport == true then
					RanNum = Random(1, 4)
				elseif TranSpawnLocation == "North Side" then
					RanNum = 1
				elseif TranSpawnLocation == "South Side" then
					RanNum = 2
				elseif TranSpawnLocation == "East Side" then
					RanNum = 3
				elseif TranSpawnLocation == "West Side" then
					RanNum = 4
				elseif TranSpawnLocation == "East-West" then
					if Random(1, 2) == 1 then
						RanNum = 3
					else
						RanNum = 4
					end
				elseif TranSpawnLocation == "North-South" then
					if Random(1, 2) == 1 then
						RanNum = 1
					else
						RanNum = 2
					end
				elseif TranSpawnLocation == "Center Only" then
					RanNum = 5
				end	
					
				if RanNum == 1 then
					posX = Random(1, sizeX)
					posZ = 1
				elseif RanNum == 2 then
					posX = Random(1, sizeX)
					posZ = sizeZ
				elseif RanNum == 3 then
					posX = sizeX
					posZ = Random(1, sizeZ)
				elseif RanNum == 4 then
					posX = 1
					posZ = Random(1, sizeZ)
				elseif RanNum == 5 then
					posX = (sizeX * 0.5) + Random(1, 20)
					if Random(1, 2) == 1 then
						posX = (sizeX * 0.5) - Random(1, 20)
					end	
					posZ = (sizeZ * 0.5) + Random(1, 20)
					if Random(1, 2) == 1 then
						posZ = (sizeZ * 0.5) + Random(1, 20)
					end	
				end	
                local terrainAltitude = GetTerrainHeight(posX, posZ) + 9
                unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
            end
        end
		if unit and unit ~= nil and not unit.Dead then
                if GameTime < 0.33 then
					totalIncrease = HealthBonus * 0.5 + totalEnemyT3AirDefences * 50 + totalEnemyExpAirDefences * 100
					maxhp = unit:GetMaxHealth()
					unit:SetMaxHealth(maxhp + totalIncrease)
				elseif GameTime >= 0.33 and GameTime < 0.66 then
					totalIncrease = HealthBonus + totalEnemyT3AirDefences * 50 + totalEnemyExpAirDefences * 100
					maxhp = unit:GetMaxHealth()
					unit:SetMaxHealth(maxhp + totalIncrease)
				elseif GameTime >= 0.66 and GameTime < 1 then
					totalIncrease = HealthBonus * 1.5 + Random(1000, 1500) * totalEnemyEndgamers + totalEnemyT3AirDefences * 50 + totalEnemyExpAirDefences * 100
					maxhp = unit:GetMaxHealth()
					unit:SetMaxHealth(maxhp + totalIncrease)
				elseif GameTime >= 1 then
					totalIncrease = HealthBonus * 2 + Random(1800, 2500) * totalEnemyEndgamers + totalEnemyT3AirDefences * 50 + totalEnemyExpAirDefences * 100
					maxhp = unit:GetMaxHealth()
					unit:SetMaxHealth(maxhp + totalIncrease)
				end
				hp = unit:GetMaxHealth()
                unit:SetHealth(self, hp)
                unit:SetReclaimable(false)
        end
		transport = unit
		ScenarioFramework.AttachUnitsToTransports(aplatoon:GetPlatoonUnits(), {transport})
		RedirectTransports(transport, aplatoon)
		RetaliationTransport = false
	end)
end
function SpawnInPlatoon(TransportPlatoon)
    local circle = ForkThread(function(self)
	local unit = nil
	local transport
        local posX, posZ = aiBrain:GetArmyStartPos()
        if GetGameTimeSeconds() > 0 then
            rspawn = GetRandomizedTransUnit()
            if rspawn ~= nil then
                local oldposX = posX
                local oldposZ = posZ
                if Random(1, 2) == 2 then
                    posX = posX + Random(5, 20)
                    posZ = posZ + Random(5, 20)
                else
                    posX = posX - Random(5, 20)
                    posZ = posZ + Random(5, 20)
                end
                if Random(1, 2) == 2 then
                    posX = posX + Random(5, 20)
                    posZ = posZ - Random(5, 20)
                else
                    posX = posX - Random(5, 20)
                    posZ = posZ - Random(5, 20)
                end
                if Random(1, 2) == 2 then
                    posZ = posZ + Random(5, 20)
                    posX = posX + Random(5, 20)
                else
                    posZ = posZ - Random(5, 20)
                    posX = posX + Random(5, 20)
                end
                if Random(1, 2) == 2 then
                    posZ = posZ + Random(5, 20)
                    posX = posX - Random(5, 20)
                else
                    posZ = posZ - Random(5, 20)
                    posX = posX - Random(5, 20)
                end
                unit = aiBrain:CreateUnitNearSpot(rspawn, posX, posZ)
                if unit == nil then
                    local posX = oldposX
                    local posZ = oldposZ
                    if Random(1, 2) == 2 then
                        posX = posX + Random(5, 20)
                        posZ = posZ + Random(5, 20)
                    else
                        posX = posX - Random(5, 20)
                        posZ = posZ + Random(5, 20)
                    end
                    if Random(1, 2) == 2 then
                        posX = posX + Random(5, 20)
                        posZ = posZ - Random(5, 20)
                    else
                        posX = posX - Random(5, 20)
                        posZ = posZ - Random(5, 20)
                    end
                    if Random(1, 2) == 2 then
                        posZ = posZ + Random(5, 20)
                        posX = posX + Random(5, 20)
                    else
                        posZ = posZ - Random(5, 20)
                        posX = posX + Random(5, 20)
                    end
                    if Random(1, 2) == 2 then
                        posZ = posZ + Random(5, 20)
                        posX = posX - Random(5, 20)
                    else
                        posZ = posZ - Random(5, 20)
                        posX = posX - Random(5, 20)
                    end
                    local terrainAltitude = GetTerrainHeight(posX, posZ)
                    unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
                end
            end
			if aiBrain ~= nil and unit ~= nil then
				aiBrain:AssignUnitsToPlatoon(TransportPlatoon, {unit}, 'Attack', 'NoFormation')
			end	
			if unit and unit ~= nil and not unit.Dead and (HPBonusAI > 0 or ParagonCycle ~= "Off") then
                if GameTime < 0.33 then
					totalIncrease = HealthBonus * 0.5
					maxhp = unit:GetMaxHealth()
					unit:SetMaxHealth(maxhp + totalIncrease)
				elseif GameTime >= 0.33 and GameTime < 0.66 then
					totalIncrease = HealthBonus
					maxhp = unit:GetMaxHealth()
					unit:SetMaxHealth(maxhp + totalIncrease)
				elseif GameTime >= 0.66 and GameTime < 1 then
					totalIncrease = HealthBonus * 1.5 + Random(1400, 1800) * totalEnemyEndgamers
					maxhp = unit:GetMaxHealth()
					unit:SetMaxHealth(maxhp + totalIncrease)
				elseif GameTime >= 1 then
					totalIncrease = HealthBonus * 2 + Random(1800, 2800) * totalEnemyEndgamers
					maxhp = unit:GetMaxHealth()
					unit:SetMaxHealth(maxhp + totalIncrease)
				end
				hp = unit:GetMaxHealth()
                unit:SetHealth(self, hp)
                unit:SetReclaimable(false)
            end
            if unit and not unit.Dead then
				if DamageBoost ~= 'Off - 0' then
					ModifyWeaponDamageBuffAndRange(unit)
				end	
				unit:SetSpeedMult(1 + waveNum * SpeedBonus + SpeedBonusOnce)
			end
			if KillPlayerUnit > 0 then
				SuicideLandNavyUnit(unit)
			end	
        end
	end)
end
function SpawnInExperimentalPlatoon(TransportPlatoon)
    local circle = ForkThread(function(self)
	local unit = nil
	local transport
        local posX, posZ = aiBrain:GetArmyStartPos()
        if GetGameTimeSeconds() > 0 then
			if TotalMayhemWaves == "Adjustable T1/T2/T3 Experimentals" then
				if HlandHeavy > 0 and Random(1, 3) == 1 then
					rspawn = (landUnitsHHeavy.Tech4)[Random(1, HlandHeavy)]
				else	
					if Random(1, 2) == 1 then
						rspawn = "URL0402"
					else
						rspawn = "XSL0401"
					end
				end	
			else
				if Random(1, 2) == 1 then
					rspawn = "URL0402"
				else
					rspawn = "XSL0401"
				end
			end	
            if rspawn ~= nil then
                local oldposX = posX
                local oldposZ = posZ
                if Random(1, 2) == 2 then
                    posX = posX + Random(5, 20)
                    posZ = posZ + Random(5, 20)
                else
                    posX = posX - Random(5, 20)
                    posZ = posZ + Random(5, 20)
                end
                if Random(1, 2) == 2 then
                    posX = posX + Random(5, 20)
                    posZ = posZ - Random(5, 20)
                else
                    posX = posX - Random(5, 20)
                    posZ = posZ - Random(5, 20)
                end
                if Random(1, 2) == 2 then
                    posZ = posZ + Random(5, 20)
                    posX = posX + Random(5, 20)
                else
                    posZ = posZ - Random(5, 20)
                    posX = posX + Random(5, 20)
                end
                if Random(1, 2) == 2 then
                    posZ = posZ + Random(5, 20)
                    posX = posX - Random(5, 20)
                else
                    posZ = posZ - Random(5, 20)
                    posX = posX - Random(5, 20)
                end
                unit = aiBrain:CreateUnitNearSpot(rspawn, posX, posZ)
                if unit == nil then
                    local posX = oldposX
                    local posZ = oldposZ
                    if Random(1, 2) == 2 then
                        posX = posX + Random(5, 20)
                        posZ = posZ + Random(5, 20)
                    else
                        posX = posX - Random(5, 20)
                        posZ = posZ + Random(5, 20)
                    end
                    if Random(1, 2) == 2 then
                        posX = posX + Random(5, 20)
                        posZ = posZ - Random(5, 20)
                    else
                        posX = posX - Random(5, 20)
                        posZ = posZ - Random(5, 20)
                    end
                    if Random(1, 2) == 2 then
                        posZ = posZ + Random(5, 20)
                        posX = posX + Random(5, 20)
                    else
                        posZ = posZ - Random(5, 20)
                        posX = posX + Random(5, 20)
                    end
                    if Random(1, 2) == 2 then
                        posZ = posZ + Random(5, 20)
                        posX = posX - Random(5, 20)
                    else
                        posZ = posZ - Random(5, 20)
                        posX = posX - Random(5, 20)
                    end
                    local terrainAltitude = GetTerrainHeight(posX, posZ)
                    unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
                end
            end
			if aiBrain ~= nil and unit ~= nil then
				aiBrain:AssignUnitsToPlatoon(TransportPlatoon, {unit}, 'Attack', 'NoFormation')
			end	
			if unit and unit ~= nil and not unit.Dead and (HPBonusAI > 0 or ParagonCycle ~= "Off") then
                if GameTime < 0.33 then
					totalIncrease = HealthBonus
					maxhp = unit:GetMaxHealth()
					unit:SetMaxHealth(maxhp + totalIncrease)
				elseif GameTime >= 0.33 and GameTime < 0.66 then
					totalIncrease = HealthBonus * 1.5
					maxhp = unit:GetMaxHealth()
					unit:SetMaxHealth(maxhp + totalIncrease)
				elseif GameTime >= 0.66 and GameTime < 1 then
					totalIncrease = HealthBonus * 2 + Random(1400, 1800) * totalEnemyEndgamers
					maxhp = unit:GetMaxHealth()
					unit:SetMaxHealth(maxhp + totalIncrease)
				elseif GameTime >= 1 then
					totalIncrease = HealthBonus * 3 + Random(1800, 2800) * totalEnemyEndgamers
					maxhp = unit:GetMaxHealth()
					unit:SetMaxHealth(maxhp + totalIncrease)
				end
				hp = unit:GetMaxHealth()
                unit:SetHealth(self, hp)
                unit:SetReclaimable(false)
            end
            if unit and not unit.Dead then
				if DamageBoost ~= 'Off - 0' then
					ModifyWeaponDamageBuffAndRange(unit)
				end	
				unit:SetSpeedMult(1 + waveNum * SpeedBonus + SpeedBonusOnce)
			end
			if KillPlayerUnit > 0 then
				SuicideLandNavyUnit(unit)
			end	
        end
	end)
end
function BoostAIACUHealth()
    local circle = ForkThread(function(self)
        LOG("calling BoostAIACUHealth().")
        local unit = nil
		local aiUnit
        WaitTicks(1)
        if aiBrain ~= nil then
            local unitList = aiBrain:GetListOfUnits(categories.COMMAND + (categories.STRUCTURE * categories.FACTORY) + categories.ENGINEER, false)
			for i, aiUnit in unitList do
				if aiUnit and not aiUnit:BeenDestroyed() then
				aiUnit:Kill()
				end
			end
        end
        WaitTicks(1)
        if aiBrain ~= nil then
            unit = aiBrain:GetListOfUnits(categories.COMMAND, false)[1]
        else
            LOG("aiBrain is nil!.")
        end
        if unit ~= nil then
            unit:Kill()
            --[[local hp = unit:GetMaxHealth()
            unit:SetHealth(self, hp)
            LOG("AI ACU unit HP boosted.")]]--
        end
        if unit == nil then
            unit = aiBrain:GetListOfUnits(categories.COMMAND, false)[0]
            if unit ~= nil then
                unit:Kill()
                --[[local hp = unit:GetMaxHealth()
                unit:SetHealth(self, hp)
                LOG("AI ACU unit HP boosted.")]]--
            end
        end
        KillThread(self)
    end)
end
function Kill2ndSpawnPlayer()
    local circle = ForkThread(function(self)
        local unit = nil
		local aiUnit
        WaitTicks(1)
        if SecBrain ~= nil then
            local unitList = SecBrain:GetListOfUnits(categories.ALLUNITS, false)
			for i, aiUnit in unitList do
				if aiUnit and not aiUnit:BeenDestroyed() then
				aiUnit:Kill()
				end
			end
        else
            LOG("SecBrain is nil!.")
        end
        if unit ~= nil then
			unit = SecBrain:GetListOfUnits(categories.COMMAND, false)[0]
            unit:Kill()
            --[[local hp = unit:GetMaxHealth()
            unit:SetHealth(self, hp)
            LOG("AI ACU unit HP boosted.")]]--
        end
        if unit == nil then
            unit = SecBrain:GetListOfUnits(categories.COMMAND, false)[0]
            if unit ~= nil then
                unit:Kill()
                --[[local hp = unit:GetMaxHealth()
                unit:SetHealth(self, hp)
                LOG("AI ACU unit HP boosted.")]]--
            end
        end
        KillThread(self)
    end)
end
function SuicideAirUnit(unitId)
    local circle = ForkThread(function(self)
	local unit = unitId
	WaitTicks(Random(10, 100))
	WaitSeconds(KillPlayerUnit)
		if unit and not unit.Dead then
			unit:Kill()
		end
	KillThread(self)
    end)
end
function SuicideLandNavyUnit(unitId)
    local circle = ForkThread(function(self)
		local unit = unitId
		WaitTicks(Random(10, 100))
		WaitSeconds(KillNavyLandUnit)
		if unit and not unit.Dead then
			unit:Kill()
		end
		KillThread(self)
    end)
end
function SuicideBoss(unitId)
    local circle = ForkThread(function(self)
		local unit = unitId
		WaitTicks(Random(10, 100))
		WaitSeconds(KillPlayerUnit * 2)
		if unit and not unit.Dead then
			unit:Kill()
		end
		KillThread(self)
    end)
end
GetAIOrHumanEnemyBrain = function(self)
    local AIorHumanEnemyBrain = nil
    local HQandAllyBrains = { HQallyBrains = {} }
    local EnemyBrains = { enemyBrains = {} }
    local allycount = 0
    local enemycount = 0
	local brains
    local allyFlag = nil
	--[[if salvationspawn ~= "Off" then
		for aindex, abrain in ArmyBrains do
			if abrain.Name == "ARMY_" .. salvationspawn then
				SalvationBrain = abrain
			end
		end
	end]]--
	HQPlayerNotSetWarning()
    if AIWavePlayer ~= "Random" then
		for aindex, abrain in ArmyBrains do
			if abrain.Name == "ARMY_" .. AIWavePlayer then
				AIorHumanEnemyBrain = abrain
			end
		end
		if AIorHumanEnemyBrain ~= nil then
			HQSetFlag = true
		end	
		for aindex, abrain in ArmyBrains do
            if not ArmyIsCivilian(abrain:GetArmyIndex()) and not IsAlly(abrain:GetArmyIndex(), AIorHumanEnemyBrain:GetArmyIndex()) and abrain ~= AIorHumanEnemyBrain then
                table.insert(humanBrains.HBrains, abrain)
                table.insert(humanACUs.HACUs, abrain:GetListOfUnits(categories.COMMAND, false)[1])
                hBrains = hBrains + 1
                LOG("Human Brain found.")
            end
        end
		for aindex, abrain in ArmyBrains do
            if not ArmyIsCivilian(abrain:GetArmyIndex()) and IsAlly(abrain:GetArmyIndex(), AIorHumanEnemyBrain:GetArmyIndex()) and abrain ~= AIorHumanEnemyBrain then
                table.insert(allyBrainsHQ.ABrainsHQ, abrain)
                table.insert(allyHQACU.AllyACUs, abrain:GetListOfUnits(categories.COMMAND, false)[1])
                aBrainsHQ = aBrainsHQ + 1
                LOG("HQ Ally Brain found.")
            end
        end
	end	
	if AIWavePlayer == "Random" then
		for aindex, abrain in ArmyBrains do
			if not ArmyIsCivilian(abrain:GetArmyIndex()) then
				if aindex > 1 then
					if IsAlly(abrain:GetArmyIndex(), allyFlag:GetArmyIndex()) then
						table.insert(allyBrainsHQ.ABrainsHQ, abrain)
						aBrainsHQ = aBrainsHQ + 1
					else
						table.insert(EnemyBrains.enemyBrains, abrain)
						enemycount = enemycount + 1
					end
				else
					allyFlag = abrain
					aBrainsHQ = aBrainsHQ + 1
					table.insert(allyBrainsHQ.ABrainsHQ, allyFlag)
				end
			end
		end
		if aBrainsHQ > enemycount then
			AIorHumanEnemyBrain = (EnemyBrains.enemyBrains)[Random(1, enemycount)]
			for aindex, abrain in allyBrainsHQ.ABrainsHQ do
				if not ArmyIsCivilian(abrain:GetArmyIndex()) then
					table.insert(humanBrains.HBrains, abrain)
					table.insert(humanACUs.HACUs, abrain:GetListOfUnits(categories.COMMAND, false)[1])
					hBrains = hBrains + 1
					LOG("Human Brain found.")
				end
			end
		elseif aBrainsHQ < enemycount then
			AIorHumanEnemyBrain = (allyBrainsHQ.ABrainsHQ)[Random(1, aBrainsHQ)]
			for aindex, abrain in EnemyBrains.enemyBrains do
				if not ArmyIsCivilian(abrain:GetArmyIndex()) then
					table.insert(humanBrains.HBrains, abrain)
					table.insert(humanACUs.HACUs, abrain:GetListOfUnits(categories.COMMAND, false)[1])
					hBrains = hBrains + 1
					LOG("Human Brain found.")
				end
			end
		end
		if aBrainsHQ == enemycount then
			local AIinEnemyBrain = false
			for aindex, abrain in EnemyBrains.enemyBrains do
				if not ArmyIsCivilian(abrain:GetArmyIndex()) and aiBrain.BrainType ~= "Human" then
					AIinEnemyBrain = true
					break
				end
			end
			if AIinEnemyBrain == false then
				LOG("AI not found in enemy brains, pick AI from allyBrains")
				AIorHumanEnemyBrain = (allyBrainsHQ.ABrainsHQ)[Random(1, aBrainsHQ)]
				for aindex, enemybrain in EnemyBrains.enemyBrains do
					if not ArmyIsCivilian(enemybrain:GetArmyIndex()) then
						table.insert(humanBrains.HBrains, enemybrain)
						table.insert(humanACUs.HACUs, enemybrain:GetListOfUnits(categories.COMMAND, false)[1])
						hBrains = hBrains + 1
						LOG("Human Brain found.")
					end
				end
			else
				LOG("AI  found in enemy brains, pick AI from enemyBrains")
				AIorHumanEnemyBrain = (EnemyBrains.enemyBrains)[Random(1, enemycount)]
				for aindex, allybrain in allyBrainsHQ.ABrainsHQ do
					if not ArmyIsCivilian(allybrain:GetArmyIndex()) then
						table.insert(humanBrains.HBrains, allybrain)
						table.insert(humanACUs.HACUs, allybrain:GetListOfUnits(categories.COMMAND, false)[1])
						hBrains = hBrains + 1
						LOG("Human Brain found.")
					end
				end
			end
		end
    end
	SecondSpawn()
	SalvationPlayerFind()
	AlternateHQSpawn()
	Alternate2ndSpawn()
    PreparePathFindingAlgorithm()
    return AIorHumanEnemyBrain
end
function HQPlayerNotSetWarning()
	local circle = ForkThread(function(self)
	WaitSeconds(5)
	if AIWavePlayer ~= "Random" and HQSetFlag == false then
		PrintText("==ERROR: HQ Player not Set. Make sure correct Player Slot is set in Map Options.==", 28, 'ffCC0000', 300, 'center')
		PrintText("--Check AI Wave Survival Picture Guide on FAF Forums for Setup Help--", 28, 'ffCC0000', 300, 'center')
		PrintText("https://forum.faforever.com/topic/5563/ai-wave-survival-mod-information", 28, 'ffCC0000', 300, 'center')
	end
	KillThread(self)
    end)
end
function SalvationPlayerFind()
    local circle = ForkThread(function(self)
        if salvationspawn ~= "Off" and salvationspawn ~= "Half of Team" then
			if salvationspawn ~= "Random" then
				for aindex, abrain in ArmyBrains do
					if abrain.Name == "ARMY_" .. salvationspawn then
						SalvationBrain = abrain
					end
				end	
			else	
				brains = table.getn(humanBrains.HBrains)
				SalvationBrain = (humanBrains.HBrains)[Random(1, brains)]
			end
			if SalvationBrain ~= nil then
				SalvationCheck = true
				WaitSeconds(15)
				sender = SalvationBrain.Nickname
				PrintText("== Salvation Player is " .. sender .. " ==", 28, 'ff6FA8DC', 8, 'center')
				PrintText("Suicide/Death of Player's ACU Destroys Wave!", 24, 'ff6FA8DC', 8, 'center')
			end	
		end
		if salvationspawn == "Half of Team" then
			WaitSeconds(15)
			PrintText("== Team Salvation is ON ==", 28, 'ff6FA8DC', 8, 'center')
			PrintText("Losing too many Commanders triggers Salvation!", 24, 'ff6FA8DC', 8, 'center')
		end	
        KillThread(self)
    end)
end
function AlternateHQSpawn()
    local circle = ForkThread(function(self)
        if AltHQSpawn ~= "Off" then
			for aindex, abrain in ArmyBrains do
				if abrain.Name == "ARMY_" .. AltHQSpawn then
					AltHQBrain = abrain
				end
			end	
			if AltHQBrain ~= nil then
				AltHQCheck = true
				WaitSeconds(3)
				--PrintText("== Salvation Player is " .. sender .. " ==", 28, 'ff6FA8DC', 8, 'center')
				--PrintText("Alternative HQ Spawn Correctly Configured.", 24, 'ff6FA8DC', 8, 'center')
			end	
		end
        KillThread(self)
    end)
end
function Alternate2ndSpawn()
    local circle = ForkThread(function(self)
        if Alt2ndSpawn ~= "Off" and secondaryspawn ~= "Off" then
			for aindex, abrain in ArmyBrains do
				if abrain.Name == "ARMY_" .. Alt2ndSpawn then
					Alt2ndBrain = abrain
				end
			end	
			if Alt2ndBrain ~= nil then
				Alt2ndCheck = true
				WaitSeconds(3)
				--PrintText("== Salvation Player is " .. sender .. " ==", 28, 'ff6FA8DC', 8, 'center')
				--PrintText("Alternative 2nd Spawn Correctly Configured.", 24, 'ff6FA8DC', 8, 'center')
			end	
		end
        KillThread(self)
    end)
end
function SecondSpawn()
    local circle = ForkThread(function(self)
        if secondaryspawn ~= "Off" then
			for aindex, abrain in ArmyBrains do
				if abrain.Name == "ARMY_" .. secondaryspawn then
					SecBrain = abrain
				end
			end
			if SecBrain ~= nil then
				SecondSpawnCheck = true
				WaitSeconds(2)
				--PrintText("== Salvation Player is " .. sender .. " ==", 28, 'ff6FA8DC', 8, 'center')
				--PrintText("==2nd Spawn is Enabled==", 28, 'ffE69138', 10, 'center')
			end	
		end
        KillThread(self)
    end)
end
function PreparePathFindingAlgorithm()
    local circle = ForkThread(function(self)
        table.insert(closestEnemyBrains.CBrains, GetClosestEnemyBrainLand(aiBrain))
        LOG("closestEnemyBrains.CBrains length is " .. (table.getn(closestEnemyBrains.CBrains)))
        LOG("humanBrains.HBrains length is " .. (table.getn(humanBrains.HBrains)))
        WaitTicks(5)
        for i, brain in humanBrains.HBrains do
            if brain and not table.find(closestEnemyBrains.CBrains, brain) then
                local closeBrain = GetClosestAlliedBrain(self, brain)
                if closeBrain and not table.find(closestEnemyBrains.CBrains, closeBrain) then
                    table.insert(closestEnemyBrains.CBrains, closeBrain)
                else
                    table.insert(closestEnemyBrains.CBrains, brain)
                end
            end
        end
        KillThread(self)
    end)
end
function InitSurvival()
	PrintText("AI Wave Survival Mod setup guide on FAForever Forums at", 28, 'ff004eff', 15, 'center')
	PrintText("forum.faforever.com/topic/5563/ai-wave-survival-mod-information", 28, 'ff004eff', 15, 'center')
	PrintText("Set HQ Player and other Spawn Players in MAP OPTIONS:", 28, 'ffCBFFFF', 15, 'center')
	PrintText("Under HQ SETTINGS and 2ND SPAWN SETTINGS", 28, 'ffCBFFFF', 15, 'center')
	PrintText("Set up to 4 Spawn Points: HQ, 2nd Spawn, Alt HQ, and Alt 2nd Spawn.", 28, 'ffCBFFFF', 15, 'center')
    WaitTicks(40)
	--[[for aindex, abrain in ArmyBrains do
		 if abrain.BrainType ~= "Human" and  not ArmyIsCivilian(abrain:GetArmyIndex())  then
		aiBrain = abrain
			LOG("aiBrain found, Army index : " ..abrain:GetArmyIndex())
			break
			 end
		end
	for aindex, abrain in ArmyBrains do
		 if abrain.BrainType == "Human" and not ArmyIsCivilian(abrain:GetArmyIndex()) then
		 table.insert(humanBrains.HBrains, abrain)
		 table.insert(humanACUs.HACUs, abrain:GetListOfUnits(categories.COMMAND, false)[1])
		 hBrains = hBrains + 1
		 LOG("Human Brain found.")
		 end
	end]]--
	AIWavePlayer = tostring(ScenarioInfo.Options.AIWavePlayer)
	secondaryspawn = tostring(ScenarioInfo.Options.secondaryspawn)
	salvationspawn = tostring(ScenarioInfo.Options.salvationspawn)
	AltHQSpawn = tostring(ScenarioInfo.Options.AltHQSpawn)
	Alt2ndSpawn = tostring(ScenarioInfo.Options.Alt2ndSpawn)
	
	--PrintText("Players can be set to suicide ACU's under 'HQ/2ndSpawn Base Building On/Off'.", 24, 'ffCC0000', 10, 'center')
    
	aiBrain = GetAIOrHumanEnemyBrain()
	SetIgnoreArmyUnitCap(aiBrain:GetArmyIndex(), true)
	
	WaitTicks(10)
    LOG("Calling  STRfour")
    MinorBossSpawns = tostring(ScenarioInfo.Options.MinorBossSpawns)
	ExperimentalSpawns = tostring(ScenarioInfo.Options.ExperimentalSpawns)
	UEFWaves = tostring(ScenarioInfo.Options.UEFWaves)
	CybranWaves = tostring(ScenarioInfo.Options.CybranWaves)
	AeonWaves = tostring(ScenarioInfo.Options.AeonWaves)
	SeraphimWaves = tostring(ScenarioInfo.Options.SeraphimWaves)
	NomadWaves = tostring(ScenarioInfo.Options.NomadWaves)
	ASFWaves = tostring(ScenarioInfo.Options.ASFWaves)
	LandAmphibious = tostring(ScenarioInfo.Options.LandAmphibious)
	TotalMayhemWaves = tostring(ScenarioInfo.Options.TotalMayhemWaves)
	
    WaitTicks(22)
	humans = table.getn(humanBrains.HBrains)
	if humans < 1 then
		humans = 1
	end
	HPBonusAI = tonumber(ScenarioInfo.Options.HPBonusAI)
    --DmgBonus = tonumber(ScenarioInfo.Options.DmgBonus)
	WaveStyle = tostring(ScenarioInfo.Options.WaveStyle)
	DelayUntilNextWaveAI = (tonumber(ScenarioInfo.Options.DelayUntilNextWaveAI) * 60)
    WavesStartTimeAI = (tonumber(ScenarioInfo.Options.WavesStartTimeAI) * 60)
    MainBuildingHPAI = (tonumber(ScenarioInfo.Options.MainBuildingHPAI) * 1000000)
	SecSpawnBuildingHP = (tonumber(ScenarioInfo.Options.SecSpawnBuildingHP) * 1000000)
    HoldTimeAI = (tonumber(ScenarioInfo.Options.HoldTimeAI) * 60)
	GameBreak = tonumber(ScenarioInfo.Options.GameBreak) * 60
    LandPerWave = tonumber(ScenarioInfo.Options.LandPerWave) * humans
    HivesPerPlayerAI = tonumber(ScenarioInfo.Options.HivesPerPlayerAI)
    NukeStrikeEveryAI = tostring(ScenarioInfo.Options.NukeStrikeEveryAI)
	NukeIncreasePerStrike = tonumber(ScenarioInfo.Options.NukeIncreasePerStrike)
    NukesPerStrikeAI = tostring(ScenarioInfo.Options.NukesPerStrikeAI)
	SpeedBonus = tonumber(ScenarioInfo.Options.SpeedBonus)
	SpeedBonusOnce = tonumber(ScenarioInfo.Options.SpeedBonusOnce)
	HQMass = tonumber(ScenarioInfo.Options.HQMass)
	HQEnergy = tonumber(ScenarioInfo.Options.HQEnergy)
	NukesOn = tostring(ScenarioInfo.Options.NukesOn)
	--NukesTypesOn = tostring(ScenarioInfo.Options.NukesOn)
	--PlayerLevel = tostring(ScenarioInfo.Options.PlayerLevel)
	WaveProgressionData = tostring(ScenarioInfo.Options.WaveProgressionData)
	ArtyOn = tostring(ScenarioInfo.Options.ArtyOn)
	ArtySpawnTime = (tonumber(ScenarioInfo.Options.ArtySpawnTime) * 60)
	ArtyType = tostring(ScenarioInfo.Options.ArtyType)
	Endless = tostring(ScenarioInfo.Options.Endless)
	EndWaveMulti = tonumber(ScenarioInfo.Options.EndWaveMulti)
	EndWaveAir = tonumber(ScenarioInfo.Options.EndWaveAir)
	AirPerWave = tonumber(ScenarioInfo.Options.AirPerWave) * humans
	HumanEcoBoost = tonumber(ScenarioInfo.Options.HumanEcoBoost)
	EndGameEcoBoost = tonumber(ScenarioInfo.Options.EndGameEcoBoost)
	HQAllyEcoBoost = tonumber(ScenarioInfo.Options.HQAllyEcoBoost)
	NavyPerWave = tonumber(ScenarioInfo.Options.NavyPerWave) * humans
	NavyTime = (tonumber(ScenarioInfo.Options.NavyTime) * DelayUntilNextWaveAI)
	AirTime = (tonumber(ScenarioInfo.Options.AirTime) * DelayUntilNextWaveAI)
	BossWaveEndlessSpawn = tostring(ScenarioInfo.Options.BossWaveEndlessSpawn)
	SecondaryBuildingFlag = tostring(ScenarioInfo.Options.SecondaryBuildingFlag)
	SpawnAlliesForceFlag = tostring(ScenarioInfo.Options.SpawnAlliesForceFlag)
	NuclearOverwhelm = tostring(ScenarioInfo.Options.NuclearOverwhelm)
	JumpTech2 = tostring(ScenarioInfo.Options.JumpTech2)
	ExpMulti = (tonumber(ScenarioInfo.Options.ExpMulti) * .01)
	AirExpMulti = (tonumber(ScenarioInfo.Options.AirExpMulti) * .01)
	NavyExpMulti = (tonumber(ScenarioInfo.Options.NavyExpMulti) * .01)
	ExtraWaveDelay = (tonumber(ScenarioInfo.Options.ExtraWaveDelay) * 60)
	EndGameHoldTime = tostring(ScenarioInfo.Options.EndGameHoldTime)
	TorpBomberStartTime = (tonumber(ScenarioInfo.Options.TorpBomberStartTime) * 60)
	KillAIBase = tostring(ScenarioInfo.Options.KillAIBase)
	CrazyModeLand = tostring(ScenarioInfo.Options.CrazyModeLand)
	CrazyModeAir = tostring(ScenarioInfo.Options.CrazyModeAir)
	CrazyModeNavy = tostring(ScenarioInfo.Options.CrazyModeNavy)
	EndEcoBoostTime = (tonumber(ScenarioInfo.Options.EndEcoBoostTime) * 60)
	NukeTime = tonumber(ScenarioInfo.Options.NukeTime)
	ParagonCycle = tostring(ScenarioInfo.Options.ParagonCycle)
	ParagonNuke = tostring(ScenarioInfo.Options.ParagonNuke)
	ArtyYolo = tostring(ScenarioInfo.Options.ArtyYolo)
	EndGameParagon = tostring(ScenarioInfo.Options.EndGameParagon)
	EndGameYolo = tostring(ScenarioInfo.Options.EndGameYolo)
	KillPlayerUnit = (tonumber(ScenarioInfo.Options.KillPlayerUnit) * 60)
	KillNavyLandUnit = (tonumber(ScenarioInfo.Options.KillPlayerUnit) * 90)
	HQDefenses = tostring(ScenarioInfo.Options.HQDefenses)
	HQDefensesPD = tostring(ScenarioInfo.Options.HQDefensesPD)
	SecSpawnDefences = tostring(ScenarioInfo.Options.SecSpawnDefences)
	SecSpawnPD = tostring(ScenarioInfo.Options.SecSpawnPD)
	KillAllNonHQPlayers = tostring(ScenarioInfo.Options.KillAllNonHQPlayers)
	KillHQPlayerAllies = tostring(ScenarioInfo.Options.KillHQPlayerAllies)
	HoldTimeAI = HoldTimeAI + GameBreak
	AlliedForceMultiplier = tonumber(ScenarioInfo.Options.AlliedForceMultiplier)
	PowerStallTime = (tonumber(ScenarioInfo.Options.PowerStallTime) * 60)
	WaveSizeMultiLand = tostring(ScenarioInfo.Options.WaveSizeMultiLand)
	WaveSizeMultiAir = tostring(ScenarioInfo.Options.WaveSizeMultiAir)
	WaveSizeMultiNaval = tostring(ScenarioInfo.Options.WaveSizeMultiNaval)
	permanentwaveloss = tonumber(ScenarioInfo.Options.permanentwaveloss)
	permanentwavelossair = tonumber(ScenarioInfo.Options.permanentwavelossair)
	permanentwavelossnavy = tonumber(ScenarioInfo.Options.permanentwavelossnavy)
	spawnrateland = tonumber(ScenarioInfo.Options.spawnrateland)
	spawnrateair = tonumber(ScenarioInfo.Options.spawnrateair)
	spawnratenavy = tonumber(ScenarioInfo.Options.spawnratenavy)
	VersesSurvival = tostring(ScenarioInfo.Options.VersesSurvival)
	NomanderSpawn = tostring(ScenarioInfo.Options.NomanderSpawn)
	SpecialWeapons = tostring(ScenarioInfo.Options.SpecialWeapons)
	ArtyNukeEnable = tostring(ScenarioInfo.Options.ArtyNukeEnable)
	DamageBoost = tostring(ScenarioInfo.Options.DamageBoost)
	ACUHunterTime = tostring(ScenarioInfo.Options.ACUHunterTime)
	ACUHunterTimeNumber = tonumber(ScenarioInfo.Options.ACUHunterTime)
	ACUHunterSize = tonumber(ScenarioInfo.Options.ACUHunterSize)
	DoomCount = tostring(ScenarioInfo.Options.DoomCount)
	DoomDamageHQ = tonumber(ScenarioInfo.Options.DoomDamageHQ) * 0.01
	DoomIncrease = tonumber(ScenarioInfo.Options.DoomIncrease)
	DoomBoostHP = tonumber(ScenarioInfo.Options.DoomBoostHP) * 0.01
	DoomCrawlers = tostring(ScenarioInfo.Options.DoomCrawlers)
	DoomWalkers = tostring(ScenarioInfo.Options.DoomWalkers)
	DoomMinimum = tonumber(ScenarioInfo.Options.DoomMinimum)
	DoomMaximum = tostring(ScenarioInfo.Options.DoomMaximum)
	salvationBOOM = tostring(ScenarioInfo.Options.salvationBOOM)
	DoomStorm = tostring(ScenarioInfo.Options.DoomStorm)
	DoomStormMulti = tonumber(ScenarioInfo.Options.DoomStorm)
	ExtraASFEnabled = tostring(ScenarioInfo.Options.ExtraASFEnabled)
	TransportFrequency = tostring(ScenarioInfo.Options.TransportFrequency)
	InitialTransports = tonumber(ScenarioInfo.Options.InitialTransports)
	TransportMultiplier = tostring(ScenarioInfo.Options.TransportMultiplier)
	TransportsToStartTime = tonumber(ScenarioInfo.Options.TransportsToStartTime)
	TransportEndTime = tostring(ScenarioInfo.Options.TransportEndTime)
	TransportUnits = tostring(ScenarioInfo.Options.TransportUnits)
	TransportExpChance = tostring(ScenarioInfo.Options.TransportExpChance)
	TranSpawnLocation = tostring(ScenarioInfo.Options.TranSpawnLocation)
	RamboChance = tostring(ScenarioInfo.Options.RamboChance)
	Alt2ndHealth = tostring(ScenarioInfo.Options.Alt2ndHealth)
	AltHQHealth = tostring(ScenarioInfo.Options.AltHQHealth)
	TotalMayhemLand = tonumber(ScenarioInfo.Options.TotalMayhemLand) * 0.1
	TotalMayhemAir = tonumber(ScenarioInfo.Options.TotalMayhemAir) * 0.1
	TotalMayhemNavy = tonumber(ScenarioInfo.Options.TotalMayhemNavy) * 0.1
	SupportBaseMulti = tonumber(ScenarioInfo.Options.SupportBaseMulti)
	SupportBaseNukes = tostring(ScenarioInfo.Options.SupportBaseNukes)
	HQAllyRestrict = tostring(ScenarioInfo.Options.HQAllyRestrict)
	RiftUnits = tostring(ScenarioInfo.Options.RiftUnits)
	AmphibiousCheck = tostring(ScenarioInfo.Options.AmphibiousCheck)
	
	
	
	
	--transports
	if TransportFrequency ~= "Off" then
		if TransportEndTime == "Endless --" then
			TransportEndTime = 334
		else
			TransportEndTime = tonumber(ScenarioInfo.Options.TransportEndTime)
		end	
		TransportWaveFrequency()
		TransportMonitor()
		if TransportMultiplier ~= "No" then
			WaveSizeMultiForTransports()
		end
		if TransportExpChance ~= "Off --" then
			TransportExpChance = tonumber(ScenarioInfo.Options.TransportExpChance) * 0.1
		end	
	end
	if TransportUnits ~= "All Units" then
		CreateTransportTables()
	end
	
	SelectHQDefenses()
	Select2ndSpawnDefenses()
	
	if EndGameHoldTime ~= "Off --" then
		EndGameHoldTime = (tonumber(ScenarioInfo.Options.EndGameHoldTime) * 60)
		EndGameCondition = true
		EndGameTime = EndGameHoldTime / 60
		PrintText("=Survive for " .. EndGameTime .. " Minutes after FINAL STAGE to Win!=", 28, 'ff8afbfb', 6, 'center')
		if TorpBomberStartTime > 0 then --Spawns Torp Bombers if Hold to Win is on and ACU's hiding in water
			ACUTorpHunters()
		end	
	else
		EndGameHoldTime = 0
	end
	if DoomMaximum ~= "Off --" then
		DoomMaximum = tonumber(ScenarioInfo.Options.DoomMaximum)
	end	
	if ArtyType == "Mavor" then
		ArtyType = "UEB2401"
		elseif ArtyType == "RapidFire" then
		ArtyType = "XAB2307"
		elseif ArtyType == "Scathis" then
		ArtyType = "URL0401"
		elseif ArtyType == "Duke" then
		ArtyType = "UEB2302"
		elseif ArtyType == "Emissary" then
		ArtyType = "UAB2302"
		elseif ArtyType == "Disruptor" then
		ArtyType = "URB2302"
		elseif ArtyType == "Hovatham" then
		ArtyType = "XSB2302"
		elseif ArtyType == "Guardian (T3 DPS, T4 Range)" then
		ArtyType = "ARU2401"
	end
	if NuclearOverwhelm == "1 per 5 Mins" then
		NuclearOverwhelm = 0.4
		elseif NuclearOverwhelm == "1 per 4 Mins" then
		NuclearOverwhelm = 0.5
		elseif NuclearOverwhelm == "1 per 3 Mins" then
		NuclearOverwhelm = 0.67
		elseif NuclearOverwhelm == "1 per 2 Mins" then
		NuclearOverwhelm = 1
		elseif NuclearOverwhelm == "1 per Min" then
		NuclearOverwhelm = 2
		elseif NuclearOverwhelm == "2 per Min" then
		NuclearOverwhelm = 4
		elseif NuclearOverwhelm == "3 per Min" then
		NuclearOverwhelm = 6
		elseif NuclearOverwhelm == "Off" then
		NuclearOverwhelm = 0
	end
	NuclearStrikeFrequency()
	--[[if NukeStrikeEveryAI == '5 to 6 Mins' then
		NukeStrikeEveryAI = 0
		elseif NukeStrikeEveryAI == '5.5 to 7 Mins' then
		NukeStrikeEveryAI = 60
		elseif NukeStrikeEveryAI == '6 to 8 Mins' then
		NukeStrikeEveryAI = 120
		elseif NukeStrikeEveryAI == '6.5 to 9 Mins' then
		NukeStrikeEveryAI = 180
		elseif NukeStrikeEveryAI == '7 to 10 Mins' then
		NukeStrikeEveryAI = 240
		elseif NukeStrikeEveryAI == '7.5 to 11 Mins' then
		NukeStrikeEveryAI = 300
		elseif NukeStrikeEveryAI == '8 to 12 Mins' then
		NukeStrikeEveryAI = 360
		elseif NukeStrikeEveryAI == '8.5 to 13 Mins' then
		NukeStrikeEveryAI = 420
		elseif NukeStrikeEveryAI == '9 to 14 Mins' then
		NukeStrikeEveryAI = 480
	end]]--
	if NukesPerStrikeAI == 'Fewest' then
		NukesPerStrikeAI = 1
		elseif NukesPerStrikeAI == 'Few' then
		NukesPerStrikeAI = 2
		elseif NukesPerStrikeAI == 'Regular' then
		NukesPerStrikeAI = 3
		elseif NukesPerStrikeAI == 'More' then
		NukesPerStrikeAI = 4
		elseif NukesPerStrikeAI == 'Most' then
		NukesPerStrikeAI = 5
	end
    if aiBrain ~= nil then
        if aiBrain.BrainType ~= "Human" then
            isAIBrain = true
            --ControlDifficultyByAiPersonality()
        else
            isAIBrain = false
        end
    end
	WaitTicks(20)
	if AmphibiousCheck == 'Enabled' then	
		CheckIfLandCanPass()
	end	
    WaitTicks(50)
	if TotalMayhemWaves == "Not Adjustable - Totally Random!" then
		STRfour()
	else
		TablesForTotalMayhemMods()
	end
	
	if secondaryspawn ~= "Off" and SecondSpawnCheck == false then
		PrintText("==ERROR: 2nd Spawn not Set. Make sure correct Player Slot is set in Map Options.==", 28, 'ffCC0000', 30, 'center')
		ErrorMessage = true
	end
	if salvationspawn ~= "Off" and SalvationCheck == false and salvationspawn ~= "Half of Team" then
		PrintText("==ERROR: Salvation Player Not Set. Make sure correct Player Slot is set in Map Options.==", 28, 'ffCC0000', 30, 'center')	
	end
	if AltHQSpawn ~= "Off" and AltHQCheck == false then
		PrintText("==ERROR: Alternative HQ Spawn not Set. Make sure correct Player Slot is set in Map Options.==", 28, 'ffCC0000', 30, 'center')
		ErrorMessage = true		
	end
	if Alt2ndSpawn ~= "Off" and secondaryspawn ~= "Off" and Alt2ndCheck == false then
		PrintText("==ERROR: Alternative 2nd Spawn not Set. Make sure correct Player Slot is set in Map Options.==", 28, 'ffCC0000', 30, 'center')
		ErrorMessage = true
	end
	
	if aBrainsHQ > 0 and AIWavePlayer ~= "Random" then 
		if SecondSpawnCheck == true or AltHQCheck == true then
			--Do nothing
		elseif ErrorMessage == false then
			PrintText("==NOTICE: HQ Allies Detected. Set Allies as optional Spawn points in MAP OPTIONS==", 28, 'ffffa548', 20, 'center')
			PrintText("--Check Map Options under HQ SETTINGS or 2ND SPAWN SETTINGS to set Spawns--", 28, 'ffffa548', 20, 'center')
		end
	end	
	
    CreateMainAIBuilding()
	if secondaryspawn ~= "Off" then	
		CreateSecondarySpawnBuilding()
	end	
	if AltHQSpawn ~= "Off" then
		if AltHQHealth ~= "Invulnerable --" then
			AltHQHealth = tonumber(ScenarioInfo.Options.AltHQHealth) * 1000000
		end	
		CreateHQAltSpawnBuilding()
	end	
	if Alt2ndSpawn ~= "Off" and secondaryspawn ~= "Off" then
		if Alt2ndHealth ~= "Invulnerable --" then
			Alt2ndHealth = tonumber(ScenarioInfo.Options.Alt2ndHealth) * 1000000
		end	
		Create2ndAltSpawnBuilding()
	end	
    LOG("sa: Continue to wave spawn check loop.")
	if WaveSizeMultiLand ~= "No" then	
		WaveSizeMultiForLand()
	end
	if WaveSizeMultiAir ~= "No" then	
		WaveSizeMultiForAir()
	end
	if WaveSizeMultiNaval ~= "No" then	
		WaveSizeMultiForNaval()
	end	
	if WaveProgressionData ~= "Normal" then
		WaveProgressionRate()
	end
    MonitoringFunction() --Waves and Endgame Conditions
	MonitoringFunctionTwo() --Weapon Restrictions
	MonitoringFunctionThree() --Enemy Count Scripts
	MonitoringFunctionFour() --Paragon Count
	CheckMainGoal() --Monitors HQ
	if RiftUnits ~= "Off --" then --Rift Orb Scripts
		RiftUnits = tonumber(ScenarioInfo.Options.RiftUnits) 
		CreateRiftSpawnPoints()
		CreateRiftTables()
		MonitorRiftBuildingCount()
		DetectAndSpawnOrbRiftWaves()
	end	
	if HumanEcoBoost > 0 or EndGameEcoBoost > 0 then
		MonitoringFunctionHQEnemyEcoBoosts()
	end	
	if DamageBoost ~= 'Off - 0' then --damage boost
		DamageBoostMulti = tonumber(ScenarioInfo.Options.DamageBoost)
		MonitoringFunctionFive() 
	end	
	if DoomCount ~= 'Off --' then
		DoomCount = tonumber(ScenarioInfo.Options.DoomCount)
		FillDoomTable()
	end	
	if ExtraASFEnabled ~= 'Off --' then
		ExtraASFEnabled = tonumber(ScenarioInfo.Options.ExtraASFEnabled)
	end	
	MonitoringFunctionSix()
	if NomanderSpawn ~= "Off 0" then	
		DeployAntiAir()
	end	
    MonitoringAiNukeFunction()
	if ArtyYolo == "Yolona Response On" or ArtyYolo == "Yolona+Arty Response On" then
		YolonaResponse()
	end
	if ArtyYolo == "Artillery Response On" or ArtyYolo == "Yolona+Arty Response On" then
		ArtilleryResponse()
	end	
    --MonitoringAiNukeSubmarinesFunction()
    --MonitoringEnemyExpAirFunction()
    --MonitoringEnemyExpNavalFunction()
    --MonitoringEnemyExpArtyFunction()
    --MonitoringEnemyExpDefencesFunction()
    --MonitoringEnemyT3DefencesFunction()
    MonitoringNearbyEnemyUnitsFunction() --Defensive Nukes
	MonitoringNearbyEnemyUnitsFunctionTwo() --Defensive Nukes Two
    --MonitoringAIExpArtyFunction()
    MonitoringStationAssistPodsCount() --Engy Stations Count Limit Monitor
	if salvationspawn ~= "Off" then
		MonitoringSalvationPlayer()
	end
	if KillAllNonHQPlayers == "Supremacy Defeat" then	
		MonitoringPlayerUnits()
	end
	if KillAllNonHQPlayers == "Assassinate Defeat" then	
		MonitoringPlayerUnitsAssassinate()
	end
	if KillHQPlayerAllies == "HQ Allies Assassinate Defeat" then	
		MonitoringHQAlliesAssassinate()
	end
	if KillHQPlayerAllies == "HQ Allies Supremacy Defeat" then	
		MonitoringHQAlliesSupremecy()
	end
	if VersesSurvival == 'Versus Survival On' then	
		MonitoringTeamElimination()
	end
	--Support Bases
	MonitoringAISecondaryBuildings()
	MonitoringAISecondaryBuildingsDefenses()
	
	if ACUHunterTime ~= 'Off --' then --Spawns the ACU Hunter Bot Waves
		ACUHunterSpawn()	
	end	
    --AIMainBuildingRespondMinotoring()
    CheckForOtherParagonsIds()
	if NavyPerWave > 0 then	
		ValidWaterPositionsMonitoring()
		if secondaryspawn ~= "Off" and spawnratenavy > 0 then
			ValidWaterPositionsMonitoring2ndSpawn()
		end	
	end	
    --NavalUnitsSpawnMonitoring()
	--MonitoringPlayersACU()
	--BoostAIACUHealth()
	if (KillAIBase == "BaseBuilding On" or KillAIBase == "HQ Only BaseBuilding") and isAIBrain then --Spawns Engy Stations for AI if BaseBuilding On
		EngiStationsForAI()
	end	
	for i, Army in ListArmies() do
		if EndGameParagon == "Paragon Disabled" or EndGameParagon == "Paragon Midgame" then
			AddBuildRestriction(Army, categories.xab1401) --para
		end
		if EndGameYolo == "Yolona Disabled" or EndGameYolo == "Yolona Midgame" then
			AddBuildRestriction(Army, categories.xsb2401)    --yolona
		end	
	end
	for i, Army in ListArmies() do
		AddBuildRestriction(Army, categories.raa2304) --Exp AA
		AddBuildRestriction(Army, categories.ram2108)    --tac
	end
	for i, Army in ListArmies() do
		AddBuildRestriction(Army, categories.ueb5101) --walls
		AddBuildRestriction(Army, categories.urb5101)
		AddBuildRestriction(Army, categories.uab5101)
		AddBuildRestriction(Army, categories.xsb5101)
	end
	if ArtyNukeEnable ~= "No Restrictions (Buildable Arty/Nukes/Sat)" then --arty/nukes
		if ArtyNukeEnable ~= "Buildable Arty/Nukes/Sat Disabled" then
			HoldTimeForArtyNuke()
		end	
		DisableArtilleryNukes()
		DisableNomadsArtyNuke()
	end	
	DisableBlackOpsArtemis()
	DisableBrewLANWalls()
	if HQAllyRestrict == "HQ Allies No T4 Weapons" or  HQAllyRestrict == "HQ Allies All Restricted" then
		DisableWeaponsHQAllies()
	end	
	if HQAllyRestrict == "HQ Allies No FABs/RAS" or  HQAllyRestrict == "HQ Allies All Restricted" then
		DisableFabsHQAllies()
		DisableFabsHQAlliesNomands()
	end	
	if RamboChance ~= "Off --" then
		RamboChance = tonumber(ScenarioInfo.Options.RamboChance) * 0.1
		--table.insert(RamboTransTable, 'UAL0301_RAMBO')
		table.insert(RamboTransTable, 'UEL0301_RAMBO')
		table.insert(RamboTransTable, 'URL0301_RAMBO')
		table.insert(RamboTransTable, 'XSL0301_RAMBO')
	end	

    repeat
        if GetGameTimeSeconds() < WavesStartTimeAI then
			WaitSeconds(WavesStartTimeAI)
		end
		if ParaYoloFlag == false then
			--EarlyParagonsWillSpeedDifficultyInitialWarning()
			local timeInMin = (HoldTimeAI / 60 * 0.7)
			if EndGameYolo == "Yolona Midgame" and EndGameParagon == "Paragon Midgame" then
					PrintText("Paragons and Yolonas available in " .. timeInMin .. " minutes.", 30, 'ffCBFFFF', 4, 'center')
				elseif EndGameYolo == "Yolona Midgame" then
					PrintText("Yolona available in " .. timeInMin .. " minutes", 30, 'ffCBFFFF', 4, 'center')
				elseif EndGameParagon == "Paragon Midgame" then
					PrintText("Paragon available in " .. timeInMin .. " minutes", 30, 'ffCBFFFF', 4, 'center')
			end
			if NukesOn == "All On" or NukesOn == "Offensive" then
				NukeWaveWarning()
			end	
			ParaYoloFlag = true
		end
		WaitTicks(10)
		
		totalEnemyEndgamers = totalEnemyParagons + totalEnemyYolonas
		HealthBonus = HPBonusAI * (GetGameTimeSeconds() - WavesStartTimeAI)
        if (GetGameTimeSeconds() > WavesStartTimeAI and GetGameTimeSeconds() < (HoldTimeAI + WavesStartTimeAI)) or (Endless ~= "Off" and GetGameTimeSeconds() > WavesStartTimeAI) then
			
			GameTime = math.floor(GetGameTimeSeconds() - WavesStartTimeAI) / HoldTimeAI
			GameTimeNavy = math.floor(GetGameTimeSeconds() - WavesStartTimeAI - NavyTime) / HoldTimeAI
			GameTimeAir = math.floor(GetGameTimeSeconds() - WavesStartTimeAI - AirTime) / HoldTimeAI
            
			-- Land Multiplier
			if WaveSizeMultiLand ~= "No" then
				local LandCount = 0
				if GameTime <= 0.25 then
					LandCount = LandPerWave * Landx1
				elseif GameTime > 0.25 and GameTime <= 0.5 then
					LandCount = LandPerWave * Landx2
				elseif GameTime > 0.5 and GameTime <= 0.75 then
					LandCount = LandPerWave * Landx3
				elseif GameTime > 0.75 and GameTime <= 1 then
					LandCount = LandPerWave * Landx4
				elseif GameTime > 1 then
					LandCount = LandPerWave * Landx5
				end
				if LandCount < 1 then
					LandCount = 1
				end
				Hcount = LandCount
			else	
				Hcount = LandPerWave
			end
			-- Air Multiplier
			if WaveSizeMultiAir ~= "No" then
				local ACount = 0
				if GameTimeAir <= 0.25 then
					ACount = AirPerWave * Airx1
				elseif GameTimeAir > 0.25 and GameTimeAir <= 0.5 then
					ACount = AirPerWave * Airx2
				elseif GameTimeAir > 0.5 and GameTimeAir <= 0.75 then
					ACount = AirPerWave * Airx3
				elseif GameTimeAir > 0.75 and GameTimeAir <= 1 then
					ACount = AirPerWave * Airx4
				elseif GameTimeAir > 1 then
					ACount = AirPerWave * Airx5
				end
				if ACount < 1 then
					ACount = 1
				end
				AirCount = ACount
			else	
				AirCount = AirPerWave
			end
			-- Navy Multiplier
			if WaveSizeMultiNaval ~= "No" then
				local NavyCount = 0
				if GameTimeNavy <= 0.25 then
					NavyCount = NavyPerWave * Navyx1
				elseif GameTimeNavy > 0.25 and GameTimeNavy <= 0.5 then
					NavyCount = NavyPerWave * Navyx2
				elseif GameTimeNavy > 0.5 and GameTimeNavy <= 0.75 then
					NavyCount = NavyPerWave * Navyx3
				elseif GameTimeNavy > 0.75 and GameTimeNavy <= 1 then
					NavyCount = NavyPerWave * Navyx4
				elseif GameTimeNavy > 1 then
					NavyCount = NavyPerWave * Navyx5
				end
				if NavyCount < 1 then
					NavyCount = 1
				end
				Ncount = NavyCount
			else	
				Ncount = NavyPerWave
			end
			
			
			if (GetGameTimeSeconds() - WavesStartTimeAI) > (HoldTimeAI * 0.95) and GameBreak > 0 and GameBreakFlag == false then
				local BreakTime = GameBreak / 60
				PrintText("Break detected in Waves! " .. BreakTime .. " Minutes!", 28, 'ffCBFFFF', 4, 'center') 
				WaitSeconds(GameBreak)
				GameBreakFlag = true
			end
			
			
			
			waveNum = waveNum + 1
			if LandPerWave > 0 or NavyPerWave > 0 or AirPerWave > 0 then
				IntervalWarning("Wave " .. waveNum .. " is coming!")
			end
		
		
		
			if (LandPerWave > 0 and GetGameTimeSeconds() < (HoldTimeAI + WavesStartTimeAI))
			or (LandPerWave > 0 and (Endless == "Land+Air+Navy" or Endless == "Land+Air" or Endless == "Land+Navy" or Endless == "Land")) then	
				local circle = ForkThread(function(self)
					GetListsOfLandTargets()
					local landcycle = 0
					repeat
						TFl4()
						Hcount = Hcount - 1
						landcycle = landcycle + 1
						if landcycle == 14 then
							WaitTicks(3)
							GetListsOfLandTargets()
							landcycle = 0
						end	
					until Hcount < 1
				end)	
			end
			WaitTicks(30)
			if (AirPerWave > 0 and GetGameTimeSeconds() < (HoldTimeAI + WavesStartTimeAI) and GetGameTimeSeconds() > (WavesStartTimeAI + AirTime))
			or (AirPerWave > 0 and GetGameTimeSeconds() > (WavesStartTimeAI + AirTime) and (Endless == "Land+Air+Navy" or Endless == "Land+Air" or Endless == "Air+Navy" or Endless == "Air")) then	
				local circle = ForkThread(function(self)
					GetListsOfAirTargets()
					local aircycle = 0
					if AirTime > 0 and AirTimeFlag == false then
						PrintText("Air Inbound!", 24, 'ffCBFFFF', 4, 'center') 
						AirTimeFlag = true
					end
					repeat
						TFl4AIR()
						AirCount = AirCount - 1
						aircycle = aircycle + 1
						if aircycle == 14 then
							WaitTicks(3)
							GetListsOfAirTargets()
							aircycle = 0
						end	
					until AirCount < 1
					if AirPower > 20 and ExtraASFEnabled ~= "Off --" then
						ExtraASF = math.floor(((totalT3Gunships * 0.5) + (totalT3Bombers * 0.5) + (totalExpAir * 9) + (totalT3Fighters * 0.25)) * ExtraASFEnabled + 0.5)
						local asfcycle = 0
						repeat
							SpawnExtraASF()
							ExtraASF = ExtraASF - 1
							asfcycle = asfcycle + 1
							if asfcycle == 14 then
								WaitTicks(3)
								GetAllEnemyUnitsAirList()
								asfcycle = 0
							end	 
						until ExtraASF < 1
					end	
				end)
			end
			WaitTicks(30)
			if (NavyPerWave > 0 and GetGameTimeSeconds() < (HoldTimeAI + WavesStartTimeAI) and GetGameTimeSeconds() > (WavesStartTimeAI + NavyTime))
			or (NavyPerWave > 0 and GetGameTimeSeconds() > (WavesStartTimeAI + NavyTime) and (Endless == "Land+Air+Navy" or Endless == "Land+Navy" or Endless == "Air+Navy" or Endless == "Navy")) then	
				local circle = ForkThread(function(self)
					GetListsOfNavyTargets()
					local navycycle = 0
					if NavyTime > 0 and NavyTimeFlag == false then
						PrintText("Navy Inbound!", 24, 'ffCBFFFF', 4, 'center')
						NavyTimeFlag = true
					end
					repeat
						if secondaryspawn ~= "Off" and spawnratenavy > 0 and SecondarySpawnDead == false then
							if Random(1, 100) > spawnratenavy then
								NavalUnitsSpawnWaves()
							else
								NavalUnitsSpawnWaves2ndSpawn()
							end
						else
							if SecondarySpawnDead == false then
								NavalUnitsSpawnWaves()
							end
						end	
						if secondaryspawn ~= "Off" and SecondarySpawnDead == true and spawnratenavy > 0 then
							if spawnratenavymulti ~= 0 and (spawnratenavymulti + 2) >= Random(1, 100) then
								NavalUnitsSpawnWaves()
							else
							end	
						end	
						Ncount = Ncount - 1
						navycycle = navycycle + 1
						if navycycle == 14 then
							WaitTicks(5)
							GetListsOfNavyTargets()
							navycycle = 0
						end
					until Ncount < 1
				end)	
			end
			WaitTicks(5)
			if GameTime > (0.7 * WaveProgression) and (MinorBossSpawns == "ExtraAir" or MinorBossSpawns == "ExtraLand+ExtraAir" or MinorBossSpawns == "Land+ExtraAir") 
			and (Random(0, 20) <= 10 * AirExpMulti or totalEnemyEndgamers > 0) then
				local Acount = Random(0 + totalEnemyEndgamers, 2 + totalEnemyEndgamers * 2) + math.floor(humans * 0.5 + 0.5)
				repeat
					WaitTicks(1)
					SpawnAIAirUnit()
					if Random(0, 180) <= 10 * AirExpMulti and totalEnemyEndgamers > 0 then
						CreateACombinedAirBossUnitAroundMainBuildingForAI()	
					end
					Acount = Acount - 1
				until Acount < 1
			end
			WaitTicks(5)
			if GameTime > (0.7 * WaveProgression) and (MinorBossSpawns == "ExtraLand+ExtraAir" or MinorBossSpawns == "ExtraLand" or MinorBossSpawns == "Air+ExtraLand") 
			and (Random(0, 20) <= 10 * ExpMulti or totalEnemyEndgamers > 0) then
				local Acount = Random(0 + totalEnemyEndgamers, 4 + totalEnemyEndgamers * 2) + humans
				repeat
					WaitTicks(1)
					CreateACombinedLandBossUnitAroundMainBuildingForAI()
					Acount = Acount - 1
				until Acount < 1
			end
		end
		if GetGameTimeSeconds() - WavesStartTimeAI > HoldTimeAI and Endless ~= "Off" then
			WaitSeconds(ExtraWaveDelay)
		end	
		WaitSeconds(DelayUntilNextWaveAI - 7)
    until GetGameTimeSeconds() > 20000 or won == true
end
function CreateShieldDefenceForAI(unitId)
    local circle = ForkThread(function(self)
        local unit = nil
        local posX, posZ = aiBrain:GetArmyStartPos()
		--local MapCheck = false
		local Chance
		--local count = 0
        if GetGameTimeSeconds() > 0 then
            rspawn = unitId
            if rspawn ~= nil then
                local oldposX = posX
				local oldposZ = posZ
					Chance = Random(1, 8)
					if Chance == 1 then
						posX = posX + Random(1, 45)
						posZ = posZ + Random(1, 45)
					elseif Chance == 2 then
						posX = posX - Random(1, 45)
						posZ = posZ + Random(1, 45)
					elseif Chance == 3 then
						posX = posX + Random(1, 45)
						posZ = posZ - Random(1, 45)
					elseif Chance == 4 then
						posX = posX - Random(1, 45)
						posZ = posZ - Random(1, 45)
					elseif Chance == 5 then
						posZ = posZ + Random(1, 45)
						posX = posX + Random(1, 45)
					elseif Chance == 6 then
						posZ = posZ - Random(1, 45)
						posX = posX + Random(1, 45)
					elseif Chance == 7 then
						posZ = posZ + Random(1, 45)
						posX = posX - Random(1, 45)
					else
						posZ = posZ - Random(1, 45)
						posX = posX - Random(1, 45)
					end

					if posX < 5 then
						posX = Random(5, 45)
					end
					if posX > (sizeX - 5) then
						posX = sizeX - Random(5, 45)
					end
					if posZ < 5 then
						posZ = Random(5, 45)
					end
					if posZ > (sizeZ - 5) then
						posZ = sizeZ - Random(5, 45)
					end
				unit = aiBrain:CreateUnitNearSpot(rspawn, posX, posZ)
				if unit == nil then
					local posX = oldposX
					local posZ = oldposZ
						Chance = Random(1, 8)
						if Chance == 1 then
							posX = posX + Random(1, 45)
							posZ = posZ + Random(1, 45)
						elseif Chance == 2 then
							posX = posX - Random(1, 45)
							posZ = posZ + Random(1, 45)
						elseif Chance == 3 then
							posX = posX + Random(1, 45)
							posZ = posZ - Random(1, 45)
						elseif Chance == 4 then
							posX = posX - Random(1, 45)
							posZ = posZ - Random(1, 45)
						elseif Chance == 5 then
							posZ = posZ + Random(1, 45)
							posX = posX + Random(1, 45)
						elseif Chance == 6 then
							posZ = posZ - Random(1, 45)
							posX = posX + Random(1, 45)
						elseif Chance == 7 then
							posZ = posZ + Random(1, 45)
							posX = posX - Random(1, 45)
						else
							posZ = posZ - Random(1, 45)
							posX = posX - Random(1, 45)
						end

						if posX < 5 then
							posX = Random(5, 45)
						end
						if posX > (sizeX - 5) then
							posX = sizeX - Random(5, 45)
						end
						if posZ < 5 then
							posZ = Random(5, 45)
						end
						if posZ > (sizeZ - 5) then
							posZ = sizeZ - Random(5, 45)
						end
					local terrainAltitude = GetTerrainHeight(posX, posZ)
					unit = CreateUnitHPR(rspawn, aiBrain:GetArmyIndex(), posX, terrainAltitude, posZ, 0, 0, 0)
                end
            end
        end
        if unit ~= nil then
            maxhp = unit:GetMaxHealth()
            unit:SetMaxHealth(maxhp + 4000 * totalEnemyEndgamers + 1500 * totalEnemyExpArty + 500 * totalEnemyT3Arty)
            hp = unit:GetMaxHealth()
            unit:SetHealth(self, hp)
        end
        KillThread(self)
    end)
end
function DisableBlackOpsArtemis()
	local circle = ForkThread(function(self)
		for i, Army in ListArmies() do
			AddBuildRestriction(Army, categories.bab2404) --Blackops Artemis Sat
		end
	KillThread(self)
	end)
end	
function DisableBrewLANWalls()
	local circle = ForkThread(function(self)
		for i, Army in ListArmies() do
			AddBuildRestriction(Army, categories.sab5210)
			AddBuildRestriction(Army, categories.sab5301)
			AddBuildRestriction(Army, categories.seb5210)
			AddBuildRestriction(Army, categories.seb5310)
			AddBuildRestriction(Army, categories.srb5210)
			AddBuildRestriction(Army, categories.srb5310)
			AddBuildRestriction(Army, categories.srb5312)
			AddBuildRestriction(Army, categories.ssb5210)
			AddBuildRestriction(Army, categories.ssb5301)
		end
	KillThread(self)
	end)
end	
function DisableArtilleryNukes()
	local circle = ForkThread(function(self)
		for i, Army in ListArmies() do
			--nukes
			AddBuildRestriction(Army, categories.ueb2305)
			AddBuildRestriction(Army, categories.urb2305)
			AddBuildRestriction(Army, categories.uab2305)
			AddBuildRestriction(Army, categories.xsb2305)
			--t3 arty
			AddBuildRestriction(Army, categories.ueb2302)
			AddBuildRestriction(Army, categories.urb2302)
			AddBuildRestriction(Army, categories.uab2302)
			AddBuildRestriction(Army, categories.xsb2302)
			--t4 arty + sat
			AddBuildRestriction(Army, categories.ueb2401)
			AddBuildRestriction(Army, categories.url0401)
			AddBuildRestriction(Army, categories.xab2307)
			AddBuildRestriction(Army, categories.xeb2402)
			-- strategic subs/sera battleship
			AddBuildRestriction(Army, categories.ues0304)
			AddBuildRestriction(Army, categories.urs0304)
			AddBuildRestriction(Army, categories.uas0304)
			AddBuildRestriction(Army, categories.xss0302)
			
		end
		PrintText("Artillery, Nukes, Sat, and Strategic Subs Disabled", 30, 'ffCBFFFF', 4, 'center')
	KillThread(self)
	end)
end	
function EnableArtilleryNukes()
	local circle = ForkThread(function(self)
		for i, Army in ListArmies() do
			--nukes
			RemoveBuildRestriction(Army, categories.ueb2305)
			RemoveBuildRestriction(Army, categories.urb2305)
			RemoveBuildRestriction(Army, categories.uab2305)
			RemoveBuildRestriction(Army, categories.xsb2305)
			--t3 arty
			RemoveBuildRestriction(Army, categories.ueb2302)
			RemoveBuildRestriction(Army, categories.urb2302)
			RemoveBuildRestriction(Army, categories.uab2302)
			RemoveBuildRestriction(Army, categories.xsb2302)
			--t4 arty + sat
			RemoveBuildRestriction(Army, categories.ueb2401)
			RemoveBuildRestriction(Army, categories.url0401)
			RemoveBuildRestriction(Army, categories.xab2307)
			RemoveBuildRestriction(Army, categories.xeb2402)
			-- strategic subs/sera battleship
			RemoveBuildRestriction(Army, categories.ues0304)
			RemoveBuildRestriction(Army, categories.urs0304)
			RemoveBuildRestriction(Army, categories.uas0304)
			RemoveBuildRestriction(Army, categories.xss0302)
		end
	KillThread(self)
	end)
end	
function DisableNomadsArtyNuke()
	local circle = ForkThread(function(self)
		for i, Army in ListArmies() do
			AddBuildRestriction(Army, categories.xnb2305) --nuke
			AddBuildRestriction(Army, categories.xnb2302) --arty
			AddBuildRestriction(Army, categories.xnl0403) --missiletankT4
		end
	KillThread(self)
	end)
end	
function EnableNomadsArtyNuke()
	local circle = ForkThread(function(self)
		for i, Army in ListArmies() do
			RemoveBuildRestriction(Army, categories.xnb2305) --nuke
			RemoveBuildRestriction(Army, categories.xnb2302) --arty
			RemoveBuildRestriction(Army, categories.xnl0403) --missiletankT4
		end
	KillThread(self)
	end)
end	
function DisableWeaponsHQAllies()
	local Army
	local circle = ForkThread(function(self)
		for i, brain in allyBrainsHQ.ABrainsHQ do
			Army = brain:GetArmyIndex()
			AddBuildRestriction(Army, categories.pd4sp2108) --sera T4 Tacs
			AddBuildRestriction(Army, categories.pdan2301) --aeon T4 PD
			AddBuildRestriction(Army, categories.pdcb2301) --cybran T4 PD
			AddBuildRestriction(Army, categories.pduef2301) --uef T4 PD
		end
	KillThread(self)
	end)
end	
function DisableFabsHQAllies()
	local Army
	local circle = ForkThread(function(self)
		for i, brain in allyBrainsHQ.ABrainsHQ do
			Army = brain:GetArmyIndex()
			AddBuildRestriction(Army, categories.ueb1104) --uef t2 massfab
			AddBuildRestriction(Army, categories.ueb1303) --uef t3 massfab
			AddBuildRestriction(Army, categories.urb1104) --cybran t2 massfab
			AddBuildRestriction(Army, categories.urb1303) --cybran t3 massfab
			AddBuildRestriction(Army, categories.uab1104) --aeon t2 massfab
			AddBuildRestriction(Army, categories.uab1303) --aeon t3 massfab
			AddBuildRestriction(Army, categories.xsb1104) --sera t2 massfab
			AddBuildRestriction(Army, categories.xsb1303) --sera t3 massfab
			
			AddBuildRestriction(Army, categories.url0301_ras) --cybran ras
			AddBuildRestriction(Army, categories.ual0301_ras) --aeon ras
			AddBuildRestriction(Army, categories.uel0301_ras) --uef ras
		end
	KillThread(self)
	end)
end	
function DisableFabsHQAlliesNomands()
	local Army
	local circle = ForkThread(function(self)
		for i, brain in allyBrainsHQ.ABrainsHQ do
			Army = brain:GetArmyIndex()
			AddBuildRestriction(Army, categories.xnb1104) --nomad t2 massfab
			AddBuildRestriction(Army, categories.xnb1303) --nomad t3 massfab
			
			AddBuildRestriction(Army, categories.xnl0301_ras) --Nomad RAS
			AddBuildRestriction(Army, categories.xnl0301_naturalproducer) --Nomad RAS Alt
		end
	KillThread(self)
	end)
end	