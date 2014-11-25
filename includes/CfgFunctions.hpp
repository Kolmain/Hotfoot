class CfgFunctions
{
	class KOL
	{
		class gamemode
		{
			class createAmbientEnviroment
			{
				preInit = 0; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				postInit = 0; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
				recompile = 1; // 1 to recompile the function upon mission start
				ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
			};
			class initPlayer
			{
				preInit = 0; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				postInit = 0; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
				recompile = 1; // 1 to recompile the function upon mission start
				ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
			};
			class initHotfoot
			{
				preInit = 0; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				postInit = 0; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
				recompile = 1; // 1 to recompile the function upon mission start
				ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
			};
			class epilogue
			{
				preInit = 0; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				postInit = 0; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
				recompile = 1; // 1 to recompile the function upon mission start
				ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
			};
		};
		class respawn
		{
			class createRespawnHeli
			{
				preInit = 0; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				postInit = 0; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
				recompile = 1; // 1 to recompile the function upon mission start
				ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
			};
			class createRespawnHeliPlayer
			{
				preInit = 0; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				postInit = 0; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
				recompile = 1; // 1 to recompile the function upon mission start
				ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
			};
			class createRespawnableAiGroup
			{
				preInit = 0; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				postInit = 0; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
				recompile = 1; // 1 to recompile the function upon mission start
				ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
			};
			class onPlayerKilled
			{
				preInit = 0; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				postInit = 0; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
				recompile = 1; // 1 to recompile the function upon mission start
				ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
			};
			class onPlayerRespawn
			{
				preInit = 0; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				postInit = 0; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
				recompile = 1; // 1 to recompile the function upon mission start
				ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
			};
		};
		class support
		{
			class initPlayerSupports
			{
				preInit = 0; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				postInit = 0; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
				recompile = 1; // 1 to recompile the function upon mission start
				ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
			};
			class mortarStrike
			{
				preInit = 0; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				postInit = 0; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
				recompile = 1; // 1 to recompile the function upon mission start
				ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
			};
			class artyStrike
			{
				preInit = 0; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				postInit = 0; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
				recompile = 1; // 1 to recompile the function upon mission start
				ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
			};
			class fixedCas
			{
				preInit = 0; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				postInit = 0; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
				recompile = 1; // 1 to recompile the function upon mission start
				ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
			};
			class qrfRequest
			{
				preInit = 0; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				postInit = 0; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
				recompile = 1; // 1 to recompile the function upon mission start
				ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
			};
			class ugvRequest
			{
				preInit = 0; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				postInit = 0; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
				recompile = 1; // 1 to recompile the function upon mission start
				ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
			};
				class createNonrespawnableAiGroup
			{
				preInit = 0; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				postInit = 0; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
				recompile = 1; // 1 to recompile the function upon mission start
				ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
			};
		};
		class loadout
		{
			class initPlayerLoadout
			{
				preInit = 0; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				postInit = 0; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
				recompile = 1; // 1 to recompile the function upon mission start
				ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
			};
			class changePlayerLoadout
			{
				preInit = 0; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				postInit = 0; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
				recompile = 1; // 1 to recompile the function upon mission start
				ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
			};
		};
		class locality
		{
			class globalVehicleChat
			{
				preInit = 0; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				postInit = 0; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
				recompile = 1; // 1 to recompile the function upon mission start
				ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
			};
			class globalSideChat
			{
				preInit = 0; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				postInit = 0; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
				recompile = 1; // 1 to recompile the function upon mission start
				ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
			};
		};
		class handlers
		{
			class onUnitKilled
			{
				preInit = 0; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				postInit = 0; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
				recompile = 1; // 1 to recompile the function upon mission start
				ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
			};
			class gridMarkers
			{
				preInit = 0; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				postInit = 0; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
				recompile = 1; // 1 to recompile the function upon mission start
				ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
			};
			class gameEndLoop
			{
				preInit = 0; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				postInit = 0; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
				recompile = 1; // 1 to recompile the function upon mission start
				ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
			};
			class rankHandler
			{
				preInit = 0; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				postInit = 0; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
				recompile = 1; // 1 to recompile the function upon mission start
				ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
			};
		};
	};
};
