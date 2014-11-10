hotfoot_epilogue = false;
hootfoot_intro = true;
KOL_debug = true;
insertionChopper_west = init_obj;
insertionChopper_east = init_obj;
insertionChopper_guerrila = init_obj;

publicVariable "hotfoot_epilogue";
publicVariable "hootfoot_intro";
publicVariable "KOL_debug";

_gear = [west, 'rifleman_west'] call BIS_fnc_addRespawnInventory;
_gear = [west, "grenadier_west"] call BIS_fnc_addRespawnInventory;
_gear = [west, "autorifleman_west"] call BIS_fnc_addRespawnInventory;
_gear = [west, "sniper_west"] call BIS_fnc_addRespawnInventory;
_gear = [west, "specops_west"] call BIS_fnc_addRespawnInventory;

if (!isDedicated) then { 
	[] spawn KOL_fnc_initPlayer;
};


if (isDedicated || !isMultiplayer) then { 
	
	[east] spawn KOL_fnc_createRespawnHeliPlayer;
	[west] spawn KOL_fnc_createRespawnHeliPlayer;
	[independent] spawn KOL_fnc_createRespawnHeliPlayer;
	_empty = [west, respawnVehicle_west] spawn BIS_fnc_addRespawnPosition;
	_empty = [east, respawnVehicle_east] spawn BIS_fnc_addRespawnPosition;
	_empty = [resistance, respawnVehicle_guerrila] spawn BIS_fnc_addRespawnPosition;
	for "_i" from 1 to 5 do
	{
		[west] spawn KOL_fnc_createRespawnableAiGroup;
		[east] spawn KOL_fnc_createRespawnableAiGroup;
		[independent] spawn KOL_fnc_createRespawnableAiGroup;
		sleep 10;
	};
	[east] spawn KOL_fnc_createRespawnHeli;
	[west] spawn KOL_fnc_createRespawnHeli;
	[independent] spawn KOL_fnc_createRespawnHeli;
	
	hootfoot_intro = false;

};

