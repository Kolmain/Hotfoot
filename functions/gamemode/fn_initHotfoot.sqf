hotfoot_epilogue = false;
hotfoot_intro = true;
KOL_debug = true;
insertionChopper_west = init_obj;
insertionChopper_east = init_obj;
insertionChopper_guerrila = init_obj;
extractionChopper = init_obj;
winningSide = west;
points_west = 0;
points_east = 0;
points_guerrila = 0;
scoreToWin = 250;

publicVariable "hotfoot_epilogue";
publicVariable "points_west";
publicVariable "points_east";
publicVariable "points_guerrila";
publicVariable "scoreToWin";
publicVariable "hotfoot_intro";
publicVariable "KOL_debug";



_gear = [west, 'rifleman_west'] call BIS_fnc_addRespawnInventory;
_gear = [west, "grenadier_west"] call BIS_fnc_addRespawnInventory;
_gear = [west, "autorifleman_west"] call BIS_fnc_addRespawnInventory;
_gear = [west, "sniper_west"] call BIS_fnc_addRespawnInventory;
_gear = [west, "specops_west"] call BIS_fnc_addRespawnInventory;

if (!isDedicated) then { 
	[] spawn KOL_fnc_initPlayer;
};

if (isServer) then {
	[east] spawn KOL_fnc_createRespawnHeliPlayer;
	[west] spawn KOL_fnc_createRespawnHeliPlayer;
	[independent] spawn KOL_fnc_createRespawnHeliPlayer;
	[] spawn KOL_fnc_gameEndLoop;
	_empty = [west, respawnVehicle_west] spawn BIS_fnc_addRespawnPosition;
	_empty = [east, respawnVehicle_east] spawn BIS_fnc_addRespawnPosition;
	_empty = [resistance, respawnVehicle_guerrila] spawn BIS_fnc_addRespawnPosition;
	if (isMultiplayer) then {
		_empty = [] spawn {
			for "_i" from 1 to ("b_teams" call BIS_fnc_getParamValue) do
			{
				[west] spawn KOL_fnc_createRespawnableAiGroup;
				sleep 10;
			};
		};
		_empty = [] spawn {
			for "_i" from 1 to ("o_teams" call BIS_fnc_getParamValue) do
			{
				[east] spawn KOL_fnc_createRespawnableAiGroup;
				sleep 10;
			};
		};
		_empty = [] spawn {
			for "_i" from 1 to ("i_teams" call BIS_fnc_getParamValue) do
			{
				[independent] spawn KOL_fnc_createRespawnableAiGroup;
				sleep 10;
			};
		};
		if (_bteams > 0) then { [west] spawn KOL_fnc_createRespawnHeli; };
		if (_oteams > 0) then { [east] spawn KOL_fnc_createRespawnHeli; };
		if (_iteams > 0) then { [independent] spawn KOL_fnc_createRespawnHeli; };
		sleep 30;
	} else {
		for "_i" from 1 to 4 do
			{
				[west] spawn KOL_fnc_createRespawnableAiGroup;
				[east] spawn KOL_fnc_createRespawnableAiGroup;
				[independent] spawn KOL_fnc_createRespawnableAiGroup;
				sleep 10;
			};
		[west] spawn KOL_fnc_createRespawnHeli; 
		[east] spawn KOL_fnc_createRespawnHeli; 
		[independent] spawn KOL_fnc_createRespawnHeli; 
	};
};

hotfoot_intro = false;
publicVariable "hotfoot_intro";
