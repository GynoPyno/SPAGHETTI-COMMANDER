AIOpts = {
{
        default = 1,
        label = "<LOC aiwave_0231>===AI WAVE SURVIVAL===",
        help = "<LOC aiwave_0232>Set HQ player under 'HQ Spawn Spot'. Set a 2nd Spawn Player, same team as HQ (Optional). HQ Player can be AI or Human; can also have allies, just set to same team as HQ. Set second team/teams as opponents (Can be Human/AI Teams). Any players not on HQ Player's team will count as opponents. Civilian Buildings MUST be set to “Default”. Recommend AI Unit cap be MAX. Works best with AI_WaveSurvival and Uveso AI, may behave different with other AIs, like M27 AI. AI_WaveSurvival is a dumb AI, builds nothing, speeds up SIM, and doesn't interfere with scripted attack waves. Works with unit packs, like Total Mayhem and BlackOps. FALSE DESYNC at START; ignore and play on, does not affect game (all players redownloading all mods usually fixes).",
        key = 'HowToPlay',
		value_text = "%s",
        value_help = "<LOC aiwave_0233>Mouse over AI WAVE SURVIVAL for instructions.",
        values = {
           
         'How to Play', 'Mouse over for instructions', 'Functions differently with different AIs', 'AI_WaveSurvival = Traditional Survival', 'UvesoAI = Stream/Hordes', 'M27AI = Hordes then Attacks (Harder)', 'SimSpeed++ Included', 'Works with Unit Packs', 'Can also be played Human vs Human', 'Trouble Shooting:', 'If waves not spawning, adjust Size/Delay', 'If HQ does not spawn with HQ Player, check to make sure assigned correct spot', 'If scripts stop, increase Unit Cap', 'If freeze/desync, redownload all mods'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0234>UEF RACE On/Off",
        help = "<LOC aiwave_0235>Sets if UEF units will spawn in waves. Multiple races may be selected.",
        key = 'UEFWaves',
		value_text = "  %s",
        value_help = "<LOC aiwave_0236>UEF Turn Race On/Off",
        values = {
           
         'UEF On', 'Off'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0237>CYBRAN RACE On/Off",
        help = "<LOC aiwave_0238>Sets if Cybran units will spawn in waves. Multiple races may be selected.",
        key = 'CybranWaves',
		value_text = "  %s",
        value_help = "<LOC aiwave_0239>Cybran Turn Race On/Off",
        values = {
           
         'Cybran On', 'Off'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0240>AEON RACE On/Off",
        help = "<LOC aiwave_0241>Sets if Aeon units will spawn in waves. Multiple races may be selected.",
        key = 'AeonWaves',
		value_text = "  %s",
        value_help = "<LOC aiwave_0242>Aeon Turn Race On/Off",
        values = {
           
         'Aeon On', 'Off'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0243>SERAPHIM RACE On/Off",
        help = "<LOC aiwave_0242>Sets if Seraphim units will spawn in waves. Multiple races may be selected.",
        key = 'SeraphimWaves',
		value_text = "  %s",
        value_help = "<LOC aiwave_0245>Seraphim Turn Race On/Off",
        values = {
           
         'Seraphim On', 'Off'
        },
    },
	{
        default = 2,
        label = "<LOC aiwave_0246>NOMADS RACE On/Off",
        help = "<LOC aiwave_0247>Sets if Nomad units will spawn in waves. Multiple races may be selected. Must host a Nomads game to work.",
        key = 'NomadWaves',
		value_text = "  %s",
        value_help = "<LOC aiwave_0248>Nomads Turn Race On/Off",
        values = {
           
         'Nomads On', 'Off'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0249>       HQ SETTINGS",
        help = "HQ is the main spawn point. Destroying will win the game. Nukes, Artillery, and EndGame Bosses only spawn at HQ.",
        key = 'hqsettingskey',
		value_text = "%s",
        value_help = "",
        values = {
           
        '====================', 'Set HQ Spawn Spot for Best Performance'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0250>HQ Spawn Spot",
        help = "<LOC aiwave_0251> Sets which Player spawns with HQ. Setting spawn spot required for games with more than 2 teams, and highly recommended for all games for best performance. Random will choose a random player on SMALLEST team (Random only supports two teams). Can be AI or Human Player.",
        key = 'AIWavePlayer',
		value_text = "  Player %s",
        value_help = "<LOC aiwave_0252>%s (Which Player gets HQ, can be AI or Human. Mod works best when HQ Player spot is not Random.)",
        values = {
           
        'Random', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16'
        },
    },
	{
        default = 7,
        label = "<LOC aiwave_0253> HQ Health (millions)",
        help = "<LOC aiwave_0254>Set the MainBuilding HP (millions).",
        key = 'MainBuildingHPAI',
		value_text = "  %s millions HQ Health",
        value_help = "<LOC aiwave_0255>(MainBuilding HP)",
        values = {
           
         '0.1', '0.25', '0.3', '0.4', '0.5', '0.6', '0.75', '0.9', '1', '1.25', '1.5', '1.75', '2', '2.5', '3', '4', '5', '7.5', '10', '12.5', '15', '20', '25', '30', '40', '50', '75', '100', '250', '500'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0256>HQ Alternate Spawn (Optional)",
        help = "<LOC aiwave_0257> Will spawn half of Land/Air/Bosses/Dooms/Nukes/ACU Hunter Waves from alternate spawn. Cannot be destroyed. If no Base Building wanted, set the player AI to AI_WaveSurvival, which will build nothing.",
        key = 'AltHQSpawn',
		value_text = "  Alternate Spawn Player %s",
        value_help = "<LOC aiwave_0258>%s (Sets alternative spawn for HQ!)",
        values = {
           
        'Off', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0259>HQ Alternate Health",
        help = "<LOC aiwave_0260> Sets if Alternate HQ Spawn can be destroyed or is invulnerable. If destroyed, any units that would spawn at Alternate HQ will instead spawn at HQ.",
        key = 'AltHQHealth',
		value_text = "  %s millions HQ Alternate Health",
        value_help = "<LOC aiwave_0261>%s (Sets Alternative Spawn Health!)",
        values = {
           
        'Invulnerable --', '0.1', '0.15', '0.2', '0.25', '0.3', '0.35', '0.4', '0.45', '0.5', '0.55', '0.6', '0.65', '0.7', '0.75', '0.85', '0.9', '1', '1.25', '1.5', '1.75', '2', '2.5', '3', '4', '5', '7.5', '10', '12.5', '15', '20', '25', '30', '40', '50', '75', '100', '250', '500'
        },
    },
	{
        default = 4,
        label = "<LOC aiwave_0262> HQ Shields/SMD/TMD Defenses",
        help = "<LOC aiwave_0263> Sets what tier Shields, SMD, and TMD spawn around HQ. S2-Tier are all Guardians. S1-Tier are Guardian Shields/TMD and Advanced SMD. AAA-Tier are Guardian Shields/SMD and Vanilla TMD. AA-Tier are Advanced Shields and Guardian SMD/TMD. A-Tier are Advanced Shields/SMD and Guardian TMD. B-Tier are Advanced Shields/SMD and Vanilla TMD. C-Tier are Vanilla Shields/SMD/TMD.",
        key = 'HQDefenses',
		value_text = "  %s",
        value_help = "<LOC aiwave_0264>%s (What Shileds/SMD/TMD spawn around HQ)",
        values = {
           
        "HQ S2-Tier Defenses", "HQ S1-Tier Defenses", "HQ AAA-Tier Defenses", "HQ AA-Tier Defenses", "HQ A-Tier Defenses", "HQ B-Tier Defenses", "HQ C-Tier Defenses", "HQ Defenses Off"
        },
    },
	{
        default = 2,
        label = "<LOC aiwave_0265> HQ Point Defenses",
        help = "<LOC aiwave_0266> Sets what tier PD/AA spawn around HQ. S-Tier are all Guardians. A-Tier are Universal PD. B-Tier are Vanilla T3 PD. C-Tier are Vanilla T2 PD.",
        key = 'HQDefensesPD',
		value_text = "  %s",
        value_help = "<LOC aiwave_0267>%s (What PD/AA spawn around HQ)",
        values = {
           
        "HQ Guardian PD S-Tier", "HQ Universal PD A-Tier", "HQ T3 Vanilla PD B-Tier", "HQ T2 Vanilla PD C-Tier", "HQ Point Defenses Off"
        },
    },
	{
        default = 4,
        label = "<LOC aiwave_0268>HQ/2ndSpawn Base Building On/Off",
        help = "<LOC aiwave_0269> Sets if AI/Human HQ Player can build base and units or not. Disabling removes some of the random challenge and also can speed up sim speed. Will kill HQ Player's ACU on start, or 2nd Spawn Player. Doesn't affect other players.",
        key = 'KillAIBase',
		value_text = "  %s",
        value_help = "<LOC aiwave_0270>%s (Sets if HQ Player or 2nd Spawn Player can Base Build)",
        values = {
           
        'BaseBuilding On', 'HQ Only BaseBuilding', '2nd Spawn Only BaseBuilding', 'BaseBuilding Off'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0271>       2ND SPAWN SETTINGS",
        help = "",
        key = '2ndspawnsettingskey',
		value_text = "%s",
        value_help = "",
        values = {
           
         '       2nd Spawn is Optional', '===================='
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0272>2nd Spawn Spot (Optional)",
        help = "<LOC aiwave_0273> Allows waves to spawn from a secondary spawn point; slot must have an AI/Human to function (Player can be force killed under 'HQ/2ndSpawn Base Building On/Off' Option). Does not increase wave sizes, but splits total units between the points. If destroyed, spawn reverts to HQ. Does not affect End Game bosses, which only spawn from HQ.",
        key = 'secondaryspawn',
		value_text = "  2nd Spawn Player %s",
        value_help = "<LOC aiwave_0274>%s (Sets the Secondary Spot spawn units can spawn from. 2nd Spawn is Optional, can be left Off.)",
        values = {
           
        'Off', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16'
        },
    },
	{
        default = 5,
        label = "<LOC aiwave_0275> 2nd Spawn Health (millions)",
        help = "<LOC aiwave_0276>Set the 2nd Spawn's HP (millions).",
        key = 'SecSpawnBuildingHP',
		value_text = "  %s millions 2nd Spawn Health",
        value_help = "<LOC aiwave_0277>(2nd Spawn HP)",
        values = {
           
         '0.1', '0.25', '0.3', '0.4', '0.5', '0.6', '0.75', '0.9', '1', '1.25', '1.5', '1.75', '2', '2.5', '3', '4', '5', '7.5', '10', '12.5', '15', '20', '25', '30', '40', '50', '75', '100', '250', '500'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0278>2nd Spawn Alternate (Optional)",
        help = "<LOC aiwave_0279> Will spawn half of Land/Air Waves from alternate spawn. Disabled if 2nd Spawn is destroyed. If no Base Building wanted, use the AI option AI_WaveSurvival, which will build nothing.",
        key = 'Alt2ndSpawn',
		value_text = "  Alternate 2nd Spawn Player %s",
        value_help = "<LOC aiwave_0280>%s (Sets alternative spawn for 2nd Spawn!)",
        values = {
           
        'Off', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0281>2nd Spawn Alternate Health",
        help = "<LOC aiwave_0282> Sets if Alternate 2nd Spawn can be destroyed or is invulnerable. If destroyed, any units that would spawn at Alternate 2nd Spawn will instead spawn at 2nd Spawn.",
        key = 'Alt2ndHealth',
		value_text = "  %s millions 2nd Alternate Health",
        value_help = "<LOC aiwave_0283>%s (Sets Alternative 2nd Spawn Health!)",
        values = {
           
        'Invulnerable --', '0.1', '0.15', '0.2', '0.25', '0.3', '0.35', '0.4', '0.45', '0.5', '0.55', '0.6', '0.65', '0.7', '0.75', '0.85', '0.9', '1', '1.25', '1.5', '1.75', '2', '2.5', '3', '4', '5', '7.5', '10', '12.5', '15', '20', '25', '30', '40', '50', '75', '100', '250', '500'
        },
    },
	{
        default = 4,
        label = "<LOC aiwave_0285> 2nd Spawn Shields/SMD Defenses",
        help = "<LOC aiwave_0286> Sets what tier Shields, SMD, and TMD spawn around 2nd Spawn. SS-Tier are all Guardians. S-Tier are Guardian Shields/TMD and Advanced SMD. AAA-Tier are Guardian Shields/SMD and Vanilla TMD. AA-Tier are Advanced Shields and Guardian SMD/TMD. A-Tier are Advanced Shields/SMD and Guardian TMD. B-Tier are Advanced Shields/SMD and Vanilla TMD. C-Tier are Vanilla Shields/SMD/TMD.",
        key = 'SecSpawnDefences',
		value_text = "  %s",
        value_help = "<LOC aiwave_0287>%s (What Shileds/SMD/TMD spawn around 2nd Spawn)",
        values = {
           
        "2nd Spawn S2-Tier Defenses", "2nd Spawn S1-Tier Defenses", "2nd Spawn AAA-Tier Defenses", "2nd Spawn AA-Tier Defenses", "2nd Spawn A-Tier Defenses", "2nd Spawn B-Tier Defenses", "2nd Spawn C-Tier Defenses", "2nd Spawn Defenses Off"
        },
    },
	{
        default = 2,
        label = "<LOC aiwave_0288> 2nd Spawn Point Defenses",
        help = "<LOC aiwave_0289> Sets what tier PD/AA spawn around 2nd Spawn. S-Tier are all Guardians. A-Tier are Universal PD. B-Tier are Vanilla T3 PD. C-Tier are Vanilla T2 PD.",
        key = 'SecSpawnPD',
		value_text = "  %s",
        value_help = "<LOC aiwave_0290>%s (What PD/AA spawn around 2nd Spawn)",
        values = {
           
        "2nd Spawn Guardian PD S-Tier", "2nd Spawn Universal PD A-Tier", "2nd Spawn T3 Vanilla PD B-Tier", "2nd Spawn T2 Vanilla PD C-Tier", "2nd Spawn Point Defenses Off"
        },
    },
	{
        default = 7,
        label = "<LOC aiwave_0291> 1a. 2nd Spawn Land Percent",
        help = "<LOC aiwave_0292> Allows land waves to spawn from a secondary spawn point. Does not increase wave sizes, but splits total units between the points.",
        key = 'spawnrateland',
		value_text = "   Land Spawn %s %%",
        value_help = "<LOC aiwave_0293>%s (Sets what percentage of Land Wave will spawn from secondary.)",
        values = {
           
        '0', '10', '20', '25', '30', '40', '50', '60', '70', '75', '80', '90', '100'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0294>   1b. Recover Land to HQ Spawn",
        help = "<LOC aiwave_0295> If 2nd Spawn Building is destroyed, will set what % of Land Units spawned by 2nd Spawn will respawn at HQ.",
        key = 'permanentwaveloss',
		value_text = "     HQ %s%% Land Recovery",
        value_help = "<LOC aiwave_0296>(Sets what percentage of Land units spawned by 2nd Spawn respawn at HQ if 2nd Spawn destroyed.)",
        values = {
           
        '100', '90', '80', '75', '70', '60', '50', '40', '30', '25', '20', '10', '0'
        },
    },
	{
        default = 7,
        label = "<LOC aiwave_0297> 2a. 2nd Spawn Air Percent",
        help = "<LOC aiwave_0298> Allows air waves to spawn from a secondary spawn point. Does not increase wave sizes, but splits total units between the points.",
        key = 'spawnrateair',
		value_text = "   Air Spawn %s %%",
        value_help = "<LOC aiwave_0299>%s (Sets what percentage of Air Wave will spawn from secondary.)",
        values = {
           
        '0', '10', '20', '25', '30', '40', '50', '60', '70', '75', '80', '90', '100'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0300>   2b. Recover Air to HQ Spawn",
        help = "<LOC aiwave_0301> If 2nd Spawn Building is destroyed, will set what % of Air Units spawned by 2nd Spawn will respawn at HQ.",
        key = 'permanentwavelossair',
		value_text = "     HQ %s%% Air Recovery",
        value_help = "<LOC aiwave_0302>(Sets what percentage of Air units spawned by 2nd Spawn respawn at HQ if 2nd Spawn destroyed.)",
        values = {
           
        '100', '90', '80', '75', '70', '60', '50', '40', '30', '25', '20', '10', '0'
        },
    },
	{
        default = 7,
        label = "<LOC aiwave_0303> 3a. 2nd Spawn Navy Percent",
        help = "<LOC aiwave_0304> Allows navy waves to spawn from a secondary spawn point. Does not increase wave sizes, but splits total units between the points.",
        key = 'spawnratenavy',
		value_text = "   Navy Spawn %s %%",
        value_help = "<LOC aiwave_0305>%s (Sets what percentage of Navy Wave will spawn from secondary.)",
        values = {
           
        '0', '10', '20', '25', '30', '40', '50', '60', '70', '75', '80', '90', '100'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0306>   3b. Recover Navy to HQ Spawn",
        help = "<LOC aiwave_0307> If 2nd Spawn Building is destroyed, will set what % of Navy Units spawned by 2nd Spawn will respawn at HQ.",
        key = 'permanentwavelossnavy',
		value_text = "     HQ %s%% Navy Recovery",
        value_help = "<LOC aiwave_0308>(Sets what percentage of Navy units spawned by 2nd Spawn respawn at HQ if 2nd Spawn destroyed.)",
        values = {
           
        '100', '90', '80', '75', '70', '60', '50', '40', '30', '25', '20', '10', '0'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0309>       SALVATION PLAYER",
        help = "",
        key = 'salvationsettingskey',
		value_text = "%s",
        value_help = "",
        values = {
           
        '===================', 'Salvation Player'
        },
    },
	{
        default = 2,
        label = "<LOC aiwave_0310>Salvation Player Slot",
        help = "<LOC aiwave_0311> Salvation Player can save team through sacrafice. The death/suicide of their ACU will trigger entire wave to self destruct. Half of team requires half of ACUs to be dead to trigger salvation.",
        key = 'salvationspawn',
		value_text = "  Salvation Player %s",
        value_help = "<LOC aiwave_0312>%s (Sets who will be the Team's Salvation!)",
        values = {
           
        'Off', 'Half of Team', 'Random', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16'
        },
    },
	{
        default = 2,
        label = "<LOC aiwave_0313>Salvation Destruction",
        help = "<LOC aiwave_0314> Sets if entire wave is destroyed, or T4s and/or Dooms immune. Units that are immune will not be destroyed",
        key = 'salvationBOOM',
		value_text = "  %s",
        value_help = "<LOC aiwave_0315>%s (Sets what units are immune to Salvation.)",
        values = {
           
        'Entire Wave Destroyed', 'Dooms Immune', 'Dooms and T4 Immune'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0316>       WIN/LOSE/VERSUS SETTINGS",
        help = "Versus can be played with multiple teams, FFA, or even with a Human HQ Player.",
        key = 'winlosekey',
		value_text = "%s",
        value_help = "",
        values = {
           
        '===================', 'Win and Defeat Conditions'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0317>Hold to Win On/Off",
        help = "<LOC aiwave_0318>Sets Win Condition. Kill HQ to Win or set Survival Time after FINAL STAGE starts.",
        key = 'EndGameHoldTime',
		value_text = "  Hold to Win %s mins",
        value_help = "<LOC aiwave_0319>(Final Stage Survival Time (mins))",
        values = {
           
         'Off --', '1', '3', '5', '6', '7', '8', '9', '10', '12', '14', '16', '18', '20', '22', '24', '26', '28', '30'
        },
    },
	{
        default = 4,
        label = "<LOC aiwave_0320>  Hold to Win Torp Bombers",
        help = "<LOC aiwave_0321>If Hold to Win is on, enables an extremely powerful ACU Hunting Torp Bomber. No more hiding in water to win! Torp Bombers only spawn within set time and if Commanders and SACUs are detected in water. Number of bombers that spawn depend on total Commanders in water, and spawn repeats every 2 minutes.",
        key = 'TorpBomberStartTime',
		value_text = "    Start %s mins before Victory, 0 = Off",
        value_help = "<LOC aiwave_0322>(ONLY spawns if Hold to Win is ON and Commanders detected in water!)",
        values = {
           
         '0', '2', '4', '6', '8', '10', '12', '14', '16', '18', '20'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0323>Defeat Conditions",
        help = "<LOC aiwave_0324> 'Assassinate All ACUs Defeat' If ACU's of ALL players fighting the HQ Team are lost, triggers defeat. Does NOT affect Players allied with HQ Player. All other Defeat modes are same as vanilla, but only apply to players NOT allied with HQ.",
        key = 'KillAllNonHQPlayers',
		value_text = "  %s",
        value_help = "<LOC aiwave_0325>%s (Defeat conditions for non-HQ Teams)",
        values = {
           
        "Assassinate All ACUs Defeat", "Supremacy Defeat", "Assassinate Defeat", "Annihilation Defeat"
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0326>Defeat Conditions: HQ Allies",
        help = "<LOC aiwave_0327>  Additional Defeat conditions for players allied with HQ. 'HQ Allies Kill All ACUs Defeat' Killing ALL Allied ACU's will eliminate allied players. HQ Allies Defeat Conditons only affect HQ Allies. Destroying HQ will always eliminate all HQ Allies.",
        key = 'KillHQPlayerAllies',
		value_text = "  %s",
        value_help = "<LOC aiwave_0328>%s (Defeat conditions for Allies of HQ Player. Killing HQ will always eliminate all HQ Allies.)",
        values = {
           
        "HQ Allies Annihilation Defeat", "HQ Allies Supremacy Defeat", "HQ Allies Assassinate Defeat", "HQ Allies Kill All ACUs Defeat"
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0329>Versus Survival On/Off",
        help = "<LOC aiwave_0330>'Versus Survival - HQ Suicides' option will destroy HQ and any HQ allies seconds after one team/player vanquishes all other opposition. 'Versus Survival - Defeat HQ' requires HQ being destroyed to win game. 'Versus Survival - HQ Suicides' requires HQ Team plus 2 or more teams (3+ Teams Total) or game will default back to requiring HQ be destroyed to win.",
        key = 'VersesSurvival',
		value_text = "  %s",
        value_help = "<LOC aiwave_0331>(Leave Versus Survival to 'Defeat HQ' if playing survival with only HQ Team and Survivors Team)",
        values = {
         
			'Versus Survival - Defeat HQ', 'Versus Survival - HQ Suicides'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0332>Versus Suicide Timer",
        help = "<LOC aiwave_0333> Useful if HQ Player is a Human Player. Only affects spawned units. Will kill units after the set amount of time after they spawn. Air suicides in 1x Minutes, Land/Navy in 1.5x Minutes, Bosses in 2x Minutes. Special Bosses spawned to counter Yolonas do not suicide. Forces Human HQ Players to attack or can be used to clear stuck units. If units are transferred to an allied player, will prevent suicide.",
        key = 'KillPlayerUnit',
		value_text = "  Units Suicide %s min, 0 = Never",
        value_help = "<LOC aiwave_0334>%s (Air suicides 1x Minutes after Spawn, Land/Navy suicide in 1.5x Minutes, Boss Units suicide 2x Minutes)",
        values = {
           
        '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0335>       WAVE SETUP",
        help = "Initial Wave Settings. How many land/air/navy units per wave and experimental spawn rate.",
        key = 'wavesetupkey',
		value_text = "%s",
        value_help = "",
        values = {
           
        '===================', 'Wave Settings'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0336>Wave Style",
        help = "<LOC aiwave_0337> 'Dynamic Waves' will increased attacks on front Players and scale attacks against stronger players/teams. Artillery units will stay at range. 'Even Waves' attack all players/teams evenly, regardless of strength. Artillery units will rush in. If set to 'AI/Human Controlled', the AI/Human player will use spawned units as it sees fit (attack, retreat, flank, horde). 'Human with AI Assist' is for Human HQ players that want some help. Waves on spawn will recieve dynamic attack orders from AI, but no further orders after reaching their target. Any new units built by Human/AI players will not be redirected by scripts.",
        key = 'WaveStyle',
		value_text = "  %s",
        value_help = "<LOC aiwave_0338>AI/Human Controlled or Scripted Waves",
        values = {
           
         'Dynamic Attack Waves', 'Even Attack Waves', 'AI/Human Controlled', 'Human with AI Assist'
        },
    },
	{
        default = 7,
        label = "<LOC aiwave_0339>1a: Build Time (mins)",
        help = "<LOC aiwave_0340>Set the Waves Start Time(mins).",
        key = 'WavesStartTimeAI',
		value_text = "  %s min Build Time",
        value_help = "<LOC aiwave_0341>%s (Minutes)",
        values = {
           
         '2', '2.5', '3', '3.5', '4', '4.5', '5', '5.5', '6', '6.5', '7', '7.5', '8', '9', '10', '12', '14', '16', '18', '20'
        },
    },
	{
        default = 3,
        label = "<LOC aiwave_0342> 1b: Air Delay Spawn Time",
        help = "<LOC aiwave_0343>Adds more time to when Air begins to spawn. Delays tech level (Starts at T1). Will start at T2 if Tech 2 Wave Start is on.",
        key = 'AirTime',
		value_text = "  %s waves Air Delay",
        value_help = "<LOC aiwave_0344>%s (Waves till Air Starts)",
        values = {
           
         '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15'
        },
    },
	{
        default = 4,
        label = "<LOC aiwave_0345> 1c: Naval Delay Spawn Time",
        help = "<LOC aiwave_0346>Adds more time to when Navy begins to spawn. Delays tech level (Starts as T1). Will start at T2 if Tech 2 Wave Start is on.",
        key = 'NavyTime',
		value_text = "  %s waves Navy Delay",
        value_help = "<LOC aiwave_0347>%s (Waves till Navy Starts)",
        values = {
           
         '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15'
        },
    },
	{
        default = 6,
        label = "<LOC aiwave_0348>2: Delay between Waves (mins)",
        help = "<LOC aiwave_0349>Sets delay between Waves (mins). Very big waves need longer delay or may not spawn.",
        key = 'DelayUntilNextWaveAI',
		value_text = "  %s min Wave Delay",
        value_help = "<LOC aiwave_0350>%s (Delay Between Waves)",
        values = {
           
            '0.9', '1', '1.25', '1.5', '1.75', '2', '2.25', '2.5', '2.75', '3', '3.5', '4', '4.5', '5', '6', '7', '8', '9', '10'
        },
    },
	{
        default = 10,
        label = "<LOC aiwave_0351>3a: Hold Until (mins)",
        help = "<LOC aiwave_0352>Time till Endgame (mins).",
        key = 'HoldTimeAI',
		value_text = "  %s min Hold till Final",
        value_help = "<LOC aiwave_0353>%s (Minutes)",
        values = {
           
         '10', '12', '15', '18', '20', '23', '25', '28', '30', '33', '35', '38', '40', '45', '50', '55', '60'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0354> 3b: Endgame Wave Break",
        help = "<LOC aiwave_0355>Creates a break in waves at 99% of HoldTime, just before EndGame. Gives team a break to recover, allowing to prepare for endgame or a counter attack.",
        key = 'GameBreak',
		value_text = "  %s min Wave Break",
        value_help = "<LOC aiwave_0356>%s (Minutes of Break)",
        values = {
           
            '0', '1', '1.5', '2', '2.5', '3', '3.5', '4', '4.5', '5', '5.5', '6', '7', '8', '9', '10'
        },
    },
	{
        default = 31,
        label = "<LOC aiwave_0357>4: Wave Tech Progression",
        help = "<LOC aiwave_0358> Waves T1/T2/T3 Progression. Can be set to be faster or slower. Small changes can greatly affect difficulty.",
        key = 'WaveProgressionData',
		value_text = "  %s Tech Progression",
        value_help = "<LOC aiwave_0359>( Speed up or slow down Tech Progression of Waves. )",
        values = {
		
			'200 % Slower', '190 % Slower', '180 % Slower', '170 % Slower', '160 % Slower', '150 % Slower', '140 % Slower', '130 % Slower', '120 % Slower', '110 % Slower',
			'100 % Slower', '95 % Slower', '90 % Slower', '85 % Slower', '80 % Slower', '75 % Slower', '70 % Slower', '65 % Slower', '60 % Slower', '55 % Slower', '50 % Slower',
			'45 % Slower', '40 % Slower', '35 % Slower', '30 % Slower', '25 % Slower', '20 % Slower', '15 % Slower', '10 % Slower', '5 % Slower', 'Normal', '5 % Faster', '10 % Faster',
			'15 % Faster', '20 % Faster', '25 % Faster', '30 % Faster', '35 % Faster', '40 % Faster', '45 % Faster', '50 % Faster', '55 % Faster', '60 % Faster', '65 % Faster',
			'70 % Faster', '75 % Faster', '80 % Faster', '85 % Faster', '90 % Faster'
			
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0360>5: Start Waves at Tech 2",
        help = "<LOC aiwave_0361> Sets if Land/Air/Naval waves start at Tech2. Good for 20km maps or faster starts.",
        key = 'JumpTech2',
		value_text = "  Starts Tech2 %s",
        value_help = "<LOC aiwave_0362>%s (Starts at Tech 2)",
        values = {
           
			'Off', 'Land+Air+Navy', 'Land+Air', 'Land+Navy', 'Air+Navy', 'Land', 'Air', 'Navy'
        },
    },
	{
        default = 9,
        label = "<LOC aiwave_0363>6a: LAND UNITS Per Player",
        help = "<LOC aiwave_0364>Number of Land Units Per Player.",
        key = 'LandPerWave',
		value_text = "  %s units Land",
        value_help = "<LOC aiwave_0365>%s (Land Per Player)",
        values = {
           
         '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '22', '24', '26', '28', '32', '36', '40', '44', '48', '52', '56', '60', '64', '68', '72', '76', '80', '100', '150', '200'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0366> 6b: LAND Amphibious/AntiAir On/Off",
        help = "<LOC aiwave_0367> Sets if AntiAir units or Amphibious/Hover units will spawn in land waves. No AntiAir = Removes all AA. Amphibious = Only units that can cross water.",
        key = 'LandAmphibious',
		value_text = "  Land Special - %s",
        value_help = "<LOC aiwave_0368>%s (Land Waves)",
        values = {
           
			'All On', 'No AntiAir', 'Amphibious', 'Amphibious No AA'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0366> 6c: LAND Amphibious Check",
        help = "<LOC aiwave_0367> Checks to see if Land Units can path to players, and will change Land Waves to Amphibious/Hover units if more than half of enemies can't be reached. Disable to prevent wave settings being over-ridden.",
        key = 'AmphibiousCheck',
		value_text = "  %s - Amphibious Check",
        value_help = "<LOC aiwave_0368>%s (Checks if Land Waves can reach Players.)",
        values = {
           
			'Enabled', 'Disabled'
        },
    },
	{
        default = 15,
        label = "<LOC aiwave_0369> 6d: LAND Wave Size Multiply",
        help = "<LOC aiwave_0370>Will increase or decrease the size of waves as game progresses. Can start with huge lower tech waves or have waves increase in size as game progresses.",
        key = 'WaveSizeMultiLand',
		value_text = "   %s Land Multiplier",
        value_help = "<LOC aiwave_0371>%s (Multiples Land Wave Size)",
        values = {
           
         '1 > 1.5 > 2 > 3 > 1.5', '1 > 1.25 > 1.5 > 2 > 1.25', '1 > 1.5 > 2 > 1.5 > 1', '1 > 2 > 3 > 2 > 1', '1 > 2 > 4 > 8 > 16', '1 > 2 > 4 > 8 > 12', '1 > 2 > 4 > 6 > 8', '1 > 2 > 3 > 4 > 5', '1 > 1.5 > 2 > 2.5 > 3', '1 > 1.25 > 1.5 > 1.75 > 2', '1 > 1.2 > 1.4 > 1.6 > 1.8', '1 > 1.15 > 1.3 > 1.45 > 1.6', '1 > 1.1 > 1.2 > 1.3 > 1.4', '1 > 1.05 > 1.1 > 1.15 > 1.2', 
		 "No",
		 "1.2 > 1.15 > 1.1 > 1.05 > 1", "1.4 > 1.3 > 1.2 > 1.1 > 1", "1.6 > 1.45 > 1.3 > 1.15 > 1", "1.8 > 1.6 > 1.4 > 1.2 > 1", "2 > 1.75 > 1.5 > 1.25 > 1", "3 > 2.5 > 2 > 1.5 > 1", "5 > 4 > 3 > 2 > 1", "8 > 6 > 4 > 2 > 1", "12 > 6 > 4 > 2 > 1", "16 > 6 > 4 > 2 > 1", "4 > 4 > 4 > 2 > 1", "3 > 3 > 3 > 2 > 1", "2 > 2 > 2 > 1.5 > 1", "1 > 1 > 1 > 1.5 > 2", "1 > 1 > 1.5 > 2 > 3", "1 > 1 > 2 > 3 > 3"
        },
    },
	{
        default = 6,
        label = "<LOC aiwave_0372> 6e: LAND Experimental/Boss Frequency",
        help = "<LOC aiwave_0373> Will increase or decrease spawn rate of Land Experimentals and Mini Bosses.",
        key = 'ExpMulti',
		value_text = "  %s percent Land T4/Boss",
        value_help = "<LOC aiwave_0374>%s (Percent)",
        values = {
           
			'10', '20', '30', '40', '50', '60', '70', '80', '90', '100', '110', '120', '130', '140', '150', '160', '170', '180', '190', '200'
        },
    },
	{
        default = 9,
        label = "<LOC aiwave_0375>7a: AIR UNITS Per Player",
        help = "<LOC aiwave_0376>Number of Air Units Per Player.",
        key = 'AirPerWave',
		value_text = "  %s units Air",
        value_help = "<LOC aiwave_0377>%s (Air Per Player)",
        values = {
           
         '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '22', '24', '26', '28', '32', '36', '40', '44', '48', '52', '56', '60', '64', '68', '72', '76', '80', '100', '150', '200'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0378> 7b: AIR ASF & Torp Bombers On/Off",
        help = "<LOC aiwave_0379> Sets if Air Superior Fighters and Torp Bombers spawn. Off = No ASF or Torp Bombers.",
        key = 'ASFWaves',
		value_text = "  Air Special - %s",
        value_help = "<LOC aiwave_0380>%s (Air Waves)",
        values = {
           
			'ASF', 'Torp Bombers', 'ASF+Torp Bombers', 'Off'
        },
    },
	{
        default = 15,
        label = "<LOC aiwave_0381> 7c: AIR Wave Size Multiply",
        help = "<LOC aiwave_0382>Will increase or decrease the size of waves as game progresses. Can start with huge lower tech waves or have waves increase in size as game progresses. Syncs with Air Delay (if on), so first value applies to start of Air waves.",
        key = 'WaveSizeMultiAir',
		value_text = "   %s Air Multiplier",
        value_help = "<LOC aiwave_0383>%s (Multiples Air Wave Size)",
        values = {
           
         '1 > 1.5 > 2 > 3 > 1.5', '1 > 1.25 > 1.5 > 2 > 1.25', '1 > 1.5 > 2 > 1.5 > 1', '1 > 2 > 3 > 2 > 1', '1 > 2 > 4 > 8 > 16', '1 > 2 > 4 > 8 > 12', '1 > 2 > 4 > 6 > 8', '1 > 2 > 3 > 4 > 5', '1 > 1.5 > 2 > 2.5 > 3', '1 > 1.25 > 1.5 > 1.75 > 2', '1 > 1.2 > 1.4 > 1.6 > 1.8', '1 > 1.15 > 1.3 > 1.45 > 1.6', '1 > 1.1 > 1.2 > 1.3 > 1.4', '1 > 1.05 > 1.1 > 1.15 > 1.2', 
		 "No",
		 "1.2 > 1.15 > 1.1 > 1.05 > 1", "1.4 > 1.3 > 1.2 > 1.1 > 1", "1.6 > 1.45 > 1.3 > 1.15 > 1", "1.8 > 1.6 > 1.4 > 1.2 > 1", "2 > 1.75 > 1.5 > 1.25 > 1", "3 > 2.5 > 2 > 1.5 > 1", "5 > 4 > 3 > 2 > 1", "8 > 6 > 4 > 2 > 1", "12 > 6 > 4 > 2 > 1", "16 > 6 > 4 > 2 > 1", "4 > 4 > 4 > 2 > 1", "3 > 3 > 3 > 2 > 1", "2 > 2 > 2 > 1.5 > 1", "1 > 1 > 1 > 1.5 > 2", "1 > 1 > 1.5 > 2 > 3", "1 > 1 > 2 > 3 > 3"
        },
    },
	{
        default = 6,
        label = "<LOC aiwave_0384> 7d: AIR Experimental/Boss Frequency",
        help = "<LOC aiwave_0385> Will increase or decrease spawn rate of Air Experimentals and Mini Bosses.",
        key = 'AirExpMulti',
		value_text = "  %s percent Air T4/Boss",
        value_help = "<LOC aiwave_0386>%s (Percent)",
        values = {
           
			'10', '20', '30', '40', '50', '60', '70', '80', '90', '100', '110', '120', '130', '140', '150', '160', '170', '180', '190', '200'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0387>8a: NAVAL UNITS Per Player",
        help = "<LOC aiwave_0388>Number of Naval Units Per Player.",
        key = 'NavyPerWave',
		value_text = "  %s units Navy",
        value_help = "<LOC aiwave_0389>%s (Naval Per Player)",
        values = {
           
         '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '22', '24', '26', '28', '32', '36', '40', '44', '48', '52', '56', '60', '64', '68', '72', '76', '80', '100', '150', '200'
        },
    },
	{
        default = 15,
        label = "<LOC aiwave_0390> 8b: NAVAL Wave Size Multiply",
        help = "<LOC aiwave_0391>Will increase or decrease the size of waves as game progresses. Can start with huge lower tech waves or have waves increase in size as game progresses. Syncs with Naval Delay (if on), so first value applies to start of Naval waves.",
        key = 'WaveSizeMultiNaval',
		value_text = "   %s Naval Multiplier",
        value_help = "<LOC aiwave_0392>%s (Multiples Naval Wave Size)",
        values = {
           
         '1 > 1.5 > 2 > 3 > 1.5', '1 > 1.25 > 1.5 > 2 > 1.25', '1 > 1.5 > 2 > 1.5 > 1', '1 > 2 > 3 > 2 > 1', '1 > 2 > 4 > 8 > 16', '1 > 2 > 4 > 8 > 12', '1 > 2 > 4 > 6 > 8', '1 > 2 > 3 > 4 > 5', '1 > 1.5 > 2 > 2.5 > 3', '1 > 1.25 > 1.5 > 1.75 > 2', '1 > 1.2 > 1.4 > 1.6 > 1.8', '1 > 1.15 > 1.3 > 1.45 > 1.6', '1 > 1.1 > 1.2 > 1.3 > 1.4', '1 > 1.05 > 1.1 > 1.15 > 1.2', 
		 "No",
		 "1.2 > 1.15 > 1.1 > 1.05 > 1", "1.4 > 1.3 > 1.2 > 1.1 > 1", "1.6 > 1.45 > 1.3 > 1.15 > 1", "1.8 > 1.6 > 1.4 > 1.2 > 1", "2 > 1.75 > 1.5 > 1.25 > 1", "3 > 2.5 > 2 > 1.5 > 1", "5 > 4 > 3 > 2 > 1", "8 > 6 > 4 > 2 > 1", "12 > 6 > 4 > 2 > 1", "16 > 6 > 4 > 2 > 1", "4 > 4 > 4 > 2 > 1", "3 > 3 > 3 > 2 > 1", "2 > 2 > 2 > 1.5 > 1", "1 > 1 > 1 > 1.5 > 2", "1 > 1 > 1.5 > 2 > 3", "1 > 1 > 2 > 3 > 3"
        },
    },
	{
        default = 5,
        label = "<LOC aiwave_0393> 8c: NAVAL Experimental Frequency",
        help = "<LOC aiwave_0394> Will increase or decrease spawn rate of Navy Experimentals.",
        key = 'NavyExpMulti',
		value_text = "  %s percent Navy T4/Boss",
        value_help = "<LOC aiwave_0395>%s (Percent)",
        values = {
           
			'10', '20', '30', '40', '50', '60', '70', '80', '90', '100', '110', '120', '130', '140', '150', '160', '170', '180', '190', '200'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0396>9: Land/Air/Navy Experimentals On/Off",
        help = "<LOC aiwave_0397> Sets if Experimentals will spawn in Land/Air/Naval waves.",
        key = 'ExperimentalSpawns',
		value_text = "  Experimentals %s",
        value_help = "<LOC aiwave_0398>%s (Experimentals Spawn)",
        values = {
           
			'Land+Air+Navy', 'Land+Air', 'Land+Navy', 'Air+Navy', 'Land', 'Air', 'Navy', 'Off'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0399>10: Special Option for Unit Packs",
        help = "<LOC aiwave_0400> Unit Packs like Total Mayhem, Extreme Wars, and a few others have Experimental T1/T2/T3 Units. Below settings allow to adjust their spawn frequency. Units are determined by Mass Costs if they are an Experimental and their spawn rates will be adjusted.",
        key = 'TotalMayhemWaves',
		value_text = "  %s",
        value_help = "<LOC aiwave_0401>%s (T1/T2/T3 Experimental Spawn)",
        values = {
           
			"Not Adjustable - Totally Random!", "Adjustable T1/T2/T3 Experimentals"
        },
    },
	{
        default = 10,
        label = "<LOC aiwave_0402> 10a: Land T1/T2/T3 Experimental Frequency",
        help = "<LOC aiwave_0403> Will increase or decrease spawn rate of T1/T2/T3 Land Experimentals.",
        key = 'TotalMayhemLand',
		value_text = "  %s %% Land T1/T2/T3 Experimental",
        value_help = "<LOC aiwave_0404>%s (Percent)",
        values = {
           
			'10', '20', '30', '40', '50', '60', '70', '80', '90', '100', '110', '120', '130', '140', '150', '160', '170', '180', '190', '200'
        },
    },
	{
        default = 10,
        label = "<LOC aiwave_0405> 10b: Air T1/T2/T3 Experimental Frequency",
        help = "<LOC aiwave_0406> Will increase or decrease spawn rate of T1/T2/T3 Air Experimentals.",
        key = 'TotalMayhemAir',
		value_text = "  %s %% Air T1/T2/T3 Experimental",
        value_help = "<LOC aiwave_0407>%s (Percent)",
        values = {
           
			'10', '20', '30', '40', '50', '60', '70', '80', '90', '100', '110', '120', '130', '140', '150', '160', '170', '180', '190', '200'
        },
    },
	{
        default = 10,
        label = "<LOC aiwave_0408> 10c: Navy T1/T2/T3 Experimental Frequency",
        help = "<LOC aiwave_0409> Will increase or decrease spawn rate of T1/T2/T3 Navy Experimentals.",
        key = 'TotalMayhemNavy',
		value_text = "  %s %% Navy T1/T2/T3 Experimental",
        value_help = "<LOC aiwave_0410>%s (Percent)",
        values = {
           
			'10', '20', '30', '40', '50', '60', '70', '80', '90', '100', '110', '120', '130', '140', '150', '160', '170', '180', '190', '200'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0411>       SPEED/HP SETTINGS",
        help = "Settings to increase speed and health of waves.",
        key = 'specialsettingskey',
		value_text = "%s",
        value_help = "",
        values = {
           
        '===================', 'Speed/HP Boost Settings'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0412>BOOST: HP Bonus",
        help = "<LOC aiwave_0413> HP Bonus increseas per second of game time. Bonus is further multipled as game progresses Beginning/Middle/Final/Endless. Land/Air x0.5/1/1.5/2, Navy x1/1.5/2/2.5 EXAMPLE: HP Bonus = 1, HoldTime = 30mins, Land Units Bonus = 0.5hp/s 1st 10mins, 1hp/s 2nd 10mins, 1.5hp/s 3rd 10mins, 2hp/s in Endless ",
        key = 'HPBonusAI',
		value_text = "  %s - HP Boost",
        value_help = "<LOC aiwave_0414>%s (HP per Second Bonus)",
        values = {
           
            '0', '0.25', '0.5', '0.75', '1', '1.25', '1.5', '1.75', '2', '2.5', '3', '3.5', '4', '4.5', '5', '6', '7', '8', '9', '10', '12', '14', '16', '18', '20'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0415>BOOST: Incremental Speed",
        help = "<LOC aiwave_0416>Increase Unit's Speed every Wave. Example: 0.05 = 5% Bonus. Land receives 100% bonus, Air/Navy receives 50%, EndBoss receives 30%",
        key = 'SpeedBonus',
		value_text = "  %s - SpeedBoost per Wave",
        value_help = "<LOC aiwave_0417>%s (Boost * Wave Number)",
        values = {
           
        '0', '0.006', '0.008', '0.01', '0.02', '0.03', '0.04' ,'0.05', '0.06', '0.07', '0.08', '0.09', '0.10', '0.11', '0.12', '0.13', '0.14', '0.15', '0.16', '0.17', '0.18', '0.19', '0.20'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0418>BOOST: Single SpeedBoost",
        help = "<LOC aiwave_0419> Increases enemy speed once. Example: 0.05 = 5% Bonus. Land receives 100% bonus, Air/Navy receives 50%, EndBoss receives 30%",
        key = 'SpeedBonusOnce',
		value_text = "  %s - Single SpeedBoost",
        value_help = "<LOC aiwave_0420>(One time Speed Boost)",
        values = {
           
        '0', '0.05', '0.1', '0.15', '0.2', '0.25', '0.3', '0.4', '0.5', '0.6', '0.7', '0.8', '0.9', '1'
        },
    },
	{
        default = 9,
        label = "<LOC aiwave_0421>BOOST: Damage Amplification",
        help = "<LOC aiwave_0422> Will activate a Damage Boost for all units, once Teams start producing enough mass, 250 Mass * Number_of_Players (HQ and HQ Allies do not count). Damage Boost increases based on Team mass production (default is 1 point Damage per 100 mass produced). Paragons greatly increase damage output, for each Paragon built. Boss Units gain 4x the Damage Boost.",
        key = 'DamageBoost',
		value_text = "  %sx Damage Boost",
        value_help = "<LOC aiwave_0423>(Damage Amplification)",
        values = {
           
        '5', '4', '3', '2.5', '2', '1.75', '1.5', '1.25', '1', '0.75', '0.5', '0.25', 'Off - 0'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0424>       AIRDROPS",
        help = "Controls the spawning of Air Dropped Units.",
        key = 'airdropbreakkey',
		value_text = "%s",
        value_help = "",
        values = {
           
        '===================', 'Airdropped Units'
        },
    },
	{
        default = 12,
        label = "<LOC aiwave_0425>DROPS: Airdrops On/Off",
        help = "<LOC aiwave_0426> Sets if Air Drops are on and how frequent they occur. Transports are affected by the Wave Tech Delay setting above.",
        key = 'TransportFrequency',
		value_text = "  Transports %s",
        value_help = "<LOC aiwave_0427>(Transport Spawn Frequency)",
        values = {
           
			'Off', 'Every 1 to 2 Minutes', 'Every 2 to 3 Minutes', 'Every 3 to 4 Minutes', 'Every 4 to 5 Minutes', 'Every 6 to 7 Minutes', 'Every 8 to 9 Minutes', 'Every 9 to 10 Minutes', 'Every 1 to 3 Minutes', 'Every 2 to 4 Minutes', 'Every 3 to 5 Minutes', 'Every 4 to 6 Minutes', 'Every 6 to 8 Minutes', 'Every 8 to 10 Minutes', 'Every 1 to 4 Minutes', 'Every 2 to 5 Minutes', 'Every 3 to 6 Minutes', 'Every 4 to 7 Minutes', 'Every 5 to 8 Minutes', 'Every 6 to 9 Minutes'
        },
    },
	{
        default = 2,
        label = "<LOC aiwave_0428>DROPS: Airdrops per Wave",
        help = "<LOC aiwave_0429> Sets how many transports spawn per wave.",
        key = 'InitialTransports',
		value_text = "  %s Transports",
        value_help = "<LOC aiwave_0430>(Number of Transports)",
        values = {
           
        '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '22', '24', '26', '28', '30'
        },
    },
	{
        default = 10,
        label = "<LOC aiwave_0431>DROPS: Airdrops Wave Multiply",
        help = "<LOC aiwave_0432>Will increase or decrease the size of waves as game progresses.",
        key = 'TransportMultiplier',
		value_text = "   %s Transport Multiplier",
        value_help = "<LOC aiwave_0433>(Multiples Transport Wave Size)",
        values = {
           
         '1 > 1.5 > 2 > 3 > 1.5', '1 > 1.25 > 1.5 > 2 > 1.25', '1 > 1.5 > 2 > 1.5 > 1', '1 > 2 > 3 > 2 > 1', '1 > 2 > 4 > 8 > 16', '1 > 2 > 4 > 8 > 12', '1 > 2 > 4 > 6 > 8', '1 > 2 > 3 > 4 > 5', '1 > 1.5 > 2 > 2.5 > 3', '1 > 1.25 > 1.5 > 1.75 > 2', '1 > 1.2 > 1.4 > 1.6 > 1.8', '1 > 1.15 > 1.3 > 1.45 > 1.6', '1 > 1.1 > 1.2 > 1.3 > 1.4', '1 > 1.05 > 1.1 > 1.15 > 1.2', 
		 "No",
		 "1.2 > 1.15 > 1.1 > 1.05 > 1", "1.4 > 1.3 > 1.2 > 1.1 > 1", "1.6 > 1.45 > 1.3 > 1.15 > 1", "1.8 > 1.6 > 1.4 > 1.2 > 1", "2 > 1.75 > 1.5 > 1.25 > 1", "3 > 2.5 > 2 > 1.5 > 1", "5 > 4 > 3 > 2 > 1", "8 > 6 > 4 > 2 > 1", "12 > 6 > 4 > 2 > 1", "16 > 8 > 4 > 2 > 1", "4 > 4 > 4 > 2 > 1", "3 > 3 > 3 > 2 > 1", "2 > 2 > 2 > 1.5 > 1", "1 > 1 > 1 > 1.5 > 2", "1 > 1 > 1.5 > 2 > 3", "1 > 1.5 > 2 > 2 > 2", "1 > 1 > 2 > 3 > 3", "1 > 2 > 2 > 3 > 3", "1 > 2 > 2 > 3 > 4", "1 > 2 > 3 > 4 > 4"
        },
    },
	{
        default = 3,
        label = "<LOC aiwave_0434>DROPS: Airdrops Start Time",
        help = "<LOC aiwave_0435> Sets the time after Holdtime begins that Transports will start.",
        key = 'TransportsToStartTime',
		value_text = "  %s %% Airdrop Holdtime Start",
        value_help = "<LOC aiwave_0436>(How soon Transports start spawning.)",
        values = {
           
        '0.05', '0.10', '0.15', '0.20', '0.25', '0.30', '0.35', '0.40', '0.45', '0.50', '0.55', '0.60', '0.65', '0.70', '0.75', '0.80', '0.85', '0.90', '0.95'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0437>DROPS: Airdrops End Time",
        help = "<LOC aiwave_0438> Sets the time after Endgame begins that Transports will stop. Endless means transports never stop spawning.",
        key = 'TransportEndTime',
		value_text = "  %s %% Airdrop Holdtime Stop",
        value_help = "<LOC aiwave_0439>(How long after EndGame begins till Transports Stop)",
        values = {
           
        'Endless --', '1.00', '1.10', '1.20', '1.30', '1.40', '1.50', '1.60', '1.70', '1.80', '1.90', '2.00', '3.00', '4.00', '5.00'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0440>DROPS: Airdrops Unit Types",
        help = "<LOC aiwave_0441> Sets the types of units carried by the transports. The 'All Units' option will restrict whatever races are not enabled.",
        key = 'TransportUnits',
		value_text = "  %s",
        value_help = "<LOC aiwave_0442>(What units Transports carry.)",
        values = {
           
        "Bots+Tanks (Mixed Race)", "Only Bots (Mixed Race)", "Only Tanks (Mixed Race)", "Amphibious/Hover (Mixed Race)", "All Units"
        },
    },
	{
        default = 6,
        label = "<LOC aiwave_0443>DROPS: Airdrops RAMBOS",
        help = "<LOC aiwave_0444> Sets if Transports will drop SACU Rambo units.",
        key = 'RamboChance',
		value_text = "  %s percent Rambo AirDrop",
        value_help = "<LOC aiwave_0445>(Enables AirDrops of SACU Rambos.)",
        values = {
           
        'Off --', '10', '20', '30', '40', '50', '60', '70', '80', '90', '100', '110', '120', '130', '140', '150', '160', '170', '180', '190', '200'
        },
    },
	{
        default = 3,
        label = "<LOC aiwave_0446>DROPS: Airdrops Experimentals",
        help = "<LOC aiwave_0447> Sets if Transports will drop T4 units. Transports only carry one T4 unit at a time. Sets the frequency of the occurrence.",
        key = 'TransportExpChance',
		value_text = "  %s percent T4 AirDrop",
        value_help = "<LOC aiwave_0448>(Enables AirDrops of T4 Units.)",
        values = {
           
        'Off --', '10', '20', '30', '40', '50', '60', '70', '80', '90', '100', '110', '120', '130', '140', '150', '160', '170', '180', '190', '200'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0449>DROPS: Airdrops Spawn Location",
        help = "<LOC aiwave_0450> Sets where Transports will spawn in from.",
        key = 'TranSpawnLocation',
		value_text = "  Spawn %s",
        value_help = "<LOC aiwave_0451>(Where Transports Spawn)",
        values = {
           
        "All Sides", "North Side", "South Side", "East Side", "West Side", "East-West", "North-South", "Center Only", "From the HQ"
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0452>       EXTRA WAVES/RESPONSE",
        help = "Mini Bosses, 2ndary Objective, and Special Response Scripts.",
        key = 'extraresponsekey',
		value_text = "%s",
        value_help = "",
        values = {
           
        '===================', 'Special Wave Responses'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0453>1: Minor Boss Units On/Off",
        help = "<LOC aiwave_0454> Sets if Minor Land or Air Boss units spawn. Extra options add even more minor boss units that increase based on game enders. Extra Boss units WILL SPAWN even if Land/Air waves off.",
        key = 'MinorBossSpawns',
		value_text = "  MinorBoss %s",
        value_help = "<LOC aiwave_0455>%s (Minor Boss Spawn)",
        values = {
           
			'Land+Air', 'Land', 'Air', 'Land+ExtraAir', 'Air+ExtraLand', 'ExtraLand', 'ExtraAir', 'ExtraLand+ExtraAir', 'Off'
        },
    },
	{
        default = 7,
        label = "<LOC aiwave_0456>2a: AntiAir Response Wave",
        help = "<LOC aiwave_0457> Sets if Mini-CZARs (NOMANDERS) will spawn in response to Air Power. Size of waves can be adjusted.",
        key = 'NomanderSpawn',
		value_text = "  AntiAir Response Multi - %sx",
        value_help = "<LOC aiwave_0458>%s (AntiAir Waves On/Off)",
        values = {
           
			'Off 0', '0.25', '0.38', '0.5', '0.63', '0.75', '0.88', '1', '1.25', '1.38', '1.5', '1.63', '1.75', '1.88', '2'
        },
    },
	{
        default = 5,
        label = "<LOC aiwave_0459>2b: Extra ASF",
        help = "<LOC aiwave_0460> Sets if extra ASF will spawn and attack enemy air. Works independant of Anti-Air Response Wave (NOMANDERS). Spawns with air waves. Defaults are 1 ASF every two Gunships/Bombers, 1 ASF every four ASF, and 9 ASF every T4 Air.",
        key = 'ExtraASFEnabled',
		value_text = "  Extra ASF Multi - %sx",
        value_help = "<LOC aiwave_0461>%s (Extra ASF On/Off)",
        values = {
           
			'Off --', '0.25', '0.5', '0.75', '1', '1.25', '1.5', '1.75', '2', '2.5', '3', '3.5', '4', '4.5', '5', '6', '7', '8', '9', '10'
        },
    },
	{
        default = 5,
        label = "<LOC aiwave_0459>3: Extra Sub Response",
        help = "<LOC aiwave_0460> Will spawn Sub Hunters to counter player submarine spam. Default is 1 Hunter for every three T3 Subs, and 4 Hunters for every T4 Sub. A certain amount of submarines must be built before a response is triggered, based on player count.",
        key = 'SubResponseEnabled',
		value_text = "  Sub Response - %sx",
        value_help = "<LOC aiwave_0461>%s (Sub Response On/Off)",
        values = {
           
			'Off --', '0.25', '0.5', '0.75', '1', '1.25', '1.5', '1.75', '2', '2.5', '3', '3.5', '4', '4.5', '5', '6', '7', '8', '9', '10'
        },
    },
	{
        default = 4,
        label = "<LOC aiwave_0459>4: Carriers Spawn Air",
        help = "<LOC aiwave_0460> Aircraft Carriers will deploy aircraft. Default is 1 to 4 units per carrier. Multiplier will increase/decrease number. Carriers will spawn torp bombers in response to submerged units.",
        key = 'CarriersSpawnAir',
		value_text = "  Carrier Air - %sx",
        value_help = "<LOC aiwave_0461>%s (Sub Response On/Off)",
        values = {
           
			'Off --', '0.5', '0.75', '1', '1.25', '1.5', '1.75', '2', '2.5', '3', '3.5', '4', '4.5', '5'
        },
    },
	{
        default = 9,
        label = "<LOC aiwave_0462>5a: ACU Hunters",
        help = "<LOC aiwave_0463> Spawns dedicated ACU and SACU hunters. Modified Bricks, they are fast, High DPS, and explosive. Effective in water and on land. The more SACUs, the more Hunters.",
        key = 'ACUHunterTime',
		value_text = "  %s %% HoldTime till ACU Hunters",
        value_help = "<LOC aiwave_0464>(Percentage of Hold Time till Hunters Appear)",
        values = {
           
        'Off --', '0.50', '0.55', '0.60', '0.65', '0.70', '0.75', '0.80', '0.85', '0.90', '0.95', '1.00', '1.05', '1.10', '1.15', '1.20', '1.25'
        },
    },
	{
        default = 4,
        label = "<LOC aiwave_0465> 5b: ACU Hunters Wave Multi",
        help = "<LOC aiwave_0466> Will multiply the size of the wave.",
        key = 'ACUHunterSize',
		value_text = "  %s x ACU Hunters",
        value_help = "<LOC aiwave_0467>(Multiplies size of Hunter Waves.)",
        values = {
           
        '0.25', '0.5', '0.75', '1', '1.25', '1.5', '1.75', '2', '2.25', '2.5', '2.75', '3', '3.5', '4', '4.5', '5', '6', '7', '8', '9', '10'
        },
    },
	{
        default = 6,
        label = "<LOC aiwave_0468>6a: Paragon Punishment",
        help = "<LOC aiwave_0469>Starting a Paragon immediately triggers nukes, and then increases boss health and nukes per strike every X minutes. Setting to Off disables the script, including early nuke strikes.",
        key = 'ParagonCycle',
		value_text = "  %s min Paragon Punishment",
        value_help = "<LOC aiwave_0470>( How quickly Paragons increase difficutly. Turn Off for no difficulty increase. )",
        values = {
           
        'Off', '1' , '2', '3', '4', '5', '6', '7', '8', '9', '10'
        },
    },
	{
        default = 2,
        label = "<LOC aiwave_0471> 6b: Paragon Nuke",
        help = "<LOC aiwave_0472>Sets if starting a Paragon will immediately trigger nukes. Paragon Punishment option must be On. Offensive Nukes option must be on.",
        key = 'ParagonNuke',
		value_text = "  Paragon Nuke %s",
        value_help = "<LOC aiwave_0473>( Sets if Paragons trigger nuke script. )",
        values = {
           
        'On', 'Off'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0474>7: Yolona+Artillery Response",
        help = "<LOC aiwave_0475>Sets if HQ will retaliate against Yolonas and T3/T4 Artillery.",
        key = 'ArtyYolo',
		value_text = "  %s",
        value_help = "<LOC aiwave_0476>( Sets what Response Scripts are on. )",
        values = {
           
        'Yolona+Arty Response On', 'Yolona Response On', 'Artillery Response On', 'Yolona+Arty Response Off'
        },
    },
	{
        default = 2,
        label = "<LOC aiwave_0477>SB1: Spawn Support Bases",
        help = "<LOC aiwave_0478> Spawns a support bases between HQ Player and enemy players. Buildings spawn defensive structures every 4.5 mins until destroyed. Destroying all secondary structures will spawn reinforcments (if on) and power stall the HQ Player. Best to turn off on 5x5 maps. Random Map Spawn will spawn buildings around the map randomly (will not spawn next to player's spawn). Spawn Around HQ will only spawn buildings near the HQ.",
        key = 'SecondaryBuildingFlag',
		value_text = "  Bases %s",
        value_help = "<LOC aiwave_0479>%s (Support Bases - Optional Objectives)",
        values = {
           
        'Off', 'On - Random Map Spawn', 'On - Spawn Around HQ', "On - North Half", "On - South Half", "On - East Half", "On - West Half", "On - NE to SW Diagonal", "On - NW to SE Diagonal", "On - Center E to W", "On - Center N to S"
        },
    },
	{
        default = 6,
        label = "<LOC aiwave_0480>SB2: Support Bases Multipler",
        help = "<LOC aiwave_0481> Adjust to have more or fewer support bases! Bases are based on the number of players, rounded up, Bases = 1 + (Player Count / 2) * Modifier. Minimum count is 3 bases, and Maximum Count is 16 bases, regardless.",
        key = 'SupportBaseMulti',
		value_text = "  Base Count x%s",
        value_help = "<LOC aiwave_0482>%s (Adjust number of Support Bases)",
        values = {
           
        '0.5', '0.6', '0.7', '0.8', '0.9', '1', '1.1', '1.2', '1.3', '1.4', '1.5', '1.6', '1.7', '1.8', '1.9', '2', '2.25', '2.5', '2.75', '3', '3.25', '3.5', '3.75', '4'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0483>SB3: Nuke Retaliation",
        help = "<LOC aiwave_0484> Sets if Nuclear Strikes will be one of the retaliation scripts. Note: A nuclear strike will never be triggered by the destruction of the first Support Base.",
        key = 'SupportBaseNukes',
		value_text = "  %s",
        value_help = "<LOC aiwave_0485>%s (Support Base Nuclear Retaliation On/Off)",
        values = {
           
        'SB Nuke Retaliation - On', 'SB Nuke Retaliation - Off'
        },
    },
	{
        default = 3,
        label = "<LOC aiwave_0486> SB4: HQ Player Power Stall",
        help = "<LOC aiwave_0487> Sets the duration for how long the HQ Player will Power Stall if all Support Bases are destroyed. Power Stalling will disable all shields and any weapons that need power. If the HQ Player builds a Paragon, they will not power stall.",
        key = 'PowerStallTime',
		value_text = "  Power Stall - %s Mins",
        value_help = "<LOC aiwave_0488>%s (How long HQ Player power stalls if all Support Bases are destroyed)",
        values = {
           
        '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15'
        },
    },
	{
        default = 4,
        label = "<LOC aiwave_0486> SB5: Rift Orbs",
        help = "<LOC aiwave_0487> Enables Support Bases to deploy Rift Orbs, which will spawn additional units to attack players. Rift Orbs are deployed on EMP Nukes vulnerable to SMD. Every Support Base can support one Rift Orb. Rifts that are destroyed will eventually be redeployed. Any undeployed Rift Orbs are launched at Endgame. Rifts spawn more units based on team strength and building Endgamers.",
        key = 'RiftUnits',
		value_text = "  %s Units per Rift",
        value_help = "<LOC aiwave_0488>%s (Sets how many units spawn from each Rift.)",
        values = {
           
        'Off --', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0489>       ENDGAME SETTINGS",
        help = "Sets what waves/events happen after Hold Time ends.",
        key = 'endgamekey',
		value_text = "%s",
        value_help = "",
        values = {
           
        '===================', 'End Game Options'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0490>1a: Endless Land/Air/Navy Waves",
        help = "<LOC aiwave_0491> Regular waves and Minor Bosses continue till HQ destroyed.",
        key = 'Endless',
		value_text = "  Endless %s",
        value_help = "<LOC aiwave_0492>%s (Endless Waves)",
        values = {
           
        'Off', 'Land+Air+Navy', 'Land+Air', 'Land+Navy', 'Air+Navy', 'Land', 'Air', 'Navy'
        },
    },
	{
        default = 4,
        label = "<LOC aiwave_0493> 1b: Endless Delay (Mins)",
        help = "<LOC aiwave_0494> Adds addition time to Delay Between Waves once past Hold Time and if Endless Waves are on. (Does not affect Final Boss Waves)",
        key = 'ExtraWaveDelay',
		value_text = "  %s min Endless Delay",
        value_help = "<LOC aiwave_0495>%s (Extra Minutes Between Endless Waves)",
        values = {
           
        '0', '0.5', '0.75', '1', '1.25', '1.5', '1.75', '2', '2.5', '3', '3.5', '4', '4.5', '5', '6', '7', '8', '9', '10'
        },
    },
	{
        default = 4,
        label = "<LOC aiwave_0496>2a: BOSS LAND Units",
        help = "<LOC aiwave_0497> Adjust size of Land Boss Wave. Turn on Endless Boss Waves for repeat waves.",
        key = 'EndWaveMulti',
		value_text = "  %s units Land Boss",
        value_help = "<LOC aiwave_0498>%s (Land Units Boss Wave)",
        values = {
           
        '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '12', '14', '16', '18', '20', '24', '28', '32', '36', '40', '45', '50', '55', '60', '65', '70', '75', '80', '85', '90', '95', '100', '120', '140', '160', '180', '200'
        },
    },
	{
        default = 2,
        label = "<LOC aiwave_0499> 2b: BOSS AIR Units",
        help = "<LOC aiwave_0500> Adjust size of Air Boss Wave. Turn on Endless Boss Waves for repeat waves.",
        key = 'EndWaveAir',
		value_text = "  %s units Air Boss",
        value_help = "<LOC aiwave_0501>%s (Air Units Boss Wave)",
        values = {
           
        '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '12', '14', '16', '18', '20', '24', '28', '32', '36', '40', '45', '50', '55', '60', '65', '70', '75', '80', '85', '90', '95', '100', '120', '140', '160', '180', '200'
        },
    },
	{
        default = 12,
        label = "<LOC aiwave_0502> 2c: BOSS Endless Final Wave",
        help = "<LOC aiwave_0503> Boss wave will continue till HQ destroyed. Off = Boss Wave won't repeat.",
        key = 'BossWaveEndlessSpawn',
		value_text = "  %s min Respawn Bosses, Off = No Repeat",
        value_help = "<LOC aiwave_0504>%s (Minutes between Boss Waves)",
        values = {
           
        'Off', '0.5', '0.75', '1', '1.25', '1.5', '1.75', '2', '2.5', '3', '3.5', '4', '4.5', '5', '6', '7', '8', '9', '10'
        },
    },
	{
        default = 2,
        label = "<LOC aiwave_0505>3a: ARTILLERY Endgame On/Off",
        help = "<LOC aiwave_0506> Turns Endgame Artillery On/Off. Setting to Repeat Spawn will have the event re-occur.",
        key = 'ArtyOn',
		value_text = "  Artillery - %s",
        value_help = "<LOC aiwave_0507>(Endgame Artillery On/Off)",
        values = {
           
        'On', 'On, Repeats Spawn', 'Off'
        },
    },
	{
        default = 11,
        label = "<LOC aiwave_0508> 3b: ARTILLERY Endgame Spawn Time",
        help = "<LOC aiwave_0509> Spawns x Mins after Hold Time",
        key = 'ArtySpawnTime',
		value_text = "  %s min till Artillery",
        value_help = "<LOC aiwave_0510>%s (Mins after Endgame Starts)",
        values = {
           
        '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '12', '14', '16', '18', '20'
        },
    },
    {
        default = 8,
        label = "<LOC aiwave_0511> 3c: ARTILLERY EndGame Type",
        help = "<LOC aiwave_0512> Select what artillery spawns for EndGame. Guardians are special artillery with T3 damage combined with T4 Range. Duke/Emissary/Disruptor/Hovatham are not recommended on 20km maps, as they cannot hit entire area.",
        key = 'ArtyType',
		value_text = "  %s",
        value_help = "<LOC aiwave_0513>%s (Endgame Artillery Type)",
        values = {
           
        'Mavor', 'RapidFire', 'Scathis', 'Duke', 'Emissary', 'Disruptor', 'Hovatham', 'Guardian (T3 DPS, T4 Range)'
        },
    },
	{
        default = 2,
        label = "<LOC aiwave_0514>4a: DOOM EndGame Wave",
        help = "<LOC aiwave_0515> DOOM units are powerful T5 Units. Destroying the DOOM Waves will damage the HQ. Dooms waves respawn 1 minute after being destroyed.",
        key = 'DoomCount',
		value_text = "  %s Dooms per Wave",
        value_help = "<LOC aiwave_0516>%s (Doom Wave Size)",
        values = {
           
        'Off --', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '12', '14', '16', '18', '20'
        },
    },
	{
        default = 10,
        label = "<LOC aiwave_0517> 4b: DOOM HQ Damage",
        help = "<LOC aiwave_0518> Sets what percentage of HQ's max health the HQ will lose with every DOOM Wave that is defeated. 25 percent would reduce the HQ Health by 1/4 per wave, killing HQ after 4th wave's defeat.",
        key = 'DoomDamageHQ',
		value_text = "  %s%% HQ Damage per Doom Wave",
        value_help = "<LOC aiwave_0519>%s (Percent of Health HQ losses each defeat of DOOM Wave.)",
        values = {
           
        '0', '1', '2.5', '5', '7.5', '10', '12.5', '15', '20', '25', '30', '35', '40', '45', '50', '60', '70', '80', '90', '100'
        },
    },
	{
        default = 7,
        label = "<LOC aiwave_0520> 4c: DOOM Wave +/-",
        help = "<LOC aiwave_0521> Increases/Decreases DOOM Wave size by the set amount each spawn. Waves will never go lower than 1.",
        key = 'DoomIncrease',
		value_text = "  %s +/- Units per Doom Wave",
        value_help = "<LOC aiwave_0522>%s (Adjusts wave size every respawn.)",
        values = {
           
        '-5', '-4', '-3', '-2', '-1', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0523> 4d: DOOM Minimum Wave Size",
        help = "<LOC aiwave_0524> Set a minimum wave size.",
        key = 'DoomMinimum',
		value_text = "  %s Doom Minimum Wave Size",
        value_help = "<LOC aiwave_0525>%s (Sets the smallest Doom Waves will become.)",
        values = {
           
        '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'
        },
    },
	{
        default = 3,
        label = "<LOC aiwave_0526> 4e: DOOM Maximum Wave Size",
        help = "<LOC aiwave_05267> Set a maximum wave size.",
        key = 'DoomMaximum',
		value_text = "  %s Doom Maximum Wave Size",
        value_help = "<LOC aiwave_0528>%s (Sets the maximum size Doom Waves will become.)",
        values = {
           
        'Off --', '2', '3', '4', '5', '6', '7', '8', '9', '10', '12', '14', '16', '18', '20', '24', '28', '32', '36', '40', '50', '60', '70', '80', '90', '100'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0529> 4f: DOOM Health Boost",
        help = "<LOC aiwave_0530> Increases DOOM units' base health by the set percentage.",
        key = 'DoomBoostHP',
		value_text = "  %s%% Doom Health Boost",
        value_help = "<LOC aiwave_0531>%s (Increases DOOM units' health.)",
        values = {
           
        '0', '5', '10', '15', '20', '25', '30', '35', '40', '45', '50', '60', '70', '80', '90', '100', '125', '150', '175', '200', '250', '300', '400', '500', '600', '700', '800', '900', '1000'
        },
    },
	{
        default = 11,
        label = "<LOC aiwave_0532> 4g: DOOM Storm Spawn",
        help = "<LOC aiwave_0533> Adjusts number of random electric storms around the map whenever a Doom Wave is defeated. There is a 50% chance storms will spawn after every wave. Default storm spawn numbers are 27 on 20+km maps, 9 on 10km maps, and 3 on 5km maps.",
        key = 'DoomStorm',
		value_text = "  %sx Doom Storm Spawns",
        value_help = "<LOC aiwave_0534>%s (Multiples how many storms will spawn around map.)",
        values = {
           
        'Off --', '0.1', '0.2', '0.3', '0.4', '0.5', '0.6', '0.7', '0.8', '0.9', '1', '1.1', '1.2', '1.3', '1.4', '1.5', '1.6', '1.7', '1.8', '1.9', '2', '2.25', '2.5', '2.75', '3', '3.5', '4', '5'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0535> 4h: DOOM Crawlers On/Off",
        help = "<LOC aiwave_0536> Enables the Doom Mega and Doom Fatboy spawning in Doom Waves.",
        key = 'DoomCrawlers',
		value_text = "  %s",
        value_help = "<LOC aiwave_0537>%s (Enables Doom Mega and Doom Fatboy)",
        values = {
           
        "Doom Mega + Doom Fatboy", "Doom Mega", "Doom Fatboy", "Crawlers Off"
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0538> 4i: DOOM Walkers On/Off",
        help = "<LOC aiwave_0539> Enables the Doom Colossus and Doom Ythotha spawning in Doom Waves.",
        key = 'DoomWalkers',
		value_text = "  %s",
        value_help = "<LOC aiwave_0540>%s (Enables Doom Colossus and Doom Ythotha)",
        values = {
           
        "Doom Colossus + Doom Ythotha", "Doom Colossus", "Doom Ythotha", "Walkers Off"
        },
    },
	{
        default = 2,
        label = "<LOC aiwave_0541>5a: Allied Reinforcements",
        help = "<LOC aiwave_0542> Spawns allied forces for player. Must destroy Secondary Objectives or survive to end of Hold Time to spawn. Allies are randomly distributed amoung players.",
        key = 'SpawnAlliesForceFlag',
		value_text = "  Allies - %s",
        value_help = "<LOC aiwave_0543>%s (Spawns Allies for Players)",
        values = {
           
        'On - Land + Air', 'On - Land Only', 'On - Air Only', 'Off'
        },
    },
	{
        default = 3,
        label = "<LOC aiwave_0544> 5b: Allied Force Multiplier",
        help = "<LOC aiwave_0545> Multiplies the number of Allies that spawn for the teams fighting the HQ. Allies are randomly distributed amoung players.",
        key = 'AlliedForceMultiplier',
		value_text = "  Allies Multipler - %sx",
        value_help = "<LOC aiwave_0546>%s (Multiplies the number of allied units that spawn.)",
        values = {
           
        '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0547>       ECO BOOST SETTINGS",
        help = "Controls extra Eco given to HQ, ACU's, HQ Allies, and Wreck Reclaim/Decay",
        key = 'ecoboostkey',
		value_text = "%s",
        value_help = "",
        values = {
           
        '===================', 'Eco and Wreck Options'
        },
    },
	{
        default = 3,
        label = "<LOC aiwave_0548>ECO 1: Starting ACU EcoBoost, 0 = Off",
        help = "<LOC aiwave_0549> Sets Mass and Energy of all ACU not allied with HQ. Starts 20 seconds after game begins. Will override RAS, unless off. 0 = Off",
        key = 'HumanEcoBoost',
		value_text = "  %s - EcoBoost",
        value_help = "<LOC aiwave_0550>%s (Mass * 1, Energy * 75)",
        values = {
           
        '0', '10', '15', '20', '25', '30', '35', '40', '45', '50', '60', '70', '80', '90', '100', '120', '140', '160', '180', '200', '250', '300', '350', '400', '450', '500'
        },
    },
	{
        default = 3,
        label = "<LOC aiwave_0551>ECO 2a: Endgame EcoBoost, 0 = Off",
        help = "<LOC aiwave_0552> Sets Mass and Energy of Human ACU for Endgame. Activates 60 Seconds before Endgame stage. Works even if Starting ACU EcoBoost is Off. 0 = Off",
        key = 'EndGameEcoBoost',
		value_text = "  %s - EndGame EcoBoost, 0 = Off",
        value_help = "<LOC aiwave_0553>%s (Mass * 1, Energy * 75), will work even if Starting ACU EcoBoost is Off.",
        values = {
           
        '0', '50', '75', '100', '125', '150', '175', '200', '225', '250', '275', '300', '325', '350', '375', '400', '425', '450', '475', '500', '600', '700', '800', '900', '1000'
        },
    },
	{
        default = 4,
        label = "<LOC aiwave_0554> ECO 2b: Endgame EcoBoost Start Time",
        help = "<LOC aiwave_0555> Sets how many Minutes before end of Hold Time that Endgame EcoBoost Starts.",
        key = 'EndEcoBoostTime',
		value_text = "  %s min EndGame EcoBoost",
        value_help = "<LOC aiwave_0556>%s (Minutes before EndGame Starts)",
        values = {
           
        '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '12', '14', '16', '18', '20'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0557>ECO 3: HQ Allies EcoBoost, 0 = Off",
        help = "<LOC aiwave_0558> Grants an EcoBoost to any Allies of the HQ Player. Only affects Allied ACUs, not the HQ Player's ACU. 0 = Off",
        key = 'HQAllyEcoBoost',
		value_text = "  %s - HQ Allies EcoBoost",
        value_help = "<LOC aiwave_0559>%s (Mass * 1, Energy * 75)",
        values = {
           
        '0', '10', '15', '20', '25', '30', '35', '40', '45', '50', '60', '70', '80', '90', '100', '120', '140', '160', '180', '200', '250', '300', '350', '400', '450', '500', '600', '700', '800', '900', '1000'
        },
    },
	{
        default = 10,
        label = "<LOC aiwave_0560>ECO 4a: Wreck Removal",
        help = "<LOC aiwave_0561> Sets how long wrecks stick around for reclaim, in seconds. Setting to 1 sec clears wrecks almost immediately. Good if you want to play with No Air Crash mod.",
        key = 'WreckDespawn',
		value_text = "  Wrecks Despawn in %s sec",
        value_help = "<LOC aiwave_0562>%s (seconds)",
        values = {
           
        '1', '15', '30', '45', '60', '75', '90', '120', '150', '180', '210', '240', '300', '360', '420', '480', '540', '600'
        },
    },
	{
        default = 4,
        label = "<LOC aiwave_0563> ECO 4b: Wreck Reclaim Rate",
        help = "<LOC aiwave_0564> Sets how quickly wrecks are reclaimed. Make it harder or easier to reclaim!",
        key = 'WreckReclaim',
		value_text = "  Reclaim at %sx Rate",
        value_help = "<LOC aiwave_0565>%s (Speed of Wreck Reclaim)",
        values = {
           
        '0.25', '0.5', '0.75', '1', '1.25', '1.5', '1.75', '2', '4', '6', '8', '10', '20'
        },
    },
	{
        default = 3,
        label = "<LOC aiwave_0566>ECO 5a: HQ Mass Production",
        help = "<LOC aiwave_0567>Mass Generated by HQ for AI. HQ produces 10000 after Hold Time ends.",
        key = 'HQMass',
		value_text = "  %s mass HQ",
        value_help = "<LOC aiwave_0568>%s (Mass)",
        values = {
           
        '10', '25', '50', '75', '100', '150', '200', '250', '500', '750', '1000', '2000' ,'3000', '4000', '5000', '10000'
        },
    },
		{
        default = 5,
        label = "<LOC aiwave_0569> ECO 5b: HQ Energy Production",
        help = "<LOC aiwave_0570>Energy Generated by HQ for AI. HQ produces 1000000 after Hold Time ends.",
        key = 'HQEnergy',
		value_text = "  %s energy HQ",
        value_help = "<LOC aiwave_0571>%s (Energy)",
        values = {
           
        '1000', '2500', '5000', '7500', '10000', '15000', '20000', '25000', '50000', '75000', '100000', '200000' ,'300000', '400000', '500000', '1000000'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0572>       NUKE STRIKE SETTINGS",
        help = "",
        key = 'nukewavekey',
		value_text = "%s",
        value_help = "",
        values = {
           
        '===================', 'Nuclear Strike Options'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0573>NUKE: Strikes On/Off",
        help = "<LOC aiwave_0574> Turns scripted Nukes off. Offensive target player bases. Defensive target units too close to HQ. AI may still build nukes.",
        key = 'NukesOn',
		value_text = "  Nukes - %s",
        value_help = "<LOC aiwave_0575>(Nukes On/Off)",
        values = {
           
        'All On', 'Offensive', 'Defensive',  'Off'
        },
    },
	{
        default = 9,
        label = "<LOC aiwave_0576>NUKE: Strikes Start Time",
        help = "<LOC aiwave_0577> When Nuke Strikes Start, as a Percentage of Hold Time. Default is 0.85, which is 85%.",
        key = 'NukeTime',
		value_text = "  %s %% HoldTime till Nukes",
        value_help = "<LOC aiwave_0578>(Percentage of Hold Time till Nukes Launch)",
        values = {
           
        '0.50', '0.55', '0.60', '0.65', '0.70', '0.75', '0.80', '0.85', '0.90', '0.95', '1.00', '1.05', '1.10', '1.15', '1.20', '1.25'
        },
    },
	{
        default = 16,
        label = "<LOC aiwave_0579>NUKE: Strike Frequency",
        help = "<LOC aiwave_0580> Delays the random time of potential strikes. Lowest value is once every 5 to 6 minutes.",
        key = 'NukeStrikeEveryAI',
		value_text = "  Nukes Every %s",
        value_help = "<LOC aiwave_0581>(Recurring Nuclear Strikes)",
        values = {
         
		'1 to 2 Mins', '1 to 3 Mins', '1 to 4 Mins', '2 to 3 Mins', '2 to 4 Mins', '2 to 5 Mins', '3 to 4 Mins', '3 to 5 Mins', '3 to 6 Mins', 
		'4 to 5 Mins', '4 to 6 Mins', '4 to 7 Mins', '5 to 6 Mins', '5 to 7 Mins', '5 to 8 Mins', '6 to 7 Mins', '6 to 8 Mins', '6 to 9 Mins', 
		'7 to 8 Mins', '7 to 9 Mins', '7 to 10 Mins', '8 to 9 Mins', '8 to 10 Mins', '8 to 11 Mins', '9 to 10 Mins', '9 to 11 Mins', '9 to 12 Mins'
        },
    },
	{
        default = 2,
        label = "<LOC aiwave_0582>NUKE: Nukes Per Strike",
        help = "<LOC aiwave_0583> Increases the random amount of nukes fired from various events. Recommend 1-2 SMD per player per level selected.",
        key = 'NukesPerStrikeAI',
		value_text = "  %s Nukes",
        value_help = "<LOC aiwave_0584>(More Nukes per Strike)",
        values = {
           
         'Fewest', 'Few', 'Regular', 'More', 'Most'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0585>NUKE: Increase Nukes Per Strike",
        help = "<LOC aiwave_0586> Will increase the nuke count after every strike.",
        key = 'NukeIncreasePerStrike',
		value_text = "  %s Extra Nukes every Strike",
        value_help = "<LOC aiwave_0587>(Increases Nukes launched after every strike.)",
        values = {
           
         '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0588>NUKE: Nuclear Overwhelm",
        help = "<LOC aiwave_0589> Works independant of other scripts in NUKE STRIKES. Increases the number of nukes fired per every PAIR (2) of players for every X minutes of time after Waves start. You WILL eventually be overwhelmed.",
        key = 'NuclearOverwhelm',
		value_text = "  Overwhelm - %s",
        value_help = "<LOC aiwave_0590>(Increases Nukes per Every 2 PLAYERS per Minute)",
        values = {
           
         'Off', '1 per 5 Mins', '1 per 4 Mins', '1 per 3 Mins', '1 per 2 Mins', '1 per Min', '2 per Min', '3 per Min'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0591>       BUILD RESTRICTIONS",
        help = "",
        key = 'buildrestrictionkey',
		value_text = "%s",
        value_help = "",
        values = {
           
        '===================', 'Build Restriction Options'
        },
    },
	{
        default = 11,
        label = "<LOC aiwave_0592>BUILD: Max Hives Per Player",
        help = "<LOC aiwave_0593>Set the Max Number of Hives Per Player.",
        key = 'HivesPerPlayerAI',
		value_text = "  %s Hives per Player",
        value_help = "<LOC aiwave_0594>%s (Hives Per Player)",
        values = {
           
        '20', '30' ,'40', '50', '60', '70', '80', '90', '100', '120', '140', '160', '180', '200', '250', '500'
        },
    },
	{
        default = 2,
        label = "<LOC aiwave_0595>BUILD: Paragon On/Off",
        help = "<LOC aiwave_0596>Sets if Paragon is available at start of game, at midgame (70% of HoldTime), or completely disabled.",
        key = 'EndGameParagon',
		value_text = "  %s",
        value_help = "<LOC aiwave_0597>( Sets if/when Paragon is Available. )",
        values = {
           
        'Paragon No Restrictions', 'Paragon Midgame', 'Paragon Disabled'
        },
    },
	{
        default = 2,
        label = "<LOC aiwave_0598>BUILD: Yolona On/Off",
        help = "<LOC aiwave_0599>Sets if Yolona is available at start of game, at midgame (70% of HoldTime), or completely disabled.",
        key = 'EndGameYolo',
		value_text = "  %s",
        value_help = "<LOC aiwave_0600>( Sets if/when Yolona is Available. )",
        values = {
           
        'Yolona No Restrictions', 'Yolona Midgame', 'Yolona Disabled'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0601>BUILD: T4AA + EMP Tacs On/Off",
        help = "<LOC aiwave_0602>Sets if T4AA and/or EMP Tacs will become available later in the game. T4AA is available at 50% HoldTime, EMP Tacs at 60% HoldTime.",
        key = 'SpecialWeapons',
		value_text = "  %s",
        value_help = "<LOC aiwave_0603>( Sets if T4AA and EMP Tacs available. )",
        values = {
           
        "T4AA + EmpTacs Enabled", "T4 AA Enabled", "EmpTacs Enabled", "T4AA + EmpTacs Off"
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0604>BUILD: Buildable Arty/Nukes/Sat",
        help = "<LOC aiwave_0605>Sets if/when T3/T4 Artillery, T3 Nukes, UEF Sat, and Strategic Subs/Battelship are buildable. Good for Survival Versus to delay rushing Nukes and Artillery.",
        key = 'ArtyNukeEnable',
		value_text = "  %s",
        value_help = "<LOC aiwave_0606>( Sets when Artillery, Nukes, Sat, and NukeSubs available. )",
        values = {
           
        "No Restrictions (Buildable Arty/Nukes/Sat)", "Enable at 25 % HoldTime", "Enable at 33 % HoldTime", "Enable at 40 % HoldTime", "Enable at 50 % HoldTime", "Enable at 60 % HoldTime", 
		"Enable at 70 % HoldTime", "Enable at 80 % HoldTime", "Enable at 90 % HoldTime", "Enable at 100 % HoldTime", "Buildable Arty/Nukes/Sat Disabled"
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0607>BUILD: HQ Allies Restrictions",
        help = "<LOC aiwave_0608>Sets if players allied with HQ can build Mass Fabs, RAS Subcoms, and the special T4 Weapons included with AI Wave Survival.",
        key = 'HQAllyRestrict',
		value_text = "  %s",
        value_help = "<LOC aiwave_0609>( Sets Restrictions for HQ Allies )",
        values = {
           
        "HQ Allies No Restrictions", "HQ Allies No FABs/RAS", "HQ Allies No T4 Weapons", "HQ Allies All Restricted"
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0610>       SPECIAL SETTINGS",
        help = "<LOC aiwave_0611> ",
        key = 'specialkey',
		value_text = "%s",
        value_help = "<LOC aiwave_0612> ",
        values = {
           
        '===================', 'Special Wave Options'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0613>Land Crazy Mode",
        help = "<LOC aiwave_0614> Restrict Land Waves to only spawn a single Tech Level!",
        key = 'CrazyModeLand',
		value_text = "  %s",
        value_help = "<LOC aiwave_0615>%s (Spawns Only the Set Tech Level)",
        values = {
           
        'Normal Land', 'Tech 1 Land Only', 'Tech 2 Land Only', 'Tech 3 Land Only', 'Experimental Land Only', 'Minor Land Boss Only', 'EndGame Land Boss Only'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0616>Air Crazy Mode",
        help = "<LOC aiwave_0617> Restrict Air Waves to only spawn a single Tech Level!",
        key = 'CrazyModeAir',
		value_text = "  %s",
        value_help = "<LOC aiwave_0618>%s (Spawns Only the Set Tech Level)",
        values = {
           
        'Normal Air', 'Tech 1 Air Only', 'Tech 2 Air Only', 'Tech 3 Air Only', 'Experimental Air Only', 'Minor Air Boss Only', 'EndGame Air Boss Only'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0619>Navy Crazy Mode",
        help = "<LOC aiwave_0620> Restrict Navy Waves to only spawn a single Tech Level!",
        key = 'CrazyModeNavy',
		value_text = "  %s",
        value_help = "<LOC aiwave_0621>%s (Spawns Only the Set Tech Level)",
        values = {
           
        'Normal Navy', 'Tech 1 Navy Only', 'Tech 2 Navy Only', 'Tech 3 Navy Only', 'Experimental Navy Only'
        },
    },
	{
        default = 1,
        label = "<LOC aiwave_0622>==END AI WAVE SURVIVAL==",
        help = "<LOC aiwave_0623> End of Settings for AI Wave Survival Mod",
        key = 'EndOfSettings',
		value_text = "%s",
        value_help = "<LOC aiwave_0624>GL and HF!",
        values = {
           
        'Good Luck! Have Fun!', 'Thanks to AKarmy01!', 'Try PvP w/ Mod!'
        },
    }
}