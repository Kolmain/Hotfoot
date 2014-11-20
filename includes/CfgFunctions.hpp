class CfgFunctions
{
	class KOL
	{
		class gamemode
		{
			class createAmbientEnviroment
			{
				preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				postInit = 1; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
				recompile = 1; // 1 to recompile the function upon mission start
				ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
			};
			class initPlayer
			{
				preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				postInit = 1; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
				recompile = 1; // 1 to recompile the function upon mission start
				ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
			};
			class initHotfoot
			{
				preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				postInit = 1; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
				recompile = 1; // 1 to recompile the function upon mission start
				ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
			};
			class epilogue
			{
				preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				postInit = 1; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
				recompile = 1; // 1 to recompile the function upon mission start
				ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
			};
		};
		class support
		{
			class initPlayerSupports
			{
				preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				postInit = 1; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
				recompile = 1; // 1 to recompile the function upon mission start
				ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
			};
			class mortarStrike
			{
				preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				postInit = 1; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
				recompile = 1; // 1 to recompile the function upon mission start
				ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
			};
			class artyStrike
			{
				preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				postInit = 1; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
				recompile = 1; // 1 to recompile the function upon mission start
				ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
			};
			class fixedCas
			{
				preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				postInit = 1; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
				recompile = 1; // 1 to recompile the function upon mission start
				ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
			};
			class qrfRequest
			{
				preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				postInit = 1; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
				recompile = 1; // 1 to recompile the function upon mission start
				ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
			};
			class ugvRequest
			{
				preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				postInit = 1; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
				recompile = 1; // 1 to recompile the function upon mission start
				ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
			};
		};
		class loadout
		{
			class initPlayerLoadout
			{
				preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				postInit = 1; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
				recompile = 1; // 1 to recompile the function upon mission start
				ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
			};
			class changePlayerLoadout
			{
				preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				postInit = 1; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
				recompile = 1; // 1 to recompile the function upon mission start
				ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
			};
		};
		class locality
		{
			class globalVehicleChat
			{
				preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				postInit = 1; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
				recompile = 1; // 1 to recompile the function upon mission start
				ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
			};
			class globalSideChat
			{
				preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				postInit = 1; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
				recompile = 1; // 1 to recompile the function upon mission start
				ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
			};
		};
		class handlers
		{
			class onUnitKilled
			{
				preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				postInit = 1; // 1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit"]
				recompile = 1; // 1 to recompile the function upon mission start
				ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
			};
		};
	};
};
