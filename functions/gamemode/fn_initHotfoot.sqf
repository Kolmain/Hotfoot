hotfoot_epilogue = false;
KOL_debug = true;

publicVariable "hotfoot_epilogue";
publicVariable "KOL_debug";

_gear = [west, 'rifleman_west'] call BIS_fnc_addRespawnInventory;
_gear = [west, "grenadier_west"] call BIS_fnc_addRespawnInventory;
_gear = [west, "autorifleman_west"] call BIS_fnc_addRespawnInventory;
_gear = [west, "sniper_west"] call BIS_fnc_addRespawnInventory;
_gear = [west, "specops_west"] call BIS_fnc_addRespawnInventory;

if (isDedicated || !isMultiplayer) then { 
	[east] spawn KOL_fnc_createRespawnHeli;
	[west] spawn KOL_fnc_createRespawnHeli;
	[independent] spawn KOL_fnc_createRespawnHeli;
	sleep 1;
	[west] spawn KOL_fnc_createRespawnableAiGroup;
	[east] spawn KOL_fnc_createRespawnableAiGroup;
	[independent] spawn KOL_fnc_createRespawnableAiGroup;
	[east] spawn KOL_fnc_createRespawnableAiGroup;
	[west] spawn KOL_fnc_createRespawnableAiGroup;
	[independent] spawn KOL_fnc_createRespawnableAiGroup;


	//_empty = [west, respawnVehicle_west] spawn BIS_fnc_addRespawnPosition;
	_empty = [east, respawnVehicle_east] spawn BIS_fnc_addRespawnPosition;
	_empty = [resistance, respawnVehicle_guerrila] spawn BIS_fnc_addRespawnPosition;
};

if (!isDedicated) then { 
	[] spawn KOL_fnc_initPlayer;
};
