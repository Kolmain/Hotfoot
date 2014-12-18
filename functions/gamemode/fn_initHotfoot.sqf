if (!isDedicated && (player != headlessClient)) then {
	[] spawn KOL_fnc_initPlayer;
};

if ((isServer && !HC) or (HC && (player == headlessClient))) then {
//if (isServer) then {
	[] spawn KOL_fnc_gameEndLoop;
	_empty = [] spawn {
		if (west_active) then {
			_empty = [west] spawn KOL_fnc_aiSupportHandler;
			for "_i" from 1 to ("b_teams" call BIS_fnc_getParamValue) do
			{
				[west] spawn KOL_fnc_createRespawnableAiGroup;
				sleep 10;
			};
		};
	};
	_empty = [] spawn {
		if (east_active) then {
			_empty = [east] spawn KOL_fnc_aiSupportHandler;
			for "_i" from 1 to ("o_teams" call BIS_fnc_getParamValue) do
			{
				[east] spawn KOL_fnc_createRespawnableAiGroup;
				sleep 10;
			};
		};
	};
	_empty = [] spawn {
		if (indep_active) then {
			_empty = [independent] spawn KOL_fnc_aiSupportHandler;
			for "_i" from 1 to ("i_teams" call BIS_fnc_getParamValue) do
			{
				[independent] spawn KOL_fnc_createRespawnableAiGroup;
				sleep 10;
			};
		};
	};
};

if (("nvgs" call BIS_fnc_getParamValue) == 1) then {
	{
		_x unassignItem "NVGoggles";
		_x removeItem "NVGoggles";
		_x unassignItem "NVGoggles_OPFOR";
		_x removeItem "NVGoggles_OPFOR";
		_x unassignItem "NVGoggles_INDEP";
		_x removeItem "NVGoggles_INDEP";
		if (("weaponFX" call BIS_fnc_getParamValue) == 1) then {
			_x addEventHandler ["Fired", {_this execVM "scripts\L_Twitch.sqf";}];
		};
	} forEach allUnits;
};

{
	if (!(_x isKindOf "Man")) then {
		clearItemCargoGlobal _x;
		clearWeaponCargoGlobal _x;
		clearMagazineCargoGlobal _x;
	};
} forEach allUnits;
