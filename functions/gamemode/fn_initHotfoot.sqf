

publicVariable "hotfoot_epilogue";
publicVariable "points_west";
publicVariable "points_east";
publicVariable "points_guerrila";
publicVariable "scoreToWin";
publicVariable "hotfoot_intro";
publicVariable "KOL_debug";



if (!isDedicated) then {
	[] spawn KOL_fnc_initPlayer;
};

if (isServer) then {
	[] spawn KOL_fnc_gameEndLoop;
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
};
